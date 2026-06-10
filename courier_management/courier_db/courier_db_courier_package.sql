-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: courier_db
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '46aaf2dc-3709-11f1-9f51-68f728fad17f:1-425';

--
-- Table structure for table `courier_package`
--

DROP TABLE IF EXISTS `courier_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier_package` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sender_name` varchar(100) NOT NULL,
  `sender_address` longtext NOT NULL,
  `sender_phone` varchar(10) NOT NULL,
  `receiver_name` varchar(100) NOT NULL,
  `receiver_address` longtext NOT NULL,
  `receiver_phone` varchar(10) NOT NULL,
  `package_weight` decimal(5,2) NOT NULL,
  `package_image` varchar(100) DEFAULT NULL,
  `tracking_id` varchar(20) NOT NULL,
  `booking_date` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `current_city` varchar(100) NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `assigned_staff_id` bigint DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracking_id` (`tracking_id`),
  KEY `courier_package_user_id_a37a38c0_fk_auth_user_id` (`user_id`),
  KEY `courier_package_assigned_staff_id_71f50270_fk_courier_staff_id` (`assigned_staff_id`),
  CONSTRAINT `courier_package_assigned_staff_id_71f50270_fk_courier_staff_id` FOREIGN KEY (`assigned_staff_id`) REFERENCES `courier_staff` (`id`),
  CONSTRAINT `courier_package_user_id_a37a38c0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier_package`
--

LOCK TABLES `courier_package` WRITE;
/*!40000 ALTER TABLE `courier_package` DISABLE KEYS */;
INSERT INTO `courier_package` VALUES (1,'Manushree','Arasikere','8767657658','Dhanush','Mysore','8666878988',4.00,'package_images/IMG_20260312_113541.jpg','TRK67739','2026-04-21 07:33:06.974254','Delivered','Tumkur','2026-04-21 14:57:29.978849',9,3,0.00,NULL,'Pending'),(2,'Pallavi','Rajajinagar, Bangalore','8876987988','Shruthi','Kengeri, Bangalore','9731144324',3.00,'','TRK10326','2026-04-21 07:36:08.677120','In Transit','Dhasarahalli','2026-04-21 07:38:12.421358',8,5,0.00,NULL,'Pending'),(3,'Sharath','Palalli, Mysore, Karnataka','8978767658','Tarun','Kanya Kumari, Tamil nadu','9877576766',9.00,'','TRK57439','2026-04-22 05:07:14.267500','Out for Delivery','Ramnagar','2026-04-22 15:05:28.271968',11,2,0.00,NULL,'Pending'),(7,'Sharath','Palalli, Mysore, Karnataka','8978767658','Pavan Kumar','Pune, Maharashtra','6387263746',3.00,'package_images/OIP_1.webp','TRK87276','2026-04-22 08:09:12.888611','Booked','Bangalore','2026-04-22 15:00:20.324376',11,3,150.00,'2026-04-22 08:15:13.777140','Paid'),(8,'Manushree','Gollarhatti,magadi main road Bangalore North Bangalore Karnataka','8767657658','Kiran Raj','Malleshwaram , 2nd cross , 3rd main road, Bangalore','9879878898',5.00,'package_images/OIP.webp','TRK53899','2026-04-22 08:24:03.805335','Booked','Bangalore','2026-04-22 08:26:43.369573',9,4,250.00,'2026-04-22 08:24:08.038275','Paid'),(9,'Sharath','Palalli, Mysore, Karnataka','8978767658','Tarun','Kanya Kumari, Tamil nadu','9877576766',3.00,'package_images/OIP_3.webp','TRK81674','2026-04-22 15:13:11.190450','Booked','Bangalore','2026-04-22 15:13:30.073579',11,NULL,150.00,'2026-04-22 15:13:30.073462','Paid');
/*!40000 ALTER TABLE `courier_package` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 20:49:53
