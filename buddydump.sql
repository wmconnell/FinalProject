-- MySQL dump 10.13  Distrib 5.7.34, for osx11.0 (x86_64)
--
-- Host: localhost    Database: squadgoalsdb
-- ------------------------------------------------------
-- Server version	5.7.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `badge`
--

DROP TABLE IF EXISTS `badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(499) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge`
--

LOCK TABLES `badge` WRITE;
/*!40000 ALTER TABLE `badge` DISABLE KEYS */;
INSERT INTO `badge` VALUES (1,'Super Squad','Any squad that reaches 100 pts receives the Super Squad badge!',NULL),(2,'Mother Teresa','Any squad that achieves 3 charitable goals within 1 year receives the Mother Teresa badge!',NULL),(3,'Huge Member','Any member who reaches 100 pts receive the Huge Member badge!',NULL),(4,'Buddy It Up','Any squad that reaches max capacity receives the Buddy It Up badge!',0);
/*!40000 ALTER TABLE `badge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge_has_squad`
--

DROP TABLE IF EXISTS `badge_has_squad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badge_has_squad` (
  `badge_id` int(11) NOT NULL,
  `squad_id` int(11) NOT NULL,
  `achieved_date` datetime DEFAULT NULL,
  PRIMARY KEY (`badge_id`,`squad_id`),
  KEY `fk_badge_has_squad_squad1_idx` (`squad_id`),
  KEY `fk_badge_has_squad_badge1_idx` (`badge_id`),
  CONSTRAINT `fk_badge_has_squad_badge1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_badge_has_squad_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_has_squad`
--

LOCK TABLES `badge_has_squad` WRITE;
/*!40000 ALTER TABLE `badge_has_squad` DISABLE KEYS */;
INSERT INTO `badge_has_squad` VALUES (1,1,NULL);
/*!40000 ALTER TABLE `badge_has_squad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge_has_user`
--

DROP TABLE IF EXISTS `badge_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badge_has_user` (
  `badge_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `achieved_date` datetime DEFAULT NULL,
  PRIMARY KEY (`badge_id`,`user_id`),
  KEY `fk_badge_has_user_user1_idx` (`user_id`),
  KEY `fk_badge_has_user_badge1_idx` (`badge_id`),
  CONSTRAINT `fk_badge_has_user_badge1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_badge_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_has_user`
--

LOCK TABLES `badge_has_user` WRITE;
/*!40000 ALTER TABLE `badge_has_user` DISABLE KEYS */;
INSERT INTO `badge_has_user` VALUES (3,1,NULL);
/*!40000 ALTER TABLE `badge_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge_requirement`
--

DROP TABLE IF EXISTS `badge_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badge_requirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badge_id` int(11) NOT NULL,
  `rule` varchar(45) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_condition_badge1_idx` (`badge_id`),
  CONSTRAINT `fk_condition_badge1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_requirement`
--

LOCK TABLES `badge_requirement` WRITE;
/*!40000 ALTER TABLE `badge_requirement` DISABLE KEYS */;
INSERT INTO `badge_requirement` VALUES (1,1,NULL,NULL);
/*!40000 ALTER TABLE `badge_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goal`
--

DROP TABLE IF EXISTS `goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(99) DEFAULT NULL,
  `description` text,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `completed` tinyint(4) DEFAULT NULL,
  `public_visibility` tinyint(4) DEFAULT NULL,
  `public_attendance` tinyint(4) DEFAULT NULL,
  `recurring` varchar(45) DEFAULT NULL,
  `creator_id` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goal_user1_idx` (`creator_id`),
  CONSTRAINT `fk_goal_user1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goal`
--

LOCK TABLES `goal` WRITE;
/*!40000 ALTER TABLE `goal` DISABLE KEYS */;
INSERT INTO `goal` VALUES (1,'Pizza party','Some wholesome, after-school fun!','2022-09-20 19:54:01','2022-09-20 19:54:01',NULL,'2022-09-23 19:30:00','2022-09-23 21:00:00',0,1,1,NULL,1,1),(2,'Join Squad Goals','The first step',NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,1,1),(3,'Mooch off Anna','She deserve it','2022-09-24 14:23:32','2022-09-24 14:23:32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(4,'TEST REVIEW',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL),(5,'Flapdfasdfdsafd lijlijloijold toenail dust 2','Ferlsadfasdfimshus','2022-09-26 16:54:30','2022-09-26 16:54:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(6,'eat','food','2022-09-26 16:56:13','2022-09-26 16:56:13',NULL,NULL,NULL,0,0,0,'',1,1),(7,'eat','food again','2022-09-26 16:57:54','2022-09-26 16:57:54',NULL,NULL,NULL,0,0,0,'',1,1),(8,'holy','sheeeet','2022-09-26 20:15:52','2022-09-26 20:15:52',NULL,NULL,NULL,0,0,0,'',1,1),(9,'inron','it o;itu','2022-09-26 21:02:37','2022-09-26 21:02:37',NULL,NULL,NULL,0,0,0,'',1,1),(10,'llll','oooollll','2022-09-26 21:45:52','2022-09-26 21:45:52',NULL,NULL,NULL,0,0,0,'',1,1),(11,'which way','will i go','2022-09-26 22:03:26','2022-09-26 22:03:26',NULL,NULL,NULL,0,0,0,'',1,1),(12,'adad','goal','2022-09-26 22:04:09','2022-09-26 22:04:09',NULL,NULL,NULL,0,0,0,'',1,1),(13,'ggguuuhh','huhhhh','2022-09-26 22:09:20','2022-09-26 22:09:20',NULL,NULL,NULL,0,0,0,'',1,1);
/*!40000 ALTER TABLE `goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(499) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg',NULL),(2,'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',NULL),(3,'https://static.wikia.nocookie.net/snl/images/6/66/Wild_and_crazy_guys.jpg/revision/latest?cb=20140804162910',NULL),(4,'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',1),(5,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(6,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(7,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(8,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(9,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(10,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(11,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(12,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(13,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(14,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(15,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(16,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(17,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(18,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(19,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(20,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(21,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(22,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(23,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(24,'https://images.unsplash.com/photo-1516222338250-863216ce01ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',1),(25,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(26,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(27,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(28,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(29,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1),(30,'https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg',1);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_has_goal`
--

DROP TABLE IF EXISTS `image_has_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_has_goal` (
  `image_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  PRIMARY KEY (`image_id`,`goal_id`),
  KEY `fk_image_has_goal_goal1_idx` (`goal_id`),
  KEY `fk_image_has_goal_image1_idx` (`image_id`),
  CONSTRAINT `fk_image_has_goal_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_has_goal_image1` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_has_goal`
--

LOCK TABLES `image_has_goal` WRITE;
/*!40000 ALTER TABLE `image_has_goal` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_has_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_has_review`
--

DROP TABLE IF EXISTS `image_has_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_has_review` (
  `image_id` int(11) NOT NULL,
  `review_goal_id` int(11) NOT NULL,
  `review_user_id` int(11) NOT NULL,
  PRIMARY KEY (`image_id`,`review_goal_id`,`review_user_id`),
  KEY `fk_image_has_review_review1_idx` (`review_goal_id`,`review_user_id`),
  KEY `fk_image_has_review_image1_idx` (`image_id`),
  CONSTRAINT `fk_image_has_review_image1` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_has_review_review1` FOREIGN KEY (`review_goal_id`, `review_user_id`) REFERENCES `review` (`goal_id`, `user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_has_review`
--

LOCK TABLES `image_has_review` WRITE;
/*!40000 ALTER TABLE `image_has_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_has_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `rating` int(11) DEFAULT NULL,
  `comment` text,
  `goal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `review_date` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`goal_id`,`user_id`),
  KEY `fk_review_goal1_idx` (`goal_id`),
  KEY `fk_review_user1_idx` (`user_id`),
  CONSTRAINT `fk_review_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (3,'Woweeeee!',1,1,NULL,1),(3,'Woweeeee!',4,3,NULL,1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad`
--

DROP TABLE IF EXISTS `squad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `bio` text,
  `active` tinyint(4) DEFAULT NULL,
  `leader_id` int(11) NOT NULL,
  `profile_image_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_squad_user1_idx` (`leader_id`),
  KEY `fk_squad_image1_idx` (`profile_image_id`),
  CONSTRAINT `fk_squad_image1` FOREIGN KEY (`profile_image_id`) REFERENCES `image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_user1` FOREIGN KEY (`leader_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad`
--

LOCK TABLES `squad` WRITE;
/*!40000 ALTER TABLE `squad` DISABLE KEYS */;
INSERT INTO `squad` VALUES (1,'The OGs','We\'re just two wild and crazy guys!',1,1,3,NULL),(2,'buddy squad','We are all buddies!',NULL,1,10,NULL),(3,'buddy squad 2',NULL,NULL,1,11,NULL),(4,'buddy squad 3','I hate nothing',NULL,1,12,NULL),(5,'buddy squad xxx',NULL,NULL,1,13,NULL),(6,'squad squad',NULL,NULL,1,14,NULL),(8,'squad squad squad xxxxxx',NULL,NULL,1,16,NULL),(9,'squad squad squad xxopopoppoxxxx',NULL,NULL,1,17,NULL),(10,'eskimo pod',NULL,NULL,1,18,NULL),(11,'eskimo pod in hell',NULL,NULL,1,19,NULL),(12,'eskimo pod in hell 2',NULL,NULL,1,20,NULL),(13,'eskimo pod in hell 3',NULL,0,1,21,NULL),(14,'eskimo pod in hell 5','We are not buddies!',0,1,23,NULL),(15,'best squad',NULL,NULL,1,26,NULL),(19,'test 5','We are totally buddies!',1,1,30,NULL);
/*!40000 ALTER TABLE `squad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad_has_goal`
--

DROP TABLE IF EXISTS `squad_has_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squad_has_goal` (
  `squad_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  PRIMARY KEY (`squad_id`,`goal_id`),
  KEY `fk_squad_has_goal_goal1_idx` (`goal_id`),
  KEY `fk_squad_has_goal_squad1_idx` (`squad_id`),
  CONSTRAINT `fk_squad_has_goal_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_goal_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad_has_goal`
--

LOCK TABLES `squad_has_goal` WRITE;
/*!40000 ALTER TABLE `squad_has_goal` DISABLE KEYS */;
INSERT INTO `squad_has_goal` VALUES (1,1),(2,4),(1,5),(1,9),(1,10),(1,11),(1,12),(1,13);
/*!40000 ALTER TABLE `squad_has_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad_has_tag`
--

DROP TABLE IF EXISTS `squad_has_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squad_has_tag` (
  `squad_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`squad_id`,`tag_id`),
  KEY `fk_squad_has_tags_tags1_idx` (`tag_id`),
  KEY `fk_squad_has_tags_squad1_idx` (`squad_id`),
  CONSTRAINT `fk_squad_has_tags_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_tags_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad_has_tag`
--

LOCK TABLES `squad_has_tag` WRITE;
/*!40000 ALTER TABLE `squad_has_tag` DISABLE KEYS */;
INSERT INTO `squad_has_tag` VALUES (1,1),(1,2),(1,3);
/*!40000 ALTER TABLE `squad_has_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad_has_task`
--

DROP TABLE IF EXISTS `squad_has_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squad_has_task` (
  `squad_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `points` int(11) DEFAULT NULL,
  PRIMARY KEY (`squad_id`,`task_id`),
  KEY `fk_squad_has_task_task1_idx` (`task_id`),
  KEY `fk_squad_has_task_squad1_idx` (`squad_id`),
  CONSTRAINT `fk_squad_has_task_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_has_task_task1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad_has_task`
--

LOCK TABLES `squad_has_task` WRITE;
/*!40000 ALTER TABLE `squad_has_task` DISABLE KEYS */;
INSERT INTO `squad_has_task` VALUES (1,1,NULL),(1,2,NULL);
/*!40000 ALTER TABLE `squad_has_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad_message`
--

DROP TABLE IF EXISTS `squad_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squad_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_date` datetime DEFAULT NULL,
  `content` text,
  `sender_id` int(11) NOT NULL,
  `squad_id` int(11) NOT NULL,
  `reply_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_squad_message_user1_idx` (`sender_id`),
  KEY `fk_squad_message_squad1_idx` (`squad_id`),
  KEY `fk_squad_message_squad_message1_idx` (`reply_to_id`),
  CONSTRAINT `fk_squad_message_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_message_squad_message1` FOREIGN KEY (`reply_to_id`) REFERENCES `squad_message` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squad_message_user1` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad_message`
--

LOCK TABLES `squad_message` WRITE;
/*!40000 ALTER TABLE `squad_message` DISABLE KEYS */;
INSERT INTO `squad_message` VALUES (1,'0001-02-12 00:00:00','u up?',1,1,NULL),(2,'0001-03-13 00:00:00','yeet',2,1,1);
/*!40000 ALTER TABLE `squad_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'fitness',NULL,NULL),(2,'volunteer',NULL,NULL),(3,'party',NULL,NULL),(4,'music','related to music in one way or another',0),(5,'food','FOOD',NULL);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_has_goal`
--

DROP TABLE IF EXISTS `tag_has_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_has_goal` (
  `tag_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`,`goal_id`),
  KEY `fk_tags_has_goal_goal1_idx` (`goal_id`),
  KEY `fk_tags_has_goal_tags1_idx` (`tag_id`),
  CONSTRAINT `fk_tags_has_goal_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_goal_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_has_goal`
--

LOCK TABLES `tag_has_goal` WRITE;
/*!40000 ALTER TABLE `tag_has_goal` DISABLE KEYS */;
INSERT INTO `tag_has_goal` VALUES (3,1);
/*!40000 ALTER TABLE `tag_has_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `description` text,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `completed` tinyint(4) DEFAULT NULL,
  `goal_id` int(11) NOT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_goal1_idx` (`goal_id`),
  CONSTRAINT `fk_task_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Buy the pizza','Chicago style, please',NULL,NULL,NULL,NULL,NULL,0,1,NULL),(2,'Get the Mountain Dew','Code Red is best, just sayin\'',NULL,NULL,NULL,NULL,NULL,0,1,NULL),(3,'Sign up for Squad Goals','Just do it!',NULL,NULL,NULL,NULL,NULL,1,2,NULL);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_task`
--

DROP TABLE IF EXISTS `task_has_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_task` (
  `task_id` int(11) NOT NULL,
  `precursor_task_id` int(11) NOT NULL,
  PRIMARY KEY (`task_id`,`precursor_task_id`),
  KEY `fk_task_has_task_task2_idx` (`precursor_task_id`),
  KEY `fk_task_has_task_task1_idx` (`task_id`),
  CONSTRAINT `fk_task_has_task_task1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_has_task_task2` FOREIGN KEY (`precursor_task_id`) REFERENCES `task` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_task`
--

LOCK TABLES `task_has_task` WRITE;
/*!40000 ALTER TABLE `task_has_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_has_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(99) DEFAULT NULL,
  `last_name` varchar(99) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `bio` text,
  `active` tinyint(4) DEFAULT NULL,
  `profile_image_id` int(11) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_user_image1_idx` (`profile_image_id`),
  CONSTRAINT `fk_user_image1` FOREIGN KEY (`profile_image_id`) REFERENCES `image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'originaltom','$2a$10$jv.tFTSYGqiSllEewaLR7.RTV7hWqmrY/HB2q44B62Y.MaYtDHU0S','tom@myspace.com','Tom','MySpace','admin','Hi, I\'m Tom, and I\'m friends with everyone!',1,1,NULL),(2,'godzilla','$2a$10$jv.tFTSYGqiSllEewaLR7.RTV7hWqmrY/HB2q44B62Y.MaYtDHU0S','godzilla@monster.rawr','Go','Shira','member','Hi, name\'s Godzilla. Love smashing cities and chasing damsels up skyscrapers. Oh, is that my cousin, King Kong? Oops.',1,2,NULL),(3,'buddy3','$2a$10$jv.tFTSYGqiSllEewaLR7.RTV7hWqmrY/HB2q44B62Y.MaYtDHU0S','buddy23@buddy.buddy',NULL,NULL,'member',NULL,1,4,NULL),(4,'buddyman','$2a$10$dRcCGlRjMHBI9jjt1bq2peOJAmxCPBJdBAgZ6YcXetF6Z2bQo0qe2','buddyman@buddy.man','Buddy','Mann','member','',1,25,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_goal`
--

DROP TABLE IF EXISTS `user_has_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_goal` (
  `user_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`goal_id`),
  KEY `fk_user_has_goal_goal1_idx` (`goal_id`),
  KEY `fk_user_has_goal_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_goal_goal1` FOREIGN KEY (`goal_id`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_goal_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_goal`
--

LOCK TABLES `user_has_goal` WRITE;
/*!40000 ALTER TABLE `user_has_goal` DISABLE KEYS */;
INSERT INTO `user_has_goal` VALUES (1,1),(1,2),(1,6);
/*!40000 ALTER TABLE `user_has_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_squad`
--

DROP TABLE IF EXISTS `user_has_squad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_squad` (
  `user_id` int(11) NOT NULL,
  `squad_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`squad_id`),
  KEY `fk_user_has_squad_squad1_idx` (`squad_id`),
  KEY `fk_user_has_squad_user_idx` (`user_id`),
  CONSTRAINT `fk_user_has_squad_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_squad_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_squad`
--

LOCK TABLES `user_has_squad` WRITE;
/*!40000 ALTER TABLE `user_has_squad` DISABLE KEYS */;
INSERT INTO `user_has_squad` VALUES (1,1),(2,1),(1,2),(3,2),(3,14),(3,15),(3,19);
/*!40000 ALTER TABLE `user_has_squad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_tag`
--

DROP TABLE IF EXISTS `user_has_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_tag` (
  `user_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `fk_user_has_tags_tags1_idx` (`tag_id`),
  KEY `fk_user_has_tags_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_tags_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_tags_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_tag`
--

LOCK TABLES `user_has_tag` WRITE;
/*!40000 ALTER TABLE `user_has_tag` DISABLE KEYS */;
INSERT INTO `user_has_tag` VALUES (1,1);
/*!40000 ALTER TABLE `user_has_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_task`
--

DROP TABLE IF EXISTS `user_has_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_task` (
  `user_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`task_id`),
  KEY `fk_user_has_task_task1_idx` (`task_id`),
  KEY `fk_user_has_task_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_task_task1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_task_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_task`
--

LOCK TABLES `user_has_task` WRITE;
/*!40000 ALTER TABLE `user_has_task` DISABLE KEYS */;
INSERT INTO `user_has_task` VALUES (1,1),(2,2),(1,3);
/*!40000 ALTER TABLE `user_has_task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-27  0:17:45
