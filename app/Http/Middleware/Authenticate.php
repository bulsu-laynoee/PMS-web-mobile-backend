<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        // For API requests or if no login route exists, return null
        // This will cause a 401 Unauthorized response instead of redirect
        if ($request->expectsJson() || !$request->is('web/*')) {
            return null;
        }
        
        // For web requests, check if login route exists
        try {
            return route('login');
        } catch (\Exception $e) {
            // If login route doesn't exist, return null for 401 response
            return null;
        }
    }
}
