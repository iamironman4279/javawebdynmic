-- Create database `bankapp` if it does not exist
CREATE DATABASE IF NOT EXISTS `bankapp`;
USE `bankapp`;

-- Table structure for table `admin`
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Inserting data into `admin`
INSERT INTO `admin` VALUES (1,'admin','adminpassword');

-- Table structure for table `customer`
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullName` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `mobileNo` varchar(15) DEFAULT NULL,
  `emailId` varchar(100) DEFAULT NULL,
  `accountType` varchar(10) DEFAULT NULL,
  `initialBalance` decimal(10,2) DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `idProof` varchar(50) DEFAULT NULL,
  `accountNo` varchar(20) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `tempPassword` varchar(100) DEFAULT NULL,
  `photoFileName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accountNo` (`accountNo`),
  CONSTRAINT `customer_chk_1` CHECK ((`initialBalance` >= 0))
);

-- Inserting data into `customer`
INSERT INTO `customer` VALUES (1,'guduru hemanth kumar reddy','Thotla palle','09441861353','hemanthrdj@gmail.com','savings',0.00,'2024-07-09','12345678','110709763','1234','68816',NULL),
(3,'guduru hemanth kumar reddy','Thotla palle','09441861353','hemanthrdj@gmail.com','savings',1000.00,'2024-07-10','12345678','5110857',NULL,'27072','5110857.jpg');

-- Table structure for table `transactions`
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(20) DEFAULT NULL,
  `transactionType` varchar(10) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `transactionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `accountNo` (`accountNo`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`accountNo`) REFERENCES `customer` (`accountNo`)
);
