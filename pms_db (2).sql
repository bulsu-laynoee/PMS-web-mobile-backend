-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2025 at 03:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

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
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `title`, `last_message_at`, `created_at`, `updated_at`) VALUES
(27, NULL, '2025-10-13 16:07:30', '2025-10-11 12:06:01', '2025-10-13 16:07:30'),
(28, NULL, '2025-10-19 14:56:31', '2025-10-11 12:15:25', '2025-10-19 14:56:31'),
(29, NULL, '2025-10-13 20:18:13', '2025-10-11 12:21:28', '2025-10-13 20:18:13'),
(30, NULL, '2025-10-20 00:40:32', '2025-10-13 20:38:56', '2025-10-20 00:40:32'),
(31, NULL, NULL, '2025-10-13 23:57:02', '2025-10-13 23:57:02'),
(32, NULL, '2025-10-17 07:34:41', '2025-10-17 07:17:28', '2025-10-17 07:34:41'),
(33, NULL, '2025-10-19 21:55:25', '2025-10-17 07:20:12', '2025-10-19 21:55:25'),
(34, NULL, '2025-10-19 14:54:48', '2025-10-18 01:23:13', '2025-10-19 14:54:48'),
(35, NULL, NULL, '2025-10-18 15:19:46', '2025-10-18 15:19:46'),
(36, NULL, NULL, '2025-10-19 07:06:03', '2025-10-19 07:06:03'),
(37, NULL, '2025-10-19 12:33:28', '2025-10-19 12:33:28', '2025-10-19 12:33:28'),
(38, NULL, NULL, '2025-10-19 17:49:28', '2025-10-19 17:49:28'),
(39, NULL, '2025-10-20 01:44:47', '2025-10-19 20:51:38', '2025-10-20 01:44:47'),
(40, NULL, '2025-11-08 17:59:25', '2025-10-20 03:31:33', '2025-11-08 17:59:25'),
(41, NULL, '2025-10-20 04:18:12', '2025-10-20 04:18:12', '2025-10-20 04:18:12'),
(42, NULL, '2025-10-20 04:20:19', '2025-10-20 04:20:18', '2025-10-20 04:20:19'),
(43, NULL, NULL, '2025-10-20 04:25:55', '2025-10-20 04:25:55');

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
(29, 28, 25, NULL, NULL),
(32, 29, 25, NULL, NULL),
(34, 30, 25, NULL, NULL),
(35, 30, 23, NULL, NULL),
(36, 31, 23, NULL, NULL),
(37, 31, 29, NULL, NULL),
(41, 33, 29, NULL, NULL),
(42, 34, 23, NULL, NULL),
(48, 37, 23, NULL, NULL),
(52, 39, 29, NULL, NULL),
(53, 39, 25, NULL, NULL),
(54, 40, 38, NULL, NULL),
(55, 40, 29, NULL, NULL),
(56, 41, 39, NULL, NULL),
(57, 41, 40, NULL, NULL),
(58, 42, 39, NULL, NULL),
(59, 42, 38, NULL, NULL),
(60, 43, 39, NULL, NULL),
(61, 43, 29, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `date_time` datetime NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `rating`, `date_time`, `comments`, `created_at`, `updated_at`) VALUES
(6, 0, 5, '2025-10-19 16:11:30', 'Test', '2025-10-19 16:11:30', '2025-10-19 16:11:30'),
(7, 0, 5, '2025-10-19 16:17:13', 'Testing testing', '2025-10-19 16:17:13', '2025-10-19 16:17:13'),
(8, 0, 3, '2025-10-19 16:17:47', 'Testing testing', '2025-10-19 16:17:47', '2025-10-19 16:17:47'),
(9, 25, 5, '2025-10-19 20:55:01', '4:54am', '2025-10-19 20:55:01', '2025-10-19 20:55:01'),
(10, 25, 5, '2025-10-19 20:55:11', '4:54am', '2025-10-19 20:55:11', '2025-10-19 20:55:11'),
(11, 0, 5, '2025-10-19 20:55:20', '4:54am anonymous', '2025-10-19 20:55:20', '2025-10-19 20:55:20'),
(12, 25, 5, '2025-10-19 20:55:32', 'Edward layno', '2025-10-19 20:55:32', '2025-10-19 20:55:32'),
(13, 0, 5, '2025-10-19 20:55:39', 'Edward layno anonymous', '2025-10-19 20:55:39', '2025-10-19 20:55:39'),
(14, 25, 2, '2025-10-19 21:06:25', 'Good service', '2025-10-19 21:06:25', '2025-10-19 21:06:25');

-- --------------------------------------------------------

--
-- Table structure for table `incidents`
--

