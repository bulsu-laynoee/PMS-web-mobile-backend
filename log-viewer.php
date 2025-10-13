<?php
// Simple Log Viewer for Hostinger
// WARNING: Remove this file after debugging for security!

// Password protection
$password = 'capstonePMS081!'; // Change this!
session_start();

if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    if (isset($_POST['password']) && $_POST['password'] === $password) {
        $_SESSION['logged_in'] = true;
    } else {
        ?>
        <!DOCTYPE html>
        <html>
        <head><title>Log Viewer - Authentication</title></head>
        <body>
            <h2>Enter Password</h2>
            <form method="post">
                <input type="password" name="password" required>
                <button type="submit">Login</button>
            </form>
        </body>
        </html>
        <?php
        exit;
    }
}

$logType = $_GET['type'] ?? 'laravel';
$lines = $_GET['lines'] ?? 100;

// Define log file paths
$logFiles = [
    'laravel' => __DIR__ . '/storage/logs/laravel.log',
    'php' => '/opt/alt/php82/var/log/php-error.log',
    'error' => __DIR__ . '/../logs/error.log',
    'access' => __DIR__ . '/../logs/access.log'
];

function tailFile($file, $lines = 100) {
    if (!file_exists($file)) {
        return "Log file not found: $file";
    }
    
    $handle = fopen($file, 'r');
    if (!$handle) {
        return "Cannot open log file: $file";
    }
    
    // Get file size
    fseek($handle, 0, SEEK_END);
    $fileSize = ftell($handle);
    
    // Read from end of file
    $pos = $fileSize;
    $lineCount = 0;
    $text = '';
    
    while ($pos > 0 && $lineCount < $lines) {
        $pos--;
        fseek($handle, $pos);
        $char = fgetc($handle);
        
        if ($char === "\n") {
            $lineCount++;
        }
        
        $text = $char . $text;
    }
    
    fclose($handle);
    return $text;
}

?>
<!DOCTYPE html>
<html>
<head>
    <title>PMS Backend Log Viewer</title>
    <style>
        body { font-family: monospace; margin: 20px; }
        .nav { margin-bottom: 20px; }
        .nav a { margin-right: 15px; padding: 5px 10px; background: #f0f0f0; text-decoration: none; }
        .nav a.active { background: #007cba; color: white; }
        .log-content { background: #000; color: #0f0; padding: 15px; overflow-x: auto; max-height: 80vh; overflow-y: auto; }
        .error { color: #ff6b6b; }
        .warning { color: #feca57; }
        .info { color: #48dbfb; }
        .controls { margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>PMS Backend Log Viewer</h1>
    
    <div class="nav">
        <a href="?type=laravel" <?= $logType === 'laravel' ? 'class="active"' : '' ?>>Laravel Logs</a>
        <a href="?type=php" <?= $logType === 'php' ? 'class="active"' : '' ?>>PHP Errors</a>
        <a href="?type=error" <?= $logType === 'error' ? 'class="active"' : '' ?>>Server Errors</a>
        <a href="?type=access" <?= $logType === 'access' ? 'class="active"' : '' ?>>Access Logs</a>
    </div>
    
    <div class="controls">
        <form method="get" style="display: inline;">
            <input type="hidden" name="type" value="<?= htmlspecialchars($logType) ?>">
            <label>Lines: </label>
            <select name="lines" onchange="this.form.submit()">
                <option value="50" <?= $lines == 50 ? 'selected' : '' ?>>50</option>
                <option value="100" <?= $lines == 100 ? 'selected' : '' ?>>100</option>
                <option value="200" <?= $lines == 200 ? 'selected' : '' ?>>200</option>
                <option value="500" <?= $lines == 500 ? 'selected' : '' ?>>500</option>
            </select>
        </form>
        
        <a href="?type=<?= $logType ?>&lines=<?= $lines ?>&refresh=1" style="margin-left: 15px;">🔄 Refresh</a>
        <a href="?logout=1" style="margin-left: 15px; color: red;">Logout</a>
    </div>
    
    <div class="log-content">
        <pre><?php
        if (isset($_GET['logout'])) {
            session_destroy();
            header('Location: ' . strtok($_SERVER['REQUEST_URI'], '?'));
            exit;
        }
        
        $logFile = $logFiles[$logType] ?? $logFiles['laravel'];
        echo htmlspecialchars(tailFile($logFile, $lines));
        ?></pre>
    </div>
    
    <script>
        // Auto-refresh every 30 seconds if user is viewing
        setTimeout(() => location.reload(), 30000);
        
        // Scroll to bottom
        document.querySelector('.log-content').scrollTop = document.querySelector('.log-content').scrollHeight;
    </script>
</body>
</html>