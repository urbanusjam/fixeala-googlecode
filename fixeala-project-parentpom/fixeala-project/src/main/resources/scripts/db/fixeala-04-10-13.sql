# Host: localhost  (Version: 5.0.51b-community-nt-log)
# Date: 2013-10-04 17:49:29
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

INSERT INTO `authorities` VALUES ('admin','ROLE_ADMIN'),('admin','ROLE_USER'),('coripel','ROLE_USER'),('dummy','ROLE_USER'),('fakeuser','ROLE_USER'),('guest','ROLE_USER'),('helloworld','ROLE_USER'),('mock','ROLE_USER'),('nuevouser','ROLE_USER'),('pablo','ROLE_USER'),('testing','ROLE_USER'),('wing','ROLE_USER');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

#
# Data for table "issues"
#

INSERT INTO `issues` VALUES (1,'coripel','2015-06-09 00:00:00','Libertad 1201-1299','Retiro','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5937,-58.3844,'Un reclamo de ejemplo 999dd','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','ABIERTO'),(2,'mock','2013-10-01 12:01:43','Hamburgo 3201-3299','Agronomía','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5869,-58.4838,'Alumbrado defectuoso','Nullam dapibus imperdiet dapibus. Ut eget turpis risus. Morbi malesuada sodales orci ut vestibulum. Quisque rhoncus nisl non ante venenatis tempus. ','ABIERTO'),(3,'coripel','2013-10-01 12:08:17','Eduardo Acevedo 582-600','Caballito','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6089,-58.433,'Calle rota','Proin adipiscing in neque sit amet pharetra. Proin eget sem lacus. Ut dictum, metus at venenatis sagittis, eros quam posuere sapien, vel rhoncus lacus purus non libero. ','ABIERTO'),(4,'fakeuser','2013-10-01 12:11:15','Miñones 1722-1800','Belgrano','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5583,-58.443,'Un ejemplo de marker','Nullam dapibus imperdiet dapibus. Ut eget turpis risus. Morbi malesuada sodales orci ut vestibulum. Quisque rhoncus nisl non ante venenatis tempus. M','ABIERTO'),(5,'coripel','2013-10-01 12:20:06','sd','Palermo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5756,-58.4258,'sdf','sdf','ABIERTO'),(6,'fakeuser','2013-10-01 12:23:44','Avenida Alvarez Thomas 2-100','Chacarita','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5832,-58.4447,'Pozo grande!!','Cras sodales mauris mauris, at euismod ipsum faucibus interdum. Sed vel nulla eget neque facilisis venenatis. Phasellus elementum fermentum hendrerit. Sed mattis ornare leo.','ABIERTO'),(7,'coripel','2013-10-01 12:24:41','Bolívar 799-849','','Ramos Mejía','Buenos Aires',-34.6485,-58.563,'Fuera de CABA','Cras sodales mauris mauris, at euismod ipsum faucibus interdum. Sed vel nulla eget neque facilisis venenatis. Phasellus elementum fermentum hendrerit. Sed mattis ornare leo.','ABIERTO'),(8,'fakeuser','2013-10-01 12:28:01','Gdor. Castro 1300-1398','','Villa Adelina','Buenos Aires',-34.5281,-58.5537,'Basura tirada por todos lados','Suspendisse eu diam sem. Phasellus ac hendrerit neque. Duis dapibus nunc sed tellus condimentum interdum. Morbi vulputate ac purus at egestas.','ABIERTO'),(9,'coripel','2013-10-01 00:00:00','Gral. Paz 8902-9000','Villa Real','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6208,-58.5298,'Un ejemplo de titulo nuevo y URL','Mauris facilisis fermentum augue id accumsan. Morbi vehicula mi lorem. Nullam pulvinar cursus urna aliquam accumsan. Vivamus ullamcorper ligula sed risus hendrerit commodo.','ABIERTO'),(10,'fakeuser','2013-10-01 13:51:57','Herrera 1901-1999','Barracas','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6496,-58.3747,'APICABA','Mauris facilisis fermentum augue id accumsan. Morbi vehicula mi lorem. Nullam pulvinar cursus urna aliquam accumsan. Vivamus ullamcorper ligula sed risus hendrerit commodo. ','ABIERTO'),(11,'coripel','2013-10-01 13:53:59','Pres. Teniente General Juan Domingo Perón 2602-2700','','Valentín Alsina','Buenos Aires',-34.6733,-58.4062,'Tapa de alcantarilla hundida','Fusce quam nibh, molestie non massa quis, consequat luctus metus. Donec ac ullamcorper nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus.','ABIERTO'),(12,'coripel','2013-10-01 00:00:00','Avenida Juan Bautista Alberdi 1602-1700','Flores','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6276,-58.4519,'Mampostería en mal estado','dfs','ABIERTO'),(13,'coripel','2013-10-01 16:27:17','Venezuela 802-900','Monserrat','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6143,-58.378,'sdfs','dfsdf','ABIERTO'),(14,'mock','2013-10-01 16:27:45','Avenida Francisco Beiro 2402-2500','Agronomía','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5937,-58.4883,'dfgdf','gdfg','ABIERTO'),(15,'coripel','2013-10-01 16:28:20','Avenida Independencia 3902-3926','Almagro','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6213,-58.4207,'dfsdf','sdfsdfs','ABIERTO'),(16,'mock','2013-10-01 16:30:05','Manuel García 101-199','Parque Patricios','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6377,-58.397,'sdfs','dfsdf','ABIERTO'),(17,'coripel','2013-10-01 16:33:16','Avenida Rivadavia 9352-9400','Villa Luro','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6372,-58.4962,'sdfs','df','ABIERTO'),(18,'coripel','2013-10-01 16:36:06','Atuel 851-899','Nueva Pompeya','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6479,-58.4066,'sdfsdf','fsdf','ABIERTO'),(19,'mock','2013-10-01 16:36:54','Santa Catalina 1801-1899','Nueva Pompeya','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6567,-58.4255,'sdfg','sdfg','ABIERTO'),(20,'coripel','2013-10-01 16:41:27','Virrey Liniers 1201-1299','Boedo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6259,-58.4138,'asdsd','asd','ABIERTO'),(21,'coripel','2013-10-01 00:00:00','Sánchez de Loría 702-800','Almagro','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6191,-58.4124,'Un titulo de X-Editable 2','Sed ut laoreet odio, id interdum odio. Ut et eleifend orci. Proin venenatis pretium bibendum. Maecenas faucibus risus et nisi laoreet venenatis. Donec urna mi, dignissim non sollicitudin at, dignissim quis turpis. Donec a odio sit amet leo tristique vestibulum ac placerat erat. Fusce in velit vel risus rhoncus blandit eu elementum risus.','ABIERTO'),(22,'coripel','2013-10-01 16:48:44','Güemes 3701-3799','Palermo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5874,-58.4152,'sdf','dfsdf','ABIERTO'),(23,'coripel','2013-10-01 16:50:46','Constitución 1401-1499','Constitución','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6247,-58.3863,'sdf','dfdf','ABIERTO'),(24,'coripel','2013-10-01 16:58:06','Cabello 3601-3699','Palermo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5804,-58.4114,'zxczxc','zxzxc','ABIERTO'),(25,'coripel','2013-10-01 17:15:13','Aristóbulo del Valle 702-800','Boca','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.6345,-58.3641,'asda','sdasd','ABIERTO'),(26,'coripel','2013-10-01 17:31:12','Julián Alvarez 1302-1400','Palermo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5937,-58.4262,'asdas','dasdd','ABIERTO'),(27,'coripel','2013-10-01 17:32:19','Quilmssssssss','ssssssssss','Buenos Aires','Ciudad Autónomass',-34.6445,-58.4176,'sddf','sdfsdf','ABIERTO'),(28,'coripel','2013-10-01 17:34:22','Julián Alvarez 1602-1700','Palermo','Buenos Airesc','Ciudad Autónoma de Buenos Aires',-34.592,-58.4231,'cvbc','cvbcvb','ABIERTO'),(29,'coripel','2013-10-01 17:35:00','Bonpland 2301-2399','Palermo','Buenos Aires','Ciudad Autónoma de Buenos Aires',-34.5784,-58.431,'fsdfsdf','ddfsdfs','ABIERTO'),(30,'coripel','2013-01-10 00:00:00','Campero 101-199','Barrio Bajo Gorriti','San Salvador de Jujuy','Jujuy',-24.1909,-65.3002,'Alumbrado en mal estado','Donec pharetra orci odio, eget ullamcorper sem mattis ut. Suspendisse nec sodales quam. In adipiscing mi sed tincidunt sodales. Etiam blandit orci ante, eu varius justo gravida non. Aliquam quis pulvinar massa, sit amet gravida lacus.','ABIERTO');

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

INSERT INTO `issues_tags` VALUES (2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(10,10),(11,11),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(22,22),(23,23),(24,24),(25,25),(26,26),(27,27),(28,28),(29,29);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

#
# Data for table "tags"
#

INSERT INTO `tags` VALUES (1,'bache'),(2,'alumbrado'),(3,'calle'),(4,'bache'),(5,'bache'),(6,'vereda'),(7,'bache'),(8,'basura'),(9,'ejemplo'),(10,'apicaba'),(11,'tapa alcantarila'),(12,'sdf'),(13,'sdfsdf'),(14,'dffg'),(15,'s'),(16,'sdf'),(17,'sdfsdf'),(18,'sdfd'),(19,'sdf'),(20,'assd'),(21,'sdf'),(22,'sdfsdf'),(23,'sdfd'),(24,'zxc'),(25,'asd'),(26,'assd'),(27,'sdfdf'),(28,'cvbcvb'),(29,'sdfsdf'),(30,'dfdgdf');

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

INSERT INTO `users` VALUES ('admin','admin','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('coripel','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','','coripel@gmail.com','Constitución',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('fakeuser','43a3f7f06dc85a1d3249e073c2fe3fa2cfe06cc5','','fakeuser@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('guest','guest','','guest@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('helloworld','b6fc2132f07b0230ac197d342548c10b1c760ccf','','helloworld@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('mock','e8a26afff685de0b2e2ae72a6fbb3747a0ed5fe2','','mock@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('nuevouser','527ba03e5191dd7c9fd01a40cf22bef3503509ac','','nuevouser@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('pablo','a1350c8fd2951c99fa395e807b8fb62de1ded7af','','pablo@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('pablodo','ade6d94764bcc80af37932f1e5f9f3a6ac3cc8f9','','pablodo@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);

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
