/*  Script by Cora Reyes Calens              */ 	 				     
/*  Done for UrbanusJam!		             */						 
/*  Contact:     			                 */
/*			urbanusjam@gmail.com             */				 
/*    		coripel@gmail.com				 */	 
/*  Copyright Fixeala - 2013	             */
/*  Created:  08-10-2013 (dd-MM-YYYY)        */
		

	--DROP DATABASE IF EXISTS fixeala;
	--CREATE DATABASE fixeala;
USE fixeala;


-- AREA
CREATE TABLE area ( 
	   id_area BIGINT(20) NOT NULL AUTO_INCREMENT,
	   name VARCHAR(255) NULL,
	   acronym VARCHAR(15) NULL,
	   city VARCHAR(255) NULL,
	   city_acronym VARCHAR(2) NULL,
	   province VARCHAR(15) NULL,
	   province_acronym VARCHAR(2) NULL,
	   
	   PRIMARY KEY (id_area)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- USER 	
CREATE TABLE user ( 
	   id_user BIGINT(20) NOT NULL AUTO_INCREMENT,
	   username VARCHAR(50) NOT NULL,
	   password VARCHAR(50) NULL,    
	   email VARCHAR(255) NOT NULL,
	   name VARCHAR(255) NULL,
	   last_name VARCHAR(255) NULL,
	   place_of_residence VARCHAR(64) NULL,  /* <neighborhood>, <city>, <province> */
	   salt VARCHAR(25) NULL,	
	   id_area BIGINT(20) NULL,
	   gov_position VARCHAR(255) NULL,
	   gov_sub_area VARCHAR(255) NULL,
	   gov_sub_area_acronym VARCHAR(15) NULL,
	   is_area TINYINT(1) NULL,
	   is_verified_official TINYINT(1) NULL,
	   registration_date DATETIME NULL,     
	   last_password_change_date DATETIME NULL,    	   
	   last_login_date DATETIME NULL,   
	   close_account_date DATETIME NULL,   	   
	   enabled TINYINT(1) NOT NULL,		
	   
	   PRIMARY KEY (id_user),
	   UNIQUE KEY (email, username),
	   FOREIGN KEY (id_area) REFERENCES area (id_area)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- AUTHORITY
CREATE TABLE role (
	   id_role BIGINT(20) NOT NULL AUTO_INCREMENT,
	   rolename VARCHAR(50) NOT NULL,
		
	   PRIMARY KEY (id_role)	
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- USER_AUTHORITY
CREATE TABLE user_role (
	   id_user BIGINT(20) NOT NULL,
	   id_role VARCHAR(50) NOT NULL,		
	   
	   PRIMARY KEY (id_user, id_role),
	   FOREIGN KEY (id_user) REFERENCES user (id_user)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ACTIVATION
CREATE TABLE activation ( 
	   token VARCHAR(126) NOT NULL,
	   username VARCHAR(50) NOT NULL,		  
	   creation_date DATETIME NOT NULL,
	   expiration_date DATETIME NOT NULL,
						
	   PRIMARY KEY (token),
	   UNIQUE KEY (username)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE
CREATE TABLE issue (
	   id_issue BIGINT(20) NOT NULL, 
	   id_reporter BIGINT(20) NOT NULL,
	   id_assigned_official BIGINT(20) NULL,
	   id_area BIGINT(20) NULL,
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
	   status VARCHAR(30) NOT NULL, 
	   priority VARCHAR(30) NOT NULL, 
	   
	   PRIMARY KEY (id_issue),
	   FOREIGN KEY (id_reporter) REFERENCES user (id_user),
	   FOREIGN KEY (id_assigned_official) REFERENCES user (id_user),
	   FOREIGN KEY (id_area) REFERENCES area (id_area)

	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE LICITACION	
CREATE TABLE issue_licitacion ( 	  
	   id_issue BIGINT(20) NOT NULL, 	
	   nro_licitacion VARCHAR(20) NULL, 
	   nro_expediente VARCHAR(20) NULL, 	
	   objeto VARCHAR (600) NULL, 
	   tipo VARCHAR(20) NULL,  	
	   valor_pliego FLOAT(20) NULL,
	   documentacion_pliego VARCHAR(255) NULL,	
	   unidad_ejecutora VARCHAR (255) NULL, 
	   unidad_financiamiento VARCHAR (255) NULL, 
	   empresa_constructora_nombre VARCHAR (255) NULL, 
	   empresa_constructora_cuit BIGINT (30) NULL, 
	   empresa_constructora_email VARCHAR (255) NULL, 
	   representante_tecnico_nombre VARCHAR (255) NULL, 
	   representante_tecnico_dni BIGINT (30) NULL, 
	   representante_tecnico_email VARCHAR (255) NULL, 
	   plazo_ejecucion INT(10) NULL, 
	   presupuesto_adjudicado FLOAT (20) NULL,
	   presupuesto_final FLOAT (20) NULL,
	   fecha_estimada_inicio DATETIME NULL,
	   fecha_estimada_fin DATETIME NULL,
	   fecha_real_inicio DATETIME NULL,
	   fecha_real_fin DATETIME NULL,
	   stauts_obra VARCHAR(30) NULL,  
	   
	   KEY(id_issue),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue) ON DELETE CASCADE ON UPDATE CASCADE
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	


-- TAG
CREATE TABLE tag (
	   id_tag BIGINT(20) NOT NULL AUTO_INCREMENT,
	   tagname VARCHAR (50) NOT NULL,
	   
	   PRIMARY KEY (id_tag)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE_TAG
CREATE TABLE issue_tag (
	   id_issue BIGINT(20) NOT NULL,
	   id_tag BIGINT(20) NOT NULL,		   
	   
	   PRIMARY KEY (id_tag, id_issue),
	   FOREIGN KEY (id_tag) REFERENCES tag (id_tag),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- CONTENIDO
CREATE TABLE content ( 
	   id_content BIGINT(20) NOT NULL AUTO_INCREMENT,
	   id_issue BIGINT(20) NOT NULL,	   
	   height BIGINT(22) NOT NULL,
	   width BIGINT(22) NOT NULL,
	   filename VARCHAR(255) NOT NULL,
	   filename_extension VARCHAR(255) NOT NULL,	
	   filename_with_extension VARCHAR(255) NOT NULL,
	   relative_path VARCHAR(255) NOT NULL,		  
	   upload_date DATETIME NULL,
	   file_order INT(10) NOT NULL,
	   is_profile_pic TINYINT(1) NOT NULL,
	   
	   PRIMARY KEY (id_content),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- PASSWORD CHANGE REQUEST 
CREATE TABLE password_change_request ( 
	   token VARCHAR(126) NOT NULL,
	   username VARCHAR(50) NOT NULL,		  
	   creation_date DATETIME NOT NULL,
	   expiration_date DATETIME NOT NULL,
				
	   PRIMARY KEY (token)
	  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- PERSISTENT LOGIN (REMEMBER ME)
CREATE TABLE persistent_logins(
	   username VARCHAR(50) NULL,
	   series VARCHAR(64) NULL,
	   token VARCHAR(64) NULL,
	   last_used TIMESTAMP NULL,		      
	   
	   PRIMARY KEY (series)
	 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ISSUE HISTORIAL REVISION
CREATE TABLE issue_update_history ( 	  
	   id_issue_history BIGINT(20) NOT NULL AUTO_INCREMENT, 	   
	   id_issue BIGINT(20) NOT NULL, 	   
	   id_user BIGINT(20) NOT NULL,	   
	   update_date DATETIME NOT NULL,    	   
	   status VARCHAR(30) NOT NULL, 	    
	   operation_type VARCHAR(1) NOT NULL,
	   motive VARCHAR(255) NOT NULL, 	
	   observations VARCHAR(500) NULL,  
	   modified_fields VARCHAR(255) NULL, 
	   
	   PRIMARY KEY(id_issue_history),
	   KEY(id_issue),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue) ON DELETE CASCADE ON UPDATE CASCADE,
	   FOREIGN KEY (id_user) REFERENCES user (id_user)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	


-- COMMENT			
CREATE TABLE comment ( 	  
	   id_comment BIGINT(20) NOT NULL AUTO_INCREMENT,    
	   id_issue BIGINT(20) NOT NULL, 
	   id_user BIGINT(20) NOT NULL,	   
	   creation_date DATETIME NULL,    	   
	   message VARCHAR(300) NOT NULL,		 
	   flag TINYINT(1) NOT NULL,
	   
	   PRIMARY KEY(id_comment),
	   FOREIGN KEY (id_issue) REFERENCES issue (id_issue),
	   FOREIGN KEY (id_user) REFERENCES user (id_user)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


-- COMMENT_VOTE
CREATE TABLE comment_vote (	
	   id_comment BIGINT(20) NOT NULL,
	   id_user BIGINT(20) NOT NULL,	 
	   vote SMALLINT NOT NULL CHECK ("VOTE" = 1 OR "VOTE" = -1),
	   vote_date DATETIME NOT NULL,
	   
	   PRIMARY KEY (id_comment, id_user),
	   FOREIGN KEY (id_comment) REFERENCES comment (id_comment),
	   FOREIGN KEY (id_user) REFERENCES user (id_user)	  
	   
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
