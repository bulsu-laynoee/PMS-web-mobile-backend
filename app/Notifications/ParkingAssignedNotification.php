<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\DatabaseMessage;

class ParkingAssignedNotification extends Notification
{
    use Queueable;

    protected $assignment;

    public function __construct($assignment)
    {
        $this->assignment = $assignment;
    }

    public function via($notifiable)
    {
        // store in DB and broadcast (if broadcasting configured)
        return ['database', 'broadcast'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'type' => 'parking_assigned',
            'message' => 'A parking slot has been assigned to you',
            'assignment_id' => $this->assignment->id ?? null,
            'parking_slot_id' => $this->assignment->parking_slot_id ?? null,
            'parking_layout_id' => optional($this->assignment->parkingSlot)->layout_id ?? null,
            'created_at' => now()->toDateTimeString(),
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage($this->toDatabase($notifiable));
    }
}
