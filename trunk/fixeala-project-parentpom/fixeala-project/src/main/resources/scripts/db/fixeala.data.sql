/*  Script by Cora Reyes Calens              */ 	 				     
/*  Done for UrbanusJam!		             */						 
/*  Contact:     			                 */
/*			urbanusjam@gmail.com             */				 
/*    		coripel@gmail.com				 */	 
/*  Copyright Fixeala - 2013	             */
/*  Created:  08-10-2013 (dd-MM-YYYY)        */
		

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


INSERT INTO `role` (`ID_ROLE`,`NAME`) VALUES 
(1,'ROLE_ADMIN'),
(2,'ROLE_MANAGER'),
(3,'ROLE_AREA'),
(4,'ROLE_USER');


INSERT INTO `user_role` (`ID_USER`,`ID_ROLE`) VALUES 
(1,1),
(2,1),
(3,2),
(4,4),
(5,4),
(6,3), 
(7,3);


INSERT INTO `area` (`NAME`,`ACRONYM`,`PROVINCE`,`PROVINCE_ACRONYM`,`CITY`,`CITY_ACRONYM`) 
VALUES 
('Comuna 1','C1', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 2','C2', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 3','C3', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 4','C4', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Ministerio de Ambiente y Espacio Publico','MAYEPGC', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA');


INSERT INTO `comment` (`ID_ISSUE`,`ID_USER`, `COMMENT_DATE`, `COMMENT_MESSAGE`, `FLAG`) VALUES
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 6, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false );