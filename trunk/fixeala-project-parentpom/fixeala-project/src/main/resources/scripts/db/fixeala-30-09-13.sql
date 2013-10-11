# Host: localhost  (Version: 5.0.51b-community-nt-log)
# Date: 2013-09-30 18:00:27
# Generator: MySQL-Front 5.2  (Build 5.62)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

DROP DATABASE IF EXISTS `fixeala`;
CREATE DATABASE `fixeala` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fixeala`;

#
# Source for table "activation"
#

DROP TABLE IF EXISTS `activation`;
CREATE TABLE `activation` (
  `TOKEN` varchar(126) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `CREATION_DATE` datetime NOT NULL,
  `EXPIRATION_DATE` datetime NOT NULL,
  PRIMARY KEY  (`TOKEN`),
  UNIQUE KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "activation"
#


#
# Source for table "authorities"
#

DROP TABLE IF EXISTS `authorities`;
CREATE TABLE `authorities` (
  `USERNAME` varchar(50) NOT NULL,
  `AUTHORITY` varchar(50) NOT NULL,
  PRIMARY KEY  (`USERNAME`,`AUTHORITY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "authorities"
#

INSERT INTO `authorities` VALUES ('admin','ROLE_ADMIN'),('admin','ROLE_USER'),('coripel','ROLE_USER'),('fakeuser','ROLE_USER'),('guest','ROLE_USER'),('helloworld','ROLE_USER'),('mock','ROLE_USER'),('nuevouser','ROLE_USER'),('pablo','ROLE_USER');

#
# Source for table "issues"
#

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `ID_ISSUE` int(10) NOT NULL auto_increment,
  `USERNAME` varchar(50) NOT NULL,
  `REPORTED_DATE` datetime NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `NEIGHBORHOOD` varchar(64) default NULL,
  `CITY` varchar(255) NOT NULL,
  `PROVINCE` varchar(64) NOT NULL,
  `LATITUDE` float NOT NULL,
  `LONGITUDE` float NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(500) NOT NULL,
  `STATUS` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID_ISSUE`),
  KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "issues"
#

INSERT INTO `issues` VALUES (1,'coripel','2013-09-30 14:50:28','Libertad 1201-1299','Retiro','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5937,-58.3844,'Un reclamo de ejemplo','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam purus orci, consectetur eget nulla sed, tempus commodo lacus. Aenean non iaculis leo. Quisque aliquam quam at dapibus scelerisque. Donec pellentesque ultrices rhoncus. Aliquam faucibus a nulla vel pulvinar. Vestibulum sit amet consequat odio, a elementum purus.','OPEN');

#
# Source for table "issues_tags"
#

DROP TABLE IF EXISTS `issues_tags`;
CREATE TABLE `issues_tags` (
  `ID_ISSUE` int(10) NOT NULL,
  `ID_TAG` int(10) NOT NULL,
  PRIMARY KEY  (`ID_TAG`,`ID_ISSUE`),
  KEY `ID_ISSUE` (`ID_ISSUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "issues_tags"
#

INSERT INTO `issues_tags` VALUES (1,1);

#
# Source for table "password_change_requests"
#

DROP TABLE IF EXISTS `password_change_requests`;
CREATE TABLE `password_change_requests` (
  `TOKEN` varchar(126) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `CREATION_DATE` datetime NOT NULL,
  `EXPIRATION_DATE` datetime NOT NULL,
  PRIMARY KEY  (`TOKEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "password_change_requests"
#


#
# Source for table "persistent_logins"
#

DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins` (
  `USERNAME` varchar(50) default NULL,
  `SERIES` varchar(64) NOT NULL default '',
  `TOKEN` varchar(64) default NULL,
  `LAST_USED` timestamp NULL default NULL,
  PRIMARY KEY  (`SERIES`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "persistent_logins"
#


#
# Source for table "tags"
#

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `ID_TAG` int(10) NOT NULL auto_increment,
  `TAG_NAME` varchar(50) NOT NULL,
  PRIMARY KEY  (`ID_TAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "tags"
#

INSERT INTO `tags` VALUES (1,'bache');

#
# Source for table "users"
#

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `SALT` varchar(25) default NULL,
  `EMAIL` varchar(255) default NULL,
  `NEIGHBORHOOD` varchar(64) default NULL,
  `PROFILE_PIC` varchar(255) default NULL,
  `FIX_RANK` varchar(64) default NULL,
  `FIX_POINTS` int(22) default NULL,
  `REGISTRATION_DATE` datetime default NULL,
  `LAST_PASSWORD_CHANGE_DATE` datetime default NULL,
  `LAST_LOGIN_DATE` datetime default NULL,
  `CLOSED_ACCOUNT_DATE` datetime default NULL,
  `ENABLED` tinyint(1) NOT NULL,
  PRIMARY KEY  (`USERNAME`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  KEY `USERNAME` (`USERNAME`,`PASSWORD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "users"
#

INSERT INTO `users` VALUES ('admin','admin','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('coripel','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','','coripel@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('fakeuser','43a3f7f06dc85a1d3249e073c2fe3fa2cfe06cc5','','fakeuser@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('guest','guest','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('helloworld','b6fc2132f07b0230ac197d342548c10b1c760ccf','','helloworld@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('mock','e8a26afff685de0b2e2ae72a6fbb3747a0ed5fe2','','mock@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('nuevouser','527ba03e5191dd7c9fd01a40cf22bef3503509ac','','nuevouser@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('pablo','a1350c8fd2951c99fa395e807b8fb62de1ded7af','','pablo@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('pablodo','ade6d94764bcc80af37932f1e5f9f3a6ac3cc8f9','','pablodo@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);

#
#  Foreign keys for table issues
#

ALTER TABLE `issues`
ADD CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`USERNAME`) REFERENCES `users` (`USERNAME`);

#
#  Foreign keys for table issues_tags
#

ALTER TABLE `issues_tags`
ADD CONSTRAINT `issues_tags_ibfk_1` FOREIGN KEY (`ID_TAG`) REFERENCES `tags` (`ID_TAG`),
ADD CONSTRAINT `issues_tags_ibfk_2` FOREIGN KEY (`ID_ISSUE`) REFERENCES `issues` (`ID_ISSUE`);


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
