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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('0','testacc0','test0@gmail.com','123'),('1','testacc1','test@gmail.com','123'),('10','testacc10','test10@gmail.com','123'),('11','testacc11','test11@gmail.com','123'),('12','testacc12','test12@gmail.com','123'),('13','testacc13','test13@gmail.com','123'),('14','testacc14','test14@gmail.com','123'),('15','testacc15','test15@gmail.com','123'),('16','testacc16','test16@gmail.com','123'),('17','testacc17','test17@gmail.com','123'),('18','testacc18','test18@gmail.com','123'),('19','testacc19','test19@gmail.com','123'),('2','testacc2','test@gmail.com','123'),('20','testacc20','test20@gmail.com','123'),('21','testacc21','test21@gmail.com','123'),('22','testacc22','test22@gmail.com','123'),('23','testacc23','test23@gmail.com','123'),('24','therock','rock.123@gmail.com','rock123'),('3','testacc3','test@gmail.com','123'),('4','testacc4','test4@gmail.com','123'),('5','testacc5','test5@gmail.com','123'),('6','testacc6','test6@gmail.com','123'),('7','testacc7','test7@gmail.com','123'),('8','testacc8','test8@gmail.com','123'),('9','testacc9','test9@gmail.com','123');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_details`
--

LOCK TABLES `account_details` WRITE;
/*!40000 ALTER TABLE `account_details` DISABLE KEYS */;
INSERT INTO `account_details` VALUES ('0','Michael','Brown','200 THG','1880-10-10','cat-d.png','rock-d.jfif',1),('1','Jim','Danger','290 THD','1995-12-12','jim_avt.png','jim_bck.jfif',10),('10','Grace','Anderson','555 Birch St','1991-06-18','grace_avatar.png','grace_bck.jpg',0),('11','Henry','Martinez','777 Redwood St','1986-07-12','henry_avatar.png','henry_bck.jpg',0),('12','Isabella','Taylor','888 Sequoia St','1989-09-05','isabella_avatar.png','isabella_bck.jpg',0),('13','Jack','Moore','999 Willow St','1994-04-08','jack_avatar.png','jack_bck.jpg',0),('14','Katherine','White','111 Cedar St','1984-11-28','katherine_avatar.png','katherine_bck.jpg',0),('15','Liam','Hall','222 Elm St','1993-07-30','liam_avatar.png','liam_bck.jpg',0),('16','Mia','Jackson','333 Pine St','1988-01-10','mia_avatar.png','mia_bck.jpg',0),('17','Noah','Miller','444 Oak St','1996-02-22','noah_avatar.png','noah_bck.jpg',0),('18','Olivia','Brown','666 Maple St','1982-04-15','olivia_avatar.png','olivia_bck.jpg',0),('19','Paul','Garcia','777 Redwood St','1997-09-02','paul_avatar.png','paul_bck.jpg',0),('2','Martin','Lunatic','639 BHN','1992-10-30','martin_avt.png','martin_bck.jpg',8),('20','Quinn','Harris','999 Sequoia St','1981-12-12','quinn_avatar.png','quinn_bck.jpg',0),('21','Ryan','Clark','123 Birch St','1998-08-18','ryan_avatar.png','ryan_bck.jpg',0),('22','Sophia','Turner','456 Willow St','1980-05-25','sophia_avatar.png','sophia_bck.jpg',0),('23','Tyler','Walker','789 Cedar St','1999-03-08','tyler_avatar.png','tyler_bck.jpg',0),('24','The','Rock Man','200 Bekela','1975-04-30','therock.png','therock.jpg',0),('3','Smith','Black','401 NVC','1998-01-20','smith_avt.png','smith_bck.jpg',8),('4','Alice','Johnson','123 Main St','1990-05-15','alice_avatar.png','alice_bck.jpg',4),('5','Bob','Smith','456 Elm St','1985-08-20','bob_avatar.png','bob_bck.jpg',3),('6','Charlie','Brown','789 Oak St','1992-02-10','charlie_avatar.png','charlie_bck.jpg',3),('7','David','Davis','101 Pine St','1987-10-05','david_avatar.png','david_bck.jpg',3),('8','Eva','Williams','246 Cedar St','1995-03-25','eva_avatar.png','eva_bck.jpg',3),('9','Frank','Wilson','369 Maple St','1983-12-30','frank_avatar.png','frank_bck.jpg',3);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (0,21),(1,2),(2,1),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_users`
--

