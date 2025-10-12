<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Support\Facades\Auth;

class ConversationsController extends Controller
{
    // List conversations for current user
    public function index(Request $request)
    {
        $user = Auth::user();
        $query = Conversation::whereHas('users', function($q) use ($user) { $q->where('user_id', $user->id); });

        if ($q = $request->get('q')) {
            $query->where('title', 'like', "%{$q}%");
        }

        $perPage = intval($request->get('per_page', 20));
        $convs = $query->with('users')->withCount('messages')->orderBy('last_message_at', 'desc')->paginate($perPage);

        // Add current user context to each conversation
        $currentUserId = $user->id;
        $convs->getCollection()->transform(function ($conv) use ($currentUserId) {
            $conv->current_user_id = $currentUserId;
            return $conv;
        });

        return response()->json(['success' => true, 'data' => $convs]);
    }

    // Create conversation (users array of ids)
    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'nullable|string',
            'user_ids' => 'nullable|array',
            'user_id' => 'nullable|integer',
            'recipient_phone' => 'nullable|string'
        ]);

        // require either user_ids (or single user_id) or recipient_phone
        if (empty($data['user_ids']) && empty($data['user_id']) && empty($data['recipient_phone'])) {
            return response()->json(['success' => false, 'message' => 'user_ids or recipient_phone required'], 422);
        }

        // ensure the creator is included
        $userIds = [$request->user()->id];

        // support singular user_id for convenience
        if (!empty($data['user_id'])) {
            $data['user_ids'] = array_merge($data['user_ids'] ?? [], [$data['user_id']]);
        }

        if (!empty($data['user_ids']) && is_array($data['user_ids'])) {
            // normalize numeric strings to ints and dedupe
            $normalized = array_map(function($v) { return is_numeric($v) ? (int)$v : $v; }, $data['user_ids']);
            $userIds = array_values(array_unique(array_merge($userIds, $normalized)));
        }

        // If this is a 2-user conversation (creator + one other), try to find an existing conversation
        $existingConv = null;
        if (count($userIds) === 2) {
            // find conversations for the current user that have exactly these two participants
            // Use users.id when querying the related users table
            $candidate = \App\Models\Conversation::whereHas('users', function($q) use ($userIds){ $q->whereIn('users.id', $userIds); })
                ->withCount('users')
                ->get()
                ->first(function($c) use ($userIds) {
                    $ids = $c->users->pluck('id')->sort()->values()->toArray();
                    $expected = collect($userIds)->sort()->values()->toArray();
                    return $ids === $expected;
                });

            if ($candidate) {
                // ensure users relation loaded
                $candidate->load('users');
                return response()->json(['success' => true, 'data' => $candidate], 200);
            }
        }

        $conv = Conversation::create(['title' => $data['title'] ?? null]);

        // if recipient_phone is provided, try to resolve to a user by contact_number or in user_details
        if (!empty($data['recipient_phone'])) {
            // normalize to digits only for flexible matching
            $raw = $data['recipient_phone'];
            $digits = preg_replace('/\D+/', '', $raw);
            $last10 = strlen($digits) > 10 ? substr($digits, -10) : $digits;

            // First try exact match against user_details.contact_number (after stripping non-digits)
            $ud = \App\Models\UserDetails::whereRaw("REPLACE(REPLACE(REPLACE(REPLACE(contact_number, ' ', ''), '-', ''), '(', ''), ')', '') = ?", [$digits])->first();
            if ($ud && $ud->user_id) {
                $userIds[] = $ud->user_id;
                \Log::info('ConversationsController: resolved recipient_phone to user_id via user_details', ['phone' => $raw, 'user_id' => $ud->user_id]);
            } else {
                // fallback: try matching by last 10 digits in user_details
                $ud2 = \App\Models\UserDetails::where('contact_number', 'like', "%{$last10}")->first();
                if ($ud2 && $ud2->user_id) {
                    $userIds[] = $ud2->user_id;
                    \Log::info('ConversationsController: resolved recipient_phone to user_id via user_details LIKE', ['phone' => $raw, 'user_id' => $ud2->user_id]);
                } else {
                    // fallback: try users table (older schema) — try exact and last10 match
                    try {
                        $found = \App\Models\User::whereRaw("REPLACE(REPLACE(REPLACE(REPLACE(contact_number, ' ', ''), '-', ''), '(', ''), ')', '') = ?", [$digits])->first();
                        if ($found) {
                            $userIds[] = $found->id;
                            \Log::info('ConversationsController: resolved recipient_phone to user_id via users exact', ['phone' => $raw, 'user_id' => $found->id]);
                        } else {
                            $found2 = \App\Models\User::where('contact_number', 'like', "%{$last10}")->first();
                            if ($found2) {
                                $userIds[] = $found2->id;
                                \Log::info('ConversationsController: resolved recipient_phone to user_id via users LIKE', ['phone' => $raw, 'user_id' => $found2->id]);
                            } else {
                                \Log::info('ConversationsController: could not resolve recipient_phone to a user', ['phone' => $raw]);
                            }
                        }
                    } catch (\Exception $ex) {
                        // ignore if column doesn't exist or other DB errors
                        \Log::warning('ConversationsController: exception during user lookup by phone', ['err' => $ex->getMessage()]);
                    }
                }
            }
        }

    $conv->users()->attach(array_values(array_unique($userIds)));

    // load users relation for the client so it knows the participants immediately
    $conv->load('users');

    return response()->json(['success' => true, 'data' => $conv], 201);
    }

    // Get conversation messages
    public function show($id)
    {
        // load conversation including participants so clients can know who the other user is
        $conv = Conversation::with('users')->findOrFail($id);

        // ensure current user is a participant
        $userId = Auth::id();
        if (!$conv->users()->where('user_id', $userId)->exists()) {
            return response()->json(['success' => false, 'message' => 'Forbidden'], 403);
        }

        $perPage = intval(request()->get('per_page', 50));
        $page = intval(request()->get('page', 1));

        $messages = $conv->messages()->with('sender')->paginate($perPage, ['*'], 'page', $page);

        // Add current user context
        $conv->current_user_id = $userId;

        return response()->json(['success' => true, 'data' => ['conversation' => $conv, 'messages' => $messages]]);
    }

    // Append message to conversation
    public function message(Request $request, $id)
    {
        $conv = Conversation::findOrFail($id);
        $data = $request->validate([
            'body' => 'required|string',
            'recipient_id' => 'nullable|integer',
            'recipient_phone' => 'nullable|string'
        ]);

    // Debug: log incoming recipient info
    try { \Log::info('ConversationsController.message incoming', ['conversation' => $conv->id, 'payload' => $data, 'auth_id' => Auth::id()]); } catch (\Exception $e) {}

    // If recipient_id wasn't provided, infer it from the conversation participants
        $recipientId = $data['recipient_id'] ?? null;
        $recipientPhone = $data['recipient_phone'] ?? null;

        // If client explicitly provided a recipient_id but that user isn't yet attached to the conversation,
        // attach them so the conversation participants include the selected contact and saved messages can record recipient_id.
        if (!empty($recipientId)) {
            try {
                $exists = $conv->users()->where('user_id', $recipientId)->exists();
                if (!$exists) {
                    // ensure the user exists
                    $u = \App\Models\User::find($recipientId);
                    if ($u) {
                        $conv->users()->attach($recipientId);
                        \Log::info('ConversationsController: attached recipient to conversation', ['conversation_id' => $conv->id, 'recipient_id' => $recipientId]);
                    }
                }
            } catch (\Exception $ex) {
                \Log::warning('ConversationsController: failed to attach recipient', ['err' => $ex->getMessage()]);
            }
        }

        if (empty($recipientId)) {
            // pick the other participant (first one that's not the sender)
            try {
                // query the related users by their primary key 'id' to find the other participant
                $other = $conv->users()->where('id', '!=', Auth::id())->first();
                // $other is a User model; use ->id (not user_id)
                if ($other && isset($other->id)) {
                    $recipientId = $other->id;
                }
            } catch (\Exception $ex) {
                // ignore — leave recipientId null for group or edge-cases
            }
        }

        // If recipient_phone wasn't provided, and we have a recipient user, try to resolve a phone
        if (empty($recipientPhone) && !empty($recipientId)) {
            try {
                $ru = \App\Models\User::find($recipientId);
                if ($ru) {
                    // prefer userDetail.contact_number then user.contact_number; guard if userDetail is null
                    $recipientPhone = optional($ru->userDetail)->contact_number ?? $ru->contact_number ?? null;
                }
            } catch (\Exception $ex) {
                // swallow any lookup errors
            }
        }

        $msg = Message::create([
            'conversation_id' => $conv->id,
            'sender_id' => Auth::id(),
            'recipient_id' => $recipientId,
            'recipient_phone' => $recipientPhone,
            'body' => $data['body'],
            'sent_via' => 'in-app',
        ]);

        $conv->last_message_at = now();
        $conv->save();

        // Broadcast event for real-time updates
        event(new \App\Events\MessageSent($msg));

        return response()->json(['success' => true, 'data' => $msg], 201);
    }
}
