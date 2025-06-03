-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.2.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table old_database.domains
CREATE TABLE IF NOT EXISTS `domains` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table old_database.domains: ~10 rows (approximately)
INSERT INTO `domains` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'example.com', 'active', '2025-01-01 04:00:00', '2025-01-01 04:00:00'),
	(2, 'testdomain.com', 'active', '2025-01-02 06:00:00', '2025-01-02 06:00:00'),
	(3, 'mywebsite.org', 'active', '2025-01-03 08:00:00', '2025-01-03 08:00:00'),
	(4, 'inactive.net', 'inactive', '2025-01-04 10:00:00', '2025-01-04 10:00:00'),
	(5, 'blogsite.com', 'active', '2025-01-05 12:00:00', '2025-01-05 12:00:00'),
	(6, 'test.example.org', 'active', '2025-01-06 14:00:00', '2025-01-06 14:00:00'),
	(7, 'shoponline.com', 'active', '2025-01-07 16:00:00', '2025-01-07 16:00:00'),
	(8, 'portfolio.io', 'inactive', '2025-01-08 02:00:00', '2025-01-08 02:00:00'),
	(9, 'newsite.co', 'active', '2025-01-09 04:00:00', '2025-01-09 04:00:00'),
	(10, 'learning.edu', 'active', '2025-01-10 06:00:00', '2025-01-10 06:00:00');

-- Dumping structure for table old_database.news
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `status` enum('published','draft') DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table old_database.news: ~10 rows (approximately)
INSERT INTO `news` (`id`, `title`, `content`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Breaking News: Tech Update', 'Latest tech advancements...', 'published', '2025-02-01 03:00:00', '2025-02-01 03:00:00'),
	(2, 'Test News Article', 'This is a test article...', 'published', '2025-02-02 05:00:00', '2025-02-02 05:00:00'),
	(3, 'Global Events Summary', 'Summary of global events...', 'published', '2025-02-03 07:00:00', '2025-02-03 07:00:00'),
	(4, 'Draft Article One', 'Work in progress...', 'draft', '2025-02-04 09:00:00', '2025-02-04 09:00:00'),
	(5, 'Science Breakthrough', 'New discoveries in science...', 'published', '2025-02-05 11:00:00', '2025-02-05 11:00:00'),
	(6, 'Test Technology Trends', 'Testing tech trends...', 'published', '2025-02-06 13:00:00', '2025-02-06 13:00:00'),
	(7, 'Health Tips 2025', 'Tips for staying healthy...', 'published', '2025-02-07 15:00:00', '2025-02-07 15:00:00'),
	(8, 'Unfinished News', 'Not ready yet...', 'draft', '2025-02-08 02:00:00', '2025-02-08 02:00:00'),
	(9, 'Business Insights', 'Insights for businesses...', 'published', '2025-02-09 04:00:00', '2025-02-09 04:00:00'),
	(10, 'Education News', 'Updates in education...', 'published', '2025-02-10 06:00:00', '2025-02-10 06:00:00');

-- Dumping structure for table old_database.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_test` tinyint DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `users_email_unique` (`email`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table old_database.users: 20 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `is_test`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'John Doe', 'john.doe@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-01 04:00:00', '2025-05-01 04:00:00'),
	(2, 'Jane Smith', 'jane.smith@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-02 06:00:00', '2025-05-02 06:00:00'),
	(3, 'Test User', 'test.user@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-03 08:00:00', '2025-05-03 08:00:00'),
	(4, 'Alice Johnson', 'alice.j@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-04 03:00:00', '2025-05-04 03:00:00'),
	(5, 'Dummy Test', 'dummy@test.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-05 05:00:00', '2025-05-05 05:00:00'),
	(6, 'Bob Wilson', 'bob.wilson@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-06 09:00:00', '2025-05-06 09:00:00'),
	(7, 'Test Account', 'test.account@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-07 10:00:00', '2025-05-07 10:00:00'),
	(8, 'Emma Brown', 'emma.brown@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-08 02:00:00', '2025-05-08 02:00:00'),
	(9, 'Test Dummy', 'test.dummy@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-09 04:00:00', '2025-05-09 04:00:00'),
	(10, 'Michael Chen', 'michael.chen@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-10 07:00:00', '2025-05-10 07:00:00'),
	(11, 'Sarah Davis', 'sarah.davis@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-11 08:00:00', '2025-05-11 08:00:00'),
	(12, 'Test Tester', 'tester@test.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-12 06:00:00', '2025-05-12 06:00:00'),
	(13, 'Laura Martinez', 'laura.m@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-13 03:00:00', '2025-05-13 03:00:00'),
	(14, 'Dummy User', 'dummy.user@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-14 05:00:00', '2025-05-14 05:00:00'),
	(15, 'David Lee', 'david.lee@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-15 09:00:00', '2025-05-15 09:00:00'),
	(16, 'Test Bot', 'test.bot@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-16 10:00:00', '2025-05-16 10:00:00'),
	(17, 'Emily Clark', 'emily.clark@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-17 02:00:00', '2025-05-17 02:00:00'),
	(18, 'Fake Test', 'fake.test@example.com', 1, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-18 04:00:00', '2025-05-18 04:00:00'),
	(19, 'Chris Evans', 'chris.evans@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-19 07:00:00', '2025-05-19 07:00:00'),
	(20, 'Anna Taylor', 'anna.taylor@example.com', 0, NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2025-05-20 08:00:00', '2025-05-20 08:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
