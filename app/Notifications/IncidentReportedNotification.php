<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\BroadcastMessage;

class IncidentReportedNotification extends Notification
{
    use Queueable;

    protected $incident;

    public function __construct($incident)
    {
        $this->incident = $incident;
    }

    public function via($notifiable)
    {
        return ['database', 'broadcast'];
    }

    public function toDatabase($notifiable)
    {
        // include reporter summary if available
        $reporter = null;
        if ($this->incident->reporter) {
            $reporter = [
                'id' => $this->incident->reporter->id ?? null,
                'username' => $this->incident->reporter->username ?? ($this->incident->reporter->name ?? null),
                'name' => $this->incident->reporter->name ?? null,
            ];
        }

        return [
            'type' => 'incident_reported',
            'message' => 'An incident has been reported involving you',
            'incident_id' => $this->incident->id ?? null,
            'reported_user_id' => $this->incident->reported_user_id ?? null,
            'reported_plate' => $this->incident->reported_plate ?? ($this->incident->meta['reported_plate'] ?? null),
            // include basic incident metadata so clients can display the incident type/title/severity without an extra fetch
            'incident_type' => $this->incident->type ?? null,
            'incident_title' => $this->incident->title ?? null,
            'severity' => $this->incident->severity ?? null,
            'report_count' => $this->incident->report_count ?? null,
            'reporter' => $reporter,
            'created_at' => now()->toDateTimeString(),
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage($this->toDatabase($notifiable));
    }
}
