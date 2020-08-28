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
  `idattribute` int NOT NULL,
  `idcatagory` int NOT NULL,
  `attribute` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idattribute`),
  UNIQUE KEY `idattribute_UNIQUE` (`idattribute`),
  KEY `att_idx` (`idcatagory`),
  CONSTRAINT `att` FOREIGN KEY (`idcatagory`) REFERENCES `catagory` (`idcatagory`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `attribute` */

insert  into `attribute`(`idattribute`,`idcatagory`,`attribute`) values (1,1,'csci');

/*Table structure for table `catagory` */

DROP TABLE IF EXISTS `catagory`;

CREATE TABLE `catagory` (
  `idcatagory` int NOT NULL,
  `catagory_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcatagory`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `catagory` */

insert  into `catagory`(`idcatagory`,`catagory_name`) values (1,'student'),(2,'teacher');

/*Table structure for table `files` */

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
  `idfile` int NOT NULL,
  `title` varchar(45) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `id` int NOT NULL,
  `file` blob,
  PRIMARY KEY (`idfile`),
  UNIQUE KEY `idfile_UNIQUE` (`idfile`),
  KEY `user_idx` (`id`),
  CONSTRAINT `uploader` FOREIGN KEY (`id`) REFERENCES `user_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `files` */

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

insert  into `powers`(`uid`,`fid`) values (1,3),(1,5),(1,7),(1,8),(2,3),(2,5),(2,8);

/*Table structure for table `user_att` */

DROP TABLE IF EXISTS `user_att`;

CREATE TABLE `user_att` (
  `user_id` int NOT NULL,
  `catagory_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `user_att` */

insert  into `user_att`(`user_id`,`catagory_id`,`attribute_id`) values (1,1,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`userName`,`password`,`userType`,`email`,`phone`) values (1,'xk','1',2,'kx876@uowmail.edu.au','88888888'),(2,'mm','123456',2,NULL,NULL),(3,'anqi','123456',2,NULL,NULL),(4,'zh','123456',2,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
