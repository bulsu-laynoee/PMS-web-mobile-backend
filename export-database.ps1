# PMS Database Export Script for Production Hosting (Windows PowerShell)
# This script exports your database structure and data for hosting

Write-Host "=== PMS Database Export for Production Hosting ===" -ForegroundColor Green

# Configuration - Update these values
$LOCAL_DB_NAME = "pms_db"
$LOCAL_DB_USER = "root"
$LOCAL_DB_PASSWORD = ""
$LOCAL_DB_HOST = "localhost"

# Export directory
$EXPORT_DIR = "./database/hosting-export"
New-Item -ItemType Directory -Force -Path $EXPORT_DIR | Out-Null

Write-Host "Step 1: Exporting database structure only..." -ForegroundColor Yellow
$cmd1 = "mysqldump -h $LOCAL_DB_HOST -u $LOCAL_DB_USER"
if ($LOCAL_DB_PASSWORD) { $cmd1 += " -p$LOCAL_DB_PASSWORD" }
$cmd1 += " --no-data --routines --triggers --single-transaction $LOCAL_DB_NAME"
Invoke-Expression "$cmd1 > $EXPORT_DIR/01_structure.sql"

Write-Host "Step 2: Exporting core data (roles, admin users, layouts)..." -ForegroundColor Yellow
$cmd2 = "mysqldump -h $LOCAL_DB_HOST -u $LOCAL_DB_USER"
if ($LOCAL_DB_PASSWORD) { $cmd2 += " -p$LOCAL_DB_PASSWORD" }
$cmd2 += " --no-create-info --single-transaction --where=`"1`" $LOCAL_DB_NAME roles admin_users parking_layouts"
Invoke-Expression "$cmd2 > $EXPORT_DIR/02_core_data.sql"

Write-Host "Step 3: Exporting sample data (optional)..." -ForegroundColor Yellow
$cmd3 = "mysqldump -h $LOCAL_DB_HOST -u $LOCAL_DB_USER"
if ($LOCAL_DB_PASSWORD) { $cmd3 += " -p$LOCAL_DB_PASSWORD" }
$cmd3 += " --no-create-info --single-transaction --where=`"id <= 5`" $LOCAL_DB_NAME users user_details vehicles"
Invoke-Expression "$cmd3 > $EXPORT_DIR/03_sample_data.sql"

Write-Host "Step 4: Creating complete database dump..." -ForegroundColor Yellow
$cmd4 = "mysqldump -h $LOCAL_DB_HOST -u $LOCAL_DB_USER"
if ($LOCAL_DB_PASSWORD) { $cmd4 += " -p$LOCAL_DB_PASSWORD" }
$cmd4 += " --single-transaction --routines --triggers $LOCAL_DB_NAME"
Invoke-Expression "$cmd4 > $EXPORT_DIR/complete_database.sql"

Write-Host "Step 5: Creating production import instructions..." -ForegroundColor Yellow
@"
-- PMS Production Database Import Script
-- Run these commands in your production MySQL database

-- 1. Create database (if not exists)
CREATE DATABASE IF NOT EXISTS your_production_database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE your_production_database;

-- 2. Import structure
SOURCE 01_structure.sql;

-- 3. Import core data
SOURCE 02_core_data.sql;

-- 4. (Optional) Import sample data for testing
-- SOURCE 03_sample_data.sql;

-- 5. Verify tables
SHOW TABLES;

-- 6. Check if admin user exists
SELECT id, name, email, role_id FROM users WHERE role_id = 1 LIMIT 1;
"@ | Out-File -FilePath "$EXPORT_DIR/import_instructions.sql" -Encoding UTF8

Write-Host "✅ Database export completed!" -ForegroundColor Green
Write-Host "Files created in: $EXPORT_DIR" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Upload the SQL files to your hosting provider"
Write-Host "2. Import them in order: structure -> core_data -> sample_data"
Write-Host "3. Update your .env file with production database credentials"
Write-Host "4. Run 'php artisan key:generate' and 'php artisan config:cache'"