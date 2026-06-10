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
-- Table structure for table `courier_trackinghistory`
--

DROP TABLE IF EXISTS `courier_trackinghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier_trackinghistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `package_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courier_trackinghist_package_id_144d745f_fk_courier_p` (`package_id`),
  CONSTRAINT `courier_trackinghist_package_id_144d745f_fk_courier_p` FOREIGN KEY (`package_id`) REFERENCES `courier_package` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier_trackinghistory`
--

LOCK TABLES `courier_trackinghistory` WRITE;
/*!40000 ALTER TABLE `courier_trackinghistory` DISABLE KEYS */;
INSERT INTO `courier_trackinghistory` VALUES (1,'Booked','Origin City','2026-04-21 07:33:06.978816',1),(2,'Booked','Origin City','2026-04-21 07:36:08.681560',2),(3,'In Transit','Dhasarahalli','2026-04-21 07:38:12.425447',2),(4,'In Transit','Dhavanagere','2026-04-21 07:39:04.801629',1),(5,'Out for Delivery','Tumkur','2026-04-21 14:53:30.128082',1),(6,'Delivered','Tumkur','2026-04-21 14:57:29.982494',1),(7,'Booked','Origin City','2026-04-22 05:07:14.271923',3),(8,'In Transit','Mysore','2026-04-22 05:11:25.839302',3),(12,'Booked','Origin City','2026-04-22 08:09:12.893303',7),(13,'Booked','Origin City','2026-04-22 08:24:03.813346',8),(14,'Out for Delivery','Ramnagar','2026-04-22 15:05:28.276530',3),(15,'Booked','Origin City','2026-04-22 15:13:11.194531',9);
/*!40000 ALTER TABLE `courier_trackinghistory` ENABLE KEYS */;
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
