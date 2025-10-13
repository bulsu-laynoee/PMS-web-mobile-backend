# 🚀 PMS Production Hosting Checklist

## Pre-Deployment Preparation

### ✅ Database Export
- [ ] Run `export-database.ps1` to export database
- [ ] Verify all SQL files are created in `database/hosting-export/`
- [ ] Test import on local test database

### ✅ Environment Configuration
- [ ] Copy `.env.production` to production server as `.env`
- [ ] Update database credentials in production `.env`
- [ ] Generate new APP_KEY with `php artisan key:generate`
- [ ] Set APP_DEBUG=false for production
- [ ] Update APP_URL to your domain

### ✅ File Permissions & Storage
- [ ] Set proper permissions on storage/ and bootstrap/cache/
- [ ] Create symbolic link: `php artisan storage:link`
- [ ] Ensure uploads directory exists and is writable

## Hosting Provider Setup

### Database Hosting Options:
1. **Shared Hosting** (cPanel/PHPMyAdmin)
2. **Cloud Database** (AWS RDS, Google Cloud SQL)
3. **VPS/Dedicated** (Self-managed MySQL)

### ✅ Database Setup Steps:
- [ ] Create production database
- [ ] Create database user with appropriate permissions
- [ ] Import SQL files in order:
  1. `01_structure.sql`
  2. `02_core_data.sql`
  3. `03_sample_data.sql` (optional)
- [ ] Verify all tables are created
- [ ] Test database connection

### ✅ Web Server Configuration
- [ ] Upload Laravel files to web root
- [ ] Point domain to `public/` directory
- [ ] Configure `.htaccess` for Apache or Nginx config
- [ ] Enable required PHP extensions:
  - PDO MySQL
  - GD (for image processing)
  - cURL
  - OpenSSL
  - JSON
  - BCMath

### ✅ Laravel Production Setup
```bash
# Run these commands on production server
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force
php artisan storage:link
```

### ✅ Security Checklist
- [ ] Use HTTPS (SSL certificate)
- [ ] Set secure session cookies
- [ ] Configure CORS for frontend domains
- [ ] Disable directory browsing
- [ ] Set up database backups
- [ ] Configure error logging

### ✅ Testing Checklist
- [ ] Test admin login
- [ ] Test user registration
- [ ] Test file uploads (OR/CR, ID photos)
- [ ] Test parking assignment system
- [ ] Test incident reporting
- [ ] Test mobile app API endpoints
- [ ] Test email functionality

## Frontend Deployment

### ✅ React Frontend
- [ ] Update API_BASE_URL to production backend
- [ ] Run `npm run build`
- [ ] Upload build files to hosting
- [ ] Configure routing (single-page app)

### ✅ Mobile App
- [ ] Update API endpoints in mobile app
- [ ] Test on physical devices
- [ ] Build APK/App Store version

## Post-Deployment

### ✅ Monitoring Setup
- [ ] Set up error monitoring (Sentry, Bugsnag)
- [ ] Configure log rotation
- [ ] Set up database backups
- [ ] Monitor server resources

### ✅ DNS & SSL
- [ ] Point domain to hosting server
- [ ] Install SSL certificate
- [ ] Configure HTTPS redirects
- [ ] Update CORS settings

## Hosting Provider Recommendations

### Budget-Friendly Options:
1. **InfinityFree** - Free PHP hosting with MySQL
2. **000webhost** - Free hosting with limitations
3. **Hostinger** - Affordable shared hosting

### Professional Options:
1. **DigitalOcean** - VPS with full control
2. **AWS EC2 + RDS** - Scalable cloud hosting
3. **Heroku** - Easy deployment platform

### Database-Specific Hosting:
1. **PlanetScale** - Serverless MySQL
2. **AWS RDS** - Managed MySQL
3. **Railway** - Database + app hosting

## Troubleshooting Common Issues

### Database Connection Issues:
- Check host, port, username, password
- Verify database exists and user has permissions
- Check for SSL requirements

### File Upload Issues:
- Verify storage directory permissions (755/644)
- Check PHP upload limits (upload_max_filesize, post_max_size)
- Ensure storage:link is created

### CORS Issues:
- Update CORS_ALLOWED_ORIGINS in .env
- Check preflight requests
- Verify API endpoints are accessible

### Performance Issues:
- Enable Laravel caching (config, route, view)
- Optimize database queries
- Use CDN for static files
- Enable gzip compression

## Support & Documentation

### Useful Commands:
```bash
# Check Laravel installation
php artisan about

# Clear all caches
php artisan optimize:clear

# Check database connection
php artisan tinker
> DB::connection()->getPdo();

# View logs
tail -f storage/logs/laravel.log
```

### Emergency Contacts:
- Hosting Support: [Your hosting provider support]
- Database Issues: Check hosting provider documentation
- Laravel Issues: Check official documentation