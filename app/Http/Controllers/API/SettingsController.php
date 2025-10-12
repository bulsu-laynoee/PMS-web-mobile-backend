<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class SettingsController extends BaseController
{
    public function profile(\Illuminate\Http\Request $request)
    {
        $user = Auth::user();

        // If middleware didn't populate the current user (for example the
        // request reached this handler without auth:sanctum applied), try to
        // resolve the user from a Bearer token in the Authorization header.
        if (! $user) {
            try {
                $authHeader = $request->header('Authorization');
                if ($authHeader && preg_match('/Bearer\s+(.+)/i', $authHeader, $m)) {
                    $token = $m[1];
                    // Use Sanctum's PersonalAccessToken finder to match the token
                    // to a tokenable (user). This accepts the plain-text token.
                    if (class_exists('\\Laravel\\Sanctum\\PersonalAccessToken')) {
                        $patClass = '\\Laravel\\Sanctum\\PersonalAccessToken';
                        $pat = $patClass::findToken($token);
                        if ($pat && $pat->tokenable) {
                            $user = $pat->tokenable;
                        }
                    }
                }
            } catch (\Throwable $e) {
                // ignore any token parsing/lookup errors
            }
        }

        if (! $user) {
            return $this->sendError('Unauthorized', [], 401);
        }

        try {
            // Ensure related data (user details, vehicles, role) is included so
            // the mobile app can read fields like `qr_path` from userDetail.
            $user->loadMissing(['userDetails', 'vehicles', 'role']);
        } catch (\Throwable $e) {
            // If relations or loader fail for any reason, fall back to returning the user
        }

        return $this->sendResponse($user, 'Profile retrieved');
    }

    public function updateProfile(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . Auth::id(),
            'profile_pic' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = Auth::user();
        $user->name = $request->name;
        $user->email = $request->email;

        if ($request->hasFile('profile_pic')) {
            $path = $request->file('profile_pic')->store('profile_pics', 'public');
            $user->profile_pic = asset('storage/' . $path);
        }

        $user->save();

        return $this->sendResponse($user, 'Profile updated successfully');
    }

    public function updateProfilePic(Request $request)
    {
        $request->validate([
            'profile_pic' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = Auth::user();

        if ($request->hasFile('profile_pic')) {
            $path = $request->file('profile_pic')->store('profile_pics', 'public');
            $user->profile_pic = asset('storage/' . $path);
            $user->save();
        }

        return $this->sendResponse(['profile_pic' => $user->profile_pic], 'Profile picture updated successfully');
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        $user = Auth::user();

        if (!Hash::check($request->current_password, $user->password)) {
            return $this->sendError('Current password is incorrect', [], 422);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return $this->sendResponse([], 'Password updated successfully');
    }

    public function deleteAccount()
    {
        $user = Auth::user();
        $user->delete();

        return $this->sendResponse([], 'Account deleted successfully');
    }
}
