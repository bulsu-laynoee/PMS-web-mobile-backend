# PMS Production Deployment Script for Windows
# Run this script on your Windows hosting server after uploading files

Write-Host "🚀 Starting PMS Production Deployment..." -ForegroundColor Green

# Check if we're in the right directory
if (-Not (Test-Path "artisan")) {
    Write-Host "❌ Laravel artisan file not found. Make sure you're in the Laravel root directory." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found Laravel installation" -ForegroundColor Green

# Check PHP version
$phpVersion = php -v | Select-String "PHP" | ForEach-Object { $_.ToString() }
Write-Host "✅ PHP Version: $($phpVersion.Split(' ')[1])" -ForegroundColor Green

# Install/Update Composer dependencies
if (Get-Command composer -ErrorAction SilentlyContinue) {
    Write-Host "✅ Installing Composer dependencies..." -ForegroundColor Green
    composer install --optimize-autoloader --no-dev --no-interaction
} else {
    Write-Host "⚠️  Composer not found. Please install dependencies manually." -ForegroundColor Yellow
}

# Check if .env file exists
if (-Not (Test-Path ".env")) {
    if (Test-Path ".env.production") {
        Write-Host "✅ Copying .env.production to .env" -ForegroundColor Green
        Copy-Item ".env.production" ".env"
    } else {
        Write-Host "❌ .env file not found! Please create one from .env.production template." -ForegroundColor Red
        exit 1
    }
}

# Generate application key if not set
$envContent = Get-Content ".env" -Raw
if ($envContent -notmatch "APP_KEY=base64:") {
    Write-Host "✅ Generating application key..." -ForegroundColor Green
    php artisan key:generate --force
} else {
    Write-Host "✅ Application key already set" -ForegroundColor Green
}

# Clear and cache config
Write-Host "✅ Optimizing application..." -ForegroundColor Green
php artisan optimize:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Create storage symlink
if (-Not (Test-Path "public/storage")) {
    Write-Host "✅ Creating storage symlink..." -ForegroundColor Green
    php artisan storage:link
} else {
    Write-Host "✅ Storage symlink already exists" -ForegroundColor Green
}

# Run database migrations (optional)
$runMigrations = Read-Host "Do you want to run database migrations? (y/n)"
if ($runMigrations -eq "y" -or $runMigrations -eq "Y") {
    Write-Host "✅ Running database migrations..." -ForegroundColor Green
    php artisan migrate --force
}

# Check critical directories
Write-Host "✅ Checking critical directories..." -ForegroundColor Green

$directories = @(
    "storage/app",
    "storage/logs", 
    "storage/framework/cache",
    "storage/framework/sessions",
    "storage/framework/views",
    "bootstrap/cache"
)

foreach ($dir in $directories) {
    if (-Not (Test-Path $dir)) {
        Write-Host "⚠️  Creating missing directory: $dir" -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
}

# Test database connection
Write-Host "✅ Testing database connection..." -ForegroundColor Green
try {
    php artisan tinker --execute="echo 'Database connection: ' . (DB::connection()->getPdo() ? 'OK' : 'FAILED');"
    Write-Host "✅ Database connection successful" -ForegroundColor Green
} catch {
    Write-Host "❌ Database connection failed! Check your .env settings." -ForegroundColor Red
}

# Final checks
Write-Host "✅ Running final system checks..." -ForegroundColor Green

# Check if storage is writable
try {
    New-Item -ItemType File -Path "storage/test-write.tmp" -Force | Out-Null
    Remove-Item "storage/test-write.tmp" -Force
    Write-Host "✅ Storage directory is writable" -ForegroundColor Green
} catch {
    Write-Host "❌ Storage directory is not writable! Fix permissions." -ForegroundColor Red
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "🎉 PMS Deployment Complete!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Test your application in a web browser"
Write-Host "2. Login to admin panel and verify functionality"
Write-Host "3. Test user registration and file uploads"
Write-Host "4. Set up SSL certificate (HTTPS)"
Write-Host "5. Configure regular database backups"
Write-Host ""
Write-Host "Important URLs:" -ForegroundColor Yellow
Write-Host "• Admin Panel: https://your-domain.com/admin"
Write-Host "• API Endpoint: https://your-domain.com/api"
Write-Host "• Storage Files: https://your-domain.com/storage"
Write-Host ""
Write-Host "🔐 Security Reminders:" -ForegroundColor Yellow
Write-Host "• Change default admin passwords"
Write-Host "• Enable HTTPS (SSL)"
Write-Host "• Set up regular database backups"
Write-Host "• Monitor error logs: storage/logs/laravel.log"
Write-Host ""
Write-Host "✅ Deployment completed successfully!" -ForegroundColor Green