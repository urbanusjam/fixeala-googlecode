/*  Script by Cora Reyes Calens              */ 	 				     
/*  Done for UrbanusJam!		             */						 
/*  Contact:     			                 */
/*			urbanusjam@gmail.com             */				 
/*    		coripel@gmail.com				 */	 
/*  Copyright Fixeala - 2013	             */
/*  Created:  08-10-2013 (dd-MM-YYYY)        */
/*  Modified: 08-10-2013                     */
		

DROP DATABASE IF EXISTS fixeala;
CREATE DATABASE fixeala;
USE fixeala;



-- AREA
CREATE TABLE AREA ( 
	   ID_AREA BIGINT(20) NOT NULL AUTO_INCREMENT,
	   NAME VARCHAR(255) NULL,
	   ACRONYM VARCHAR(15) NULL,
	   CITY VARCHAR(255) NULL,
	   CITY_ACRONYM VARCHAR(2) NULL,
	   PROVINCE VARCHAR(15) NULL,
	   PROVINCE_ACRONYM VARCHAR(2) NULL,
	   
	   PRIMARY KEY (ID_AREA)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- USER 	
CREATE TABLE USER ( 
	   ID_USER BIGINT(20) NOT NULL AUTO_INCREMENT,
	   USERNAME VARCHAR(50) NOT NULL,
	   PASSWORD VARCHAR(50) NULL,    
	   EMAIL VARCHAR(255) NOT NULL,
	   NAME VARCHAR(255) NULL,
	   LAST_NAME VARCHAR(255) NULL,
	   SALT VARCHAR(25) NULL,	
	   ID_AREA BIGINT(20) NULL,
	   GOV_POSITION VARCHAR(255) NULL,
	   GOV_SUB_AREA VARCHAR(255) NULL,
	   GOV_SUB_AREA_ACRONYM VARCHAR(15) NULL,
	   NEIGHBORHOOD VARCHAR(64) NULL,  
	   REGISTRATION_DATE DATETIME NULL,     
	   LAST_PASSWORD_CHANGE_DATE DATETIME NULL,    	   
	   LAST_LOGIN_DATE DATETIME NULL,   
	   CLOSED_ACCOUNT_DATE DATETIME NULL,   
	   IS_AREA TINYINT(1) NOT NULL,
	   VERIFIED_OFFICIAL TINYINT(1) NOT NULL,
	   ENABLED TINYINT(1) NOT NULL,		
	   
	   PRIMARY KEY (ID_USER),
	   UNIQUE KEY (EMAIL, USERNAME),
	   FOREIGN KEY (ID_AREA) REFERENCES AREA (ID_AREA)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- AUTHORITY
CREATE TABLE ROLE (
	   ID_ROLE BIGINT(20) NOT NULL AUTO_INCREMENT,
	   NAME VARCHAR(50) NOT NULL,
		
	   PRIMARY KEY (ID_ROLE)	
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- USER_AUTHORITY
CREATE TABLE USER_ROLE (
	   ID_USER BIGINT(20) NOT NULL,
	   ID_ROLE VARCHAR(50) NOT NULL,		
	   
	   PRIMARY KEY (ID_USER, ID_ROLE),
	   FOREIGN KEY (ID_USER) REFERENCES USER (ID_USER)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ACTIVATION
CREATE TABLE ACTIVATION ( 
	   TOKEN VARCHAR(126) NOT NULL,
	   USERNAME VARCHAR(50) NOT NULL,		  
	   CREATION_DATE DATETIME NOT NULL,
	   EXPIRATION_DATE DATETIME NOT NULL,
						
	   PRIMARY KEY (TOKEN),
	   UNIQUE KEY (USERNAME)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE
CREATE TABLE ISSUE (
	   ID_ISSUE BIGINT(20) NOT NULL, 
	   ID_REPORTER BIGINT(20) NOT NULL,
	   ID_ASSIGNED_OFFICIAL BIGINT(20) NULL,
	   ID_AREA BIGINT(20) NULL,
	   REPORTED_DATE DATETIME NOT NULL,    	  
	   ADDRESS VARCHAR(255) NOT NULL,
	   NEIGHBORHOOD VARCHAR (64) NULL,  
	   CITY VARCHAR(255) NOT NULL,		
	   PROVINCE VARCHAR (64) NOT NULL,  		   
	   LATITUDE FLOAT NOT NULL,
	   LONGITUDE FLOAT NOT NULL,
	   TITLE VARCHAR(255) NOT NULL,
	   DESCRIPTION LONGTEXT NOT NULL,		  
	   STATUS VARCHAR(30) NOT NULL, 
	   
	   PRIMARY KEY (ID_ISSUE),
	   FOREIGN KEY (ID_REPORTER) REFERENCES USER (ID_USER),
	   FOREIGN KEY (ID_ASSIGNED_OFFICIAL) REFERENCES USER (ID_USER),
	   FOREIGN KEY (ID_AREA) REFERENCES AREA (ID_AREA)

	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE LICITACION	
CREATE TABLE ISSUE_LICITACION ( 	  
	   ID_ISSUE BIGINT(20) NOT NULL, 	
	   NRO_LICITACION VARCHAR(20) NULL, 
	   NRO_EXPEDIENTE VARCHAR(20) NULL, 	
	   OBJETO VARCHAR (600) NULL, 
	   TIPO VARCHAR(20) NULL,  	
	   VALOR_PLIEGO FLOAT(20) NULL,
	   DOCUMENTACION_PLIEGO VARCHAR(255) NULL,	
	   UNIDAD_EJECUTORA VARCHAR (255) NULL, 
	   UNIDAD_FINANCIAMIENTO VARCHAR (255) NULL, 
	   EMPRESA_CONSTRUCTORA_NOMBRE VARCHAR (255) NULL, 
	   EMPRESA_CONSTRUCTORA_CUIT BIGINT (30) NULL, 
	   EMPRESA_CONSTRUCTORA_EMAIL VARCHAR (255) NULL, 
	   REPRESENTANTE_TECNICO_NOMBRE VARCHAR (255) NULL, 
	   REPRESENTANTE_TECNICO_DNI BIGINT (30) NULL, 
	   REPRESENTANTE_TECNICO_EMAIL VARCHAR (255) NULL, 
	   PLAZO_EJECUCION INT(10) NULL, 
	   PRESUPUESTO_ADJUDICADO FLOAT (20) NULL,
	   PRESUPUESTO_FINAL FLOAT (20) NULL,
	   FECHA_ESTIMADA_INICIO DATETIME NULL,
	   FECHA_ESTIMADA_FIN DATETIME NULL,
	   FECHA_REAL_INICIO DATETIME NULL,
	   FECHA_REAL_FIN DATETIME NULL,
	   STATUS_OBRA VARCHAR(30) NULL,  
	   
	   KEY(ID_ISSUE),
	   FOREIGN KEY (ID_ISSUE) REFERENCES ISSUE (ID_ISSUE) ON DELETE CASCADE ON UPDATE CASCADE
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	

-- TAG
CREATE TABLE TAG (
	   ID_TAG BIGINT(20) NOT NULL AUTO_INCREMENT,
	   TAG_NAME VARCHAR (50) NOT NULL,
	   
	   PRIMARY KEY (ID_TAG)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE_TAG
CREATE TABLE ISSUE_TAG (
	   ID_ISSUE BIGINT(20) NOT NULL,
	   ID_TAG BIGINT(20) NOT NULL,		   
	   
	   PRIMARY KEY (ID_TAG, ID_ISSUE),
	   FOREIGN KEY (ID_TAG) REFERENCES TAG (ID_TAG),
	   FOREIGN KEY (ID_ISSUE) REFERENCES ISSUE (ID_ISSUE)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- CONTENIDO
CREATE TABLE CONTENIDO ( 
	   ID_CONTENIDO BIGINT(20) NOT NULL AUTO_INCREMENT,
	   ID_ISSUE BIGINT(20) NULL,
	   TIPO VARCHAR(255) NOT NULL,
	   ALTO BIGINT(22) NOT NULL,
	   ANCHO BIGINT(22) NOT NULL,
	   PATH_RELATIVO VARCHAR(255) NOT NULL,
	   URL VARCHAR(1024) NULL,
	   NOMBRE VARCHAR(255) NOT NULL,
	   NOMBRE_CON_EXTENSION VARCHAR(255) NOT NULL,
	   UPLOAD_DATE DATETIME NULL,
	   ORDEN INT(10) NOT NULL,
	   IS_PROFILE_PIC TINYINT(1) NOT NULL,
	   
	   PRIMARY KEY (ID_CONTENIDO),
	   FOREIGN KEY (ID_ISSUE) REFERENCES ISSUE (ID_ISSUE)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- PASSWORD CHANGE REQUEST 
CREATE TABLE PASSWORD_CHANGE_REQUEST ( 
	   TOKEN VARCHAR(126) NOT NULL,
	   USERNAME VARCHAR(50) NOT NULL,		  
	   CREATION_DATE DATETIME NOT NULL,
	   EXPIRATION_DATE DATETIME NOT NULL,
				
	   PRIMARY KEY (TOKEN)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- PERSISTENT LOGIN (REMEMBER ME)
CREATE TABLE PERSISTENT_LOGINS(
	   USERNAME VARCHAR(50) NULL,
	   SERIES VARCHAR(64) NULL,
	   TOKEN VARCHAR(64) NULL,
	   LAST_USED TIMESTAMP NULL,		      
	   
	   PRIMARY KEY (SERIES)
	 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE HISTORIAL REVISION
CREATE TABLE ISSUE_HISTORIAL_REVISION ( 	  
	   ID_ISSUE_HISTORIAL_REVISION BIGINT(20) NOT NULL AUTO_INCREMENT, 	   
	   ID_ISSUE BIGINT(20) NOT NULL, 	   
	   ID_USER BIGINT(20) NOT NULL,	   
	   HISTORIAL_DATE DATETIME NOT NULL,    	   
	   STATUS VARCHAR(30) NOT NULL, 	    
	   OPERACION VARCHAR(1) NOT NULL,
	   MOTIVO VARCHAR(255) NOT NULL, 	
	   OBSERVACIONES VARCHAR(500) NULL,  
	   CAMPOS_MODIFICADOS VARCHAR(255) NULL, 
	   
	   PRIMARY KEY(ID_ISSUE_HISTORIAL_REVISION),
	   KEY(ID_ISSUE),
	   FOREIGN KEY (ID_ISSUE) REFERENCES ISSUE (ID_ISSUE) ON DELETE CASCADE ON UPDATE CASCADE,
	   FOREIGN KEY (ID_USER) REFERENCES USER (ID_USER)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	


-- COMMENT			
CREATE TABLE COMMENT ( 	  
	   ID_COMMENT BIGINT(20) NOT NULL AUTO_INCREMENT,    
	   ID_ISSUE BIGINT(20) NOT NULL, 
	   ID_USER BIGINT(20) NOT NULL,	   
	   COMMENT_DATE DATETIME NULL,    	   
	   COMMENT_MESSAGE VARCHAR(300) NOT NULL,		 
	   FLAG TINYINT(1) NOT NULL,
	   
	   PRIMARY KEY(ID_COMMENT),
	   FOREIGN KEY (ID_ISSUE) REFERENCES ISSUE (ID_ISSUE),
	   FOREIGN KEY (ID_USER) REFERENCES USER (ID_USER)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


-- ISSUE_VOTE
CREATE TABLE issue_vote (	
       id_issue BIGINT(20) NOT NULL,
	   id_voter BIGINT(20) NOT NULL,	 
	   vote SMALLINT NOT NULL CHECK ("VOTE" = 1 OR "VOTE" = -1),
	   vote_date DATETIME NOT NULL,
	   	   
	   PRIMARY KEY (id_issue, id_voter),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue),
	   FOREIGN KEY (id_voter) REFERENCES user (id_user)	  
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE_FOLLOW
CREATE TABLE issue_follow (	 	
	   id_issue BIGINT(20) NOT NULL,
	   id_follower BIGINT(20) NOT NULL,	 
	   follow_date DATETIME NOT NULL,
	   	  
	   PRIMARY KEY (id_issue, id_follower),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue),
	   FOREIGN KEY (id_follower) REFERENCES user (id_user)	  
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE_VIEW
CREATE TABLE issue_pageview (	
	   id_issue_pageview BIGINT(20) NOT NULL AUTO_INCREMENT,    
	   id_issue BIGINT(20) NOT NULL,
	   id_user BIGINT(20) NOT NULL,	 
	   ip_address INT(11) UNSIGNED NULL,
	   pageview_date DATETIME NOT NULL,
	   
	   PRIMARY KEY (id_issue_pageview),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue),
	   FOREIGN KEY (id_user) REFERENCES user (id_user)	  
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--INSERT INTO `ISSUE_VIEW` (`IP_ADDRESS`) VALUES (INET_ATON("127.0.0.1"));
--SELECT INET_NTOA(`IP_ADDRESS`) FROM `ISSUE_VIEW`;


-- COMMENT_VOTE
CREATE TABLE COMMENT_VOTE (	
	   ID_COMMENT BIGINT(20) NOT NULL,
	   ID_USER BIGINT(20) NOT NULL,	 
	   VOTE SMALLINT NOT NULL CHECK ("VOTE" = 1 OR "VOTE" = -1),
	   VOTE_DATE DATETIME NOT NULL,
	   
	   PRIMARY KEY (ID_COMMENT, ID_USER),
	   FOREIGN KEY (ID_COMMENT) REFERENCES COMMENT (ID_COMMENT),
	   FOREIGN KEY (ID_USER) REFERENCES USER (ID_USER)	  
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- NOTIFICATION
CREATE TABLE notification (
       id_notification BIGINT(20) NOT NULL AUTO_INCREMENT,   
       id_notification_type BIGINT(20) NOT NULL,
       id_action_type BIGINT(20) NOT NULL,
       id_sender BIGINT(20) NOT NULL,           
       created_date TIMESTAMP NOT NULL,
       url VARCHAR(300) NULL,       

       PRIMARY KEY (id_notification ),
       FOREIGN KEY (id_notification_type) REFERENCES notification_type (id_notification_type),
       FOREIGN KEY (id_action_type) REFERENCES action_type (id_action_type),
       FOREIGN KEY (id_sender) REFERENCES USER (id_user)      

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- NOTIFICATION_USER
CREATE TABLE notification_user (
       id_notification BIGINT(20) NOT NULL,
       id_recipient BIGINT(20) NOT NULL,
       seen TINYINT(1) DEFAULT 0,   

       PRIMARY KEY (id_notification , id_recipient),
       FOREIGN KEY (id_notification) REFERENCES notification (id_notification),
       FOREIGN KEY (id_recipient ) REFERENCES USER (id_user)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- NOTIFICATION TYPE
CREATE TABLE notification_type (
       id_notification_type BIGINT(20) NOT NULL AUTO_INCREMENT,   
       notification_name VARCHAR(100) NOT NULL,
       description VARCHAR(300) NULL,

       PRIMARY KEY (id_notification_type)   

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ACTION_TYPE
CREATE TABLE action_type (
       id_action_type BIGINT(20) NOT NULL AUTO_INCREMENT,   
       action_name VARCHAR(100) NOT NULL,     

       PRIMARY KEY (id_action_type) 

) ENGINE=InnoDB DEFAULT CHARSET=utf8; 


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


INSERT INTO `area` (`NAME`,`ACRONYM`,`PROVINCE`,`PROVINCE_ACRONYM`,`CITY`,`CITY_ACRONYM`) 
VALUES 
('Comuna 1','C1', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 2','C2', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 3','C3', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 4','C4', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Ministerio de Ambiente y Espacio P�blico','MAYEPGC', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA');


INSERT INTO `user` 
(`USERNAME`,`PASSWORD`,`EMAIL`,`NAME`, `LAST_NAME`,`SALT`, `ID_AREA`,`GOV_POSITION`,`GOV_SUB_AREA`,`GOV_SUB_AREA_ACRONYM`,
`NEIGHBORHOOD`,`REGISTRATION_DATE`,`LAST_PASSWORD_CHANGE_DATE`,`LAST_LOGIN_DATE`,`CLOSED_ACCOUNT_DATE`, `VERIFIED_OFFICIAL`, `ENABLED`) 
VALUES
('coripel','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','coripel@gmail.com','Cora','Reyes Calens',NULL, 5, 'Responsable de area', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('fakeuser','20dc925be88e7d0bd130c6c2cf43a77eb344243f','fakeuser@gmail.com','Juan','Vasquez',NULL, 1, 'Presidente Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('mock','3a49a0e2f78aa4d0300177f4588388a21833b0b5','mock@gmail.com','Julia','Rikiki', NULL, 1, 'Miembro Junta Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,0,1),
('helloworld','dce876c90f1e39b5a195d468ebbdfb7f192c4c8a','helloworld@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'San Telmo',NULL,NULL,NULL,NULL,0,1),
('dummy','37323501a7840726056e7d2159f2c776482f13ef','dummy@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',NULL,NULL,NULL,NULL,0,1),
('comuna1',NULL,'comuna_uno@buenosaires.gob.ar',NULL,NULL, NULL, 1, 'Area', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('comuna2',NULL,'comuna_dos@buenosaires.gob.ar',NULL,NULL, NULL, 2, 'Area', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('user2','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user2@gmail.com','Cora','Reyes Calens',NULL, 5, 'Responsable de area', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('user3','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user3@gmail.com','Juan','Vasquez',NULL, 1, 'Presidente Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('user4','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user4@gmail.com','Julia','Rikiki', NULL, 1, 'Miembro Junta Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,0,1),
('user5','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user5@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'San Telmo',NULL,NULL,NULL,NULL,0,1),
('user6','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user6@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'La Boca',NULL,NULL,NULL,NULL,0,1),
('user7','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user7@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',NULL,NULL,NULL,NULL,0,1),
('user8','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user8@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',NULL,NULL,NULL,NULL,0,1);

INSERT INTO `user` 
(`USERNAME`,`PASSWORD`,`EMAIL`,`NAME`, `LAST_NAME`,`SALT`, `ID_AREA`,`GOV_POSITION`,`GOV_SUB_AREA`,`GOV_SUB_AREA_ACRONYM`,
`NEIGHBORHOOD`,`REGISTRATION_DATE`,`LAST_PASSWORD_CHANGE_DATE`,`LAST_LOGIN_DATE`,`CLOSED_ACCOUNT_DATE`, `VERIFIED_OFFICIAL`, `ENABLED`) 
VALUES
('user2','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user2@gmail.com','Cora','Reyes Calens',NULL, 5, 'Responsable de area', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('user3','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user3@gmail.com','Juan','Vasquez',NULL, 1, 'Presidente Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('user4','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user4@gmail.com','Julia','Rikiki', NULL, 1, 'Miembro Junta Comunal', NULL, NULL, NULL,NULL,NULL,NULL,NULL,0,1),
('user5','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user5@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'San Telmo',NULL,NULL,NULL,NULL,0,1),
('user6','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user6@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'La Boca',NULL,NULL,NULL,NULL,0,1),
('user7','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user7@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',NULL,NULL,NULL,NULL,0,1),
('user8','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user8@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',NULL,NULL,NULL,NULL,0,1);

INSERT INTO `role` (`ID_ROLE`,`NAME`)
VALUES 
(1,'ROLE_ADMIN'),
(2,'ROLE_MANAGER'),
(3,'ROLE_AREA'),
(4,'ROLE_USER');


INSERT INTO `user_role` (`ID_USER`,`ID_ROLE`) 
VALUES 
(1,1),
(2,1),
(3,2),
(4,4),
(5,4),
(6,3), 
(7,3);


INSERT INTO `comment` (`ID_ISSUE`,`ID_USER`, `COMMENT_DATE`, `COMMENT_MESSAGE`, `FLAG`) 
VALUES
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 6, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false );






	

