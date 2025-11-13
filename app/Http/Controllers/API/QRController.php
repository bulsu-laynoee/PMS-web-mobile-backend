<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Schema;
// Use local QR generator (endroid/qr-code)
use Endroid\QrCode\Builder\Builder;
use Endroid\QrCode\Writer\SvgWriter;
use Endroid\QrCode\Encoding\Encoding;
use Endroid\QrCode\ErrorCorrectionLevel\ErrorCorrectionLevelLow;
use App\Models\User;
use App\Models\UserDetails;

class QRController extends Controller
{
    /**
     * Generate a QR image for a user and save path to user_details.qr_path.
     *
     * POST /api/users/{id}/qr
     * Body (optional): { "payload": "custom text or url" }
     */
    public function generate(Request $request, $id)
    {
        $user = User::find($id);
        if (! $user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        // Ensure user_details relation exists (adjust relation name if different)
        $details = null;
        if (method_exists($user, 'userDetails')) {
            $details = $user->userDetails;
        } elseif (method_exists($user, 'details')) {
            $details = $user->details;
        }

        if (! $details) {
            $details = new UserDetails();
            $details->user_id = $user->id;
        }

        // Determine payload
        $payload = $request->input('payload');

        // We'll create a token for generated QR codes. If the caller provided a custom payload
        // we will not inject the token into the payload, but we will still create an internal
        // token and expiry so the app can use verification behavior consistently when desired.
        $token = hash('sha256', $user->id . '|' . now()->timestamp . '|' . Str::random(8));
        $expiresAt = now()->addMinutes(3); // 3 minute expiry

        if (! $payload) {
            // Default payload: a simple internal scan URL containing a short token
            $payload = url("/api/scan/qr?user={$user->id}&t={$token}");
        }

        $filename = 'qr_' . $user->id . '_' . time() . '.svg';
        // Store QR files under 'qrs/' directory as requested
        $relativePath = 'qrs/' . $filename;

        // Generate SVG locally using endroid/qr-code so we don't depend on
        // external services. This produces an SVG string which we persist
        // to storage/app/public/qrs/.
        try {
            $result = Builder::create()
                ->writer(new SvgWriter())
                ->data($payload)
                ->encoding(new Encoding('UTF-8'))
                ->errorCorrectionLevel(new ErrorCorrectionLevelLow())
                ->size(400)
                ->margin(1)
                ->build();

            $contents = $result->getString();

            // Save to storage/app/public/qrs/
            Storage::disk('public')->put($relativePath, $contents);

            // Attempt to persist the QR path (token and expiry) to user_details only
            // if the columns exist. If the DB schema doesn't have these
            // columns we'll skip the update but still return the payload so
            // the client can use it immediately.
            try {
                $needsSave = false;
                if (Schema::hasColumn('user_details', 'qr_path')) {
                    $details->qr_path = $relativePath;
                    $needsSave = true;
                }
                if (Schema::hasColumn('user_details', 'qr_token')) {
                    $details->qr_token = $token;
                    $needsSave = true;
                }
                if (Schema::hasColumn('user_details', 'qr_expires_at')) {
                    // Store as MySQL datetime string
                    $details->qr_expires_at = $expiresAt;
                    $needsSave = true;
                }
                if (Schema::hasColumn('user_details', 'qr_is_active')) {
                    $details->qr_is_active = 1;
                    $needsSave = true;
                }
                if ($needsSave) {
                    $details->save();
                }
            } catch (\Throwable $e) {
                // ignore DB write failures for QR metadata; generation still
                // succeeded and we will return the payload to the caller.
            }

            $publicUrl = asset('storage/' . $relativePath);

            return response()->json([
                'message' => 'QR generated',
                'path' => $relativePath,
                'url' => $publicUrl,
                'payload' => $payload,
                'token' => $token,
                // Use ISO8601 with timezone info so clients interpret expiry consistently
                'expires_at' => $expiresAt->toIso8601String(),
            ], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'QR generation failed', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Verify a scanned token and return user + payload.
     * POST /api/verify-qr
     * Body: { token: string }
     */
    public function verify(Request $request)
    {
        $token = $request->input('token');
        if (! $token) {
            return response()->json(['message' => 'Missing token'], 400);
        }

        // The token format we generate earlier is embedded in the payload as URL params
        // Try to parse it if the token is a full URL or a raw token.
        $payload = null;
        $user = null;

        // If token looks like a URL with query params, try to parse user and t
        try {
            $u = parse_url($token);
            if (isset($u['query'])) {
                parse_str($u['query'], $qs);
                if (isset($qs['user'])) {
                    // If a token (t) is present in the URL, validate it against stored user_details
                    if (isset($qs['t'])) {
                        $ud = UserDetails::where('user_id', $qs['user'])->first();
                        if (! $ud) {
                            return response()->json(['message' => 'Token not recognized'], 404);
                        }

                        // Ensure token matches
                        if (! isset($ud->qr_token) || $ud->qr_token !== $qs['t']) {
                            return response()->json(['message' => 'Token not recognized'], 404);
                        }

                        // Check expiry if available
                        if (Schema::hasColumn('user_details', 'qr_expires_at') && $ud->qr_expires_at) {
                            try {
                                $expires = \Carbon\Carbon::parse($ud->qr_expires_at);
                                if ($expires->isPast()) {
                                    return response()->json(['message' => 'Token expired', 'expired' => true], 410);
                                }
                            } catch (\Throwable $e) {
                                // ignore parse errors and continue
                            }
                        }

                        $user = User::find($qs['user']);
                        $payload = $qs;
                    } else {
                        // If URL does not include the token param, treat as invalid token
                        return response()->json(['message' => 'Token not recognized'], 404);
                    }
                }
            }
        } catch (\Throwable $e) {
            // ignore parse errors, continue to raw search
        }

        // If not found, try matching token against user_details.qr_token
        if (! $user) {
            $ud = UserDetails::where('qr_token', $token)->first();
            if ($ud) {
                // check expiry if present
                if (Schema::hasColumn('user_details', 'qr_expires_at') && $ud->qr_expires_at) {
                    try {
                        $expires = \Carbon\Carbon::parse($ud->qr_expires_at);
                        if ($expires->isPast()) {
                            return response()->json(['message' => 'Token expired', 'expired' => true], 410);
                        }
                    } catch (\Throwable $e) {
                        // ignore parse errors
                    }
                }

                $user = User::find($ud->user_id);
                $payload = ['user' => $ud->user_id, 'token' => $token];
            }
        }

        if (! $user) {
            return response()->json(['message' => 'Token not recognized'], 404);
        }

        // Build enriched response similar to what the mobile app expects
        $details = $user->userDetails ?? $user->details ?? null;
        $vehicles = [];
        try {
            $vehicles = $user->vehicles ?? [];
        } catch (\Throwable $e) {
            // ignore if relation missing
        }

        return response()->json([
            'data' => [
                'user' => $user,
                'payload' => $payload,
                'userDetail' => $details,
                'vehicles' => $vehicles,
            ]
        ]);
    }

    /**
     * Serve QR file directly from public storage when requested by filename
     * GET /api/qr/{filename}
     */
    public function showFile($filename)
    {
    $path = 'qrs/' . $filename;
        if (! Storage::disk('public')->exists($path)) {
            return response()->json(['message' => 'File not found'], 404);
        }

        return response()->file(storage_path('app/public/' . $path));
    }
}
