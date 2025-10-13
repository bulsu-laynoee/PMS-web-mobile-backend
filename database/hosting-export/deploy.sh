#!/bin/bash

# ========================================
# PMS Production Deployment Script
# ========================================
# Run this script on your production server after uploading files

echo "🚀 Starting PMS Production Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "artisan" ]; then
    print_error "Laravel artisan file not found. Make sure you're in the Laravel root directory."
    exit 1
fi

print_status "Found Laravel installation"

# Check PHP version
PHP_VERSION=$(php -v | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1,2)
print_status "PHP Version: $PHP_VERSION"

# Install/Update Composer dependencies
if command -v composer &> /dev/null; then
    print_status "Installing Composer dependencies..."
    composer install --optimize-autoloader --no-dev --no-interaction
else
    print_warning "Composer not found. Please install dependencies manually."
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    if [ -f ".env.production" ]; then
        print_status "Copying .env.production to .env"
        cp .env.production .env
    else
        print_error ".env file not found! Please create one from .env.production template."
        exit 1
    fi
fi

# Generate application key if not set
if ! grep -q "APP_KEY=base64:" .env; then
    print_status "Generating application key..."
    php artisan key:generate --force
else
    print_status "Application key already set"
fi

# Set proper permissions
print_status "Setting file permissions..."
chmod -R 755 storage bootstrap/cache
chmod -R 644 storage/logs

# Clear and cache config
print_status "Optimizing application..."
php artisan optimize:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Create storage symlink
if [ ! -L "public/storage" ]; then
    print_status "Creating storage symlink..."
    php artisan storage:link
else
    print_status "Storage symlink already exists"
fi

# Run database migrations (optional)
read -p "Do you want to run database migrations? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Running database migrations..."
    php artisan migrate --force
fi

# Check critical directories
print_status "Checking critical directories..."

directories=("storage/app" "storage/logs" "storage/framework/cache" "storage/framework/sessions" "storage/framework/views" "bootstrap/cache")

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        print_warning "Creating missing directory: $dir"
        mkdir -p $dir
        chmod 755 $dir
    fi
done

# Test database connection
print_status "Testing database connection..."
php artisan tinker --execute="echo 'Database connection: ' . (DB::connection()->getPdo() ? 'OK' : 'FAILED');"

# Final checks
print_status "Running final system checks..."

# Check if storage is writable
if [ -w "storage" ]; then
    print_status "Storage directory is writable"
else
    print_error "Storage directory is not writable! Fix permissions."
fi

# Check if bootstrap/cache is writable
if [ -w "bootstrap/cache" ]; then
    print_status "Bootstrap cache directory is writable"
else
    print_error "Bootstrap cache directory is not writable! Fix permissions."
fi

echo ""
echo "========================================="
echo "🎉 PMS Deployment Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Test your application in a web browser"
echo "2. Login to admin panel and verify functionality"
echo "3. Test user registration and file uploads"
echo "4. Set up SSL certificate (HTTPS)"
echo "5. Configure regular database backups"
echo ""
echo "Important URLs:"
echo "• Admin Panel: https://your-domain.com/admin"
echo "• API Endpoint: https://your-domain.com/api"
echo "• Storage Files: https://your-domain.com/storage"
echo ""
echo "🔐 Security Reminders:"
echo "• Change default admin passwords"
echo "• Enable HTTPS (SSL)"  
echo "• Set up regular database backups"
echo "• Monitor error logs: storage/logs/laravel.log"
echo ""
print_status "Deployment completed successfully!"