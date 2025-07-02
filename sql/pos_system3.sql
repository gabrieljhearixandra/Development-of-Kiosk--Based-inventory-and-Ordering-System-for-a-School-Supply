-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2025 at 09:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos_system3`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `last_login`) VALUES
(1, 'admin', '$2y$12$pPKsvdEaDTKaYXjYyPfK4eM4DsuDGEgxt01Vu09Os9sdqvQuRgddG', '2025-06-03 16:04:30', '2025-06-19 15:12:00');

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_type` varchar(50) NOT NULL,
  `action_details` text DEFAULT NULL,
  `action_timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `affected_table` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `action_type`, `action_details`, `action_timestamp`, `ip_address`, `user_agent`, `affected_table`, `record_id`) VALUES
(1, NULL, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/maskingtape.jpg\"},\"price\":{\"old\":\"20.00\",\"new\":\"30\"}}', '2025-06-19 00:47:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 14),
(2, NULL, 'delete', '{\"name\":\"dsadas\",\"description\":\"sdsa\",\"category_id\":9,\"price\":\"12.00\",\"stock\":1233,\"image_path\":\"..\\/uploads\\/products\\/6852e823a0be1.jpg\"}', '2025-06-19 00:47:55', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 25),
(3, NULL, 'login', 'User logged in{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/684b53d8b79ac.jpg\"},\"price\":{\"old\":\"30.00\",\"new\":\"35\"}}', '2025-06-19 00:49:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(4, 1, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/684b53d8b79ac.jpg\"},\"price\":{\"old\":\"30.00\",\"new\":\"35\"}}', '2025-06-19 00:50:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 19),
(5, 1, 'login', 'User logged in', '2025-06-19 01:06:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(6, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in\"}', '2025-06-19 01:12:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(7, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in\"}', '2025-06-19 01:12:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(8, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:36:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(9, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:36:34', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(10, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:36:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(11, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:39:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(12, NULL, 'account_locked', 'Account locked due to multiple failed attempts', '2025-06-19 01:42:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(13, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:42:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(14, NULL, 'login_locked', 'Attempt to access locked account: admin', '2025-06-19 01:42:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(15, NULL, 'login_locked', 'Attempt to access locked account: admin', '2025-06-19 01:43:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(16, NULL, 'login_locked', 'Attempt to access locked account: admin', '2025-06-19 01:43:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(17, NULL, 'login_locked', 'Attempt to access locked account: admin', '2025-06-19 01:45:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(18, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:46:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(19, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:46:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(20, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin2\"}', '2025-06-19 01:47:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 2),
(21, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin2\"}', '2025-06-19 01:48:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 2),
(22, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:48:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(23, NULL, 'login_failed', '{\"username\":\"unknown\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"Failed login attempt for user: admin\"}', '2025-06-19 01:54:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(24, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in successfully\"}', '2025-06-19 01:56:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(25, 1, 'create', '{\"name\":\"dcq\",\"description\":\"qds\",\"category_id\":\"9\",\"price\":\"100\",\"stock\":\"122\",\"image_path\":\"..\\/uploads\\/products\\/6852ffaeb332d.jpeg\"}', '2025-06-19 02:04:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 26),
(26, 1, 'delete', '{\"name\":\"dcq\",\"description\":\"qds\",\"category_id\":9,\"price\":\"100.00\",\"stock\":122,\"image_path\":\"..\\/uploads\\/products\\/6852ffaeb332d.jpeg\"}', '2025-06-19 02:04:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 26),
(27, 1, 'password_change', 'Password updated', '2025-06-19 02:29:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(28, 1, 'logout', 'User logged out', '2025-06-19 02:33:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(29, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in successfully\"}', '2025-06-19 02:33:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(30, 1, 'logout', 'User logged out', '2025-06-19 02:33:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(31, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in successfully\"}', '2025-06-19 02:37:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(32, 1, 'logout', 'User logged out', '2025-06-19 02:37:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(33, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in successfully\"}', '2025-06-19 02:37:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(34, 1, 'password_change', 'Password updated', '2025-06-19 02:39:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(35, 1, '1', 'delete', '2025-06-19 02:53:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"Do you sell school uniforms?\",\"answer', 0),
(36, 1, '1', 'update', '2025-06-19 02:54:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"answer\":{\"old\":\"We carry a selection of eco-frie', 0),
(37, 1, '1', 'create', '2025-06-19 02:58:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"ADAD\",\"answer\":\"ADASDASD\"}', 0),
(38, 1, '1', 'delete', '2025-06-19 02:58:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"ADAD\",\"answer\":\"ADASDASD\"}', 0),
(39, 1, '1', 'create', '2025-06-19 03:12:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"sdad\",\"answer\":\"sadada\"}', 0),
(40, 1, '1', 'delete', '2025-06-19 03:15:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"sdad\",\"answer\":\"sadada\"}', 0),
(41, 1, '1', 'create', '2025-06-19 03:19:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"123132\",\"answer\":\"31312313\"}', 0),
(42, 1, 'logout', 'User logged out', '2025-06-19 03:19:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(43, 1, 'login', '{\"username\":\"admin\",\"ip\":\"::1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/137.0.0.0 Safari\\/537.36 Edg\\/137.0.0.0\",\"additional_info\":\"User logged in successfully\"}', '2025-06-19 03:19:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(44, 1, '1', 'DELETE', '2025-06-19 03:31:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"123132\",\"answer\":\"31312313\"}', 0),
(45, 1, 'password_change', 'Password updated', '2025-06-19 03:43:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(46, 1, '1', 'create', '2025-06-19 03:45:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"SVFWA\",\"answer\":\"AFAWFA\"}', 0),
(47, 1, '1', 'delete', '2025-06-19 03:52:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"SVFWA\",\"answer\":\"AFAWFA\"}', 0),
(48, 1, '1', 'UPDATE', '2025-06-19 04:12:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"answer\":{\"old\":\"Yes, just provide your email add', 0),
(49, 1, '1', 'CREATE', '2025-06-19 04:15:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"23424\",\"answer\":\"23423432424\"}', 0),
(50, 1, '1', 'DELETE', '2025-06-19 04:16:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"23424\",\"answer\":\"23423432424\"}', 0),
(51, 1, '1', 'CREATE', '2025-06-19 04:27:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"r242\",\"answer\":\"424342\"}', 0),
(52, 1, '1', 'DELETE', '2025-06-19 04:27:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"r242\",\"answer\":\"424342\"}', 0),
(53, 1, '1', 'DELETE', '2025-06-19 04:27:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"r242\",\"answer\":\"424342\"}', 0),
(54, 1, '1', 'CREATE', '2025-06-19 04:31:50', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"12312313\",\"answer\":\"1313123\"}', 0),
(55, 1, '1', 'CREATE', '2025-06-19 04:32:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '{\"question\":\"213213\",\"answer\":\"3213\"}', 0),
(56, NULL, 'DELETE', '{\"question\":null,\"answer\":null}', '2025-06-19 04:41:41', NULL, NULL, NULL, NULL),
(57, NULL, 'DELETE', '{\"question\":null,\"answer\":null}', '2025-06-19 04:41:45', NULL, NULL, NULL, NULL),
(58, NULL, 'CREATE', '{\"question\":\"dasdad\",\"answer\":\"sdadas\"}', '2025-06-19 04:41:51', NULL, NULL, NULL, NULL),
(59, NULL, 'DELETE', '{\"question\":\"dasdad\",\"answer\":\"sdadas\"}', '2025-06-19 04:42:28', NULL, NULL, NULL, NULL),
(60, NULL, 'DELETE', '{\"type\":\"faq_item\",\"id\":\"27\",\"question\":\"12312313\",\"answer\":\"1313123\"}', '2025-06-19 04:44:52', NULL, NULL, NULL, NULL),
(61, 1, 'CREATE', '{\"type\":\"FAQ\",\"question\":\"24234\",\"answer\":\"242424\"}', '2025-06-19 04:47:53', NULL, NULL, NULL, NULL),
(62, 1, 'DELETE', '{\"type\":\"FAQ\",\"question\":\"24234\",\"answer\":\"242424\"}', '2025-06-19 04:48:24', NULL, NULL, NULL, NULL),
(63, 1, 'login', 'User logged in successfully', '2025-06-19 09:43:56', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(64, 1, 'CREATE', '{\"type\":\"FAQ\",\"question\":\"whhbauygc\",\"answer\":\"23153464ferwav\"}', '2025-06-19 09:44:16', NULL, NULL, NULL, NULL),
(65, 1, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/maskingtape.jpg\"},\"price\":{\"old\":\"30.00\",\"new\":\"45\"}}', '2025-06-19 09:57:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 14),
(66, 1, 'DELETE', '{\"type\":\"FAQ\",\"question\":\"whhbauygc\",\"answer\":\"23153464ferwav\",\"affected_table\":\"faqs\",\"record_id\":\"31\"}', '2025-06-19 09:58:15', NULL, NULL, 'faqs', 31),
(67, 1, 'CREATE', '{\"type\":\"FAQ\",\"question\":\"A65W4D6Q8\",\"answer\":\"13535V56Q4WREQWE\",\"affected_table\":\"faqs\",\"record_id\":\"32\"}', '2025-06-19 09:58:35', NULL, NULL, 'faqs', 32),
(68, 1, 'DELETE', '{\"type\":\"FAQ\",\"question\":\"A65W4D6Q8\",\"answer\":\"13535V56Q4WREQWE\",\"affected_table\":\"faqs\",\"record_id\":\"32\"}', '2025-06-19 10:27:23', NULL, NULL, 'faqs', 32),
(69, 1, 'logout', 'User logged out', '2025-06-19 10:50:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(70, 1, 'login', 'User logged in successfully', '2025-06-19 10:50:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(71, 1, 'reset_sales', 'Reset sales data', '2025-06-19 11:38:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'sales', NULL),
(72, 1, 'UPDATE', '{\"type\":\"FAQ\",\"id\":\"15\",\"affected_table\":\"faqs\",\"record_id\":\"15\",\"answer\":{\"old\":\"Yes, just provide your email address at checkout and we\'ll send a digital receipt along with your printed DADADone.\",\"new\":\"Yes, just provide your email address at checkout and we\'ll send a digital receipt along with your printed one.\"}}', '2025-06-19 12:04:34', NULL, NULL, 'faqs', 15),
(73, 1, 'logout', 'User logged out', '2025-06-19 12:11:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(74, 1, 'login', 'User logged in successfully', '2025-06-19 12:21:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(75, 1, 'login', 'User logged in successfully', '2025-06-19 14:10:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(76, 1, 'UPDATE', '{\"type\":\"FAQ\",\"id\":\"11\",\"affected_table\":\"faqs\",\"record_id\":\"11\",\"answer\":{\"old\":\"Our kiosk doesn\'t currently support saving orders, but you can complete your purchase quickly and return if needed.\",\"new\":\"Our kiosk doesn\'t support saving orders, but you can complete your purchase quickly and return if needed.\"}}', '2025-06-19 14:32:11', NULL, NULL, 'faqs', 11),
(77, 1, 'create', '{\"name\":\"sf\",\"description\":\"dsfs\",\"category_id\":\"10\",\"price\":\"45\",\"stock\":\"150\",\"image_path\":\"..\\/uploads\\/products\\/6853b836519f1.jpeg\"}', '2025-06-19 15:11:50', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 27),
(78, 1, 'delete', '{\"name\":\"sf\",\"description\":\"dsfs\",\"category_id\":10,\"price\":\"45.00\",\"stock\":150,\"image_path\":\"..\\/uploads\\/products\\/6853b836519f1.jpeg\"}', '2025-06-19 15:12:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 27),
(79, 1, 'create', '{\"name\":\"fcswe\",\"description\":\"ecsf\"}', '2025-06-19 15:28:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 12),
(80, 1, 'create', '{\"name\":\"DSADAS\",\"description\":\"SADASDADS\"}', '2025-06-19 15:28:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 13),
(81, 1, 'delete', '{\"name\":\"DSADAS\",\"description\":\"SADASDADS\"}', '2025-06-19 15:29:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 13),
(82, 1, 'delete', '{\"name\":\"fcswe\",\"description\":\"ecsf\"}', '2025-06-19 15:29:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 12),
(83, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 16:07:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(84, 1, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/maskingtape.jpg\"},\"stock\":{\"old\":0,\"new\":\"150\"}}', '2025-06-19 16:40:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 14),
(85, 1, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/684b53d8b79ac.jpg\"},\"stock\":{\"old\":-1,\"new\":\"150\"}}', '2025-06-19 16:40:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 19),
(86, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 17:04:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(87, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 17:37:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(88, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 17:42:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(89, 1, 'logout', 'User logged out', '2025-06-19 17:42:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(90, NULL, 'login_failed', 'Failed login attempt for user: admin', '2025-06-19 17:42:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(91, 1, 'login', 'User logged in successfully', '2025-06-19 17:42:50', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(92, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 17:43:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(93, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 17:46:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(94, 1, 'logout', 'User logged out', '2025-06-19 18:28:44', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(95, NULL, 'login_failed', 'Failed login attempt for user: admin', '2025-06-19 18:28:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(96, 1, 'login', 'User logged in successfully', '2025-06-19 18:30:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(97, 1, 'update_receipt_settings', 'Updated receipt settings', '2025-06-19 20:03:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'receipt_settings', NULL),
(98, 1, 'update', '{\"name\":{\"old\":\"Pens & Markers\",\"new\":\"Writing Instruments\"}}', '2025-06-19 20:33:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 9),
(99, 1, 'create', '{\"name\":\"Highlighters\",\"description\":\"highlighters\\r\\n\"}', '2025-06-19 20:34:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 14),
(100, 1, 'create', '{\"name\":\"Binders and Folders\",\"description\":\"Different color and kinds of binders and Folders\\r\\n\"}', '2025-06-19 20:35:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 15),
(101, 1, 'create', '{\"name\":\"Backpacks & Bags\",\"description\":\"\"}', '2025-06-19 20:36:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 16),
(102, 1, 'create', '{\"name\":\"Organization & Desk Accessories\",\"description\":\"Carrying School Supplies\"}', '2025-06-19 20:38:19', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 17),
(103, 1, 'create', '{\"name\":\"Art Supplies\",\"description\":\"Materials for creative projects\"}', '2025-06-19 20:38:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 18),
(104, 1, 'create', '{\"name\":\"Math & Science Tools\",\"description\":\"Supplies for calculations and experiments\"}', '2025-06-19 20:39:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 19),
(105, 1, 'create', '{\"name\":\"Technology & Electronics\",\"description\":\"Technology & Electronics\"}', '2025-06-19 20:39:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 20),
(106, 1, 'update', '{\"description\":{\"old\":\"\",\"new\":\"Carrying school supplies\"}}', '2025-06-19 20:39:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 16),
(107, 1, 'update', '{\"description\":{\"old\":\"Carrying School Supplies\",\"new\":\"Keeping supplies tidy\"}}', '2025-06-19 20:40:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 17),
(108, 1, 'delete', '{\"name\":\"Highlighters\",\"description\":\"highlighters\\r\\n\"}', '2025-06-19 20:40:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 14),
(109, 1, 'update', '{\"name\":{\"old\":\"Notebooks\",\"new\":\"Paper Products\"}}', '2025-06-19 20:42:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 11),
(110, 1, 'update', '{\"description\":{\"old\":\"different kind of notebooks\",\"new\":\"Materials to write or print on\"}}', '2025-06-19 20:42:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 11),
(111, 1, 'update', '{\"current_image\":{\"old\":null,\"new\":\"..\\/uploads\\/products\\/684b96e7b9ac8.jpg\"},\"stock\":{\"old\":5,\"new\":\"50\"}}', '2025-06-19 20:42:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 23),
(112, 1, 'create', '{\"name\":\"Sticky Notes\",\"description\":\"Removable adhesive notes for reminders.\",\"category_id\":\"11\",\"price\":\"30\",\"stock\":\"150\",\"image_path\":\"..\\/uploads\\/products\\/6854069f395d0.jpg\"}', '2025-06-19 20:46:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 28),
(113, 1, 'create', '{\"name\":\"Index Card\",\"description\":\"For study flashcards or quick notes.  per pieces\",\"category_id\":\"11\",\"price\":\"2\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/685406dd114f4.jpg\"}', '2025-06-19 20:47:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 29),
(114, 1, 'create', '{\"name\":\"Brown Folder\",\"description\":\"a brown folder keep assignments and handouts organized.\\r\\n\\r\\n\",\"category_id\":\"15\",\"price\":\"20\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/6854077ee14d8.jpg\"}', '2025-06-19 20:50:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 30),
(115, 1, 'create', '{\"name\":\"Totoro Sling Bag\",\"description\":\"A messenger bag that is totoro\",\"category_id\":\"16\",\"price\":\"700\",\"stock\":\"250\",\"image_path\":\"..\\/uploads\\/products\\/68540b299b1b4.jpg\"}', '2025-06-19 21:05:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 31),
(116, 1, 'create', '{\"name\":\"study lamp white\",\"description\":\"a white study lamp\",\"category_id\":\"17\",\"price\":\"100\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/68540b4f1e953.jpg\"}', '2025-06-19 21:06:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 32),
(117, 1, 'create', '{\"name\":\"Thermal Printer\",\"description\":\"a small, on hand thermal printer\",\"category_id\":\"20\",\"price\":\"199\",\"stock\":\"150\",\"image_path\":\"..\\/uploads\\/products\\/68540b791ad37.jpg\"}', '2025-06-19 21:07:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 33),
(118, 1, 'create', '{\"name\":\"sketchbook\",\"description\":\"sketchbook\",\"category_id\":\"11\",\"price\":\"79\",\"stock\":\"500\",\"image_path\":\"..\\/uploads\\/products\\/68540b976002b.jpg\"}', '2025-06-19 21:07:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 34),
(119, 1, 'create', '{\"name\":\"Sharpener\",\"description\":\"sharpener with a lid\",\"category_id\":\"\",\"price\":\"15\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/68540bf44e7db.jpg\"}', '2025-06-19 21:09:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 35),
(120, 1, 'create', '{\"name\":\"Ruler\",\"description\":\"ruler\",\"category_id\":\"18\",\"price\":\"20\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/68540c0fe6ad1.jpg\"}', '2025-06-19 21:09:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 36),
(121, 1, 'create', '{\"name\":\"scissor\",\"description\":\"black scissor\",\"category_id\":\"18\",\"price\":\"35\",\"stock\":\"50\",\"image_path\":\"..\\/uploads\\/products\\/68540c38ce560.jpg\"}', '2025-06-19 21:10:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 37),
(122, 1, 'create', '{\"name\":\"pusheen pencil case\",\"description\":\"pencil case na cute\",\"category_id\":\"17\",\"price\":\"75\",\"stock\":\"70\",\"image_path\":\"..\\/uploads\\/products\\/68540c6722562.jpg\"}', '2025-06-19 21:11:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 38),
(123, 1, 'create', '{\"name\":\"black organizer\",\"description\":\"black organizer\",\"category_id\":\"17\",\"price\":\"35\",\"stock\":\"18\",\"image_path\":\"..\\/uploads\\/products\\/68540c835f1a8.jpg\"}', '2025-06-19 21:11:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 39),
(124, 1, 'create', '{\"name\":\"alarm clock\",\"description\":\"white alarm clock\",\"category_id\":\"20\",\"price\":\"130\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540c9cda34e.jpg\"}', '2025-06-19 21:11:56', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 40),
(125, 1, 'create', '{\"name\":\"drawer organizer\",\"description\":\"black organizer drawer\",\"category_id\":\"17\",\"price\":\"120\",\"stock\":\"10\",\"image_path\":\"..\\/uploads\\/products\\/68540cf1d7e73.jpg\"}', '2025-06-19 21:13:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 41),
(126, 1, 'create', '{\"name\":\"music player\",\"description\":\"music player\",\"category_id\":\"20\",\"price\":\"250\",\"stock\":\"15\",\"image_path\":\"..\\/uploads\\/products\\/68540d0a09870.jpg\"}', '2025-06-19 21:13:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 42),
(127, 1, 'create', '{\"name\":\"onigiri notebook\",\"description\":\"cute\",\"category_id\":\"11\",\"price\":\"25\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68540dd983c41.jpg\"}', '2025-06-19 21:17:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 43),
(128, 1, 'create', '{\"name\":\"purple binder\",\"description\":\"a binder\",\"category_id\":\"17\",\"price\":\"30\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540df545d37.jpg\"}', '2025-06-19 21:17:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 44),
(129, 1, 'create', '{\"name\":\"organizer desk\",\"description\":\"desk organizer\",\"category_id\":\"17\",\"price\":\"80\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540e16362e9.jpg\"}', '2025-06-19 21:18:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 45),
(130, 1, 'create', '{\"name\":\"blue lunchbag\",\"description\":\"lunchbag\",\"category_id\":\"16\",\"price\":\"99\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540e2fcf9a3.jpg\"}', '2025-06-19 21:18:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 46),
(131, 1, 'create', '{\"name\":\"40 pieces crayola\",\"description\":\"crayola\",\"category_id\":\"18\",\"price\":\"59\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/68540e590828e.jpg\"}', '2025-06-19 21:19:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 47),
(132, 1, 'create', '{\"name\":\"hello kitty notebook\",\"description\":\"cute\",\"category_id\":\"11\",\"price\":\"30\",\"stock\":\"50\",\"image_path\":\"..\\/uploads\\/products\\/68540e803ef6c.jpg\"}', '2025-06-19 21:20:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 48),
(133, 1, 'create', '{\"name\":\"converse backpack\",\"description\":\"bag\",\"category_id\":\"16\",\"price\":\"299\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68540e9e35bab.jpg\"}', '2025-06-19 21:20:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 49),
(134, 1, 'create', '{\"name\":\"2H Pencil\",\"description\":\"pencil\",\"category_id\":\"9\",\"price\":\"20\",\"stock\":\"99\",\"image_path\":\"..\\/uploads\\/products\\/68540ed07999c.jpg\"}', '2025-06-19 21:21:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 50),
(135, 1, 'create', '{\"name\":\"Pink Lunchbag\",\"description\":\"lunchbag\",\"category_id\":\"16\",\"price\":\"99\",\"stock\":\"50\",\"image_path\":\"..\\/uploads\\/products\\/68540eeeb83bc.jpg\"}', '2025-06-19 21:21:50', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 51),
(136, 1, 'create', '{\"name\":\"cute y2k bag\",\"description\":\"black bag\",\"category_id\":\"16\",\"price\":\"299\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540f0e67c6a.jpg\"}', '2025-06-19 21:22:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 52),
(137, 1, 'create', '{\"name\":\"pen holder\",\"description\":\"black pen holder\",\"category_id\":\"17\",\"price\":\"30\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68540f26422c4.jpg\"}', '2025-06-19 21:22:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 53),
(138, 1, 'create', '{\"name\":\"gudetam calendar\",\"description\":\"calendar\",\"category_id\":\"17\",\"price\":\"99\",\"stock\":\"10\",\"image_path\":\"..\\/uploads\\/products\\/685410afd207a.jpg\"}', '2025-06-19 21:29:19', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 54),
(139, 1, 'create', '{\"name\":\"violet cat headphone\",\"description\":\"headphone\",\"category_id\":\"20\",\"price\":\"299\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685410cb0f368.jpg\"}', '2025-06-19 21:29:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 55),
(140, 1, 'create', '{\"name\":\"bear tape dispenser\",\"description\":\"tape dispenser\",\"category_id\":\"17\",\"price\":\"59\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685410fb9c8b3.jpg\"}', '2025-06-19 21:30:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 56),
(141, 1, 'create', '{\"name\":\"cate tape dispenser\",\"description\":\"tape dispenser\",\"category_id\":\"17\",\"price\":\"59\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68541112f3cfd.jpg\"}', '2025-06-19 21:30:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 57),
(142, 1, 'create', '{\"name\":\"white cat tape dispenser\",\"description\":\"tape dispenser\",\"category_id\":\"17\",\"price\":\"59\",\"stock\":\"29\",\"image_path\":\"..\\/uploads\\/products\\/6854112fbf67b.jpg\"}', '2025-06-19 21:31:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 58),
(143, 1, 'create', '{\"name\":\"purple notebook\",\"description\":\"notebook\",\"category_id\":\"11\",\"price\":\"29\",\"stock\":\"50\",\"image_path\":\"..\\/uploads\\/products\\/6854114f25d21.jpg\"}', '2025-06-19 21:31:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 59),
(144, 1, 'create', '{\"name\":\"kuromi phone holder\",\"description\":\"phone holder\",\"category_id\":\"17\",\"price\":\"39\",\"stock\":\"56\",\"image_path\":\"..\\/uploads\\/products\\/6854117312529.jpg\"}', '2025-06-19 21:32:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 60),
(145, 1, 'create', '{\"name\":\"gudetama calculator\",\"description\":\"calculator\",\"category_id\":\"20\",\"price\":\"79\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/6854118e90536.jpg\"}', '2025-06-19 21:33:02', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 61),
(146, 1, 'delete', '{\"name\":\"Math & Science Tools\",\"description\":\"Supplies for calculations and experiments\"}', '2025-06-19 21:33:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'categories', 19),
(147, 1, 'create', '{\"name\":\"plant\",\"description\":\"plant\",\"category_id\":\"17\",\"price\":\"69\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/685411ae7de7e.jpg\"}', '2025-06-19 21:33:34', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 62),
(148, 1, 'create', '{\"name\":\"pompompurin pen\",\"description\":\"ballpen\",\"category_id\":\"9\",\"price\":\"25\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/685411e2f084b.jpg\"}', '2025-06-19 21:34:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 63),
(149, 1, 'create', '{\"name\":\"pompompurin pen 2\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"29\",\"stock\":\"65\",\"image_path\":\"..\\/uploads\\/products\\/685411f82d66a.jpg\"}', '2025-06-19 21:34:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 64),
(150, 1, 'create', '{\"name\":\"pochacco pencil case\",\"description\":\"pencil case\",\"category_id\":\"17\",\"price\":\"69\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/6854121c146fc.jpg\"}', '2025-06-19 21:35:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 65),
(151, 1, 'create', '{\"name\":\"pink notebook thick\",\"description\":\"notebook\",\"category_id\":\"11\",\"price\":\"69\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68541251c88af.jpg\"}', '2025-06-19 21:36:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 66),
(152, 1, 'create', '{\"name\":\"cat pencil case \",\"description\":\"pencil case\",\"category_id\":\"17\",\"price\":\"69\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68541285598e6.jpg\"}', '2025-06-19 21:37:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 67),
(153, 1, 'create', '{\"name\":\"cinnamorol pencil case\",\"description\":\"pencil case\",\"category_id\":\"17\",\"price\":\"69\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685412a6ee92b.jpg\"}', '2025-06-19 21:37:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 68),
(154, 1, 'create', '{\"name\":\"multicolor pen\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"39\",\"stock\":\"29\",\"image_path\":\"..\\/uploads\\/products\\/685412c0961f3.jpg\"}', '2025-06-19 21:38:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 69),
(155, 1, 'create', '{\"name\":\"multicolor pen 2\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"39\",\"stock\":\"37\",\"image_path\":\"..\\/uploads\\/products\\/685412db588fd.jpg\"}', '2025-06-19 21:38:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 70),
(156, 1, 'create', '{\"name\":\"capybara bag\",\"description\":\"bag\",\"category_id\":\"16\",\"price\":\"199\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685413d77d11d.jpg\"}', '2025-06-19 21:42:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 71),
(157, 1, 'create', '{\"name\":\"yellow mini bag\",\"description\":\"bag yello\",\"category_id\":\"16\",\"price\":\"199\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685413efab5e5.jpg\"}', '2025-06-19 21:43:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 72),
(158, 1, 'create', '{\"name\":\"strawberry bag pink\",\"description\":\"bag na pink\",\"category_id\":\"16\",\"price\":\"199\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68541405bd8c2.jpg\"}', '2025-06-19 21:43:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 73),
(159, 1, 'create', '{\"name\":\"pink bag mini\",\"description\":\"bag na mini\",\"category_id\":\"16\",\"price\":\"199\",\"stock\":\"21\",\"image_path\":\"..\\/uploads\\/products\\/6854141aedde3.jpg\"}', '2025-06-19 21:43:54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 74),
(160, 1, 'create', '{\"name\":\"miffy bag\",\"description\":\"bag\",\"category_id\":\"16\",\"price\":\"199\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/6854142b7ab42.jpg\"}', '2025-06-19 21:44:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 75);
INSERT INTO `audit_trail` (`id`, `user_id`, `action_type`, `action_details`, `action_timestamp`, `ip_address`, `user_agent`, `affected_table`, `record_id`) VALUES
(161, 1, 'create', '{\"name\":\"cat tape\",\"description\":\"tape\",\"category_id\":\"10\",\"price\":\"26\",\"stock\":\"61\",\"image_path\":\"..\\/uploads\\/products\\/685414c192606.jpg\"}', '2025-06-19 21:46:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 76),
(162, 1, 'create', '{\"name\":\"cat tape black and white\",\"description\":\"tape na cat\",\"category_id\":\"10\",\"price\":\"29\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/685414d810dd9.jpg\"}', '2025-06-19 21:47:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 77),
(163, 1, 'create', '{\"name\":\"cute pink tape\",\"description\":\" pink tape\",\"category_id\":\"10\",\"price\":\"25\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685414eb574e7.jpg\"}', '2025-06-19 21:47:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 78),
(164, 1, 'create', '{\"name\":\"corgi tape\",\"description\":\"tape\",\"category_id\":\"10\",\"price\":\"29\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685414fb949ae.jpg\"}', '2025-06-19 21:47:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 79),
(165, 1, 'create', '{\"name\":\"gudetama pen\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"29\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/6854152b37bb0.jpg\"}', '2025-06-19 21:48:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 80),
(166, 1, 'create', '{\"name\":\"pink paw pen\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"29\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/6854154aa7f3e.jpg\"}', '2025-06-19 21:48:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 81),
(167, 1, 'create', '{\"name\":\"multicolor pen 3\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"39\",\"stock\":\"130\",\"image_path\":\"..\\/uploads\\/products\\/685415664209e.jpg\"}', '2025-06-19 21:49:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 82),
(168, 1, 'create', '{\"name\":\"multi color pen 5\",\"description\":\"pen\",\"category_id\":\"9\",\"price\":\"39\",\"stock\":\"23\",\"image_path\":\"..\\/uploads\\/products\\/685415860bb32.jpg\"}', '2025-06-19 21:49:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 83),
(169, 1, 'create', '{\"name\":\"kuromi clock\",\"description\":\"clock\",\"category_id\":\"20\",\"price\":\"99\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685415c18825c.jpg\"}', '2025-06-19 21:50:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 84),
(170, 1, 'create', '{\"name\":\"desk fan cat\",\"description\":\"fan\",\"category_id\":\"20\",\"price\":\"199\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/685415d5280b9.jpg\"}', '2025-06-19 21:51:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 85),
(171, 1, 'create', '{\"name\":\"kuromi calculator\",\"description\":\"calculator\",\"category_id\":\"20\",\"price\":\"129\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685415f5a029a.jpg\"}', '2025-06-19 21:51:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 86),
(172, 1, 'create', '{\"name\":\"bear calculator\",\"description\":\"calculator\",\"category_id\":\"20\",\"price\":\"129\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68541611167f6.jpg\"}', '2025-06-19 21:52:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 87),
(173, 1, 'create', '{\"name\":\"clipboard violet\",\"description\":\"clipboard\",\"category_id\":\"15\",\"price\":\"69\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/685416c54a532.jpg\"}', '2025-06-19 21:55:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 88),
(174, 1, 'create', '{\"name\":\"cute pink binder\",\"description\":\"binder\",\"category_id\":\"15\",\"price\":\"69\",\"stock\":\"31\",\"image_path\":\"..\\/uploads\\/products\\/685416db09dad.jpg\"}', '2025-06-19 21:55:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 89),
(175, 1, 'create', '{\"name\":\"clipboard pink\",\"description\":\"clipboard\",\"category_id\":\"15\",\"price\":\"69\",\"stock\":\"13\",\"image_path\":\"..\\/uploads\\/products\\/685416f16a27c.jpg\"}', '2025-06-19 21:56:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 90),
(176, 1, 'create', '{\"name\":\"pastel binder\",\"description\":\"binder\",\"category_id\":\"15\",\"price\":\"69\",\"stock\":\"32\",\"image_path\":\"..\\/uploads\\/products\\/6854170243ac4.jpg\"}', '2025-06-19 21:56:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 91),
(177, 1, 'create', '{\"name\":\"pink folder\",\"description\":\"folder\",\"category_id\":\"15\",\"price\":\"20\",\"stock\":\"100\",\"image_path\":\"..\\/uploads\\/products\\/685417248ab87.jpg\"}', '2025-06-19 21:56:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 92),
(178, 1, 'create', '{\"name\":\"green folder\",\"description\":\"folder\",\"category_id\":\"15\",\"price\":\"20\",\"stock\":\"97\",\"image_path\":\"..\\/uploads\\/products\\/68541738f3082.jpg\"}', '2025-06-19 21:57:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 93),
(179, 1, 'create', '{\"name\":\"blue folder\",\"description\":\"folder\",\"category_id\":\"15\",\"price\":\"20\",\"stock\":\"86\",\"image_path\":\"..\\/uploads\\/products\\/6854174b9a3ce.jpg\"}', '2025-06-19 21:57:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 94),
(180, 1, 'create', '{\"name\":\"black binder\",\"description\":\"binder \",\"category_id\":\"15\",\"price\":\"29\",\"stock\":\"46\",\"image_path\":\"..\\/uploads\\/products\\/685417861fcb8.jpg\"}', '2025-06-19 21:58:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 95),
(181, 1, 'create', '{\"name\":\"gouche paint \",\"description\":\"paint\",\"category_id\":\"18\",\"price\":\"199\",\"stock\":\"32\",\"image_path\":\"..\\/uploads\\/products\\/6854195db10b8.jpg\"}', '2025-06-19 22:06:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 96),
(182, 1, 'create', '{\"name\":\"pallete\",\"description\":\"pallete\",\"category_id\":\"18\",\"price\":\"99\",\"stock\":\"60\",\"image_path\":\"..\\/uploads\\/products\\/68541976e395d.jpg\"}', '2025-06-19 22:06:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 97),
(183, 1, 'create', '{\"name\":\"school paint \",\"description\":\"paint set\",\"category_id\":\"18\",\"price\":\"99\",\"stock\":\"123\",\"image_path\":\"..\\/uploads\\/products\\/6854198c8b1a9.jpg\"}', '2025-06-19 22:07:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 98),
(184, 1, 'create', '{\"name\":\"watercolor\",\"description\":\"watercolor\",\"category_id\":\"18\",\"price\":\"79\",\"stock\":\"150\",\"image_path\":\"..\\/uploads\\/products\\/685419a41df86.jpg\"}', '2025-06-19 22:07:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 99),
(185, 1, 'create', '{\"name\":\"watercolor 2\",\"description\":\"watercolor\",\"category_id\":\"18\",\"price\":\"299\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/685419f4140ba.jpg\"}', '2025-06-19 22:08:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 100),
(186, 1, 'create', '{\"name\":\"acrylic paint\",\"description\":\"paint\",\"category_id\":\"18\",\"price\":\"399\",\"stock\":\"20\",\"image_path\":\"..\\/uploads\\/products\\/68541a0771866.jpg\"}', '2025-06-19 22:09:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 101),
(187, 1, 'create', '{\"name\":\"acrylic markers\",\"description\":\"marker\",\"category_id\":\"18\",\"price\":\"199\",\"stock\":\"30\",\"image_path\":\"..\\/uploads\\/products\\/68541a2211b0e.jpg\"}', '2025-06-19 22:09:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 102),
(188, 1, 'create', '{\"name\":\"color marker\",\"description\":\"marker\",\"category_id\":\"18\",\"price\":\"175\",\"stock\":\"40\",\"image_path\":\"..\\/uploads\\/products\\/68541a3c2e037.jpg\"}', '2025-06-19 22:10:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'products', 103),
(189, 1, 'logout', 'User logged out', '2025-06-19 22:40:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(190, 1, 'login', 'User logged in successfully', '2025-06-19 23:03:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(191, 1, 'logout', 'User logged out', '2025-06-19 23:04:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(192, NULL, 'login_failed', 'Failed login attempt for non-existent user: ad0da', '2025-06-19 23:07:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', NULL, NULL),
(193, NULL, 'login_failed', 'Failed login attempt for non-existent user: ad0da', '2025-06-19 23:07:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', NULL, NULL),
(194, NULL, 'login_failed', 'Failed login attempt for non-existent user: ad0da', '2025-06-19 23:07:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', NULL, NULL),
(195, NULL, 'login_failed', 'Failed login attempt for non-existent user: sdasda', '2025-06-19 23:08:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', NULL, NULL),
(196, NULL, 'login_failed', 'Failed login attempt for non-existent user: as', '2025-06-19 23:08:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', NULL, NULL),
(197, NULL, 'login_failed', 'Failed login attempt for user: admin', '2025-06-19 23:09:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(198, 1, 'login', 'User logged in successfully', '2025-06-19 23:12:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1),
(199, 1, 'logout', 'User logged out', '2025-06-19 23:12:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'admins', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(9, 'Writing Instruments', 'Ballpens, Markers, Highlighters. (Something that has Ink)', '2025-06-12 04:52:07', '2025-06-19 12:33:07'),
(10, 'Tapes', 'sticky tapes', '2025-06-12 04:54:37', '2025-06-12 04:54:37'),
(11, 'Paper Products', 'Materials to write or print on', '2025-06-13 02:56:32', '2025-06-19 12:42:36'),
(15, 'Binders and Folders', 'Different color and kinds of binders and Folders\r\n', '2025-06-19 12:35:48', '2025-06-19 12:35:48'),
(16, 'Backpacks & Bags', 'Carrying school supplies', '2025-06-19 12:36:20', '2025-06-19 12:39:51'),
(17, 'Organization & Desk Accessories', 'Keeping supplies tidy', '2025-06-19 12:38:19', '2025-06-19 12:40:04'),
(18, 'Art Supplies', 'Materials for creative projects', '2025-06-19 12:38:39', '2025-06-19 12:38:39'),
(20, 'Technology & Electronics', 'Technology & Electronics', '2025-06-19 12:39:24', '2025-06-19 12:39:24');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `created_at`, `updated_at`) VALUES
(1, 'How do I find a specific school supply?', 'You can browse by category (notebooks, pens, etc.) or use the search bar at the top of the screen to find specific items.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(2, 'Do you sell items individually or in packs?', 'Some items like pens and pencils are sold individually, while others like notebooks and paper are sold in packs. The product details will specify this information.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(3, 'Can I see the total price before checking out?', 'Yes! Your current total is always displayed at the bottom of the screen. You can review your entire order before finalizing.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(6, 'How do I know if an item is in stock?', 'Items that are out of stock will be clearly marked and you won\'t be able to add them to your cart.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(7, 'Can I return or exchange items?', 'Yes, with a receipt you can return or exchange items within 14 days of purchase, provided they are in original condition.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(9, 'Where can I find the school supply list?', 'Many schools provide supply lists that we keep at the counter. You can also ask a staff member to help you find grade-specific supplies.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(10, 'Do you price match with other stores?', 'Yes, we price match with local competitors on identical in-stock items. Just show us the current advertised price at checkout.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(11, 'Can I save my order for later?', 'Our kiosk doesn\'t support saving orders, but you can complete your purchase quickly and return if needed.', '2025-06-12 23:10:44', '2025-06-19 06:32:11'),
(13, 'Are your products eco-friendly?', 'We carry a selection of eco-friendly school supplies. Look for the green leaf icon on product displays. eys', '2025-06-12 23:10:44', '2025-06-18 18:54:01'),
(14, 'Do you sell art supplies?', 'Yes! We have a dedicated art supplies section with everything from sketchpads to watercolors.', '2025-06-12 23:10:44', '2025-06-12 23:10:44'),
(15, 'Can I get a receipt emailed to me?', 'Yes, just provide your email address at checkout and we\'ll send a digital receipt along with your printed one.', '2025-06-12 23:10:44', '2025-06-19 04:04:34');

-- --------------------------------------------------------

--
-- Table structure for table `login_history`
--

CREATE TABLE `login_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_time` datetime NOT NULL DEFAULT current_timestamp(),
  `logout_time` datetime DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `login_status` enum('success','failed') NOT NULL DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `low_stock_alerts`
--

CREATE TABLE `low_stock_alerts` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `threshold` int(11) NOT NULL,
  `alert_date` datetime NOT NULL,
  `alerted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `barcode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `category_id`, `price`, `stock`, `image_path`, `created_at`, `updated_at`, `barcode`) VALUES
(14, 'Masking Tape', 'a tape', 10, 45.00, 149, '../uploads/products/maskingtape.jpg', '2025-06-12 04:56:10', '2025-06-19 11:59:51', NULL),
(15, 'flexstick black ballpen', 'flexstick black ballpen. 1 pcs', 9, 10.00, 114, '../uploads/products/flexstickblackballpen.jpg', '2025-06-12 04:57:49', '2025-06-19 10:49:42', NULL),
(16, 'ribbon tape', 'a tape with design', 10, 25.00, 15, '../uploads/products/ribbontape.jpg', '2025-06-12 05:57:10', '2025-06-19 11:57:09', NULL),
(17, 'red tape yan', 'red na tape', 10, 20.00, 17, '../uploads/products/684a8cb1ac1db.jpg', '2025-06-12 08:15:45', '2025-06-19 12:00:18', NULL),
(18, 'scotchtape', 'scotch na tape siya', 10, 10.00, 84, '../uploads/products/684a8d8eafc65.jpg', '2025-06-12 08:19:26', '2025-06-19 11:57:09', NULL),
(19, 'electrical tape', 'electric', 10, 35.00, 136, '../uploads/products/684b53d8b79ac.jpg', '2025-06-12 08:56:24', '2025-06-19 10:41:34', NULL),
(22, 'Black Notebook', 'black', 11, 30.00, 14, '../uploads/products/684b9657f167e.jpg', '2025-06-13 03:09:11', '2025-06-19 15:13:11', NULL),
(23, 'Blue Notebook', 'blue', 11, 30.00, 50, '../uploads/products/684b96e7b9ac8.jpg', '2025-06-13 03:09:43', '2025-06-19 12:42:48', NULL),
(28, 'Sticky Notes', 'Removable adhesive notes for reminders.', 11, 30.00, 150, '../uploads/products/6854069f395d0.jpg', '2025-06-19 12:46:23', '2025-06-19 12:46:23', NULL),
(29, 'Index Card', 'For study flashcards or quick notes.  per pieces', 11, 2.00, 100, '../uploads/products/685406dd114f4.jpg', '2025-06-19 12:47:25', '2025-06-19 12:47:25', NULL),
(30, 'Brown Folder', 'a brown folder keep assignments and handouts organized.\r\n\r\n', 15, 20.00, 100, '../uploads/products/6854077ee14d8.jpg', '2025-06-19 12:50:06', '2025-06-19 12:50:06', NULL),
(31, 'Totoro Sling Bag', 'A messenger bag that is totoro', 16, 700.00, 250, '../uploads/products/68540b299b1b4.jpg', '2025-06-19 13:05:45', '2025-06-19 13:05:45', NULL),
(32, 'study lamp white', 'a white study lamp', 17, 100.00, 100, '../uploads/products/68540b4f1e953.jpg', '2025-06-19 13:06:23', '2025-06-19 13:06:23', NULL),
(33, 'Thermal Printer', 'a small, on hand thermal printer', 20, 199.00, 150, '../uploads/products/68540b791ad37.jpg', '2025-06-19 13:07:05', '2025-06-19 13:07:05', NULL),
(34, 'sketchbook', 'sketchbook', 11, 79.00, 500, '../uploads/products/68540b976002b.jpg', '2025-06-19 13:07:35', '2025-06-19 13:07:35', NULL),
(35, 'Sharpener', 'sharpener with a lid', NULL, 15.00, 100, '../uploads/products/68540bf44e7db.jpg', '2025-06-19 13:09:08', '2025-06-19 13:09:08', NULL),
(36, 'Ruler', 'ruler', 18, 20.00, 100, '../uploads/products/68540c0fe6ad1.jpg', '2025-06-19 13:09:35', '2025-06-19 13:09:35', NULL),
(37, 'scissor', 'black scissor', 18, 35.00, 50, '../uploads/products/68540c38ce560.jpg', '2025-06-19 13:10:16', '2025-06-19 13:10:16', NULL),
(38, 'pusheen pencil case', 'pencil case na cute', 17, 75.00, 70, '../uploads/products/68540c6722562.jpg', '2025-06-19 13:11:03', '2025-06-19 13:11:03', NULL),
(39, 'black organizer', 'black organizer', 17, 35.00, 18, '../uploads/products/68540c835f1a8.jpg', '2025-06-19 13:11:31', '2025-06-19 13:11:31', NULL),
(40, 'alarm clock', 'white alarm clock', 20, 130.00, 19, '../uploads/products/68540c9cda34e.jpg', '2025-06-19 13:11:56', '2025-06-19 15:13:11', NULL),
(41, 'drawer organizer', 'black organizer drawer', 17, 120.00, 10, '../uploads/products/68540cf1d7e73.jpg', '2025-06-19 13:13:21', '2025-06-19 13:13:21', NULL),
(42, 'music player', 'music player', 20, 250.00, 15, '../uploads/products/68540d0a09870.jpg', '2025-06-19 13:13:46', '2025-06-19 13:13:46', NULL),
(43, 'onigiri notebook', 'cute', 11, 25.00, 30, '../uploads/products/68540dd983c41.jpg', '2025-06-19 13:17:13', '2025-06-19 13:17:13', NULL),
(44, 'purple binder', 'a binder', 17, 30.00, 20, '../uploads/products/68540df545d37.jpg', '2025-06-19 13:17:41', '2025-06-19 13:17:41', NULL),
(45, 'organizer desk', 'desk organizer', 17, 80.00, 20, '../uploads/products/68540e16362e9.jpg', '2025-06-19 13:18:14', '2025-06-19 13:18:14', NULL),
(46, 'blue lunchbag', 'lunchbag', 16, 99.00, 20, '../uploads/products/68540e2fcf9a3.jpg', '2025-06-19 13:18:39', '2025-06-19 13:18:39', NULL),
(47, '40 pieces crayola', 'crayola', 18, 59.00, 60, '../uploads/products/68540e590828e.jpg', '2025-06-19 13:19:21', '2025-06-19 13:19:21', NULL),
(48, 'hello kitty notebook', 'cute', 11, 30.00, 50, '../uploads/products/68540e803ef6c.jpg', '2025-06-19 13:20:00', '2025-06-19 13:20:00', NULL),
(49, 'converse backpack', 'bag', 16, 299.00, 30, '../uploads/products/68540e9e35bab.jpg', '2025-06-19 13:20:30', '2025-06-19 13:20:30', NULL),
(50, '2H Pencil', 'pencil', 9, 20.00, 99, '../uploads/products/68540ed07999c.jpg', '2025-06-19 13:21:20', '2025-06-19 13:21:20', NULL),
(51, 'Pink Lunchbag', 'lunchbag', 16, 99.00, 50, '../uploads/products/68540eeeb83bc.jpg', '2025-06-19 13:21:50', '2025-06-19 13:21:50', NULL),
(52, 'cute y2k bag', 'black bag', 16, 299.00, 20, '../uploads/products/68540f0e67c6a.jpg', '2025-06-19 13:22:22', '2025-06-19 13:22:22', NULL),
(53, 'pen holder', 'black pen holder', 17, 30.00, 20, '../uploads/products/68540f26422c4.jpg', '2025-06-19 13:22:46', '2025-06-19 13:22:46', NULL),
(54, 'gudetam calendar', 'calendar', 17, 99.00, 10, '../uploads/products/685410afd207a.jpg', '2025-06-19 13:29:19', '2025-06-19 13:29:19', NULL),
(55, 'violet cat headphone', 'headphone', 20, 299.00, 30, '../uploads/products/685410cb0f368.jpg', '2025-06-19 13:29:47', '2025-06-19 13:29:47', NULL),
(56, 'bear tape dispenser', 'tape dispenser', 17, 59.00, 30, '../uploads/products/685410fb9c8b3.jpg', '2025-06-19 13:30:35', '2025-06-19 13:30:35', NULL),
(57, 'cate tape dispenser', 'tape dispenser', 17, 59.00, 20, '../uploads/products/68541112f3cfd.jpg', '2025-06-19 13:30:59', '2025-06-19 13:30:59', NULL),
(58, 'white cat tape dispenser', 'tape dispenser', 17, 59.00, 29, '../uploads/products/6854112fbf67b.jpg', '2025-06-19 13:31:27', '2025-06-19 13:31:27', NULL),
(59, 'purple notebook', 'notebook', 11, 29.00, 50, '../uploads/products/6854114f25d21.jpg', '2025-06-19 13:31:59', '2025-06-19 13:31:59', NULL),
(60, 'kuromi phone holder', 'phone holder', 17, 39.00, 56, '../uploads/products/6854117312529.jpg', '2025-06-19 13:32:35', '2025-06-19 13:32:35', NULL),
(61, 'gudetama calculator', 'calculator', 20, 79.00, 60, '../uploads/products/6854118e90536.jpg', '2025-06-19 13:33:02', '2025-06-19 13:33:02', NULL),
(62, 'plant', 'plant', 17, 69.00, 20, '../uploads/products/685411ae7de7e.jpg', '2025-06-19 13:33:34', '2025-06-19 13:33:34', NULL),
(63, 'pompompurin pen', 'ballpen', 9, 25.00, 60, '../uploads/products/685411e2f084b.jpg', '2025-06-19 13:34:26', '2025-06-19 13:34:26', NULL),
(64, 'pompompurin pen 2', 'pen', 9, 29.00, 65, '../uploads/products/685411f82d66a.jpg', '2025-06-19 13:34:48', '2025-06-19 13:34:48', NULL),
(65, 'pochacco pencil case', 'pencil case', 17, 69.00, 60, '../uploads/products/6854121c146fc.jpg', '2025-06-19 13:35:24', '2025-06-19 13:35:24', NULL),
(66, 'pink notebook thick', 'notebook', 11, 69.00, 30, '../uploads/products/68541251c88af.jpg', '2025-06-19 13:36:17', '2025-06-19 13:36:17', NULL),
(67, 'cat pencil case ', 'pencil case', 17, 69.00, 30, '../uploads/products/68541285598e6.jpg', '2025-06-19 13:37:09', '2025-06-19 13:37:09', NULL),
(68, 'cinnamorol pencil case', 'pencil case', 17, 69.00, 30, '../uploads/products/685412a6ee92b.jpg', '2025-06-19 13:37:42', '2025-06-19 13:37:42', NULL),
(69, 'multicolor pen', 'pen', 9, 39.00, 29, '../uploads/products/685412c0961f3.jpg', '2025-06-19 13:38:08', '2025-06-19 13:38:08', NULL),
(70, 'multicolor pen 2', 'pen', 9, 39.00, 37, '../uploads/products/685412db588fd.jpg', '2025-06-19 13:38:35', '2025-06-19 13:38:35', NULL),
(71, 'capybara bag', 'bag', 16, 199.00, 30, '../uploads/products/685413d77d11d.jpg', '2025-06-19 13:42:47', '2025-06-19 13:42:47', NULL),
(72, 'yellow mini bag', 'bag yello', 16, 199.00, 30, '../uploads/products/685413efab5e5.jpg', '2025-06-19 13:43:11', '2025-06-19 13:43:11', NULL),
(73, 'strawberry bag pink', 'bag na pink', 16, 199.00, 30, '../uploads/products/68541405bd8c2.jpg', '2025-06-19 13:43:33', '2025-06-19 13:43:33', NULL),
(74, 'pink bag mini', 'bag na mini', 16, 199.00, 21, '../uploads/products/6854141aedde3.jpg', '2025-06-19 13:43:54', '2025-06-19 13:43:54', NULL),
(75, 'miffy bag', 'bag', 16, 199.00, 30, '../uploads/products/6854142b7ab42.jpg', '2025-06-19 13:44:11', '2025-06-19 13:44:11', NULL),
(76, 'cat tape', 'tape', 10, 26.00, 61, '../uploads/products/685414c192606.jpg', '2025-06-19 13:46:41', '2025-06-19 13:46:41', NULL),
(77, 'cat tape black and white', 'tape na cat', 10, 29.00, 60, '../uploads/products/685414d810dd9.jpg', '2025-06-19 13:47:04', '2025-06-19 13:47:04', NULL),
(78, 'cute pink tape', ' pink tape', 10, 25.00, 30, '../uploads/products/685414eb574e7.jpg', '2025-06-19 13:47:23', '2025-06-19 13:47:23', NULL),
(79, 'corgi tape', 'tape', 10, 29.00, 30, '../uploads/products/685414fb949ae.jpg', '2025-06-19 13:47:39', '2025-06-19 13:47:39', NULL),
(80, 'gudetama pen', 'pen', 9, 29.00, 30, '../uploads/products/6854152b37bb0.jpg', '2025-06-19 13:48:27', '2025-06-19 13:48:27', NULL),
(81, 'pink paw pen', 'pen', 9, 29.00, 100, '../uploads/products/6854154aa7f3e.jpg', '2025-06-19 13:48:58', '2025-06-19 13:48:58', NULL),
(82, 'multicolor pen 3', 'pen', 9, 39.00, 130, '../uploads/products/685415664209e.jpg', '2025-06-19 13:49:26', '2025-06-19 13:49:26', NULL),
(83, 'multi color pen 5', 'pen', 9, 39.00, 23, '../uploads/products/685415860bb32.jpg', '2025-06-19 13:49:58', '2025-06-19 13:49:58', NULL),
(84, 'kuromi clock', 'clock', 20, 99.00, 30, '../uploads/products/685415c18825c.jpg', '2025-06-19 13:50:57', '2025-06-19 13:50:57', NULL),
(85, 'desk fan cat', 'fan', 20, 199.00, 60, '../uploads/products/685415d5280b9.jpg', '2025-06-19 13:51:17', '2025-06-19 13:51:17', NULL),
(86, 'kuromi calculator', 'calculator', 20, 129.00, 30, '../uploads/products/685415f5a029a.jpg', '2025-06-19 13:51:49', '2025-06-19 13:51:49', NULL),
(87, 'bear calculator', 'calculator', 20, 129.00, 19, '../uploads/products/68541611167f6.jpg', '2025-06-19 13:52:17', '2025-06-19 15:13:11', NULL),
(88, 'clipboard violet', 'clipboard', 15, 69.00, 20, '../uploads/products/685416c54a532.jpg', '2025-06-19 13:55:17', '2025-06-19 13:55:17', NULL),
(89, 'cute pink binder', 'binder', 15, 69.00, 31, '../uploads/products/685416db09dad.jpg', '2025-06-19 13:55:39', '2025-06-19 13:55:39', NULL),
(90, 'clipboard pink', 'clipboard', 15, 69.00, 13, '../uploads/products/685416f16a27c.jpg', '2025-06-19 13:56:01', '2025-06-19 13:56:01', NULL),
(91, 'pastel binder', 'binder', 15, 69.00, 32, '../uploads/products/6854170243ac4.jpg', '2025-06-19 13:56:18', '2025-06-19 13:56:18', NULL),
(92, 'pink folder', 'folder', 15, 20.00, 100, '../uploads/products/685417248ab87.jpg', '2025-06-19 13:56:52', '2025-06-19 13:56:52', NULL),
(93, 'green folder', 'folder', 15, 20.00, 97, '../uploads/products/68541738f3082.jpg', '2025-06-19 13:57:12', '2025-06-19 13:57:12', NULL),
(94, 'blue folder', 'folder', 15, 20.00, 86, '../uploads/products/6854174b9a3ce.jpg', '2025-06-19 13:57:31', '2025-06-19 13:57:31', NULL),
(95, 'black binder', 'binder ', 15, 29.00, 45, '../uploads/products/685417861fcb8.jpg', '2025-06-19 13:58:30', '2025-06-19 15:13:11', NULL),
(96, 'gouche paint ', 'paint', 18, 199.00, 32, '../uploads/products/6854195db10b8.jpg', '2025-06-19 14:06:21', '2025-06-19 14:06:21', NULL),
(97, 'pallete', 'pallete', 18, 99.00, 60, '../uploads/products/68541976e395d.jpg', '2025-06-19 14:06:46', '2025-06-19 14:06:46', NULL),
(98, 'school paint ', 'paint set', 18, 99.00, 123, '../uploads/products/6854198c8b1a9.jpg', '2025-06-19 14:07:08', '2025-06-19 14:07:08', NULL),
(99, 'watercolor', 'watercolor', 18, 79.00, 150, '../uploads/products/685419a41df86.jpg', '2025-06-19 14:07:32', '2025-06-19 14:07:32', NULL),
(100, 'watercolor 2', 'watercolor', 18, 299.00, 30, '../uploads/products/685419f4140ba.jpg', '2025-06-19 14:08:52', '2025-06-19 14:08:52', NULL),
(101, 'acrylic paint', 'paint', 18, 399.00, 20, '../uploads/products/68541a0771866.jpg', '2025-06-19 14:09:11', '2025-06-19 14:09:11', NULL),
(102, 'acrylic markers', 'marker', 18, 199.00, 30, '../uploads/products/68541a2211b0e.jpg', '2025-06-19 14:09:38', '2025-06-19 14:09:38', NULL),
(103, 'color marker', 'marker', 18, 175.00, 40, '../uploads/products/68541a3c2e037.jpg', '2025-06-19 14:10:04', '2025-06-19 14:10:04', NULL);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `after_product_insert` AFTER INSERT ON `products` FOR EACH ROW BEGIN
    INSERT INTO stock (product_id, quantity) VALUES (NEW.id, NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_product_update` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    UPDATE stock SET quantity = NEW.stock WHERE product_id = NEW.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_history`
--

CREATE TABLE `product_history` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `edited_by` int(11) NOT NULL,
  `edit_date` datetime NOT NULL,
  `old_data` text NOT NULL,
  `new_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receipt_settings`
--

CREATE TABLE `receipt_settings` (
  `id` int(11) NOT NULL,
  `store_name` varchar(100) NOT NULL DEFAULT 'MY STORE',
  `store_address` varchar(255) NOT NULL DEFAULT '123 Main Street, City',
  `store_phone` varchar(50) NOT NULL DEFAULT 'Tel: (123) 456-7890',
  `thank_you_message` varchar(255) NOT NULL DEFAULT 'Thank you for your purchase!',
  `receipt_prefix` varchar(10) NOT NULL DEFAULT 'ORD',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receipt_settings`
