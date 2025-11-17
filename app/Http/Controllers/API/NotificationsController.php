<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
                // Primary source: notifications explicitly addressed to this user
                $notes = $user->notifications()->orderBy('created_at', 'desc')->limit(100)->get()->toArray();

                // Also include notifications that mention this user inside the JSON payload
                // (e.g. incident_reported where data.reported_user_id == $user->id)
                // Use a loose LIKE search on the JSON to support a variety of DB engines.
                $likePattern1 = '%"reported_user_id":' . $user->id . '%';
                $likePattern2 = '%"reported_user_id":"' . $user->id . '"%';

                $mentions = DB::table('notifications')
                    ->where(function ($q) use ($user, $likePattern1, $likePattern2) {
                        $q->where('data', 'like', $likePattern1)
                          ->orWhere('data', 'like', $likePattern2);
                    })
                    ->orderBy('created_at', 'desc')
                    ->limit(100)
                    ->get()
                    ->toArray();

                // Merge unique by id (notes may already contain some of these)
                $all = [];
                $seen = [];
                foreach (array_merge($notes, $mentions) as $n) {
                    $id = is_object($n) ? ($n->id ?? null) : ($n['id'] ?? null);
                    if ($id && !isset($seen[$id])) {
                        $seen[$id] = true;
                        $all[] = $n;
                    }
                }

                return response()->json(['data' => array_values($all)]);
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
                // Try the normal polymorphic path first (notification addressed to this user)
                $note = $user->notifications()->where('id', $id)->first();
                if ($note) {
                    $note->markAsRead();
                    return response()->json(['message' => 'Marked read']);
                }

                // If not found, the notification may still mention this user in the payload
                // (e.g. incident_reported where data.reported_user_id == $user->id). Update the
                // notifications table row directly in that case.
                $updated = DB::table('notifications')
                    ->where('id', $id)
                    ->where(function ($q) use ($user) {
                        $q->where('notifiable_id', $user->id)
                          ->orWhere('user_id', $user->id)
                          ->orWhere('data', 'like', '%"reported_user_id":' . $user->id . '%')
                          ->orWhere('data', 'like', '%"reported_user_id":"' . $user->id . '"%');
                    })
                    ->update(['read_at' => now(), 'updated_at' => now()]);

                if ($updated) return response()->json(['message' => 'Marked read']);

                return response()->json(['message' => 'Not found'], 404);
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
