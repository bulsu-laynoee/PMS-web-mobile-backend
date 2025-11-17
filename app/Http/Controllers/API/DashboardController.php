<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Exception;

class DashboardController extends Controller
{
    public function getDashboardStats()
    {
        try {
            $totalParkingSpaces = DB::table('parking_layouts')->count();

            // Count distinct active users but exclude users with roles_id 6 and 7
            $activeUsers = DB::table('user_details')
                ->join('users', 'user_details.user_id', '=', 'users.id')
                ->whereNotIn('users.roles_id', [6, 7])
                ->distinct()
                ->count('user_id');

            $currentlyParked = DB::table('parking_assignments')
                ->whereIn('status', ["active", "reserved"])
                ->count();

            return response()->json([
                'total_parking_spaces' => (int) $totalParkingSpaces,
                'active_users' => (int) $activeUsers,
                'currently_parked' => (int) $currentlyParked,
            ]);
        } catch (Exception $ex) {
            logger()->error('DashboardController@getDashboardStats error: ' . $ex->getMessage(), ['exception' => $ex]);
            $message = config('app.debug') ? $ex->getMessage() : 'Failed to load dashboard stats. Check server logs.';
            return response()->json(['message' => $message], 500);
        }
    }
}
