/* ###################################################################################### */
/* ###    FIXEALA Database Schema                                                         */ 	
/* ###																					  */
/* ###    Script by CORA REYES CALENS                                                     */ 	 				     
/* ###    Done for UrbanusJam!		             										  */						 
/* ###    Contact:     			                                                          */
/* ###					urbanusjam@gmail.com                                              */				 
/* ###   				coripel@gmail.com				                                  */	 
/* ###																					  */
/* ###    Created:  08-10-2013         													  */
/* ###    © Copyright FIXEALA 2013-2014	             									  */
/* ###################################################################################### */		


DROP DATABASE IF EXISTS fixeala;

CREATE DATABASE fixeala;

USE fixeala;



/* ###################################################################################### */
/* ###    TABLES                                                                          */
/* ###################################################################################### */



CREATE TABLE activation ( 
	   token VARCHAR(126) NOT NULL,
	   username VARCHAR(50) NOT NULL,		  
	   creation_date DATETIME NOT NULL,
	   expiration_date DATETIME NOT NULL,
						
	   PRIMARY KEY (token),
	   UNIQUE KEY (username)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE comment ( 	  
	   id_comment BIGINT(20) NOT NULL AUTO_INCREMENT,    
	   id_issue BIGINT(20) NOT NULL, 
	   id_user BIGINT(20) NOT NULL,	   
	   creation_date DATETIME NULL,    	   
	   message VARCHAR(300) NOT NULL,		 
	   flag TINYINT(1) NOT NULL,
	   
	   PRIMARY KEY(id_comment)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE media_content ( 
	   id_content BIGINT(20) NOT NULL AUTO_INCREMENT,
	   id_issue BIGINT(20) NULL,	
	   file_id VARCHAR(50) NOT NULL,
	   file_type VARCHAR(30) NOT NULL, 
	   filename VARCHAR(200) NULL,
	   file_order INT(1) NOT NULL,
	   upload_date BIGINT NOT NULL,
	   width BIGINT(22) NOT NULL,
	   height BIGINT(22) NOT NULL,
	   size BIGINT(50) NOT NULL,
	   deletehash VARCHAR(100) NULL,
	   link VARCHAR(150) NOT NULL,
	   is_profile_pic TINYINT(1) NOT NULL,
	   username VARCHAR(50) NULL,
	   
	   PRIMARY KEY (id_content),
	   UNIQUE KEY(file_id)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue (
	   id_issue BIGINT(20) NOT NULL AUTO_INCREMENT, 
	   id_reporter BIGINT(20) NOT NULL,
	   creation_date DATETIME NOT NULL,    	  
	   last_update_date DATETIME NOT NULL,    	  
	   address VARCHAR(255) NOT NULL,
	   neighborhood VARCHAR (64) NULL,  
	   city VARCHAR(255) NOT NULL,		
	   province VARCHAR (64) NOT NULL,  		   
	   latitude FLOAT NOT NULL,
	   longitude FLOAT NOT NULL,
	   title VARCHAR(255) NOT NULL,
	   description LONGTEXT NOT NULL,		  	 
	   priority VARCHAR(64) NULL, 
	   resolution_type VARCHAR(64) NULL, 	
	   status VARCHAR(64) NOT NULL,
	  
	   PRIMARY KEY (id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_follow (	 	
	   id_issue BIGINT(20) NOT NULL,
	   id_user BIGINT(20) NOT NULL,	 
	   date DATETIME NOT NULL,
	   	  
	   PRIMARY KEY (id_issue, id_user)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_repair ( 	  
	   id_issue BIGINT(20) NOT NULL, 	
	   obra VARCHAR (600) NULL, 
	   nro_licitacion VARCHAR(20) NULL, 
	   nro_expediente VARCHAR(20) NULL, 	 
	   plazo INT(20) NULL, 	  
	   contratista_nombre VARCHAR (255) NULL, 
	   contratista_cuit VARCHAR (30) NULL, 	 
	   representante_tecnico_nombre VARCHAR (255) NULL, 
	   representante_tecnico_matricula VARCHAR (30) NULL, 	 
	   unidad_ejecutora VARCHAR (255) NULL, 
	   unidad_financiamiento VARCHAR (255) NULL, 
	   presupuesto_adjudicacion DECIMAL (10,2) DEFAULT 0,
	   presupuesto_final DECIMAL (10,2) DEFAULT 0,
	   fecha_estimada_inicio DATE NULL,
	   fecha_estimada_fin DATE NULL,
	   fecha_real_inicio DATE NULL,
	   fecha_real_fin DATE NULL,
	   estado_obra VARCHAR(30) NULL,  
	   observaciones LONGTEXT NULL,  
	   
	   KEY(id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	
 

CREATE TABLE issue_link (
	   id_issue BIGINT(20) NOT NULL, 
	   id_related_issue BIGINT(20) NOT NULL, 
	   link_type VARCHAR(64) NOT NULL, 
	   
	   PRIMARY KEY (id_issue, id_related_issue)
	    
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 

CREATE TABLE issue_tag (
	   id_issue BIGINT(20) NOT NULL,
	   id_tag BIGINT(20) NOT NULL,		   
	   
	   PRIMARY KEY (id_tag, id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_history ( 	  
	   id_issue_history BIGINT(20) NOT NULL AUTO_INCREMENT, 	   
	   id_issue BIGINT(20) NOT NULL, 	   
	   id_user BIGINT(20) NOT NULL,	   
	   update_date DATETIME NOT NULL,    	   
	   status VARCHAR(30) NOT NULL, 	    
	   operation_type VARCHAR(1) NULL,	
	   resolution_type VARCHAR(255) NULL, 	
	   motive VARCHAR(255) NULL, 	   
	   observations VARCHAR(500) NULL,  
	  
	   PRIMARY KEY(id_issue_history),
	   KEY(id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_pageview (	
	   id_issue_pageview BIGINT(20) NOT NULL AUTO_INCREMENT,    
	   id_issue BIGINT(20) NOT NULL,
	   id_user BIGINT(20) NOT NULL,	 
	   ip_address INT(11) UNSIGNED NULL,
	   pageview_date DATETIME NOT NULL,
	   
	   PRIMARY KEY (id_issue_pageview)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_vote (	
       id_issue BIGINT(20) NOT NULL,
	   id_user BIGINT(20) NOT NULL,	 
	   vote SMALLINT NOT NULL CHECK ("VOTE" = 1 OR "VOTE" = -1),
	   date DATETIME NOT NULL,
	   	   
	   PRIMARY KEY (id_issue, id_user) 
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_verification_request ( 
	id_issue BIGINT(20) NOT NULL,
	id_user BIGINT(20) NOT NULL,	   
	verification_date DATETIME NOT NULL,
	is_verified TINYINT(1) NOT NULL,		
	   
	PRIMARY KEY (id_issue, id_user)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE password_change_request ( 
	   token VARCHAR(126) NOT NULL,
	   username VARCHAR(50) NOT NULL,		  
	   creation_date DATETIME NOT NULL,
	   expiration_date DATETIME NOT NULL,
				
	   PRIMARY KEY (token)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE persistent_logins (
	   username VARCHAR(50) NULL,
	   series VARCHAR(64) NULL,
	   token VARCHAR(64) NULL,
	   last_used TIMESTAMP NULL,		      
	   
	   PRIMARY KEY (series)
	 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE role (
	   id_role BIGINT(20) NOT NULL AUTO_INCREMENT,
	   rolename VARCHAR(50) NOT NULL,
		
	   PRIMARY KEY (id_role)	
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE tag (
	   id_tag BIGINT(20) NOT NULL AUTO_INCREMENT,
	   tagname VARCHAR (50) NOT NULL,
	   
	   PRIMARY KEY (id_tag),
	   UNIQUE KEY (tagname)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	

CREATE TABLE user ( 
	   id_user BIGINT(20) NOT NULL AUTO_INCREMENT,
	   username VARCHAR(50) NOT NULL,
	   password VARCHAR(50) NULL,    
	   email VARCHAR(255) NOT NULL,
	   first_name VARCHAR(255) NULL,
	   last_name VARCHAR(255) NULL,
	   city_of_residence VARCHAR(64) NULL,
	   province_of_residence VARCHAR(64) NULL,
	   salt VARCHAR(25) NULL,		   
	   registration_date DATETIME NULL,     
	   last_password_change_date DATETIME NULL,    	   
	   last_login_date DATETIME NULL,   
	   closed_account_date DATETIME NULL,   	   
	   enabled TINYINT(1) NOT NULL,		
	   
	   PRIMARY KEY (id_user),
	   UNIQUE KEY (email, username)	 
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE user_role (
	   id_user BIGINT(20) NOT NULL,
	   id_role VARCHAR(50) NOT NULL,		
	   
	   PRIMARY KEY (id_user, id_role)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/* ###################################################################################### */
/* ###    CONSTRAINTS                                                                     */
/* ###################################################################################### */



ALTER TABLE user_role
    ADD CONSTRAINT FOREIGN KEY fk_user_role_1 (id_user)
    REFERENCES user (id_user);
    
ALTER TABLE issue
    ADD CONSTRAINT FOREIGN KEY fk_issue_1 (id_reporter)
    REFERENCES user (id_user);
    
ALTER TABLE issue_repair
    ADD CONSTRAINT FOREIGN KEY fk_issue_repair_1 (id_issue)
    REFERENCES issue (id_issue)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE issue_link
    ADD CONSTRAINT FOREIGN KEY fk_issue_link_1 (id_issue)
    REFERENCES issue (id_issue)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE issue_link
    ADD CONSTRAINT FOREIGN KEY fk_issue_link_2 (id_related_issue)
    REFERENCES issue (id_issue)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE issue_tag
    ADD CONSTRAINT FOREIGN KEY fk_issue_tag_1 (id_tag)
    REFERENCES tag (id_tag);
    
ALTER TABLE issue_tag
    ADD CONSTRAINT FOREIGN KEY fk_issue_tag_2 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE media_content
    ADD CONSTRAINT FOREIGN KEY fk_media_content_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_history
    ADD CONSTRAINT FOREIGN KEY fk_issue_history_1 (id_issue)
    REFERENCES issue (id_issue)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE issue_history
    ADD CONSTRAINT FOREIGN KEY fk_issue_history_2 (id_user)
    REFERENCES user (id_user);

ALTER TABLE comment
    ADD CONSTRAINT FOREIGN KEY fk_comment_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE comment
    ADD CONSTRAINT FOREIGN KEY fk_comment_2 (id_user)
    REFERENCES user (id_user);
    
ALTER TABLE issue_vote
    ADD CONSTRAINT FOREIGN KEY fk_issue_vote_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_vote
    ADD CONSTRAINT FOREIGN KEY fk_issue_vote_2 (id_user)
    REFERENCES user (id_user);

ALTER TABLE issue_follow
    ADD CONSTRAINT FOREIGN KEY fk_issue_follow_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_follow
    ADD CONSTRAINT FOREIGN KEY fk_issue_follow_2 (id_user)
    REFERENCES user (id_user);
    
ALTER TABLE issue_pageview
    ADD CONSTRAINT FOREIGN KEY fk_issue_pageview_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_pageview
    ADD CONSTRAINT FOREIGN KEY fk_issue_pageview_2 (id_user)
    REFERENCES user (id_user);

ALTER TABLE issue_verification_request
    ADD CONSTRAINT FOREIGN KEY fk_issue_verification_request_1 (id_issue)
    REFERENCES issue (id_issue); 
    
ALTER TABLE issue_verification_request
    ADD CONSTRAINT FOREIGN KEY fk_issue_verification_request_2 (id_user)
    REFERENCES user (id_user); 
    
    
    
/* ###################################################################################### */
/* ###    DATA                                                                            */
/* ###################################################################################### */
    
    
    
/***** roles *****/
INSERT INTO role (id_role, rolename) 
VALUES 
	(1,'ROLE_ADMIN'),
	(2,'ROLE_USER');

	
/***** users *****/	
INSERT INTO user 
	(username, password, email, first_name, last_name, salt, city_of_residence, province_of_residence, 
	 registration_date, last_password_change_date, last_login_date, closed_account_date, enabled) 
VALUES
	('coripel'    ,'c7589745dd1841655ac79a8f6fbb8e63b01b1e00' ,'coripel@gmail.com'    ,'Cora'  ,'Reyes Calens' , null ,'JUNIN DE LOS ANDES' ,'NEUQUEN'         , curdate(), null, null, null, 1),
	('fakeuser'   ,'20dc925be88e7d0bd130c6c2cf43a77eb344243f' ,'fakeuser@gmail.com'   ,'Juan'  ,'Vasquez'      , null ,'BOULOGNE SUR MER'   ,'BUENOS AIRES'    , curdate(), null, null, null, 1),
	('mock'       ,'3a49a0e2f78aa4d0300177f4588388a21833b0b5' ,'mock@gmail.com'       ,'Julia' ,'Rikiki'       , null ,'MORENO'             ,'BUENOS AIRES'    , curdate(), null, null, null, 1),
	('helloworld' ,'dce876c90f1e39b5a195d468ebbdfb7f192c4c8a' ,'helloworld@gmail.com' ,'Hello' ,'World'        , null ,'BOEDO'              ,'CAPITAL FEDERAL' , curdate(), null, null, null, 1),
	('dummy'      ,'37323501a7840726056e7d2159f2c776482f13ef' ,'dummy@gmail.com'      ,'Dummy' ,'The Dumbest'  , null ,'CABALLITO'          ,'CAPITAL FEDERAL' , curdate(), null, null, null, 1);

	
/***** users & roles *****/	
INSERT INTO user_role (id_user, id_role) VALUES (1,2);
INSERT INTO user_role (id_user, id_role) VALUES (2,2);
INSERT INTO user_role (id_user, id_role) VALUES (3,2);
INSERT INTO user_role (id_user, id_role) VALUES (4,2);
INSERT INTO user_role (id_user, id_role) VALUES (5,2);


/***** tags *****/
INSERT INTO tag (tagname) VALUES ('ACERA');
INSERT INTO tag (tagname) VALUES ('ALUMBRADO');
INSERT INTO tag (tagname) VALUES ('ARBOLADO');
INSERT INTO tag (tagname) VALUES ('ATENCION SOCIAL');
INSERT INTO tag (tagname) VALUES ('COMERCIO');
INSERT INTO tag (tagname) VALUES ('DEMOLICION');
INSERT INTO tag (tagname) VALUES ('ESPACIO VERDE');
INSERT INTO tag (tagname) VALUES ('MAL ESTACIONAMIENTO');
INSERT INTO tag (tagname) VALUES ('MOBILIARIO URBANO');
INSERT INTO tag (tagname) VALUES ('OBRA EN CONSTRUCCION');
INSERT INTO tag (tagname) VALUES ('OTRA');
INSERT INTO tag (tagname) VALUES ('PAVIMENTO');
INSERT INTO tag (tagname) VALUES ('PROTECCION AMBIENTAL');
INSERT INTO tag (tagname) VALUES ('RECUPERADORES');
INSERT INTO tag (tagname) VALUES ('SANEAMIENTO URBANO');
INSERT INTO tag (tagname) VALUES ('SEGURIDAD');
INSERT INTO tag (tagname) VALUES ('TRANSPORTE Y TRANSITO');
INSERT INTO tag (tagname) VALUES ('VILLA');
