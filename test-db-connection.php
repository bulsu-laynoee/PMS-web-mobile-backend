<?php
/**
 * Database Connection Test Script
 * Upload this file to your server and run it via web browser or CLI
 */

// Test different database configurations
$configs = [
    'Current Config' => [
        'host' => 'srv1518.hstgr.io',
        'port' => '3306',
        'database' => 'u947149485_pms_db',
        'username' => 'u947149485_pms_db',
        'password' => 'Pms_db081'
    ],
    'Alternative Config 1' => [
        'host' => 'srv1518.hstgr.io',
        'port' => '3306',
        'database' => 'u947149485_db',
        'username' => 'u947149485_user',
        'password' => 'r|4s/:qUh5~G'
    ],
    'Alternative Config 2' => [
        'host' => 'srv1518.hstgr.io', 
        'port' => '3306',
        'database' => 'u947149485_pms_db',
        'username' => 'u947149485',
        'password' => 'Pms_db081'
    ]
];

echo "<h1>Database Connection Test</h1>\n";
echo "<pre>\n";

foreach ($configs as $name => $config) {
    echo "=== Testing: $name ===\n";
    echo "Host: {$config['host']}\n";
    echo "Database: {$config['database']}\n";
    echo "Username: {$config['username']}\n";
    echo "Password: " . str_repeat('*', strlen($config['password'])) . "\n";
    
    try {
        $dsn = "mysql:host={$config['host']};port={$config['port']};dbname={$config['database']};charset=utf8mb4";
        $pdo = new PDO($dsn, $config['username'], $config['password'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_TIMEOUT => 10
        ]);
        
        // Test basic query
        $stmt = $pdo->query("SELECT DATABASE() as current_db, USER() as current_user, NOW() as current_time");
        $result = $stmt->fetch();
        
        echo "✅ CONNECTION SUCCESSFUL!\n";
        echo "   Current Database: {$result['current_db']}\n";
        echo "   Current User: {$result['current_user']}\n";
        echo "   Server Time: {$result['current_time']}\n";
        
        // Test table listing
        $stmt = $pdo->query("SHOW TABLES");
        $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
        echo "   Tables in database: " . count($tables) . "\n";
        if (count($tables) > 0) {
            echo "   Table names: " . implode(', ', array_slice($tables, 0, 5)) . (count($tables) > 5 ? '...' : '') . "\n";
        }
        
        $pdo = null; // Close connection
        echo "\n";
        break; // Stop testing once we find a working config
        
    } catch (PDOException $e) {
        echo "❌ CONNECTION FAILED!\n";
        echo "   Error: " . $e->getMessage() . "\n";
        echo "   Error Code: " . $e->getCode() . "\n\n";
    }
}

echo "</pre>\n";

// Also test via command line if running in CLI
if (php_sapi_name() === 'cli') {
    echo "\n=== CLI MySQL Test ===\n";
    foreach ($configs as $name => $config) {
        echo "Testing $name...\n";
        $command = "mysql -h {$config['host']} -P {$config['port']} -u {$config['username']} -p'{$config['password']}' {$config['database']} -e 'SELECT DATABASE(), USER(), NOW();' 2>&1";
        $output = shell_exec($command);
        if (strpos($output, 'ERROR') === false && !empty($output)) {
            echo "✅ MySQL CLI connection successful!\n";
            echo $output . "\n";
            break;
        } else {
            echo "❌ MySQL CLI connection failed:\n";
            echo $output . "\n";
        }
    }
}
?>