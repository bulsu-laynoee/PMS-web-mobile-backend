# PowerShell script to update server with correct database credentials
Write-Host "=== PMS Quick Deployment Script ===" -ForegroundColor Green

# The commands to run on your SSH server
$sshCommands = @"
# Navigate to Laravel directory
cd domains/bulsupms.com/public_html/

# Update .env file with correct credentials
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

# Clear and test
php artisan config:clear
php artisan migrate:status

# If successful, complete deployment
if [ $? -eq 0 ]; then
    echo "✅ Database connected! Running deployment..."
    php artisan migrate --force
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    chmod -R 775 storage/
    chmod -R 775 bootstrap/cache/
    echo "🎉 DEPLOYMENT COMPLETE!"
    echo "Live at: https://bulsupms.com"
else
    echo "❌ Database connection failed!"
fi
"@

Write-Host "SSH Commands to run:" -ForegroundColor Yellow
Write-Host $sshCommands -ForegroundColor Cyan

Write-Host "`n=== Instructions ===" -ForegroundColor Green
Write-Host "1. Copy the commands above" -ForegroundColor White
Write-Host "2. Paste them into your SSH session" -ForegroundColor White
Write-Host "3. Press Enter to execute" -ForegroundColor White
Write-Host "4. Test your site at https://bulsupms.com" -ForegroundColor White