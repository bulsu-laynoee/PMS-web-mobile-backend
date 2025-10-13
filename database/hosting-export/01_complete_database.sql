-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2025 at 04:30 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `feedback_id` int(11) DEFAULT NULL,
  `guard_id` int(11) DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `title`, `last_message_at`, `created_at`, `updated_at`) VALUES
(27, NULL, '2025-10-11 12:36:06', '2025-10-11 12:06:01', '2025-10-11 12:36:06'),
(28, NULL, '2025-10-11 12:20:27', '2025-10-11 12:15:25', '2025-10-11 12:20:27'),
(29, NULL, '2025-10-11 12:25:29', '2025-10-11 12:21:28', '2025-10-11 12:25:29');

-- --------------------------------------------------------

--
-- Table structure for table `conversation_user`
--

CREATE TABLE `conversation_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversation_user`
--

INSERT INTO `conversation_user` (`id`, `conversation_id`, `user_id`, `created_at`, `updated_at`) VALUES
(27, 27, 25, NULL, NULL),
(28, 27, 13, NULL, NULL),
(29, 28, 25, NULL, NULL),
(30, 28, 18, NULL, NULL),
(31, 27, 18, NULL, NULL),
(32, 29, 25, NULL, NULL),
(33, 29, 13, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `date_time` datetime NOT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incidents`
--

CREATE TABLE `incidents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `severity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `resolved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incident_attachments`
--

CREATE TABLE `incident_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `incident_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `recipient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `recipient_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_via` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `recipient_id`, `user_id`, `recipient_phone`, `body`, `sent_via`, `created_at`, `updated_at`) VALUES
(22, 27, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:06:01', '2025-10-11 12:06:01'),
(23, 27, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:09:05', '2025-10-11 12:09:05'),
(24, 27, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:09:07', '2025-10-11 12:09:07'),
(25, 27, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:10:45', '2025-10-11 12:10:45'),
(26, 27, 25, 13, NULL, '0912345678', 'Hey', 'in-app', '2025-10-11 12:11:15', '2025-10-11 12:11:15'),
(27, 28, 25, 18, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-11 12:15:25', '2025-10-11 12:15:25'),
(28, 27, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:17:39', '2025-10-11 12:17:39'),
(29, 28, 18, NULL, NULL, NULL, 'dsadads', 'in-app', '2025-10-11 12:18:28', '2025-10-11 12:18:28'),
(30, 27, 25, 18, NULL, NULL, 'The car emp-001 is not parked on his proper space', 'in-app', '2025-10-11 12:19:07', '2025-10-11 12:19:07'),
(31, 28, 25, 18, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-11 12:20:27', '2025-10-11 12:20:27'),
(32, 27, 25, 18, NULL, NULL, 'Hey', 'in-app', '2025-10-11 12:20:45', '2025-10-11 12:20:45'),
(33, 29, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:21:28', '2025-10-11 12:21:28'),
(34, 29, 25, 13, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:25:21', '2025-10-11 12:25:21'),
(35, 29, 25, 13, NULL, '0912345678', 'Hey', 'in-app', '2025-10-11 12:25:29', '2025-10-11 12:25:29'),
(36, 27, 18, NULL, NULL, NULL, 'hi', 'in-app', '2025-10-11 12:36:06', '2025-10-11 12:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2025_08_17_193124_restructure_parking_assignments_table', 1),
(3, '2025_09_21_200000_import_full_schema_dump', 1),
(4, '2025_09_21_210000_add_foreign_keys_to_pms_tables', 1),
(5, '2025_09_23_000000_add_or_cr_numbers_to_vehicles', 1),
(6, '2025_09_23_001000_add_or_cr_numbers_to_user_details', 1),
(7, '2025_10_11_000000_create_notifications_table', 1),
(8, '2025_10_11_000001_create_incidents_table', 1),
(9, '2025_10_11_000002_create_incident_attachments_table', 1),
(10, '2025_10_11_123000_add_qr_columns_to_user_details', 2),
(11, '2025_10_11_000000_create_messages_table', 3),
(12, '2025_10_11_000001_create_conversations_table', 3),
(13, '2025_10_12_000000_add_conversation_fields_to_messages_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('38e9632e-8acc-438a-adbe-a76896f5ee06', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":3,\"parking_slot_id\":1,\"parking_layout_id\":1,\"created_at\":\"2025-10-11 16:57:05\"}', '2025-10-11 10:50:48', '2025-10-11 08:57:05', '2025-10-11 10:50:48'),
('4ffe7685-efa0-4110-aaa5-81778c937ed9', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":2,\"parking_slot_id\":1,\"parking_layout_id\":1,\"created_at\":\"2025-10-11 16:56:05\"}', '2025-10-12 17:23:29', '2025-10-11 08:56:05', '2025-10-12 17:23:29');

-- --------------------------------------------------------

--
-- Table structure for table `parking_assignments`
--

CREATE TABLE `parking_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parking_slot_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `guest_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guest_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculty_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purpose` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_plate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `assignee_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assignment_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_assignments`
--

INSERT INTO `parking_assignments` (`id`, `parking_slot_id`, `user_id`, `guest_name`, `guest_contact`, `faculty_position`, `purpose`, `vehicle_plate`, `vehicle_color`, `vehicle_type`, `start_time`, `end_time`, `status`, `created_at`, `updated_at`, `assignee_type`, `assignment_type`) VALUES
(1, 3, NULL, 'Faculty 4 Test', '0912345678', 'Faculty', '-', 'FAC-004', 'Unknown', 'car', '2025-09-21 07:40:00', NULL, 'reserved', '2025-09-20 15:42:26', '2025-09-20 15:42:26', 'faculty', 'reserve'),
(2, 1, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-12 00:56:23', '2025-10-11 16:56:13', 'completed', '2025-10-11 08:56:03', '2025-10-11 08:56:13', 'guest', 'assign'),
(3, 1, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-12 00:57:25', '2025-10-11 16:57:09', 'completed', '2025-10-11 08:57:05', '2025-10-11 08:57:09', 'guest', 'assign');

-- --------------------------------------------------------

--
-- Table structure for table `parking_layouts`
--

CREATE TABLE `parking_layouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`layout_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_layouts`
--

INSERT INTO `parking_layouts` (`id`, `name`, `background_image`, `layout_data`, `created_at`, `updated_at`) VALUES
(1, '-', 'http://localhost:8000/storage/parking-layouts/UwDq0lvVLxwhcT6lm9nXMYCazKIgWfLAj27O0ZM8.jpg', '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"Space 1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":184,\"position_y\":127,\"width\":101,\"height\":230,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}},{\"id\":\"space-2\",\"space_number\":\"Space 2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":298,\"position_y\":384,\"width\":111,\"height\":250,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 2\"}},{\"id\":\"space-3\",\"space_number\":\"Space 3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":414,\"position_y\":138,\"width\":113,\"height\":215,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 3\"}}],\"lines\":[],\"texts\":[{\"id\":1758439813067,\"x\":602,\"y\":55,\"text\":\"Double click to edit\",\"fontSize\":16,\"fill\":\"#ffffff\",\"rotation\":0},{\"id\":1758439814620,\"x\":695,\"y\":680,\"text\":\"Double click to edit\",\"fontSize\":16,\"fill\":\"#ffffff\",\"rotation\":0},{\"id\":1758439816566,\"x\":685,\"y\":385,\"text\":\"Double click to edit\",\"fontSize\":16,\"fill\":\"#ffffff\",\"rotation\":0}]}', '2025-09-20 15:30:27', '2025-09-20 15:30:27'),
(2, 'S', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"Space 1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":76,\"position_y\":143,\"width\":119,\"height\":148,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}},{\"id\":\"space-2\",\"space_number\":\"Space 2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":215,\"position_y\":306,\"width\":135,\"height\":118,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 2\"}},{\"id\":\"space-3\",\"space_number\":\"Space 3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":404,\"position_y\":472,\"width\":135,\"height\":99,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 3\"}},{\"id\":\"space-4\",\"space_number\":\"Space 4\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":447,\"position_y\":197,\"width\":85,\"height\":67,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 4\"}},{\"id\":\"space-5\",\"space_number\":\"Space 5\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":581,\"position_y\":300,\"width\":85,\"height\":71,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 5\"}},{\"id\":\"space-6\",\"space_number\":\"Space 6\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":639,\"position_y\":123,\"width\":26,\"height\":36,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 6\"}},{\"id\":\"space-7\",\"space_number\":\"Space 7\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":299,\"position_y\":91,\"width\":29,\"height\":21,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 7\"}},{\"id\":\"space-8\",\"space_number\":\"Space 8\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":361,\"position_y\":242,\"width\":25,\"height\":22,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 8\"}},{\"id\":\"space-9\",\"space_number\":\"Space 9\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":430,\"position_y\":315,\"width\":43,\"height\":37,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 9\"}},{\"id\":\"space-10\",\"space_number\":\"Space 10\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":137,\"position_y\":424,\"width\":133,\"height\":92,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 10\"}},{\"id\":\"space-11\",\"space_number\":\"Space 11\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":304,\"position_y\":540,\"width\":104,\"height\":81,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 11\"}}],\"lines\":[],\"texts\":[]}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(3, 'Valencia Hall', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"Space 1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":104,\"position_y\":236,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}},{\"id\":\"space-1760313797155\",\"space_number\":\"Space 1 (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":254,\"position_y\":235,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy)\"}},{\"id\":\"space-1760313798979\",\"space_number\":\"Space 1 (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":404,\"position_y\":237,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy)\"}},{\"id\":\"space-1760313800602\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":258,\"position_y\":434,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy)\"}},{\"id\":\"space-1760313806183\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":105,\"position_y\":437,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\"}},{\"id\":\"space-1760313811674\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":403,\"position_y\":436,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\"}}],\"lines\":[],\"texts\":[]}', '2025-10-12 16:05:33', '2025-10-12 16:05:33');

-- --------------------------------------------------------

--
-- Table structure for table `parking_slots`
--

CREATE TABLE `parking_slots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `layout_id` bigint(20) UNSIGNED NOT NULL,
  `space_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `space_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'standard',
  `space_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `position_x` double(8,2) NOT NULL,
  `position_y` double(8,2) NOT NULL,
  `width` double(8,2) NOT NULL,
  `height` double(8,2) NOT NULL,
  `rotation` double(8,2) NOT NULL DEFAULT 0.00,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_slots`
--

INSERT INTO `parking_slots` (`id`, `layout_id`, `space_number`, `space_type`, `space_status`, `position_x`, `position_y`, `width`, `height`, `rotation`, `metadata`, `created_at`, `updated_at`) VALUES
(1, 1, 'Space 1', 'standard', 'available', 184.00, 127.00, 101.00, 230.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}', '2025-09-20 15:30:27', '2025-10-11 08:57:09'),
(2, 1, 'Space 2', 'standard', 'available', 298.00, 384.00, 111.00, 250.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 2\"}', '2025-09-20 15:30:27', '2025-09-20 15:30:27'),
(3, 1, 'Space 3', 'standard', 'reserved', 414.00, 138.00, 113.00, 215.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 3\"}', '2025-09-20 15:30:27', '2025-09-20 15:42:26'),
(4, 2, 'Space 1', 'standard', 'available', 76.00, 143.00, 119.00, 148.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(5, 2, 'Space 2', 'standard', 'available', 215.00, 306.00, 135.00, 118.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 2\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(6, 2, 'Space 3', 'standard', 'available', 404.00, 472.00, 135.00, 99.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 3\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(7, 2, 'Space 4', 'standard', 'available', 447.00, 197.00, 85.00, 67.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 4\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(8, 2, 'Space 5', 'standard', 'available', 581.00, 300.00, 85.00, 71.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 5\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(9, 2, 'Space 6', 'standard', 'available', 639.00, 123.00, 26.00, 36.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 6\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(10, 2, 'Space 7', 'standard', 'available', 299.00, 91.00, 29.00, 21.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 7\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(11, 2, 'Space 8', 'standard', 'available', 361.00, 242.00, 25.00, 22.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 8\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(12, 2, 'Space 9', 'standard', 'available', 430.00, 315.00, 43.00, 37.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 9\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(13, 2, 'Space 10', 'standard', 'available', 137.00, 424.00, 133.00, 92.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 10\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(14, 2, 'Space 11', 'standard', 'available', 304.00, 540.00, 104.00, 81.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 11\"}', '2025-10-11 12:50:44', '2025-10-11 12:50:44'),
(15, 3, 'Space 1', 'standard', 'available', 104.00, 236.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(16, 3, 'Space 1 (Copy)', 'standard', 'available', 254.00, 235.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(17, 3, 'Space 1 (Copy) (Copy)', 'standard', 'available', 404.00, 237.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(18, 3, 'Space 1 (Copy) (Copy) (Copy)', 'standard', 'available', 258.00, 434.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(19, 3, 'Space 1 (Copy) (Copy) (Copy) (Copy)', 'standard', 'available', 105.00, 437.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(20, 3, 'Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)', 'standard', 'available', 403.00, 436.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('waynelamarca720@gmail.com', '334473', '2025-09-20 16:51:51');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 18, 'MyApp', '33320b01a66c7a09fda3fe30411cb2351d7cbe60de2acb84b15c5f7e89538a15', '[\"*\"]', NULL, NULL, '2025-09-20 14:09:43', '2025-09-20 14:09:43'),
(2, 'App\\Models\\User', 18, 'MyApp', 'f9b44315cd7c84fd46cc09baec83adbe9752899153c10124351bad96bba3b45f', '[\"*\"]', NULL, NULL, '2025-09-20 15:40:14', '2025-09-20 15:40:14'),
(3, 'App\\Models\\User', 18, 'MyApp', '9f506e73c54b3501a673f708097b92c65d8e86ff37d751c2623829d9d11be00e', '[\"*\"]', NULL, NULL, '2025-09-20 16:34:37', '2025-09-20 16:34:37'),
(4, 'App\\Models\\User', 18, 'MyApp', '4f8b115f565aec6f9189368638d47ef3d1abf1b07391ddebc51e94c43e6070c9', '[\"*\"]', NULL, NULL, '2025-09-20 16:49:32', '2025-09-20 16:49:32'),
(5, 'App\\Models\\User', 18, 'MyApp', 'e406f716165a107277ad2c8f5c91925217ef1a4c8019107bf800d5966bb8e3ad', '[\"*\"]', NULL, NULL, '2025-09-20 16:50:51', '2025-09-20 16:50:51'),
(6, 'App\\Models\\User', 21, 'MyApp', '6fc712d076cb5ce084da40adcd67fba416230e10a6fb30b2b140179748a57113', '[\"*\"]', NULL, NULL, '2025-10-11 07:07:30', '2025-10-11 07:07:30'),
(7, 'App\\Models\\User', 21, 'MyApp', '25f75d72c4ed043dd1920f0ffc6df1fedccd55c8e711c673323a24acc0fafa93', '[\"*\"]', '2025-10-11 07:18:48', NULL, '2025-10-11 07:08:02', '2025-10-11 07:18:48'),
(8, 'App\\Models\\User', 18, 'MyApp', '76c84df3d29bff0c7eab5320fe3854b15fed234853b0d3786ca0d535587fa42b', '[\"*\"]', NULL, NULL, '2025-10-11 07:08:49', '2025-10-11 07:08:49'),
(9, 'App\\Models\\User', 24, 'MyApp', '05765bc7998a01988580be829996d2b105c1670cf6c45ed87822a9e48ceeea68', '[\"*\"]', NULL, NULL, '2025-10-11 07:20:04', '2025-10-11 07:20:04'),
(10, 'App\\Models\\User', 25, 'MyApp', '34012b22967839b9062f5aa8389acecfac22a89c2c76396e2e2b6fb5dc473e0d', '[\"*\"]', '2025-10-11 07:22:36', NULL, '2025-10-11 07:21:13', '2025-10-11 07:22:36'),
(11, 'App\\Models\\User', 25, 'MyApp', '0d94ef572a25c4be1e4c986e6ddaf83a39befecb19f0ef7e69c987b61ee97b09', '[\"*\"]', '2025-10-11 08:33:41', NULL, '2025-10-11 08:29:51', '2025-10-11 08:33:41'),
(12, 'App\\Models\\User', 25, 'MyApp', '43b179efe771e78d007ae1716abe8dad2c6ae3d817eca97a7aff5cb99605b4d7', '[\"*\"]', '2025-10-11 08:53:37', NULL, '2025-10-11 08:34:16', '2025-10-11 08:53:37'),
(13, 'App\\Models\\User', 23, 'MyApp', '0c4b5899721d95988f10f890a9f7c597b989a5b51f213971d39d898482b202a9', '[\"*\"]', '2025-10-11 09:11:08', NULL, '2025-10-11 08:53:54', '2025-10-11 09:11:08'),
(14, 'App\\Models\\User', 25, 'MyApp', '3b5ad8b9e71db30fc605de68751cf19fbcce9629d2aec6c685312b9f245d4151', '[\"*\"]', '2025-10-11 09:11:56', NULL, '2025-10-11 09:11:42', '2025-10-11 09:11:56'),
(15, 'App\\Models\\User', 25, 'MyApp', 'b99a5ffc7ce6f8a1705da266d68ab6faaeb19c7d5ccf093090e27cd7e42aaf44', '[\"*\"]', '2025-10-11 09:25:17', NULL, '2025-10-11 09:19:32', '2025-10-11 09:25:17'),
(16, 'App\\Models\\User', 25, 'MyApp', '8e6da4eb7bb6bdc0d970168b59982beb0b35b00ba9c79854a6ed60fefd9f63bb', '[\"*\"]', '2025-10-11 09:38:37', NULL, '2025-10-11 09:31:22', '2025-10-11 09:38:37'),
(17, 'App\\Models\\User', 25, 'MyApp', '052ceb73364d9f32b44de04e70ff859b13e072ebac31362dc4cc5b47f7f97c7f', '[\"*\"]', '2025-10-11 09:51:03', NULL, '2025-10-11 09:38:37', '2025-10-11 09:51:03'),
(18, 'App\\Models\\User', 25, 'MyApp', '6cae6f51da88e127d6042abd72d5b23cf04ec4dac378b3cf56a75c61dd501551', '[\"*\"]', '2025-10-11 10:07:51', NULL, '2025-10-11 09:54:02', '2025-10-11 10:07:51'),
(19, 'App\\Models\\User', 25, 'MyApp', '060ebcb35ba3a144c853f0059930f2ce8d031bc6f5e9df010be05aa993d8c5ee', '[\"*\"]', '2025-10-11 10:20:55', NULL, '2025-10-11 10:09:21', '2025-10-11 10:20:55'),
(20, 'App\\Models\\User', 25, 'MyApp', '1783a0fbbfa01628472cda5c960fe79a1034586099c4d944c426339565364b85', '[\"*\"]', '2025-10-11 10:55:44', NULL, '2025-10-11 10:21:33', '2025-10-11 10:55:44'),
(21, 'App\\Models\\User', 25, 'MyApp', '7a1450f24cc599a19f2faf20134c9411fd7b971e3cefc37cc8fafda35e3a6b3a', '[\"*\"]', '2025-10-11 11:21:43', NULL, '2025-10-11 10:57:16', '2025-10-11 11:21:43'),
(22, 'App\\Models\\User', 25, 'MyApp', 'e8af289d14fd663c29ee85a6f513b7d9c57d24942a6d5d43d86c7c86494edcbf', '[\"*\"]', '2025-10-11 11:34:49', NULL, '2025-10-11 11:24:14', '2025-10-11 11:34:49'),
(23, 'App\\Models\\User', 25, 'MyApp', '1d835d4e2bbecc5c9f1b792970c60afadd3a9e42587eabf0de9052fd7767014e', '[\"*\"]', '2025-10-11 11:37:34', NULL, '2025-10-11 11:35:09', '2025-10-11 11:37:34'),
(24, 'App\\Models\\User', 25, 'MyApp', 'c74c9ed87de9996bd7991d11ef5da6ed11547a01983c80cbdb6ff3603655b15f', '[\"*\"]', '2025-10-11 11:42:15', NULL, '2025-10-11 11:37:37', '2025-10-11 11:42:15'),
(25, 'App\\Models\\User', 25, 'MyApp', '94e0007a5c4327acb21d9c7b7d080a3a6b931a3a1e19f034d01f86cd0c9597da', '[\"*\"]', '2025-10-11 12:00:46', NULL, '2025-10-11 11:46:25', '2025-10-11 12:00:46'),
(26, 'App\\Models\\User', 25, 'MyApp', '6b5d5e297361f4e2aaafd047ba360517c3f52ec32fb502e2b3b0267ed116c3be', '[\"*\"]', '2025-10-11 12:11:18', NULL, '2025-10-11 12:04:12', '2025-10-11 12:11:18'),
(27, 'App\\Models\\User', 25, 'MyApp', '0f127322de6a04d4f595ced91ea3894fc737b2ccf86d51e00f0582319a579d34', '[\"*\"]', '2025-10-11 12:51:02', NULL, '2025-10-11 12:12:01', '2025-10-11 12:51:02'),
(28, 'App\\Models\\User', 18, 'MyApp', 'e32a9e866dfd88515935c25af59d6f85912b3b549e51a8587cd81038702883b8', '[\"*\"]', NULL, NULL, '2025-10-11 12:18:07', '2025-10-11 12:18:07'),
(29, 'App\\Models\\User', 26, 'MyApp', '0c6722e82470fa5da4dbba35195caa0910d5d12051e87ba0e7ad85960a94b68e', '[\"*\"]', NULL, NULL, '2025-10-11 12:35:27', '2025-10-11 12:35:27'),
(30, 'App\\Models\\User', 27, 'MyApp', '3984efe29bca74497af9207521f3b2ac47ee781a0ea21abacf256a5d08c747ec', '[\"*\"]', NULL, NULL, '2025-10-11 12:40:24', '2025-10-11 12:40:24'),
(31, 'App\\Models\\User', 28, 'MyApp', '756854ae99bd0af6f51bf2f0b3f2114e9ed12921b10b24b85fc53513ef7991ab', '[\"*\"]', NULL, NULL, '2025-10-11 12:48:43', '2025-10-11 12:48:43'),
(32, 'App\\Models\\User', 25, 'MyApp', '6d0fab7285f11695f2d97dbced2ac9c933f2a6bfd34b9f7419da9093f4beabb5', '[\"*\"]', '2025-10-11 13:03:14', NULL, '2025-10-11 12:51:12', '2025-10-11 13:03:14'),
(33, 'App\\Models\\User', 18, 'MyApp', 'e6543fdbb7247d50d03d35b7fb72515489c1cbfc1ea62359d0ab92976a5d309b', '[\"*\"]', NULL, NULL, '2025-10-11 12:59:44', '2025-10-11 12:59:44'),
(34, 'App\\Models\\User', 18, 'MyApp', '5028b11991d94b26ef981b5f4ece848285d460f1c6658ed8692f7baee91a1b22', '[\"*\"]', NULL, NULL, '2025-10-11 13:42:28', '2025-10-11 13:42:28'),
(35, 'App\\Models\\User', 18, 'MyApp', '5a7db4dc651e2629de684e3b60491f088a17491fa6da27b4082632628be56e93', '[\"*\"]', NULL, NULL, '2025-10-11 13:47:50', '2025-10-11 13:47:50'),
(36, 'App\\Models\\User', 25, 'MyApp', 'c93984a7ef55f4bfa9d6439ff6714ba4c653c7a392f384b906d64ed72ac5e9f4', '[\"*\"]', '2025-10-11 14:16:01', NULL, '2025-10-11 14:02:04', '2025-10-11 14:16:01'),
(37, 'App\\Models\\User', 25, 'MyApp', 'aa816e71cbb9223da98d989680e2b7c4c2b25796d117cdb7c5ce0e6c408eff0d', '[\"*\"]', '2025-10-11 14:31:46', NULL, '2025-10-11 14:17:49', '2025-10-11 14:31:46'),
(38, 'App\\Models\\User', 25, 'MyApp', 'a4f923d7dd9ff83c94d4c4d7ab078b4353e932e568bbb32540d714402ccd0ede', '[\"*\"]', '2025-10-11 14:41:25', NULL, '2025-10-11 14:34:41', '2025-10-11 14:41:25'),
(39, 'App\\Models\\User', 25, 'MyApp', '18ce1d37a03a7a13eb9d60e166b6f817ed54c2ea7330f9308cf4035bd13ff8c9', '[\"*\"]', '2025-10-11 14:45:37', NULL, '2025-10-11 14:44:33', '2025-10-11 14:45:37'),
(40, 'App\\Models\\User', 25, 'MyApp', '45970ff69440b3f0aa1e4edbd0e1d06ff818128d031b9e4bf807203e4893f38d', '[\"*\"]', '2025-10-11 14:49:07', NULL, '2025-10-11 14:48:44', '2025-10-11 14:49:07'),
(41, 'App\\Models\\User', 25, 'MyApp', 'd8f41d7e660c435f82bfc783ca9c7e3b3354a7c8921e22cda62dd31d8260ee93', '[\"*\"]', '2025-10-11 14:49:27', NULL, '2025-10-11 14:49:22', '2025-10-11 14:49:27'),
(42, 'App\\Models\\User', 25, 'MyApp', '031250580ad88b52e40eb0c88168bb4cb26230d7e333c1bbbbfc7b47554d7642', '[\"*\"]', '2025-10-11 14:58:13', NULL, '2025-10-11 14:52:08', '2025-10-11 14:58:13'),
(43, 'App\\Models\\User', 25, 'MyApp', '5d0d28448bd50f42b27c6deac1137fc0f3ebac753e2bf10bad929bdfdedebb69', '[\"*\"]', '2025-10-11 14:59:03', NULL, '2025-10-11 14:59:02', '2025-10-11 14:59:03'),
(44, 'App\\Models\\User', 25, 'MyApp', '23d99522cb91ac03da0c744db92af7366b5e26d24be1b4435218175873d969ec', '[\"*\"]', '2025-10-11 15:29:39', NULL, '2025-10-11 14:59:11', '2025-10-11 15:29:39'),
(45, 'App\\Models\\User', 18, 'MyApp', '9ea4fa5009e3920ac07f86747c242314a30d02746fee1a22830887ce4687b2bd', '[\"*\"]', NULL, NULL, '2025-10-12 15:59:32', '2025-10-12 15:59:32'),
(46, 'App\\Models\\User', 25, 'MyApp', 'a80d998ef06fe57b7339728b34a2d303ec49a51c46ef8a0dc24831057654d8bc', '[\"*\"]', '2025-10-12 16:35:52', NULL, '2025-10-12 16:28:06', '2025-10-12 16:35:52'),
(47, 'App\\Models\\User', 25, 'MyApp', '72776f16146985a7fa28933c43b354749e37f6e293566bbed86e8fe8e31bb7f3', '[\"*\"]', '2025-10-12 17:11:06', NULL, '2025-10-12 17:09:58', '2025-10-12 17:11:06'),
(48, 'App\\Models\\User', 25, 'MyApp', 'd9fd9d83865401a2bf25a29b93ab057642bec2616ad26ec483eef3b72221c6cb', '[\"*\"]', '2025-10-12 17:20:42', NULL, '2025-10-12 17:19:34', '2025-10-12 17:20:42'),
(49, 'App\\Models\\User', 25, 'MyApp', '6149dd8226e2683125e7512471865c5f53d4e680fbf3fef9fd0809d5d80c3f89', '[\"*\"]', '2025-10-12 17:35:32', NULL, '2025-10-12 17:22:46', '2025-10-12 17:35:32'),
(50, 'App\\Models\\User', 25, 'MyApp', '1a825237379dfa4cda226927f6927b7d9cb3c5e1f9b08c6d8fd4f5c8318113ec', '[\"*\"]', '2025-10-12 17:53:15', NULL, '2025-10-12 17:37:51', '2025-10-12 17:53:15'),
(51, 'App\\Models\\User', 25, 'MyApp', '2dbbce432d4f89b9f98321b8e37dc650b98a31abb8f4d52d4787962f615da96b', '[\"*\"]', '2025-10-12 18:04:04', NULL, '2025-10-12 17:59:30', '2025-10-12 18:04:04');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(3, 'Student', NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(4, 'Faculty', NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(5, 'Employee', NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(6, 'Admin', 'Administrator', '2025-09-20 13:57:48', '2025-09-20 13:57:48'),
(7, 'Guard', NULL, '2025-10-11 07:15:09', '2025-10-11 07:15:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `roles_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `roles_id`, `name`, `email`, `email_verified_at`, `password`, `profile_pic`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 3, 'Student 1 Test', 'student1@example.com', NULL, '$2y$10$b1BMeyYQ07JpIXQ3jHRQIe8bNbp2VQtf.V/G0wk5GtirVc5B82WMO', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(4, 3, 'Student 2 Test', 'student2@example.com', NULL, '$2y$10$k6bwNYU5SfARBzYuCEPreOfiyqbNvkHl5gq0.ig4qz9bgf/WimBaO', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(5, 3, 'Student 3 Test', 'student3@example.com', NULL, '$2y$10$Epw3cMd4US4O3sovDCfLf.53wPfQQjHJ/dc3LzRZOlf7QU7YpGWXa', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(6, 3, 'Student 4 Test', 'student4@example.com', NULL, '$2y$10$ebB1nDZ4WS6Wt3TXWAHP3u68LIE9QIowWT4Ud1rcTQJLkncZpt.ym', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(7, 3, 'Student 5 Test', 'student5@example.com', NULL, '$2y$10$93AeyVWoN1Lxwfyaq59LEOmqIixdLmwJGSFKbHroQ3hKdk.z.4lfO', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(8, 4, 'Faculty 1 Test', 'faculty1@example.com', NULL, '$2y$10$lx13Bao/oTgSi1I/LUk/b.dZwNPMRRRTDDhf9bLq7iFKJpVUsmtsK', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(9, 4, 'Faculty 2 Test', 'faculty2@example.com', NULL, '$2y$10$57IBy4uNutYJHwxM3U7Gz.g1sZNFBSrDHWf2pozn.0kk/nTBIKQbW', NULL, NULL, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(10, 4, 'Faculty 3 Test', 'faculty3@example.com', NULL, '$2y$10$lNY6o56LLVcNmRv5AWL/COLkYn2p93StcZI2Q6Et46lwoAkBpLC0y', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(11, 4, 'Faculty 4 Test', 'faculty4@example.com', NULL, '$2y$10$nRrwV8V.878m2MdqE/ZCRu/EMzC0ULYrwBAhRaHmod9XasEo8GqGW', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(12, 4, 'Faculty 5 Test', 'faculty5@example.com', NULL, '$2y$10$mN2vtbzHf5d/lR902mKOdOxbSSyEYuRj.QfK7QohInonSpe36zMCi', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(13, 5, 'Employee 1 Test', 'employee1@example.com', NULL, '$2y$10$S093m9Tfjmv6vQo1IKD4b.pImP0Y7GA0Z0z21eGFOD.KYkOpXY3T.', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(14, 5, 'Employee 2 Test', 'employee2@example.com', NULL, '$2y$10$aGDJAB1kew8x2ILScINNlOrDidcBnIyITHpSjRH.ApwJKQ4927gSq', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(15, 5, 'Employee 3 Test', 'employee3@example.com', NULL, '$2y$10$GAYYRvcSWII.axk/FIPnZujasbV3WXLdhoJgDS6GhmvHuE9IjA7C2', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(16, 5, 'Employee 4 Test', 'employee4@example.com', NULL, '$2y$10$Y3IbI4al7SAkr2MeTXWqteaG8oK1UKs2bQMgjS6iKPza9EmixvhjG', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(17, 5, 'Employee 5 Test', 'employee5@example.com', NULL, '$2y$10$fgx9upykFnN2LsgyuowaLeOB0lwv6RC5.2Vc6tx8EpbkLp4peRSAG', NULL, NULL, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(18, 6, 'Jerry', 'admin@gmail.com', NULL, '$2y$10$7QR4rlbZ4JIhIv5TovNhtOK0RlzM0zGHXljO00z9bYv9f82d1J2mG', 'http://localhost:8000/storage/profile_pics/iBVzRXVz0jaA2ZRxPZDEpgqSSovijH3raODMBDhv.jpg', NULL, '2025-09-20 13:57:48', '2025-09-20 16:51:17'),
(23, 7, 'guard1', 'guard@email.com', NULL, '$2y$10$h860XLtwUey7R51pVWRkg.rvKM1yhBQzGyEeXTdIR7OT80qxbmuMu', NULL, NULL, '2025-10-11 07:15:10', '2025-10-11 07:15:10'),
(24, NULL, 'Smoke Register', 'smoke2@example.com', NULL, '$2y$10$FSVorKI/OedtkGiUoE7xR.y94fI8ZkYW47KiP1TqSyqMMauYl1T.q', NULL, NULL, '2025-10-11 07:20:04', '2025-10-11 07:20:04'),
(25, NULL, 'Smoke Register', 'smoke11@example.com', NULL, '$2y$10$uAlbjHsmkiwXhI3GLjxHUuBQ56dl4tNzJjp3VG9.AudPlbKLzfDkS', NULL, NULL, '2025-10-11 07:20:04', '2025-10-11 07:20:04'),
(26, NULL, 'Wayne Hdjjss', 'fac@gmail.com', NULL, '$2y$10$HzOpJ.s1JBQCYtxyZPq2yuIusr7.YYFJpqT/vflwaHZUInEpGoQW2', NULL, NULL, '2025-10-11 12:35:27', '2025-10-11 12:35:27'),
(27, NULL, 'Wayne Hdjjss', 'facjsjdjs@gmail.com', NULL, '$2y$10$taWxOvFrZpmHdgkaUlwlSublKOjaXMt7xVIGO.bRS2AW47flH843a', NULL, NULL, '2025-10-11 12:40:24', '2025-10-11 12:40:24'),
(28, NULL, 'Wayne Hdjjss', 'fahejebecjsjdjs@gmail.com', NULL, '$2y$10$mAjqL0NHtQiIZWcFHvj9eOY2xubSXYwImQxuXE937WhtNLqksA7ZG', NULL, NULL, '2025-10-11 12:48:43', '2025-10-11 12:48:43');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate_numbers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`plate_numbers`)),
  `student_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculty_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yr_section` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `or_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `or_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cr_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `or_cr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_pending` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `user_id`, `firstname`, `lastname`, `department`, `contact_number`, `plate_number`, `plate_numbers`, `student_no`, `faculty_id`, `employee_id`, `course`, `yr_section`, `position`, `or_path`, `or_number`, `cr_path`, `cr_number`, `or_cr_path`, `qr_path`, `qr_token`, `from_pending`, `created_at`, `updated_at`) VALUES
(2, 3, 'Student1', 'Test', 'Sample Dept', '0912345678', 'ABC-001', NULL, 'S001', NULL, NULL, 'Sample Course', '1-A', NULL, 'or_cr/or_student_1_tpPZx1.pdf', NULL, 'or_cr/cr_student_1_al9L5R.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(3, 4, 'Student2', 'Test', 'Sample Dept', '0912345678', 'ABC-002', NULL, 'S002', NULL, NULL, 'Sample Course', '1-A', NULL, 'or_cr/or_student_2_LfRo20.pdf', NULL, 'or_cr/cr_student_2_33jgds.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(4, 5, 'Student3', 'Test', 'Sample Dept', '0912345678', 'ABC-003', NULL, 'S003', NULL, NULL, 'Sample Course', '1-A', NULL, 'or_cr/or_student_3_G9k1pa.pdf', NULL, 'or_cr/cr_student_3_y28tLA.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(5, 6, 'Student4', 'Test', 'Sample Dept', '0912345678', 'ABC-004', NULL, 'S004', NULL, NULL, 'Sample Course', '1-A', NULL, 'or_cr/or_student_4_TCtlHV.pdf', NULL, 'or_cr/cr_student_4_BWKHth.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(6, 7, 'Student5', 'Test', 'Sample Dept', '0912345678', 'ABC-005', NULL, 'S005', NULL, NULL, 'Sample Course', '1-A', NULL, 'or_cr/or_student_5_Uln7kn.pdf', NULL, 'or_cr/cr_student_5_3bhhga.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(7, 8, 'Faculty1', 'Test', 'Sample Dept', '0912345678', 'FAC-001', '[\"FAC-001\"]', NULL, 'F001', NULL, NULL, NULL, 'Professor', 'or_cr/or_faculty_1_z2TPgG.pdf', NULL, 'or_cr/cr_faculty_1_pM8Pyl.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 14:13:02'),
(8, 9, 'Faculty2', 'Test', 'Sample Dept', '0912345678', 'FAC-002', NULL, NULL, 'F002', NULL, NULL, NULL, 'Professor', 'or_cr/or_faculty_2_sAEZQe.pdf', NULL, 'or_cr/cr_faculty_2_2TyECr.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:22', '2025-09-20 13:42:22'),
(9, 10, 'Faculty3', 'Test', 'Sample Dept', '0912345678', 'FAC-003', NULL, NULL, 'F003', NULL, NULL, NULL, 'Professor', 'or_cr/or_faculty_3_xXUH9L.pdf', NULL, 'or_cr/cr_faculty_3_5a1nfZ.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(10, 11, 'Faculty4', 'Test', 'Sample Dept', '0912345678', 'FAC-004', NULL, NULL, 'F004', NULL, NULL, NULL, 'Professor', 'or_cr/or_faculty_4_DDbJep.pdf', NULL, 'or_cr/cr_faculty_4_hQvMpU.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(11, 12, 'Faculty5', 'Test', 'Sample Dept', '0912345678', 'FAC-005', NULL, NULL, 'F005', NULL, NULL, NULL, 'Professor', 'or_cr/or_faculty_5_FDW1a6.pdf', NULL, 'or_cr/cr_faculty_5_lnRqiA.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(12, 13, 'Employee1', 'Test', 'Sample Dept', '0912345678', 'EMP-001', NULL, NULL, NULL, 'E001', NULL, NULL, 'Staff', 'or_cr/or_employee_1_NY37zz.pdf', NULL, 'or_cr/cr_employee_1_yhopEm.pdf', NULL, NULL, NULL, NULL, 1, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(13, 14, 'Employee2', 'Test', 'Sample Dept', '0912345678', 'EMP-002', NULL, NULL, NULL, 'E002', NULL, NULL, 'Staff', 'or_cr/or_employee_2_EkwPz6.pdf', NULL, 'or_cr/cr_employee_2_RZiUzU.pdf', NULL, NULL, NULL, NULL, 1, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(14, 15, 'Employee3', 'Test', 'Sample Dept', '0912345678', 'EMP-003', NULL, NULL, NULL, 'E003', NULL, NULL, 'Staff', 'or_cr/or_employee_3_cBi49o.pdf', NULL, 'or_cr/cr_employee_3_XgdB7d.pdf', NULL, NULL, NULL, NULL, 1, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(15, 16, 'Employee4', 'Test', 'Sample Dept', '0912345678', 'EMP-004', NULL, NULL, NULL, 'E004', NULL, NULL, 'Staff', 'or_cr/or_employee_4_4JLgnR.pdf', NULL, 'or_cr/cr_employee_4_ePFKym.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(16, 17, 'Employee5', 'Test', 'Sample Dept', '0912345678', 'EMP-005', NULL, NULL, NULL, 'E005', NULL, NULL, 'Staff', 'or_cr/or_employee_5_Snmapg.pdf', NULL, 'or_cr/cr_employee_5_S7i4Xp.pdf', NULL, NULL, NULL, NULL, 0, '2025-09-20 13:42:23', '2025-09-20 13:42:23'),
(17, 18, 'Admin', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-09-20 13:57:48', '2025-09-20 13:57:48'),
(20, 23, 'guard1', '', NULL, '09273915603', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-10-11 07:15:10', '2025-10-11 07:15:10'),
(21, 24, 'Smoke', 'Register', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-10-11 07:20:04', '2025-10-11 07:20:04'),
(22, 25, 'Smoke', 'Register', 'Smoke Test', '09683440125', NULL, '[\"VEH-002\"]', '201213123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'qrs/qr_25_1760196004.svg', '27ff6be308168712c05faac77d7f9f660622535dde082d31776a777c75f4fc4f', 0, '2025-10-11 07:20:04', '2025-10-12 17:45:34'),
(23, 26, 'Wayne', 'Hdjjss', NULL, NULL, 'ABC 123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '1336-000000047372', '0', '00086549100107222022', NULL, NULL, NULL, 0, '2025-10-11 12:35:27', '2025-10-11 12:35:28'),
(24, 27, 'Wayne', 'Hdjjss', NULL, NULL, 'ABC 123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '1336-000000047372bsbsbs', '0', '00086549100107222022hsjwjjs', NULL, NULL, NULL, 0, '2025-10-11 12:40:24', '2025-10-11 12:40:24'),
(25, 28, 'Wayne', 'Hdjjss', NULL, NULL, 'ABC 123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '1336-000000047372bsbsbs', '0', '00086549100107222022hsjwjjs', NULL, NULL, NULL, 0, '2025-10-11 12:48:43', '2025-10-11 12:48:44');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_details_id` bigint(20) UNSIGNED DEFAULT NULL,
  `plate_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `or_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `or_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cr_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `user_id`, `user_details_id`, `plate_number`, `vehicle_color`, `vehicle_type`, `brand`, `model`, `or_path`, `or_number`, `cr_path`, `cr_number`, `created_at`, `updated_at`) VALUES
(2, 3, 2, 'ABC-001', 'Yellow', 'motorcycle', 'Yamaha', 'Mio', 'or_cr/veh_or_OJINmraE.pdf', NULL, 'or_cr/veh_cr_9ZVIKydS.pdf', NULL, '2025-09-20 14:00:14', '2025-09-20 15:55:34'),
(3, 4, 3, 'ABC-002', 'Unknown', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(4, 5, 4, 'ABC-003', 'Unknown', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(5, 6, 5, 'ABC-004', 'Unknown', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(6, 7, 6, 'ABC-005', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(7, 8, 7, 'FAC-001', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(8, 9, 8, 'FAC-002', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(9, 10, 9, 'FAC-003', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(10, 11, 10, 'FAC-004', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(11, 12, 11, 'FAC-005', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(12, 13, 12, 'EMP-001', 'Green', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(13, 14, 13, 'EMP-002', 'Green', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(14, 15, 14, 'EMP-003', 'Green', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(15, 16, 15, 'EMP-004', 'Green', 'Car', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(16, 17, 16, 'EMP-005', 'Green', 'Motorcycle', NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 14:00:14', '2025-09-20 14:00:14'),
(17, 8, NULL, 'FAC-001', 'Green', 'Car', 'Yamaha', 'Mio', 'or_cr/veh_or_CxqKVtDG.pdf', NULL, 'or_cr/veh_cr_FFTu8c4H.pdf', NULL, '2025-09-20 14:13:02', '2025-09-20 14:13:02'),
(19, 25, NULL, 'SMK2464', 'blue', 'car', 'Test', 'S1', NULL, NULL, NULL, NULL, '2025-10-11 07:20:04', '2025-10-11 07:20:04'),
(20, 26, NULL, 'ABC 123', 'Green', 'car', 'Hinda', 'Blue', '0', '1336-000000047372', '0', '00086549100107222022', '2025-10-11 12:35:28', '2025-10-11 12:35:28'),
(22, 28, NULL, 'ABC 123', 'Green', 'car', 'Hinda', 'Blue', '0', '1336-000000047372bsbsbs', '0', '00086549100107222022hsjwjjs', '2025-10-11 12:48:44', '2025-10-11 12:48:44'),
(23, 25, NULL, 'VEH-002', 'Green', 'motorcycle', 'YAMAHA', 'MIO', 'or_cr/veh_or_JIgsv0iF.pdf', 'SDADASD123213', 'or_cr/veh_cr_5m4csp0C.pdf', 'ASDAD1231', '2025-10-12 17:45:34', '2025-10-12 17:45:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversation_user`
--
ALTER TABLE `conversation_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_user_conversation_id_index` (`conversation_id`),
  ADD KEY `conversation_user_user_id_index` (`user_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incidents`
--
ALTER TABLE `incidents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incidents_resolved_by_foreign` (`resolved_by`),
  ADD KEY `incidents_user_id_index` (`user_id`);

--
-- Indexes for table `incident_attachments`
--
ALTER TABLE `incident_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incident_attachments_incident_id_index` (`incident_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_user_id_index` (`user_id`),
  ADD KEY `messages_conversation_id_index` (`conversation_id`),
  ADD KEY `messages_sender_id_index` (`sender_id`),
  ADD KEY `messages_recipient_id_index` (`recipient_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `parking_assignments`
--
ALTER TABLE `parking_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parking_assignments_parking_slot_id_foreign` (`parking_slot_id`),
  ADD KEY `parking_assignments_user_id_index` (`user_id`);

--
-- Indexes for table `parking_layouts`
--
ALTER TABLE `parking_layouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parking_slots`
--
ALTER TABLE `parking_slots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parking_slots_layout_id_foreign` (`layout_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_details_qr_token_index` (`qr_token`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicles_user_id_foreign` (`user_id`),
  ADD KEY `vehicles_plate_number_index` (`plate_number`),
  ADD KEY `vehicles_user_details_id_foreign` (`user_details_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `conversation_user`
--
ALTER TABLE `conversation_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incidents`
--
ALTER TABLE `incidents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incident_attachments`
--
ALTER TABLE `incident_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `parking_assignments`
--
ALTER TABLE `parking_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `parking_layouts`
--
ALTER TABLE `parking_layouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `parking_slots`
--
ALTER TABLE `parking_slots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `conversation_user`
--
ALTER TABLE `conversation_user`
  ADD CONSTRAINT `conversation_user_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversation_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `incidents`
--
ALTER TABLE `incidents`
  ADD CONSTRAINT `incidents_resolved_by_foreign` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `incidents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `incident_attachments`
--
ALTER TABLE `incident_attachments`
  ADD CONSTRAINT `incident_attachments_incident_id_foreign` FOREIGN KEY (`incident_id`) REFERENCES `incidents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_recipient_id_foreign` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `parking_assignments`
--
ALTER TABLE `parking_assignments`
  ADD CONSTRAINT `parking_assignments_parking_slot_id_foreign` FOREIGN KEY (`parking_slot_id`) REFERENCES `parking_slots` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parking_slots`
--
ALTER TABLE `parking_slots`
  ADD CONSTRAINT `parking_slots_layout_id_foreign` FOREIGN KEY (`layout_id`) REFERENCES `parking_layouts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_user_details_id_foreign` FOREIGN KEY (`user_details_id`) REFERENCES `user_details` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vehicles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
