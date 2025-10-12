<?php
// Boots the Laravel app and runs a full QR generation + verify smoke test.
// Usage: php tools/run_qr_full_smoketest.php [user_id]

putenv('APP_ENV=local');
require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';

$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;
use App\Models\UserDetails;
use App\Models\Vehicle;
use App\Http\Controllers\API\QRController;
use Illuminate\Http\Request;

$uid = isset($argv[1]) ? intval($argv[1]) : 3;
echo "Starting full QR smoke test for user_id={$uid}\n";

$user = User::find($uid);
if (! $user) {
    echo "User id={$uid} not found. Aborting.\n";
    exit(2);
}
echo "Found user: {$user->id} {$user->email}\n";

$details = $user->userDetails ?? $user->userDetail ?? null;
if (! $details) {
    $details = new UserDetails();
    $details->user_id = $user->id;
    $details->firstname = 'Smoke';
    $details->lastname = 'Tester';
    $details->department = 'IT';
    $details->from_pending = 0;
    $details->save();
    echo "Created user_details id={$details->id}\n";
} else {
    echo "UserDetails exists id={$details->id}\n";
}

$veh = Vehicle::where('user_id', $user->id)->first();
if (! $veh) {
    $veh = Vehicle::create([
        'user_id' => $user->id,
        'plate_number' => 'SMK' . rand(100,999),
        'vehicle_type' => 'car',
        'brand' => 'Test',
        'model' => 'S1',
        'vehicle_color' => 'blue'
    ]);
    echo "Created vehicle id={$veh->id} plate={$veh->plate_number}\n";
} else {
    echo "Vehicle exists id={$veh->id} plate={$veh->plate_number}\n";
}

$ctrl = new QRController();
$req = new Request();
// call generate
$resp = $ctrl->generate($req, $user->id);
echo "GENERATE HTTP STATUS: " . $resp->getStatusCode() . "\n";
$content = $resp->getContent();
echo "GENERATE RESPONSE: \n" . $content . "\n";

$json = json_decode($content, true);
$token = $json['payload'] ?? ($json['path'] ?? null);
echo "TOKEN/PAYLOAD: " . ($token ?? '[none]') . "\n";

if ($token) {
    // Pass token as a query parameter so input('token') will retrieve it
    $req2 = new Request(['token' => $token], []);
    $verify = $ctrl->verify($req2);
    echo "VERIFY HTTP STATUS: " . $verify->getStatusCode() . "\n";
    echo "VERIFY RESPONSE: \n" . $verify->getContent() . "\n";
} else {
    echo "No token/payload to verify.\n";
}

echo "Full smoke test complete.\n";
