-- PMS Production Database Structure and Data
-- This is your complete database ready for production hosting
-- 
-- Instructions:
-- 1. Create a new MySQL database on your hosting provider
-- 2. Import this file using phpMyAdmin or MySQL command line
-- 3. Update your .env file with the production database credentials
-- 4. Run 'php artisan migrate --force' if needed

-- Set proper SQL mode for production
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Character set configuration
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Disable foreign key checks during import
SET FOREIGN_KEY_CHECKS=0;

-- Your database structure and data will be imported from the cleaned dump
-- The file 01_complete_database.sql contains your full database

-- After import, enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Commit the transaction
COMMIT;

-- Restore SQL settings
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;