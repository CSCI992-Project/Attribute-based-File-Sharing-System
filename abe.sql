/*
SQLyog v10.2 
MySQL - 8.0.21 : Database - abe
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`abe` /*!40100 DEFAULT CHARACTER SET gbk */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `abe`;

/*Table structure for table `attribute` */

DROP TABLE IF EXISTS `attribute`;

CREATE TABLE `attribute` (
  `attribute_id` int NOT NULL,
  `category_id` int NOT NULL,
  `attribute_name` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `idattribute_UNIQUE` (`attribute_id`),
  KEY `att_idx` (`category_id`),
  CONSTRAINT `att` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `attribute` */

insert  into `attribute`(`attribute_id`,`category_id`,`attribute_name`) values (0,2,'isit'),(1,1,'csci'),(2,2,'925'),(3,1,'uow');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `category_name` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values (0,'please select'),(1,'student'),(2,'teacher');

/*Table structure for table `file_att` */

DROP TABLE IF EXISTS `file_att`;

CREATE TABLE `file_att` (
  `file_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `file_att` */

insert  into `file_att`(`file_id`,`category_id`,`attribute_id`) values (1,1,3),(2,1,1),(6,2,2),(7,1,3),(8,2,2),(9,2,2),(10,2,2),(11,2,2),(12,2,2),(13,2,0),(14,2,2);

/*Table structure for table `file_info` */

DROP TABLE IF EXISTS `file_info`;

CREATE TABLE `file_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_title` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `file_describe` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `file_path` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idfile_UNIQUE` (`id`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `uploader` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=gbk;

/*Data for the table `file_info` */

insert  into `file_info`(`id`,`file_title`,`file_describe`,`user_id`,`file_path`) values (1,'Test','Test file',1,'112'),(2,'Test2','Test file',2,'22'),(13,'TEst444','444',1,'Test file.txt'),(14,'Final','test',1,'Test file.txt');

/*Table structure for table `functions` */

DROP TABLE IF EXISTS `functions`;

CREATE TABLE `functions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `parentid` int DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `isleaf` bit(1) DEFAULT NULL,
  `nodeorder` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=gbk;

/*Data for the table `functions` */

insert  into `functions`(`id`,`name`,`parentid`,`url`,`isleaf`,`nodeorder`) values (1,'Platform',0,NULL,'\0',0),(2,'File Management',1,NULL,'\0',1),(3,'All Files',2,NULL,'',1),(4,'File Upload',2,NULL,'',2),(5,'My Files',2,NULL,'',2),(6,'User Management',1,NULL,'\0',1),(7,'User List',6,NULL,'',1),(8,'Log out',1,NULL,'',1);

/*Table structure for table `powers` */

DROP TABLE IF EXISTS `powers`;

CREATE TABLE `powers` (
  `uid` int NOT NULL,
  `fid` int NOT NULL,
  PRIMARY KEY (`uid`,`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `powers` */

insert  into `powers`(`uid`,`fid`) values (1,3),(1,5),(1,7),(1,8),(2,3),(2,5),(2,8),(32,3),(32,5),(32,8),(33,3),(33,5),(33,8),(34,3),(34,5),(34,8),(35,3),(35,5),(35,8),(36,3),(36,5),(36,8),(37,3),(37,5),(37,8),(38,3),(38,5),(38,8),(39,3),(39,5),(39,8),(40,3),(40,5),(40,8),(41,3),(41,5),(41,8),(42,3),(42,5),(42,8),(43,3),(43,5),(43,8),(45,3),(45,5),(45,8),(46,3),(46,5),(46,8),(47,3),(47,5),(47,8),(48,3),(48,5),(48,8),(49,3),(49,5),(49,8),(50,3),(50,5),(50,8),(51,3),(51,5),(51,8),(52,3),(52,5),(52,8),(53,3),(53,5),(53,8),(54,3),(54,5),(54,8),(55,3),(55,5),(55,8),(56,3),(56,5),(56,8),(57,3),(57,5),(57,8),(58,3),(58,5),(58,8),(59,3),(59,5),(59,8),(62,3),(62,5),(62,8),(63,3),(63,5),(63,8),(64,3),(64,5),(64,8),(65,3),(65,5),(65,8),(66,3),(66,5),(66,8),(67,3),(67,5),(67,8),(68,3),(68,5),(68,8),(69,3),(69,5),(69,8),(70,3),(70,5),(70,8),(71,3),(71,5),(71,8),(72,3),(72,5),(72,8);

/*Table structure for table `user_att` */

DROP TABLE IF EXISTS `user_att`;

CREATE TABLE `user_att` (
  `user_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `user_att` */

insert  into `user_att`(`user_id`,`category_id`,`attribute_id`) values (1,1,1),(2,2,2),(34,1,1),(35,NULL,NULL),(36,NULL,NULL),(37,NULL,NULL),(39,1,1),(40,1,3),(41,1,3),(42,1,3),(43,1,3),(45,1,1),(46,1,1),(47,2,2),(48,2,2),(49,2,2),(50,2,2),(51,2,0),(52,2,2),(53,2,2),(54,2,2),(55,1,1),(56,1,3),(57,1,3),(58,2,2),(59,1,1),(62,1,3),(63,1,1),(64,1,1),(65,1,1),(66,1,1),(67,1,1),(68,1,3),(69,1,3),(70,1,1),(71,2,0),(72,1,1);

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `password` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `userType` int DEFAULT '2',
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=gbk;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`userName`,`password`,`userType`,`email`,`phone`) values (1,'admin','1',1,'kx876@uowmail.edu.au','88888888'),(2,'mm','123456',2,'123','1235'),(40,'zh','1',2,'111@qq.com','1111111534'),(55,'aq','1',2,'1123','312312'),(56,'ww','1',2,'123','123'),(71,'wqe','1',2,'123','123'),(72,'qqwe','1',2,'123','123');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
