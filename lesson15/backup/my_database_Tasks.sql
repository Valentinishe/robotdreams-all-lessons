-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: my_database
-- ------------------------------------------------------
-- Server version	8.2.0

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

--
-- Table structure for table `Tasks`
--

DROP TABLE IF EXISTS `Tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `status` enum('TODO','IN PROGRESS','DONE') DEFAULT NULL,
  `dueAt` date DEFAULT NULL,
  `emploeeId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  KEY `emploeeId` (`emploeeId`),
  CONSTRAINT `Tasks_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`),
  CONSTRAINT `Tasks_ibfk_2` FOREIGN KEY (`emploeeId`) REFERENCES `Employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tasks`
--

LOCK TABLES `Tasks` WRITE;
/*!40000 ALTER TABLE `Tasks` DISABLE KEYS */;
INSERT INTO `Tasks` VALUES (1,1,'Money','No kino - no money','DONE','1993-07-17',3),(2,1,'Money','No kino - no money','DONE','1993-07-17',3),(3,2,'Find heroes','Really hard a task','TODO','2021-08-10',3),(4,1,'Money','No kino - no money','DONE','1993-07-17',3),(5,2,'Find heroes','Really hard a task','TODO','2021-08-10',3),(6,2,'Find scenarion','Really hard a task','TODO','2021-08-11',3),(7,1,'Money','No kino - no money','DONE','1993-07-17',3),(8,2,'Find heroes','Really hard a task','TODO','2021-08-10',3),(9,2,'Find scenarion','Really hard a task','TODO','2021-08-11',3),(10,2,'Buy buhlo','Really hard a task','DONE','2021-08-12',3),(11,2,'Buy cars for producers','Really hard a task','IN PROGRESS','2021-08-17',3),(12,2,'Corporative','Corporative','DONE','2022-02-17',4),(13,1,'Money','No kino - no money','DONE','1993-07-17',3),(14,1,'Script','Write script','DONE','1993-08-17',4),(15,1,'Sell','Sell film to cinema','DONE','1994-08-17',5),(16,2,'Find heroes','Really hard a task','TODO','2021-08-10',3),(17,2,'Find scenarion','Really hard a task','TODO','2021-08-11',3),(18,2,'Buy buhlo','Really hard a task','DONE','2021-08-12',3),(19,2,'Buy cars for producers','Really hard a task','IN PROGRESS','2021-08-17',3),(20,2,'Corporative','Corporative','DONE','2022-02-17',4),(21,1,'Money','No kino - no money','DONE','1993-07-17',3),(22,1,'Script','Write script','DONE','1993-08-17',4),(23,1,'Sell','Sell film to cinema','DONE','1994-08-17',5),(24,2,'Find heroes','Really hard a task','TODO','2021-08-10',3),(25,2,'Find scenarion','Really hard a task','TODO','2021-08-11',3),(26,2,'Buy buhlo','Really hard a task','DONE','2021-08-12',3),(27,2,'Buy cars for producers','Really hard a task','IN PROGRESS','2021-08-17',3),(28,2,'Corporative','Corporative','DONE','2022-02-17',4);
/*!40000 ALTER TABLE `Tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 15:47:41
