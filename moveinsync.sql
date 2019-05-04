-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 172.18.0.2:3306
-- Generation Time: May 04, 2019 at 03:54 PM
-- Server version: 5.7.25
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moveinsync`
--
CREATE DATABASE IF NOT EXISTS `moveinsync` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `moveinsync`;

-- --------------------------------------------------------

--
-- Table structure for table `urls`
--

CREATE TABLE `urls` (
  `id` int(11) NOT NULL,
  `url` text NOT NULL,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_processing` int(11) NOT NULL DEFAULT '0',
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `is_failed` tinyint(1) NOT NULL DEFAULT '0',
  `error_message` text,
  `http_error_code` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `urls`
--

INSERT INTO `urls` (`id`, `url`, `response`, `is_processing`, `is_processed`, `is_failed`, `error_message`, `http_error_code`, `created_at`, `updated_at`, `status`) VALUES
(1, 'https://in.bookmyshow.com/movies/avengers-endgame/ET00090482', '', 0, 0, 0, NULL, NULL, '2019-05-04 11:49:40', '2019-05-04 11:49:40', 1),
(2, 'https://codereviewvideos.com/', '', 0, 0, 0, NULL, NULL, '2019-05-04 11:51:37', '2019-05-04 11:51:37', 1),
(3, 'http://www.abcdefghij.com/', '', 0, 0, 0, NULL, NULL, '2019-05-04 11:51:59', '2019-05-04 11:51:59', 1),
(4, 'https://www.99roomz.com/rooms/47293874\r\n', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:08:44', '2019-05-04 13:08:44', 1),
(5, 'https://httpstat.us/401', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:22:22', '2019-05-04 13:22:22', 1),
(6, 'https://httpstat.us/500', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:26:34', '2019-05-04 13:26:34', 1),
(7, 'https://httpstat.us/402', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:36:16', '2019-05-04 13:36:16', 1),
(8, 'https://httpstat.us/403', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:36:16', '2019-05-04 13:36:16', 1),
(9, 'https://httpstat.us/404', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:36:40', '2019-05-04 13:36:40', 1),
(10, 'https://httpstat.us/405', '', 0, 0, 0, NULL, NULL, '2019-05-04 13:36:40', '2019-05-04 13:36:40', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `urls`
--
ALTER TABLE `urls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `urls`
--
ALTER TABLE `urls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
