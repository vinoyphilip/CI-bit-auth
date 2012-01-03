-- MySQL dump 10.13  Distrib 5.1.37, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: codeigniter_plugins
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5

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
-- Table structure for table `bitauth_assoc`
--

DROP TABLE IF EXISTS `bitauth_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_assoc` (
  `assoc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`assoc_id`),
  KEY `user_id` (`user_id`,`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_assoc`
--

LOCK TABLES `bitauth_assoc` WRITE;
/*!40000 ALTER TABLE `bitauth_assoc` DISABLE KEYS */;
INSERT INTO `bitauth_assoc` VALUES (1,1,1),(2,2,2),(8,2,5),(3,3,2),(7,3,4),(4,4,2),(9,4,5),(11,5,3);
/*!40000 ALTER TABLE `bitauth_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_groups`
--

DROP TABLE IF EXISTS `bitauth_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(48) NOT NULL,
  `description` text NOT NULL,
  `roles` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_groups`
--

LOCK TABLES `bitauth_groups` WRITE;
/*!40000 ALTER TABLE `bitauth_groups` DISABLE KEYS */;
INSERT INTO `bitauth_groups` VALUES (1,'Administrators','Administrators (Full Access)',1),(2,'Users','Default User Group',0),(3,'America','This is the americans group',0),(4,'Australia','This is the Australians group',0),(5,'Kuwaiti','This is Kuwaitis group',0);
/*!40000 ALTER TABLE `bitauth_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_logins`
--

DROP TABLE IF EXISTS `bitauth_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_logins` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `time` datetime NOT NULL,
  `success` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_logins`
--

LOCK TABLES `bitauth_logins` WRITE;
/*!40000 ALTER TABLE `bitauth_logins` DISABLE KEYS */;
INSERT INTO `bitauth_logins` VALUES (1,2130706689,1,'2011-09-07 12:04:07',1),(2,2130706689,2,'2011-09-07 12:05:17',1),(3,2130706689,1,'2011-09-07 12:05:30',1),(4,2130706689,5,'2011-09-07 12:10:27',0),(5,2130706689,5,'2011-09-07 12:10:37',1),(6,2130706689,1,'2011-09-07 12:57:11',1),(7,2130706689,1,'2011-09-07 15:19:09',1),(8,2130706689,1,'2011-09-07 16:57:41',0),(9,2130706689,1,'2011-09-07 17:04:35',1),(10,2130706689,4,'2011-09-07 17:06:40',1),(11,2130706689,1,'2011-09-07 17:29:22',1),(12,2130706689,5,'2011-09-07 17:55:29',0),(13,2130706689,5,'2011-09-07 17:55:41',0),(14,2130706689,1,'2011-09-07 17:55:55',1),(15,2130706689,5,'2011-09-07 17:57:47',1),(16,2130706689,1,'2011-09-07 17:58:18',1),(17,2130706689,5,'2011-09-07 17:59:14',1),(18,2130706689,1,'2011-09-07 18:06:45',1);
/*!40000 ALTER TABLE `bitauth_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_perm_group_assoc`
--

DROP TABLE IF EXISTS `bitauth_perm_group_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_perm_group_assoc` (
  `assoc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`assoc_id`),
  KEY `group_id` (`group_id`,`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_perm_group_assoc`
--

LOCK TABLES `bitauth_perm_group_assoc` WRITE;
/*!40000 ALTER TABLE `bitauth_perm_group_assoc` DISABLE KEYS */;
INSERT INTO `bitauth_perm_group_assoc` VALUES (31,1,1),(29,1,2),(19,1,3),(28,1,4),(32,2,1),(30,2,2),(33,3,1);
/*!40000 ALTER TABLE `bitauth_perm_group_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_permissions`
--

DROP TABLE IF EXISTS `bitauth_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_permissions` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `permission_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `key` (`permission_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_permissions`
--

LOCK TABLES `bitauth_permissions` WRITE;
/*!40000 ALTER TABLE `bitauth_permissions` DISABLE KEYS */;
INSERT INTO `bitauth_permissions` VALUES (1,'group can read','READ'),(2,'group can write','WRITE'),(3,'group can delete','DELETE'),(4,'group read all permission','READALL');
/*!40000 ALTER TABLE `bitauth_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_userdata`
--

DROP TABLE IF EXISTS `bitauth_userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_userdata` (
  `userdata_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `fullname` varchar(40) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`userdata_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_userdata`
--

LOCK TABLES `bitauth_userdata` WRITE;
/*!40000 ALTER TABLE `bitauth_userdata` DISABLE KEYS */;
INSERT INTO `bitauth_userdata` VALUES (1,1,'Administrator','admin@admin.com'),(2,2,'Vinoy  Philip','vinoyhere@gmail.com'),(3,3,'Vijoy','vijoym@gmail.com'),(4,4,'Sanoj Mathew','sano@gmail.com'),(5,5,'Visan Koshy','visan@gmail.com');
/*!40000 ALTER TABLE `bitauth_userdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitauth_users`
--

DROP TABLE IF EXISTS `bitauth_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitauth_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(60) NOT NULL,
  `password_last_set` datetime NOT NULL,
  `password_never_expires` tinyint(1) NOT NULL DEFAULT '0',
  `remember_me` varchar(40) NOT NULL,
  `activation_code` varchar(40) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `forgot_code` varchar(40) NOT NULL,
  `forgot_generated` datetime NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `last_login` datetime NOT NULL,
  `last_login_ip` int(10) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitauth_users`
--

LOCK TABLES `bitauth_users` WRITE;
/*!40000 ALTER TABLE `bitauth_users` DISABLE KEYS */;
INSERT INTO `bitauth_users` VALUES (1,'admin','$P$BJjJARXjlv9.tWfUg63IZFEVDTFzl.0','2011-09-07 12:03:07',0,'','',1,'','0000-00-00 00:00:00',1,'2011-09-07 18:06:45',2130706689),(2,'vinoy','$P$BJjJARXjlv9.tWfUg63IZFEVDTFzl.0','2011-09-07 12:04:59',0,'','',1,'','0000-00-00 00:00:00',1,'2011-09-07 12:05:17',2130706689),(3,'vijoy','$P$BJjJARXjlv9.tWfUg63IZFEVDTFzl.0','2011-09-07 12:06:27',0,'','',1,'','0000-00-00 00:00:00',1,'0000-00-00 00:00:00',0),(4,'sanoj','$P$BJjJARXjlv9.tWfUg63IZFEVDTFzl.0','2011-09-07 12:07:03',0,'','',1,'','0000-00-00 00:00:00',1,'2011-09-07 17:06:40',2130706689),(5,'visan','$P$BJjJARXjlv9.tWfUg63IZFEVDTFzl.0','2011-09-07 17:56:55',0,'','',1,'','0000-00-00 00:00:00',1,'2011-09-07 17:59:14',2130706689);
/*!40000 ALTER TABLE `bitauth_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-07 18:08:19
