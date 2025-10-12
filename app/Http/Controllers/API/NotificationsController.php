<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class NotificationsController extends Controller
{
    // Return recent notifications for the authenticated user
    public function index(Request $request)
    {
        $user = $request->user();
        if (!$user) return response()->json([], 200);

        // Some deployments use a legacy notifications table with a user_id column instead
        // of Laravel's polymorphic notifications table. Detect which shape we have and
        // return the appropriate rows for the authenticated user.
        try {
            if (\Illuminate\Support\Facades\Schema::hasColumn('notifications', 'notifiable_type')) {
                $notes = $user->notifications()->orderBy('created_at', 'desc')->limit(100)->get();
                return response()->json(['data' => $notes]);
            }
        } catch (\Exception $e) {
            // fall through to legacy path
        }

        // Legacy table: notifications(user_id, type, message, link, read...)
        $notes = \Illuminate\Support\Facades\DB::table('notifications')
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->limit(100)
            ->get();

        return response()->json(['data' => $notes]);
    }

    // Mark a notification as read
    public function markRead(Request $request, $id)
    {
        $user = $request->user();
        if (!$user) return response()->json(['message' => 'Unauthorized'], 401);

        try {
            if (\Illuminate\Support\Facades\Schema::hasColumn('notifications', 'notifiable_type')) {
                $note = $user->notifications()->where('id', $id)->first();
                if (!$note) return response()->json(['message' => 'Not found'], 404);
                $note->markAsRead();
                return response()->json(['message' => 'Marked read']);
            }
        } catch (\Exception $e) {
            // fall through to legacy path
        }

        // Legacy table path: update `read` tinyint column to 1
        $updated = \Illuminate\Support\Facades\DB::table('notifications')
            ->where('id', $id)
            ->where('user_id', $user->id)
            ->update(['read' => 1, 'updated_at' => now()]);

        if ($updated) return response()->json(['message' => 'Marked read']);
        return response()->json(['message' => 'Not found'], 404);
    }
}
