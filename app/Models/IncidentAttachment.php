<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class IncidentAttachment extends Model
{
    protected $fillable = ['incident_id', 'path', 'original_name', 'mime'];

    public function incident()
    {
        return $this->belongsTo(Incident::class);
    }
}
