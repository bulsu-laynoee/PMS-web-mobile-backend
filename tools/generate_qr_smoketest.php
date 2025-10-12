<?php
// Simple smoke test: fetch an SVG QR from QuickChart and save to storage/app/public/qr
// Run: php tools/generate_qr_smoketest.php

$payload = isset($argv[1]) ? $argv[1] : 'test:user:1';
$chartUrl = 'https://quickchart.io/qr?text=' . urlencode($payload) . '&ecLevel=M&size=400&format=svg';

echo "Requesting QR SVG from QuickChart for payload: $payload\n";
$svg = @file_get_contents($chartUrl);
if ($svg === false) {
    $err = error_get_last();
    echo "Failed to fetch QR SVG: " . ($err['message'] ?? 'unknown') . "\n";
    exit(2);
}

$dir = __DIR__ . '/../storage/app/public/qr';
if (!is_dir($dir)) {
    if (!mkdir($dir, 0755, true)) {
        echo "Failed to create directory: $dir\n";
        exit(3);
    }
}

$filename = 'smoke_qr_' . time() . '.svg';
$path = $dir . DIRECTORY_SEPARATOR . $filename;
if (file_put_contents($path, $svg) === false) {
    echo "Failed to write file: $path\n";
    exit(4);
}

echo "Wrote QR SVG to: $path\n";
// Print first 10 lines for quick inspection
$lines = preg_split('/\r?\n/', $svg);
echo "--- SVG preview (first 10 lines) ---\n";
for ($i = 0; $i < min(10, count($lines)); $i++) {
    echo $lines[$i] . "\n";
}

echo "Smoke test completed successfully.\n";
