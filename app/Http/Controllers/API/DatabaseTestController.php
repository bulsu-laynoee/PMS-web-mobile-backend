<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Exception;

class DatabaseTestController extends Controller
{
    /**
     * Test database connection and return system info
     */
    public function testConnection()
    {
        try {
            // Test basic database connection
            $connection = DB::connection();
            $pdo = $connection->getPdo();
            
            // Get database info
            $dbName = DB::select('SELECT DATABASE() as db_name')[0]->db_name;
            $dbUser = DB::select('SELECT USER() as db_user')[0]->db_user;
            $dbTime = DB::select('SELECT NOW() as db_time')[0]->db_time;
            
            // Get table count
            $tables = DB::select('SHOW TABLES');
            $tableCount = count($tables);
            
            // Get Laravel tables if they exist
            $laravelTables = [];
            $commonTables = ['users', 'vehicles', 'parking_slots', 'violations', 'payments', 'migrations'];
            
            foreach ($commonTables as $table) {
                try {
                    $count = DB::table($table)->count();
                    $laravelTables[$table] = $count;
                } catch (Exception $e) {
                    $laravelTables[$table] = 'Not found';
                }
            }
            
            return response()->json([
                'status' => 'success',
                'message' => 'Database connection successful',
                'database_info' => [
                    'database_name' => $dbName,
                    'database_user' => $dbUser,
                    'server_time' => $dbTime,
                    'total_tables' => $tableCount,
                    'laravel_tables' => $laravelTables
                ],
                'environment' => [
                    'app_env' => config('app.env'),
                    'app_debug' => config('app.debug'),
                    'app_url' => config('app.url'),
                    'db_connection' => config('database.default'),
                    'db_host' => config('database.connections.mysql.host'),
                    'db_database' => config('database.connections.mysql.database')
                ]
            ], 200);
            
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Database connection failed',
                'error' => $e->getMessage(),
                'error_code' => $e->getCode(),
                'environment' => [
                    'app_env' => config('app.env'),
                    'app_debug' => config('app.debug'),
                    'app_url' => config('app.url'),
                    'db_connection' => config('database.default'),
                    'db_host' => config('database.connections.mysql.host'),
                    'db_database' => config('database.connections.mysql.database')
                ]
            ], 500);
        }
    }
    
    /**
     * Simple health check endpoint
     */
    public function healthCheck()
    {
        return response()->json([
            'status' => 'healthy',
            'timestamp' => now(),
            'server' => $_SERVER['SERVER_NAME'] ?? 'unknown',
            'php_version' => PHP_VERSION,
            'laravel_version' => app()->version()
        ], 200);
    }
}