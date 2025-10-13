#!/bin/bash
# Quick deployment script to update database credentials and test

echo "=== PMS Deployment & Smoke Test ==="
echo "Updating database credentials..."

# Update .env file with correct database credentials
cat > .env << 'EOF'
APP_NAME="PMS - Parking Management System"
APP_ENV=production
APP_KEY=base64:zw2dR+4ONcq1Ibx4ibfWNnnsi5BpuTWNi6Cl8aFXFBg=
APP_DEBUG=false
APP_URL=https://bulsupms.com

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=error

# Hostinger Database Configuration
DB_CONNECTION=mysql
DB_HOST=srv1518.hstgr.io
DB_PORT=3306
DB_DATABASE=u947149485_pms_db
DB_USERNAME=u947149485_pms_db
DB_PASSWORD=&Sg6Viti

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=public
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

# Production Mail Configuration
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=no.reply022123@gmail.com
MAIL_PASSWORD=nbmuydpejasvsdyl
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=no.reply022123@gmail.com
MAIL_FROM_NAME="PMS Support"

# Security Settings
SESSION_SECURE_COOKIE=true
SANCTUM_STATEFUL_DOMAINS=bulsupms.com
SESSION_DOMAIN=bulsupms.com

# File Storage
FILESYSTEM_DISK=public

# CORS Settings
CORS_ALLOWED_ORIGINS=https://bulsupms.com,http://localhost:3000
EOF

echo "✅ Database credentials updated"

# Clear config cache
echo "Clearing configuration cache..."
php artisan config:clear

# Test database connection
echo "Testing database connection..."
php artisan migrate:status

if [ $? -eq 0 ]; then
    echo "✅ Database connection successful!"
    
    # Run migrations if needed
    echo "Running database migrations..."
    php artisan migrate --force
    
    # Cache configurations
    echo "Caching configurations..."
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    
    # Set permissions
    echo "Setting file permissions..."
    chmod -R 775 storage/
    chmod -R 775 bootstrap/cache/
    
    echo ""
    echo "🎉 DEPLOYMENT COMPLETE!"
    echo "Your PMS is now live at: https://bulsupms.com"
    echo ""
    echo "Test endpoints:"
    echo "- API Status: https://bulsupms.com/api/status"
    echo "- Database Test: https://bulsupms.com/api/test-db"
    
else
    echo "❌ Database connection failed!"
    echo "Check the credentials and try again."
fi

echo "=== Deployment Complete ==="