CREATE TABLE `incidents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `severity` enum('low','medium','high') DEFAULT 'low',
  `location` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'open',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `resolved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reported_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `report_count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `incidents`
--

INSERT INTO `incidents` (`id`, `user_id`, `title`, `description`, `type`, `severity`, `location`, `status`, `meta`, `resolved_by`, `resolved_at`, `created_at`, `updated_at`, `reported_user_id`, `report_count`) VALUES
(12, 38, 'Low prio', 'Ejdhd', NULL, 'low', 'Pimentel', 'open', '\"{\\\"reported_plate\\\":\\\"SMK2464\\\"}\"', NULL, NULL, '2025-10-20 03:28:59', '2025-10-20 03:28:59', 25, 1),
(13, 38, 'Medium Prio', 'Okayy', NULL, 'low', 'Pimentel', 'open', '\"{\\\"reported_plate\\\":\\\"SMK2464\\\"}\"', NULL, NULL, '2025-10-20 03:29:28', '2025-10-20 03:29:28', 25, 2),
(14, 38, 'High Prio', 'Testtinggg', NULL, 'low', 'Alvarado Hall', 'open', '\"{\\\"reported_plate\\\":\\\"SMK2464\\\"}\"', NULL, NULL, '2025-10-20 03:29:51', '2025-10-20 03:29:51', 25, 3),
(15, 38, 'Another High prio', 'Testing w', NULL, 'low', 'College of Law', 'open', '\"{\\\"reported_plate\\\":\\\"SMK2464\\\"}\"', NULL, NULL, '2025-10-20 03:30:32', '2025-10-20 03:30:32', 25, 1),
(16, 38, 'Crash', 'Asap', NULL, 'low', 'Pimentel', 'open', '\"{\\\"reported_plate\\\":\\\"131036\\\"}\"', NULL, NULL, '2025-10-20 04:25:26', '2025-10-20 04:25:26', 39, 1);

-- --------------------------------------------------------

--
-- Table structure for table `incident_attachments`
--

CREATE TABLE `incident_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `incident_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(1024) NOT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
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
  `recipient_phone` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `sent_via` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `recipient_id`, `user_id`, `recipient_phone`, `body`, `sent_via`, `created_at`, `updated_at`) VALUES
(22, 27, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:06:01', '2025-10-11 12:06:01'),
(23, 27, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:09:05', '2025-10-11 12:09:05'),
(24, 27, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:09:07', '2025-10-11 12:09:07'),
(25, 27, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:10:45', '2025-10-11 12:10:45'),
(26, 27, 25, NULL, NULL, '0912345678', 'Hey', 'in-app', '2025-10-11 12:11:15', '2025-10-11 12:11:15'),
(27, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-11 12:15:25', '2025-10-11 12:15:25'),
(28, 27, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:17:39', '2025-10-11 12:17:39'),
(29, 28, NULL, NULL, NULL, NULL, 'dsadads', 'in-app', '2025-10-11 12:18:28', '2025-10-11 12:18:28'),
(30, 27, 25, NULL, NULL, NULL, 'The car emp-001 is not parked on his proper space', 'in-app', '2025-10-11 12:19:07', '2025-10-11 12:19:07'),
(31, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-11 12:20:27', '2025-10-11 12:20:27'),
(32, 27, 25, NULL, NULL, NULL, 'Hey', 'in-app', '2025-10-11 12:20:45', '2025-10-11 12:20:45'),
(33, 29, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:21:28', '2025-10-11 12:21:28'),
(34, 29, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-11 12:25:21', '2025-10-11 12:25:21'),
(35, 29, 25, NULL, NULL, '0912345678', 'Hey', 'in-app', '2025-10-11 12:25:29', '2025-10-11 12:25:29'),
(36, 27, NULL, NULL, NULL, NULL, 'hi', 'in-app', '2025-10-11 12:36:06', '2025-10-11 12:36:06'),
(37, 28, NULL, NULL, NULL, NULL, 'test', 'in-app', '2025-10-13 16:07:13', '2025-10-13 16:07:13'),
(38, 28, NULL, NULL, NULL, NULL, 'Test', 'in-app', '2025-10-13 16:07:21', '2025-10-13 16:07:21'),
(39, 27, NULL, NULL, NULL, NULL, 'Hello', 'in-app', '2025-10-13 16:07:30', '2025-10-13 16:07:30'),
(40, 28, NULL, NULL, NULL, NULL, 'late', 'in-app', '2025-10-13 16:07:42', '2025-10-13 16:07:42'),
(41, 29, 25, NULL, NULL, '0912345678', 'Hello, Employee 1 Test', 'in-app', '2025-10-13 20:18:13', '2025-10-13 20:18:13'),
(42, 30, 25, 23, NULL, '09273915603', 'Hello, guard1', 'in-app', '2025-10-13 20:38:56', '2025-10-13 20:38:56'),
(43, 30, 25, 23, NULL, '09273915603', 'Test', 'in-app', '2025-10-13 20:39:46', '2025-10-13 20:39:46'),
(44, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-13 20:48:21', '2025-10-13 20:48:21'),
(45, 30, 25, 23, NULL, '09273915603', 'Hello, guard1', 'in-app', '2025-10-13 20:48:36', '2025-10-13 20:48:36'),
(46, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-13 22:06:03', '2025-10-13 22:06:03'),
(47, 28, 25, NULL, NULL, NULL, 'Hi', 'in-app', '2025-10-13 22:06:20', '2025-10-13 22:06:20'),
(48, 30, 25, 23, NULL, '09273915603', 'Hello, guard1', 'in-app', '2025-10-13 22:39:18', '2025-10-13 22:39:18'),
(49, 30, 25, 23, NULL, '09273915603', 'Hello', 'in-app', '2025-10-13 23:58:34', '2025-10-13 23:58:34'),
(50, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-14 01:01:25', '2025-10-14 01:01:25'),
(51, 28, 25, NULL, NULL, NULL, 'Test', 'in-app', '2025-10-14 01:01:32', '2025-10-14 01:01:32'),
(52, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-14 01:01:46', '2025-10-14 01:01:46'),
(53, 28, NULL, NULL, NULL, NULL, 'Hi, Juan', 'in-app', '2025-10-14 01:02:29', '2025-10-14 01:02:29'),
(54, 28, NULL, NULL, NULL, NULL, 'Hi', 'in-app', '2025-10-14 10:49:29', '2025-10-14 10:49:29'),
(55, 30, 23, 25, NULL, '09683440125', 'Hello', 'in-app', '2025-10-14 10:50:55', '2025-10-14 10:50:55'),
(56, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-14 10:58:03', '2025-10-14 10:58:03'),
(57, 28, 25, NULL, NULL, NULL, 'Hi,sir!', 'in-app', '2025-10-14 10:58:17', '2025-10-14 10:58:17'),
(58, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-15 13:33:10', '2025-10-15 13:33:10'),
(59, 28, 25, NULL, NULL, NULL, 'Hello, Jerry', 'in-app', '2025-10-15 13:33:41', '2025-10-15 13:33:41'),
(60, 30, 25, 23, NULL, '09273915603', 'Hello, guard1', 'in-app', '2025-10-16 07:54:32', '2025-10-16 07:54:32'),
(61, 28, NULL, NULL, NULL, NULL, 'Test Message', 'in-app', '2025-10-16 10:11:23', '2025-10-16 10:11:23'),
(62, 28, NULL, NULL, NULL, NULL, 'Test', 'in-app', '2025-10-17 02:12:26', '2025-10-17 02:12:26'),
(63, 28, NULL, NULL, NULL, NULL, 'Hi Smoke', 'in-app', '2025-10-17 07:14:03', '2025-10-17 07:14:03'),
(64, 32, NULL, NULL, NULL, NULL, 'Test message', 'in-app', '2025-10-17 07:34:41', '2025-10-17 07:34:41'),
(65, 28, NULL, NULL, NULL, NULL, 'Test Message Smoke', 'in-app', '2025-10-17 07:55:55', '2025-10-17 07:55:55'),
(66, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:05:58', '2025-10-18 01:05:58'),
(67, 34, 23, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:23:14', '2025-10-18 01:23:14'),
(68, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:24:57', '2025-10-18 01:24:57'),
(69, 28, 25, NULL, NULL, NULL, 'Hi', 'in-app', '2025-10-18 01:25:06', '2025-10-18 01:25:06'),
(70, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:31:30', '2025-10-18 01:31:30'),
(71, 30, 25, 23, NULL, '09273915603', 'Hello, guard1', 'in-app', '2025-10-18 01:31:40', '2025-10-18 01:31:40'),
(72, 30, 25, 23, NULL, '09273915603', 'Hello Test Message', 'in-app', '2025-10-18 01:34:48', '2025-10-18 01:34:48'),
(73, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:47:11', '2025-10-18 01:47:11'),
(74, 28, 25, NULL, NULL, NULL, 'Test Message Debug', 'in-app', '2025-10-18 01:47:25', '2025-10-18 01:47:25'),
(75, 28, NULL, NULL, NULL, NULL, 'okay', 'in-app', '2025-10-18 01:47:41', '2025-10-18 01:47:41'),
(76, 28, NULL, NULL, NULL, NULL, 'okay', 'in-app', '2025-10-18 01:47:52', '2025-10-18 01:47:52'),
(77, 28, NULL, NULL, NULL, NULL, 'Nice', 'in-app', '2025-10-18 01:48:10', '2025-10-18 01:48:10'),
(78, 34, 23, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-18 01:49:13', '2025-10-18 01:49:13'),
(79, 34, 23, NULL, NULL, NULL, 'Sample Test', 'in-app', '2025-10-18 01:49:28', '2025-10-18 01:49:28'),
(80, 34, NULL, NULL, NULL, NULL, 'go', 'in-app', '2025-10-18 01:49:36', '2025-10-18 01:49:36'),
(81, 34, NULL, NULL, NULL, NULL, 'try', 'in-app', '2025-10-18 01:54:40', '2025-10-18 01:54:40'),
(82, 34, 23, NULL, NULL, NULL, 'Yeah', 'in-app', '2025-10-18 01:54:50', '2025-10-18 01:54:50'),
(83, 28, NULL, NULL, NULL, NULL, 'Try', 'in-app', '2025-10-18 01:55:07', '2025-10-18 01:55:07'),
(84, 34, 23, NULL, NULL, NULL, 'Pass', 'in-app', '2025-10-18 01:55:30', '2025-10-18 01:55:30'),
(85, 34, 23, NULL, NULL, NULL, 'Test Real Time', 'in-app', '2025-10-18 02:04:58', '2025-10-18 02:04:58'),
(86, 34, 23, NULL, NULL, NULL, 'Good morning sir', 'in-app', '2025-10-18 20:26:09', '2025-10-18 20:26:09'),
(87, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-19 04:32:57', '2025-10-19 04:32:57'),
(88, 28, 25, NULL, NULL, NULL, 'Test notif', 'in-app', '2025-10-19 04:33:05', '2025-10-19 04:33:05'),
(89, 28, 25, NULL, NULL, NULL, 'Ayaw mag notif', 'in-app', '2025-10-19 04:52:23', '2025-10-19 04:52:23'),
(90, 28, 25, NULL, NULL, NULL, 'Test notif', 'in-app', '2025-10-19 04:57:10', '2025-10-19 04:57:10'),
(91, 28, 25, NULL, NULL, NULL, 'Hello, Admin Edward', 'in-app', '2025-10-19 06:35:24', '2025-10-19 06:35:24'),
(92, 28, 25, NULL, NULL, NULL, 'Good morning sir', 'in-app', '2025-10-19 06:35:42', '2025-10-19 06:35:42'),
(93, 28, NULL, NULL, NULL, NULL, 'Goodafternoon', 'in-app', '2025-10-19 06:41:38', '2025-10-19 06:41:38'),
(94, 28, NULL, NULL, NULL, NULL, 'its working again', 'in-app', '2025-10-19 06:43:59', '2025-10-19 06:43:59'),
(95, 28, 25, NULL, NULL, NULL, 'Hey', 'in-app', '2025-10-19 07:40:23', '2025-10-19 07:40:23'),
(96, 28, 25, NULL, NULL, NULL, 'Hey', 'in-app', '2025-10-19 07:40:23', '2025-10-19 07:40:23'),
(97, 28, 25, NULL, NULL, NULL, 'H', 'in-app', '2025-10-19 07:40:35', '2025-10-19 07:40:35'),
(98, 28, NULL, NULL, NULL, NULL, 'reply', 'in-app', '2025-10-19 07:42:40', '2025-10-19 07:42:40'),
(99, 28, 25, NULL, NULL, NULL, 'Try', 'in-app', '2025-10-19 07:43:19', '2025-10-19 07:43:19'),
(100, 34, 23, NULL, NULL, NULL, 'Gm', 'in-app', '2025-10-19 07:57:38', '2025-10-19 07:57:38'),
(101, 34, 23, NULL, NULL, NULL, 'H', 'in-app', '2025-10-19 08:00:14', '2025-10-19 08:00:14'),
(102, 34, 23, NULL, NULL, NULL, 'H', 'in-app', '2025-10-19 08:02:04', '2025-10-19 08:02:04'),
(103, 34, 23, NULL, NULL, NULL, 'Yow', 'in-app', '2025-10-19 08:06:00', '2025-10-19 08:06:00'),
(104, 34, 23, NULL, NULL, NULL, 'Hey', 'in-app', '2025-10-19 08:06:05', '2025-10-19 08:06:05'),
(105, 34, 23, NULL, NULL, NULL, 'Jjjjj', 'in-app', '2025-10-19 08:07:08', '2025-10-19 08:07:08'),
(106, 34, 23, NULL, NULL, NULL, 'Test Message', 'in-app', '2025-10-19 09:10:07', '2025-10-19 09:10:07'),
(107, 34, 23, NULL, NULL, NULL, 'Notif test', 'in-app', '2025-10-19 09:39:05', '2025-10-19 09:39:05'),
(108, 37, 23, NULL, NULL, '+639625003238', 'Hello, Edward Layno', 'in-app', '2025-10-19 12:33:28', '2025-10-19 12:33:28'),
(109, 34, NULL, NULL, NULL, NULL, 'set', 'in-app', '2025-10-19 14:54:48', '2025-10-19 14:54:48'),
(110, 28, NULL, NULL, NULL, NULL, 'l', 'in-app', '2025-10-19 14:56:31', '2025-10-19 14:56:31'),
(111, 33, 29, NULL, NULL, NULL, 'Test', 'in-app', '2025-10-19 21:55:25', '2025-10-19 21:55:25'),
(112, 39, 25, 29, NULL, '09625003238', 'Hello, Admin Edward', 'in-app', '2025-10-19 22:09:35', '2025-10-19 22:09:35'),
(113, 39, 25, 29, NULL, '09625003238', 'Good morning, admin Edward!', 'in-app', '2025-10-19 22:09:52', '2025-10-19 22:09:52'),
(114, 30, 23, 25, NULL, '09683440125', 'Hello, Smoke Register', 'in-app', '2025-10-20 00:40:32', '2025-10-20 00:40:32'),
(115, 39, 25, 29, NULL, '09625003238', 'Hello, Admin Edward', 'in-app', '2025-10-20 01:12:51', '2025-10-20 01:12:51'),
(116, 39, 25, 29, NULL, '09625003238', 'Hello admin edward', 'in-app', '2025-10-20 01:13:00', '2025-10-20 01:13:00'),
(117, 39, 25, 29, NULL, '09625003238', 'Up', 'in-app', '2025-10-20 01:44:47', '2025-10-20 01:44:47'),
(118, 40, 38, 29, NULL, '09625003238', 'Hello, Admin Edward', 'in-app', '2025-10-20 03:31:33', '2025-10-20 03:31:33'),
(119, 40, 38, 29, NULL, '09625003238', 'Hello, admin Edward!', 'in-app', '2025-10-20 03:31:44', '2025-10-20 03:31:44'),
(120, 40, 38, 29, NULL, '09625003238', 'Is there any available parking in pimentel?', 'in-app', '2025-10-20 03:34:19', '2025-10-20 03:34:19'),
(121, 40, 29, NULL, NULL, NULL, 'Yes', 'in-app', '2025-10-20 03:34:36', '2025-10-20 03:34:36'),
(122, 41, 39, 40, NULL, '09913195657', 'Hello, Gate-2', 'in-app', '2025-10-20 04:18:12', '2025-10-20 04:18:12'),
(123, 42, 39, 38, NULL, '+639456641887', 'Hello, Juan Patrick Dela Cruz', 'in-app', '2025-10-20 04:20:19', '2025-10-20 04:20:19'),
(124, 40, 29, NULL, NULL, NULL, 'test', 'in-app', '2025-11-08 17:59:25', '2025-11-08 17:59:25');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
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
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('0145354a-54a0-4c45-a472-d081f5503ad3', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":89,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 04:52:23\"}', NULL, '2025-10-19 04:52:23', '2025-10-19 04:52:23'),
('02136bc6-e343-4e00-b42e-21098d91aa9b', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":12,\"reporter_id\":38,\"report_count\":1,\"created_at\":\"2025-10-20 03:28:59\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/12\"}', NULL, '2025-10-20 03:28:59', '2025-10-20 03:28:59'),
('03035272-1a71-4e41-b78d-c2c2bf02b3b4', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":9,\"reporter_id\":25,\"report_count\":4,\"created_at\":\"2025-10-19 21:32:30\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/9\"}', NULL, '2025-10-19 21:32:30', '2025-10-19 21:32:30'),
('0c35d956-f6a8-447d-be80-6d142bf016ce', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":26,\"parking_slot_id\":61,\"parking_layout_id\":4,\"created_at\":\"2025-10-20 01:20:30\"}', NULL, '2025-10-20 01:20:30', '2025-10-20 01:20:30'),
('0f438cd8-c1a2-4ec3-be42-18596f263b84', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":105,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 08:07:08\"}', NULL, '2025-10-19 08:07:08', '2025-10-19 08:07:08'),
('0f619dd0-b711-4c67-b681-d0d5acb60ae9', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":18,\"parking_slot_id\":61,\"user_id\":25,\"created_at\":\"2025-10-19 12:58:59\"}', NULL, '2025-10-19 12:58:59', '2025-10-19 12:58:59'),
('0f9441b0-5e74-4d7e-abfd-191557b0c75e', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 18, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":7,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-19 16:17:13\"}', NULL, '2025-10-19 16:17:13', '2025-10-19 16:17:13'),
('1185756a-3acb-472b-8d55-293dd776b06e', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":14,\"reporter_id\":38,\"report_count\":3,\"created_at\":\"2025-10-20 03:29:51\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/14\"}', NULL, '2025-10-20 03:29:51', '2025-10-20 03:29:51'),
('12f67aee-64e6-4d5c-a8cf-e7fb4a00bf18', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":8,\"reporter_id\":25,\"report_count\":3,\"created_at\":\"2025-10-19 21:31:45\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/8\"}', NULL, '2025-10-19 21:31:45', '2025-10-19 21:31:45'),
('145ec089-9421-4bf4-97d1-8214b498ea3d', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":96,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 07:40:23\"}', NULL, '2025-10-19 07:40:23', '2025-10-19 07:40:23'),
('18bf1b31-a93b-466c-ba6d-4a712f26f1e2', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":15,\"reporter_id\":38,\"report_count\":1,\"created_at\":\"2025-10-20 03:30:32\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/15\"}', NULL, '2025-10-20 03:30:32', '2025-10-20 03:30:32'),
('1ca1448b-8032-4dc6-80bd-439a2f20e739', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":18,\"parking_slot_id\":61,\"parking_layout_id\":4,\"created_at\":\"2025-10-19 12:58:59\"}', NULL, '2025-10-19 12:58:59', '2025-10-19 12:58:59'),
('233d33d2-3109-4d3e-b536-53294e4301f5', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":12,\"reported_user_id\":25,\"created_at\":\"2025-10-20 03:28:59\"}', NULL, '2025-10-20 03:28:59', '2025-10-20 03:28:59'),
('302275c4-4c4b-46c6-b305-0a3e934e7338', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":5,\"reported_user_id\":null,\"created_at\":\"2025-10-19 21:12:39\"}', NULL, '2025-10-19 21:12:39', '2025-10-19 21:12:39'),
('310251a4-09e2-40ea-b402-5f00f580a17b', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":7,\"reported_user_id\":13,\"created_at\":\"2025-10-19 04:17:04\"}', NULL, '2025-10-19 04:17:04', '2025-10-19 04:17:04'),
('336ed322-eb99-4452-a283-e6376b9c012a', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":39,\"message_id\":116,\"sender_id\":25,\"recipient_id\":29,\"created_at\":\"2025-10-20 01:13:00\"}', NULL, '2025-10-20 01:13:00', '2025-10-20 01:13:00'),
('37f146fb-1ab3-4fd4-b31c-2e232424382d', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":102,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 08:02:04\"}', NULL, '2025-10-19 08:02:04', '2025-10-19 08:02:04'),
('38e9632e-8acc-438a-adbe-a76896f5ee06', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":3,\"parking_slot_id\":1,\"parking_layout_id\":1,\"created_at\":\"2025-10-11 16:57:05\"}', '2025-10-11 10:50:48', '2025-10-11 08:57:05', '2025-10-11 10:50:48'),
('3a8d5762-c20c-47e0-9af6-e093d56f6f83', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":37,\"message_id\":108,\"sender_id\":23,\"recipient_id\":32,\"created_at\":\"2025-10-19 12:33:28\"}', NULL, '2025-10-19 12:33:28', '2025-10-19 12:33:28'),
('4041aab1-99bf-4d06-9599-3ed84a889106', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":4,\"reported_user_id\":null,\"created_at\":\"2025-10-19 21:12:23\"}', NULL, '2025-10-19 21:12:23', '2025-10-19 21:12:23'),
('40e1ac9f-85cc-4615-a91b-8d1dafef89df', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":4,\"reported_user_id\":13,\"created_at\":\"2025-10-18 23:08:10\"}', '2025-10-18 16:39:15', '2025-10-18 15:08:12', '2025-10-18 16:39:15'),
('49926526-5dd5-4cb9-b745-90d23ec5eb68', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":95,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 07:40:23\"}', NULL, '2025-10-19 07:40:23', '2025-10-19 07:40:23'),
('49fe8bf9-5be6-4cd4-8be4-cd994727248b', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":25,\"parking_slot_id\":61,\"parking_layout_id\":4,\"created_at\":\"2025-10-19 20:52:43\"}', NULL, '2025-10-19 20:52:43', '2025-10-19 20:52:43'),
('4e9b9179-ed1b-46e0-abf9-804a6fd857d3', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":15,\"reported_user_id\":25,\"created_at\":\"2025-10-20 03:30:32\"}', NULL, '2025-10-20 03:30:32', '2025-10-20 03:30:32'),
('4ef2800b-cb50-4cce-a013-38397f780798', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":24,\"parking_slot_id\":15,\"user_id\":25,\"created_at\":\"2025-10-19 16:45:51\"}', NULL, '2025-10-19 16:45:51', '2025-10-19 16:45:51'),
('4ffe7685-efa0-4110-aaa5-81778c937ed9', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":2,\"parking_slot_id\":1,\"parking_layout_id\":1,\"created_at\":\"2025-10-11 16:56:05\"}', '2025-10-12 17:23:29', '2025-10-11 08:56:05', '2025-10-12 17:23:29'),
('50014d91-1358-4d12-9dfe-7a5433444604', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":23,\"parking_slot_id\":61,\"user_id\":25,\"created_at\":\"2025-10-19 16:23:24\"}', NULL, '2025-10-19 16:23:24', '2025-10-19 16:23:24'),
('5115ccc5-1f04-444a-805a-d9f75459bfe5', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":9,\"user_id\":25,\"rating\":5,\"created_at\":\"2025-10-19 20:55:01\"}', NULL, '2025-10-19 20:55:01', '2025-10-19 20:55:01'),
('532aade5-a199-4b37-b622-ba09d8c4b5f5', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":39,\"message_id\":115,\"sender_id\":25,\"recipient_id\":29,\"created_at\":\"2025-10-20 01:12:51\"}', NULL, '2025-10-20 01:12:51', '2025-10-20 01:12:51'),
('55938dd7-8f6c-43d0-9332-700517931caf', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":17,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-20 01:17:47\"}', NULL, '2025-10-20 01:17:47', '2025-10-20 01:17:47'),
('5637edd5-db29-43b9-9936-b41efe1f69ad', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":90,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 04:57:10\"}', NULL, '2025-10-19 04:57:10', '2025-10-19 04:57:10'),
('59e25b77-3124-4b16-944a-63990a93e6e5', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 15, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":1,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 07:25:09\",\"admin_user_id\":18,\"link\":\"\\/home\\/incidents\\/1\"}', NULL, '2025-10-19 07:25:09', '2025-10-19 07:25:09'),
('59e9ff00-9269-4dca-929a-d64c597ecd03', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":21,\"parking_slot_id\":51,\"user_id\":25,\"created_at\":\"2025-10-19 14:15:48\"}', NULL, '2025-10-19 14:15:48', '2025-10-19 14:15:48'),
('5c471bf8-3337-4924-b445-36067bc49ac7', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":42,\"message_id\":123,\"sender_id\":39,\"recipient_id\":38,\"created_at\":\"2025-10-20 04:20:19\"}', NULL, '2025-10-20 04:20:19', '2025-10-20 04:20:19'),
('5f1189e0-cb93-4626-a817-4553f89177e1', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":22,\"parking_slot_id\":160,\"user_id\":null,\"created_at\":\"2025-10-19 14:25:31\"}', NULL, '2025-10-19 14:25:31', '2025-10-19 14:25:31'),
('666e9930-5130-42ba-8801-f9fc3a29a471', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 18, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":4,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-18 23:08:54\"}', '2025-10-19 04:43:45', '2025-10-18 15:08:54', '2025-10-19 04:43:45'),
('6e825a74-88bc-4c30-b4c5-21c73ce451ae', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":1,\"reported_user_id\":15,\"created_at\":\"2025-10-19 07:25:09\"}', '2025-10-19 09:38:02', '2025-10-19 07:25:09', '2025-10-19 09:38:02'),
('6f2c9d8a-bba3-4fe3-89de-9943f4331394', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":13,\"reporter_id\":38,\"report_count\":2,\"created_at\":\"2025-10-20 03:29:28\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/13\"}', NULL, '2025-10-20 03:29:28', '2025-10-20 03:29:28'),
('769a2fa2-aa20-42b2-ae99-f3982a493660', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":7,\"reported_user_id\":25,\"created_at\":\"2025-10-19 21:27:12\"}', NULL, '2025-10-19 21:27:12', '2025-10-19 21:27:12'),
('76c843b8-32af-46bc-927e-f317870fb96d', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":14,\"user_id\":25,\"rating\":2,\"created_at\":\"2025-10-19 21:06:25\"}', NULL, '2025-10-19 21:06:25', '2025-10-19 21:06:25'),
('780ab08d-a8c9-40a7-9719-8b143474da49', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 29, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":26,\"parking_slot_id\":61,\"user_id\":25,\"created_at\":\"2025-10-20 01:20:31\"}', NULL, '2025-10-20 01:20:31', '2025-10-20 01:20:31'),
('7810055f-b6e8-40c9-bf09-28abaf849b40', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":107,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 09:39:05\"}', NULL, '2025-10-19 09:39:05', '2025-10-19 09:39:05'),
('7906c543-71ae-423a-a4d2-08d2610807f1', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":87,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 04:32:57\"}', NULL, '2025-10-19 04:32:57', '2025-10-19 04:32:57'),
('7a00c50f-5e99-431d-bbc5-3ed85287fc5e', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 13, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":7,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 04:17:04\",\"admin_user_id\":18,\"link\":\"\\/home\\/incidents\\/7\"}', NULL, '2025-10-19 04:17:04', '2025-10-19 04:17:04'),
('7d56a0f1-3ba6-448c-a0db-af8aa05f447e', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":39,\"message_id\":117,\"sender_id\":25,\"recipient_id\":29,\"created_at\":\"2025-10-20 01:44:47\"}', NULL, '2025-10-20 01:44:47', '2025-10-20 01:44:47'),
('831404b8-6bdd-4d6e-a055-aa245b3f834c', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":20,\"parking_slot_id\":131,\"user_id\":25,\"created_at\":\"2025-10-19 13:52:14\"}', NULL, '2025-10-19 13:52:14', '2025-10-19 13:52:14'),
('8935b306-51f2-4897-802d-bee8d015e698', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":8,\"reported_user_id\":25,\"created_at\":\"2025-10-19 21:31:45\"}', NULL, '2025-10-19 21:31:45', '2025-10-19 21:31:45'),
('89a3e02f-8cbe-4893-9b11-fbaf1789945a', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":41,\"message_id\":122,\"sender_id\":39,\"recipient_id\":40,\"created_at\":\"2025-10-20 04:18:12\"}', NULL, '2025-10-20 04:18:12', '2025-10-20 04:18:12'),
('8d476346-28c9-4a11-b525-3a9bfa1e537d', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":106,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 09:10:07\"}', NULL, '2025-10-19 09:10:07', '2025-10-19 09:10:07'),
('913658f7-a42a-4174-89d6-53f53ad42f14', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":6,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 04:10:00\",\"admin_user_id\":18,\"link\":\"\\/home\\/incidents\\/6\"}', '2025-10-19 12:08:15', '2025-10-19 04:10:00', '2025-10-19 12:08:15'),
('94e6ad4a-1cd0-4ac5-ba32-8bf86f3ac1fd', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":109,\"sender_id\":18,\"recipient_id\":null,\"created_at\":\"2025-10-19 14:54:48\"}', NULL, '2025-10-19 14:54:48', '2025-10-19 14:54:48'),
('954c1a7c-8642-4a5f-b779-0c37fe0782b5', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":10,\"reported_user_id\":null,\"created_at\":\"2025-10-20 01:16:02\"}', NULL, '2025-10-20 01:16:02', '2025-10-20 01:16:02'),
('95b9889d-f790-49b4-92fa-1bedbda2d50e', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":7,\"reporter_id\":25,\"report_count\":2,\"created_at\":\"2025-10-19 21:27:12\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/7\"}', NULL, '2025-10-19 21:27:12', '2025-10-19 21:27:12'),
('9654767b-4b00-4824-bf08-cd93cb17562e', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":88,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 04:33:05\"}', NULL, '2025-10-19 04:33:05', '2025-10-19 04:33:05'),
('971d2ac0-3531-4c8a-b8fb-61cd5c1f9c45', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":6,\"reported_user_id\":25,\"created_at\":\"2025-10-19 21:26:42\"}', NULL, '2025-10-19 21:26:42', '2025-10-19 21:26:42'),
('9a16498b-a664-4afd-9626-1c030c0c1875', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":16,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-20 01:17:09\"}', NULL, '2025-10-20 01:17:09', '2025-10-20 01:17:09'),
('9a3d2006-ac59-4c00-a5f9-c73e5c44005c', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":93,\"sender_id\":18,\"recipient_id\":null,\"created_at\":\"2025-10-19 06:41:38\"}', NULL, '2025-10-19 06:41:38', '2025-10-19 06:41:38'),
('9ad0b15e-9a19-43d9-905e-e926dfbf4493', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":13,\"reported_user_id\":25,\"created_at\":\"2025-10-20 03:29:28\"}', NULL, '2025-10-20 03:29:28', '2025-10-20 03:29:28'),
('9add294f-dec4-41fa-aff5-56411c7f9764', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":100,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 07:57:38\"}', NULL, '2025-10-19 07:57:38', '2025-10-19 07:57:38'),
('9b322262-0378-41f0-939a-a54da6f144fc', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 18, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":5,\"user_id\":18,\"rating\":5,\"created_at\":\"2025-10-19 00:56:06\"}', NULL, '2025-10-18 16:56:06', '2025-10-18 16:56:06'),
('9d13df55-0653-49e9-8cf0-d67f1644fa93', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":33,\"message_id\":111,\"sender_id\":29,\"recipient_id\":null,\"created_at\":\"2025-10-19 21:55:25\"}', NULL, '2025-10-19 21:55:25', '2025-10-19 21:55:25'),
('a49af3b8-3019-4665-a27a-4db4b0abbb32', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 18, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":6,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-19 16:11:31\"}', NULL, '2025-10-19 16:11:31', '2025-10-19 16:11:31'),
('a4e66a8b-5f83-47e7-823e-08b5c37227ff', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":110,\"sender_id\":18,\"recipient_id\":null,\"created_at\":\"2025-10-19 14:56:31\"}', NULL, '2025-10-19 14:56:31', '2025-10-19 14:56:31'),
('a5485a7d-979a-420c-8e8d-4708b4f1c23d', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":5,\"reported_user_id\":25,\"created_at\":\"2025-10-19 02:16:25\"}', NULL, '2025-10-18 18:16:26', '2025-10-18 18:16:26'),
('a588e9ad-879d-44d6-a6e2-3c7793d99bfb', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":30,\"message_id\":114,\"sender_id\":23,\"recipient_id\":25,\"created_at\":\"2025-10-20 00:40:32\"}', NULL, '2025-10-20 00:40:32', '2025-10-20 00:40:32'),
('a5a016e2-969a-439b-bf27-05f50ffe1040', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 29, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":25,\"parking_slot_id\":61,\"user_id\":25,\"created_at\":\"2025-10-19 20:52:43\"}', NULL, '2025-10-19 20:52:43', '2025-10-19 20:52:43'),
('a77df323-af45-49ba-bc7e-2437493253fe', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":11,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-19 20:55:20\"}', NULL, '2025-10-19 20:55:20', '2025-10-19 20:55:20'),
('ac855b11-342d-4a7b-8f9d-b2979d1aaa8c', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":10,\"user_id\":25,\"rating\":5,\"created_at\":\"2025-10-19 20:55:11\"}', NULL, '2025-10-19 20:55:11', '2025-10-19 20:55:11'),
('afc3836d-a147-45f5-8ef8-614c1c6533be', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 17, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":2,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 13:55:08\",\"admin_user_id\":18,\"link\":\"\\/home\\/incidents\\/2\"}', NULL, '2025-10-19 13:55:08', '2025-10-19 13:55:08'),
('b1859430-6c9c-44eb-b839-5ad896de1a93', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":20,\"parking_slot_id\":131,\"parking_layout_id\":5,\"created_at\":\"2025-10-19 13:52:14\"}', NULL, '2025-10-19 13:52:14', '2025-10-19 13:52:14'),
('b798a4bf-180c-437d-9c60-863b6b31faeb', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":13,\"user_id\":0,\"rating\":5,\"created_at\":\"2025-10-19 20:55:39\"}', NULL, '2025-10-19 20:55:39', '2025-10-19 20:55:39'),
('b95d6fda-6401-4228-b507-dd337c7b52df', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":40,\"message_id\":119,\"sender_id\":38,\"recipient_id\":29,\"created_at\":\"2025-10-20 03:31:44\"}', NULL, '2025-10-20 03:31:44', '2025-10-20 03:31:44'),
('bc7d2737-25dc-4aa3-b41f-a5288d25344e', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":4,\"parking_slot_id\":4,\"parking_layout_id\":2,\"created_at\":\"2025-10-18 23:12:12\"}', '2025-10-18 18:24:36', '2025-10-18 15:12:12', '2025-10-18 18:24:36'),
('bc9b99c6-afef-45d3-94dc-c58024e0537e', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":104,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 08:06:05\"}', NULL, '2025-10-19 08:06:05', '2025-10-19 08:06:05'),
('be35d139-44fd-43db-ad7b-aa1ff0dd9df6', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":4,\"parking_slot_id\":4,\"user_id\":25,\"created_at\":\"2025-10-18 23:12:14\"}', NULL, '2025-10-18 15:12:14', '2025-10-18 15:12:14'),
('bfc58d9c-26ce-49ff-8a79-05a7355fc94a', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":12,\"user_id\":25,\"rating\":5,\"created_at\":\"2025-10-19 20:55:32\"}', NULL, '2025-10-19 20:55:32', '2025-10-19 20:55:32'),
('c172b0f3-801a-4ac7-8d02-cc6bd691079e', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":39,\"message_id\":113,\"sender_id\":25,\"recipient_id\":29,\"created_at\":\"2025-10-19 22:09:52\"}', NULL, '2025-10-19 22:09:52', '2025-10-19 22:09:52'),
('c2f18b12-9f0d-496f-98f6-ddcc850c6924', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":98,\"sender_id\":18,\"recipient_id\":null,\"created_at\":\"2025-10-19 07:42:40\"}', NULL, '2025-10-19 07:42:40', '2025-10-19 07:42:40'),
('c61e3d82-229f-441b-b9e2-a04f013943b5', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 39, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":16,\"reporter_id\":38,\"report_count\":1,\"created_at\":\"2025-10-20 04:25:26\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/16\"}', '2025-10-20 04:25:40', '2025-10-20 04:25:26', '2025-10-20 04:25:40'),
('c9299aec-5ab2-41bb-a673-44b7678fb397', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 29, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":15,\"user_id\":25,\"rating\":3,\"created_at\":\"2025-10-20 01:17:04\"}', NULL, '2025-10-20 01:17:04', '2025-10-20 01:17:04'),
('ccd6ec46-3502-4bf0-b7f2-ffda67202f51', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":6,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 21:26:42\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/6\"}', NULL, '2025-10-19 21:26:42', '2025-10-19 21:26:42'),
('cd3e598c-ab71-4f83-adbd-10b7cc9e258b', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":40,\"message_id\":118,\"sender_id\":38,\"recipient_id\":29,\"created_at\":\"2025-10-20 03:31:33\"}', NULL, '2025-10-20 03:31:33', '2025-10-20 03:31:33'),
('d0a38800-e958-4a38-a0b7-ba4ef295c401', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":97,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 07:40:35\"}', NULL, '2025-10-19 07:40:35', '2025-10-19 07:40:35'),
('d0d76041-d29a-43a9-8a2c-acaee5b56c49', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":39,\"message_id\":112,\"sender_id\":25,\"recipient_id\":29,\"created_at\":\"2025-10-19 22:09:35\"}', NULL, '2025-10-19 22:09:35', '2025-10-19 22:09:35'),
('d1ec6ed5-389f-466c-941d-38fe565aac5b', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":14,\"reported_user_id\":25,\"created_at\":\"2025-10-20 03:29:51\"}', NULL, '2025-10-20 03:29:51', '2025-10-20 03:29:51'),
('d3386bcb-543d-4d6a-8af7-179ae85e8eb9', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":5,\"reporter_id\":25,\"report_count\":1,\"created_at\":\"2025-10-19 02:16:26\",\"admin_user_id\":18,\"link\":\"\\/home\\/incidents\\/5\"}', '2025-10-18 18:17:22', '2025-10-18 18:16:26', '2025-10-18 18:17:22'),
('d3af3755-9bbb-4b45-a207-ab9315acf02e', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":99,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 07:43:19\"}', NULL, '2025-10-19 07:43:19', '2025-10-19 07:43:19'),
('d895777f-e6b7-453a-8371-64180e05955c', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":103,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 08:06:00\"}', NULL, '2025-10-19 08:06:00', '2025-10-19 08:06:00'),
('d90f81f5-2936-4565-af5b-e8e4ac536630', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":40,\"message_id\":121,\"sender_id\":29,\"recipient_id\":null,\"created_at\":\"2025-10-20 03:34:36\"}', NULL, '2025-10-20 03:34:36', '2025-10-20 03:34:36'),
('d9e62c42-baec-485f-8fe8-8a3d331d8cfd', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 29, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":40,\"message_id\":120,\"sender_id\":38,\"recipient_id\":29,\"created_at\":\"2025-10-20 03:34:19\"}', NULL, '2025-10-20 03:34:19', '2025-10-20 03:34:19'),
('dc4dd91f-2046-474f-a9f7-69e1d16d9b40', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":92,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 06:35:42\"}', NULL, '2025-10-19 06:35:42', '2025-10-19 06:35:42'),
('de4bbf82-d5ed-48c6-951f-5f450167a526', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":34,\"message_id\":101,\"sender_id\":23,\"recipient_id\":18,\"created_at\":\"2025-10-19 08:00:14\"}', NULL, '2025-10-19 08:00:14', '2025-10-19 08:00:14'),
('e1181cf3-861f-4f87-953b-78166bac1791', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":11,\"reported_user_id\":25,\"created_at\":\"2025-10-20 01:16:31\"}', NULL, '2025-10-20 01:16:31', '2025-10-20 01:16:31'),
('e11bdf64-6888-4734-bf83-8c0693f73162', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":24,\"parking_slot_id\":15,\"parking_layout_id\":3,\"created_at\":\"2025-10-19 16:45:51\"}', NULL, '2025-10-19 16:45:51', '2025-10-19 16:45:51'),
('e2315c96-8787-4ca3-af3b-d85c6c9cb45c', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":9,\"reported_user_id\":25,\"created_at\":\"2025-10-19 21:32:30\"}', NULL, '2025-10-19 21:32:30', '2025-10-19 21:32:30'),
('e39e696d-120e-40e9-9859-252a73555d9b', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":6,\"reported_user_id\":25,\"created_at\":\"2025-10-19 04:10:00\"}', NULL, '2025-10-19 04:10:00', '2025-10-19 04:10:00'),
('e4f7a7a8-fd7c-4432-b3c7-8f8775576565', 'App\\Notifications\\ParkingAssignmentNotification', 'App\\Models\\User', 18, '{\"type\":\"parking_assignment\",\"message\":\"A parking slot was assigned\",\"assignment_id\":19,\"parking_slot_id\":15,\"user_id\":25,\"created_at\":\"2025-10-19 13:36:51\"}', NULL, '2025-10-19 13:36:51', '2025-10-19 13:36:51'),
('e773fb45-dc6f-4a86-827a-66eead70e0f3', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":91,\"sender_id\":25,\"recipient_id\":18,\"created_at\":\"2025-10-19 06:35:24\"}', NULL, '2025-10-19 06:35:24', '2025-10-19 06:35:24'),
('e94fae78-3402-47a0-aab2-37cafb3ea77e', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":21,\"parking_slot_id\":51,\"parking_layout_id\":4,\"created_at\":\"2025-10-19 14:15:48\"}', NULL, '2025-10-19 14:15:48', '2025-10-19 14:15:48'),
('e9aac766-78bf-423e-8323-c4cab766017b', 'App\\Notifications\\InAppMessageNotification', 'App\\Models\\User', 18, '{\"type\":\"in_app_message\",\"message\":\"A new in-app message was sent\",\"conversation_id\":28,\"message_id\":94,\"sender_id\":18,\"recipient_id\":null,\"created_at\":\"2025-10-19 06:43:59\"}', NULL, '2025-10-19 06:43:59', '2025-10-19 06:43:59'),
('ea3d3c4e-5582-4bf5-89d2-76449ce2badc', 'App\\Notifications\\IncidentReportedNotification', 'App\\Models\\User', 25, '{\"type\":\"incident_reported\",\"message\":\"You were named in an incident report\",\"incident_id\":11,\"reporter_id\":25,\"report_count\":5,\"created_at\":\"2025-10-20 01:16:31\",\"admin_user_id\":29,\"link\":\"\\/home\\/incidents\\/11\"}', NULL, '2025-10-20 01:16:31', '2025-10-20 01:16:31'),
('ead7e95f-6378-4e52-b410-3278de50294a', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":23,\"parking_slot_id\":61,\"parking_layout_id\":4,\"created_at\":\"2025-10-19 16:23:24\"}', NULL, '2025-10-19 16:23:24', '2025-10-19 16:23:24'),
('f1595c4a-d1bc-4597-b45c-9130e5b646e6', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 29, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":16,\"reported_user_id\":39,\"created_at\":\"2025-10-20 04:25:26\"}', NULL, '2025-10-20 04:25:26', '2025-10-20 04:25:26'),
('f1d0498a-6f6c-46ec-b111-d7d7c70fea91', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":3,\"reported_user_id\":null,\"created_at\":\"2025-10-19 16:11:06\"}', NULL, '2025-10-19 16:11:06', '2025-10-19 16:11:06'),
('f59aae78-d356-4196-8443-98f02313a3e0', 'App\\Notifications\\FeedbackNotification', 'App\\Models\\User', 18, '{\"type\":\"feedback\",\"message\":\"New feedback submitted\",\"feedback_id\":8,\"user_id\":0,\"rating\":3,\"created_at\":\"2025-10-19 16:17:48\"}', NULL, '2025-10-19 16:17:48', '2025-10-19 16:17:48'),
('fbf599f7-2c60-46d0-b8df-64d13d2d5b18', 'App\\Notifications\\ParkingAssignedNotification', 'App\\Models\\User', 25, '{\"type\":\"parking_assigned\",\"message\":\"A parking slot has been assigned to you\",\"assignment_id\":19,\"parking_slot_id\":15,\"parking_layout_id\":3,\"created_at\":\"2025-10-19 13:36:51\"}', NULL, '2025-10-19 13:36:51', '2025-10-19 13:36:51'),
('fcdd4b69-def3-4b4a-a6bb-a306bbb4e5bf', 'App\\Notifications\\IncidentReportNotification', 'App\\Models\\User', 18, '{\"type\":\"incident_report\",\"message\":\"A new incident was reported\",\"incident_id\":2,\"reported_user_id\":17,\"created_at\":\"2025-10-19 13:55:08\"}', NULL, '2025-10-19 13:55:08', '2025-10-19 13:55:08');

-- --------------------------------------------------------

--
-- Table structure for table `parking_assignments`
--

CREATE TABLE `parking_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parking_slot_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `guest_name` varchar(255) DEFAULT NULL,
  `guest_contact` varchar(255) DEFAULT NULL,
  `faculty_position` varchar(255) DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `vehicle_plate` varchar(255) NOT NULL,
  `vehicle_color` varchar(255) NOT NULL,
  `vehicle_type` varchar(255) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `assignee_type` varchar(255) NOT NULL,
  `assignment_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_assignments`