LOCK TABLES `chat_users` WRITE;
/*!40000 ALTER TABLE `chat_users` DISABLE KEYS */;
INSERT INTO `chat_users` VALUES (6,'0'),(0,'1'),(1,'1'),(3,'1'),(4,'1'),(5,'1'),(6,'1'),(11,'1'),(12,'1'),(13,'1'),(14,'1'),(0,'2'),(2,'2'),(7,'2'),(8,'2'),(15,'2'),(16,'2'),(17,'2'),(18,'2'),(1,'3'),(2,'3'),(9,'3'),(10,'3'),(19,'3'),(20,'3'),(21,'3'),(22,'3'),(3,'4'),(4,'4'),(7,'4'),(9,'4'),(5,'5'),(8,'5'),(10,'5'),(11,'6'),(15,'6'),(19,'6'),(12,'7'),(16,'7'),(20,'7'),(13,'8'),(17,'8'),(21,'8'),(14,'9'),(18,'9'),(22,'9');
/*!40000 ALTER TABLE `chat_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_like` (
  `postID` varchar(16) NOT NULL,
  `commentID` int NOT NULL,
  `userID` varchar(16) NOT NULL,
  PRIMARY KEY (`postID`,`commentID`,`userID`),
  KEY `account_comment_like_idx` (`userID`) /*!80000 INVISIBLE */,
  KEY `post_comment_like` (`commentID`,`postID`),
  CONSTRAINT `account_comment_like` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`),
  CONSTRAINT `post_comment_like` FOREIGN KEY (`postID`, `commentID`) REFERENCES `post_comment` (`postID`, `commentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES ('1',0,'1');
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES ('1','2',0,0),('1','3',1,0),('1','4',4,0),('1','5',5,0),('1','6',11,0),('1','7',12,0),('1','8',13,0),('1','9',14,0),('2','3',2,0),('2','4',7,0),('2','5',8,0),('2','6',15,0),('2','7',16,0),('2','8',17,0),('2','9',18,0),('3','4',9,0),('3','5',10,0),('3','6',19,0),('3','7',20,0),('3','8',21,0),('3','9',22,0);
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_request`
--

DROP TABLE IF EXISTS `friend_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_request` (
  `sendUserID` varchar(16) NOT NULL,
  `receiveUserID` varchar(16) NOT NULL,
  PRIMARY KEY (`sendUserID`,`receiveUserID`),
  KEY `receiveidaccount_idx` (`receiveUserID`),
  CONSTRAINT `receiveidaccount` FOREIGN KEY (`receiveUserID`) REFERENCES `account` (`userID`),
  CONSTRAINT `sendidaccount` FOREIGN KEY (`sendUserID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_request`
--

LOCK TABLES `friend_request` WRITE;
/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_request` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (0,'1',0,'abc','2023-10-15 14:30:00',0),(0,'1',1,'xin chào','2023-10-15 14:31:00',0),(0,'2',2,'100 ok','2023-10-17 14:10:11',0),(0,'1',3,'123','2023-11-01 23:14:19',0),(0,'2',4,'123','2023-11-01 23:15:32',0),(0,'1',5,'ok','2023-11-01 23:18:08',0),(0,'2',6,'ok ko','2023-11-01 23:18:30',0),(0,'2',7,'ok','2023-11-01 23:18:42',0),(0,'2',8,'ok','2023-11-01 23:19:44',0),(0,'2',9,'đẹp','2023-11-01 23:19:52',0),(0,'1',10,'đẹp z','2023-11-01 23:20:44',0),(0,'2',11,'đu đủ','2023-11-01 23:20:53',0),(0,'2',12,'what','2023-11-02 16:52:30',0),(0,'2',13,'ok','2023-11-02 16:53:51',0),(0,'2',14,'ok','2023-11-02 16:55:58',0),(0,'1',15,'helo','2023-11-02 16:56:05',0),(0,'1',16,'asd','2023-11-13 07:54:09',0),(0,'1',17,'asd','2023-11-13 07:54:14',0),(0,'1',18,'qwre','2023-11-13 07:54:19',0),(0,'1',19,'asdasdsaodkasodkasokdoaksdkaokdaoskdoaskdoaskdoaskdokasodkasodkaso','2023-11-13 07:55:46',0),(0,'2',20,'Xin chao','2023-11-15 17:11:14',0),(1,'3',0,'asd','2023-10-17 14:10:11',0),(1,'1',1,'yôi ko có tiền','2023-10-17 14:10:11',0),(2,'3',0,'123','2023-10-17 14:10:11',0);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `message_AFTER_INSERT` AFTER INSERT ON `message` FOR EACH ROW BEGIN
	update chat set message_count = message_count + 1 where chatID = new.chatID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `message_AFTER_DELETE` AFTER DELETE ON `message` FOR EACH ROW BEGIN
	update chat set message_count = message_count - 1 where chatID = old.chatID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `post_comment`
