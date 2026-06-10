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
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-04-21 05:18:19.717656'),(2,'auth','0001_initial','2026-04-21 05:18:20.487958'),(3,'admin','0001_initial','2026-04-21 05:18:20.656688'),(4,'admin','0002_logentry_remove_auto_add','2026-04-21 05:18:20.669133'),(5,'admin','0003_logentry_add_action_flag_choices','2026-04-21 05:18:20.682098'),(6,'contenttypes','0002_remove_content_type_name','2026-04-21 05:18:20.829588'),(7,'auth','0002_alter_permission_name_max_length','2026-04-21 05:18:20.907158'),(8,'auth','0003_alter_user_email_max_length','2026-04-21 05:18:20.937400'),(9,'auth','0004_alter_user_username_opts','2026-04-21 05:18:20.947980'),(10,'auth','0005_alter_user_last_login_null','2026-04-21 05:18:21.024657'),(11,'auth','0006_require_contenttypes_0002','2026-04-21 05:18:21.028034'),(12,'auth','0007_alter_validators_add_error_messages','2026-04-21 05:18:21.036128'),(13,'auth','0008_alter_user_username_max_length','2026-04-21 05:18:21.102423'),(14,'auth','0009_alter_user_last_name_max_length','2026-04-21 05:18:21.190971'),(15,'auth','0010_alter_group_name_max_length','2026-04-21 05:18:21.218270'),(16,'auth','0011_update_proxy_permissions','2026-04-21 05:18:21.232901'),(17,'auth','0012_alter_user_first_name_max_length','2026-04-21 05:18:21.330058'),(18,'courier','0001_initial','2026-04-21 05:18:21.896293'),(19,'courier','0002_remove_staff_profile_image_alter_staff_city_and_more','2026-04-21 05:18:22.311108'),(20,'courier','0003_feedback_feedback_type_feedback_screenshot_and_more','2026-04-21 05:18:22.597912'),(21,'courier','0004_remove_feedback_feedback_type_and_more','2026-04-21 05:18:22.771249'),(22,'courier','0005_staff_address_staff_profile_image_alter_staff_city_and_more','2026-04-21 05:18:23.090830'),(23,'courier','0006_staff_email_alter_staff_phone_and_more','2026-04-21 05:18:23.296207'),(24,'courier','0007_message','2026-04-21 05:18:23.447969'),(25,'courier','0008_remove_message_is_read','2026-04-21 05:18:23.506441'),(26,'courier','0009_message_is_read','2026-04-21 05:18:23.608577'),(27,'sessions','0001_initial','2026-04-21 05:18:23.662696'),(28,'courier','0010_package_amount_package_payment_date_and_more','2026-04-22 07:14:20.303585');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
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