--

INSERT INTO `parking_assignments` (`id`, `parking_slot_id`, `user_id`, `guest_name`, `guest_contact`, `faculty_position`, `purpose`, `vehicle_plate`, `vehicle_color`, `vehicle_type`, `start_time`, `end_time`, `status`, `created_at`, `updated_at`, `assignee_type`, `assignment_type`) VALUES
(5, 70, NULL, 'James Adrian Celestino', '09193195657', NULL, 'Graduation', 'W1919N', 'Black', 'car', '2025-10-14 10:39:00', '2025-10-14 10:41:43', 'completed', '2025-10-14 10:40:47', '2025-10-14 10:41:43', 'guest', 'assign'),
(6, 69, NULL, 'James Adrian Celestino', '09193195657', NULL, 'Graduation', 'W1919N', 'Black', 'car', '2025-10-14 10:40:00', NULL, 'active', '2025-10-14 10:42:07', '2025-10-14 10:42:30', 'guest', 'assign'),
(7, 161, NULL, 'James Adrian Celestino', '09193195657', NULL, 'Testing', 'W1918N', 'Black', 'car', '2025-10-14 10:55:00', NULL, 'reserved', '2025-10-14 10:57:22', '2025-10-14 10:57:32', 'guest', 'reserve'),
(9, 141, 25, 'Test Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-16 12:07:35', '2025-10-16 04:57:17', 'completed', '2025-10-16 04:07:36', '2025-10-16 04:57:17', 'guest', 'assign'),
(10, 51, 25, 'Test Register', NULL, NULL, 'parking', 'VEH-002', 'Green', 'bicycle', '2025-10-16 13:27:48', '2025-10-16 06:07:32', 'completed', '2025-10-16 05:27:28', '2025-10-16 06:07:32', 'guest', 'assign'),
(12, 61, 25, 'Test Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-16 15:27:23', '2025-10-16 07:28:26', 'completed', '2025-10-16 07:27:24', '2025-10-16 07:28:26', 'guest', 'assign'),
(14, 51, 25, 'Test Register', NULL, NULL, 'parking', 'VEH-002', 'Green', 'bicycle', '2025-10-16 16:43:31', '2025-10-19 12:58:22', 'completed', '2025-10-16 08:43:10', '2025-10-19 12:58:22', 'guest', 'assign'),
(15, 67, NULL, 'Pin', '09913195657', 'Dean', NULL, '889', 'Black', 'car', '2025-10-17 11:18:00', NULL, 'active', '2025-10-17 11:19:21', '2025-10-17 11:19:21', 'faculty', 'assign'),
(16, 61, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-18 09:03:51', '2025-10-18 01:05:48', 'completed', '2025-10-18 01:03:52', '2025-10-18 01:05:48', 'guest', 'assign'),
(17, 61, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-18 12:13:10', '2025-10-18 04:13:58', 'completed', '2025-10-18 04:13:10', '2025-10-18 04:13:58', 'guest', 'assign'),
(18, 61, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-19 20:58:57', '2025-10-19 13:00:47', 'completed', '2025-10-19 12:58:59', '2025-10-19 13:00:47', 'guest', 'assign'),
(19, 15, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-19 21:37:17', '2025-10-19 13:36:58', 'completed', '2025-10-19 13:36:51', '2025-10-19 13:36:58', 'guest', 'assign'),
(21, 51, 25, 'Smoke Register', NULL, NULL, 'parking', 'VEH-002', 'Green', 'bicycle', '2025-10-19 22:16:14', '2025-10-19 14:19:18', 'completed', '2025-10-19 14:15:48', '2025-10-19 14:19:18', 'guest', 'assign'),
(22, 160, NULL, 'Nico Leonardo', '09913195657', NULL, 'd', 'W1910N', 'White', 'car', '2025-10-19 14:23:00', '2025-10-19 14:26:04', 'completed', '2025-10-19 14:25:31', '2025-10-19 14:26:04', 'guest', 'assign'),
(23, 61, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-20 00:23:23', '2025-10-19 16:25:30', 'completed', '2025-10-19 16:23:24', '2025-10-19 16:25:30', 'guest', 'assign'),
(24, 15, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-20 00:45:51', '2025-10-19 16:46:16', 'completed', '2025-10-19 16:45:51', '2025-10-19 16:46:16', 'guest', 'assign'),
(25, 61, 25, 'Smoke Register', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-20 04:52:43', '2025-10-19 20:52:47', 'completed', '2025-10-19 20:52:43', '2025-10-19 20:52:47', 'guest', 'assign'),
(26, 61, 25, 'Smoke Registerr', NULL, NULL, 'parking', 'SMK2464', 'blue', 'car', '2025-10-20 09:20:30', '2025-10-20 01:21:23', 'completed', '2025-10-20 01:20:30', '2025-10-20 01:21:23', 'guest', 'assign');

-- --------------------------------------------------------

--
-- Table structure for table `parking_layouts`
--

CREATE TABLE `parking_layouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `background_image` varchar(255) DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`layout_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parking_layouts`
--

INSERT INTO `parking_layouts` (`id`, `name`, `background_image`, `layout_data`, `created_at`, `updated_at`) VALUES
(3, 'Valencia Hall', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"Space 1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":104,\"position_y\":236,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}},{\"id\":\"space-1760313797155\",\"space_number\":\"Space 1 (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":254,\"position_y\":235,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy)\"}},{\"id\":\"space-1760313798979\",\"space_number\":\"Space 1 (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":404,\"position_y\":237,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy)\"}},{\"id\":\"space-1760313800602\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":258,\"position_y\":434,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy)\"}},{\"id\":\"space-1760313806183\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":105,\"position_y\":437,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\"}},{\"id\":\"space-1760313811674\",\"space_number\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":403,\"position_y\":436,\"width\":92,\"height\":163,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\"}}],\"lines\":[],\"texts\":[]}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(4, 'Pimentel Hall', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"P - M1\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":227,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M1\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355784405\",\"space_number\":\"P - M2\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":277,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M2\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355811669\",\"space_number\":\"P - M3\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":327,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M3\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355851109\",\"space_number\":\"P - M4\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":377,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M4\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355870637\",\"space_number\":\"P - M5\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":78,\"position_y\":427,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M5\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355895965\",\"space_number\":\"P - M6\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":477,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M6\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355912117\",\"space_number\":\"P - M7\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":528,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M7\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355920149\",\"space_number\":\"P - M8\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":577,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M8\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355953404\",\"space_number\":\"P - M9\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":627,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M9\"},\"layout_id\":\"4\"},{\"id\":\"space-1760355970773\",\"space_number\":\"P - M10\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":77,\"position_y\":678,\"width\":71,\"height\":45,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M10\"},\"layout_id\":\"4\"},{\"id\":\"space-30\",\"space_number\":\"P - A1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":878,\"position_y\":228,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A1\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356689917\",\"space_number\":\"P - A2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":802,\"position_y\":228,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A2\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356725109\",\"space_number\":\"P - A3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":728,\"position_y\":229,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A3\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356737533\",\"space_number\":\"P - A4\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":653,\"position_y\":229,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A4\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356745045\",\"space_number\":\"P - A5\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":578,\"position_y\":229,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A5\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356755556\",\"space_number\":\"P - A6\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":503,\"position_y\":229,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A6\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356778204\",\"space_number\":\"P - A7\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":428,\"position_y\":229,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A7\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356790012\",\"space_number\":\"P - A8\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":353,\"position_y\":228,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A8\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356798116\",\"space_number\":\"P - A9\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":278,\"position_y\":228,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A9\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356804463\",\"space_number\":\"P - A10\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":203,\"position_y\":228,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - A10\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356878206\",\"space_number\":\"P - B1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":877,\"position_y\":627,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B1\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356898597\",\"space_number\":\"P - B2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":802,\"position_y\":627,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B2\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356915333\",\"space_number\":\"P - B3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":728,\"position_y\":627,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B3\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356923453\",\"space_number\":\"P - B4\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":653,\"position_y\":627,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B4\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356933125\",\"space_number\":\"P - B5\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":578,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B5\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356946789\",\"space_number\":\"P - B6\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":503,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B6\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356968573\",\"space_number\":\"P - B7\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":428,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B7\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356978188\",\"space_number\":\"P - B8\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":353,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B8\"},\"layout_id\":\"4\"},{\"id\":\"space-1760356991580\",\"space_number\":\"P - B9\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":278,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B9\"},\"layout_id\":\"4\"},{\"id\":\"space-1760357003348\",\"space_number\":\"P - B10\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":203,\"position_y\":628,\"width\":70,\"height\":93,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#10B981\",\"type\":\"standard\",\"name\":\"P - B10\"},\"layout_id\":\"4\"}],\"lines\":[],\"texts\":[{\"id\":1760356548676,\"x\":825,\"y\":443,\"text\":\"ENTRANCE\",\"fontSize\":20,\"fill\":\"#000000\",\"rotation\":90}]}', '2025-10-13 11:56:21', '2025-10-13 12:04:23'),
(7, 'Front of Alvarado Hall', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"FA1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":349,\"position_y\":22,\"width\":76,\"height\":126,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA1\"}},{\"id\":\"space-2\",\"space_number\":\"FA2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":352,\"position_y\":174,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA2\"}},{\"id\":\"space-3\",\"space_number\":\"FA3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":350,\"position_y\":326,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA3\"}},{\"id\":\"space-1760368524457\",\"space_number\":\"FA4\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":477,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA4\"}},{\"id\":\"space-1760368530357\",\"space_number\":\"FA5\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":634,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA5\"}},{\"id\":\"space-1760368542022\",\"space_number\":\"FA6\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":786,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA6\"}},{\"id\":\"space-1760368569220\",\"space_number\":\"FA7\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":942,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA7\"}},{\"id\":\"space-1760368577394\",\"space_number\":\"FA8\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":1096,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA8\"}},{\"id\":\"space-1760368587011\",\"space_number\":\"FA9\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":351,\"position_y\":1251,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA9\"}},{\"id\":\"space-1760368595079\",\"space_number\":\"FA10\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":352,\"position_y\":1406,\"width\":74,\"height\":128,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA10\"}}],\"lines\":[],\"texts\":[]}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(8, 'Front of E-Library', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"FE1\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":167,\"position_y\":302,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE1\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368786247\",\"space_number\":\"FE2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":323,\"position_y\":301,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE2\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368796093\",\"space_number\":\"FE3\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":477,\"position_y\":301,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE3\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368805787\",\"space_number\":\"FE4\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":628,\"position_y\":300,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE4\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368818369\",\"space_number\":\"FE5\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":777,\"position_y\":301,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE5\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368827514\",\"space_number\":\"FE6\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":927,\"position_y\":302,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE6\"},\"layout_id\":\"8\"},{\"id\":\"space-1760368838670\",\"space_number\":\"FE7\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":1084,\"position_y\":303,\"width\":74,\"height\":125,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE7\"},\"layout_id\":\"8\"}],\"lines\":[],\"texts\":[]}', '2025-10-13 15:23:37', '2025-10-14 10:48:01'),
(11, 'Activity Center', NULL, '{\"parking_slots\":[{\"id\":\"space-1\",\"space_number\":\"P B2\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":319,\"position_y\":236,\"width\":97,\"height\":139,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P B2\"}},{\"id\":\"space-1760438780367\",\"space_number\":\"P B2 (Copy)\",\"space_type\":\"standard\",\"space_status\":\"available\",\"position_x\":424,\"position_y\":239,\"width\":97,\"height\":139,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P B2 (Copy)\"}},{\"id\":\"space-3\",\"space_number\":\"Space 3\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":82,\"position_y\":456,\"width\":95,\"height\":124,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"Space 3\"}},{\"id\":\"space-4\",\"space_number\":\"Space 4\",\"space_type\":\"compact\",\"space_status\":\"available\",\"position_x\":322,\"position_y\":455,\"width\":97,\"height\":113,\"rotation\":0,\"metadata\":{\"rotation\":0,\"fill\":\"#110101\",\"type\":\"compact\",\"name\":\"Space 4\"}}],\"lines\":[],\"texts\":[{\"id\":1760438816731,\"x\":538,\"y\":464,\"text\":\"ENTRANCE\",\"fontSize\":16,\"fill\":\"#000000\",\"rotation\":90}]}', '2025-10-14 10:47:35', '2025-10-14 10:47:35');

-- --------------------------------------------------------

--
-- Table structure for table `parking_slots`
--

CREATE TABLE `parking_slots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `layout_id` bigint(20) UNSIGNED NOT NULL,
  `space_number` varchar(255) NOT NULL,
  `space_type` varchar(255) NOT NULL DEFAULT 'standard',
  `space_status` varchar(255) NOT NULL DEFAULT 'available',
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
(15, 3, 'Space 1', 'standard', 'available', 104.00, 236.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1\"}', '2025-10-12 16:05:33', '2025-10-19 16:46:16'),
(16, 3, 'Space 1 (Copy)', 'standard', 'available', 254.00, 235.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(17, 3, 'Space 1 (Copy) (Copy)', 'standard', 'available', 404.00, 237.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(18, 3, 'Space 1 (Copy) (Copy) (Copy)', 'standard', 'available', 258.00, 434.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(19, 3, 'Space 1 (Copy) (Copy) (Copy) (Copy)', 'standard', 'available', 105.00, 437.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(20, 3, 'Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)', 'standard', 'available', 403.00, 436.00, 92.00, 163.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"Space 1 (Copy) (Copy) (Copy) (Copy) (Copy)\"}', '2025-10-12 16:05:33', '2025-10-12 16:05:33'),
(51, 4, 'P - M1', 'compact', 'available', 77.00, 227.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M1\"}', '2025-10-13 12:04:23', '2025-10-19 14:19:18'),
(52, 4, 'P - M2', 'compact', 'available', 77.00, 277.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M2\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(53, 4, 'P - M3', 'compact', 'available', 77.00, 327.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M3\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(54, 4, 'P - M4', 'compact', 'available', 77.00, 377.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M4\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(55, 4, 'P - M5', 'compact', 'available', 78.00, 427.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M5\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(56, 4, 'P - M6', 'compact', 'available', 77.00, 477.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M6\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(57, 4, 'P - M7', 'compact', 'available', 77.00, 528.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M7\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(58, 4, 'P - M8', 'compact', 'available', 77.00, 577.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M8\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(59, 4, 'P - M9', 'compact', 'available', 77.00, 627.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M9\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(60, 4, 'P - M10', 'compact', 'available', 77.00, 678.00, 71.00, 45.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"P - M10\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(61, 4, 'P - A1', 'standard', 'available', 878.00, 228.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A1\"}', '2025-10-13 12:04:23', '2025-10-20 01:21:23'),
(62, 4, 'P - A2', 'standard', 'available', 802.00, 228.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A2\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(63, 4, 'P - A3', 'standard', 'available', 728.00, 229.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A3\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(64, 4, 'P - A4', 'standard', 'available', 653.00, 229.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A4\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(65, 4, 'P - A5', 'standard', 'available', 578.00, 229.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A5\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(66, 4, 'P - A6', 'standard', 'available', 503.00, 229.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A6\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(67, 4, 'P - A7', 'standard', 'occupied', 428.00, 229.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A7\"}', '2025-10-13 12:04:23', '2025-10-17 11:19:21'),
(68, 4, 'P - A8', 'standard', 'available', 353.00, 228.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A8\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(69, 4, 'P - A9', 'standard', 'occupied', 278.00, 228.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A9\"}', '2025-10-13 12:04:23', '2025-10-14 10:42:30'),
(70, 4, 'P - A10', 'standard', 'available', 203.00, 228.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - A10\"}', '2025-10-13 12:04:23', '2025-10-14 10:42:30'),
(71, 4, 'P - B1', 'standard', 'available', 877.00, 627.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B1\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(72, 4, 'P - B2', 'standard', 'available', 802.00, 627.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B2\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(73, 4, 'P - B3', 'standard', 'available', 728.00, 627.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B3\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(74, 4, 'P - B4', 'standard', 'available', 653.00, 627.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B4\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(75, 4, 'P - B5', 'standard', 'available', 578.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B5\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(76, 4, 'P - B6', 'standard', 'available', 503.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B6\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(77, 4, 'P - B7', 'standard', 'available', 428.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B7\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(78, 4, 'P - B8', 'standard', 'available', 353.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B8\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(79, 4, 'P - B9', 'standard', 'available', 278.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B9\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(80, 4, 'P - B10', 'standard', 'available', 203.00, 628.00, 70.00, 93.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P - B10\"}', '2025-10-13 12:04:23', '2025-10-13 12:04:23'),
(141, 7, 'FA1', 'standard', 'available', 349.00, 22.00, 76.00, 126.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA1\"}', '2025-10-13 15:18:15', '2025-10-16 04:57:17'),
(142, 7, 'FA2', 'standard', 'available', 352.00, 174.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA2\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(143, 7, 'FA3', 'standard', 'available', 350.00, 326.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA3\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(144, 7, 'FA4', 'standard', 'available', 351.00, 477.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA4\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(145, 7, 'FA5', 'standard', 'available', 351.00, 634.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA5\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(146, 7, 'FA6', 'standard', 'available', 351.00, 786.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA6\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(147, 7, 'FA7', 'standard', 'available', 351.00, 942.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA7\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(148, 7, 'FA8', 'standard', 'available', 351.00, 1096.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA8\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(149, 7, 'FA9', 'standard', 'available', 351.00, 1251.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA9\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(150, 7, 'FA10', 'standard', 'available', 352.00, 1406.00, 74.00, 128.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FA10\"}', '2025-10-13 15:18:15', '2025-10-13 15:18:15'),
(160, 11, 'P B2', 'standard', 'available', 319.00, 236.00, 97.00, 139.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P B2\"}', '2025-10-14 10:47:35', '2025-10-19 14:26:04'),
(161, 11, 'P B2 (Copy)', 'standard', 'reserved', 424.00, 239.00, 97.00, 139.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"P B2 (Copy)\"}', '2025-10-14 10:47:35', '2025-10-14 10:57:32'),
(162, 11, 'Space 3', 'compact', 'available', 82.00, 456.00, 95.00, 124.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"compact\",\"name\":\"Space 3\"}', '2025-10-14 10:47:35', '2025-10-14 10:47:35'),
(163, 11, 'Space 4', 'compact', 'available', 322.00, 455.00, 97.00, 113.00, 0.00, '{\"rotation\":0,\"fill\":\"#110101\",\"type\":\"compact\",\"name\":\"Space 4\"}', '2025-10-14 10:47:35', '2025-10-14 10:47:35'),
(164, 8, 'FE1', 'standard', 'available', 167.00, 302.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE1\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(165, 8, 'FE2', 'standard', 'available', 323.00, 301.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE2\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(166, 8, 'FE3', 'standard', 'available', 477.00, 301.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE3\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(167, 8, 'FE4', 'standard', 'available', 628.00, 300.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE4\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(168, 8, 'FE5', 'standard', 'available', 777.00, 301.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE5\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(169, 8, 'FE6', 'standard', 'available', 927.00, 302.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE6\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01'),
(170, 8, 'FE7', 'standard', 'available', 1084.00, 303.00, 74.00, 125.00, 0.00, '{\"rotation\":0,\"fill\":\"rgba(0, 255, 0, 0.3)\",\"type\":\"standard\",\"name\":\"FE7\"}', '2025-10-14 10:48:01', '2025-10-14 10:48:01');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
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
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
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
(51, 'App\\Models\\User', 25, 'MyApp', '2dbbce432d4f89b9f98321b8e37dc650b98a31abb8f4d52d4787962f615da96b', '[\"*\"]', '2025-10-12 18:04:04', NULL, '2025-10-12 17:59:30', '2025-10-12 18:04:04'),
(52, 'App\\Models\\User', 18, 'MyApp', '9c36df2380f4f1434fbe75d5ddc30f61ebe71bce847bac4cd3a8c3895199b175', '[\"*\"]', '2025-10-13 12:09:55', NULL, '2025-10-13 11:17:30', '2025-10-13 12:09:55'),
(53, 'App\\Models\\User', 18, 'MyApp', '1a677479e636646419bff7bc0221d4004c2bc4f36c925d5a8edebd84fc817bab', '[\"*\"]', '2025-10-13 12:09:00', NULL, '2025-10-13 11:38:45', '2025-10-13 12:09:00'),
(54, 'App\\Models\\User', 18, 'MyApp', '77f915adb6218cc97fb0ec696a27620e91ae17814805368051f1a2ef5479151c', '[\"*\"]', '2025-10-13 22:57:07', NULL, '2025-10-13 14:22:31', '2025-10-13 22:57:07'),
(55, 'App\\Models\\User', 18, 'MyApp', '540063d4c1b416166d51c175cae485130fe8e762c3dd3664a95b5357a04e69e9', '[\"*\"]', '2025-10-13 15:24:01', NULL, '2025-10-13 14:28:55', '2025-10-13 15:24:01'),
(56, 'App\\Models\\User', 18, 'MyApp', '97a93e1b8aff21379579188185d1a668b1d92ca66562ca783199965e90d3dcf4', '[\"*\"]', '2025-10-13 15:35:33', NULL, '2025-10-13 15:34:39', '2025-10-13 15:35:33'),
(57, 'App\\Models\\User', 18, 'MyApp', 'ac11bd52313c85ea45c90228ea7d8850379bb71dabf022df65ef179b8881c983', '[\"*\"]', '2025-10-13 17:14:12', NULL, '2025-10-13 15:37:27', '2025-10-13 17:14:12'),
(58, 'App\\Models\\User', 18, 'MyApp', 'fa4a77f867157aff973f93ff2567feb87ca1b76740e507a1821dfb5ec78f06b0', '[\"*\"]', NULL, NULL, '2025-10-13 16:56:17', '2025-10-13 16:56:17'),
(59, 'App\\Models\\User', 18, 'MyApp', '22176f0a4fb54d1e550373add37f657557aeba972df6f4850e1b7d5f48f0409e', '[\"*\"]', '2025-10-13 17:05:40', NULL, '2025-10-13 17:01:34', '2025-10-13 17:05:40'),
(60, 'App\\Models\\User', 18, 'MyApp', 'e4499b46b1c38438bc14564f6211928d97bfb16e6bac8bec15f2e7cc55159829', '[\"*\"]', '2025-10-13 17:04:00', NULL, '2025-10-13 17:02:35', '2025-10-13 17:04:00'),
(61, 'App\\Models\\User', 18, 'MyApp', 'd2bb1434626756c6e8555441318a860d273ee3fb56ff89c79348102235717682', '[\"*\"]', '2025-10-13 17:11:52', NULL, '2025-10-13 17:04:19', '2025-10-13 17:11:52'),
(62, 'App\\Models\\User', 18, 'MyApp', 'a5adb0f0c40f00bb9f34072f37a97170229a9de8e94c62cedd68c90e2068a1cf', '[\"*\"]', '2025-10-13 17:13:22', NULL, '2025-10-13 17:08:58', '2025-10-13 17:13:22'),
(63, 'App\\Models\\User', 18, 'MyApp', '6b872093ac3486976b32faf237070c229f72242c500724a432b8243fc473102d', '[\"*\"]', '2025-10-13 17:12:52', NULL, '2025-10-13 17:12:17', '2025-10-13 17:12:52'),
(64, 'App\\Models\\User', 25, 'MyApp', 'eae5e037ac6c6a3ea047cd8d8723edc7a8adf8fa3fbba4f9728a9aba4a40f568', '[\"*\"]', '2025-10-13 19:50:46', NULL, '2025-10-13 19:49:07', '2025-10-13 19:50:46'),
(65, 'App\\Models\\User', 25, 'MyApp', '47408c5b972f44d00d5b17de5e41a17eb8ca98981850ed25666478d152399778', '[\"*\"]', '2025-10-13 19:50:56', NULL, '2025-10-13 19:50:55', '2025-10-13 19:50:56'),
(66, 'App\\Models\\User', 25, 'MyApp', '60e8c1f21e42054d2b325f5e41bd4fd46193d3eabfa288434cd7be132ac6bf29', '[\"*\"]', '2025-10-13 19:51:20', NULL, '2025-10-13 19:51:16', '2025-10-13 19:51:20'),
(67, 'App\\Models\\User', 25, 'MyApp', '4006330c75a9860e17ac5bc9a8cee8bd2e88c4b1f3d49aba71399f2e0812a035', '[\"*\"]', '2025-10-13 20:03:15', NULL, '2025-10-13 19:51:44', '2025-10-13 20:03:15'),
(68, 'App\\Models\\User', 25, 'MyApp', '79ff158a569b5e9b00df4b38c54616baeab5f6ce94396f24a2bbb5edc2cccf7b', '[\"*\"]', '2025-10-13 20:13:47', NULL, '2025-10-13 20:03:41', '2025-10-13 20:13:47'),
(69, 'App\\Models\\User', 25, 'MyApp', 'dcb8eaa8bec0af14f753ec3c0076dbefbbff4e9cc023b3cd65e6b012f7a76969', '[\"*\"]', '2025-10-13 20:22:49', NULL, '2025-10-13 20:13:50', '2025-10-13 20:22:49'),
(70, 'App\\Models\\User', 25, 'MyApp', 'd3af6b59315aaa736144c769058bd39b0bab942f805f1162d4e397e83af54e71', '[\"*\"]', '2025-10-13 20:29:22', NULL, '2025-10-13 20:27:36', '2025-10-13 20:29:22'),
(71, 'App\\Models\\User', 23, 'MyApp', '7b1cf960f9c85975bcb12fd8c1dec31edb1656dd34a5fdf0a597eb9da9e80360', '[\"*\"]', '2025-10-13 20:36:15', NULL, '2025-10-13 20:35:11', '2025-10-13 20:36:15'),
(72, 'App\\Models\\User', 25, 'MyApp', 'd6d4fe082a6cd6666ae74c28a15d85b18af7a93526fb1c07a8ceb8874cb24999', '[\"*\"]', '2025-10-13 20:44:46', NULL, '2025-10-13 20:37:51', '2025-10-13 20:44:46'),
(73, 'App\\Models\\User', 25, 'MyApp', '3dcba69775b90145222c3798ebf2d865533c93f4541649a18c8e5e464d90836b', '[\"*\"]', '2025-10-13 20:45:02', NULL, '2025-10-13 20:45:02', '2025-10-13 20:45:02'),
(74, 'App\\Models\\User', 25, 'MyApp', 'c9677f0b8dd9901cb8798aac00676f1a6becbf143d325fd868f1e038dba11ed4', '[\"*\"]', '2025-10-13 20:45:15', NULL, '2025-10-13 20:45:14', '2025-10-13 20:45:15'),
(75, 'App\\Models\\User', 25, 'MyApp', 'f834a224d5f1a01d66a3c2d4872fa709f36f982c651fd2c6ceccaceb507ba86e', '[\"*\"]', '2025-10-13 20:45:26', NULL, '2025-10-13 20:45:25', '2025-10-13 20:45:26'),
(76, 'App\\Models\\User', 25, 'MyApp', '6abfdc642255988ef80749785c5f38bb58a10836c11c1178ceefb6da1cde73ec', '[\"*\"]', '2025-10-13 20:50:32', NULL, '2025-10-13 20:46:22', '2025-10-13 20:50:32'),
(77, 'App\\Models\\User', 25, 'MyApp', '76f0bc25ff1aa61baa5aa9d81ff32cf6a70c562ec003af31dfde84b5dcfb6afb', '[\"*\"]', '2025-10-13 20:56:20', NULL, '2025-10-13 20:50:35', '2025-10-13 20:56:20'),
(78, 'App\\Models\\User', 25, 'MyApp', '9ac19f583759232c2589f290ddc5133e2c61e3f96e74213e2dff6d510c72349f', '[\"*\"]', '2025-10-13 21:15:25', NULL, '2025-10-13 21:10:25', '2025-10-13 21:15:25'),
(79, 'App\\Models\\User', 25, 'MyApp', '996cb89bda778e35c5a37e481ce698a2a8919b576eb8f16192fa5a1e44c1b0e1', '[\"*\"]', '2025-10-13 21:12:58', NULL, '2025-10-13 21:10:43', '2025-10-13 21:12:58'),
(80, 'App\\Models\\User', 18, 'MyApp', '69c9cce8e4e745f930c8c8e39d1fd03dfeb388375d834d254387ff13bfbaf6cc', '[\"*\"]', '2025-10-13 21:13:21', NULL, '2025-10-13 21:13:05', '2025-10-13 21:13:21'),
(81, 'App\\Models\\User', 25, 'MyApp', '3f6a8c0f0e685eba7ef3ee2ec53a5e544f30edaa2f5f686d705be37da1ddf383', '[\"*\"]', '2025-10-13 21:13:07', NULL, '2025-10-13 21:13:06', '2025-10-13 21:13:07'),
(82, 'App\\Models\\User', 25, 'MyApp', '58ff0edc4274d60b46f1e7441b637dcdb4a4e6676f904c5f62d9293bf03bcbd8', '[\"*\"]', '2025-10-13 21:13:18', NULL, '2025-10-13 21:13:18', '2025-10-13 21:13:18'),
(83, 'App\\Models\\User', 25, 'MyApp', '19a7d2e12f5e9df32998ebe2d719a81c6e426a6c9bf4f519f97c65914277c472', '[\"*\"]', '2025-10-13 21:13:54', NULL, '2025-10-13 21:13:53', '2025-10-13 21:13:54'),
(84, 'App\\Models\\User', 25, 'MyApp', '83790679a83ab073b6d7dca333976a40a0fa5ec2d72b4018dbd1a603263ec3a8', '[\"*\"]', '2025-10-13 21:22:19', NULL, '2025-10-13 21:14:21', '2025-10-13 21:22:19'),
(85, 'App\\Models\\User', 25, 'MyApp', 'a70d78460095cc3b4d81cd5f9367f38bb5b05ecf9806cb147dc50c663d50a978', '[\"*\"]', '2025-10-13 21:23:05', NULL, '2025-10-13 21:22:20', '2025-10-13 21:23:05'),
(86, 'App\\Models\\User', 25, 'MyApp', 'e1b6e98edc3bc3e2c0cb557ba85aa477fa598502973692ffc2675d601fc33f0b', '[\"*\"]', '2025-10-13 21:54:16', NULL, '2025-10-13 21:51:22', '2025-10-13 21:54:16'),
(87, 'App\\Models\\User', 25, 'MyApp', '6cf6e45b75fc87092f05252dba936c63cccf6c4d9f837c6b913c97a1776e0239', '[\"*\"]', '2025-10-13 22:03:50', NULL, '2025-10-13 21:59:04', '2025-10-13 22:03:50'),
(88, 'App\\Models\\User', 25, 'MyApp', '0160a86ea54fbcebea14672e367edfd817886920193b24c30977d545aece6acc', '[\"*\"]', '2025-10-13 22:04:12', NULL, '2025-10-13 22:03:09', '2025-10-13 22:04:12'),
(89, 'App\\Models\\User', 25, 'MyApp', '1eabd5f1ed7bb0b6fe52a8725dc62f75f26bdefd939eab919e323840f92c1c8b', '[\"*\"]', '2025-10-13 22:37:02', NULL, '2025-10-13 22:05:47', '2025-10-13 22:37:02'),
(90, 'App\\Models\\User', 23, 'MyApp', '3dd765e75c04cf3d742640006609f5dceeb7411483adf56e5833fce0a45b6526', '[\"*\"]', '2025-10-13 22:06:21', NULL, '2025-10-13 22:06:20', '2025-10-13 22:06:21'),
(91, 'App\\Models\\User', 25, 'MyApp', '16f869b045d7ca5da08d33cd072dfcb794832aed6b5a666b5f519ab26892b4c2', '[\"*\"]', '2025-10-13 22:20:23', NULL, '2025-10-13 22:20:14', '2025-10-13 22:20:23'),
(92, 'App\\Models\\User', 29, 'MyApp', '755cf089f54ebd369870e7d4db2f80d4d78f880d0373440bbed8c47dd6775368', '[\"*\"]', NULL, NULL, '2025-10-13 22:22:56', '2025-10-13 22:22:56'),
(93, 'App\\Models\\User', 30, 'MyApp', '6a11fc5bf96462978c33e56d76a4016543b4c1f49ba35036767fe74e48d80c23', '[\"*\"]', NULL, NULL, '2025-10-13 22:33:40', '2025-10-13 22:33:40'),
(94, 'App\\Models\\User', 25, 'MyApp', 'f960b1c7cb34349cdbc0cbabd1c8b284396816aefa0ca274f5b2d433cdd65fb0', '[\"*\"]', '2025-10-13 22:51:34', NULL, '2025-10-13 22:37:07', '2025-10-13 22:51:34'),
(95, 'App\\Models\\User', 25, 'MyApp', 'cecd0ef9f898f708ff96dea8d4e43eb163894875b4a13ca0882987065d47adec', '[\"*\"]', '2025-10-13 22:39:26', NULL, '2025-10-13 22:38:04', '2025-10-13 22:39:26'),
(96, 'App\\Models\\User', 25, 'MyApp', 'ca8d04efb1fe347aff79b89eac675b53a56e104c306809e206692310ed7e7234', '[\"*\"]', '2025-10-13 22:39:31', NULL, '2025-10-13 22:39:26', '2025-10-13 22:39:31'),
(97, 'App\\Models\\User', 23, 'MyApp', '2fc8f7d4a2d70452c59feb2ae5778c025fb6e05acc27351d7cb2101866844a49', '[\"*\"]', '2025-10-13 22:52:44', NULL, '2025-10-13 22:51:37', '2025-10-13 22:52:44'),
(98, 'App\\Models\\User', 23, 'MyApp', '27dd6bee5b0af47508d9ec5bea648f096870003bee7fd9827a7a09028a1a71d5', '[\"*\"]', '2025-10-13 22:53:20', NULL, '2025-10-13 22:53:18', '2025-10-13 22:53:20'),
(99, 'App\\Models\\User', 23, 'MyApp', 'aac52dc047f10370acdea530ee8864585e399f3b8be3ae163e3428d38f88d254', '[\"*\"]', '2025-10-13 22:53:59', NULL, '2025-10-13 22:53:59', '2025-10-13 22:53:59'),
(100, 'App\\Models\\User', 23, 'MyApp', 'ad9e2604763b8bb3181eb1e515383e3a83982b2accccfd0da7796ede10c064c0', '[\"*\"]', '2025-10-13 23:00:11', NULL, '2025-10-13 23:00:08', '2025-10-13 23:00:11'),
(101, 'App\\Models\\User', 23, 'MyApp', 'b072c2e0acdfa0cef6cc6dd2a68c2a953e1f6e1b67bef144838289619d977f42', '[\"*\"]', '2025-10-13 23:22:05', NULL, '2025-10-13 23:22:03', '2025-10-13 23:22:05'),
(102, 'App\\Models\\User', 18, 'MyApp', 'eb08ac6d08b793be7f5c4fac3584f3c13979e9d18d5d557a452ecaf2cca3154f', '[\"*\"]', '2025-10-13 23:28:02', NULL, '2025-10-13 23:23:36', '2025-10-13 23:28:02'),
(103, 'App\\Models\\User', 25, 'MyApp', 'f405a7f747cd8c78fc661f3bccc5838376fada1d6136400bb14f356ff130d29f', '[\"*\"]', '2025-10-13 23:26:14', NULL, '2025-10-13 23:26:13', '2025-10-13 23:26:14'),
(104, 'App\\Models\\User', 23, 'MyApp', 'defddf1c7c7565321dc363ce7d893a7b6ebacafa37c4307b0d9a39654d085e0c', '[\"*\"]', '2025-10-13 23:28:51', NULL, '2025-10-13 23:26:24', '2025-10-13 23:28:51'),
(105, 'App\\Models\\User', 23, 'MyApp', '9af22b94becba5e4fa9b30d712bda3131cd7526c1008a18b0b91b9c2d7e0fbe0', '[\"*\"]', NULL, NULL, '2025-10-13 23:36:42', '2025-10-13 23:36:42'),
(106, 'App\\Models\\User', 23, 'MyApp', '5ea5171af4dd1fae7ebf3df10f74dc7fac06a5048d64ba12168332cfcfe9b716', '[\"*\"]', '2025-10-13 23:40:36', NULL, '2025-10-13 23:40:34', '2025-10-13 23:40:36'),
(107, 'App\\Models\\User', 23, 'MyApp', '6272f1918973b3f2b6e6d05c3dccf800466b28b921bae5d233aa8d1a1bd9437c', '[\"*\"]', '2025-10-13 23:42:02', NULL, '2025-10-13 23:42:00', '2025-10-13 23:42:02'),
(108, 'App\\Models\\User', 23, 'MyApp', '3aadc9f88a42f297336611a66046cf9e52c6eab1f39fceaca3bcd8b49fe9d5ac', '[\"*\"]', '2025-10-13 23:47:38', NULL, '2025-10-13 23:46:50', '2025-10-13 23:47:38'),
(109, 'App\\Models\\User', 23, 'MyApp', '4104c33319945c91b60f481d6ad6502f907bd756127b1529cc099714c6b326a9', '[\"*\"]', '2025-10-13 23:57:19', NULL, '2025-10-13 23:47:29', '2025-10-13 23:57:19'),
(110, 'App\\Models\\User', 25, 'MyApp', '1c91f35d780ea88f4539d1904a3bc594417c78b158e90c1eb2e9244b744d0c18', '[\"*\"]', '2025-10-14 00:58:20', NULL, '2025-10-13 23:58:20', '2025-10-14 00:58:20'),
(111, 'App\\Models\\User', 25, 'MyApp', '3ae8e1afded7f776bd7351d4e92d4c72876f86e3009551603abe3f20c13f0e82', '[\"*\"]', '2025-10-14 01:06:52', NULL, '2025-10-14 00:58:24', '2025-10-14 01:06:52'),
(112, 'App\\Models\\User', 18, 'MyApp', '09357d51e6f523b37de3463b0868395ba1d7228558cf75b0649e65c555268580', '[\"*\"]', '2025-10-14 01:06:55', NULL, '2025-10-14 01:00:22', '2025-10-14 01:06:55'),
(113, 'App\\Models\\User', 23, 'MyApp', '60f0d5275098d2996fa0fa39c78125de3c2aa9bb395b29414bdab874fb47e1a6', '[\"*\"]', '2025-10-14 01:04:58', NULL, '2025-10-14 01:04:36', '2025-10-14 01:04:58'),
(114, 'App\\Models\\User', 23, 'MyApp', '6d99918cd4d1904a10fc8ee306bf13033d12e06eeeefba84910d139444a03c34', '[\"*\"]', '2025-10-14 01:05:25', NULL, '2025-10-14 01:05:23', '2025-10-14 01:05:25'),
(115, 'App\\Models\\User', 23, 'MyApp', 'a2d063cf05938723058d1b62589be2681ccb8dd93b31fc3a3ac15d7ca4558cc8', '[\"*\"]', '2025-10-14 01:05:38', NULL, '2025-10-14 01:05:36', '2025-10-14 01:05:38'),
(116, 'App\\Models\\User', 31, 'MyApp', '6005b67fc8193435b23d36c47ff7932fee2d1da2f60563880db72a30c80f6bf3', '[\"*\"]', NULL, NULL, '2025-10-14 01:22:08', '2025-10-14 01:22:08'),
(117, 'App\\Models\\User', 31, 'MyApp', '74272b0f505f68bdb4b525e69d1811aabba0adf2d34c8b349ee98e463b49c7ec', '[\"*\"]', '2025-10-14 01:23:53', NULL, '2025-10-14 01:22:51', '2025-10-14 01:23:53'),
(118, 'App\\Models\\User', 23, 'MyApp', '5e10a40202cba329bc544c6a08903769e9b18a5d1a5c2b3040a3a422a4292f5d', '[\"*\"]', '2025-10-14 01:32:43', NULL, '2025-10-14 01:32:40', '2025-10-14 01:32:43'),
(119, 'App\\Models\\User', 18, 'MyApp', 'a833e6162a4f1e07d596a27f6ab2ca03529ac3a84fe6a453b2de0c8bec8e5591', '[\"*\"]', '2025-10-15 00:22:54', NULL, '2025-10-14 01:41:19', '2025-10-15 00:22:54'),
(120, 'App\\Models\\User', 18, 'MyApp', '2382cf3a83c77649c874c134bc018bbe6b629e076829697b58083dc0799edc7e', '[\"*\"]', '2025-10-14 02:15:09', NULL, '2025-10-14 02:03:41', '2025-10-14 02:15:09'),
(121, 'App\\Models\\User', 18, 'MyApp', 'cf83ddcc67359fc1b28e410896f8f8eff91f935661df90892908fd391890c2e1', '[\"*\"]', NULL, NULL, '2025-10-14 02:16:06', '2025-10-14 02:16:06'),
(122, 'App\\Models\\User', 25, 'MyApp', '600d781b9966de4f5299194f757c597dfe021aae87b64c4fd2ce38f21c616e2c', '[\"*\"]', '2025-10-14 02:19:59', NULL, '2025-10-14 02:19:58', '2025-10-14 02:19:59'),
(123, 'App\\Models\\User', 25, 'MyApp', '0bab02c92dae34b3cca874a5e96fd329c1914cb7d6a31a7814c47606d7807b88', '[\"*\"]', '2025-10-14 02:21:42', NULL, '2025-10-14 02:20:02', '2025-10-14 02:21:42'),
(124, 'App\\Models\\User', 23, 'MyApp', '850b3691d75b7fcd479a9fbd6b28c6fa24b93f4a509461520aa4fd47df5ccb4c', '[\"*\"]', '2025-10-14 02:21:53', NULL, '2025-10-14 02:21:49', '2025-10-14 02:21:53'),
(125, 'App\\Models\\User', 23, 'MyApp', 'eb983ea30c256b80362ee17a0fd1d6819b9b52a95449facd2a084c107d649462', '[\"*\"]', '2025-10-14 02:26:01', NULL, '2025-10-14 02:25:59', '2025-10-14 02:26:01'),
(126, 'App\\Models\\User', 18, 'MyApp', 'df184cc8f1475c72d34f23557662f7eb31e426d4f9b7aeadf500079dedcb18f8', '[\"*\"]', '2025-10-14 02:50:43', NULL, '2025-10-14 02:50:43', '2025-10-14 02:50:43'),
(127, 'App\\Models\\User', 18, 'MyApp', '975ffcc7575177228df6c7d68204657c28989d6061ac00c2445226a6c116e717', '[\"*\"]', '2025-10-14 02:56:21', NULL, '2025-10-14 02:56:19', '2025-10-14 02:56:21'),
(128, 'App\\Models\\User', 18, 'MyApp', '5ea5e2503a10ca49f86b738e46ac295c2f3110292480d2d1327ec37457286307', '[\"*\"]', '2025-10-14 02:58:47', NULL, '2025-10-14 02:58:46', '2025-10-14 02:58:47'),
(129, 'App\\Models\\User', 18, 'MyApp', '2e73c311fd5cd827b0ff0586833e6815f31b2a8a007ab7e03d3325e2a923b16f', '[\"*\"]', '2025-10-14 03:07:16', NULL, '2025-10-14 03:07:15', '2025-10-14 03:07:16'),
(130, 'App\\Models\\User', 18, 'MyApp', '01149e19b439453a56dff7b28bfb3d3c083665cf6bca0cea65128d6ca7471013', '[\"*\"]', '2025-10-14 03:12:56', NULL, '2025-10-14 03:12:55', '2025-10-14 03:12:56'),
(131, 'App\\Models\\User', 18, 'MyApp', 'f7d4ef42a6520b9a95a733e3ff2e8bbd3af7e8260514ac624231a3be14c3f543', '[\"*\"]', NULL, NULL, '2025-10-14 03:27:00', '2025-10-14 03:27:00'),
(132, 'App\\Models\\User', 18, 'MyApp', '70c6ef4d333c37409ad1b296349b89ec79e771d93f8140496f8f154e2dae7e7c', '[\"*\"]', NULL, NULL, '2025-10-14 07:23:04', '2025-10-14 07:23:04'),
(133, 'App\\Models\\User', 18, 'MyApp', 'd1bd4022d5e51c1994518cd6fb6412aba0e9bcb816a66b59b6bc8293cdf59908', '[\"*\"]', NULL, NULL, '2025-10-14 08:33:27', '2025-10-14 08:33:27'),
(134, 'App\\Models\\User', 18, 'MyApp', '9d2c79a2910573e28bdddf7d7db21afc77075db67e2b019f107cab7090946fc9', '[\"*\"]', NULL, NULL, '2025-10-14 08:45:25', '2025-10-14 08:45:25'),
(135, 'App\\Models\\User', 18, 'MyApp', '0044faff29f966cc415d1473b38485b8d6f4691274daae6647595622636a8c28', '[\"*\"]', '2025-10-14 10:06:01', NULL, '2025-10-14 08:45:25', '2025-10-14 10:06:01'),
(136, 'App\\Models\\User', 23, 'MyApp', 'e4d171cbd9c43054da9972798b7cb5018c3e53bd107a9d7f81123a1f25fceaac', '[\"*\"]', '2025-10-14 08:47:03', NULL, '2025-10-14 08:47:03', '2025-10-14 08:47:03'),
(137, 'App\\Models\\User', 18, 'MyApp', '06d26999e4ddf6e6fb1ce69aa219d97efa63036d81c5d18cf6c8cb895b8846c6', '[\"*\"]', NULL, NULL, '2025-10-14 08:48:09', '2025-10-14 08:48:09'),
(138, 'App\\Models\\User', 18, 'MyApp', '5c307306be13d9452f974d55b27b2519545f22f5f63fc7ff8a903fccd85f7def', '[\"*\"]', '2025-10-14 09:53:07', NULL, '2025-10-14 08:57:02', '2025-10-14 09:53:07'),
(139, 'App\\Models\\User', 25, 'MyApp', '5e417bb3030c092785f2a6f4766f73e5d3b67ac68543b8fd68e15f5e018bd60a', '[\"*\"]', '2025-10-14 09:24:46', NULL, '2025-10-14 09:23:36', '2025-10-14 09:24:46'),
(140, 'App\\Models\\User', 25, 'MyApp', '19d5c1c27e50eb71f53fa70348c1a5b8d1caebf79ddfcb8dbf4e97c51f356728', '[\"*\"]', '2025-10-14 09:24:13', NULL, '2025-10-14 09:23:50', '2025-10-14 09:24:13'),
(141, 'App\\Models\\User', 23, 'MyApp', 'a559e63d068edce99f8d727130d35162a307a7f873e7c56ab64a13ab7777cba9', '[\"*\"]', '2025-10-14 09:25:09', NULL, '2025-10-14 09:24:55', '2025-10-14 09:25:09'),
(142, 'App\\Models\\User', 23, 'MyApp', '0878a224b291312ed74515d1bf99017c85393f424e0235361ed27b20cb797009', '[\"*\"]', '2025-10-14 09:27:30', NULL, '2025-10-14 09:26:44', '2025-10-14 09:27:30'),
(143, 'App\\Models\\User', 23, 'MyApp', '0a7f43d2d9cf5117c77bd7a56484273e8dddb158d64a3069b5e36c0421314921', '[\"*\"]', '2025-10-14 10:07:46', NULL, '2025-10-14 10:07:44', '2025-10-14 10:07:46'),
(144, 'App\\Models\\User', 23, 'MyApp', '226e5f1a692189fd0e3810d47aa35979a739b03d290481f9e4a15fccb400029d', '[\"*\"]', '2025-10-14 10:27:51', NULL, '2025-10-14 10:27:50', '2025-10-14 10:27:51'),
(145, 'App\\Models\\User', 18, 'MyApp', 'c56af1d96fdbc055d02951b679e027f25fbea369be60142ca1c3ff4f29f7e624', '[\"*\"]', '2025-10-14 11:09:06', NULL, '2025-10-14 10:39:11', '2025-10-14 11:09:06'),
(146, 'App\\Models\\User', 23, 'MyApp', '4a1d83ce3d64d9c6d3dc38bcc62616c1ff70a031419cfc7cc836ed8be10f3f3c', '[\"*\"]', '2025-10-14 10:44:41', NULL, '2025-10-14 10:44:33', '2025-10-14 10:44:41'),
(147, 'App\\Models\\User', 23, 'MyApp', 'd51b1acf0333500b36644e4c4274ff31cd7e93eddcf8b28a82f8b706fea66ca9', '[\"*\"]', '2025-10-14 10:48:42', NULL, '2025-10-14 10:48:39', '2025-10-14 10:48:42'),
(148, 'App\\Models\\User', 23, 'MyApp', 'f81be2c16334e42890c7716eff28a99c821f59314ad93d76ec97824ee17d8565', '[\"*\"]', '2025-10-14 10:54:27', NULL, '2025-10-14 10:50:24', '2025-10-14 10:54:27'),
(149, 'App\\Models\\User', 25, 'MyApp', 'e6795a22449e73ec50a1d0009ee6d401d394b983f48c08f8470355f3bf15eacd', '[\"*\"]', '2025-10-14 11:11:20', NULL, '2025-10-14 10:56:04', '2025-10-14 11:11:20'),
(150, 'App\\Models\\User', 25, 'MyApp', '1b7e1fd6cba69a8431e24382935e5082475b7754f5e6d48be26525bd1bd7c909', '[\"*\"]', '2025-10-14 12:22:46', NULL, '2025-10-14 12:22:24', '2025-10-14 12:22:46'),
(151, 'App\\Models\\User', 18, 'MyApp', '36aa3cdf0896d4f2c773e760322ebaa49861373cbc38bf426d8e36655848b252', '[\"*\"]', NULL, NULL, '2025-10-14 12:43:32', '2025-10-14 12:43:32'),
(152, 'App\\Models\\User', 18, 'MyApp', '6c1937ffcd8192d51f7dfcdb30572305c7a8f68a93778131e9adb8900c9079cd', '[\"*\"]', NULL, NULL, '2025-10-15 00:08:01', '2025-10-15 00:08:01'),
(153, 'App\\Models\\User', 18, 'MyApp', '223e97d64a13d126cce28fc19385bca51c458ddf27332244d32b817a60c62947', '[\"*\"]', NULL, NULL, '2025-10-15 00:51:44', '2025-10-15 00:51:44'),
(154, 'App\\Models\\User', 18, 'MyApp', '57bde9af96471d17cb87f297e4af9acb19d4284a89bd9c3d974a729c8b6d2972', '[\"*\"]', '2025-10-15 01:55:01', NULL, '2025-10-15 01:09:14', '2025-10-15 01:55:01'),
(155, 'App\\Models\\User', 18, 'MyApp', '5af3b8ad28be8aa68dba1a7de39fdc478e1448eb06acbab0295236b7dec2c797', '[\"*\"]', '2025-10-15 02:42:42', NULL, '2025-10-15 02:13:12', '2025-10-15 02:42:42'),
(156, 'App\\Models\\User', 18, 'MyApp', '51b90aa4845ea030aaea8a6772552f1795e3affc6ed73f056b51ac1fce5e9ad2', '[\"*\"]', '2025-10-15 04:17:49', NULL, '2025-10-15 02:48:17', '2025-10-15 04:17:49'),
(157, 'App\\Models\\User', 23, 'MyApp', '0d5fadfdd8c0a61572dfe831c1a6a8091d808ef312604b91c9dc8e319788e634', '[\"*\"]', '2025-10-15 04:15:31', NULL, '2025-10-15 04:15:02', '2025-10-15 04:15:31'),
(158, 'App\\Models\\User', 25, 'MyApp', '7ab4160c59ca0d95bcfcce30603eab82716a92104679511c768e60fe373321bc', '[\"*\"]', '2025-10-15 09:30:42', NULL, '2025-10-15 04:42:50', '2025-10-15 09:30:42'),
(159, 'App\\Models\\User', 25, 'MyApp', '620730330acb8c5d2712a3ad058d1c60fb55ed25efab013c94d2262b7e839918', '[\"*\"]', '2025-10-15 05:18:31', NULL, '2025-10-15 05:17:57', '2025-10-15 05:18:31'),
(160, 'App\\Models\\User', 25, 'MyApp', '764be088f005b97dd66f26cee88352ff8b59491724020484f341f3feaf828040', '[\"*\"]', '2025-10-15 09:17:04', NULL, '2025-10-15 09:16:44', '2025-10-15 09:17:04'),
(161, 'App\\Models\\User', 25, 'MyApp', 'e91631f019b706a1e51ba163096e39ce65ae545086142382afc012c92d0f0a96', '[\"*\"]', '2025-10-15 13:10:42', NULL, '2025-10-15 13:10:16', '2025-10-15 13:10:42'),
(162, 'App\\Models\\User', 25, 'MyApp', '8498fce2376ea95cadb5376b32c4761b5bb166ef5f200881a3425da64e91d810', '[\"*\"]', '2025-10-15 13:17:36', NULL, '2025-10-15 13:11:11', '2025-10-15 13:17:36'),
(163, 'App\\Models\\User', 23, 'MyApp', '19de101e8a38ce7251b96b28e7beb73a7f7b61640b0a743aeb076c87865c78c2', '[\"*\"]', '2025-10-15 13:24:08', NULL, '2025-10-15 13:17:39', '2025-10-15 13:24:08'),
(164, 'App\\Models\\User', 23, 'MyApp', 'e30048b6cab71fdb6a12b7d7cf4bdb65bae4aff11488cd179accd41cedfcee20', '[\"*\"]', '2025-10-15 13:24:45', NULL, '2025-10-15 13:24:41', '2025-10-15 13:24:45'),
(165, 'App\\Models\\User', 23, 'MyApp', '89817df4f3cfcf52151608306f9187c067f160f1b84b83f15382fec8e0d3ec46', '[\"*\"]', '2025-10-15 13:32:22', NULL, '2025-10-15 13:26:54', '2025-10-15 13:32:22'),
(166, 'App\\Models\\User', 25, 'MyApp', 'ccc22c79e8e3c65703c1f55f56c230ef50069d0cc2599722ba17f51c12f2147b', '[\"*\"]', '2025-10-15 13:46:56', NULL, '2025-10-15 13:32:55', '2025-10-15 13:46:56'),
(167, 'App\\Models\\User', 23, 'MyApp', '63d5745c901a0206253026f844431a63068a6a5ab718c8fb3eac40af65c4bb4d', '[\"*\"]', '2025-10-15 21:53:48', NULL, '2025-10-15 21:51:40', '2025-10-15 21:53:48'),
(168, 'App\\Models\\User', 23, 'MyApp', 'e7ee86005c0624325b773bac9e6e00e6dab5f3d85c2c56546b242b536fb2649c', '[\"*\"]', '2025-10-15 23:33:11', NULL, '2025-10-15 23:33:08', '2025-10-15 23:33:11'),
(169, 'App\\Models\\User', 23, 'MyApp', '66dea7c54f6f4c7a7ae476b7c57a5658d9c768211a4ccf270df4b8cfa79263ca', '[\"*\"]', '2025-10-15 23:59:56', NULL, '2025-10-15 23:59:54', '2025-10-15 23:59:56'),
(170, 'App\\Models\\User', 23, 'MyApp', 'cd17654b0c3b28511162b9eb91a073213a9308637ce5125bbd723a4913790ae8', '[\"*\"]', '2025-10-16 00:02:37', NULL, '2025-10-16 00:02:35', '2025-10-16 00:02:37'),
(171, 'App\\Models\\User', 23, 'MyApp', '3d7924f995eac6145eb0ff8a6cc1797ce12bba258b3f2af6d29906ffdf2e6bae', '[\"*\"]', '2025-10-16 00:03:28', NULL, '2025-10-16 00:03:26', '2025-10-16 00:03:28'),
(172, 'App\\Models\\User', 23, 'MyApp', '6c61d230b5ccc6c94545885c9f90ecea43d41ab8884730cef95b312568867754', '[\"*\"]', '2025-10-16 00:20:23', NULL, '2025-10-16 00:20:21', '2025-10-16 00:20:23'),
(173, 'App\\Models\\User', 23, 'MyApp', '16a60b7cc6d08eec542eea14f3aea25df2f504e052f6bd5a2729dc9b84dea732', '[\"*\"]', '2025-10-16 00:39:47', NULL, '2025-10-16 00:39:43', '2025-10-16 00:39:47'),
(174, 'App\\Models\\User', 23, 'MyApp', '89b1545318b68b5b4d713cc4ecaf67c61b78f76ae8b1683337b2fb042126c29e', '[\"*\"]', '2025-10-16 01:56:01', NULL, '2025-10-16 01:55:58', '2025-10-16 01:56:01'),
(175, 'App\\Models\\User', 23, 'MyApp', '3fea9dcb39488881df05ef8ef4311c32468ac0c580e292739219e77d234f7e2c', '[\"*\"]', '2025-10-16 02:25:35', NULL, '2025-10-16 02:25:33', '2025-10-16 02:25:35'),
(176, 'App\\Models\\User', 23, 'MyApp', '7793c5e1e10e5940af25b0379f80d45d38b1e459ced75e10627177ddd09a323f', '[\"*\"]', '2025-10-16 03:19:01', NULL, '2025-10-16 03:18:58', '2025-10-16 03:19:01'),
(177, 'App\\Models\\User', 25, 'MyApp', 'cefafa14eea68fab5449c2fe470b9d46bda8c05ed24417c628f6221f51d9b0b4', '[\"*\"]', '2025-10-16 03:54:46', NULL, '2025-10-16 03:53:01', '2025-10-16 03:54:46'),
(178, 'App\\Models\\User', 23, 'MyApp', 'c26ed13ba8770dd2119c92b01ff6a5e7670a546f3cb038830e8cb6d0da06a14c', '[\"*\"]', '2025-10-16 03:57:16', NULL, '2025-10-16 03:54:53', '2025-10-16 03:57:16'),
(179, 'App\\Models\\User', 23, 'MyApp', '87c7ba7a2f0cb848bc0f43e91a4d9f75129c220125463eb682d4810f25b79872', '[\"*\"]', '2025-10-16 04:09:16', NULL, '2025-10-16 03:57:17', '2025-10-16 04:09:16'),
(180, 'App\\Models\\User', 25, 'MyApp', 'b8ac3efd9cfc14cb8fc34944e8cc918a06f2e57f3e45e0e15062c97743e5f179', '[\"*\"]', '2025-10-16 04:03:00', NULL, '2025-10-16 04:02:48', '2025-10-16 04:03:00'),
(181, 'App\\Models\\User', 25, 'MyApp', '72fe89d26cc4df9151eac2d95b7a6b1c9862e989d6a919851dc11a7dbbbd5e12', '[\"*\"]', '2025-10-16 04:11:25', NULL, '2025-10-16 04:09:31', '2025-10-16 04:11:25'),
(182, 'App\\Models\\User', 25, 'MyApp', 'd51d1a34eb6f65a29d272ff8a808e73a0c3b68314bc11fde46cafa3b1ab5e6f6', '[\"*\"]', '2025-10-16 04:16:24', NULL, '2025-10-16 04:13:40', '2025-10-16 04:16:24'),
(183, 'App\\Models\\User', 23, 'MyApp', 'c76ce911e3e90a73e66210f5283a5623e0224793bb932400e8ca83bb68845a09', '[\"*\"]', '2025-10-16 04:35:37', NULL, '2025-10-16 04:35:34', '2025-10-16 04:35:37'),
(184, 'App\\Models\\User', 18, 'MyApp', 'bda89d7cd480f3fc28c72779a1ea1c02fa5bf7abed257283595249c9d4d4ca6a', '[\"*\"]', '2025-10-16 08:57:02', NULL, '2025-10-16 04:54:32', '2025-10-16 08:57:02'),
(185, 'App\\Models\\User', 23, 'MyApp', '6e37f298e1985a86236fb072756df123966365258f6490f40881d2599be77b1f', '[\"*\"]', '2025-10-16 04:55:17', NULL, '2025-10-16 04:55:13', '2025-10-16 04:55:17'),
(186, 'App\\Models\\User', 25, 'MyApp', 'cc58df3e428f4eeedad7c7a4322da76c7a0aeaff168fe205b41f1ffd80ce5573', '[\"*\"]', '2025-10-16 04:57:38', NULL, '2025-10-16 04:57:31', '2025-10-16 04:57:38'),
(187, 'App\\Models\\User', 23, 'MyApp', 'a1ad5a92650f82981641753ae8d78823e2957cb0561c8704754f40804c91854b', '[\"*\"]', '2025-10-16 05:10:24', NULL, '2025-10-16 05:10:21', '2025-10-16 05:10:24'),
(188, 'App\\Models\\User', 23, 'MyApp', '518729bbc4ff2c299dec9233fd91c4371afcd37d54298fd19852ed453f19eb6b', '[\"*\"]', '2025-10-16 05:14:09', NULL, '2025-10-16 05:13:52', '2025-10-16 05:14:09'),
(189, 'App\\Models\\User', 23, 'MyApp', 'c264c1f89c369fe09e5556f19ef62b21d96b30de9fdd1c636397a84bddb9982f', '[\"*\"]', '2025-10-16 05:23:08', NULL, '2025-10-16 05:21:21', '2025-10-16 05:23:08'),
(190, 'App\\Models\\User', 23, 'MyApp', '9bc54458115593dd2fe5897ca93bd80b5713e2e18fe0a438b2efe2a1ceb22627', '[\"*\"]', '2025-10-16 05:27:28', NULL, '2025-10-16 05:26:00', '2025-10-16 05:27:28'),
(191, 'App\\Models\\User', 23, 'MyApp', '4d7ed33eb4e04a58b0ebc850e72f36c42ca59bdc90e017e21d8163db17281146', '[\"*\"]', '2025-10-16 05:40:06', NULL, '2025-10-16 05:34:28', '2025-10-16 05:40:06'),
(192, 'App\\Models\\User', 23, 'MyApp', '4c5b164fc7a965efb7dda29f6f99c3c3ecf3d00346636d49de2d227015ab9532', '[\"*\"]', '2025-10-16 06:04:18', NULL, '2025-10-16 06:04:14', '2025-10-16 06:04:18'),
(193, 'App\\Models\\User', 23, 'MyApp', '75af375e5c724126b3c32b8ece1b5975a56fe4e708903ee084e3330b4cc90ebe', '[\"*\"]', '2025-10-16 06:06:12', NULL, '2025-10-16 06:06:09', '2025-10-16 06:06:12'),
(194, 'App\\Models\\User', 18, 'MyApp', '8d496f1cb43803f9a679a1747b93a6be674936df2f77800380485340149eef0b', '[\"*\"]', '2025-10-16 06:07:33', NULL, '2025-10-16 06:06:47', '2025-10-16 06:07:33'),
(195, 'App\\Models\\User', 23, 'MyApp', '892d59d8c6d9a4e5c1913c69a438143cc0fdce443676e6dc80afc15ec6885bfb', '[\"*\"]', '2025-10-16 06:15:47', NULL, '2025-10-16 06:15:45', '2025-10-16 06:15:47'),
(196, 'App\\Models\\User', 23, 'MyApp', '34d0bd9843a2c29d373daf1f48c7a6781204f74a89341fcd1788d0058ab0e380', '[\"*\"]', '2025-10-16 06:21:18', NULL, '2025-10-16 06:21:16', '2025-10-16 06:21:18'),
(197, 'App\\Models\\User', 23, 'MyApp', '0e15cbabf2e59537b405e84f99abfb8a9ffc35fde809b407605eab170ab17860', '[\"*\"]', '2025-10-16 06:25:33', NULL, '2025-10-16 06:25:31', '2025-10-16 06:25:33'),
(198, 'App\\Models\\User', 23, 'MyApp', '1749c2cc9afa1f41ee707cc637e067440d71532c776fbf1f8a037a8cd8b6cd8b', '[\"*\"]', '2025-10-16 06:38:39', NULL, '2025-10-16 06:38:28', '2025-10-16 06:38:39'),
(199, 'App\\Models\\User', 23, 'MyApp', 'b31394262c0b2a1f205d4ebbd27424fadc5efb9658f991d634c6774571c492bd', '[\"*\"]', '2025-10-16 06:41:17', NULL, '2025-10-16 06:41:10', '2025-10-16 06:41:17'),
(200, 'App\\Models\\User', 23, 'MyApp', '8633ef45e950381b8f068323f4b131a10bc5951c6fde8c58b94f2c34ce482cf1', '[\"*\"]', '2025-10-16 06:53:34', NULL, '2025-10-16 06:53:30', '2025-10-16 06:53:34'),
(201, 'App\\Models\\User', 23, 'MyApp', '87458e4046e753263c9cba46d334c74dcccfd8378f8de5cb5ba2f073d5fed4d2', '[\"*\"]', '2025-10-16 06:59:05', NULL, '2025-10-16 06:59:03', '2025-10-16 06:59:05'),
(202, 'App\\Models\\User', 23, 'MyApp', '0c5a587d9a82d7fad93dba79e32067004f9122c676423af9d0d5a18389f65037', '[\"*\"]', '2025-10-16 07:00:02', NULL, '2025-10-16 07:00:00', '2025-10-16 07:00:02'),
(203, 'App\\Models\\User', 23, 'MyApp', 'd473e02cee6531458b0aada949fa3ba1e836472e5443399e9bef3b29ec7bf1a0', '[\"*\"]', '2025-10-16 07:12:57', NULL, '2025-10-16 07:12:55', '2025-10-16 07:12:57'),
(204, 'App\\Models\\User', 23, 'MyApp', '6282d1463f5d8043fc678d6890918b9a21a7b1037bf6a8197dc7dfacb412b6c6', '[\"*\"]', '2025-10-16 07:17:10', NULL, '2025-10-16 07:13:49', '2025-10-16 07:17:10'),
(205, 'App\\Models\\User', 23, 'MyApp', '12bcd1716ec4f113a43154b43da0dbe541d3bd6c641b62d7bb8df0fc421b93b7', '[\"*\"]', '2025-10-16 07:20:59', NULL, '2025-10-16 07:20:50', '2025-10-16 07:20:59'),
(206, 'App\\Models\\User', 23, 'MyApp', '34363c5bc7ddf4474f378d8b089e8003c8c40b23d3e442db71e5e80985c80510', '[\"*\"]', '2025-10-16 07:23:14', NULL, '2025-10-16 07:21:47', '2025-10-16 07:23:14'),
(207, 'App\\Models\\User', 23, 'MyApp', '141b252c31912680a34fdae46eb887bfb33a76a3de746949d35f26382f792bb0', '[\"*\"]', '2025-10-16 07:27:24', NULL, '2025-10-16 07:26:54', '2025-10-16 07:27:24'),
(208, 'App\\Models\\User', 25, 'MyApp', 'b76af396bd863981a1398450caf28d759b060dc7dd94f8644ae009ad30ccd379', '[\"*\"]', '2025-10-16 07:27:58', NULL, '2025-10-16 07:27:52', '2025-10-16 07:27:58'),
(209, 'App\\Models\\User', 23, 'MyApp', 'fcf9ced81db89f902d656fbac46f8618aebea06f9067cc2254d317e6e71e0abc', '[\"*\"]', '2025-10-16 07:28:26', NULL, '2025-10-16 07:28:16', '2025-10-16 07:28:26'),
(210, 'App\\Models\\User', 25, 'MyApp', '149a63d668bdb6c7f935c960c009ace7274cd43883a5f43565ad3c0935c3a589', '[\"*\"]', '2025-10-16 07:28:42', NULL, '2025-10-16 07:28:38', '2025-10-16 07:28:42'),
(211, 'App\\Models\\User', 23, 'MyApp', '9d0a61581b7e39bfa59d5ebb4db25a72b9cac3ff76bf89dcb48030b9116af8e8', '[\"*\"]', '2025-10-16 07:34:15', NULL, '2025-10-16 07:30:20', '2025-10-16 07:34:15'),
(212, 'App\\Models\\User', 23, 'MyApp', '922332c9a83fc84d9be977ca11a59e02184ad4aedb668491d475ee19fce47cef', '[\"*\"]', '2025-10-16 07:46:24', NULL, '2025-10-16 07:46:21', '2025-10-16 07:46:24'),
(213, 'App\\Models\\User', 23, 'MyApp', '7dbb8d2beabc770dfc42c65a0760f136eb409364a8bf5874e85d972e1b4bb271', '[\"*\"]', '2025-10-16 07:47:53', NULL, '2025-10-16 07:47:51', '2025-10-16 07:47:53'),
(214, 'App\\Models\\User', 23, 'MyApp', '61612d2bff16846e72bb2fd2393e060c651f02057d4be19cc9f957f83436d93c', '[\"*\"]', '2025-10-16 07:49:40', NULL, '2025-10-16 07:48:39', '2025-10-16 07:49:40'),
(215, 'App\\Models\\User', 25, 'MyApp', '42e2129f3e2c389a2295f8fd5bc1eecea3c6215853f60d6314819d8d5ead9720', '[\"*\"]', '2025-10-16 07:54:42', NULL, '2025-10-16 07:53:35', '2025-10-16 07:54:42'),
(216, 'App\\Models\\User', 23, 'MyApp', '97f91ab6b8d7f6f8f7a8e4ca892be87a59f6133d65520e6f14b3972a9f4aeb73', '[\"*\"]', '2025-10-16 07:59:24', NULL, '2025-10-16 07:59:22', '2025-10-16 07:59:24'),
(217, 'App\\Models\\User', 23, 'MyApp', '3bee10cc6b2961ae38b3a6b1dea119ccefc68718a580b0e4b6ffac1f40bd8b74', '[\"*\"]', '2025-10-16 08:45:39', NULL, '2025-10-16 08:39:00', '2025-10-16 08:45:39'),
(218, 'App\\Models\\User', 18, 'MyApp', '6a9726168390e8cd762cb50d6c59ae8dc9d755f185cc5648a0e9e3ad4d9fe24b', '[\"*\"]', '2025-10-16 11:12:08', NULL, '2025-10-16 09:01:05', '2025-10-16 11:12:08'),
(219, 'App\\Models\\User', 18, 'MyApp', '579108e8bd02326ff515063537ae4d130ee7715750c7d9a9638c391eba56c92d', '[\"*\"]', NULL, NULL, '2025-10-16 12:22:59', '2025-10-16 12:22:59'),
(220, 'App\\Models\\User', 18, 'MyApp', 'f3b172c8c6373882cfbfcd9fc0dd8f1f436e8902318f0284c3508ff1780381a5', '[\"*\"]', '2025-10-16 12:41:19', NULL, '2025-10-16 12:28:39', '2025-10-16 12:41:19'),
(221, 'App\\Models\\User', 18, 'MyApp', '392b3edc402830ea4ba9bbfe2075767a468b0c4bc19f1ca365d6cad67400e1ac', '[\"*\"]', NULL, NULL, '2025-10-16 13:35:59', '2025-10-16 13:35:59'),
(222, 'App\\Models\\User', 18, 'MyApp', '6438d8fb966ecdec9f50d51e4717ac917dd955912c4dd6bbe7892575796c429c', '[\"*\"]', NULL, NULL, '2025-10-16 13:38:01', '2025-10-16 13:38:01'),
(223, 'App\\Models\\User', 18, 'MyApp', 'a15ef4151e675326f10341d8680ce1b19b101f5d10251d0eb9d4cd60ed86ad31', '[\"*\"]', '2025-10-16 13:38:31', NULL, '2025-10-16 13:38:01', '2025-10-16 13:38:31'),
(224, 'App\\Models\\User', 18, 'MyApp', '93302a907045c52fd116a4d7a4cb7c1c986d716df53da30ff35eecc9acc2059e', '[\"*\"]', '2025-10-16 14:28:27', NULL, '2025-10-16 13:40:00', '2025-10-16 14:28:27'),
(225, 'App\\Models\\User', 18, 'MyApp', '986a8d4c5b56a79333a0958f9debd9a7f02f68640496c103d1f8ee63f1029e53', '[\"*\"]', '2025-10-17 10:20:45', NULL, '2025-10-17 02:07:04', '2025-10-17 10:20:45'),
(226, 'App\\Models\\User', 18, 'MyApp', '98d3d26b43a74e9588cd95be09b7a1bbbc75b1cf606258ccd739b61b0a8fdc4c', '[\"*\"]', '2025-10-17 12:15:27', NULL, '2025-10-17 10:29:50', '2025-10-17 12:15:27'),
(227, 'App\\Models\\User', 18, 'MyApp', '34c48bbe77a3483f40793c807d1328211cfbab4df36f5e4aedf2807dde297c21', '[\"*\"]', '2025-10-17 14:51:46', NULL, '2025-10-17 12:36:08', '2025-10-17 14:51:46'),
(228, 'App\\Models\\User', 25, 'MyApp', '5df24022a66f16316431b0257ebe135352daa16bc987b83c75a52ef2bb7d1b53', '[\"*\"]', '2025-10-17 14:28:52', NULL, '2025-10-17 14:08:40', '2025-10-17 14:28:52'),
(229, 'App\\Models\\User', 25, 'MyApp', 'ff90c5eeb12dad535a71aeea3909b56fccb0a007a0f969aa3ce8781050ec9add', '[\"*\"]', '2025-10-17 15:24:06', NULL, '2025-10-17 14:43:59', '2025-10-17 15:24:06'),
(230, 'App\\Models\\User', 25, 'MyApp', '346a04f3d4e095cab420204fa56588e006906100656ecba91dc0df9638ad0d30', '[\"*\"]', '2025-10-17 15:36:42', NULL, '2025-10-17 15:24:08', '2025-10-17 15:36:42'),
(231, 'App\\Models\\User', 18, 'MyApp', '5dd1b75ada1a153916802a9ef03a8a0ac6c02cfc39b14580e6fe948f55ff9041', '[\"*\"]', '2025-10-17 16:55:14', NULL, '2025-10-17 16:52:11', '2025-10-17 16:55:14'),
(232, 'App\\Models\\User', 18, 'MyApp', 'ea296f46adfa734bf5b03f4e5831130456f274a93b0d664ce22cd794e9b55449', '[\"*\"]', '2025-10-17 16:55:14', NULL, '2025-10-17 16:55:14', '2025-10-17 16:55:14'),
(233, 'App\\Models\\User', 18, 'MyApp', '6e03400c7e3a742372455d98c4d8f5d86c0c65637b9ff4138a235fe689e84bc4', '[\"*\"]', '2025-10-17 16:55:22', NULL, '2025-10-17 16:55:14', '2025-10-17 16:55:22'),
(234, 'App\\Models\\User', 23, 'MyApp', '8bdc5f9adeb0dcdd68eee2a1dec9a142785217671b34e28fef7c3db7d34e3a7c', '[\"*\"]', '2025-10-18 00:41:24', NULL, '2025-10-18 00:40:55', '2025-10-18 00:41:24'),
(235, 'App\\Models\\User', 23, 'MyApp', '787b678a4298147141f063420fd99fe82f892b211aef289ef1aae75b575706a7', '[\"*\"]', '2025-10-18 01:04:04', NULL, '2025-10-18 01:00:42', '2025-10-18 01:04:04'),
(236, 'App\\Models\\User', 25, 'MyApp', '3165db8b5dd3377889ac7be591fc7f7b330acfb96f2d4be01f8f80b33a8d5e4d', '[\"*\"]', '2025-10-18 01:07:05', NULL, '2025-10-18 01:03:28', '2025-10-18 01:07:05'),
(237, 'App\\Models\\User', 23, 'MyApp', '4eebc6ec797875d9b82957be74d4a63a79542ead9ed9812a90ac8bf83cb9a8fd', '[\"*\"]', '2025-10-18 01:09:01', NULL, '2025-10-18 01:05:19', '2025-10-18 01:09:01'),
(238, 'App\\Models\\User', 23, 'MyApp', '3a06fedf3dd275f7d4af9865747190ac85ba0f3ac0d1241221d742fcfa7bcc2d', '[\"*\"]', '2025-10-18 01:12:36', NULL, '2025-10-18 01:10:43', '2025-10-18 01:12:36'),
(239, 'App\\Models\\User', 23, 'MyApp', '8588ec7b9aa7acf2d38e8c48d2cca0456e00b9965bee92d73a0f5bc30334e824', '[\"*\"]', '2025-10-18 01:13:13', NULL, '2025-10-18 01:13:05', '2025-10-18 01:13:13'),
(240, 'App\\Models\\User', 23, 'MyApp', 'a0abd37e5acd6cacacfdad7a6c8579de425bf95679c25d98fa9de64c901cdaa4', '[\"*\"]', '2025-10-18 01:23:29', NULL, '2025-10-18 01:18:03', '2025-10-18 01:23:29'),
(241, 'App\\Models\\User', 25, 'MyApp', '9c2a9c2524dd3628c858a63ada5a4fe87c11d50b4399811341a438c6720ead5c', '[\"*\"]', '2025-10-18 01:27:13', NULL, '2025-10-18 01:24:05', '2025-10-18 01:27:13'),
(242, 'App\\Models\\User', 25, 'MyApp', 'bbcd547ac95fc779e73a15ee11eda4778c064a11572e46cf179889dac1e9e390', '[\"*\"]', '2025-10-18 01:46:25', NULL, '2025-10-18 01:31:19', '2025-10-18 01:46:25'),
(243, 'App\\Models\\User', 18, 'MyApp', '4fb167edac2d534675f244908265890753e23fb4c199904e3ef454fa4d22a4e5', '[\"*\"]', '2025-10-18 02:05:10', NULL, '2025-10-18 01:45:23', '2025-10-18 02:05:10'),
(244, 'App\\Models\\User', 25, 'MyApp', '20c79ad04a504a8645f306bd7a886ab7c75455ed66a7d966ec0673ed9ccc6e0d', '[\"*\"]', '2025-10-18 01:48:57', NULL, '2025-10-18 01:46:25', '2025-10-18 01:48:57'),
(245, 'App\\Models\\User', 23, 'MyApp', '596d16630251059442618c8736114f8369cf14e8dd28f59f2d7024620403fcc5', '[\"*\"]', '2025-10-18 02:05:19', NULL, '2025-10-18 01:48:58', '2025-10-18 02:05:19'),
(246, 'App\\Models\\User', 25, 'MyApp', '9083598ab1e26aaef84f0fe2199591057652d7c95566dae046a054094287b4fa', '[\"*\"]', '2025-10-18 03:05:54', NULL, '2025-10-18 02:44:14', '2025-10-18 03:05:54'),
(247, 'App\\Models\\User', 18, 'MyApp', 'a5f58f230603ae5fc059459bcbd0f97b5069c34b6d3caee99f3eb1f7f76669f0', '[\"*\"]', '2025-10-18 02:59:21', NULL, '2025-10-18 02:56:30', '2025-10-18 02:59:21'),
(248, 'App\\Models\\User', 25, 'MyApp', 'b81880a853876e2c418ca711fa92de23f1c03d1ac7ee4704b3f841db284be553', '[\"*\"]', '2025-10-18 03:54:50', NULL, '2025-10-18 03:51:41', '2025-10-18 03:54:50'),
(249, 'App\\Models\\User', 23, 'MyApp', '88123fec3133998767042735fbf99948891973689fa18102c86ea8211d441d73', '[\"*\"]', '2025-10-18 04:09:20', NULL, '2025-10-18 03:54:54', '2025-10-18 04:09:20'),
(250, 'App\\Models\\User', 23, 'MyApp', '43df0d39fabfe4018ac001419a7d18565c77acc3d578af8c0bd6a0a1b837f91f', '[\"*\"]', '2025-10-18 04:13:10', NULL, '2025-10-18 04:12:32', '2025-10-18 04:13:10'),
(251, 'App\\Models\\User', 25, 'MyApp', 'd83dcc08e7d94609d85d97444aeea93e01e0244c728f7b3ec6aca14a1c47f664', '[\"*\"]', '2025-10-18 04:13:30', NULL, '2025-10-18 04:13:26', '2025-10-18 04:13:30'),
(252, 'App\\Models\\User', 23, 'MyApp', 'fab6150b8c2599d6d626f34e518bbecf7c341c3c2286566ca8b2b356da624806', '[\"*\"]', '2025-10-18 04:13:58', NULL, '2025-10-18 04:13:50', '2025-10-18 04:13:58'),
(253, 'App\\Models\\User', 25, 'MyApp', '8da37328e0849ad6633b74d030545ddae547897503523b7b817cceb1bbde42c3', '[\"*\"]', '2025-10-18 04:14:32', NULL, '2025-10-18 04:14:14', '2025-10-18 04:14:32'),
(254, 'App\\Models\\User', 23, 'MyApp', '7f43dbe4b120ea18463caf1886fbf7c53623b4513426e65ce043901c1b89bb4b', '[\"*\"]', '2025-10-18 04:46:59', NULL, '2025-10-18 04:14:47', '2025-10-18 04:46:59'),
(255, 'App\\Models\\User', 18, 'MyApp', '840f2faeb39b9d43367f411559aba740c7755b400f3f9500f62d625aee3d9685', '[\"*\"]', NULL, NULL, '2025-10-18 06:09:17', '2025-10-18 06:09:17'),
(256, 'App\\Models\\User', 18, 'MyApp', 'c51ed4fb1a678a06babee915d0b027191d98686a02980ea0501108f0e694868d', '[\"*\"]', NULL, NULL, '2025-10-18 06:29:22', '2025-10-18 06:29:22'),
(257, 'App\\Models\\User', 25, 'MyApp', 'e524e6c381eb8accb71555d9ee1587c56fb6c98cbd3de262bcb07bdc2b4526b7', '[\"*\"]', '2025-10-18 06:33:43', NULL, '2025-10-18 06:33:13', '2025-10-18 06:33:43'),
(258, 'App\\Models\\User', 18, 'MyApp', 'dad08b619d2acfb18a82b1e6c95b2c12ccf53fdd7ab6b28c6e2eec79df8ba5a0', '[\"*\"]', '2025-10-18 06:40:28', NULL, '2025-10-18 06:40:26', '2025-10-18 06:40:28'),
(259, 'App\\Models\\User', 18, 'MyApp', 'a16912ac3db5cb3d03184b6fb07c7056d11f0fa19403d68c21fb002e6d8f3e19', '[\"*\"]', '2025-10-18 13:10:58', NULL, '2025-10-18 06:53:31', '2025-10-18 13:10:58'),
(260, 'App\\Models\\User', 18, 'MyApp', '286601124e253e7412983565e2c349d05413e71e8fcb34ce0fa75133de45ff1d', '[\"*\"]', '2025-10-18 12:34:25', NULL, '2025-10-18 12:34:08', '2025-10-18 12:34:25'),
(261, 'App\\Models\\User', 18, 'MyApp', 'e23dc618fbbb8285f9b7b1cf927ab8d36f60ff43a7794f66c9207dd8beea5567', '[\"*\"]', '2025-10-18 15:20:03', NULL, '2025-10-18 15:12:50', '2025-10-18 15:20:03');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(262, 'App\\Models\\User', 25, 'MyApp', 'b1e6d0a68285ceac1fe18275702c3aba43969332e4694f4d5627989021d03af6', '[\"*\"]', NULL, NULL, '2025-10-18 15:21:42', '2025-10-18 15:21:42'),
(263, 'App\\Models\\User', 23, 'MyApp', 'db291c5c0e9a77535b4becac345d593ad6338edecbf5ad7390bbf44d978c3e32', '[\"*\"]', '2025-10-18 20:04:39', NULL, '2025-10-18 19:53:45', '2025-10-18 20:04:39'),
(264, 'App\\Models\\User', 23, 'MyApp', 'b3fd33bc39a2ac4b370dcf8d12827352db982e8b9a81df5ace09e44aae723f75', '[\"*\"]', '2025-10-18 20:08:38', NULL, '2025-10-18 20:07:24', '2025-10-18 20:08:38'),
(265, 'App\\Models\\User', 25, 'MyApp', 'e0a6ca471c39f3c8e7e4c3f1e1a309c6de55f97a8d3e69f9bf1d70da2c201fcc', '[\"*\"]', '2025-10-18 20:12:37', NULL, '2025-10-18 20:08:54', '2025-10-18 20:12:37'),
(266, 'App\\Models\\User', 23, 'MyApp', 'c8b65ed105fc37177dddbb9d2761cfb6e8acc4da3cae726f55169e606d3ad0a1', '[\"*\"]', '2025-10-18 20:14:37', NULL, '2025-10-18 20:12:38', '2025-10-18 20:14:37'),
(267, 'App\\Models\\User', 23, 'MyApp', 'fabb925fe8ed2dc9b8dea9ef99270c5eb6c01732f6139429b6347c3bbd074e10', '[\"*\"]', '2025-10-18 20:21:08', NULL, '2025-10-18 20:15:24', '2025-10-18 20:21:08'),
(268, 'App\\Models\\User', 23, 'MyApp', '16f66c99a5bb84c6550fe32dbfc89f77b9426ad123ebe901a105190bdf09ae40', '[\"*\"]', '2025-10-18 20:23:00', NULL, '2025-10-18 20:22:52', '2025-10-18 20:23:00'),
(269, 'App\\Models\\User', 23, 'MyApp', '6ff0aae5db24b5987f78a0a9f1fcf5c1fa5711d6126443d2428e21f430629e05', '[\"*\"]', '2025-10-18 20:26:46', NULL, '2025-10-18 20:23:56', '2025-10-18 20:26:46'),
(270, 'App\\Models\\User', 25, 'MyApp', 'a737b0c2dc557c1a3152711e160e4a9232592b55a16d304bb6d8e0b3c5bd5454', '[\"*\"]', '2025-10-18 20:44:13', NULL, '2025-10-18 20:30:26', '2025-10-18 20:44:13'),
(271, 'App\\Models\\User', 23, 'MyApp', '99fb4f209d559e7fccf4b3766ed4540fc96a54d8aa520759e743a839b7c56c03', '[\"*\"]', '2025-10-18 21:00:43', NULL, '2025-10-18 20:44:28', '2025-10-18 21:00:43'),
(272, 'App\\Models\\User', 23, 'MyApp', '7f22207ef86658e4960543ce4b4cfb39e7d01d3a1936294658c19ed07d4cfb3a', '[\"*\"]', '2025-10-18 21:04:53', NULL, '2025-10-18 21:03:03', '2025-10-18 21:04:53'),
(273, 'App\\Models\\User', 18, 'MyApp', 'a02057f771bc814631b429abc96483e6955fe19b5df05d78429dcb3d5d436c4e', '[\"*\"]', '2025-10-19 02:15:52', NULL, '2025-10-19 01:33:46', '2025-10-19 02:15:52'),
(274, 'App\\Models\\User', 18, 'MyApp', '1182d19e2d9990028918188817961a4025f4a09d5cc15ccf35b0db21f3eccbf3', '[\"*\"]', '2025-10-19 02:47:48', NULL, '2025-10-19 02:17:25', '2025-10-19 02:47:48'),
(275, 'App\\Models\\User', 18, 'MyApp', '2632e1bdf717c0bde50870556f653f0df013b641b6c6486f196c36482ebc1a57', '[\"*\"]', '2025-10-19 07:38:05', NULL, '2025-10-19 02:47:23', '2025-10-19 07:38:05'),
(276, 'App\\Models\\User', 18, 'MyApp', '29533623053209ae4b0172e3a3612ecf74397f8cb869f21403a9b2f89f00b824', '[\"*\"]', '2025-10-19 03:48:54', NULL, '2025-10-19 03:16:11', '2025-10-19 03:48:54'),
(277, 'App\\Models\\User', 18, 'MyApp', 'ad92691330c192ddcfe7f52a22511d5725e89f941d22f64478a02bac8645b705', '[\"*\"]', '2025-10-19 04:03:39', NULL, '2025-10-19 03:49:31', '2025-10-19 04:03:39'),
(278, 'App\\Models\\User', 18, 'MyApp', '17f51e93427336c3f92b81341f3c62393cfbbb89bdc60fdd6c62ef4f45076b3c', '[\"*\"]', '2025-10-19 06:24:06', NULL, '2025-10-19 04:06:52', '2025-10-19 06:24:06'),
(279, 'App\\Models\\User', 18, 'MyApp', '35b736fdd8ec5c4c9abce5f4cbff583eaa9d974fcb1198f20fa1280f7506f512', '[\"*\"]', '2025-10-19 04:09:13', NULL, '2025-10-19 04:09:13', '2025-10-19 04:09:13'),
(280, 'App\\Models\\User', 25, 'MyApp', 'd7b130939220858f1768feaaee3b994ace167300aa5a3cd30bdc133f228984f6', '[\"*\"]', '2025-10-19 04:22:39', NULL, '2025-10-19 04:09:33', '2025-10-19 04:22:39'),
(281, 'App\\Models\\User', 18, 'MyApp', '3a9823936f7f1663846f53384f7268e95b9e48b5b6bd4c639306761984827d24', '[\"*\"]', '2025-10-19 04:22:46', NULL, '2025-10-19 04:20:27', '2025-10-19 04:22:46'),
(282, 'App\\Models\\User', 25, 'MyApp', 'efc31611ae5ef88cfd5d1425bae17568f6d3124ccfa2bc0491364eb3542138ca', '[\"*\"]', '2025-10-19 04:52:30', NULL, '2025-10-19 04:32:50', '2025-10-19 04:52:30'),
(283, 'App\\Models\\User', 25, 'MyApp', '28175d7b194c2918d2869883e0c8455d2e097b196231bb59f3d41cbbacf8a12f', '[\"*\"]', '2025-10-19 04:58:07', NULL, '2025-10-19 04:56:52', '2025-10-19 04:58:07'),
(284, 'App\\Models\\User', 25, 'MyApp', '5f36e9ccfe87fda5a38e098b3a85e7894013d5540913e9c0e2d042395b63b3c6', '[\"*\"]', '2025-10-19 06:21:51', NULL, '2025-10-19 06:21:36', '2025-10-19 06:21:51'),
(285, 'App\\Models\\User', 25, 'MyApp', '6eb5634a1292d35b02fdd8c619c47d8b60287840dddcd79ab8341197ba5b388c', '[\"*\"]', '2025-10-19 06:35:45', NULL, '2025-10-19 06:35:09', '2025-10-19 06:35:45'),
(286, 'App\\Models\\User', 18, 'MyApp', '3176d8e596b4c3c53ff8f48621ac56b6e1f3d96e0dedc6f0652a5b2f4dff5279', '[\"*\"]', '2025-10-19 06:44:06', NULL, '2025-10-19 06:40:31', '2025-10-19 06:44:06'),
(287, 'App\\Models\\User', 18, 'MyApp', '4283819ff0256005f82c7fa8b8295a637b7cde8c5445ee98ce5f0c81b28fb316', '[\"*\"]', '2025-10-19 08:07:09', NULL, '2025-10-19 06:58:20', '2025-10-19 08:07:09'),
(288, 'App\\Models\\User', 23, 'MyApp', 'd0f377eaf2f22b99f91a293f613784f5a0736a691d4c395b6fd798400e7ebc31', '[\"*\"]', '2025-10-19 11:39:00', NULL, '2025-10-19 07:05:40', '2025-10-19 11:39:00'),
(289, 'App\\Models\\User', 25, 'MyApp', 'cec90d9b9e45fada628906ce704cb880898b0bac99bd260210d1666ac0724cef', '[\"*\"]', '2025-10-19 07:44:14', NULL, '2025-10-19 07:24:33', '2025-10-19 07:44:14'),
(290, 'App\\Models\\User', 18, 'MyApp', '601f0757109587e1ddae7de1d5fc7dcebc870622c3e1b0ed9dfab4a1559c9d10', '[\"*\"]', '2025-10-19 08:07:09', NULL, '2025-10-19 07:54:00', '2025-10-19 08:07:09'),
(291, 'App\\Models\\User', 23, 'MyApp', 'c0749d3c5e0d1f912a155484de9219069c8da24c6d95926e46d272d0da60372f', '[\"*\"]', '2025-10-19 08:07:08', NULL, '2025-10-19 07:56:58', '2025-10-19 08:07:08'),
(292, 'App\\Models\\User', 18, 'MyApp', 'b1b7a03fd46e44b8c1b1ddf31c77dd59958a0464f7a5f557d2d32f6e07ce23f4', '[\"*\"]', '2025-10-19 08:54:35', NULL, '2025-10-19 08:54:34', '2025-10-19 08:54:35'),
(293, 'App\\Models\\User', 18, 'MyApp', '92596db39059a0d2f34de2aa34964efc805f354b14e7e7810bdc1ad0b3e1d621', '[\"*\"]', '2025-10-19 09:06:07', NULL, '2025-10-19 09:05:55', '2025-10-19 09:06:07'),
(294, 'App\\Models\\User', 23, 'MyApp', '9bac45270994ada2ffcff104e44fa0ebc88f439234b4148763c1d444a4be8846', '[\"*\"]', '2025-10-19 09:12:06', NULL, '2025-10-19 09:08:59', '2025-10-19 09:12:06'),
(295, 'App\\Models\\User', 18, 'MyApp', 'e84ca71684455a13de1cb433296f2e251a97bbf1a61f5af67dfef14e0a877651', '[\"*\"]', '2025-10-19 09:45:04', NULL, '2025-10-19 09:09:20', '2025-10-19 09:45:04'),
(296, 'App\\Models\\User', 23, 'MyApp', 'f6b613d38139c2bd095a78b9da947e229bc2390f07b5b6e6db6a3202538d0251', '[\"*\"]', '2025-10-19 10:29:16', NULL, '2025-10-19 09:38:50', '2025-10-19 10:29:16'),
(297, 'App\\Models\\User', 18, 'MyApp', '0ba1f57ea98965001462a7584a221d50bfb0354eda9d7e103d4b6e64f9738264', '[\"*\"]', '2025-10-19 11:07:05', NULL, '2025-10-19 10:08:39', '2025-10-19 11:07:05'),
(298, 'App\\Models\\User', 18, 'MyApp', '8f446f8670414655ebc597b5f3184a08e79752e7e4f9be8ce84716eb4e73707e', '[\"*\"]', '2025-10-19 15:16:13', NULL, '2025-10-19 11:31:17', '2025-10-19 15:16:13'),
(299, 'App\\Models\\User', 18, 'MyApp', '02253af54e60c24a275d0f2204ff8c939159c07a2c32c961147750cfff197f6e', '[\"*\"]', '2025-10-19 12:06:32', NULL, '2025-10-19 12:06:32', '2025-10-19 12:06:32'),
(300, 'App\\Models\\User', 23, 'MyApp', '30351760104bb744920c2e882a6c41c4c9919def06ff3c5db8104139ddbbcd92', '[\"*\"]', '2025-10-19 12:07:00', NULL, '2025-10-19 12:06:46', '2025-10-19 12:07:00'),
(301, 'App\\Models\\User', 25, 'MyApp', '0ac2fc9f6aab1b8a621ddfdefb9757a6ddf6dca616e40f7b4e603cd578140924', '[\"*\"]', '2025-10-19 12:22:03', NULL, '2025-10-19 12:07:18', '2025-10-19 12:22:03'),
(302, 'App\\Models\\User', 32, 'MyApp', 'cc0ae7440db5710382bd6fca2688ec7249eb03a6a6979fb56f0fc4c38d1c1618', '[\"*\"]', NULL, NULL, '2025-10-19 12:12:36', '2025-10-19 12:12:36'),
(303, 'App\\Models\\User', 33, 'MyApp', '3f59a6aa1d5f807c4286c433b4c55502fff197a7bde8fe520f960c686af08c59', '[\"*\"]', NULL, NULL, '2025-10-19 12:21:53', '2025-10-19 12:21:53'),
(304, 'App\\Models\\User', 23, 'MyApp', 'd9bd164c42023363dbe71ba76e2a1c45aef0ee511f807e8992f362286b3bb09b', '[\"*\"]', '2025-10-19 12:33:40', NULL, '2025-10-19 12:32:59', '2025-10-19 12:33:40'),
(305, 'App\\Models\\User', 34, 'MyApp', '71264afc12428a4c933db4dee5d8638c2ba26ec16e7d2d3ea528029285ae5b1d', '[\"*\"]', NULL, NULL, '2025-10-19 12:48:05', '2025-10-19 12:48:05'),
(306, 'App\\Models\\User', 25, 'MyApp', 'f75b07f178a87a1da1edacc50e96597e9ccebf83e266a77140a8f423c9bcf710', '[\"*\"]', '2025-10-19 12:51:41', NULL, '2025-10-19 12:51:40', '2025-10-19 12:51:41'),
(307, 'App\\Models\\User', 25, 'MyApp', '5046c51beec41800008683d28205c4413ac26d4dbc6b148f7c6313cb271968f1', '[\"*\"]', '2025-10-19 12:52:40', NULL, '2025-10-19 12:52:39', '2025-10-19 12:52:40'),
(308, 'App\\Models\\User', 25, 'MyApp', 'c5cdb62dbe3741be942ee893e506f2106da8da4d2cab1f721cf85fed67d36e6e', '[\"*\"]', '2025-10-19 12:53:21', NULL, '2025-10-19 12:53:20', '2025-10-19 12:53:21'),
(309, 'App\\Models\\User', 25, 'MyApp', '08202d57da2c576407b089acb01517ec6f16d09ca567f48f801d476db358e483', '[\"*\"]', '2025-10-19 12:54:16', NULL, '2025-10-19 12:54:01', '2025-10-19 12:54:16'),
(310, 'App\\Models\\User', 25, 'MyApp', '86babee7c4386591cd58747b6c5b5cbb4b4d4b27d339e9d249e38030a8bf2474', '[\"*\"]', '2025-10-19 12:55:31', NULL, '2025-10-19 12:55:22', '2025-10-19 12:55:31'),
(311, 'App\\Models\\User', 25, 'MyApp', '6c95801e4e3caea9db658a869ac0a41da13aa60e14dd6c0813a6532bc8f586c5', '[\"*\"]', '2025-10-19 12:55:59', NULL, '2025-10-19 12:55:58', '2025-10-19 12:55:59'),
(312, 'App\\Models\\User', 23, 'MyApp', '5816e9351f45a5ede945c5365b754062d0210f3772310432e7aeb00585ac1e11', '[\"*\"]', '2025-10-19 13:00:47', NULL, '2025-10-19 12:57:13', '2025-10-19 13:00:47'),
(313, 'App\\Models\\User', 23, 'MyApp', 'a24be54356239f4bd216d1f0ff2f789e4f6f74bcd5e80f3315b4a4b01d72d3ba', '[\"*\"]', '2025-10-19 13:44:11', NULL, '2025-10-19 13:30:38', '2025-10-19 13:44:11'),
(314, 'App\\Models\\User', 23, 'MyApp', '0e0dfb940e5293526888769c3729d397c4f362716290616fe5f26e4564d32e96', '[\"*\"]', '2025-10-19 13:52:24', NULL, '2025-10-19 13:45:56', '2025-10-19 13:52:24'),
(315, 'App\\Models\\User', 25, 'MyApp', 'dfb5bdd2faf25a3b6fa4906ecf7b71378fd79149032bfc65445e884b0d7660b5', '[\"*\"]', '2025-10-19 13:59:31', NULL, '2025-10-19 13:53:03', '2025-10-19 13:59:31'),
(316, 'App\\Models\\User', 23, 'MyApp', '5970885f352cf584a97d99c91a9770d1519c1537b1f5510d0ec3a40f1e96a849', '[\"*\"]', '2025-10-19 13:59:51', NULL, '2025-10-19 13:59:31', '2025-10-19 13:59:51'),
(317, 'App\\Models\\User', 23, 'MyApp', '31dd263829c268a9bade540294858df15aa44d0e52b1386279f32da898bf0240', '[\"*\"]', '2025-10-19 14:12:02', NULL, '2025-10-19 14:03:00', '2025-10-19 14:12:02'),
(318, 'App\\Models\\User', 23, 'MyApp', '4cad290aec4df76897231124cf0ff24498b3685f1c0b00e6cf8bef7fd2dcce98', '[\"*\"]', '2025-10-19 14:16:19', NULL, '2025-10-19 14:14:55', '2025-10-19 14:16:19'),
(319, 'App\\Models\\User', 18, 'MyApp', '23993a0ec179a65b69b9499a2387db36dfa28ef6ba7ce274e8c55fdaf5821624', '[\"*\"]', '2025-10-19 14:55:15', NULL, '2025-10-19 14:18:53', '2025-10-19 14:55:15'),
(320, 'App\\Models\\User', 32, 'MyApp', '4dc8787c5a8f50b8bd51544990e6fab03d0ae6899e728b660686f5ff053961cc', '[\"*\"]', '2025-10-19 14:25:28', NULL, '2025-10-19 14:25:26', '2025-10-19 14:25:28'),
(321, 'App\\Models\\User', 32, 'MyApp', '31ec9b529aaec5ed8d4ced850aad03be32b523e72d5e9245e9d090896f4490a4', '[\"*\"]', '2025-10-19 14:27:18', NULL, '2025-10-19 14:27:17', '2025-10-19 14:27:18'),
(322, 'App\\Models\\User', 32, 'MyApp', '9fcc3b71cf5cd5937ce681d205b9ead19a260381b73cceca6a4ff2de117d2473', '[\"*\"]', '2025-10-19 14:27:54', NULL, '2025-10-19 14:27:52', '2025-10-19 14:27:54'),
(323, 'App\\Models\\User', 18, 'MyApp', 'ddff83b094ae2d32a72a8d909c02ca94ed40a0bcf0982885995cfbe8d471437a', '[\"*\"]', '2025-10-19 15:00:38', NULL, '2025-10-19 14:47:01', '2025-10-19 15:00:38'),
(324, 'App\\Models\\User', 25, 'MyApp', 'bf87bc52560b9bb32aeca78865fb07308275ae8cb452f81380d1625e7e84a1a7', '[\"*\"]', '2025-10-19 14:59:46', NULL, '2025-10-19 14:56:23', '2025-10-19 14:59:46'),
(325, 'App\\Models\\User', 23, 'MyApp', '4c8275dea0a1ea9a0d60f528b71369eb2919730e9ab80dab72fad4210f30fd27', '[\"*\"]', '2025-10-19 15:02:47', NULL, '2025-10-19 14:59:48', '2025-10-19 15:02:47'),
(326, 'App\\Models\\User', 23, 'MyApp', '1df51d296832a87111020862fc722e2dbc1ddbcd9a7c9137b5788f78241624f3', '[\"*\"]', '2025-10-19 15:04:09', NULL, '2025-10-19 15:02:39', '2025-10-19 15:04:09'),
(327, 'App\\Models\\User', 23, 'MyApp', '1b0e9d22a7ab8f936498ce76fdaf8efcba985613ba4a6010f8c933132da94b6b', '[\"*\"]', '2025-10-19 15:03:44', NULL, '2025-10-19 15:02:48', '2025-10-19 15:03:44'),
(328, 'App\\Models\\User', 25, 'MyApp', '93cb909beee3e3d2f6d44928365b0bb9e31474831c312d94cd8e1c9cdc21a402', '[\"*\"]', '2025-10-19 15:04:02', NULL, '2025-10-19 15:04:00', '2025-10-19 15:04:02'),
(329, 'App\\Models\\User', 25, 'MyApp', 'cb10109c8978079609770489a2317f75f73433b3d62c0ffab6625afda1eb1f7c', '[\"*\"]', '2025-10-19 15:04:30', NULL, '2025-10-19 15:04:28', '2025-10-19 15:04:30'),
(330, 'App\\Models\\User', 18, 'MyApp', '8164941786fdd7e9aba144e80f5b03187e09d8dee83f3001044a31df19e5b9fe', '[\"*\"]', '2025-10-19 17:01:42', NULL, '2025-10-19 15:38:04', '2025-10-19 17:01:42'),
(331, 'App\\Models\\User', 23, 'MyApp', '5ed9052a6f297d331ea04c5366d2792893cb70ab8f1ec8d14f7830f2c1c7b5a1', '[\"*\"]', '2025-10-19 15:53:57', NULL, '2025-10-19 15:46:52', '2025-10-19 15:53:57'),
(332, 'App\\Models\\User', 25, 'MyApp', '2eedf8d63b07e65838dfb6b1f708505f239a0b868a0cc1f35efdaa9727104ff7', '[\"*\"]', '2025-10-19 16:21:56', NULL, '2025-10-19 16:07:46', '2025-10-19 16:21:56'),
(333, 'App\\Models\\User', 23, 'MyApp', 'bf07563981f12e697af6fa05a96a9587925a19bfa713814670ee469ee677b474', '[\"*\"]', '2025-10-19 16:22:31', NULL, '2025-10-19 16:22:08', '2025-10-19 16:22:31'),
(334, 'App\\Models\\User', 23, 'MyApp', 'e4e4be434ce96234ce18774af348c03c156ef67af085631285fff3ee6adf8ab7', '[\"*\"]', '2025-10-19 16:23:24', NULL, '2025-10-19 16:22:56', '2025-10-19 16:23:24'),
(335, 'App\\Models\\User', 25, 'MyApp', 'd8bc7c1a9103f7c00182d8249eee5ab9cbb299287c3304911c4562e061d9724d', '[\"*\"]', '2025-10-19 16:25:06', NULL, '2025-10-19 16:25:02', '2025-10-19 16:25:06'),
(336, 'App\\Models\\User', 23, 'MyApp', '9aba9809cc4c7e9e3ff83c21f2eb5714a1b2458a859c5d45f473a9d9a3edb2af', '[\"*\"]', '2025-10-19 16:25:30', NULL, '2025-10-19 16:25:21', '2025-10-19 16:25:30'),
(337, 'App\\Models\\User', 25, 'MyApp', '7e8e4df2831653b9ef5e57094bbf3a5aa3b702757aa077854261d9a6e006bb63', '[\"*\"]', '2025-10-19 16:27:52', NULL, '2025-10-19 16:25:45', '2025-10-19 16:27:52'),
(338, 'App\\Models\\User', 23, 'MyApp', 'e88c2d52fece62330c01bec05ca8133f702a147783b33b576bfc3abceaca24e6', '[\"*\"]', '2025-10-19 16:28:32', NULL, '2025-10-19 16:28:15', '2025-10-19 16:28:32'),
(339, 'App\\Models\\User', 23, 'MyApp', '08daa06e691fc92a636ec2264056e2779c97e6722edc0a61dab328abd1db85dd', '[\"*\"]', '2025-10-19 17:03:34', NULL, '2025-10-19 16:44:48', '2025-10-19 17:03:34'),
(340, 'App\\Models\\User', 25, 'MyApp', '3336df347cfd268fe5d799cdeb93fcd9d5e7aaac5e8a5c0402fdc07e4ec8191a', '[\"*\"]', '2025-10-19 17:45:23', NULL, '2025-10-19 16:45:18', '2025-10-19 17:45:23'),
(341, 'App\\Models\\User', 25, 'MyApp', 'df8e4ffa161dee98d60f4947a36796c5bd4af3c1a37fddbe5a90a9cd588477f5', '[\"*\"]', '2025-10-19 18:04:30', NULL, '2025-10-19 17:45:26', '2025-10-19 18:04:30'),
(342, 'App\\Models\\User', 18, 'MyApp', 'c6832c7fb1a50be93923adeb007edd53a9663c121accc1c0a440a3844803fa2c', '[\"*\"]', '2025-10-19 20:13:13', NULL, '2025-10-19 17:47:04', '2025-10-19 20:13:13'),
(343, 'App\\Models\\User', 23, 'MyApp', '22800ef975af1fa3c6c8c917816be151952ab14090a4aca137f413ea22556bc0', '[\"*\"]', '2025-10-19 19:37:18', NULL, '2025-10-19 19:37:17', '2025-10-19 19:37:18'),
(344, 'App\\Models\\User', 29, 'MyApp', 'b09189e350acb2b14cc9d384d95ed34904850db5e0aa9c12578bbb4809525942', '[\"*\"]', '2025-10-20 04:25:12', NULL, '2025-10-19 20:28:25', '2025-10-20 04:25:12'),
(345, 'App\\Models\\User', 23, 'MyApp', 'e1731a465b45823de9f88abfbfca941ecd437973942d91a9c7fe80257a40d227', '[\"*\"]', '2025-10-19 20:46:58', NULL, '2025-10-19 20:37:51', '2025-10-19 20:46:58'),
(346, 'App\\Models\\User', 23, 'MyApp', '3bcae56b6f185ccaa2123df736f735dca4dcdb263033c4c8bfac966afdacdd7d', '[\"*\"]', '2025-10-19 20:53:14', NULL, '2025-10-19 20:47:24', '2025-10-19 20:53:14'),
(347, 'App\\Models\\User', 25, 'MyApp', '91da9ce87dedad17b0276f20cd31a0de4763a9f74a433c09267351e68dd22e19', '[\"*\"]', '2025-10-19 20:55:31', NULL, '2025-10-19 20:54:46', '2025-10-19 20:55:31'),
(348, 'App\\Models\\User', 23, 'MyApp', 'ac7dc63f2bb1130ca1f71d830dea2c5f91c7d2d8b6c49260bc1182564fb523a0', '[\"*\"]', '2025-10-19 20:58:50', NULL, '2025-10-19 20:58:31', '2025-10-19 20:58:50'),
(349, 'App\\Models\\User', 25, 'MyApp', '9931a5f4674f983d6a46bf94cd83ca7ca0e726b06d2280112ae11163d466bb33', '[\"*\"]', '2025-10-19 21:09:32', NULL, '2025-10-19 21:06:10', '2025-10-19 21:09:32'),
(350, 'App\\Models\\User', 25, 'MyApp', 'a0abddbc790d6e4e2bbd4976a6c497c827af377e46f8b8f3ef498830f7827662', '[\"*\"]', '2025-10-19 21:09:59', NULL, '2025-10-19 21:09:57', '2025-10-19 21:09:59'),
(351, 'App\\Models\\User', 29, 'MyApp', '7e13e8b0a15164d6e7ab2131cbaf2bc7a1b01797a0508d2288368a550bf82a6a', '[\"*\"]', '2025-10-19 21:11:08', NULL, '2025-10-19 21:11:08', '2025-10-19 21:11:08'),
(352, 'App\\Models\\User', 25, 'MyApp', '00dca664960e2b8210a514c3f5cd58fb75008d6739480e28aaea2a8b921d636a', '[\"*\"]', '2025-10-19 21:12:39', NULL, '2025-10-19 21:11:52', '2025-10-19 21:12:39'),
(353, 'App\\Models\\User', 23, 'MyApp', 'f6666686ba54cfb9c61afd97867c76793098ff075de28de7528eac8e3551ff19', '[\"*\"]', '2025-10-19 21:25:32', NULL, '2025-10-19 21:12:54', '2025-10-19 21:25:32'),
(354, 'App\\Models\\User', 25, 'MyApp', '6747d14e3fddf8fbc9f305fffaead24e0f61227288768e21f4e54ae0f1ce34f6', '[\"*\"]', '2025-10-19 22:20:09', NULL, '2025-10-19 21:25:44', '2025-10-19 22:20:09'),
(355, 'App\\Models\\User', 23, 'MyApp', '8195aadfdd55ccd4e40cfca4f6bd763d679a86a9934d2bd33336c6a1a318e032', '[\"*\"]', '2025-10-19 23:47:21', NULL, '2025-10-19 23:47:21', '2025-10-19 23:47:21'),
(356, 'App\\Models\\User', 29, 'MyApp', '3ff1f62ce2249257e153e547408cb7756b263d02f6b55b070376005b43f45f07', '[\"*\"]', '2025-10-20 01:06:56', NULL, '2025-10-19 23:52:24', '2025-10-20 01:06:56'),
(357, 'App\\Models\\User', 35, 'MyApp', '64e0b2770d5a0c10e87e86eee105311a5825d320c1acc5a1e6823692d9f7320e', '[\"*\"]', NULL, NULL, '2025-10-19 23:56:51', '2025-10-19 23:56:51'),
(358, 'App\\Models\\User', 23, 'MyApp', 'e13c5b48b9eb46abafc4fc2104c153d4bb18040c6068da42eb52496b866e28a3', '[\"*\"]', '2025-10-20 00:13:16', NULL, '2025-10-20 00:12:48', '2025-10-20 00:13:16'),
(359, 'App\\Models\\User', 23, 'MyApp', '17f0a4ef61ceb944068c3d82640e5cfdbfaaa09890dc3540a7ed0ef54f536b6f', '[\"*\"]', '2025-10-20 00:23:47', NULL, '2025-10-20 00:22:41', '2025-10-20 00:23:47'),
(360, 'App\\Models\\User', 23, 'MyApp', 'b398ce927e37a83713ab1fc2bf7032eaa1a1c65301f38d0e73806e2d9ecefea8', '[\"*\"]', '2025-10-20 00:29:46', NULL, '2025-10-20 00:28:12', '2025-10-20 00:29:46'),
(361, 'App\\Models\\User', 23, 'MyApp', '72821c3d720825685d1eae22a893e64546eff0923796ce295737c4fe5c86b69e', '[\"*\"]', '2025-10-20 00:42:54', NULL, '2025-10-20 00:38:33', '2025-10-20 00:42:54'),
(362, 'App\\Models\\User', 23, 'MyApp', '7e523186ee79c31163da232d981af88c054c2be122111d2fa660998cf895677c', '[\"*\"]', '2025-10-20 00:52:35', NULL, '2025-10-20 00:52:20', '2025-10-20 00:52:35'),
(363, 'App\\Models\\User', 25, 'MyApp', '69bd14858c3421f872270b04b96a8f0cd813521f3ac41f33abf98e9748d888f6', '[\"*\"]', '2025-10-20 01:18:50', NULL, '2025-10-20 01:11:22', '2025-10-20 01:18:50'),
(364, 'App\\Models\\User', 25, 'MyApp', '4b89c3dce15dfead9d0c04db713fc8cb9644f0927f1aaf380607325d055f2fe6', '[\"*\"]', '2025-10-20 01:19:20', NULL, '2025-10-20 01:18:50', '2025-10-20 01:19:20'),
(365, 'App\\Models\\User', 23, 'MyApp', '2a6428bcd7caf073303780000edf90865c8cb3232a2ed9a5348a909bc5d9e08e', '[\"*\"]', '2025-10-20 01:19:28', NULL, '2025-10-20 01:19:20', '2025-10-20 01:19:28'),
(366, 'App\\Models\\User', 23, 'MyApp', '19369a0cda8682fa021f109b4eac4bd5e9294895adaa1c81597a50fd091d471f', '[\"*\"]', '2025-10-20 01:20:30', NULL, '2025-10-20 01:20:10', '2025-10-20 01:20:30'),
(367, 'App\\Models\\User', 25, 'MyApp', 'c09419ba5900fe8e13368ee5d1aa4cac966a5e1b217aa4040ce2e947e20a7e91', '[\"*\"]', '2025-10-20 01:20:48', NULL, '2025-10-20 01:20:44', '2025-10-20 01:20:48'),
(368, 'App\\Models\\User', 29, 'MyApp', 'a6c5b7ff3f526d861844e591200a3882680ea7aa4b6070967ea9ace0d3e584aa', '[\"*\"]', '2025-10-20 03:31:10', NULL, '2025-10-20 01:20:52', '2025-10-20 03:31:10'),
(369, 'App\\Models\\User', 23, 'MyApp', '0908288d96dbe30050fe5adbb3e39741ba132a09cbca2b77aebba5af68cc334f', '[\"*\"]', '2025-10-20 01:23:33', NULL, '2025-10-20 01:21:10', '2025-10-20 01:23:33'),
(370, 'App\\Models\\User', 25, 'MyApp', 'f48a405b071e552b06d4f8cd32ee55e077085a94d320766324e36c77f79040f7', '[\"*\"]', '2025-10-20 01:39:10', NULL, '2025-10-20 01:30:38', '2025-10-20 01:39:10'),
(371, 'App\\Models\\User', 25, 'MyApp', '8ddb103fb59da12cc5db3c002cab9e6797b5181cb2f3d46e82366757ab821b51', '[\"*\"]', '2025-10-20 01:41:39', NULL, '2025-10-20 01:40:11', '2025-10-20 01:41:39'),
(372, 'App\\Models\\User', 25, 'MyApp', '0113e5e69dc93177a87e5fa87326e38d41aba7769051bb2909c19295d0c8ebea', '[\"*\"]', '2025-10-20 01:48:04', NULL, '2025-10-20 01:44:05', '2025-10-20 01:48:04'),
(373, 'App\\Models\\User', 36, 'MyApp', 'd393a0ad63df605495449d393093257635ee7a2537109687515657e1f0874df6', '[\"*\"]', NULL, NULL, '2025-10-20 01:50:46', '2025-10-20 01:50:46'),
(374, 'App\\Models\\User', 25, 'MyApp', '0d9996bc983f9060c74d0fd6687750dea6898400614f53ef473c58fa095339cb', '[\"*\"]', '2025-10-20 01:54:06', NULL, '2025-10-20 01:52:32', '2025-10-20 01:54:06'),
(375, 'App\\Models\\User', 25, 'MyApp', 'de001a1fc4fd2e2a353096a405e1dd002e82d63f2a980ae2b10694d9fedb2db3', '[\"*\"]', '2025-10-20 01:56:50', NULL, '2025-10-20 01:56:44', '2025-10-20 01:56:50'),
(376, 'App\\Models\\User', 25, 'MyApp', '65f5151124c2948c22bff8b6a36964608becd95de8f1ca3a8945c147b840abdb', '[\"*\"]', '2025-10-20 02:25:41', NULL, '2025-10-20 02:24:58', '2025-10-20 02:25:41'),
(377, 'App\\Models\\User', 25, 'MyApp', '75e704d5be38976d434077f3b08fa654caad1f1f89c0b7d55268a9e6d1b4b3ab', '[\"*\"]', '2025-10-20 02:56:09', NULL, '2025-10-20 02:32:50', '2025-10-20 02:56:09'),
(378, 'App\\Models\\User', 37, 'MyApp', '4b425142b9e8aae513d76eb79b150fa33b433af41db750f194bbdecd387dae6a', '[\"*\"]', NULL, NULL, '2025-10-20 03:24:34', '2025-10-20 03:24:34'),
(379, 'App\\Models\\User', 38, 'MyApp', 'de59ef69c0bad0ea2a05b8c191002c03c7dffa82d6c807c6825dda29898ebc23', '[\"*\"]', NULL, NULL, '2025-10-20 03:27:45', '2025-10-20 03:27:45'),
(380, 'App\\Models\\User', 38, 'MyApp', 'f181c1de3c7dea789b614158071f9b49e8a91fe789be23e9a0e177fe191b8b21', '[\"*\"]', '2025-10-20 03:44:36', NULL, '2025-10-20 03:28:21', '2025-10-20 03:44:36'),
(381, 'App\\Models\\User', 25, 'MyApp', '37015e12e335b71896f313fd54a9a517d2f998f51934895143fcdf40b6d88a40', '[\"*\"]', '2025-10-20 04:06:53', NULL, '2025-10-20 04:06:50', '2025-10-20 04:06:53'),
(382, 'App\\Models\\User', 39, 'MyApp', '6b4495e402804480a64ade294cd56b269f078b4b81a6ec08dd2a11f0c3f244d9', '[\"*\"]', NULL, NULL, '2025-10-20 04:13:10', '2025-10-20 04:13:10'),
(383, 'App\\Models\\User', 39, 'MyApp', '16171a02a25e6e62255670d119e62691fcce137f208879b539ec11ad10fb00d4', '[\"*\"]', '2025-10-20 04:27:36', NULL, '2025-10-20 04:17:53', '2025-10-20 04:27:36'),
(384, 'App\\Models\\User', 38, 'MyApp', 'b8ad6ffeecbaed1ae6ceea5ccec15af03b007b5506ea4827a88f6c608230fbd9', '[\"*\"]', '2025-10-20 04:27:15', NULL, '2025-10-20 04:24:41', '2025-10-20 04:27:15'),
(385, 'App\\Models\\User', 29, 'MyApp', '5e49aa2dc5a0f265687a6d2e29eae54ae9a877feb3ec7feb74fd4f4fe0a2ace7', '[\"*\"]', '2025-11-08 18:11:42', NULL, '2025-11-08 17:32:43', '2025-11-08 18:11:42');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
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
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `roles_id`, `name`, `email`, `email_verified_at`, `password`, `profile_pic`, `remember_token`, `created_at`, `updated_at`) VALUES
(23, 7, 'guard1', 'guard@email.com', NULL, '$2y$10$h860XLtwUey7R51pVWRkg.rvKM1yhBQzGyEeXTdIR7OT80qxbmuMu', NULL, NULL, '2025-10-11 07:15:10', '2025-10-11 07:15:10'),
(25, 4, 'Ser Geybin', 'capinpin.sergeybin@example.com', NULL, '$2y$10$jIxXCQXdAmllGCUD.BGdQuBMOW1yexIHVDLTdMPRfXCiAWdB2/l.i', NULL, NULL, '2025-10-11 07:20:04', '2025-10-20 04:22:48'),
(29, 6, 'Admin Edward', 'edward.layno.13@gmail.com', NULL, '$2y$10$ab3tRxM/ykeyAeXC0qYU9ehLGyd/j1jvem7IfAMyf5LPGBJkEm52y', NULL, NULL, '2025-10-13 22:22:56', '2025-10-19 20:24:50'),
(38, 3, 'Juan Patrick Dela Cruz', 'delacruz.johnpatrick.bsit@gmail.com', NULL, '$2y$10$WxonjsZGdycgTpGZJiDaQO3J6AugsTXbCE195fP5KVtgUU/XUF97K', NULL, NULL, '2025-10-20 03:27:45', '2025-10-20 03:28:09'),
(39, 3, 'Edward Layno', 'layno.edward.bsit@gmail.com', NULL, '$2y$10$AfJKo3AQpfazcPEcWRgyHuuLeoqIayALhu2WQI87fIdU6P47qyyNu', NULL, NULL, '2025-10-20 04:13:10', '2025-10-20 04:14:28'),
(40, 7, 'Gate-2', 'guard2@gmail.com', NULL, '$2y$10$0NI6kWW/lnxel0M1jIWL1.v7Nbcj5YHjypDWZq3msN08QRd2j/3.O', NULL, NULL, '2025-10-20 04:15:57', '2025-10-20 04:15:57');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `plate_number` varchar(255) DEFAULT NULL,
  `plate_numbers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`plate_numbers`)),
  `student_no` varchar(255) DEFAULT NULL,
  `faculty_id` varchar(255) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `yr_section` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `or_path` varchar(255) DEFAULT NULL,
  `or_number` varchar(255) DEFAULT NULL,
  `cr_path` varchar(255) DEFAULT NULL,
  `deed_path` varchar(1024) DEFAULT NULL,
  `id1_path` varchar(255) DEFAULT NULL,
  `id1_name` varchar(255) DEFAULT NULL,
  `id2_path` varchar(255) DEFAULT NULL,
  `id2_name` varchar(255) DEFAULT NULL,
  `cr_number` varchar(255) DEFAULT NULL,
  `or_cr_path` varchar(255) DEFAULT NULL,
  `qr_path` varchar(255) DEFAULT NULL,
  `qr_token` varchar(255) DEFAULT NULL,
  `from_pending` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deed_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `user_id`, `firstname`, `lastname`, `department`, `contact_number`, `plate_number`, `plate_numbers`, `student_no`, `faculty_id`, `employee_id`, `course`, `yr_section`, `position`, `or_path`, `or_number`, `cr_path`, `deed_path`, `id1_path`, `id1_name`, `id2_path`, `id2_name`, `cr_number`, `or_cr_path`, `qr_path`, `qr_token`, `from_pending`, `created_at`, `updated_at`, `deed_name`) VALUES
(20, 23, 'guard1', '', NULL, '09273915603', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-10-11 07:15:10', '2025-10-11 07:15:10', NULL),
(22, 25, 'Ser', 'Geybin', 'College of Information and Communications Technology', '09683440125', NULL, '[\"VEH-002\",\"SMK2464\",\"ABC-001111\"]', '201213123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'qrs/qr_25_1760196004.svg', '27ff6be308168712c05faac77d7f9f660622535dde082d31776a777c75f4fc4f', 0, '2025-10-11 07:20:04', '2025-10-20 04:22:48', NULL),
(26, 29, 'Admin', 'Edward', NULL, '09625003238', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-10-13 22:22:56', '2025-10-13 22:22:56', NULL),
(42, 38, 'Juan', 'Patrick Dela Cruz', 'College of Information and Communications Technology', '+639456641887', 'XXX1104', NULL, '2022100826', NULL, NULL, 'BS in Information Technology', '4C', 'Student', 'or_cr/or_of5vZZl2.jpg', '0352-000000290269', 'or_cr/cr_uITlKqWf.jpg', 'deeds/deed_fhdmFlId.jpg', 'ids/id1_SHoW64PA.jpg', 'ID1', 'ids/id2_UnV23c3k.jpg', 'COR', '299826332', NULL, 'qrs/qr_38_1760930865.svg', '7b1f069c314739e6755719e6c15ac2522fb10d348eda4327ad1f041f9b147b1a', 0, '2025-10-20 03:27:45', '2025-10-20 03:28:09', 'Screenshot_2025-10-20-11-04-56-470_com.miui.gallery.jpg'),
(43, 39, 'Edward', 'Layno', 'College of Information and Communications Technology', '+639625003238', '131036', NULL, '2022100801', NULL, NULL, 'BS in Information Technology', 'BSIT 4C-G2', 'Student', 'or_cr/or_7TrGljFH.jpg', '0352-000000055236', 'or_cr/cr_ieQogE0m.jpg', 'deeds/deed_oNj8b8lx.jpg', 'ids/id1_MJH3Xk2X.jpg', 'ID1', 'ids/id2_H55nbUtu.jpg', 'COR', '1336-00000437897', NULL, 'qrs/qr_39_1760933590.svg', '08e4a07adc9237fe89f46b5123ea013348817c1d2d97ea90df92dcbdd261e827', 0, '2025-10-20 04:13:10', '2025-10-20 04:14:28', 'Screenshot_2025-10-20-11-04-32-100_com.miui.gallery.jpg'),
(44, 40, 'Gate-2', '', NULL, '09913195657', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-10-20 04:15:57', '2025-10-20 04:15:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_details_id` bigint(20) UNSIGNED DEFAULT NULL,
  `plate_number` varchar(255) NOT NULL,
  `vehicle_color` varchar(255) DEFAULT NULL,
  `vehicle_type` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `or_path` varchar(255) DEFAULT NULL,
  `or_number` varchar(255) DEFAULT NULL,
  `cr_path` varchar(255) DEFAULT NULL,
  `cr_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `user_id`, `user_details_id`, `plate_number`, `vehicle_color`, `vehicle_type`, `brand`, `model`, `or_path`, `or_number`, `cr_path`, `cr_number`, `created_at`, `updated_at`) VALUES
(23, 25, NULL, 'VEH-002', 'Green', 'motorcycle', 'YAMAHA', 'MIO', 'or_cr/veh_or_JIgsv0iF.pdf', 'SDADASD123213', 'or_cr/veh_cr_5m4csp0C.pdf', 'ASDAD1231', '2025-10-12 17:45:34', '2025-10-12 17:45:34'),
(29, 25, NULL, 'SMK2464', 'White', 'car', 'Honda', 'Civic', 'or_cr/veh_or_gBKAcL9V.pdf', '112233', 'or_cr/veh_cr_XxIHgGUt.pdf', '221144', '2025-10-19 11:36:38', '2025-10-19 11:36:38'),
(39, 38, NULL, 'XXX1104', 'Matte White', 'car', 'Toyota', 'Altis', 'or_cr/or_of5vZZl2.jpg', '0352-000000290269', 'or_cr/cr_uITlKqWf.jpg', '299826332', '2025-10-20 03:27:45', '2025-10-20 03:27:45'),
(40, 39, NULL, '131036', 'Black', 'motorcycle', 'Yamaha', 'Mio Sporty', 'or_cr/or_7TrGljFH.jpg', '0352-000000055236', 'or_cr/cr_ieQogE0m.jpg', '1336-00000437897', '2025-10-20 04:13:10', '2025-10-20 04:13:10');

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
  ADD KEY `incidents_user_id_index` (`user_id`),
  ADD KEY `incidents_reported_user_id_index` (`reported_user_id`),
  ADD KEY `incidents_resolved_by_index` (`resolved_by`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `conversation_user`
--
ALTER TABLE `conversation_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `incidents`
--
ALTER TABLE `incidents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `incident_attachments`
--
ALTER TABLE `incident_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `parking_assignments`
--
ALTER TABLE `parking_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `parking_layouts`
--
ALTER TABLE `parking_layouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `parking_slots`
--
ALTER TABLE `parking_slots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=386;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

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
