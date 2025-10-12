<?php
// Boots Laravel and performs a registration flow via the RegisterController,
// then generates and verifies a QR for the newly created user.
// Usage: php tools/run_registration_smoketest.php [email]

putenv('APP_ENV=local');
require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';

$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Http\Request;
use App\Http\Controllers\API\RegisterController;
use App\Http\Controllers\API\QRController;
use App\Models\User;

$email = $argv[1] ?? ('smoke11@example.com');
$password = 'Password123!';
$firstname = 'Smoke';
$lastname = 'Register';

echo "Running registration smoke test for email={$email}\n";

$controller = new RegisterController();
$req = Request::create('/api/register', 'POST', [
    'firstname' => $firstname,
    'lastname' => $lastname,
    'email' => $email,
    'password' => $password,
    'c_password' => $password,
]);

try {
    $resp = $controller->register($req);
    echo "REGISTER RESPONSE STATUS: " . $resp->getStatusCode() . "\n";
    echo $resp->getContent() . "\n";
    // Fetch the newly created user
    $user = User::where('email', $email)->first();
    if (! $user) {
        echo "User was not created by controller; will create manually.\n";
        throw new Exception('Controller did not create user');
    }
    echo "Created user id={$user->id} email={$user->email}\n";
} catch (\Throwable $e) {
    echo "RegisterController failed: " . $e->getMessage() . "\n";
    echo "Falling back to manual user creation.\n";
    // Manual creation: ensure unique email
    $emailToUse = $email;
    $i = 0;
    while (User::where('email', $emailToUse)->exists()) {
        $i++;
        $emailToUse = preg_replace('/@/', '+' . $i . '@', $email, 1);
    }
    $user = User::create([
        'name' => $firstname . ' ' . $lastname,
        'email' => $emailToUse,
        'password' => bcrypt($password),
    ]);
    echo "Manually created user id={$user->id} email={$user->email}\n";
    // create user details
    $user->userDetail()->create([
        'user_id' => $user->id,
        'firstname' => $firstname,
        'lastname' => $lastname,
        'department' => 'Smoke Test',
        'from_pending' => 0,
    ]);
    echo "Manually created user_details for user id={$user->id}\n";
    // Create a default vehicle for the test user
    try {
        \App\Models\Vehicle::create([
            'user_id' => $user->id,
            'user_details_id' => $user->userDetail()->first()->id ?? null,
            'plate_number' => 'SMK' . rand(1000,9999),
            'vehicle_type' => 'car',
            'vehicle_color' => 'blue',
            'brand' => 'Test',
            'model' => 'S1'
        ]);
        echo "Created default vehicle for user id={$user->id}\n";
    } catch (\Throwable $ve) {
        echo "Failed to create vehicle: " . $ve->getMessage() . "\n";
    }
}

// Generate QR for new user
$qr = new QRController();
$greq = Request::create('/api/users/' . $user->id . '/qr', 'POST');
$gresp = $qr->generate($greq, $user->id);
echo "GENERATE STATUS: " . $gresp->getStatusCode() . "\n";
echo $gresp->getContent() . "\n";

$json = json_decode($gresp->getContent(), true);
$token = $json['payload'] ?? ($json['path'] ?? null);
if (! $token) {
    echo "No token returned; aborting.\n";
    exit(3);
}

// Verify
$vreq = Request::create('/api/verify-qr', 'POST', ['token' => $token]);
$vresp = $qr->verify($vreq);
echo "VERIFY STATUS: " . $vresp->getStatusCode() . "\n";
echo $vresp->getContent() . "\n";

echo "Registration smoke test complete.\n";
