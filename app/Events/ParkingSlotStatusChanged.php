<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class ParkingSlotStatusChanged implements ShouldBroadcast
{
	use Dispatchable, InteractsWithSockets, SerializesModels;

	public $assignment;

	public function __construct($assignment)
	{
		$this->assignment = $assignment;
	}

	public function broadcastOn()
	{
		// broadcast on a public channel; listeners can filter client-side
		return new Channel('parking-slot-status');
	}

	public function broadcastWith()
	{
		return [
			'assignment' => $this->assignment,
		];
	}
}
