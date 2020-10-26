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

insert  into `attribute`(`attribute_id`,`category_id`,`attribute_name`) values (0,1,'FIN960'),(1,1,'ECON940'),(2,1,'FIN924'),(3,1,'FIN926'),(4,1,'FIN958'),(5,1,'FIN959'),(7,1,'MGNT909'),(8,1,'MBA906'),(9,2,'SNPG950'),(10,2,'SNPG923'),(11,2,'SNPG903'),(12,2,'SNPG915'),(13,2,'HSNP950'),(14,2,'HSNP923'),(15,2,'HSNP903'),(16,2,'HSNP915'),(17,3,'CSCI814'),(18,3,'CSCI851'),(19,3,'CSCI803'),(20,3,'CSCI835'),(21,3,'CSCI862'),(22,3,'CSIT826'),(23,3,'ISIT925'),(24,3,'CSIT940'),(25,3,'CSCI920'),(26,3,'CSCI992'),(27,3,'CSCI971'),(28,4,'EDGT817'),(29,4,'EDGT830'),(30,4,'EDGT838'),(31,4,'EDGT835'),(32,4,'EDGT890'),(33,4,'EDGT931'),(34,4,'EDGT932'),(35,4,'EDGT984'),(36,5,'SEA901'),(37,5,'SEA902'),(38,5,'SEA914'),(39,5,'SEA915'),(40,5,'SEA916'),(41,5,'SEA917'),(42,5,'SEA918'),(43,5,'SEA920'),(44,6,'THES925'),(45,6,'THES913'),(46,6,'RESH802'),(47,6,'GWP800');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `category_name` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values (0,'please select'),(1,'Business'),(2,'Nursing'),(3,'CSIT'),(4,'Education'),(5,'Law'),(6,'Physics');

/*Table structure for table `file_att` */

DROP TABLE IF EXISTS `file_att`;

CREATE TABLE `file_att` (
  `file_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `file_att` */

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=gbk;

/*Data for the table `file_info` */

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

insert  into `powers`(`uid`,`fid`) values (1,3),(1,5),(1,7),(1,8),(73,3),(73,5),(73,8),(74,3),(74,5),(74,8),(75,3),(75,5),(75,8),(76,3),(76,5),(76,8),(77,3),(77,5),(77,8),(78,3),(78,5),(78,8),(79,3),(79,5),(79,8),(80,3),(80,5),(80,8),(81,3),(81,5),(81,8),(82,3),(82,5),(82,8),(83,3),(83,5),(83,8),(84,3),(84,5),(84,8),(85,3),(85,5),(85,8),(86,3),(86,5),(86,8),(87,3),(87,5),(87,8),(88,3),(88,5),(88,8),(89,3),(89,5),(89,8),(90,3),(90,5),(90,8),(91,3),(91,5),(91,8),(92,3),(92,5),(92,8);

/*Table structure for table `user_att` */

DROP TABLE IF EXISTS `user_att`;

CREATE TABLE `user_att` (
  `user_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `user_att` */

insert  into `user_att`(`user_id`,`category_id`,`attribute_id`) values (1,3,26),(73,3,26),(74,3,26),(75,3,18),(76,3,26),(77,1,1),(78,2,11),(79,4,30),(80,5,39),(81,6,46),(82,6,46),(83,5,39),(84,2,12),(85,3,19),(86,3,27),(87,4,28),(88,2,13),(89,4,32),(90,2,14),(91,6,46),(92,3,20);

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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=gbk;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`userName`,`password`,`userType`,`email`,`phone`) values (1,'admin','1',1,'abe@uowmail.edu.au','0424888888'),(73,'aq610','1',4,'ag610@uowmail.edu.au','0424662513'),(74,'mm736','1',4,'mm736@uowmail.edu.au','0424558992'),(75,'kx876','1',4,'kx876@uowmail.edu.au','0424886520'),(76,'hz546','1',4,'hx546@uowmail.edu.au','0424469846'),(77,'ww485','1',2,'ww485@uowmail.edu.au','0411512345'),(78,'ad154','1',3,'ad154@uowmail.edu.au','0422125468'),(79,'ss159','1',3,'ss159@uowmail.edu.au','0422125896'),(80,'gf561','1',4,'gf561@uowmail.edu.au','0413157489'),(81,'bb154','1',2,'bb154@uowmail.edu.au','0423546879'),(82,'gr889','1',3,'gr889@uowmail.edu.au','0433548762'),(83,'ew234','1',4,'ew234@uowmail.edu.au','0422658963'),(84,'hg874','1',4,'hg874@uowmail.edu.au','0421451287'),(85,'wl845','1',4,'wl845@uowmail.edu.au','0422654823'),(86,'yg668','1',2,'yg668@uowmail.edu.au','0424556874'),(87,'gr124','1',4,'gr124@uowmail.edu.au','0242563214'),(88,'jk655','1',4,'jk655@uowmail.edu.au','0423541254'),(89,'as154','1',3,'as154@uowmail.edu.au','0142563214'),(90,'gg124','1',3,'gg124@uowmail.edu.au','0423651235'),(91,'gh223','1',4,'gh223','0433157856'),(92,'fg564','1',2,'fg564@uowmail.edu.au','0423568796');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
