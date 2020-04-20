CREATE DATABASE IF NOT EXISTS crud_flask;
USE crud_flask;
GRANT ALL PRIVILEGES ON crud_flask.* TO 'dev'@'localhost' IDENTIFIED BY 'dev';
FLUSH PRIVILEGES;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--
-- Database: `crud_flask`
--
-- --------------------------------------------------------
--
-- Table structure for table `phone_book`
--
CREATE TABLE IF NOT EXISTS `phone_book` (`id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `phone_book`
--
INSERT INTO `phone_book` (`id`, `name`, `phone`, `address`) VALUES (16, 'Muhammad Hanif', '085733492411', 'Lamongan');
--
-- Indexes for dumped tables
--
--
-- Indexes for table `phone_book`
--
ALTER TABLE `phone_book` ADD PRIMARY KEY (`id`);
--
-- AUTO_INCREMENT for dumped tables
--
--
-- AUTO_INCREMENT for table `phone_book`
--
ALTER TABLE `phone_book` MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
