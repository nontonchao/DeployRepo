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

DROP DATABASE IF EXISTS `oasip`;
CREATE DATABASE `oasip`;
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
  `attachment` varchar(500) DEFAULT NULL,
  `eventCategory` int NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `fk_event_event_category_idx` (`eventCategory`),
  CONSTRAINT `fk_event_event_category` FOREIGN KEY (`eventCategory`) REFERENCES `event_category` (`eventCategory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Somchai Jaidee (OR-7)','somchai.jai@mail.kmutt.ac.th','2022-05-23 06:30:00',30,'',null,2),
(2,'Somsri Rakdee (SJ-3)','somsri.rak@mail.kmutt.ac.th','2022-04-27 06:30:00',30,'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน',null,1),
(3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 09:30:00',15,'',null,3);
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
  `eventCategoryStatus` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`eventCategory_id`),
  UNIQUE KEY `eventCategoryName` (`eventCategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_category`
--

LOCK TABLES `event_category` WRITE;
/*!40000 ALTER TABLE `event_category` DISABLE KEYS */;
INSERT INTO `event_category` VALUES (1,'Project Management Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคำปรึกษา',30,0),(2,'DevOps/Infra Clinic','Use this event category for DevOps/Infra clinic.',20,0),(3,'Database Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย database clinic ใน วิชา INT221 integrated project I',15,1),(4,'Client-side Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย client-side clinic ใน วิชา INT221 integrated project IX',30,1),(5,'Server-side Clinic','',30,1);
/*!40000 ALTER TABLE `event_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_category_owner`
--

DROP TABLE IF EXISTS `event_category_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_category_owner` (
  `eventCategoryOwnerId` int NOT NULL AUTO_INCREMENT,
  `eventCategory_Id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`eventCategoryOwnerId`),
  KEY `category_idx` (`eventCategory_Id`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `category` FOREIGN KEY (`eventCategory_Id`) REFERENCES `event_category` (`eventCategory_id`),
  CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_category_owner`
--

LOCK TABLES `event_category_owner` WRITE;
/*!40000 ALTER TABLE `event_category_owner` DISABLE KEYS */;
INSERT INTO `event_category_owner` VALUES (1,1,2),(2,2,2),(3,3,6),(4,4,4),(5,5,2),(6,2,5),(7,5,3);
/*!40000 ALTER TABLE `event_category_owner` ENABLE KEYS */;
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
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'OASIP ADMIN','oasip.admin@kmutt.ac.th','admin','2022-08-01 00:00:00+07:00','2022-08-01 00:00:00+07:00','$argon2id$v=19$m=4096,t=3,p=1$sYXzbUOqBoHY1NfhJ8cjnw$H6+adWySiFPgcUogJK3hEhcF6Y4fusy7tcXYEL+f0cQ'),
(7,'Somchai Jaidee','somchai.jai@kmutt.ac.th','lecturer','2022-08-08 16:00:00+07:00','2022-08-08 16:00:00+07:00','$argon2id$v=19$m=4096,t=3,p=1$dmsOy7LPTjmooPu+P2oTZA$NZFTFd3f0K1Sp19aaUwyn3jgiy15yFcXhp8E4/1yXoI'),
(8,'Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','student','2022-08-08 16:00:00+07:00','2022-08-08 16:00:00+07:00','$argon2id$v=19$m=4096,t=3,p=1$i6znt0o+PWIbqyanPKpkLg$yLVOclVOV+z4RrMsnpyp87KUS/tZPid8KNNne8DARKI'),
(9,'สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','student','2022-08-16 09:00:00+07:00','2022-08-16 09:00:00+07:00','$argon2id$v=19$m=4096,t=3,p=1$gBqgjspF45FcIKQEw8GmaQ$alrOCZ0YrDqOu8/aZiLDMGZo4vFkSEAXA0YoHhY0BDQ'),
(2,'Olarn Rojanapornpun','olarn.roj@kmutt.ac.th','lecturer','2022-08-08 15:00:00+07:00','2022-08-08 15:00:00+07:00','$argon2id$v=19$m=4096,t=3,p=1$Sx7y2jxKZSjpWUV4srd8eg$AMH09iFiPQgAZ00cAdN3Gucqfhx2kRo3tQbHeLSR0RE'),
(3,'Pichet Limvachiranan','pichet.limv@kmutt.ac.th','lecturer','2022-08-08 15:00:01+07:00','2022-08-08 15:00:01+07:00','$argon2id$v=19$m=4096,t=3,p=1$46EB43gQ46Z1/EmdqxtKNA$7m6cWGO2iDlFl/ETDYuYf+ArnSjRnsNwXLIP18DTYQY'),
(4,'Umaporn Supasitthimethee','umaporn.sup@kmutt.ac.th','lecturer','2022-08-08 15:00:02+07:00','2022-08-08 15:00:02+07:00','$argon2id$v=19$m=4096,t=3,p=1$1Z2UK1zC76FIQeLH54GVAQ$qfXcHF31LnuWpt37QAcWyNp8PdbOQ+jjaV1xWXixS0M'),
(5,'Siam Yamsaengsung','siam.yam@kmutt.ac.th','lecturer','2022-08-08 15:00:03+07:00','2022-08-08 15:00:03+07:00','$argon2id$v=19$m=4096,t=3,p=1$C4pPaNWKTnZQX2mPs14jlg$rQ5W5NYKqGOu1B4GkUWq8cFbcg2peFWGjpUMr9Nkm8g'),
(6,'Sunisa Sathapornvajan','sunisa.sat@kmutt.ac.th','lecturer','2022-08-08 15:00:04+07:00','2022-08-08 15:00:04+07:00','$argon2id$v=19$m=4096,t=3,p=1$i6znt0o+PWIbqyanPKpkLg$yLVOclVOV+z4RrMsnpyp87KUS/tZPid8KNNne8DARKI');
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

-- Dump completed on 2022-10-08 21:48:53
