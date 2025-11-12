<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Response;

class FileController extends Controller
{
    public function serveImage($path)
    {
        // Decode any percent-encoding (handles %2F encoded slashes)
        $decoded = urldecode($path);

        $candidates = [$decoded, $path];

        foreach ($candidates as $candidate) {
            if (!$candidate) continue;
            // normalize: remove leading slash if present
            $candidate = ltrim($candidate, '/');
            // handle values that were accidentally stored with a "public/..." prefix
            if (strpos($candidate, 'public/') === 0) {
                $candidate = substr($candidate, 7);
            }

            $check = 'public/' . $candidate;
            Log::debug('[FileController] serveImage checking path', ['check' => $check]);

            // Primary attempt: use Storage facade (configured disk)
            if (Storage::exists($check)) {
                $file = Storage::get($check);
                $type = Storage::mimeType($check) ?: 'application/octet-stream';
                return response($file, 200)->header('Content-Type', $type);
            }

            // Fallback: try reading directly from storage_path in case storage:link is missing
            $fullPath = storage_path('app/public/' . $candidate);
            Log::debug('[FileController] serveImage storage fallback check', ['fullPath' => $fullPath]);
            try {
                if (File::exists($fullPath)) {
                    $mime = File::mimeType($fullPath) ?: 'application/octet-stream';
                    return Response::file($fullPath, ['Content-Type' => $mime]);
                }
                // Additional fallback: sometimes stored paths differ (singular/plural dirs,
                // host-specific prefixes, or other mismatches). Try to find the file by
                // basename anywhere under storage/app/public and serve the first match.
                $basename = basename($candidate);
                if ($basename) {
                    Log::debug('[FileController] serveImage attempting recursive basename search', ['basename' => $basename]);
                    $root = storage_path('app/public');
                    try {
                        $iterator = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($root));
                        foreach ($iterator as $fileinfo) {
                            if ($fileinfo->isFile() && $fileinfo->getFilename() === $basename) {
                                $found = $fileinfo->getRealPath();
                                Log::debug('[FileController] serveImage found by basename', ['found' => $found]);
                                $mime = File::mimeType($found) ?: 'application/octet-stream';
                                return Response::file($found, ['Content-Type' => $mime]);
                            }
                        }
                    } catch (\Throwable $scanEx) {
                        Log::warning('[FileController] recursive search failed', ['error' => (string)$scanEx]);
                    }
                }
            } catch (\Throwable $ex) {
                Log::warning('[FileController] storage fallback failed', ['path' => $fullPath, 'error' => (string)$ex]);
            }
        }

        return response()->json(['error' => 'Image not found'], 404);
    }
}
