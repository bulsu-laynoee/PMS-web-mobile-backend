<?php
/**
 * PMS Database Connection Test
 * Use this script to test your hosted database connection
 */

// ==========================================
// STEP 1: YOUR HOSTINGER DATABASE DETAILS
// ==========================================
$host = '194.59.164.13';               // Hostinger MySQL IP address
// Alternative hostname: srv1518.hstgr.io
$port = '3306';                         // Standard MySQL port
$database = 'u947149485_pms_db';        // Your database name
$username = 'u947149485_pms_db';        // Your database username
$password = 'Pms_db081';                // Your database password

// ==========================================
// STEP 2: RUN THIS SCRIPT TO TEST CONNECTION
// ==========================================

echo "🔍 Testing PMS Database Connection...\n";
echo "=====================================\n";

try {
    // Create PDO connection
    $dsn = "mysql:host=$host;port=$port;dbname=$database;charset=utf8mb4";
    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ];
    
    $pdo = new PDO($dsn, $username, $password, $options);
    
    echo "✅ Database connection successful!\n\n";
    
    // Test 1: Check if tables exist
    echo "📋 Checking database tables...\n";
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    $expectedTables = [
        'users', 'roles', 'user_details', 'vehicles', 
        'parking_assignments', 'parking_layouts', 'parking_slots',
        'incidents', 'messages', 'notifications'
    ];
    
    echo "Found " . count($tables) . " tables:\n";
    foreach ($tables as $table) {
        $isExpected = in_array($table, $expectedTables) ? "✅" : "ℹ️";
        echo "  $isExpected $table\n";
    }
    echo "\n";
    
    // Test 2: Check users table
    echo "👥 Checking users data...\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
    $userCount = $stmt->fetch()['count'];
    echo "  Users in database: $userCount\n";
    
    if ($userCount > 0) {
        $stmt = $pdo->query("SELECT id, email, role_id FROM users LIMIT 3");
        $users = $stmt->fetchAll();
        echo "  Sample users:\n";
        foreach ($users as $user) {
            echo "    - ID: {$user['id']}, Email: {$user['email']}, Role: {$user['role_id']}\n";
        }
    }
    echo "\n";
    
    // Test 3: Check roles table
    echo "🎭 Checking roles data...\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM roles");
    $roleCount = $stmt->fetch()['count'];
    echo "  Roles in database: $roleCount\n";
    
    if ($roleCount > 0) {
        $stmt = $pdo->query("SELECT id, name FROM roles");
        $roles = $stmt->fetchAll();
        echo "  Available roles:\n";
        foreach ($roles as $role) {
            echo "    - ID: {$role['id']}, Name: {$role['name']}\n";
        }
    }
    echo "\n";
    
    // Test 4: Check vehicles table
    echo "🚗 Checking vehicles data...\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM vehicles");
    $vehicleCount = $stmt->fetch()['count'];
    echo "  Vehicles in database: $vehicleCount\n\n";
    
    // Test 5: Check parking slots
    echo "🅿️ Checking parking data...\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM parking_slots");
    $slotCount = $stmt->fetch()['count'];
    echo "  Parking slots in database: $slotCount\n\n";
    
    // Test 6: Check incidents
    echo "🚨 Checking incidents data...\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM incidents");
    $incidentCount = $stmt->fetch()['count'];
    echo "  Incidents in database: $incidentCount\n\n";
    
    // Summary
    echo "📊 DATABASE SUMMARY\n";
    echo "==================\n";
    echo "✅ Connection: Working\n";
    echo "📋 Tables: " . count($tables) . " found\n";
    echo "👥 Users: $userCount\n";
    echo "🎭 Roles: $roleCount\n";
    echo "🚗 Vehicles: $vehicleCount\n";
    echo "🅿️ Parking Slots: $slotCount\n";
    echo "🚨 Incidents: $incidentCount\n\n";
    
    echo "🎉 Your PMS database is ready to use!\n";
    echo "Next step: Update your Laravel .env file with these connection details.\n";
    
} catch(PDOException $e) {
    echo "❌ Database connection failed!\n";
    echo "Error: " . $e->getMessage() . "\n\n";
    
    echo "🔧 Troubleshooting Tips:\n";
    echo "1. Double-check your connection details\n";
    echo "2. Verify the database service is running\n";
    echo "3. Check if your IP is whitelisted\n";
    echo "4. Ensure the database was imported correctly\n";
    echo "5. Try using SSL connection if required\n";
}
?>