--

DROP TABLE IF EXISTS `post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment` (
  `postID` varchar(16) NOT NULL,
  `commentID` int NOT NULL,
  `userID` varchar(16) DEFAULT NULL,
  `comment` text,
  `date` datetime DEFAULT NULL,
  `like_count` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`postID`,`commentID`),
  CONSTRAINT `post_comment` FOREIGN KEY (`postID`) REFERENCES `user_post` (`postID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment`
--

LOCK TABLES `post_comment` WRITE;
/*!40000 ALTER TABLE `post_comment` DISABLE KEYS */;
INSERT INTO `post_comment` VALUES ('0',0,'1','Hàng này còn giá không?','2023-11-14 20:19:13',0,0),('1',0,'1','Bạn thật xinh đẹp','2023-11-07 15:24:07',0,0),('1',1,'1','Cái này mua ở đâu vậy','2023-11-14 23:42:23',0,0),('1',2,'1','Bãi biển thật mộng mơ','2023-11-14 23:43:31',0,0),('1',3,'1','Mặt trời đẹp quá','2023-11-14 23:43:53',0,0),('2',0,'1','Thật là tuyệt vời!','2023-11-14 20:16:01',0,0),('2',1,'1','Màu gì đẹp thế','2023-11-14 23:15:47',0,0),('2',2,'1','Nói hay lắm','2023-11-14 23:46:50',0,0),('2',3,'1','Chúc bạn may mắn','2023-11-14 23:49:24',0,0),('2',4,'1','Thật ý nghĩa','2023-11-15 00:01:47',0,0),('2',5,'2','Thật là dễ thương','2023-11-15 00:04:24',0,0),('2',6,'2','Lần tới nhớ rủ tôi nhé!','2023-11-15 00:04:41',0,0),('2',7,'3','Sao mà mắc cười quá','2023-11-15 00:05:26',0,0),('2',8,'3','Bạn thật là có khiếu hài hước!','2023-11-15 00:05:40',0,0),('2',9,'3','Tôi rất ấn tượng','2023-11-15 00:05:52',0,0),('2',10,'3','Bạn cố lên nhé!','2023-11-15 00:07:06',0,0),('2',11,'1','Thật là hay!','2023-11-15 09:48:57',0,0),('4',0,'3','Bạn thật xinh đẹp!','2023-11-16 11:15:48',0,0);
/*!40000 ALTER TABLE `post_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `post_comment_AFTER_INSERT` AFTER INSERT ON `post_comment` FOR EACH ROW BEGIN
	update user_post set comment_count = comment_count+1 where new.postID = postID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `post_comment_AFTER_DELETE` AFTER DELETE ON `post_comment` FOR EACH ROW BEGIN
	update user_post set comment_count = comment_count-1 where old.postID = postID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
INSERT INTO `post_image` VALUES ('0',0,'my-tree.jpg'),('0',1,'blue-beach.jfif'),('0',2,'camelia.jpg'),('0',3,'vgarden.jpg'),('1',0,'beach-hotel.jpg');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_like`
--

LOCK TABLES `post_like` WRITE;
/*!40000 ALTER TABLE `post_like` DISABLE KEYS */;
INSERT INTO `post_like` VALUES ('0','1'),('1','1'),('2','1'),('3','1'),('4','1'),('5','1'),('4','3'),('5','3');
/*!40000 ALTER TABLE `post_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `post_like_AFTER_INSERT` AFTER INSERT ON `post_like` FOR EACH ROW BEGIN
	update user_post set like_count = like_count + 1 where postID = new.postID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `post_like_AFTER_DELETE` AFTER DELETE ON `post_like` FOR EACH ROW BEGIN
	update user_post set like_count = like_count - 1 where postID = old.postID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `comment_count` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `acc-post_idx` (`userID`),
  CONSTRAINT `acc-post` FOREIGN KEY (`userID`) REFERENCES `account` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post`
--

LOCK TABLES `user_post` WRITE;
/*!40000 ALTER TABLE `user_post` DISABLE KEYS */;
INSERT INTO `user_post` VALUES ('0','1','Dưới nắng rọi, hoa nở rộ đầy sân,\nGió nhẹ lay, cây lá xanh tươi thắm.\nTrong tĩnh lặng, lòng hòa mình với thiên nhiên,\nNhững đam mê, hạnh phúc như đang vẽ nên.\n\nSông rì rào, tiếng chim hát ca vui,\nTrải qua ngày, tâm hồn thêm sáng ngời.\nThế giới này, tuy nhỏ bé trong tay,\nNhưng nắng vàng, luôn ấm lòng mỗi ngày.','2023-11-07 14:45:51',1,1,0),('1','2','\nDưới bầu trời xanh vờn mây trắng\nLời thơ rơi nhẹ như hạt sương\nNgọn gió nhẹ, lá cây xanh tươi\nCảm xúc tràn đầy, lòng không buồn\n\nSông rì rào, tiếng sóng reo vui\nDưới bóng cây, tình yêu đẹp như tranh\nCuộc đời ngắn, hãy sống trọn vẹn\nBài thơ này, trái tim chúng ta tặng.','2023-11-07 14:47:42',1,4,0),('2','2','\"Chia sẻ với mọi người một ngày đẹp trời hôm nay! ? Thời tiết tại đây rất tốt, và tôi đang cảm thấy tràn đầy năng lượng. ? Cuối tuần này, tôi đã lên kế hoạch tham gia một cuộc dã ngoại với bạn bè, và tôi không thể đợi để thư giãn và tận hưởng thiên nhiên.\n\nNgoài ra, tôi đã bắt đầu đọc một cuốn sách tuyệt vời mới và tôi muốn chia sẻ nó với bạn. ? Cuốn này thật sự sâu sắc và thú vị!\n\nHy vọng mọi người cũng có một ngày tuyệt vời và chia sẻ những khoảnh khắc tươi đẹp trong cuộc sống của bạn. ❤️ #HạnhPhúc #CuộcSống #ThưGiãn #ĐọcSách\"','2023-11-07 14:48:17',1,12,0),('3','1','Ngày trôi qua như những đám mây trên bầu trời, không ngừng chuyển động và biến hóa. Nhìn lại, tôi nhận ra rằng mỗi cơn mưa, mỗi ánh nắng mặt trời, đều góp phần làm nên vẻ đẹp riêng biệt của cuộc sống. Đôi khi, đơn giản là cần một trái tim mở rộng và một tâm trạng lạc quan để thấy rõ những điều tuyệt vời xung quanh.','2010-05-01 12:10:10',1,0,0),('4','4','Cuộc sống như một cuộc phiêu lưu, và mỗi một chặng đường đều đầy ắp những câu chuyện đáng nhớ. Đôi khi, ta có thể bị lạc lõng giữa những lựa chọn và quyết định, nhưng đó chính là lúc ta phải tin rằng mỗi bước đi đều đưa ta đến nơi ta muốn đến. Hãy dừng lại, nhìn về quá khứ với lòng biết ơn và hãy hướng về tương lai với lòng tin tưởng.','2010-05-01 12:10:10',2,1,0),('5','4','Khi đêm buông xuống, ta nhìn lên bầu trời đầy sao và tự hỏi về ý nghĩa của cuộc sống. Mỗi ngôi sao đều là ước mơ, là khát khao, là một phần của chúng ta. Đôi khi, cuộc sống trở nên hỗn loạn, nhưng trong những khoảnh khắc yên bình, chúng ta có cơ hội nhìn thấy những điều quan trọng nhất trong cuộc sống.','2010-05-01 12:10:10',2,0,0);
/*!40000 ALTER TABLE `user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mxh_01'
--

--
-- Dumping routines for database 'mxh_01'
--
/*!50003 DROP PROCEDURE IF EXISTS `addComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addComment`(cPostID varchar(16),cUserID varchar(16),cText text,cDate datetime)
BEGIN
	declare newCommentID int;
    select count(commentID) into newCommentID from post_comment where postID = cPostID;
	insert into post_comment values(cPostID,newCommentID,cUserID,cText,cDate,0,false);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addFriend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addFriend`(newUserID1 varchar(16),newUserID2 varchar(16))
BEGIN
	IF (EXISTS(SELECT * FROM friend WHERE 
			friend.deleted = 1 AND
			((friend.userID1 = newUserID1 AND friend.userID2 = newUserID2 ) 
			OR (friend.userID1 = newUserID2 AND friend.userID2 = newUserID1))
		))
	THEN
    BEGIN
		UPDATE friend SET deleted = 0 WHERE 
			(friend.userID1 = newUserID1 AND friend.userID2 = newUserID2 ) 
			OR (friend.userID1 = newUserID2 AND friend.userID2 = newUserID1);
		update account_details set friendCount = friendCount + 1 where userID = newUserID1 or userID = newUserID2;
    END;
    ELSE IF (not EXISTS(SELECT * FROM friend WHERE 
			friend.deleted = 0 AND
			((friend.userID1 = newUserID1 AND friend.userID2 = newUserID2 ) 
			OR (friend.userID1 = newUserID2 AND friend.userID2 = newUserID1))
	))
    THEN
    BEGIN
		DECLARE vChatID int;
		SELECT 
		COUNT(chatID)
	INTO vChatID FROM
		chat;

		INSERT INTO friend(userID1,userID2,chatID,deleted) values(newUserID1,newUserID2,vChatID,0);
		INSERT INTO chat values(vChatID,0);
		INSERT INTO chat_users values(vChatID,newUserID1),(vChatID,newUserID2);
		update account_details set friendCount = friendCount + 1 where userID = newUserID1 or userID = newUserID2;
	END;
    END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addPostImage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addPostImage`(pPostID varchar(16), pImagePath varchar(256))
BEGIN
	declare newImageIndex int;
    select count(post_image.index) into newImageIndex from post_image where postID = pPostID;
    insert into post_image values(pPostID,newImageIndex,pImagePath);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPost`(pUserID varchar(16),pDescription text,pDatePosted datetime)
BEGIN
	declare newPostID int;
    select count(postID) into newPostID from user_post;
	insert into user_post values(newPostID,pUserID,pDescription,pDatePosted,0,0,false);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser`(
	username varchar(64),email varchar(128), 
    userPass varchar(64),firstName varchar(64),
    lastName varchar(64),address varchar(256),
    birthDate date, avatarName varchar(512),
    background varchar(512))
BEGIN
	declare userID varchar(16);
    select count(*)+1 into userID from account;
    insert into account values (userID,username,email,userPass);
    insert into account_details values (userID,firstName,lastName,address,birthDate,avatarName,background,0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMessage`(dChatID int,dIdx int)
BEGIN
	update message set deleted = 1 where chatID = dChatID AND chat_index = dIdx;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMutualCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMutualCount`(fUserID1 varchar(16), fUserID2 varchar(16))
BEGIN
	select count(f1.userID1) from friend f1 join friend f2 on 
		(f1.userID1 = f2.userID1 AND ((f1.userID2 = fUserID1 AND f2.userID2 = fUserID2) OR (f1.userID2 = fUserID2 AND f2.userID2 = fUserID1)))  or 
		(f1.userID2 = f2.userID2 AND ((f1.userID1 = fUserID1 AND f2.userID1 = fUserID2) OR (f1.userID1 = fUserID2 AND f2.userID1 = fUserID1)))  or 
		(f1.userID1 = f2.userID2 AND ((f1.userID1 = fUserID1 AND f2.userID2 = fUserID2) OR (f1.userID1 = fUserID2 AND f2.userID2 = fUserID1)))  or 
		(f1.userID2 = f2.userID1 AND ((f1.userID2 = fUserID1 AND f2.userID1 = fUserID2) OR (f1.userID2 = fUserID2 AND f2.userID1 = fUserID1)));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMutualFriends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMutualFriends`(fUserID1 varchar(16), fUserID2 varchar(16))
BEGIN
	select * from friend f1 join friend f2 on 
		(f1.userID1 = f2.userID1 AND ((f1.userID2 = fUserID1 AND f2.userID2 = fUserID2) OR (f1.userID2 = fUserID2 AND f2.userID2 = fUserID1)))  or 
		(f1.userID2 = f2.userID2 AND ((f1.userID1 = fUserID1 AND f2.userID1 = fUserID2) OR (f1.userID1 = fUserID2 AND f2.userID1 = fUserID1)))  or 
		(f1.userID1 = f2.userID2 AND ((f1.userID1 = fUserID1 AND f2.userID2 = fUserID2) OR (f1.userID1 = fUserID2 AND f2.userID2 = fUserID1)))  or 
		(f1.userID2 = f2.userID1 AND ((f1.userID2 = fUserID1 AND f2.userID1 = fUserID2) OR (f1.userID2 = fUserID2 AND f2.userID1 = fUserID1)));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processFriendRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `processFriendRequest`(sendUserID varchar(16),receiveUserID varchar(16))
BEGIN
	if(not exists(select * from friend where 
					friend.deleted = 0 AND (
					(friend.userID1 = sendUserID AND friend.userID2 = receiveUserID) OR 
                    (friend.userID1 = receiveUserID AND friend.userID2 = sendUserID)
	)))
    then begin
		declare rowSendID varchar(16);
		declare rowReceiveID varchar(16);
        set @rowSendID = null, @rowReceiveID = null;
        select friend_request.sendUserID, friend_request.receiveUserID INTO @rowSendID, @rowReceiveID  from friend_request where 
					(friend_request.sendUserID = sendUserID AND friend_request.receiveUserID = receiveUserID) OR 
                    (friend_request.sendUserID = receiveUserID AND friend_request.receiveUserID = sendUserID);
        if((@rowSendID is null) and (@rowReceiveID is null))
		then begin
			insert into friend_request values(sendUserID,receiveUserID);
        end;
        else begin
			if(@rowReceiveID = sendUserID)
            then begin
				call addFriend(sendUserID,receiveUserID);
                delete from friend_request where friend_request.sendUserID = receiveUserID and friend_request.receiveUserID = sendUserID;
            end;
            else if (@rowReceiveID = receiveUserID)
            then begin
				delete from friend_request where friend_request.sendUserID = sendUserID and friend_request.receiveUserID = receiveUserID;
            end;
            else begin
				signal sqlstate '45000'
				set message_text = 'Cannot send request: Friend request have already existed';
            end;
            end if;
            end if;
            end;
        end if;
    end;
    else begin
		signal sqlstate '45000'
        set message_text = 'Cannot send request: User friend have already existed';
    end;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processLikeComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `processLikeComment`(lPostID varchar(16), lCommentID int, lUserID varchar(16))
BEGIN
	if(exists(select * from comment_like where postID = lPostID and commentID = lCommentID and userID = lUserID))
    then begin
		delete from comment_like where postID = lPostID and commentID = lCommentID and userID = lUserID;
    end;
    else begin
		insert into comment_like values(lPostID,lCommentID,lUserID);
    end; 
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processLikePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `processLikePost`(lPostID varchar(16), lUserID varchar(16))
BEGIN
	if(not exists(select * from post_like where postID = lPostID and userID = lUserID))
    then begin
		insert into post_like values(lPostID,lUserID);
    end;
    else begin
		delete from post_like where postID = lPostID and userID = lUserID;
    end;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_like_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_like_post`(lPostID varchar(16), lUserID varchar(16))
BEGIN
	if(not exists(select * from post_like where postID = lPostID and userID=lUserID))
    then begin
		insert into post_like values(lPostID,lUserID);
    end;
    else begin
		delete from post_like where postID = lPostID and userID = lUserID;
    end;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeFriend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `removeFriend`(remUserID1 varchar(16),remUserID2 varchar(16))
BEGIN
	if (exists (select * from friend where deleted = 0 and ((remUserID1 = friend.userID1 AND remUserID2 = friend.userID2)
		OR (remUserID1 = friend.userID2 AND remUserID2 = friend.userID1))))
	then begin
	declare vChatID int;
    select friend.chatID into vChatID FROM friend WHERE (remUserID1 = friend.userID1 AND remUserID2 = friend.userID2) OR (remUserID1 = friend.userID2 AND remUserID2 = friend.userID1);
	DELETE FROM message where message.chatID = vChatID;
	DELETE FROM chat_users 
WHERE
    chat_users.chatID = vChatID;
    
    DELETE FROM chat 
WHERE
    (vChatID = chat.chatID);
	DELETE FROM friend 
WHERE
    (remUserID1 = friend.userID1
    AND remUserID2 = friend.userID2)
    OR (remUserID1 = friend.userID2
    AND remUserID2 = friend.userID1);
	update account_details set friendCount = friendCount - 1 where userID = remUserID1 or userID = remUserID2;
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sendMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sendMessage`(sChatID int,sUserID varchar(16), sMessage varchar(8192),sDateSent datetime)
BEGIN
	declare msgIdx int;
    select message_count into msgIdx from chat where chatID = sChatID;
	insert into message values(sChatID,sUserID,msgIdx,sMessage,sDateSent,0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sRemoveFriend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sRemoveFriend`(remUserID1 varchar(16),remUserID2 varchar(16))
BEGIN
	if (exists (select * from friend where deleted = 0 and ((remUserID1 = friend.userID1 AND remUserID2 = friend.userID2)
		OR (remUserID1 = friend.userID2 AND remUserID2 = friend.userID1))))
	then begin
	update friend set deleted = 1 where (remUserID1 = friend.userID1 AND remUserID2 = friend.userID2) OR (remUserID1 = friend.userID2 AND remUserID2 = friend.userID1);
	update account_details set friendCount = friendCount - 1 where userID = remUserID1 or userID = remUserID2;
end;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 14:53:17
