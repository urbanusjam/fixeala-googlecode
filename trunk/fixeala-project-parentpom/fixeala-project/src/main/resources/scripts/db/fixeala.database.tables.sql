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


CREATE TABLE area ( 
	   id_area BIGINT(20) NOT NULL AUTO_INCREMENT,
	   area_name VARCHAR(255) NULL,
	   acronym VARCHAR(15) NULL,
	   city VARCHAR(255) NULL,
	   city_acronym VARCHAR(2) NULL,
	   province VARCHAR(15) NULL,
	   province_acronym VARCHAR(2) NULL,
	   
	   PRIMARY KEY (id_area),
	   UNIQUE KEY (area_name)
	   
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
	   
	   PRIMARY KEY (id_content)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
	   priority VARCHAR(64) NULL, 
	   resolution_type VARCHAR(64) NULL, 	
	   status VARCHAR(64) NOT NULL,
	   
	   PRIMARY KEY (id_issue)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_follow (	 	
	   id_issue BIGINT(20) NOT NULL,
	   id_follower BIGINT(20) NOT NULL,	 
	   follow_date DATETIME NOT NULL,
	   	  
	   PRIMARY KEY (id_issue, id_follower)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE issue_repair ( 	  
	   id_issue BIGINT(20) NOT NULL, 	
	   nro_licitacion VARCHAR(20) NULL, 
	   nro_expediente VARCHAR(20) NULL, 	
	   tipo VARCHAR(20) NULL,  	
	   descripcion VARCHAR (600) NULL, 	  
	   valor_pliego FLOAT(20) NULL,
	   unidad_ejecutora VARCHAR (255) NULL, 
	   unidad_financiamiento VARCHAR (255) NULL, 
	   empresa_contratada_nombre VARCHAR (255) NULL, 
	   empresa_contratada_cuit BIGINT (30) NULL, 	 
	   representante_tecnico_nombre VARCHAR (255) NULL, 
	   representante_tecnico_dni BIGINT (30) NULL, 	 
	   plazo_ejecucion_en_dias INT(10) NULL, 
	   presupuesto_adjudicado FLOAT (20) NULL,
	   presupuesto_final FLOAT (20) NULL,
	   fecha_estimada_inicio DATETIME NULL,
	   fecha_estimada_fin DATETIME NULL,
	   fecha_real_inicio DATETIME NULL,
	   fecha_real_fin DATETIME NULL,
	   estado_obra VARCHAR(30) NULL,  
	   
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


CREATE TABLE issue_update_history ( 	  
	   id_issue_update_history BIGINT(20) NOT NULL AUTO_INCREMENT, 	   
	   id_issue BIGINT(20) NOT NULL, 	   
	   id_user BIGINT(20) NOT NULL,	   
	   update_date DATETIME NOT NULL,    	   
	   status VARCHAR(30) NOT NULL, 	    
	   operation VARCHAR(1) NOT NULL,
	   user_action VARCHAR(255) NOT NULL, 	
	   observations VARCHAR(500) NULL,  
	   modified_fields VARCHAR(255) NULL, 
	   
	   PRIMARY KEY(id_issue_update_history),
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
	   id_voter BIGINT(20) NOT NULL,	 
	   vote SMALLINT NOT NULL CHECK ("VOTE" = 1 OR "VOTE" = -1),
	   vote_date DATETIME NOT NULL,
	   	   
	   PRIMARY KEY (id_issue, id_voter) 
	   
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
	   
	   PRIMARY KEY (id_tag)
	   
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	


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
	   is_area TINYINT(1) NOT NULL,
	   is_verified_official TINYINT(1) NOT NULL,
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


ALTER TABLE user
    ADD CONSTRAINT FOREIGN KEY fk_user_1 (id_area)
    REFERENCES area (id_area);
        
ALTER TABLE user_role
    ADD CONSTRAINT FOREIGN KEY fk_user_role_1 (id_user)
    REFERENCES user (id_user);
    
ALTER TABLE issue
    ADD CONSTRAINT FOREIGN KEY fk_issue_1 (id_reporter)
    REFERENCES user (id_user);
    
ALTER TABLE issue
    ADD CONSTRAINT FOREIGN KEY fk_issue_2 (id_assigned_official)
    REFERENCES user (id_user);
    
ALTER TABLE issue
    ADD CONSTRAINT FOREIGN KEY fk_issue_3 (id_area)
    REFERENCES area (id_area);
    
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
    
ALTER TABLE content
    ADD CONSTRAINT FOREIGN KEY fk_content_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_update_history
    ADD CONSTRAINT FOREIGN KEY fk_issue_update_history_1 (id_issue)
    REFERENCES issue (id_issue)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE issue_update_history
    ADD CONSTRAINT FOREIGN KEY fk_issue_update_history_2 (id_user)
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
    ADD CONSTRAINT FOREIGN KEY fk_issue_vote_2 (id_voter)
    REFERENCES user (id_user);

ALTER TABLE issue_follow
    ADD CONSTRAINT FOREIGN KEY fk_issue_follow_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_follow
    ADD CONSTRAINT FOREIGN KEY fk_issue_follow_2 (id_follower)
    REFERENCES user (id_user);
    
ALTER TABLE issue_pageview
    ADD CONSTRAINT FOREIGN KEY fk_issue_pageview_1 (id_issue)
    REFERENCES issue (id_issue);
    
ALTER TABLE issue_pageview
    ADD CONSTRAINT FOREIGN KEY fk_issue_pageview_2 (id_user)
    REFERENCES user (id_user);

