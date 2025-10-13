#!/bin/bash

# PMS Database Export Script for Production Hosting
# This script exports your database structure and data for hosting

echo "=== PMS Database Export for Production Hosting ==="

# Configuration - Update these values
LOCAL_DB_NAME="pms_db"
LOCAL_DB_USER="root"
LOCAL_DB_PASSWORD=""
LOCAL_DB_HOST="localhost"

# Export directory
EXPORT_DIR="./database/hosting-export"
mkdir -p "$EXPORT_DIR"

echo "Step 1: Exporting database structure only..."
mysqldump -h "$LOCAL_DB_HOST" -u "$LOCAL_DB_USER" -p"$LOCAL_DB_PASSWORD" \
  --no-data \
  --routines \
  --triggers \
  --single-transaction \
  "$LOCAL_DB_NAME" > "$EXPORT_DIR/01_structure.sql"

echo "Step 2: Exporting core data (roles, admin users, layouts)..."
mysqldump -h "$LOCAL_DB_HOST" -u "$LOCAL_DB_USER" -p"$LOCAL_DB_PASSWORD" \
  --no-create-info \
  --single-transaction \
  --where="1" \
  "$LOCAL_DB_NAME" roles admin_users parking_layouts > "$EXPORT_DIR/02_core_data.sql"

echo "Step 3: Exporting sample data (optional - for testing)..."
mysqldump -h "$LOCAL_DB_HOST" -u "$LOCAL_DB_USER" -p"$LOCAL_DB_PASSWORD" \
  --no-create-info \
  --single-transaction \
  --where="id <= 5" \
  "$LOCAL_DB_NAME" users user_details vehicles > "$EXPORT_DIR/03_sample_data.sql"

echo "Step 4: Creating complete database dump..."
mysqldump -h "$LOCAL_DB_HOST" -u "$LOCAL_DB_USER" -p"$LOCAL_DB_PASSWORD" \
  --single-transaction \
  --routines \
  --triggers \
  "$LOCAL_DB_NAME" > "$EXPORT_DIR/complete_database.sql"

echo "Step 5: Creating production import script..."
cat > "$EXPORT_DIR/import_to_production.sql" << 'EOF'
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

-- 7. Update app URL in any stored configs (if applicable)
-- UPDATE settings SET value = 'https://your-domain.com' WHERE key = 'app_url';
EOF

echo "✅ Database export completed!"
echo "Files created in: $EXPORT_DIR"
echo ""
echo "Next steps:"
echo "1. Upload the SQL files to your hosting provider"
echo "2. Import them in this order:"
echo "   - 01_structure.sql"
echo "   - 02_core_data.sql"
echo "   - 03_sample_data.sql (optional)"
echo "3. Update your .env file with production database credentials"
echo "4. Run 'php artisan migrate --force' on production if needed"