<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function getDashboardStats()
{
    $totalParkingSpaces = \DB::table('parking_layouts')->count();
        // Count distinct active users but exclude users with roles_id 6 and 7
        // Note: the users table uses `roles_id` (plural) in this DB schema
        $activeUsers = DB::table('user_details')
            ->join('users', 'user_details.user_id', '=', 'users.id')
            ->whereNotIn('users.roles_id', [6, 7])
            ->distinct()
            ->count('user_id');
    $currentlyParked = DB::table('parking_assignments')
        ->whereIn('status', ["active", "reserved"])
        ->count();

    return response()->json([
        'total_parking_spaces' => $totalParkingSpaces,
        'active_users' => $activeUsers,
        'currently_parked' => $currentlyParked,
    ]);
 }
}
