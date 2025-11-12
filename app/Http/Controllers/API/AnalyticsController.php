<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class AnalyticsController extends Controller
{
    /**
     * Get parking assignment statistics for various time windows.
     */
    public function getParkingAssignmentStats(Request $request)
    {
        $now = Carbon::now();

        // Define bindings once for all queries
        $bindings = [
            $now->copy()->subHour(),
            $now->copy()->subHours(6),
            $now->copy()->subDay(),
            $now->copy()->subDays(3),
            $now->copy()->subDays(7),
            $now->copy()->subDays(30),
        ];

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
            ->setBindings($bindings)
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
            ->setBindings($bindings) // Use the same bindings for the time windows
            ->groupBy('parking_layouts.name')
            ->orderBy('last_30_days', 'desc')
            ->get();
            
        // Cast totals to int
        $totalStats = [
            'last_hour' => (int) $stats->last_hour,
            'last_6_hours' => (int) $stats->last_6_hours,
            'last_24_hours' => (int) $stats->last_24_hours,
            'last_3_days' => (int) $stats->last_3_days,
            'last_7_days' => (int) $stats->last_7_days,
            'last_30_days' => (int) $stats->last_30_days,
        ];
        
        // Cast layout stats to int
        $layoutStats->transform(function ($item) {
            $item->last_hour = (int) $item->last_hour;
            $item->last_6_hours = (int) $item->last_6_hours;
            $item->last_24_hours = (int) $item->last_24_hours;
            $item->last_3_days = (int) $item->last_3_days;
            $item->last_7_days = (int) $item->last_7_days;
            $item->last_30_days = (int) $item->last_30_days;
            return $item;
        });

        // 3. Return combined JSON response
        return response()->json([
            'totals' => $totalStats,
            'by_layout' => $layoutStats
        ]);
    }

    /**
     * Get a list of drivers and how many times they have been reported.
     */
    public function getDriverReportStats(Request $request)
    {
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
    }
}