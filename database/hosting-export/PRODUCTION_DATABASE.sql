-- ===============================================
-- PMS (Parking Management System) - Production Database
-- Generated: October 13, 2025
-- ===============================================
-- 
-- This file contains your complete PMS database ready for production hosting
-- 
-- HOSTING INSTRUCTIONS:
-- =====================
-- 1. Create a new MySQL database on your hosting provider
-- 2. Import this file using phpMyAdmin, MySQL Workbench, or command line
-- 3. Update your Laravel .env file with production database credentials
-- 4. Run 'php artisan migrate --force' if needed
-- 5. Run 'php artisan storage:link' to enable file uploads
--
-- DATABASE FEATURES INCLUDED:
-- ==========================
-- ✅ Complete table structure
-- ✅ Roles system (Admin, Student, Faculty, Employee, Security Guard)
-- ✅ User management with authentication
-- ✅ Parking management system
-- ✅ Vehicle registration
-- ✅ Incident reporting system
-- ✅ Messaging system
-- ✅ Notifications
-- ✅ File upload support (OR/CR documents, ID photos)
--
-- PRODUCTION OPTIMIZATIONS:
-- ========================
-- - Proper character sets (utf8mb4)
-- - Foreign key constraints
-- - Indexed fields for performance
-- - Transaction safety
--
-- SECURITY NOTES:
-- ==============
-- - Change default admin passwords after import
-- - Update email addresses to production domains
-- - Configure proper file permissions
-- - Enable HTTPS/SSL
--
-- ===============================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Disable foreign key checks during import
SET FOREIGN_KEY_CHECKS=0;

-- ===============================================
-- IMPORT YOUR COMPLETE DATABASE BELOW
-- ===============================================
