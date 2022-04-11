DROP DATABASE IF EXISTS world_temp_stats;	

-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: world_temp_stats
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `world_temp_stats`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `world_temp_stats` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `world_temp_stats`;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `continent`
--

DROP TABLE IF EXISTS `continent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(52) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id_country` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_continent` bigint(20) DEFAULT NULL,
  `Name` char(52) DEFAULT '',
  `Region` char(26) DEFAULT '',
  `SurfaceArea` float(10,2) DEFAULT 0.00,
  `IndepYear` smallint(6) DEFAULT NULL,
  `Population` int(11) DEFAULT 0,
  `LifeExpectancy` float(3,1) DEFAULT NULL,
  `GNP` float(10,2) DEFAULT NULL,
  `GNPOld` float(10,2) DEFAULT NULL,
  `LocalName` char(45) DEFAULT '',
  `GovernmentForm` char(45) DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_country`),
  KEY `id_continent` (`id_continent`),
  CONSTRAINT `country_ibfk_1` FOREIGN KEY (`id_continent`) REFERENCES `continent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_by_city`
--

DROP TABLE IF EXISTS `temp_by_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_by_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `AverageTemperature` decimal(5,3) DEFAULT NULL,
  `AverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `Latitude` varchar(10) DEFAULT NULL,
  `Longitude` varchar(10) DEFAULT NULL,
  `id_country` bigint(20) DEFAULT NULL,
  `id_city` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`),
  KEY `id_city` (`id_city`),
  CONSTRAINT `temp_by_city_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `country` (`id_country`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temp_by_city_ibfk_2` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_by_country`
--

DROP TABLE IF EXISTS `temp_by_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_by_country` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `AverageTemperature` decimal(5,3) DEFAULT NULL,
  `AverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `id_country` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`),
  CONSTRAINT `temp_by_country_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `country` (`id_country`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_by_major_city`
--

DROP TABLE IF EXISTS `temp_by_major_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_by_major_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `AverageTemperature` decimal(5,3) DEFAULT NULL,
  `AverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `Latitude` varchar(10) DEFAULT NULL,
  `Longitude` varchar(10) DEFAULT NULL,
  `id_country` bigint(20) DEFAULT NULL,
  `id_city` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`),
  KEY `id_city` (`id_city`),
  CONSTRAINT `temp_by_major_city_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `country` (`id_country`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temp_by_major_city_ibfk_2` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_by_state`
--

DROP TABLE IF EXISTS `temp_by_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_by_state` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `AverageTemperature` decimal(5,3) DEFAULT NULL,
  `AverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `id_country` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_country` (`id_country`),
  CONSTRAINT `temp_by_state_ibfk_1` FOREIGN KEY (`id_country`) REFERENCES `country` (`id_country`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_global`
--

DROP TABLE IF EXISTS `temp_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_global` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `LandAverageTemperature` decimal(5,3) DEFAULT NULL,
  `LandAverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `LandMaxTemperature` decimal(5,3) DEFAULT NULL,
  `LandMaxTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `LandMinTemperature` decimal(5,3) DEFAULT NULL,
  `LandMinTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  `LandAndOceanAverageTemperature` decimal(5,3) DEFAULT NULL,
  `LandAndOceanAverageTemperatureUncertainty` decimal(5,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-28 16:38:30

/*
show PROCESSLIST;

KILL 32;


use world_temp_stats;
SELECT COUNT(*)
FROM city;

select count(*)
from temp_by_city;

ANALYZE TABLE world_temp_stats.temp_by_city;
*/
