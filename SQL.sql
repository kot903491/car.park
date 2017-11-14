-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: car_park
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `carcas_type`
--

DROP TABLE IF EXISTS `carcas_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carcas_type` (
  `id_carc` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id_carc`),
  UNIQUE KEY `type_UNIQUE` (`id_carc`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carcas_type`
--

LOCK TABLES `carcas_type` WRITE;
/*!40000 ALTER TABLE `carcas_type` DISABLE KEYS */;
INSERT INTO `carcas_type` VALUES (1,'Полуприцеп'),(2,'1+1'),(3,'Грузовик');
/*!40000 ALTER TABLE `carcas_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specific_prim`
--

DROP TABLE IF EXISTS `specific_prim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specific_prim` (
  `id_truck` int(11) NOT NULL,
  `lenght` decimal(3,1) NOT NULL,
  `capacity` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_truck`),
  CONSTRAINT `fk_id_truck_prim` FOREIGN KEY (`id_truck`) REFERENCES `truck` (`id_truck`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specific_prim`
--

LOCK TABLES `specific_prim` WRITE;
/*!40000 ALTER TABLE `specific_prim` DISABLE KEYS */;
INSERT INTO `specific_prim` VALUES (1,10.0,15),(2,10.0,10),(3,16.0,130),(4,15.0,0),(5,10.0,80);
/*!40000 ALTER TABLE `specific_prim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specific_second`
--

DROP TABLE IF EXISTS `specific_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specific_second` (
  `id_truck` int(11) NOT NULL,
  `lenght` decimal(3,1) NOT NULL,
  `capacity` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_truck`),
  CONSTRAINT `fk_id_truck_second` FOREIGN KEY (`id_truck`) REFERENCES `truck` (`id_truck`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specific_second`
--

LOCK TABLES `specific_second` WRITE;
/*!40000 ALTER TABLE `specific_second` DISABLE KEYS */;
INSERT INTO `specific_second` VALUES (2,15.0,15);
/*!40000 ALTER TABLE `specific_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_type`
--

DROP TABLE IF EXISTS `transport_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_type` (
  `id_tr` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tr`),
  UNIQUE KEY `type_UNIQUE` (`id_tr`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_type`
--

LOCK TABLES `transport_type` WRITE;
/*!40000 ALTER TABLE `transport_type` DISABLE KEYS */;
INSERT INTO `transport_type` VALUES (1,'Тент'),(2,'Рефрижератор'),(3,'Изотерм'),(4,'Jumbo'),(5,'Автовоз'),(6,'Автоцистерна'),(7,'Зерновоз'),(8,'Контейнеровоз'),(9,'Лесовоз'),(10,'Открытая бортовая платформа'),(11,'Открытая платформа'),(12,'Платформа для негабаритных грузов'),(13,'Самосвал'),(14,'Прочее');
/*!40000 ALTER TABLE `transport_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `truck`
--

DROP TABLE IF EXISTS `truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck` (
  `id_truck` int(11) NOT NULL AUTO_INCREMENT,
  `id_truck_type` int(11) NOT NULL,
  `make` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `car_num` varchar(15) NOT NULL,
  `trailer_num` varchar(15) NOT NULL,
  `driver` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  PRIMARY KEY (`id_truck`),
  KEY `fk_truck_type_idx` (`id_truck_type`),
  CONSTRAINT `fk_truck_type` FOREIGN KEY (`id_truck_type`) REFERENCES `truck_type` (`id_truck_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `truck`
--

LOCK TABLES `truck` WRITE;
/*!40000 ALTER TABLE `truck` DISABLE KEYS */;
INSERT INTO `truck` VALUES (1,9,'камаз','547711','921','077','санек','твинс'),(2,2,'MERCEDES','BVC','707','124','дима','твинс'),(3,4,'VOLVO','ZXAS','125XA','XX147','Neo','Neo'),(4,8,'HONDA','14VBR','cx547rt','cv14ff04','Tim','Tim'),(5,14,'BUS','FGBTHJ','156df','fbfg45','vfrt','fgrt');
/*!40000 ALTER TABLE `truck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `truck_type`
--

DROP TABLE IF EXISTS `truck_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck_type` (
  `id_truck_type` int(11) NOT NULL,
  `id_tr` int(11) NOT NULL,
  `id_car` int(11) NOT NULL,
  PRIMARY KEY (`id_truck_type`,`id_tr`,`id_car`),
  KEY `fk_transport_id_idx` (`id_tr`),
  KEY `fk_carcas_id_idx` (`id_car`),
  CONSTRAINT `fk_carcas_id` FOREIGN KEY (`id_car`) REFERENCES `carcas_type` (`id_carc`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transport_id` FOREIGN KEY (`id_tr`) REFERENCES `transport_type` (`id_tr`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `truck_type`
--

LOCK TABLES `truck_type` WRITE;
/*!40000 ALTER TABLE `truck_type` DISABLE KEYS */;
INSERT INTO `truck_type` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,1),(5,3,1),(6,4,1),(7,4,2),(8,5,1),(9,6,1),(10,6,3),(11,7,1),(12,7,2),(13,7,3),(14,8,1),(15,9,1),(16,10,1),(17,11,1),(18,12,1),(19,13,2),(20,13,3),(21,14,1),(22,14,2),(23,14,3);
/*!40000 ALTER TABLE `truck_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_cars`
--

DROP TABLE IF EXISTS `user_cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_cars` (
  `id_user` int(11) NOT NULL,
  `id_truck` int(11) NOT NULL,
  UNIQUE KEY `id_truck_UNIQUE` (`id_truck`),
  KEY `fk_users_id_idx` (`id_user`),
  CONSTRAINT `fk_truck_id` FOREIGN KEY (`id_truck`) REFERENCES `truck` (`id_truck`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_id` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_cars`
--

LOCK TABLES `user_cars` WRITE;
/*!40000 ALTER TABLE `user_cars` DISABLE KEYS */;
INSERT INTO `user_cars` VALUES (1,1),(1,2),(2,3),(2,5),(3,4);
/*!40000 ALTER TABLE `user_cars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UNIQUE` (`id`,`user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Rustam'),(2,'Aleksey'),(3,'Timur');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-14 19:42:57
