<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Controller;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Response;

class FileStorageController extends Controller
{
    /**
     * Alternative to storage:link for shared hosting
     * Serves files from storage/app/public directly via PHP
     */
    public function serveFile($path)
    {
        $fullPath = storage_path('app/public/' . $path);
        
        // Security check - prevent directory traversal
        if (!File::exists($fullPath) || strpos(realpath($fullPath), storage_path('app/public')) !== 0) {
            abort(404);
        }
        
        $mimeType = File::mimeType($fullPath);
        $fileSize = File::size($fullPath);
        
        return Response::file($fullPath, [
            'Content-Type' => $mimeType,
            'Content-Length' => $fileSize,
            'Cache-Control' => 'public, max-age=3600',
        ]);
    }
    
    /**
     * Check if storage link exists and create alternative route if needed
     */
    public function checkStorageLink()
    {
        $linkPath = public_path('storage');
        $targetPath = storage_path('app/public');
        
        if (is_link($linkPath) && readlink($linkPath) === $targetPath) {
            return response()->json(['status' => 'symlink_exists', 'message' => 'Storage symlink is working']);
        }
        
        if (is_dir($linkPath) && !is_link($linkPath)) {
            return response()->json(['status' => 'directory_exists', 'message' => 'Storage directory exists (not symlink)']);
        }
        
        return response()->json(['status' => 'no_link', 'message' => 'Storage link does not exist - using fallback routes']);
    }
}