<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Incident extends Model
{
    protected $fillable = [
        'user_id', 'title', 'description', 'type', 'severity', 'location', 'status', 'meta', 'resolved_by', 'resolved_at'
    ];

    protected $casts = [
        'meta' => 'array',
        'resolved_at' => 'datetime',
    ];

    public function attachments()
    {
        return $this->hasMany(IncidentAttachment::class);
    }

    public function reporter()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function resolver()
    {
        return $this->belongsTo(User::class, 'resolved_by');
    }
}
