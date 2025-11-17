<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController as BaseController;
use App\Models\Incident;
use App\Models\IncidentAttachment;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Notification;
use App\Notifications\IncidentReportedNotification;

class IncidentsController extends BaseController
{
    public function index(Request $request)
    {
        $user = $request->user();
        if ($user && $user->role && $user->role->name === 'Admin') {
            $incidents = Incident::with(['attachments','reporter','reportedUser'])->orderBy('created_at','desc')->get();
        } else {
            $incidents = Incident::with(['attachments','reporter','reportedUser'])->where('user_id', $user->id)->orderBy('created_at','desc')->get();
        }
        return $this->sendResponse($incidents, 'Incidents retrieved');
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'type' => 'nullable|string',
            'severity' => 'nullable|string|in:low,medium,high',
            'location' => 'nullable|string',
            'attachments.*' => 'sometimes|file|mimes:jpg,jpeg,png,pdf|max:5120',
            'reported_user_id' => 'nullable|exists:users,id',
            'reported_plate' => 'nullable|string|max:64',
        ]);

        $user = $request->user();
        $meta = null;
        if ($request->filled('reported_plate')) {
            $meta = array_merge($meta ?? [], ['reported_plate' => $request->reported_plate]);
        }

        $incident = Incident::create([
            'user_id' => $user ? $user->id : null,
            'title' => $request->title,
            'description' => $request->description,
            'type' => $request->type,
            'severity' => $request->severity ?? 'low',
            'location' => $request->location,
            'meta' => $meta,
            'reported_user_id' => $request->reported_user_id ?? null,
        ]);

        // handle attachments
        if ($request->hasFile('attachments')) {
            foreach ($request->file('attachments') as $file) {
                $ext = $file->getClientOriginalExtension();
                $fn = 'inc_' . Str::random(8) . '.' . $ext;
                $path = $file->storeAs('incidents', $fn, 'public');
                $incident->attachments()->create([
                    'path' => $path,
                    'original_name' => $file->getClientOriginalName(),
                    'mime' => $file->getClientMimeType(),
                ]);
            }
        }

        // Notify reported user if present
        if ($incident->reported_user_id) {
            try {
                $reportedUser = \App\Models\User::find($incident->reported_user_id);
                if ($reportedUser) {
                    Notification::send($reportedUser, new IncidentReportedNotification($incident->load('reporter')));
                }
            } catch (\Exception $e) {
                // don't block creation on notification failure
                logger('Failed to notify reported user for incident '.$incident->id.': '.$e->getMessage());
            }
        }

        return $this->sendResponse($incident->load('attachments','reporter','resolver','reportedUser'), 'Incident created');
    }

    public function show(Incident $incident, Request $request)
    {
        $user = $request->user();
        if ($user->role && $user->role->name === 'Admin') {
            return $this->sendResponse($incident->load('attachments','reporter','resolver','reportedUser'), 'Incident retrieved');
        }
        if ($incident->user_id !== $user->id) {
            return $this->sendError('Forbidden', [], 403);
        }
        return $this->sendResponse($incident->load('attachments','resolver','reportedUser'), 'Incident retrieved');
    }

    public function update(Incident $incident, Request $request)
    {
        $user = $request->user();
        if (!($user->role && $user->role->name === 'Admin')) {
            return $this->sendError('Forbidden', [], 403);
        }

        $this->validate($request, [
            'status' => 'nullable|string|in:open,acknowledged,closed',
            'resolved_by' => 'nullable|exists:users,id',
            'resolved_at' => 'nullable|date',
        ]);

        if ($request->filled('status')) $incident->status = $request->status;
        if ($request->filled('resolved_by')) $incident->resolved_by = $request->resolved_by;
        if ($request->filled('resolved_at')) $incident->resolved_at = $request->resolved_at;
        $incident->save();

        return $this->sendResponse($incident->load('attachments','reporter','resolver','reportedUser'), 'Incident updated');
    }
}
