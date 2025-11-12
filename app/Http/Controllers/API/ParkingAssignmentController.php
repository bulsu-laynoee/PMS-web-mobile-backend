<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ParkingAssignment;
use App\Models\ParkingSlot;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log; // Use Log facade
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule; // <-- Make sure this is imported
use App\Notifications\ParkingAssignedNotification;
use App\Events\ParkingSlotStatusChanged;
use App\Services\AdminNotifier;
use Illuminate\Validation\ValidationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class ParkingAssignmentController extends Controller
{
    // Get all assignments for a given layout (for frontend search/filter)
    public function byLayout($layoutId)
    {
        $assignments = ParkingAssignment::with(['parkingSlot', 'user'])
            ->whereHas('parkingSlot', function($q) use ($layoutId) {
                $q->where('layout_id', $layoutId);
            })
            ->get();

        return response()->json($assignments);
    }

    // Get active assignment for the authenticated user
    public function active(Request $request)
    {
        try {
            if (!$request->user()) {
                 return response()->json(['message' => 'Unauthenticated.'], 401);
            }
            $userId = $request->user()->id;

            $activeAssignment = ParkingAssignment::where('user_id', $userId)
                ->where('status', 'active')
                ->with(['parkingSlot.layout', 'user'])
                ->first();

            return response()->json([
                'message' => $activeAssignment ? 'Active assignment found' : 'No active assignment found',
                'data' => $activeAssignment
            ]);
        } catch (\Exception $e) {
            Log::error('Error retrieving active assignment: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error retrieving active assignment',
                'error' => config('app.debug') ? $e->getMessage() : 'Server error'
            ], 500);
        }
    }

    // Get all assignments
    public function index()
    {
        return response()->json(
            ParkingAssignment::with(['parkingSlot.layout', 'user'])
                ->orderBy('created_at', 'desc')
                ->get()
        );
    }

    /**
     * Store a newly created resource in storage.
     * POST /api/parking-assignments
     */
    public function store(Request $request)
    {
        Log::info('ParkingAssignment store request received', $request->all());

        // --- Validation: Updated date rules ---
        $validator = Validator::make($request->all(), [
            'parking_slot_id' => 'required|exists:parking_slots,id', // Changed to required
            'user_id' => 'nullable|required_without:guest_name|exists:users,id',
            'guest_name' => 'nullable|required_without:user_id|string|max:255',
            'guest_contact' => 'nullable|string|max:255',
            'vehicle_plate' => [
                'required', // Made vehicle plate required
                'string',
                'max:255',
                Rule::unique('parking_assignments')->where(function ($query) {
                    return $query->whereIn('status', ['active', 'reserved']);
                }),
            ],
            'vehicle_type' => 'required|string|in:car,motorcycle,bicycle', // Made required
            'vehicle_color' => 'required|string|max:255', // Made required
            'start_time' => 'nullable|date', // <-- FIX: Changed from date_format to date
            'end_time' => 'nullable|date|after_or_equal:start_time', // <-- FIX: Changed from date_format to date
            'purpose' => 'nullable|string|max:1000',
            'faculty_position' => 'nullable|string|max:255',
            'assignee_type' => 'required|string|in:guest,faculty,student,employee', // Made required and added options
            'assignment_type' => 'required|string|in:assign,reserve' // Made required
        ]);

        if ($validator->fails()) {
            Log::error('ParkingAssignment validation failed.', $validator->errors()->toArray());
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }
        
        $validatedData = $validator->validated(); // Get validated data
        Log::info('ParkingAssignment validation passed.', $validatedData);

        DB::beginTransaction();
        try {
            $slot = ParkingSlot::with('layout')->findOrFail($validatedData['parking_slot_id']);
            Log::info('Found parking slot.', ['slot_id' => $slot->id, 'layout_id' => $slot->layout_id]);

            // --- ADDED: Logging for layout status check ---
            $layoutIsActive = $slot->layout && $slot->layout->is_active;
            Log::info('Checking layout active status.', [
                'layout_exists' => !!$slot->layout,
                'layout_is_active_property' => $slot->layout ? $slot->layout->is_active : 'N/A (No Layout)',
                'layout_details' => $slot->layout ? ['id' => $slot->layout->id, 'name' => $slot->layout->name, 'is_active' => $slot->layout->is_active] : null
            ]);
            // --- END LOGGING ---

            // CHECK 1: Ensure Layout is Active
            if (!$layoutIsActive) { // Use variable
                 DB::rollBack();
                 Log::warning('REJECTED: Attempted assignment to inactive layout', ['slot_id' => $slot->id, 'layout_id' => $slot->layout_id]);
                 return response()->json(['message' => 'Cannot assign: The selected parking layout (' . ($slot->layout->name ?? 'ID:'.$slot->layout_id) . ') is currently disabled.'], 403);
            }

            // CHECK 2: Slot Availability
            if ($slot->space_status !== 'available') {
                 DB::rollBack();
                 Log::warning('REJECTED: Attempted assignment to unavailable slot', ['slot_id' => $slot->id, 'status' => $slot->space_status]);
                 return response()->json(['message' => 'Cannot assign: Parking slot #' . $slot->space_number . ' is not available (' . $slot->space_status . ').'], 409);
            }

            // CHECK 3: Vehicle Type vs Space Type
             $vehicleType = $validatedData['vehicle_type'];
             if ($slot->space_type === 'compact' && !in_array($vehicleType, ['motorcycle', 'bicycle'])) {
                 DB::rollBack();
                 return response()->json(['message' => "Cannot assign {$vehicleType} to compact space #{$slot->space_number} (Motorcycle/Bicycle only)."], 400);
             }
             if ($slot->space_type === 'standard' && $vehicleType !== 'car') {
                 DB::rollBack();
                 return response()->json(['message' => "Cannot assign {$vehicleType} to standard space #{$slot->space_number} (Car only)."], 400);
             }

            // Determine status and start time
            $status = $validatedData['assignment_type'] === 'reserve' ? 'reserved' : 'active';
            $startTime = ($validatedData['assignment_type'] === 'assign' && empty($validatedData['start_time']))
                            ? now()
                            : $validatedData['start_time'];

            // Create assignment using validated data
            $assignmentData = [
                'parking_slot_id' => $slot->id,
                'user_id' => $validatedData['user_id'] ?? null,
                'guest_name' => $validatedData['guest_name'] ?? null,
                'guest_contact' => $validatedData['guest_contact'] ?? null,
                'vehicle_plate' => $validatedData['vehicle_plate'],
                'vehicle_type' => $vehicleType,
                'vehicle_color' => $validatedData['vehicle_color'],
                'start_time' => $startTime,
                'end_time' => $validatedData['end_time'] ?? null,
                'status' => $status,
                'purpose' => $validatedData['purpose'] ?? null,
                'assignee_type' => $validatedData['assignee_type'],
                'assignment_type' => $validatedData['assignment_type'],
                'faculty_position' => $validatedData['faculty_position'] ?? null
            ];
            Log::info('Creating assignment with data:', $assignmentData);
            $assignment = ParkingAssignment::create($assignmentData);

            // Update slot status
            $slotStatus = $status;
            $slot->update(['space_status' => $slotStatus]);
            Log::info('Updated slot status.', ['slot_id' => $slot->id, 'new_status' => $slotStatus]);

            DB::commit();
            Log::info('Transaction committed.');

            // Notifications and Events
            try {
                if ($assignment->user_id && ($user = User::find($assignment->user_id))) {
                    $user->notify(new ParkingAssignedNotification($assignment->load('parkingSlot.layout', 'user')));
                }
            } catch (\Exception $e) { \Log::warning('Failed assign notification: ' . $e->getMessage()); }
            try { event(new ParkingSlotStatusChanged($assignment->load('parkingSlot.layout', 'user'))); }
            catch (\Exception $e) { \Log::warning('Failed status event: ' . $e->getMessage()); }
            // try { AdminNotifier::notifyAdmins([/*...*/]); }
            // catch (\Exception $e) { \Log::warning('Failed admin notification: '.$e->getMessage()); }

            return response()->json([
                'message' => 'Parking assignment created successfully',
                'assignment' => $assignment->load('parkingSlot.layout', 'user')
            ], 201);

        } catch (ModelNotFoundException $e) { // Catch slot not found
            DB::rollBack();
            Log::warning('Parking slot not found for assignment', ['slot_id' => $request->parking_slot_id ?? 'unknown']);
            return response()->json(['message' => 'Error creating assignment: Parking Slot not found.'], 404);
        } catch (\Exception $e) { // Catch all other exceptions
            DB::rollBack();
            Log::error('Parking assignment creation error', ['exception' => $e, 'request' => $request->except('password')]);
            return response()->json(['message' => 'Error creating parking assignment', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     * PUT /api/parking-assignments/{assignment}
     */
    public function update(Request $request, ParkingAssignment $assignment)
    {
        // --- Validation: Updated date rules ---
        $validatedData = $request->validate([
            'user_id' => 'sometimes|nullable|exists:users,id',
            'guest_name' => 'sometimes|nullable|string|max:255',
            'guest_contact' => 'sometimes|nullable|string|max:255',
            'vehicle_plate' => [
                'sometimes', 'required','string','max:255',
                 Rule::unique('parking_assignments')->where(function ($query) {
                    return $query->whereIn('status', ['active', 'reserved']);
                })->ignore($assignment->id),
             ],
            'vehicle_type' => 'sometimes|required|string|in:car,motorcycle,bicycle',
            'vehicle_color' => 'sometimes|required|string|max:255',
            'start_time' => 'sometimes|nullable|date', // <-- FIX: Changed from date_format to date
            'end_time' => 'sometimes|nullable|date|after_or_equal:start_time', // <-- FIX: Changed from date_format to date
            'purpose' => 'sometimes|nullable|string|max:1000',
            'faculty_position' => 'sometimes|nullable|string|max:255',
        ]);

        DB::beginTransaction();
        try {
             if (isset($validatedData['vehicle_type'])) {
                 $slot = $assignment->parkingSlot;
                 if (!$slot) { throw new \Exception("Slot relationship missing."); }
                 if ($slot->space_type === 'compact' && !in_array($validatedData['vehicle_type'], ['motorcycle', 'bicycle'])) {
                     throw ValidationException::withMessages(['vehicle_type' => "Cannot change to {$validatedData['vehicle_type']} in compact space #{$slot->space_number}."]);
                 }
                 if ($slot->space_type === 'standard' && $validatedData['vehicle_type'] !== 'car') {
                    throw ValidationException::withMessages(['vehicle_type' => "Cannot change to {$validatedData['vehicle_type']} in standard space #{$slot->space_number}."]);
                 }
             }
            $assignment->update($validatedData);
            DB::commit();
            return response()->json(['message' => 'Parking assignment updated successfully', 'assignment' => $assignment->load('parkingSlot.layout', 'user')]);
         } catch (ValidationException $e) {
             DB::rollBack(); return response()->json(['message' => 'Validation failed', 'errors' => $e->errors()], 422);
         } catch (\Exception $e) {
            DB::rollBack(); Log::error('Error updating assignment', ['id' => $assignment->id, 'error' => $e->getMessage()]);
            return response()->json(['message' => 'Error updating parking assignment', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Switch parking slot for an assignment.
     * POST /api/parking-assignments/{assignmentId}/switch
     */
    public function switchParking(Request $request, $assignmentId)
    {
        $validator = Validator::make($request->all(), [
            'new_slot_id' => 'required|exists:parking_slots,id',
            'target_assignment_id' => 'nullable|exists:parking_assignments,id'
        ]);
         if ($validator->fails()) { return response()->json(['message' => 'Validation failed', 'errors' => $validator->errors()], 422); }

        DB::beginTransaction();
        try {
            $sourceAssignment = ParkingAssignment::with('parkingSlot.layout')->findOrFail($assignmentId);
            $sourceSlot = $sourceAssignment->parkingSlot;
            if (!$sourceSlot) throw new \Exception('Source assignment missing slot info.');

            $targetSlot = ParkingSlot::with('layout')->findOrFail($request->new_slot_id);
            $targetAssignment = null;

            // --- ADDED: Logging for layout status check ---
            $targetLayoutIsActive = $targetSlot->layout && $targetSlot->layout->is_active;
            Log::info('Checking target layout active status for switch.', [
                'target_layout_exists' => !!$targetSlot->layout,
                'target_layout_is_active' => $targetLayoutIsActive,
                 'target_layout_details' => $targetSlot->layout ? ['id' => $targetSlot->layout->id, 'name' => $targetSlot->layout->name, 'is_active' => $targetSlot->layout->is_active] : null
            ]);

            // CHECK 1: Ensure TARGET Layout is Active
            if (!$targetLayoutIsActive) {
                 DB::rollBack(); Log::warning('REJECTED: Attempted switch to inactive layout', ['target_slot_id' => $targetSlot->id]);
                 return response()->json(['message' => 'Cannot switch: The target parking layout (' . ($targetSlot->layout->name ?? 'ID:'.$targetSlot->layout_id) . ') is currently disabled.'], 403);
            }

            // CHECK 2: Same Slot
            if ($sourceSlot->id === $targetSlot->id) { DB::rollBack(); return response()->json(['message' => 'Source and target slots are the same.'], 400); }
            // CHECK 3: Source Vehicle -> Target Slot Type
            $sourceVehicleType = $sourceAssignment->vehicle_type;
            if ($targetSlot->space_type === 'compact' && !in_array($sourceVehicleType, ['motorcycle', 'bicycle'])) { DB::rollBack(); return response()->json(['message' => "Cannot move {$sourceVehicleType} to compact space #{$targetSlot->space_number}."], 400); }
            if ($targetSlot->space_type === 'standard' && $sourceVehicleType !== 'car') { DB::rollBack(); return response()->json(['message' => "Cannot move {$sourceVehicleType} to standard space #{$targetSlot->space_number}."], 400); }

            // Handle SWAP
            if (in_array($targetSlot->space_status, ['occupied', 'reserved'])) {
                 $targetAssignment = ParkingAssignment::where('parking_slot_id', $targetSlot->id)->whereIn('status', ['active', 'reserved'])->first();
                 if ($request->filled('target_assignment_id') && (!$targetAssignment || $targetAssignment->id != $request->target_assignment_id)) { DB::rollBack(); return response()->json(['message' => 'Target assignment ID mismatch.'], 409); }
                 if (!$targetAssignment) { DB::rollBack(); Log::error('Inconsistent state: Target occupied/reserved but no assignment found.', ['target_slot_id' => $targetSlot->id]); return response()->json(['message' => 'Target assignment not found.'], 409); }

                 // CHECK 4: Target Vehicle -> Source Slot Type
                 $targetVehicleType = $targetAssignment->vehicle_type;
                 if ($sourceSlot->space_type === 'compact' && !in_array($targetVehicleType, ['motorcycle', 'bicycle'])) { DB::rollBack(); return response()->json(['message' => "Cannot swap: Target vehicle ({$targetVehicleType}) won't fit source compact space #{$sourceSlot->space_number}."], 400); }
                 if ($sourceSlot->space_type === 'standard' && $targetVehicleType !== 'car') { DB::rollBack(); return response()->json(['message' => "Cannot swap: Target vehicle ({$targetVehicleType}) won't fit source standard space #{$sourceSlot->space_number}."], 400); }

                 // Perform swap
                 $targetAssignment->update(['parking_slot_id' => $sourceSlot->id]);
                 $sourceAssignment->update(['parking_slot_id' => $targetSlot->id]);
            }
            // Handle MOVE
            else {
                 if ($targetSlot->space_status !== 'available') { DB::rollBack(); return response()->json(['message' => 'Target slot is not available (' . $targetSlot->space_status . ').'], 409); }
                 $sourceAssignment->update(['parking_slot_id' => $targetSlot->id]);
                 $sourceSlot->update(['space_status' => 'available']);
                 $targetSlot->update(['space_status' => $sourceAssignment->status]);
            }
            DB::commit();

            // Notifications/Events
            try { event(new ParkingSlotStatusChanged($sourceAssignment->fresh('parkingSlot.layout', 'user'))); } catch (\Exception $e) { Log::warning('Switch event fail (source): ' . $e->getMessage()); }
            if ($targetAssignment) { try { event(new ParkingSlotStatusChanged($targetAssignment->fresh('parkingSlot.layout', 'user'))); } catch (\Exception $e) { Log::warning('Switch event fail (target assign): ' . $e->getMessage()); } }
            else { try { event(new ParkingSlotStatusChanged($targetSlot)); } catch (\Exception $e) { Log::warning('Switch event fail (target slot): ' . $e->getMessage()); } }

            $response = ['message' => $targetAssignment ? 'Swapped successfully' : 'Moved successfully', 'source_assignment' => $sourceAssignment->fresh('parkingSlot.layout', 'user')];
            if ($targetAssignment) { $response['target_assignment'] = $targetAssignment->fresh('parkingSlot.layout', 'user'); }
            return response()->json($response);

        } catch (ModelNotFoundException $e) { DB::rollBack(); Log::warning('Switch fail: Not found', ['assignId' => $assignmentId, 'req' => $request->all()]); return response()->json(['message' => 'Assignment or Slot not found.'], 404);
         } catch (\Exception $e) { DB::rollBack(); Log::error('Switch fail: ' . $e->getMessage(), ['assignId' => $assignmentId, 'req' => $request->all(), 'trace' => $e->getTraceAsString()]); return response()->json(['message' => 'Error switching slot', 'error' => $e->getMessage()], 500); }
    }


    /**
     * End an active or reserved assignment.
     * POST /api/parking-assignments/{assignment}/end
     */
    public function endAssignment(ParkingAssignment $assignment)
    {
        if (!in_array($assignment->status, ['active', 'reserved'])) { return response()->json(['message' => 'Assignment already ended.'], 400); }
        DB::beginTransaction();
        try {
            $slot = $assignment->parkingSlot;
            $assignment->update(['status' => 'completed', 'end_time' => now()]);
            if ($slot && $slot->space_status !== 'available') {
                 $otherAssignment = ParkingAssignment::where('parking_slot_id', $slot->id)->whereIn('status', ['active', 'reserved'])->first();
                 if (!$otherAssignment) { $slot->update(['space_status' => 'available']); Log::info('Slot set to available', ['slot_id' => $slot->id]); }
                 else { Log::warning('Ended assignment but another active/reserved exists', ['ended_id' => $assignment->id, 'slot_id' => $slot->id, 'other_id' => $otherAssignment->id]); }
            } else if ($slot) { Log::warning('Ended assignment for already available slot?', ['assign_id' => $assignment->id, 'slot_id' => $slot->id]); }
            DB::commit();
            try { event(new ParkingSlotStatusChanged($assignment->load('parkingSlot.layout', 'user'))); } catch (\Exception $e) { \Log::warning('End status event fail: ' . $e->getMessage()); }
            $this->notifyAdminsAssignmentEnded($assignment);
            return response()->json(['message' => 'Assignment ended successfully', 'assignment' => $assignment->load('parkingSlot.layout', 'user')]);
        } catch (\Exception $e) { DB::rollBack(); Log::error('Error ending assignment', ['id' => $assignment->id, 'error' => $e->getMessage()]); return response()->json(['message' => 'Error ending assignment', 'error' => $e->getMessage()], 500); }
    }

    // --- notifyAdminsAssignmentEnded helper (Unchanged) ---
    protected function notifyAdminsAssignmentEnded(ParkingAssignment $assignment)
    {
        try {
            if (class_exists(AdminNotifier::class)) {
                AdminNotifier::notifyAdmins([
                    'type' => 'parking_assignment_ended',
                    'message' => 'A parking assignment has ended',
                    'assignment_id' => $assignment->id,
                    'parking_slot_id' => $assignment->parking_slot_id,
                    'user_id' => $assignment->user_id,
                    'ended_at' => now()->toDateTimeString(),
                ]);
            } else {
                 Log::warning('AdminNotifier service class not found.');
            }
        } catch (\Exception $e) {
            \Log::warning('Failed to notify admins about ended assignment: '.$e->getMessage());
        }
    }


    /**
     * End an active assignment by vehicle plate or user id.
     * POST /api/parking-assignments/end-by-vehicle
     */
    public function endByVehicle(Request $request)
    {
        $validatedData = $request->validate([
            'user_id' => 'nullable|required_without_all:vehicle_plate,parking_slot_id|exists:users,id',
            'vehicle_plate' => 'nullable|required_without_all:user_id,parking_slot_id|string',
            'parking_slot_id' => 'nullable|required_without_all:user_id,vehicle_plate|exists:parking_slots,id',
        ]);
        try {
            $query = ParkingAssignment::whereIn('status', ['active', 'reserved']);
            if (!empty($validatedData['parking_slot_id'])) { $query->where('parking_slot_id', $validatedData['parking_slot_id']); }
            elseif (!empty($validatedData['vehicle_plate'])) { $query->where('vehicle_plate', $validatedData['vehicle_plate']); }
            elseif (!empty($validatedData['user_id'])) { $query->where('user_id', $validatedData['user_id']); }
            $assignment = $query->first();
            if (!$assignment) { return response()->json(['message' => 'Active/reserved assignment not found.'], 404); }
            return $this->endAssignment($assignment);
        } catch (ValidationException $e) { return response()->json(['message' => 'Validation failed', 'errors' => $e->errors()], 422);
         } catch (\Exception $e) { Log::error('End by vehicle/user/slot error', ['req' => $request->all(), 'error' => $e->getMessage()]); return response()->json(['message' => 'Error ending assignment', 'error' => $e->getMessage()], 500); }
    }
}