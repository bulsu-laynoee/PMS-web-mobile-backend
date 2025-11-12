<?php
   
namespace App\Http\Controllers\API;
   
use App\Models\UserDetails;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController as BaseController;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;
use Validator;
use Illuminate\Support\Str;
use App\Models\Vehicle;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Schema;
// QR generation
use Endroid\QrCode\Builder\Builder;
use Endroid\QrCode\Writer\SvgWriter;
use Endroid\QrCode\Encoding\Encoding;
use Endroid\QrCode\ErrorCorrectionLevel\ErrorCorrectionLevelLow;
   
class RegisterController extends BaseController
{
    /**
     * Register api
     *
     * @return \Illuminate\Http\Response
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'firstname' => 'required',
            'lastname' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required',
            'c_password' => 'required|same:password',
            'role_id' => 'nullable|integer|exists:roles,id',
            // vehicle / OR-CR uploads
            'plate_number' => 'nullable|string',
            'vehicle_color' => 'nullable|string',
            'vehicle_type' => 'nullable|string',
            'brand' => 'nullable|string',
            'model' => 'nullable|string',
            // Allow OR/CR uploads to be either PDF or images (jpeg/png/jpg/heic)
            'or_file' => 'sometimes|file|mimes:pdf,jpeg,png,jpg,heic|max:5120',
            'cr_file' => 'sometimes|file|mimes:pdf,jpeg,png,jpg,heic|max:5120',
            // legacy combined OR/CR PDF field (keep PDF-only)
            'or_cr_pdf' => 'sometimes|file|mimes:pdf|max:5120',
            'deed_file' => 'sometimes|file|mimes:pdf,jpeg,png,jpg,heic|max:10240',
            // require two generic ID uploads (images only) - mandatory for registration
            'id1_file' => 'required|file|mimes:jpeg,png,jpg,heic,webp|max:5120',
            'id2_file' => 'required|file|mimes:jpeg,png,jpg,heic,webp|max:5120',
            'or_number' => 'nullable|string|unique:vehicles,or_number',
            'cr_number' => 'nullable|string|unique:vehicles,cr_number',
            'mark_as_pending' => 'nullable|string',
            'is_second_hand' => 'nullable|string',
            'referred_by' => [
                'nullable', 
                'email', 
                Rule::exists('users', 'email'), 
                function (string $attribute, mixed $value, \Closure $fail) {
                    $referrer = User::where('email', $value)->first();
                    if ($referrer && $referrer->refer_count >= 10) { $fail("Referrer exceeded count of refers."); }
                }
            ]
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $input = $request->all();
        // If frontend submitted a nested user_detail[...] payload, merge it so fields
        // like student_no, course, department, contact_number are available at top-level.
        if (isset($input['user_detail']) && is_array($input['user_detail'])) {
            $input = array_merge($input, $input['user_detail']);
        }
        $input['password'] = bcrypt($input['password']);
        // Accept role_id from client but persist into legacy roles_id when available
        $new_user = [
            'name' => $input['firstname'] . " " . $input['lastname'],
            'email' => $input['email'],
            'password' => $input['password'],
            // prefer roles_id (legacy) but accept role_id fallback
            'roles_id' => $input['role_id'] ?? $input['roles_id'] ?? 3,
            'role_id' => $input['role_id'] ?? $input['roles_id'] ?? 3,
        ];
        $user = User::create($new_user);
        $success['token'] =  $user->createToken('MyApp')->plainTextToken;
        $success['name'] =  $user->name;
        
    // Force all new accounts into pending review server-side
    $markAsPending = true;
        
        $userDetails = UserDetails::create([
            'user_id' => $user->id,
            'firstname' => $input['firstname'],
            'lastname' => $input['lastname'],
            'department' => $input['department'] ?? null,
            'contact_number' => $input['contact_number'] ?? null,
            'student_no' => $input['student_no'] ?? null,
            'faculty_id' => $input['faculty_id'] ?? null,
            'employee_id' => $input['employee_id'] ?? null,
            'course' => $input['course'] ?? null,
            'yr_section' => $input['yr_section'] ?? null,
            'nationality' => 'Filipino',
            'membership_date' => $user->created_at,
            // placeholders for OR/CR paths (may be set below)
            'or_path' => null,
            'cr_path' => null,
            // placeholders for two generic id uploads
            'id1_path' => null,
            'id1_name' => null,
            'id2_path' => null,
            'id2_name' => null,
            'or_number' => $input['or_number'] ?? null,
            'cr_number' => $input['cr_number'] ?? null,
            'plate_number' => $input['plate_number'] ?? null,
            'from_pending' => $markAsPending ? 1 : 0,
        ]);
        
        $user->userDetail()->save($userDetails);
    \Log::info('UserDetails initial saved', ['user_details' => $userDetails->toArray()]);
        
        \Log::info('User registration created', [
            'user_id' => $user->id,
            'from_pending' => $userDetails->from_pending,
            'mark_as_pending_flag' => $input['mark_as_pending'] ?? null,
            'is_second_hand_flag' => $input['is_second_hand'] ?? null
        ]);

        // Handle vehicle OR/CR upload and vehicle creation if plate_number supplied
        $orPath = null; $crPath = null;
        
        // Debug: Log what files are being received
        \Log::info('Registration file upload debug', [
            'has_or_file' => $request->hasFile('or_file'),
            'has_cr_file' => $request->hasFile('cr_file'),
            'has_or_cr_pdf' => $request->hasFile('or_cr_pdf'),
            'all_files' => array_keys($request->allFiles()),
            'input_keys' => array_keys($input)
        ]);
        
        if ($request->hasFile('or_file') || $request->hasFile('cr_file') || $request->hasFile('or_cr_pdf')) {
            // Ensure storage directory exists
            if (!file_exists(storage_path('app/public/or_cr'))) {
                mkdir(storage_path('app/public/or_cr'), 0755, true);
            }
            
            if ($request->hasFile('or_cr_pdf')) {
                $file = $request->file('or_cr_pdf');
                $orCrOriginalName = $file->getClientOriginalName();
                $filename = 'orcr_' . Str::random(8) . '.' . $file->getClientOriginalExtension();
                $orPath = null;
                try {
                    \Log::info('Attempting to store OR/CR PDF', [
                        'original_name' => $file->getClientOriginalName(),
                        'extension' => $file->getClientOriginalExtension(),
                        'mime' => $file->getClientMimeType(),
                        'size' => $file->getSize(),
                        'is_valid' => method_exists($file, 'isValid') ? $file->isValid() : null,
                        'pathname' => $file->getPathname(),
                        'realpath' => $file->getRealPath()
                    ]);
                    $orPath = $file->storeAs('or_cr', $filename, 'public');
                    if (!$orPath) {
                        // fallback to a direct put using the file stream (robust)
                        $streamPath = $file->getRealPath() ?: $file->getPathname();
                        $attempted = false;
                        if ($streamPath) {
                            try {
                                $stream = @fopen($streamPath, 'r');
                                if (is_resource($stream)) {
                                    Storage::disk('public')->put('or_cr/' . $filename, $stream);
                                    if (is_resource($stream)) fclose($stream);
                                    $orPath = 'or_cr/' . $filename;
                                    \Log::info('Fallback put succeeded for OR/CR PDF (stream)', ['path' => $orPath, 'filename' => $filename]);
                                    $attempted = true;
                                }
                            } catch (\Throwable $e) {
                                \Log::warning('Fallback stream put exception for OR/CR PDF', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                            }
                        }
                        if (!$attempted) {
                            $contents = @file_get_contents($streamPath ?: '');
                            if ($contents !== false) {
                                Storage::disk('public')->put('or_cr/' . $filename, $contents);
                                $orPath = 'or_cr/' . $filename;
                                \Log::info('Fallback put succeeded for OR/CR PDF (contents)', ['path' => $orPath, 'filename' => $filename]);
                            } else {
                                \Log::error('Fallback failed - no readable stream or contents for OR/CR PDF', ['streamPath' => $streamPath]);
                            }
                        }
                    } else {
                        \Log::info('Uploaded OR/CR PDF', ['path' => $orPath, 'filename' => $filename]);
                    }
                } catch (\Throwable $e) {
                    \Log::error('OR/CR store failed', ['error' => $e->getMessage()]);
                }
            }
            if ($request->hasFile('or_file')) {
                $file = $request->file('or_file');
                $orOriginalName = $file->getClientOriginalName();
                // Determine extension: prefer client original extension, else derive from mime or original name
                $origExt = $file->getClientOriginalExtension();
                $mime = $file->getClientMimeType() ?: '';
                $ext = $origExt ?: null;
                if (!$ext) {
                    $map = [
                        'image/png' => 'png',
                        'image/jpeg' => 'jpg',
                        'image/jpg' => 'jpg',
                        'image/heic' => 'heic',
                        'application/pdf' => 'pdf',
                    ];
                    $ext = $map[$mime] ?? null;
                }
                if (!$ext) {
                    $origName = $file->getClientOriginalName();
                    $ext = pathinfo($origName, PATHINFO_EXTENSION) ?: null;
                }
                $filename = 'or_' . Str::random(8) . ($ext ? '.' . $ext : '');
                $orPath = null;
                try {
                    \Log::info('Attempting to store OR file', [
                        'original_name' => $file->getClientOriginalName(),
                        'extension' => $ext,
                        'reported_extension' => $file->getClientOriginalExtension(),
                        'mime' => $mime,
                        'size' => $file->getSize(),
                        'is_valid' => method_exists($file, 'isValid') ? $file->isValid() : null,
                        'pathname' => $file->getPathname(),
                        'realpath' => $file->getRealPath()
                    ]);
                    $orPath = $file->storeAs('or_cr', $filename, 'public');
                    if (!$orPath) {
                        $streamPath = $file->getRealPath() ?: $file->getPathname();
                        $attempted = false;
                        if ($streamPath) {
                            try {
                                $stream = @fopen($streamPath, 'r');
                                if (is_resource($stream)) {
                                    Storage::disk('public')->put('or_cr/' . $filename, $stream);
                                    if (is_resource($stream)) fclose($stream);
                                    $orPath = 'or_cr/' . $filename;
                                    \Log::info('Fallback put succeeded for OR file (stream)', ['path' => $orPath, 'filename' => $filename]);
                                    $attempted = true;
                                }
                            } catch (\Throwable $e) {
                                \Log::warning('Fallback stream put exception for OR file', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                            }
                        }
                        if (!$attempted) {
                            $contents = @file_get_contents($streamPath ?: '');
                            if ($contents !== false) {
                                Storage::disk('public')->put('or_cr/' . $filename, $contents);
                                $orPath = 'or_cr/' . $filename;
                                \Log::info('Fallback put succeeded for OR file (contents)', ['path' => $orPath, 'filename' => $filename]);
                            } else {
                                \Log::error('Fallback failed - no readable stream or contents for OR file', ['streamPath' => $streamPath]);
                            }
                        }
                    } else {
                        \Log::info('Uploaded OR file', ['path' => $orPath, 'filename' => $filename]);
                    }
                } catch (\Throwable $e) {
                    \Log::error('OR store failed', ['error' => $e->getMessage()]);
                }
            }
            if ($request->hasFile('cr_file')) {
                $file = $request->file('cr_file');
                $crOriginalName = $file->getClientOriginalName();
                $origExt = $file->getClientOriginalExtension();
                $mime = $file->getClientMimeType() ?: '';
                $ext = $origExt ?: null;
                if (!$ext) {
                    $map = [
                        'image/png' => 'png',
                        'image/jpeg' => 'jpg',
                        'image/jpg' => 'jpg',
                        'image/heic' => 'heic',
                        'application/pdf' => 'pdf',
                    ];
                    $ext = $map[$mime] ?? null;
                }
                if (!$ext) {
                    $origName = $file->getClientOriginalName();
                    $ext = pathinfo($origName, PATHINFO_EXTENSION) ?: null;
                }
                $filename = 'cr_' . Str::random(8) . ($ext ? '.' . $ext : '');
                $crPath = null;
                try {
                    \Log::info('Attempting to store CR file', [
                        'original_name' => $file->getClientOriginalName(),
                        'extension' => $ext,
                        'reported_extension' => $file->getClientOriginalExtension(),
                        'mime' => $mime,
                        'size' => $file->getSize(),
                        'is_valid' => method_exists($file, 'isValid') ? $file->isValid() : null,
                        'pathname' => $file->getPathname(),
                        'realpath' => $file->getRealPath()
                    ]);
                    $crPath = $file->storeAs('or_cr', $filename, 'public');
                    if (!$crPath) {
                        $streamPath = $file->getRealPath() ?: $file->getPathname();
                        $attempted = false;
                        if ($streamPath) {
                            try {
                                $stream = @fopen($streamPath, 'r');
                                if (is_resource($stream)) {
                                    Storage::disk('public')->put('or_cr/' . $filename, $stream);
                                    if (is_resource($stream)) fclose($stream);
                                    $crPath = 'or_cr/' . $filename;
                                    \Log::info('Fallback put succeeded for CR file (stream)', ['path' => $crPath, 'filename' => $filename]);
                                    $attempted = true;
                                }
                            } catch (\Throwable $e) {
                                \Log::warning('Fallback stream put exception for CR file', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                            }
                        }
                        if (!$attempted) {
                            $contents = @file_get_contents($streamPath ?: '');
                            if ($contents !== false) {
                                Storage::disk('public')->put('or_cr/' . $filename, $contents);
                                $crPath = 'or_cr/' . $filename;
                                \Log::info('Fallback put succeeded for CR file (contents)', ['path' => $crPath, 'filename' => $filename]);
                            } else {
                                \Log::error('Fallback failed - no readable stream or contents for CR file', ['streamPath' => $streamPath]);
                            }
                        }
                    } else {
                        \Log::info('Uploaded CR file', ['path' => $crPath, 'filename' => $filename]);
                    }
                } catch (\Throwable $e) {
                    \Log::error('CR store failed', ['error' => $e->getMessage()]);
                }
            }

                // Handle deed_file (second-hand flows)
                if ($request->hasFile('deed_file')) {
                    if (!file_exists(storage_path('app/public/deeds'))) {
                        mkdir(storage_path('app/public/deeds'), 0755, true);
                    }
                    $file = $request->file('deed_file');
                    // determine extension, fall back to mapping from mime if empty
                    $origExt = $file->getClientOriginalExtension();
                    $mime = $file->getClientMimeType() ?: '';
                    $ext = $origExt ?: null;
                    if (!$ext) {
                        // map common mime types
                        $map = [
                            'application/pdf' => 'pdf',
                            'image/png' => 'png',
                            'image/jpeg' => 'jpg',
                            'image/jpg' => 'jpg',
                            'image/heic' => 'heic',
                        ];
                        $ext = $map[$mime] ?? null;
                    }
                    $filename = 'deed_' . Str::random(8) . ($ext ? '.' . $ext : '');
                    $deedPath = null;
                    try {
                        $deedPath = $file->storeAs('deeds', $filename, 'public');
                        if (!$deedPath) {
                            $streamPath = $file->getRealPath() ?: $file->getPathname();
                            $attempted = false;
                            if ($streamPath) {
                                try {
                                    $stream = @fopen($streamPath, 'r');
                                    if (is_resource($stream)) {
                                        Storage::disk('public')->put('deeds/' . $filename, $stream);
                                        if (is_resource($stream)) fclose($stream);
                                        $deedPath = 'deeds/' . $filename;
                                        \Log::info('Fallback put succeeded for deed file (stream)', ['path' => $deedPath, 'filename' => $filename]);
                                        $attempted = true;
                                    }
                                } catch (\Throwable $e) {
                                    \Log::warning('Fallback stream put exception for deed file', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                                }
                            }
                            if (!$attempted) {
                                $contents = @file_get_contents($streamPath ?: '');
                                if ($contents !== false) {
                                    Storage::disk('public')->put('deeds/' . $filename, $contents);
                                    $deedPath = 'deeds/' . $filename;
                                    \Log::info('Fallback put succeeded for deed file (contents)', ['path' => $deedPath, 'filename' => $filename]);
                                } else {
                                    \Log::error('Fallback failed - no readable stream or contents for deed file', ['streamPath' => $streamPath]);
                                }
                            }
                        }
                        \Log::info('Uploaded deed file', ['path' => $deedPath, 'filename' => $filename]);
                    } catch (\Throwable $e) {
                        \Log::error('deed store failed', ['error' => $e->getMessage()]);
                    }
                    $ud = $user->userDetail()->first();
                    if ($ud) {
                        if (Schema::hasColumn('user_details', 'deed_path')) $ud->deed_path = $deedPath;
                        if (Schema::hasColumn('user_details', 'deed_name')) $ud->deed_name = $file->getClientOriginalName();
                        $ud->save();
                        \Log::info('UserDetails after deed save', ['user_details' => $ud->toArray(), 'deedPath' => $deedPath]);
                    }
                }

                // Attempt to normalize OR/CR stored filenames to include detected extensions
                try {
                    // OR normalization
                    if (!empty($orPath)) {
                        $storedRel = $orPath; // e.g. or_cr/or_xxx or or_cr/or_xxx.jpg
                        $storedFull = storage_path('app/public/' . ltrim($storedRel, '/'));
                        if (file_exists($storedFull)) {
                            $finfo = new \finfo(FILEINFO_MIME_TYPE);
                            $mime = $finfo->file($storedFull);
                            $map = [
                                'image/png' => 'png',
                                'image/jpeg' => 'jpg',
                                'image/jpg' => 'jpg',
                                'image/heic' => 'heic',
                                'image/webp' => 'webp',
                                'application/pdf' => 'pdf',
                            ];
                            $detExt = $map[$mime] ?? null;
                            if ($detExt) {
                                $pi = pathinfo($storedFull);
                                $hasExt = isset($pi['extension']) && strlen($pi['extension']) > 0;
                                if (!$hasExt || (isset($pi['extension']) && strtolower($pi['extension']) !== $detExt)) {
                                    $newName = $pi['filename'] . '.' . $detExt;
                                    $newRel = 'or_cr/' . $newName;
                                    if (Storage::disk('public')->exists($newRel)) {
                                        $newName = $pi['filename'] . '_' . Str::random(4) . '.' . $detExt;
                                        $newRel = 'or_cr/' . $newName;
                                    }
                                    Storage::disk('public')->move($storedRel, $newRel);
                                    $orPath = $newRel;
                                    \Log::info('Renamed stored OR file to include detected extension', ['from' => $storedRel, 'to' => $newRel, 'mime' => $mime]);
                                }
                            }
                        }
                    }

                    // CR normalization
                    if (!empty($crPath)) {
                        $storedRel = $crPath;
                        $storedFull = storage_path('app/public/' . ltrim($storedRel, '/'));
                        if (file_exists($storedFull)) {
                            $finfo = new \finfo(FILEINFO_MIME_TYPE);
                            $mime = $finfo->file($storedFull);
                            $map = [
                                'image/png' => 'png',
                                'image/jpeg' => 'jpg',
                                'image/jpg' => 'jpg',
                                'image/heic' => 'heic',
                                'image/webp' => 'webp',
                                'application/pdf' => 'pdf',
                            ];
                            $detExt = $map[$mime] ?? null;
                            if ($detExt) {
                                $pi = pathinfo($storedFull);
                                $hasExt = isset($pi['extension']) && strlen($pi['extension']) > 0;
                                if (!$hasExt || (isset($pi['extension']) && strtolower($pi['extension']) !== $detExt)) {
                                    $newName = $pi['filename'] . '.' . $detExt;
                                    $newRel = 'or_cr/' . $newName;
                                    if (Storage::disk('public')->exists($newRel)) {
                                        $newName = $pi['filename'] . '_' . Str::random(4) . '.' . $detExt;
                                        $newRel = 'or_cr/' . $newName;
                                    }
                                    Storage::disk('public')->move($storedRel, $newRel);
                                    $crPath = $newRel;
                                    \Log::info('Renamed stored CR file to include detected extension', ['from' => $storedRel, 'to' => $newRel, 'mime' => $mime]);
                                }
                            }
                        }
                    }
                } catch (\Throwable $e) {
                    \Log::warning('Failed to normalize OR/CR stored extensions', ['error' => $e->getMessage()]);
                }

            // update the userDetails with or/cr paths
            $ud = $user->userDetail()->first();
            if ($ud) {
                if (Schema::hasColumn('user_details', 'or_path')) $ud->or_path = $orPath ?? $ud->or_path;
                if (Schema::hasColumn('user_details', 'cr_path')) $ud->cr_path = $crPath ?? $ud->cr_path;
                if (Schema::hasColumn('user_details', 'or_number')) $ud->or_number = $input['or_number'] ?? $ud->or_number;
                if (Schema::hasColumn('user_details', 'cr_number')) $ud->cr_number = $input['cr_number'] ?? $ud->cr_number;
                // Save original uploaded filenames if available
                if (isset($orOriginalName) && Schema::hasColumn('user_details', 'or_name')) $ud->or_name = $orOriginalName;
                if (isset($crOriginalName) && Schema::hasColumn('user_details', 'cr_name')) $ud->cr_name = $crOriginalName;
                // If an OR/CR PDF original name was provided via or_cr_pdf
                if (isset($orCrOriginalName) && Schema::hasColumn('user_details', 'or_cr_name')) $ud->or_cr_name = $orCrOriginalName;
                $ud->save();
                \Log::info('UserDetails after OR/CR save', ['user_details' => $ud->toArray()]);
            }
        }

        // Handle additional ID uploads (id1_file, id2_file) - store under public/ids
        if ($request->hasFile('id1_file') || $request->hasFile('id2_file')) {
            if (!file_exists(storage_path('app/public/ids'))) {
                mkdir(storage_path('app/public/ids'), 0755, true);
            }
            $ud = $user->userDetail()->first();
            if ($request->hasFile('id1_file')) {
                $file = $request->file('id1_file');
                $origExt = $file->getClientOriginalExtension();
                $mime = $file->getClientMimeType() ?: '';
                $ext = $origExt ?: null;
                if (!$ext) {
                    $map = [
                        'image/png' => 'png',
                        'image/jpeg' => 'jpg',
                        'image/jpg' => 'jpg',
                        'image/heic' => 'heic',
                        'application/pdf' => 'pdf',
                    ];
                    $ext = $map[$mime] ?? null;
                }
                if (!$ext) {
                    $origName = $file->getClientOriginalName();
                    $ext = pathinfo($origName, PATHINFO_EXTENSION) ?: null;
                }
                $filename = 'id1_' . Str::random(8) . ($ext ? '.' . $ext : '');
                $id1Path = null;
                try {
                    \Log::info('Attempting to store id1 file', [
                        'original_name' => $file->getClientOriginalName(),
                        'extension' => $ext,
                        'reported_extension' => $file->getClientOriginalExtension(),
                        'mime' => $mime,
                        'size' => $file->getSize(),
                        'is_valid' => method_exists($file, 'isValid') ? $file->isValid() : null,
                        'pathname' => $file->getPathname(),
                        'realpath' => $file->getRealPath()
                    ]);
                    $id1Path = $file->storeAs('ids', $filename, 'public');
                    if (!$id1Path) {
                        $streamPath = $file->getRealPath() ?: $file->getPathname();
                        $attempted = false;
                        if ($streamPath) {
                            try {
                                $stream = @fopen($streamPath, 'r');
                                if (is_resource($stream)) {
                                    Storage::disk('public')->put('ids/' . $filename, $stream);
                                    if (is_resource($stream)) fclose($stream);
                                    $id1Path = 'ids/' . $filename;
                                    \Log::info('Fallback put succeeded for id1 file (stream)', ['path' => $id1Path, 'filename' => $filename]);
                                    $attempted = true;
                                }
                            } catch (\Throwable $e) {
                                \Log::warning('Fallback stream put exception for id1 file', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                            }
                        }
                        if (!$attempted) {
                            $contents = @file_get_contents($streamPath ?: '');
                            if ($contents !== false) {
                                Storage::disk('public')->put('ids/' . $filename, $contents);
                                $id1Path = 'ids/' . $filename;
                                \Log::info('Fallback put succeeded for id1 file (contents)', ['path' => $id1Path, 'filename' => $filename]);
                            } else {
                                \Log::error('Fallback failed - no readable stream or contents for id1 file', ['streamPath' => $streamPath]);
                            }
                        }
                    } else {
                        \Log::info('Uploaded id1 file', ['path' => $id1Path, 'filename' => $filename]);
                    }
                } catch (\Throwable $e) {
                    \Log::error('id1 store failed', ['error' => $e->getMessage()]);
                }
                if ($ud) {
                    // Ensure stored file has correct image extension; attempt to detect mime and rename stored file if needed
                    try {
                        $storedRel = $id1Path; // e.g. ids/id1_xxx.jpg or ids/id1_xxx
                        $storedFull = storage_path('app/public/' . ltrim($storedRel, '/'));
                        $detExt = null;
                        if (file_exists($storedFull)) {
                            $finfo = new \finfo(FILEINFO_MIME_TYPE);
                            $mime = $finfo->file($storedFull);
                            $map = [
                                'image/png' => 'png',
                                'image/jpeg' => 'jpg',
                                'image/jpg' => 'jpg',
                                'image/heic' => 'heic',
                                'image/webp' => 'webp',
                            ];
                            $detExt = $map[$mime] ?? null;
                            if ($detExt) {
                                $pi = pathinfo($storedFull);
                                $hasExt = isset($pi['extension']) && strlen($pi['extension']) > 0;
                                if (!$hasExt || (isset($pi['extension']) && strtolower($pi['extension']) !== $detExt)) {
                                    $newName = $pi['filename'] . '.' . $detExt;
                                    $newRel = 'ids/' . $newName;
                                    // avoid overwriting existing
                                    if (Storage::disk('public')->exists($newRel)) {
                                        $newName = $pi['filename'] . '_' . Str::random(4) . '.' . $detExt;
                                        $newRel = 'ids/' . $newName;
                                    }
                                    Storage::disk('public')->move($storedRel, $newRel);
                                    $id1Path = $newRel;
                                    \Log::info('Renamed stored id1 file to include detected extension', ['from' => $storedRel, 'to' => $newRel, 'mime' => $mime]);
                                }
                            }
                        }
                    } catch (\Throwable $e) {
                        \Log::warning('Failed to normalize id1 stored extension', ['error' => $e->getMessage()]);
                    }

                    // Save only if column exists
                    if (Schema::hasColumn('user_details', 'id1_path')) $ud->id1_path = $id1Path;
                    if (Schema::hasColumn('user_details', 'id1_name')) $ud->id1_name = $file->getClientOriginalName();
                    $ud->save();
                    \Log::info('UserDetails after id1 save', ['user_details' => $ud->toArray(), 'id1Path' => $id1Path]);
                }
            }
            if ($request->hasFile('id2_file')) {
                $file = $request->file('id2_file');
                $origExt = $file->getClientOriginalExtension();
                $mime = $file->getClientMimeType() ?: '';
                $ext = $origExt ?: null;
                if (!$ext) {
                    $map = [
                        'image/png' => 'png',
                        'image/jpeg' => 'jpg',
                        'image/jpg' => 'jpg',
                        'image/heic' => 'heic',
                        'application/pdf' => 'pdf',
                    ];
                    $ext = $map[$mime] ?? null;
                }
                if (!$ext) {
                    $origName = $file->getClientOriginalName();
                    $ext = pathinfo($origName, PATHINFO_EXTENSION) ?: null;
                }
                $filename = 'id2_' . Str::random(8) . ($ext ? '.' . $ext : '');
                $id2Path = null;
                try {
                    \Log::info('Attempting to store id2 file', [
                        'original_name' => $file->getClientOriginalName(),
                        'extension' => $ext,
                        'reported_extension' => $file->getClientOriginalExtension(),
                        'mime' => $mime,
                        'size' => $file->getSize(),
                        'is_valid' => method_exists($file, 'isValid') ? $file->isValid() : null,
                        'pathname' => $file->getPathname(),
                        'realpath' => $file->getRealPath()
                    ]);
                    $id2Path = $file->storeAs('ids', $filename, 'public');
                    if (!$id2Path) {
                        $streamPath = $file->getRealPath() ?: $file->getPathname();
                        $attempted = false;
                        if ($streamPath) {
                            try {
                                $stream = @fopen($streamPath, 'r');
                                if (is_resource($stream)) {
                                    Storage::disk('public')->put('ids/' . $filename, $stream);
                                    if (is_resource($stream)) fclose($stream);
                                    $id2Path = 'ids/' . $filename;
                                    \Log::info('Fallback put succeeded for id2 file (stream)', ['path' => $id2Path, 'filename' => $filename]);
                                    $attempted = true;
                                }
                            } catch (\Throwable $e) {
                                \Log::warning('Fallback stream put exception for id2 file', ['error' => $e->getMessage(), 'streamPath' => $streamPath]);
                            }
                        }
                        if (!$attempted) {
                            $contents = @file_get_contents($streamPath ?: '');
                            if ($contents !== false) {
                                Storage::disk('public')->put('ids/' . $filename, $contents);
                                $id2Path = 'ids/' . $filename;
                                \Log::info('Fallback put succeeded for id2 file (contents)', ['path' => $id2Path, 'filename' => $filename]);
                            } else {
                                \Log::error('Fallback failed - no readable stream or contents for id2 file', ['streamPath' => $streamPath]);
                            }
                        }
                    } else {
                        \Log::info('Uploaded id2 file', ['path' => $id2Path, 'filename' => $filename]);
                    }
                } catch (\Throwable $e) {
                    \Log::error('id2 store failed', ['error' => $e->getMessage()]);
                }
                if ($ud) {
                    try {
                        $storedRel = $id2Path;
                        $storedFull = storage_path('app/public/' . ltrim($storedRel, '/'));
                        if (file_exists($storedFull)) {
                            $finfo = new \finfo(FILEINFO_MIME_TYPE);
                            $mime = $finfo->file($storedFull);
                            $map = [
                                'image/png' => 'png',
                                'image/jpeg' => 'jpg',
                                'image/jpg' => 'jpg',
                                'image/heic' => 'heic',
                                'image/webp' => 'webp',
                            ];
                            $detExt = $map[$mime] ?? null;
                            if ($detExt) {
                                $pi = pathinfo($storedFull);
                                $hasExt = isset($pi['extension']) && strlen($pi['extension']) > 0;
                                if (!$hasExt || (isset($pi['extension']) && strtolower($pi['extension']) !== $detExt)) {
                                    $newName = $pi['filename'] . '.' . $detExt;
                                    $newRel = 'ids/' . $newName;
                                    if (Storage::disk('public')->exists($newRel)) {
                                        $newName = $pi['filename'] . '_' . Str::random(4) . '.' . $detExt;
                                        $newRel = 'ids/' . $newName;
                                    }
                                    Storage::disk('public')->move($storedRel, $newRel);
                                    $id2Path = $newRel;
                                    \Log::info('Renamed stored id2 file to include detected extension', ['from' => $storedRel, 'to' => $newRel, 'mime' => $mime]);
                                }
                            }
                        }
                    } catch (\Throwable $e) {
                        \Log::warning('Failed to normalize id2 stored extension', ['error' => $e->getMessage()]);
                    }

                    if (Schema::hasColumn('user_details', 'id2_path')) $ud->id2_path = $id2Path;
                    if (Schema::hasColumn('user_details', 'id2_name')) $ud->id2_name = $file->getClientOriginalName();
                    $ud->save();
                    \Log::info('UserDetails after id2 save', ['user_details' => $ud->toArray(), 'id2Path' => $id2Path]);
                }
            }
        }

        // Create a Vehicle record if a plate number was provided
        if (!empty($input['plate_number'])) {
            // ensure plate is unique (case-insensitive)
            $plateCheck = trim($input['plate_number']);
            if (Vehicle::whereRaw('LOWER(plate_number) = ?', [mb_strtolower($plateCheck)])->exists()) {
                return $this->sendError('Validation error', ['plate_number' => ['Plate number already registered']], 422);
            }
            $vehicleData = [
                'user_id' => $user->id,
                'user_details_id' => $user->userDetail()->first()->id ?? null,
                'plate_number' => $input['plate_number'],
                'vehicle_color' => $input['vehicle_color'] ?? null,
                'vehicle_type' => $input['vehicle_type'] ?? null,
                'brand' => $input['brand'] ?? null,
                'model' => $input['model'] ?? null,
                'or_path' => $orPath,
                'cr_path' => $crPath,
                'or_number' => $input['or_number'] ?? null,
                'cr_number' => $input['cr_number'] ?? null,
            ];
            
            \Log::info('Creating vehicle with paths', [
                'user_id' => $user->id,
                'plate_number' => $input['plate_number'],
                'or_path' => $orPath,
                'cr_path' => $crPath,
                'or_number' => $input['or_number'] ?? null,
                'cr_number' => $input['cr_number'] ?? null
            ]);
            
            $vehicle = Vehicle::create($vehicleData);
            \Log::info('Vehicle created successfully', ['vehicle_id' => $vehicle->id]);
        }

        // NOTE: the Team model and team_user pivot are unused in the current
        // application. Avoid creating a personal team during registration.
        // Keep referral counter handling if provided.
        if (!empty($input['referred_by'])) {
            $referrer = User::where('email', $input['referred_by'])->first();
            if ($referrer) {
                $referrer->refer_count = $referrer->refer_count + 1;
                $referrer->save();
            }
        }
   
        // Refresh user details so any saved file paths are included
        $ud = $user->userDetail()->first();
        if ($ud) {
            // Convert stored relative storage paths to public asset URLs when present
            $maybeUrl = function ($path) {
                if (!$path) return null;
                // if already a URL or data URI, return as-is
                if (preg_match('/^https?:\/\//i', $path) || preg_match('/^data:/i', $path)) return $path;
                // Use the API image endpoint which reads from storage/app/public
                return url('/api/image/' . ltrim($path, '/'));
            };

            $udArr = $ud->toArray();
            if (isset($udArr['deed_path'])) $udArr['deed_path'] = $maybeUrl($udArr['deed_path']);
            if (isset($udArr['or_path'])) $udArr['or_path'] = $maybeUrl($udArr['or_path']);
            if (isset($udArr['cr_path'])) $udArr['cr_path'] = $maybeUrl($udArr['cr_path']);
            if (isset($udArr['id1_path'])) $udArr['id1_path'] = $maybeUrl($udArr['id1_path']);
            if (isset($udArr['id2_path'])) $udArr['id2_path'] = $maybeUrl($udArr['id2_path']);
            if (isset($udArr['qr_path'])) $udArr['qr_path'] = $maybeUrl($udArr['qr_path']);
        } else {
            $udArr = null;
        }

        // Include user details in response so mobile app can check from_pending status
        $success['user'] = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'userDetail' => $udArr
        ];
        // Attempt to generate a QR for the new user and persist qr_path/qr_token when possible
        try {
            $token = hash('sha256', $user->id . '|' . now()->timestamp . '|' . Str::random(8));
            $payload = url("/api/scan/qr?user={$user->id}&t={$token}");
            $filename = 'qr_' . $user->id . '_' . time() . '.svg';
            $relativePath = 'qrs/' . $filename;
            $result = Builder::create()
                ->writer(new SvgWriter())
                ->data($payload)
                ->encoding(new Encoding('UTF-8'))
                ->errorCorrectionLevel(new ErrorCorrectionLevelLow())
                ->size(400)
                ->margin(1)
                ->build();
            $contents = $result->getString();
            Storage::disk('public')->put($relativePath, $contents);
            // persist into user_details if columns exist
            $ud = $user->userDetail()->first();
            if ($ud) {
                if (Schema::hasColumn('user_details', 'qr_path')) $ud->qr_path = $relativePath;
                if (Schema::hasColumn('user_details', 'qr_token')) $ud->qr_token = $token;
                $ud->save();
                \Log::info('UserDetails after QR save', ['user_details' => $ud->toArray(), 'qr' => $relativePath, 'token' => $token]);
            }
            $success['qr'] = asset('storage/' . $relativePath);
        } catch (\Throwable $e) {
            \Log::warning('QR generation during register failed', ['error' => $e->getMessage()]);
            // continue without failing registration
        }

        $message = $markAsPending ? 'User registered - pending review' : 'User register successfully.';
        return $this->sendResponse($success, $message);
    }
   
    /**
     * Login api
     *
     * @return \Illuminate\Http\Response
     */
public function login(Request $request)
{
    $request->validate([
        'email' => 'required|string|email',
        'password' => 'required|string',
        'remember' => 'boolean'
    ]);

    $credentials = $request->only('email', 'password');
    $remember = $request->remember ?? false;

    if (!Auth::attempt($credentials, $remember)) {
        return response()->json(['message' => 'Email or Password is incorrect.'], 401);
    }

    $user = Auth::user();

    // Block login if the user's account is pending approval. This prevents
    // pending users from receiving an API token even if credentials are valid.
    try {
        $ud = $user->userDetail()->first();
        $isPending = $ud ? ($ud->from_pending ?? false) : false;
        if ($isPending && intval($isPending) === 1) {
            // Ensures no active session/token is returned
            Auth::logout();
            \Log::warning('Login denied for pending user', ['user_id' => $user->id]);
            return response()->json(['message' => 'Account pending approval. Login denied.'], 403);
        }
    } catch (\Throwable $e) {
        // If there is an error checking details, log it but continue with login
        \Log::warning('Failed to check userDetail for pending status', ['error' => $e->getMessage()]);
    }

    // If this login attempt is for the admin interface, require role id == 6
    $isAdminLogin = $request->input('admin') ? true : false;
    // The users table uses `roles_id` per the User model; accept role_id as a fallback
    $userRoleId = (int)($user->roles_id ?? $user->role_id ?? 0);
    if ($isAdminLogin && ($userRoleId !== 6)) {
        // Logout the just-authenticated user and do not issue a token
        Auth::logout();
        // Log the denied attempt to help debugging
        \Log::warning('Admin login denied', ['user_id' => $user->id ?? null, 'roles_id' => $userRoleId, 'email' => $user->email ?? null, 'admin_flag' => $request->input('admin')]);
        return response()->json(['message' => 'Unauthorized: admin access only'], 403);
    }

    $success['token'] = $user->createToken('MyApp')->plainTextToken;
    $success['name'] = $user->name;

    return response()->json(['data' => $success, 'message' => 'Login Successfully'], 200);
}

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return $this->sendResponse([], 'Logged out successfully');
    }
}