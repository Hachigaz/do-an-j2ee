CREATE DATABASE  IF NOT EXISTS `mxh_01` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mxh_01`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mxh_01
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `userID` varchar(16) NOT NULL,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('1','testacc1','test@gmail.com','123'),('2','testacc2','test@gmail.com','123'),('3','testacc3','test@gmail.com','123');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_details`
--

DROP TABLE IF EXISTS `account_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_details` (
  `userID` varchar(16) NOT NULL,
  `firstName` varchar(64) DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `avatarName` varchar(512) DEFAULT NULL,
  `background` varchar(512) DEFAULT NULL,
  `friendCount` int DEFAULT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `userID_ACCDE_ACC` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_details`
--

LOCK TABLES `account_details` WRITE;
/*!40000 ALTER TABLE `account_details` DISABLE KEYS */;
INSERT INTO `account_details` VALUES ('1','Jim','Danger','290 THD','1995-12-12','jim_avt.png','jim_bck.jfif',2),('2','Martin','Lunatic','639 BHN','1992-10-30','martin_avt.png','martin_bck.jpg',2),('3','Smith','Black','401 NVC','1998-01-20','smith_avt.png','smith_bck.jpg',2);
/*!40000 ALTER TABLE `account_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `chatID` int NOT NULL,
  `message_count` bigint DEFAULT NULL,
  PRIMARY KEY (`chatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (0,7),(1,7),(2,1);
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_users`
--

DROP TABLE IF EXISTS `chat_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_users` (
  `chatID` int NOT NULL,
  `userID` varchar(16) NOT NULL,
  PRIMARY KEY (`chatID`,`userID`),
  KEY `2_idx` (`userID`),
  CONSTRAINT `1` FOREIGN KEY (`chatID`) REFERENCES `chat` (`chatID`),
  CONSTRAINT `2` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_users`
--

LOCK TABLES `chat_users` WRITE;
/*!40000 ALTER TABLE `chat_users` DISABLE KEYS */;
INSERT INTO `chat_users` VALUES (0,'1'),(1,'1'),(0,'2'),(2,'2'),(1,'3'),(2,'3');
/*!40000 ALTER TABLE `chat_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `userID1` varchar(16) NOT NULL,
  `userID2` varchar(16) NOT NULL,
  `chatID` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`userID1`,`userID2`),
  KEY `friend_user2_idx` (`userID2`),
  KEY `132_idx` (`chatID`),
  CONSTRAINT `friend_user` FOREIGN KEY (`userID1`) REFERENCES `account` (`userID`),
  CONSTRAINT `friend_user2` FOREIGN KEY (`userID2`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES ('1','2',0,0),('1','3',1,0),('2','3',2,0);
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `chatID` int NOT NULL,
  `userID` varchar(16) NOT NULL,
  `chat_index` int NOT NULL,
  `message` varchar(8192) DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`chatID`,`chat_index`),
  KEY `1_idx` (`userID`),
  CONSTRAINT `1123` FOREIGN KEY (`chatID`) REFERENCES `chat` (`chatID`),
  CONSTRAINT `1324` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (0,'1',0,'abc','2023-10-15 14:30:00',0),(0,'1',1,'xin chào','2023-10-15 14:31:00',0),(0,'2',2,'100 ok','2023-10-17 14:10:11',0),(0,'1',5,'123','2023-10-20 09:54:31',0),(0,'1',6,'qwe','2023-10-24 12:56:32',0),(1,'3',0,'asd','2023-10-17 14:10:11',0),(1,'1',1,'yôi ko có tiền','2023-10-17 14:10:11',0),(1,'1',6,'123123','2023-10-20 09:54:40',0),(2,'3',0,'123','2023-10-17 14:10:11',0);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comment`
--

DROP TABLE IF EXISTS `post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment` (
  `postID` varchar(16) NOT NULL,
  `userID` varchar(16) NOT NULL,
  `comment` text,
  `date` datetime DEFAULT NULL,
  `like_count` int DEFAULT NULL,
  PRIMARY KEY (`postID`,`userID`),
  KEY `post_user_idx` (`userID`),
  CONSTRAINT `post_comment` FOREIGN KEY (`postID`) REFERENCES `user_post` (`postID`),
  CONSTRAINT `post_user` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment`
--

LOCK TABLES `post_comment` WRITE;
/*!40000 ALTER TABLE `post_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_image`
--

DROP TABLE IF EXISTS `post_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_image` (
  `postID` varchar(16) NOT NULL,
  `index` int NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`postID`,`index`),
  CONSTRAINT `post_image` FOREIGN KEY (`postID`) REFERENCES `user_post` (`postID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_like`
--

DROP TABLE IF EXISTS `post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_like` (
  `postID` varchar(16) NOT NULL,
  `userID` varchar(16) NOT NULL,
  PRIMARY KEY (`postID`,`userID`),
  KEY `1 2_idx` (`userID`),
  CONSTRAINT `1 1` FOREIGN KEY (`postID`) REFERENCES `user_post` (`postID`),
  CONSTRAINT `1 2` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_like`
--

LOCK TABLES `post_like` WRITE;
/*!40000 ALTER TABLE `post_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_post`
--

DROP TABLE IF EXISTS `user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_post` (
  `postID` varchar(16) NOT NULL,
  `userID` varchar(16) DEFAULT NULL,
  `description` text,
  `datePosted` datetime DEFAULT NULL,
  `like_count` int DEFAULT NULL,
  `comment_counts` int DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `acc-post_idx` (`userID`),
  CONSTRAINT `acc-post` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post`
--

LOCK TABLES `user_post` WRITE;
/*!40000 ALTER TABLE `user_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-24 13:15:36
