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
-- Table structure for table `courier_staff`
--

DROP TABLE IF EXISTS `courier_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier_staff` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `staff_id` varchar(20) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `role` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `address` longtext,
  `profile_image` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courier_staff_staff_id_ae878feb_uniq` (`staff_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `courier_staff_user_id_40230902_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier_staff`
--

LOCK TABLES `courier_staff` WRITE;
/*!40000 ALTER TABLE `courier_staff` DISABLE KEYS */;
INSERT INTO `courier_staff` VALUES (2,'STF1071','6978765787','Mysore','Delivery Staff',4,'Mysore','staff_profiles/download_4.jpg','Lokesh@gmail.com'),(3,'STF4697','9878688979','Hassan','Delivery Staff',5,'None','staff_profiles/download_2.jpg','Bharath@gmail.com'),(4,'STF5035','7878919627','Bangalore','Delivery Staff',6,NULL,'',NULL),(5,'STF7395','9876483743','Bangalore','Delivery Staff',7,'Kommagatta, Kengeri, Bangalore 560060 ','staff_profiles/download_5.jpg','kumar@gmail.com'),(6,'STF1868','9878767658','Bangalore','Delivery Staff',12,'','staff_profiles/download_5_9V0skQO.jpg','pavan@gmail.com');
/*!40000 ALTER TABLE `courier_staff` ENABLE KEYS */;
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

-- Dump completed on 2026-04-22 20:49:54