--

INSERT INTO `receipt_settings` (`id`, `store_name`, `store_address`, `store_phone`, `thank_you_message`, `receipt_prefix`, `created_at`, `updated_at`) VALUES
(1, 'store ni gwen', '123 Mickey Mouse Club House, Paranaque City', 'Tel: (123) 4567890', 'Thank you mga bhe', '', '2025-06-19 07:43:29', '2025-06-19 12:03:47');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sale_id` int(11) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `receipt_number` varchar(20) DEFAULT NULL,
  `status` enum('completed','voided') DEFAULT 'completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sale_id`, `transaction_date`, `customer_id`, `total_amount`, `receipt_number`, `status`) VALUES
(25, '2025-06-18 18:32:58', NULL, 20.00, NULL, 'completed'),
(26, '2025-06-18 18:33:13', NULL, 145.00, NULL, 'completed'),
(27, '2025-06-18 19:15:13', NULL, 95.00, NULL, 'completed'),
(28, '2025-06-18 20:01:06', NULL, 60.00, NULL, 'completed'),
(29, '2025-06-18 20:30:15', NULL, 60.00, NULL, 'completed'),
(30, '2025-06-18 20:31:33', NULL, 50.00, NULL, 'completed'),
(31, '2025-06-18 20:31:53', NULL, 65.00, NULL, 'completed'),
(32, '2025-06-18 20:34:38', NULL, 60.00, NULL, 'completed'),
(33, '2025-06-18 20:55:52', NULL, 50.00, NULL, 'completed'),
(34, '2025-06-18 21:52:15', NULL, 30.00, NULL, 'completed'),
(35, '2025-06-18 22:19:39', NULL, 35.00, NULL, 'completed'),
(36, '2025-06-18 22:49:41', NULL, 60.00, NULL, 'completed'),
(37, '2025-06-18 23:07:01', NULL, 35.00, NULL, 'completed'),
(38, '2025-06-19 00:28:09', NULL, 40.00, NULL, 'completed'),
(39, '2025-06-19 03:08:02', NULL, 35.00, NULL, 'completed'),
(40, '2025-06-19 15:29:35', NULL, 205.00, NULL, 'completed'),
(41, '2025-06-19 15:34:01', NULL, 350.00, NULL, 'completed'),
(42, '2025-06-19 15:51:51', NULL, 70.00, 'ORD953525', 'completed'),
(43, '2025-06-19 15:52:09', NULL, 70.00, 'ORD833290', 'completed'),
(44, '2025-06-19 15:52:23', NULL, 70.00, NULL, 'completed'),
(45, '2025-06-19 16:08:00', NULL, 60.00, NULL, 'completed'),
(46, '2025-06-19 16:14:04', NULL, 80.00, NULL, 'completed'),
(47, '2025-06-19 16:39:04', NULL, 20.00, NULL, 'completed'),
(48, '2025-06-19 16:57:02', NULL, 135.00, NULL, 'completed'),
(49, '2025-06-19 17:03:43', NULL, 85.00, NULL, 'completed'),
(50, '2025-06-19 17:04:42', NULL, 30.00, NULL, 'completed'),
(51, '2025-06-19 17:07:56', NULL, 20.00, NULL, 'completed'),
(52, '2025-06-19 17:10:31', NULL, 70.00, NULL, 'completed'),
(53, '2025-06-19 17:15:54', NULL, 65.00, NULL, 'completed'),
(54, '2025-06-19 17:18:52', NULL, 10.00, NULL, 'completed'),
(55, '2025-06-19 17:23:02', NULL, 10.00, NULL, 'completed'),
(56, '2025-06-19 17:23:19', NULL, 10.00, NULL, 'completed'),
(57, '2025-06-19 17:23:38', NULL, 35.00, NULL, 'completed'),
(58, '2025-06-19 17:23:57', NULL, 35.00, NULL, 'completed'),
(59, '2025-06-19 17:25:51', NULL, 20.00, NULL, 'completed'),
(60, '2025-06-19 17:37:37', NULL, 70.00, NULL, 'completed'),
(61, '2025-06-19 17:41:46', NULL, 70.00, NULL, 'completed'),
(62, '2025-06-19 17:47:33', NULL, 30.00, NULL, 'completed'),
(63, '2025-06-19 17:55:30', NULL, 40.00, NULL, 'completed'),
(64, '2025-06-19 18:22:21', NULL, 10.00, NULL, 'completed'),
(65, '2025-06-19 18:25:22', NULL, 10.00, NULL, 'completed'),
(66, '2025-06-19 18:41:34', NULL, 35.00, NULL, 'completed'),
(67, '2025-06-19 18:49:42', NULL, 20.00, NULL, 'completed'),
(68, '2025-06-19 19:56:12', NULL, 30.00, NULL, 'completed'),
(69, '2025-06-19 19:57:09', NULL, 35.00, NULL, 'completed'),
(70, '2025-06-19 19:57:52', NULL, 20.00, NULL, 'completed'),
(71, '2025-06-19 19:58:00', NULL, 120.00, NULL, 'completed'),
(72, '2025-06-19 19:59:51', NULL, 65.00, NULL, 'completed'),
(73, '2025-06-19 20:00:18', NULL, 20.00, NULL, 'completed'),
(74, '2025-06-19 20:04:24', NULL, 60.00, NULL, 'completed'),
(75, '2025-06-19 23:13:11', NULL, 318.00, NULL, 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `item_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`item_id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(41, 25, 15, 2, 10.00, 20.00),
(42, 26, 22, 1, 30.00, 30.00),
(43, 26, 23, 1, 30.00, 30.00),
(44, 26, 19, 1, 30.00, 30.00),
(45, 26, 17, 1, 20.00, 20.00),
(46, 26, 16, 1, 25.00, 25.00),
(47, 26, 18, 1, 10.00, 10.00),
(48, 27, 19, 1, 30.00, 30.00),
(49, 27, 15, 1, 10.00, 10.00),
(50, 27, 17, 1, 20.00, 20.00),
(51, 27, 16, 1, 25.00, 25.00),
(52, 27, 18, 1, 10.00, 10.00),
(53, 28, 15, 1, 10.00, 10.00),
(54, 28, 19, 1, 30.00, 30.00),
(55, 28, 17, 1, 20.00, 20.00),
(56, 29, 19, 1, 30.00, 30.00),
(57, 29, 15, 1, 10.00, 10.00),
(58, 29, 17, 1, 20.00, 20.00),
(59, 30, 16, 2, 25.00, 50.00),
(60, 31, 16, 1, 25.00, 25.00),
(61, 31, 18, 1, 10.00, 10.00),
(62, 31, 19, 1, 30.00, 30.00),
(63, 32, 19, 1, 30.00, 30.00),
(64, 32, 15, 1, 10.00, 10.00),
(65, 32, 17, 1, 20.00, 20.00),
(66, 33, 19, 1, 30.00, 30.00),
(67, 33, 15, 1, 10.00, 10.00),
(68, 33, 18, 1, 10.00, 10.00),
(69, 34, 23, 1, 30.00, 30.00),
(70, 35, 16, 1, 25.00, 25.00),
(71, 35, 18, 1, 10.00, 10.00),
(72, 36, 19, 1, 30.00, 30.00),
(73, 36, 15, 1, 10.00, 10.00),
(74, 36, 17, 1, 20.00, 20.00),
(75, 37, 18, 1, 10.00, 10.00),
(76, 37, 16, 1, 25.00, 25.00),
(77, 38, 19, 1, 30.00, 30.00),
(78, 38, 15, 1, 10.00, 10.00),
(79, 39, 18, 1, 10.00, 10.00),
(80, 39, 16, 1, 25.00, 25.00),
(81, 40, 19, 3, 35.00, 105.00),
(82, 40, 23, 3, 30.00, 90.00),
(83, 40, 15, 1, 10.00, 10.00),
(84, 41, 19, 10, 35.00, 350.00),
(85, 42, 22, 1, 30.00, 30.00),
(86, 42, 23, 1, 30.00, 30.00),
(87, 42, 15, 1, 10.00, 10.00),
(88, 43, 22, 1, 30.00, 30.00),
(89, 43, 23, 1, 30.00, 30.00),
(90, 43, 15, 1, 10.00, 10.00),
(91, 44, 22, 1, 30.00, 30.00),
(92, 44, 23, 1, 30.00, 30.00),
(93, 44, 15, 1, 10.00, 10.00),
(94, 45, 22, 2, 30.00, 60.00),
(95, 46, 22, 1, 30.00, 30.00),
(96, 46, 23, 1, 30.00, 30.00),
(97, 46, 15, 2, 10.00, 20.00),
(98, 47, 15, 2, 10.00, 20.00),
(99, 48, 19, 3, 35.00, 105.00),
(100, 48, 23, 1, 30.00, 30.00),
(101, 49, 23, 1, 30.00, 30.00),
(102, 49, 19, 1, 35.00, 35.00),
(103, 49, 15, 2, 10.00, 20.00),
(104, 50, 15, 3, 10.00, 30.00),
(105, 51, 18, 2, 10.00, 20.00),
(106, 52, 19, 2, 35.00, 70.00),
(107, 53, 23, 1, 30.00, 30.00),
(108, 53, 19, 1, 35.00, 35.00),
(109, 54, 15, 1, 10.00, 10.00),
(110, 55, 15, 1, 10.00, 10.00),
(111, 56, 15, 1, 10.00, 10.00),
(112, 57, 19, 1, 35.00, 35.00),
(113, 58, 19, 1, 35.00, 35.00),
(114, 59, 15, 2, 10.00, 20.00),
(115, 60, 19, 2, 35.00, 70.00),
(116, 61, 19, 2, 35.00, 70.00),
(117, 62, 23, 1, 30.00, 30.00),
(118, 63, 17, 2, 20.00, 40.00),
(119, 64, 18, 1, 10.00, 10.00),
(120, 65, 18, 1, 10.00, 10.00),
(121, 66, 19, 1, 35.00, 35.00),
(122, 67, 15, 2, 10.00, 20.00),
(123, 68, 23, 1, 30.00, 30.00),
(124, 69, 18, 1, 10.00, 10.00),
(125, 69, 16, 1, 25.00, 25.00),
(126, 70, 17, 1, 20.00, 20.00),
(127, 71, 22, 2, 30.00, 60.00),
(128, 71, 23, 2, 30.00, 60.00),
(129, 72, 14, 1, 45.00, 45.00),
(130, 72, 17, 1, 20.00, 20.00),
(131, 73, 17, 1, 20.00, 20.00),
(132, 74, 23, 1, 30.00, 30.00),
(133, 74, 22, 1, 30.00, 30.00),
(134, 75, 87, 1, 129.00, 129.00),
(135, 75, 40, 1, 130.00, 130.00),
(136, 75, 95, 1, 29.00, 29.00),
(137, 75, 22, 1, 30.00, 30.00);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`id`, `product_id`, `quantity`, `last_updated`) VALUES
(2, 14, 149, '2025-06-19 11:59:51'),
(3, 15, 114, '2025-06-19 10:49:42'),
(4, 16, 15, '2025-06-19 11:57:09'),
(5, 17, 17, '2025-06-19 12:00:18'),
(6, 18, 84, '2025-06-19 11:57:09'),
(7, 19, 136, '2025-06-19 10:41:34'),
(10, 22, 14, '2025-06-19 15:13:11'),
(11, 23, 50, '2025-06-19 12:42:48'),
(16, 28, 150, '2025-06-19 12:46:23'),
(17, 29, 100, '2025-06-19 12:47:25'),
(18, 30, 100, '2025-06-19 12:50:06'),
(19, 31, 250, '2025-06-19 13:05:45'),
(20, 32, 100, '2025-06-19 13:06:23'),
(21, 33, 150, '2025-06-19 13:07:05'),
(22, 34, 500, '2025-06-19 13:07:35'),
(23, 35, 100, '2025-06-19 13:09:08'),
(24, 36, 100, '2025-06-19 13:09:35'),
(25, 37, 50, '2025-06-19 13:10:16'),
(26, 38, 70, '2025-06-19 13:11:03'),
(27, 39, 18, '2025-06-19 13:11:31'),
(28, 40, 19, '2025-06-19 15:13:11'),
(29, 41, 10, '2025-06-19 13:13:21'),
(30, 42, 15, '2025-06-19 13:13:46'),
(31, 43, 30, '2025-06-19 13:17:13'),
(32, 44, 20, '2025-06-19 13:17:41'),
(33, 45, 20, '2025-06-19 13:18:14'),
(34, 46, 20, '2025-06-19 13:18:39'),
(35, 47, 60, '2025-06-19 13:19:21'),
(36, 48, 50, '2025-06-19 13:20:00'),
(37, 49, 30, '2025-06-19 13:20:30'),
(38, 50, 99, '2025-06-19 13:21:20'),
(39, 51, 50, '2025-06-19 13:21:50'),
(40, 52, 20, '2025-06-19 13:22:22'),
(41, 53, 20, '2025-06-19 13:22:46'),
(42, 54, 10, '2025-06-19 13:29:19'),
(43, 55, 30, '2025-06-19 13:29:47'),
(44, 56, 30, '2025-06-19 13:30:35'),
(45, 57, 20, '2025-06-19 13:30:59'),
(46, 58, 29, '2025-06-19 13:31:27'),
(47, 59, 50, '2025-06-19 13:31:59'),
(48, 60, 56, '2025-06-19 13:32:35'),
(49, 61, 60, '2025-06-19 13:33:02'),
(50, 62, 20, '2025-06-19 13:33:34'),
(51, 63, 60, '2025-06-19 13:34:26'),
(52, 64, 65, '2025-06-19 13:34:48'),
(53, 65, 60, '2025-06-19 13:35:24'),
(54, 66, 30, '2025-06-19 13:36:17'),
(55, 67, 30, '2025-06-19 13:37:09'),
(56, 68, 30, '2025-06-19 13:37:42'),
(57, 69, 29, '2025-06-19 13:38:08'),
(58, 70, 37, '2025-06-19 13:38:35'),
(59, 71, 30, '2025-06-19 13:42:47'),
(60, 72, 30, '2025-06-19 13:43:11'),
(61, 73, 30, '2025-06-19 13:43:33'),
(62, 74, 21, '2025-06-19 13:43:54'),
(63, 75, 30, '2025-06-19 13:44:11'),
(64, 76, 61, '2025-06-19 13:46:41'),
(65, 77, 60, '2025-06-19 13:47:04'),
(66, 78, 30, '2025-06-19 13:47:23'),
(67, 79, 30, '2025-06-19 13:47:39'),
(68, 80, 30, '2025-06-19 13:48:27'),
(69, 81, 100, '2025-06-19 13:48:58'),
(70, 82, 130, '2025-06-19 13:49:26'),
(71, 83, 23, '2025-06-19 13:49:58'),
(72, 84, 30, '2025-06-19 13:50:57'),
(73, 85, 60, '2025-06-19 13:51:17'),
(74, 86, 30, '2025-06-19 13:51:49'),
(75, 87, 19, '2025-06-19 15:13:11'),
(76, 88, 20, '2025-06-19 13:55:17'),
(77, 89, 31, '2025-06-19 13:55:39'),
(78, 90, 13, '2025-06-19 13:56:01'),
(79, 91, 32, '2025-06-19 13:56:18'),
(80, 92, 100, '2025-06-19 13:56:52'),
(81, 93, 97, '2025-06-19 13:57:12'),
(82, 94, 86, '2025-06-19 13:57:31'),
(83, 95, 45, '2025-06-19 15:13:11'),
(84, 96, 32, '2025-06-19 14:06:21'),
(85, 97, 60, '2025-06-19 14:06:46'),
(86, 98, 123, '2025-06-19 14:07:08'),
(87, 99, 150, '2025-06-19 14:07:32'),
(88, 100, 30, '2025-06-19 14:08:52'),
(89, 101, 20, '2025-06-19 14:09:11'),
(90, 102, 30, '2025-06-19 14:09:38'),
(91, 103, 40, '2025-06-19 14:10:04');

