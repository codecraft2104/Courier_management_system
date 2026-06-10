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
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$zMzsOrXECl3NGFfj5i52xf$7vK0QVhApgABGIN1eIiA+9rtB96ELiI4OY6o6O8droo=','2026-04-22 15:17:28.956725',1,'admin','','','admin@gmail.com',1,1,'2026-04-21 05:20:23.478603'),(2,'pbkdf2_sha256$1200000$AAolcLXZ6sWI4ylbWul0TX$xr+wMRVuyhUlyD4C6cttZuQ6r/M89UrD2BdUNNj9MFU=','2026-04-21 05:22:22.525697',0,'Usha','','','usha@gmail.com',0,1,'2026-04-21 05:21:58.981848'),(4,'pbkdf2_sha256$1200000$wlglHLvotaKfJhkJ0Z0yVr$C9xj9wqErS6bWNoro2/qo+GjZAPo55E72XKqjsviPpM=','2026-04-22 15:04:43.250200',0,'Lokesh','','','',0,1,'2026-04-21 07:04:30.724364'),(5,'pbkdf2_sha256$1200000$pvQQqzhtnI9i57wv8L6Hok$IUuClI4SiJphnmwfGBM0OLDwP5OkxjvqPAo8GWNO2xo=','2026-04-21 14:57:18.068602',0,'Bharath','','','',0,1,'2026-04-21 07:09:46.102488'),(6,'pbkdf2_sha256$1200000$dnH7tCyjtkA0CTOsFyXo4d$KXsOIbihim1AtLLiSEp1xia9B0pNxfnG5NZyFBITbQM=',NULL,0,'Deepak','','','',0,1,'2026-04-21 07:10:40.283313'),(7,'pbkdf2_sha256$1200000$F0Pw05yqJlrJJWTm7uu8A0$hWx05gkuFz9kOePqhtko3SiRm/UpQtl61Yh+XLR+vRM=','2026-04-21 07:37:27.199658',0,'Kumar','','','',0,1,'2026-04-21 07:11:49.567577'),(8,'pbkdf2_sha256$1200000$6c6bfKmNaoYjiN9HyYW3zm$u9X6JC5yurKAMQ63vU95lqOLXKntiDKrr0OZdXLMpFU=','2026-04-21 14:51:26.523413',0,'Pallavi','','','pallavi@gmail.com',0,1,'2026-04-21 07:29:07.799406'),(9,'pbkdf2_sha256$1200000$3Vqigi5wFIlX0BkC9l70wE$BSVQrIcrgyhlTBMvD5bIWuukxR7NETofQVtfPQRbHww=','2026-04-22 15:06:04.249736',0,'manushree','','','manushree@gmail.com',0,1,'2026-04-21 07:30:23.865420'),(10,'pbkdf2_sha256$1200000$83y72RFsW8xfPABipLxoTk$Yyj8P6mrCsxxNM9SfDcWacxXbwDNvytThhCqZO39/GU=',NULL,0,'Jeevan','','','jeevan@gmail.com',0,1,'2026-04-21 07:31:13.617390'),(11,'pbkdf2_sha256$1200000$Un2A5wvFJrHbzAGRhlwPo3$sk9NzlxrHmZFQYSQobNnS5HuLdI3jHkMrzSaI4b2jLE=','2026-04-22 15:12:24.197197',0,'Sharath','','','sharath@gmail.com',0,1,'2026-04-22 03:57:56.302239'),(12,'pbkdf2_sha256$1200000$voeDoHhHoGkA8t3MTPyHcx$YnPwlMGcat3Z3hne71x9vDvQ5QFrUwod55DoK4rDebk=','2026-04-22 15:03:19.009591',0,'Pavan','','','',0,1,'2026-04-22 15:01:32.599092'),(13,'pbkdf2_sha256$1200000$VnN3sANiMZ8YmIq3HFhNAN$XjwySrjPDjpqaVwvRTIi41fKJ+QSt9WM8xSlmbBqo7M=','2026-04-22 15:11:11.136499',1,'parimala','','','parimala@gmail.com',1,1,'2026-04-22 15:10:28.847544');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
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

-- Dump completed on 2026-04-22 20:49:52
