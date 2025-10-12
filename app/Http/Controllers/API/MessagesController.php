<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Message;
use Illuminate\Support\Facades\Auth;

class MessagesController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->validate([
            'recipient_phone' => 'required|string',
            'body' => 'nullable|string',
            'sent_via' => 'nullable|string',
        ]);

        $data['user_id'] = Auth::id();

        $msg = Message::create($data);

        return response()->json(['success' => true, 'data' => $msg], 201);
    }
}
