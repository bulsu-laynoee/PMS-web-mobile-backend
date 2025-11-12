<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ParkingLayout;
use App\Models\ParkingSlot; // Import ParkingSlot if needed for slot logic
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Schema; // <-- Added this import

class ParkingLayoutController extends Controller
{
    /**
     * Helper function for database error messages.
     *
     * @param \Illuminate\Database\QueryException $e
     * @return string
     */
    protected function getDatabaseErrorMessage(\Illuminate\Database\QueryException $e): string
    {
         $code = $e->getCode();
         $message = $e->getMessage();
         switch ($code) {
             case '23000': return 'Data integrity error: Duplicate entry or invalid reference';
             case '42S22': return 'Database schema error: Missing column';
             case '42S02': return 'Database schema error: Missing table';
             default:
                 if (str_contains($message, "Column") && str_contains($message, "doesn't exist")) {
                     return 'Database schema error: Missing column';
                 }
                 return 'Database error: (' . $code . ') ' . $message; // Include code
         }
    }

    /**
     * Display a listing of the resource.
     * GET /api/parking-layouts
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        try {
            // is_active included automatically via model
            $layouts = ParkingLayout::with('parkingSlots')->orderBy('name')->get();
            return response()->json([
                'message' => 'Layouts retrieved successfully',
                'data' => $layouts
            ]);
        } catch (\Exception $e) {
            Log::error('Error retrieving layouts: ' . $e->getMessage(), ['trace' => $e->getTraceAsString()]);
            return response()->json(['message' => 'Error retrieving layouts', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
        }
    }

    /**
     * Display the specified resource.
     * GET /api/parking-layouts/{id}
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        try {
            // is_active included automatically via model
            $layout = ParkingLayout::with('parkingSlots')->findOrFail($id);

            // layout_data automatically decoded by 'array' cast
            $layoutData = $layout->layout_data ?: [];

            // Prepare response data consistently
            $responseData = [
                'id' => $layout->id,
                'name' => $layout->name,
                'description' => $layout->description,
                'background_image' => $layout->background_image, // Uses accessor
                'is_active' => $layout->is_active,
                // parking_slots relation is already loaded via with()
                'parking_slots' => $layout->parkingSlots,
                'layout_data' => [ // Ensure structure
                    'parking_slots' => $layoutData['parking_slots'] ?? [],
                    'lines' => $layoutData['lines'] ?? [],
                    'texts' => $layoutData['texts'] ?? []
                ]
            ];

            return response()->json([
                'message' => 'Layout retrieved successfully',
                'data' => $responseData
            ]);
        } catch (ModelNotFoundException $e) {
            Log::warning('Layout not found:', ['id' => $id]);
            return response()->json(['message' => 'Layout not found'], 404);
        } catch (\Exception $e) {
            Log::error('Error retrieving layout: ' . $e->getMessage(), ['id' => $id, 'trace' => $e->getTraceAsString()]);
            return response()->json(['message' => 'Error retrieving layout', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     * POST /api/parking-layouts
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255|unique:parking_layouts,name',
            'description' => 'nullable|string',
            'background_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            // Validate structure if layout_data is provided. Accept either an already-decoded array
            // (when the request's Content-Type is application/json) or a JSON string.
            'layout_data' => ['nullable', function ($attribute, $value, $fail) {
                if ($value === null) {
                    return; // nullable allowed
                }

                if (is_array($value)) {
                    $data = $value;
                } elseif (is_string($value)) {
                    $data = json_decode($value, true);
                    if (json_last_error() !== JSON_ERROR_NONE) {
                        $fail('The '.$attribute.' must be valid JSON.');
                        return;
                    }
                } else {
                    $fail('The '.$attribute.' must be a JSON string or an array.');
                    return;
                }

                if (!is_array($data)) {
                    $fail('The '.$attribute.' must decode to an array.');
                }
            }],
        ]);

        DB::beginTransaction();
        try {
            $imagePath = null;
            if ($request->hasFile('background_image')) {
                // Store relative path
                $imagePath = $request->file('background_image')->store('parking-layouts', 'public');
            }

            $layoutData = null;
            if ($request->filled('layout_data')) {
                 $layoutDataInput = $request->input('layout_data');
                 // Decode here since validation ensures it's valid JSON string or already array
                 $layoutData = is_string($layoutDataInput) ? json_decode($layoutDataInput, true) : $layoutDataInput;
            }

            // Create the layout
            $layout = ParkingLayout::create([
                'name' => $validatedData['name'],
                'description' => $validatedData['description'] ?? null,
                'background_image' => $imagePath, // Store relative path
                'is_active' => true, // Default to active
                'layout_data' => $layoutData // Model's cast/mutator handles encoding
            ]);

            // Sync slots if layout_data was provided
            if ($layoutData && isset($layoutData['parking_slots']) && is_array($layoutData['parking_slots'])) {
                $this->syncParkingSlots($layout, $layoutData['parking_slots']);
            }

            DB::commit();
            // Load fresh data including the accessor for background_image URL
            $layout->refresh()->load('parkingSlots');
            return response()->json([
                'message' => 'Layout created successfully',
                'data' => $layout
            ], 201);

        } catch (ValidationException $e) {
             DB::rollBack();
             Log::error('Validation error creating parking layout: ', ['errors' => $e->errors()]);
             return response()->json(['message' => 'Validation failed', 'errors' => $e->errors()], 422);
         } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating parking layout: ' . $e->getMessage(), ['trace' => $e->getTraceAsString()]);
            return response()->json(['message' => 'Error creating parking layout', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     * Handles both full updates and specific is_active toggles.
     * PUT /api/parking-layouts/{id}
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        Log::info("--- Starting Update Layout Request ---", ['id' => $id, 'request_data' => $request->all()]); // Log entry point

        // --- Handle specific 'is_active' toggle request ---
        // Check if ONLY 'is_active' is present in the request body
        // Note: $request->all() might include '_method' if using form method spoofing, check count accordingly.
        // If using raw PUT, $request->all() should only contain sent data.
        $requestDataKeys = array_keys($request->all());
        $isToggleOnly = count($requestDataKeys) === 1 && $requestDataKeys[0] === 'is_active';

        if ($isToggleOnly) {
             Log::info("Processing as 'is_active' toggle only.");
             $validatedData = $request->validate([
                 'is_active' => ['required', Rule::in([true, false, 1, 0, '1', '0'])],
             ]);
             Log::info('Validation Passed (is_active toggle only).', ['validated_data' => $validatedData]);

             DB::beginTransaction();
             try {
                 $parking_layout = ParkingLayout::findOrFail($id);
                 Log::info('Found layout for toggle.', ['id' => $id, 'current_is_active' => $parking_layout->is_active]);

                 $newStatus = filter_var($validatedData['is_active'], FILTER_VALIDATE_BOOLEAN);
                 Log::info('Processing is_active toggle.', ['new_status' => $newStatus]);

                 // Only save if the status actually changed
                 if ($parking_layout->is_active !== $newStatus) {
                     $parking_layout->is_active = $newStatus;
                     Log::info('Attempting to save is_active status...');
                     if ($parking_layout->save()) { // Use direct save() for this isolated update
                         Log::info('is_active status saved successfully.');
                     } else {
                         Log::error('Model save() returned false for is_active update.');
                         throw new \Exception('Failed to save layout status change.'); // Force error if save fails silently
                     }
                 } else {
                     Log::info('is_active status unchanged, no save needed.');
                 }

                 DB::commit();
                 Log::info('Transaction committed (is_active toggle).');

                 $parking_layout->refresh()->load('parkingSlots'); // Get fresh data
                 return response()->json([
                     'message' => 'Layout status updated successfully',
                     'data' => $parking_layout
                 ]);

             } catch (ModelNotFoundException $e) {
                 DB::rollBack();
                 Log::warning('Layout not found for toggle:', ['id' => $id]);
                 return response()->json(['message' => 'Layout not found'], 404);
            } catch (ValidationException $e) {
                 DB::rollBack();
                 Log::error('Validation error toggling layout status:', ['id' => $id, 'errors' => $e->errors()]);
                 return response()->json(['message' => 'Validation failed', 'errors' => $e->errors()], 422);
             } catch (\Exception $e) {
                 DB::rollBack();
                 Log::error('--- Error During Layout Toggle ---', [
                     'id' => $id, 'message' => $e->getMessage(), 'trace' => $e->getTraceAsString()
                 ]);
                 return response()->json(['message' => 'Error updating layout status', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
             }

        } else {
             // --- Handle Full Update Request (if more than just is_active is sent) ---
             Log::info('Processing as full layout update.');
             $validatedData = $request->validate([
                 'name' => 'sometimes|required|string|max:255|unique:parking_layouts,name,'.$id,
                 'description' => 'sometimes|nullable|string',
                 'background_image' => 'sometimes|nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                 'is_active' => ['sometimes', 'required', Rule::in([true, false, 1, 0, '1', '0'])],
                 'layout_data' => ['sometimes','nullable', function ($attribute, $value, $fail) {
                      // Accept either a decoded array or a JSON string. Avoid calling json_decode on arrays.
                      if ($value === null) { return; }
                      if (is_array($value)) {
                          $data = $value;
                      } elseif (is_string($value)) {
                          $data = json_decode($value, true);
                          if (json_last_error() !== JSON_ERROR_NONE) { $fail('Invalid JSON.'); return; }
                      } else {
                          $fail('The '.$attribute.' must be a JSON string or an array.'); return;
                      }

                      if (!is_array($data)) { $fail('Must decode to an array.'); }
                 }],
             ]);
             Log::info('Validation Passed (full update).', ['validated_data' => $validatedData]);

             DB::beginTransaction();
             try {
                $parking_layout = ParkingLayout::findOrFail($id);
                 Log::info('Found layout for full update.', ['id' => $id]);

                 $updatePayload = []; // Collect fields to update

                 // Build payload based on validated data present in the request
                if (array_key_exists('is_active', $validatedData)) {
                    $updatePayload['is_active'] = filter_var($validatedData['is_active'], FILTER_VALIDATE_BOOLEAN);
                 }
                 if (array_key_exists('name', $validatedData)) {
                     $updatePayload['name'] = $validatedData['name'];
                 }
                // Check if description column exists before adding to payload
                if (array_key_exists('description', $validatedData)) {
                    // Check if the 'description' column actually exists on the table
                    if (Schema::hasColumn('parking_layouts', 'description')) {
                         $updatePayload['description'] = $validatedData['description'];
                    } else {
                         Log::warning("Skipping description update: 'description' column does not exist on parking_layouts table.");
                    }
                 }

                // Image handling (using relative paths)
                if ($request->hasFile('background_image')) {
                     if ($oldImage = $parking_layout->getRawOriginal('background_image')) { Storage::disk('public')->delete($oldImage); }
                     $imagePath = $request->file('background_image')->store('parking-layouts', 'public');
                     $updatePayload['background_image'] = $imagePath; // Store relative path
                     Log::info('Processing background image upload.');
                 } elseif ($request->has('background_image') && $request->input('background_image') === null) {
                      if ($oldImage = $parking_layout->getRawOriginal('background_image')) { Storage::disk('public')->delete($oldImage); }
                     $updatePayload['background_image'] = null;
                     Log::info('Processing background image removal.');
                 }


                // Layout data handling
                if (array_key_exists('layout_data', $validatedData)) {
                     $layoutDataInput = $request->input('layout_data');
                     $layoutData = null;
                     if ($layoutDataInput !== null) { $layoutData = is_string($layoutDataInput) ? json_decode($layoutDataInput, true) : $layoutDataInput; }
                     $updatePayload['layout_data'] = $layoutData; // Model handles encoding
                     Log::info('Processing layout_data update and syncing slots.');
                     $slotDataArr = $layoutData['parking_slots'] ?? [];
                     $this->syncParkingSlots($parking_layout, $slotDataArr);
                 }

                 // Perform mass update only if there are fields in the payload
                if (!empty($updatePayload)) {
                     Log::info('Attempting to mass update model...', ['payload_keys' => array_keys($updatePayload)]);
                     if ($parking_layout->update($updatePayload)) { // Use update() for mass assignment
                         Log::info('Model updated successfully via mass assignment.');
                     } else {
                         Log::error('Model update() returned false during full update.');
                         throw new \Exception('Failed to update layout changes using mass assignment.');
                     }
                 } else {
                     // Check if only layout_data (and thus slots) might have changed
                     if (!array_key_exists('layout_data', $validatedData)) {
                        Log::info('No eligible fields provided for layout update, skipping update().');
                     } else {
                        // If only layout_data was sent, syncSlots already happened.
                        // We still might need to save if other parts of layout_data (lines/texts) changed.
                        // However, updatePayload is empty, so we rely on syncSlots saving relationships.
                        // If layout_data itself needs saving (e.g., lines/texts change),
                        // we might need a direct save here if nothing else changed.
                         if (!$request->hasFile('background_image') && !$request->has('background_image')) {
                             // Consider if layout_data outside of slots needs saving
                             // $parking_layout->save(); // Might be redundant if syncSlots saves parent
                             Log::info('Only layout_data provided, slots synced.');
                         }
                     }
                 }


                 DB::commit();
                 Log::info('Transaction committed (full update).');

                 $parking_layout->refresh()->load('parkingSlots');
                 Log::info('Returning updated layout (full update).', ['id' => $id]);
                 return response()->json(['message' => 'Layout updated successfully', 'data' => $parking_layout]);

             } catch (ModelNotFoundException $e) {
                 DB::rollBack(); Log::warning('Layout not found for update:', ['id' => $id]); return response()->json(['message' => 'Layout not found'], 404);
             } catch (ValidationException $e) {
                 DB::rollBack(); Log::error('Validation error updating layout:', ['id' => $id, 'errors' => $e->errors()]); return response()->json(['message' => 'Validation failed', 'errors' => $e->errors()], 422);
             } catch (\Exception $e) {
                 DB::rollBack();
                 Log::error('--- Error During Full Layout Update ---', [
                     'id' => $id, 'message' => $e->getMessage(), 'trace' => $e->getTraceAsString()
                 ]);
                 return response()->json(['message' => 'Error updating layout', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
             }
         }
    }


    /**
     * Remove the specified resource from storage.
     * DELETE /api/parking-layouts/{id}
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            $layout = ParkingLayout::findOrFail($id);
            Log::info('Attempting to delete layout:', ['layout_id' => $id]);

            // Delete associated parking slots first explicitly to ensure deletion
            // This is safer than relying solely on potential DB cascade settings
            Log::info('Deleting associated parking slots for layout:', ['layout_id' => $id]);
            $layout->parkingSlots()->delete();

            // Delete the background image
            if ($imagePath = $layout->getRawOriginal('background_image')) {
                 if (Storage::disk('public')->exists($imagePath)) {
                     Storage::disk('public')->delete($imagePath);
                     Log::info('Deleted background image', ['path' => $imagePath]);
                 } else {
                     Log::warning('Background image file not found for deletion:', ['path' => $imagePath]);
                 }
             }

            $layout->delete(); // Delete the layout record
            Log::info('Successfully deleted layout', ['layout_id' => $id]);
            DB::commit();
            return response()->json(['message' => 'Layout deleted successfully'], 200);

        } catch (ModelNotFoundException $e) {
             DB::rollBack();
             Log::warning('Attempted to delete non-existent layout:', ['layout_id' => $id]);
             return response()->json(['message' => 'Layout not found'], 404);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error deleting layout:', ['id' => $id, 'error' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);
            // Check for foreign key constraint errors specifically
            if ($e instanceof \Illuminate\Database\QueryException && str_contains($e->getMessage(), 'constraint violation')) {
                // You might have assignments referencing slots in this layout
                return response()->json(['message' => 'Cannot delete layout: It may still have active parking assignments. Please end all assignments for this layout first.', 'error' => config('app.debug') ? $e->getMessage() : 'Constraint violation'], 409); // 409 Conflict
            }
            return response()->json(['message' => 'Error deleting layout', 'error' => config('app.debug') ? $e->getMessage() : 'Server error'], 500);
        }
    }

     /**
      * Helper function to sync parking slots based on layout data.
      *
      * @param ParkingLayout $parking_layout
      * @param array $slotDataArr Data containing the parking slots from the request
      * @return void
      */
     protected function syncParkingSlots(ParkingLayout $parking_layout, array $slotDataArr)
     {
         $existingSlots = $parking_layout->parkingSlots()->pluck('id', 'id'); // More efficient way to get existing IDs
         $processedSlotIds = [];

         foreach ($slotDataArr as $slotData) {
             $slotId = $slotData['id'] ?? null;

             $metadata = [ // Simplified metadata structure based on ParkingSlot model
                 'rotation' => $slotData['rotation'] ?? ($slotData['metadata']['rotation'] ?? 0),
                 'fill' => $slotData['fill'] ?? ($slotData['metadata']['fill'] ?? 'rgba(0, 255, 0, 0.3)'),
                 'type' => $slotData['space_type'] ?? ($slotData['metadata']['type'] ?? 'standard'),
                 'name' => $slotData['space_number'] ?? ($slotData['metadata']['name'] ?? ('Slot ' . substr(uniqid(), -4)))
             ];

             $slotArr = [
                 'space_number' => $slotData['space_number'] ?? ('Slot ' . substr(uniqid(), -4)),
                 'space_type' => $slotData['space_type'] ?? 'standard',
                 // Preserve existing status only if updating and not provided
                 'space_status' => $slotData['space_status'] ?? ($existingSlots->has($slotId) ? $parking_layout->parkingSlots()->find($slotId)->space_status : 'available'),
                 'position_x' => $slotData['position_x'] ?? $slotData['x_coordinate'] ?? 0,
                 'position_y' => $slotData['position_y'] ?? $slotData['y_coordinate'] ?? 0,
                 'width' => $slotData['width'] ?? 60,
                 'height' => $slotData['height'] ?? 120,
                 'rotation' => $slotData['rotation'] ?? 0,
                 'metadata' => $metadata // Model will encode this
             ];

             // Use updateOrCreate with layout relationship for automatic layout_id
             $slot = $parking_layout->parkingSlots()->updateOrCreate(
                 ['id' => $slotId], // Search criteria (null ID means create)
                 $slotArr          // Data
             );
             $processedSlotIds[$slot->id] = true; // Mark ID as processed
         }

         // Delete slots that existed before but were not in the processed list
         $slotIdsToDelete = $existingSlots->keys()->diff(array_keys($processedSlotIds))->all();
         if (!empty($slotIdsToDelete)) {
             Log::info('Deleting parking slots no longer present in layout_data update', ['ids' => $slotIdsToDelete]);
             ParkingSlot::whereIn('id', $slotIdsToDelete)->where('layout_id', $parking_layout->id)->delete();
         }
         Log::info('Parking slot sync complete', ['layout_id' => $parking_layout->id, 'processed_count' => count($processedSlotIds), 'deleted_count' => count($slotIdsToDelete)]);
     }
}