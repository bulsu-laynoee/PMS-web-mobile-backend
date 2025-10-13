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
            'or_file' => 'sometimes|file|mimes:pdf|max:5120',
            'cr_file' => 'sometimes|file|mimes:pdf|max:5120',
            'or_cr_pdf' => 'sometimes|file|mimes:pdf|max:5120',
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
        $input['password'] = bcrypt($input['password']);
        $new_user = [
            'name' => $input['firstname'] . " " . $input['lastname'],
            'email' => $input['email'],
            'password' => $input['password'],
            'role_id' => $input['role_id'] ?? 3, // Default to student role if not specified
        ];
        $user = User::create($new_user);
        $success['token'] =  $user->createToken('MyApp')->plainTextToken;
        $success['name'] =  $user->name;
        
        // Determine if account should be marked as pending
        $markAsPending = !empty($input['mark_as_pending']) || !empty($input['is_second_hand']);
        
        $userDetails = UserDetails::create([
            'user_id' => $user->id,
            'firstname' => $input['firstname'],
            'lastname' => $input['lastname'],
            'nationality' => 'Filipino',
            'membership_date' => $user->created_at,
            // placeholders for OR/CR paths (may be set below)
            'or_path' => null,
            'cr_path' => null,
            'or_number' => $input['or_number'] ?? null,
            'cr_number' => $input['cr_number'] ?? null,
            'plate_number' => $input['plate_number'] ?? null,
            'from_pending' => $markAsPending ? 1 : 0,
        ]);
        
        $user->userDetail()->save($userDetails);
        
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
                $filename = 'orcr_' . Str::random(8) . '.' . $file->getClientOriginalExtension();
                $orPath = $file->storeAs('or_cr', $filename, 'public');
                \Log::info('Uploaded OR/CR PDF', ['path' => $orPath, 'filename' => $filename]);
            }
            if ($request->hasFile('or_file')) {
                $file = $request->file('or_file');
                $filename = 'or_' . Str::random(8) . '.' . $file->getClientOriginalExtension();
                $orPath = $file->storeAs('or_cr', $filename, 'public');
                \Log::info('Uploaded OR file', ['path' => $orPath, 'filename' => $filename]);
            }
            if ($request->hasFile('cr_file')) {
                $file = $request->file('cr_file');
                $filename = 'cr_' . Str::random(8) . '.' . $file->getClientOriginalExtension();
                $crPath = $file->storeAs('or_cr', $filename, 'public');
                \Log::info('Uploaded CR file', ['path' => $crPath, 'filename' => $filename]);
            }

            // update the userDetails with or/cr paths
            $ud = $user->userDetail()->first();
            if ($ud) {
                $ud->or_path = $orPath ?? $ud->or_path;
                $ud->cr_path = $crPath ?? $ud->cr_path;
                $ud->or_number = $input['or_number'] ?? $ud->or_number;
                $ud->cr_number = $input['cr_number'] ?? $ud->cr_number;
                $ud->save();
            }
        }

        // Create a Vehicle record if a plate number was provided
        if (!empty($input['plate_number'])) {
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
   
        // Include user details in response so mobile app can check from_pending status
        $success['user'] = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'userDetail' => $user->userDetail()->first()
        ];
        
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