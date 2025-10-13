# PMS Deployment Script with Storage Link Fallback (PowerShell)
# This script handles the storage:link issue on shared hosting

Write-Host "🚀 Starting PMS Deployment..." -ForegroundColor Green
Write-Host "================================"

# Step 1: Install dependencies
Write-Host "📦 Installing Composer dependencies..." -ForegroundColor Yellow
composer install --optimize-autoloader --no-dev

# Step 2: Clear caches
Write-Host "🧹 Clearing caches..." -ForegroundColor Yellow
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Step 3: Optimize for production
Write-Host "⚡ Optimizing for production..." -ForegroundColor Yellow
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Step 4: Try storage:link (might fail on shared hosting)
Write-Host "🔗 Attempting storage:link..." -ForegroundColor Yellow
$storageLinkSucceeded = $false

try {
    php artisan storage:link 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Storage link created successfully" -ForegroundColor Green
        $storageMethod = "symlink"
        $storageLinkSucceeded = $true
    }
} catch {
    # Continue to fallback
}

if (-not $storageLinkSucceeded) {
    Write-Host "⚠️  Storage link failed - using fallback method" -ForegroundColor Yellow
    $storageMethod = "fallback"
    
    # Create storage directory structure if it doesn't exist
    $directories = @(
        "storage\app\public\profile_pics",
        "storage\app\public\or_cr",
        "storage\app\public\parking-layouts",
        "storage\app\public\incidents",
        "storage\app\public\qr"
    )
    
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -Path $dir -ItemType Directory -Force | Out-Null
        }
    }
    
    Write-Host "📁 Created storage directories manually" -ForegroundColor Green
}

# Step 5: Test database connection
Write-Host "🗄️  Testing database connection..." -ForegroundColor Yellow
try {
    php artisan migrate:status | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Database connection successful" -ForegroundColor Green
    } else {
        throw "Database connection failed"
    }
} catch {
    Write-Host "❌ Database connection failed - check your .env file" -ForegroundColor Red
    exit 1
}

# Step 6: Run any pending migrations
Write-Host "📊 Running database migrations..." -ForegroundColor Yellow
php artisan migrate --force

# Step 7: Final deployment checks
Write-Host "🧪 Running deployment checks..." -ForegroundColor Yellow

# Check if app key is set
$envContent = Get-Content .env -Raw
if ($envContent -match "APP_KEY=base64:") {
    Write-Host "✅ APP_KEY is set" -ForegroundColor Green
} else {
    Write-Host "❌ APP_KEY not set - run: php artisan key:generate" -ForegroundColor Red
}

# Test storage accessibility
if ($storageMethod -eq "symlink") {
    if (Test-Path "public\storage") {
        Write-Host "✅ Storage symlink is working" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Storage symlink verification failed" -ForegroundColor Yellow
    }
} else {
    Write-Host "ℹ️  Using fallback file serving (routes: /api/storage/{path})" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "🎉 PMS Deployment Complete!" -ForegroundColor Green
Write-Host "================================"
Write-Host ""
Write-Host "📋 Post-deployment checklist:" -ForegroundColor Yellow
Write-Host "1. Test admin login at: https://bulsupms.com/admin"
Write-Host "2. Test API endpoints: https://bulsupms.com/api/check-storage-link"
Write-Host "3. Test file uploads (profile pics, OR/CR documents)"
Write-Host "4. Verify QR code generation works"
Write-Host "5. Test mobile app connectivity"
Write-Host ""

if ($storageMethod -eq "fallback") {
    Write-Host "⚠️  IMPORTANT: Storage symlink failed!" -ForegroundColor Yellow
    Write-Host "Your files will be served via: /api/storage/{path}"
    Write-Host "This is normal on shared hosting and will work fine."
    Write-Host ""
}

Write-Host "🔍 Storage method used: $storageMethod" -ForegroundColor Cyan
Write-Host "✅ Deployment complete!" -ForegroundColor Green