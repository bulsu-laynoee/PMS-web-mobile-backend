<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

class AnalyticsController extends Controller
{
    /**
     * Get parking assignment statistics for various time windows.
     */
    public function getParkingAssignmentStats(Request $request)
    {
        try {
            $now = Carbon::now();

            // Define bindings once for all queries (use strings to avoid driver binding issues)
            $bindings = [
                $now->copy()->subHour(),
                $now->copy()->subHours(6),
                $now->copy()->subDay(),
                $now->copy()->subDays(3),
                $now->copy()->subDays(7),
                $now->copy()->subDays(30),
            ];
            $bindingStrings = array_map(function ($dt) {
                return $dt instanceof Carbon ? $dt->toDateTimeString() : (string) $dt;
            }, $bindings);

            // 1. Get Total Stats
            $stats = DB::table('parking_assignments')
                ->select(
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_hour'),
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_6_hours'),
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_24_hours'),
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_3_days'),
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_7_days'),
                    DB::raw('COUNT(CASE WHEN created_at >= ? THEN 1 END) as last_30_days')
                )
                ->setBindings($bindingStrings)
                ->first();

            // 2. Get Per-Layout Stats
            $layoutStats = DB::table('parking_assignments')
                ->join('parking_slots', 'parking_assignments.parking_slot_id', '=', 'parking_slots.id')
                ->join('parking_layouts', 'parking_slots.layout_id', '=', 'parking_layouts.id')
                ->select(
                    'parking_layouts.name as layout_name',
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_hour'),
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_6_hours'),
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_24_hours'),
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_3_days'),
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_7_days'),
                    DB::raw('COUNT(CASE WHEN parking_assignments.created_at >= ? THEN 1 END) as last_30_days')
                )
                ->setBindings($bindingStrings)
                ->groupBy('parking_layouts.name')
                ->orderBy('last_30_days', 'desc')
                ->get();

            if (!$stats) {
                // If the query returned null, return empty structure instead of erroring later
                $totalStats = [
                    'last_hour' => 0,
                    'last_6_hours' => 0,
                    'last_24_hours' => 0,
                    'last_3_days' => 0,
                    'last_7_days' => 0,
                    'last_30_days' => 0,
                ];
            } else {
                // Cast totals to int
                $totalStats = [
                    'last_hour' => (int) ($stats->last_hour ?? 0),
                    'last_6_hours' => (int) ($stats->last_6_hours ?? 0),
                    'last_24_hours' => (int) ($stats->last_24_hours ?? 0),
                    'last_3_days' => (int) ($stats->last_3_days ?? 0),
                    'last_7_days' => (int) ($stats->last_7_days ?? 0),
                    'last_30_days' => (int) ($stats->last_30_days ?? 0),
                ];
            }

            // Cast layout stats to int if present
            if ($layoutStats && method_exists($layoutStats, 'transform')) {
                $layoutStats->transform(function ($item) {
                    $item->last_hour = (int) ($item->last_hour ?? 0);
                    $item->last_6_hours = (int) ($item->last_6_hours ?? 0);
                    $item->last_24_hours = (int) ($item->last_24_hours ?? 0);
                    $item->last_3_days = (int) ($item->last_3_days ?? 0);
                    $item->last_7_days = (int) ($item->last_7_days ?? 0);
                    $item->last_30_days = (int) ($item->last_30_days ?? 0);
                    return $item;
                });
            }

            // 3. Return combined JSON response
            return response()->json([
                'totals' => $totalStats,
                'by_layout' => $layoutStats
            ]);
        } catch (Exception $ex) {
            // Log and return helpful error for debugging (do not expose stack in production)
            logger()->error('AnalyticsController@getParkingAssignmentStats error: ' . $ex->getMessage(), [
                'exception' => $ex
            ]);

            $message = config('app.debug') ? $ex->getMessage() : 'Failed to compute analytics. Check server logs.';
            return response()->json(['message' => $message], 500);
        }
    }

    /**
     * Get a list of drivers and how many times they have been reported.
     */
    public function getDriverReportStats(Request $request)
    {
        try {
            // We query the 'incidents' table, filtering for records
            // where a user was explicitly reported.
            $reports = DB::table('incidents')
                ->join('users', 'incidents.reported_user_id', '=', 'users.id')
                // Join the roles table to get the role name
                ->join('roles', 'users.roles_id', '=', 'roles.id') 
                ->select(
                    'incidents.reported_user_id', 
                    'users.name', 
                    'roles.name as position', // Select the role name as 'position'
                    DB::raw('COUNT(incidents.id) as report_count')
                )
                ->whereNotNull('incidents.reported_user_id')
                ->groupBy('incidents.reported_user_id', 'users.name', 'roles.name') // Add role name to GROUP BY
                ->orderBy('report_count', 'desc')
                ->get();

            return response()->json($reports);
        } catch (Exception $ex) {
            logger()->error('AnalyticsController@getDriverReportStats error: ' . $ex->getMessage(), ['exception' => $ex]);
            $message = config('app.debug') ? $ex->getMessage() : 'Failed to compute driver reports.';
            return response()->json(['message' => $message], 500);
        }
    }
}