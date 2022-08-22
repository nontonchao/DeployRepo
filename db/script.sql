-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: oasip
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `oasip`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `oasip` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `oasip`;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `bookingName` varchar(100) NOT NULL,
  `bookingEmail` varchar(255) NOT NULL,
  `eventStartTime` timestamp NOT NULL,
  `eventDuration` int NOT NULL,
  `eventNotes` varchar(500) DEFAULT NULL,
  `eventCategory` int NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `fk_event_event_category_idx` (`eventCategory`),
  CONSTRAINT `fk_event_event_category` FOREIGN KEY (`eventCategory`) REFERENCES `event_category` (`eventCategory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Somchai Jaidee (OR-7)','somchai.jai@mail.kmutt.ac.th','2022-05-23 06:30:00',30,'',2),(2,'Somsri Rakdee (SJ-3)','somsri.rak@mail.kmutt.ac.th','2022-04-27 06:30:00',30,'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน',1),(3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 09:30:00',15,'',3);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_category`
--

DROP TABLE IF EXISTS `event_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_category` (
  `eventCategory_id` int NOT NULL,
  `eventCategoryName` varchar(45) NOT NULL,
  `eventCategoryDescription` varchar(500) DEFAULT NULL,
  `eventDuration` int NOT NULL,
  PRIMARY KEY (`eventCategory_id`),
  UNIQUE KEY `eventCategoryName` (`eventCategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_category`
--

LOCK TABLES `event_category` WRITE;
/*!40000 ALTER TABLE `event_category` DISABLE KEYS */;
INSERT INTO `event_category` VALUES (1,'Project Management Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคำปรึกษา',30),(2,'DevOps/Infra Clinic','Use this event category for DevOps/Infra clinic.',20),(3,'Database Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย database clinic ใน วิชา INT221 integrated project I',15),(4,'Client-side Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย client-side clinic ใน วิชา INT221 integrated project I',30),(5,'Server-side Clinic','',30);
/*!40000 ALTER TABLE `event_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` enum('admin','lecturer','student') NOT NULL,
  `onCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `onUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'Chokjaroen','2asd@gmail.com','student','2022-08-16 12:42:19','2022-08-16 14:32:04'),(8,'Nitipoom','ebxz@gmail.com','admin','2022-08-16 12:52:20','2022-08-16 16:09:58'),(9,'testja','dqwd@kmutt.ac.th','student','2022-08-16 13:33:47','2022-08-16 13:33:47'),(22,'Nyz','dddw@gmail.com','admin','2022-08-16 14:51:57','2022-08-16 14:51:57'),(23,'Amorn','ZAZAZA@gmail.com','admin','2022-08-16 14:55:31','2022-08-16 14:55:31'),(24,'AmornXJ','ZAZAZAX@gmail.com','admin','2022-08-16 15:19:14','2022-08-16 15:19:14'),(28,'Nyzdw','ddddw@gmail.com','admin','2022-08-16 15:57:29','2022-08-16 15:57:29'),(29,'Nyzdwe','dddddw@gmail.com','admin','2022-08-16 15:57:58','2022-08-16 15:57:58'),(30,'Nyzcccdwe','g@cg.com','admin','2022-08-16 16:13:03','2022-08-16 16:14:43');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
CREATE USER 'dev'@'%' IDENTIFIED WITH mysql_native_password BY '0000';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%';
flush PRIVILEGES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-16 23:24:37