-- --------------------------------------------------------

--
-- Table structure for table `stock_changes`
--

CREATE TABLE `stock_changes` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `old_quantity` int(11) NOT NULL,
  `new_quantity` int(11) NOT NULL,
  `change_amount` int(11) NOT NULL,
  `change_type` enum('in','out') NOT NULL,
  `change_date` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_events`
--

CREATE TABLE `system_events` (
  `id` int(11) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_description` text NOT NULL,
  `event_timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `action_timestamp` (`action_timestamp`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_history`
--
ALTER TABLE `login_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `login_time` (`login_time`);

--
-- Indexes for table `low_stock_alerts`
--
ALTER TABLE `low_stock_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `alerted_by` (`alerted_by`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_history`
--
ALTER TABLE `product_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `edited_by` (`edited_by`);

--
-- Indexes for table `receipt_settings`
--
ALTER TABLE `receipt_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sale_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `sale_id` (`sale_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `stock_changes`
--
ALTER TABLE `stock_changes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `system_events`
--
ALTER TABLE `system_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_timestamp` (`event_timestamp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `login_history`
--
ALTER TABLE `login_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `low_stock_alerts`
--
ALTER TABLE `low_stock_alerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `product_history`
--
ALTER TABLE `product_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receipt_settings`
--
ALTER TABLE `receipt_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `stock_changes`
--
ALTER TABLE `stock_changes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_events`
--
ALTER TABLE `system_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `low_stock_alerts`
--
ALTER TABLE `low_stock_alerts`
  ADD CONSTRAINT `low_stock_alerts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `low_stock_alerts_ibfk_2` FOREIGN KEY (`alerted_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_history`
--
ALTER TABLE `product_history`
  ADD CONSTRAINT `product_history_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_history_ibfk_2` FOREIGN KEY (`edited_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`) ON DELETE CASCADE;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_changes`
--
ALTER TABLE `stock_changes`
  ADD CONSTRAINT `stock_changes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_changes_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
