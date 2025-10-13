#!/bin/bash

# PMS Deployment Script with Storage Link Fallback
# This script handles the storage:link issue on shared hosting

echo "🚀 Starting PMS Deployment..."
echo "================================"

# Step 1: Install dependencies
echo "📦 Installing Composer dependencies..."
composer install --optimize-autoloader --no-dev

# Step 2: Clear caches
echo "🧹 Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Step 3: Optimize for production
echo "⚡ Optimizing for production..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Step 4: Try storage:link (might fail on shared hosting)
echo "🔗 Attempting storage:link..."
if php artisan storage:link 2>/dev/null; then
    echo "✅ Storage link created successfully"
    STORAGE_METHOD="symlink"
else
    echo "⚠️  Storage link failed - using fallback method"
    STORAGE_METHOD="fallback"
    
    # Create storage directory structure if it doesn't exist
    mkdir -p storage/app/public/profile_pics
    mkdir -p storage/app/public/or_cr
    mkdir -p storage/app/public/parking-layouts
    mkdir -p storage/app/public/incidents
    mkdir -p storage/app/public/qr
    
    # Set proper permissions
    chmod -R 755 storage/app/public
    chmod -R 775 storage/logs
    chmod -R 775 bootstrap/cache
    
    echo "📁 Created storage directories manually"
fi

# Step 5: Check file permissions
echo "🔒 Setting file permissions..."
chmod -R 755 storage
chmod -R 755 bootstrap/cache
chmod 644 .env

# Step 6: Test database connection
echo "🗄️  Testing database connection..."
if php artisan migrate:status > /dev/null 2>&1; then
    echo "✅ Database connection successful"
else
    echo "❌ Database connection failed - check your .env file"
    exit 1
fi

# Step 7: Run any pending migrations
echo "📊 Running database migrations..."
php artisan migrate --force

# Step 8: Final deployment checks
echo "🧪 Running deployment checks..."

# Check if app key is set
if grep -q "APP_KEY=base64:" .env; then
    echo "✅ APP_KEY is set"
else
    echo "❌ APP_KEY not set - run: php artisan key:generate"
fi

# Test storage accessibility
if [ "$STORAGE_METHOD" = "symlink" ]; then
    if [ -L "public/storage" ]; then
        echo "✅ Storage symlink is working"
    else
        echo "⚠️  Storage symlink verification failed"
    fi
else
    echo "ℹ️  Using fallback file serving (routes: /api/storage/{path})"
fi

echo ""
echo "🎉 PMS Deployment Complete!"
echo "================================"
echo ""
echo "📋 Post-deployment checklist:"
echo "1. Test admin login at: https://your-domain.com/admin"
echo "2. Test API endpoints: https://your-domain.com/api/check-storage-link"
echo "3. Test file uploads (profile pics, OR/CR documents)"
echo "4. Verify QR code generation works"
echo "5. Test mobile app connectivity"
echo ""

if [ "$STORAGE_METHOD" = "fallback" ]; then
    echo "⚠️  IMPORTANT: Storage symlink failed!"
    echo "Your files will be served via: /api/storage/{path}"
    echo "This is normal on shared hosting and will work fine."
    echo ""
fi

echo "🔍 Storage method used: $STORAGE_METHOD"
echo "✅ Deployment complete!"