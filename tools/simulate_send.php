<?php
// One-off script to simulate sending a message from user 25 to user 23
require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;
use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Support\Facades\Auth;

$senderId = 25;
$recipientId = 23;
$body = 'Simulated message from 25 to 23 at ' . date('Y-m-d H:i:s');

$sender = User::find($senderId);
if (! $sender) {
    echo "Sender not found: $senderId\n";
    exit(1);
}

// Log in as sender
Auth::login($sender);

// Try to find existing conversation with exactly these two participants
$userIds = [$senderId, $recipientId];
$candidates = Conversation::whereHas('users', function($q) use ($userIds) {
    $q->whereIn('users.id', $userIds);
})->with('users')->get();

$conv = null;
foreach ($candidates as $c) {
    $ids = $c->users->pluck('id')->sort()->values()->toArray();
    $expected = collect($userIds)->sort()->values()->toArray();
    if ($ids === $expected) {
        $conv = $c;
        break;
    }
}

if (! $conv) {
    $conv = Conversation::create(['title' => null]);
    $conv->users()->attach($userIds);
    $conv->load('users');
    echo "Created conversation {$conv->id}\n";
} else {
    echo "Using existing conversation {$conv->id}\n";
}

// Create message
$msg = Message::create([
    'conversation_id' => $conv->id,
    'sender_id' => $senderId,
    'recipient_id' => $recipientId,
    'recipient_phone' => optional(User::find($recipientId)->userDetail)->contact_number ?? (User::find($recipientId)->contact_number ?? null),
    'body' => $body,
    'sent_via' => 'in-app'
]);

$conv->last_message_at = now();
$conv->save();

event(new \App\Events\MessageSent($msg));

echo "Message created: " . json_encode($msg->toArray()) . "\n";

// Show conversation_user rows for this conv
$rows = \Illuminate\Support\Facades\DB::table('conversation_user')->where('conversation_id', $conv->id)->get();
echo "Participants: " . json_encode($rows) . "\n";

// Show last 3 messages
$last = Message::where('conversation_id', $conv->id)->orderBy('id', 'desc')->take(3)->get();
echo "Recent messages: " . json_encode($last->toArray()) . "\n";

return 0;
