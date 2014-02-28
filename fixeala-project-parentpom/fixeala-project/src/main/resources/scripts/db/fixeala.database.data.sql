/*  Script by Cora Reyes Calens              */ 	 				     
/*  Done for UrbanusJam!		             */						 
/*  Contact:     			                 */
/*			urbanusjam@gmail.com             */				 
/*    		coripel@gmail.com				 */	 
/*  Copyright Fixeala - 2013	             */
/*  Created:  08-10-2013 (dd-MM-YYYY)        */


INSERT INTO `area` (`area_name`,`acronym`,`province`,`province_acronym`,`city`,`city_acronym`) 
VALUES 
('Comuna 1','C1', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 2','C2', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 3','C3', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Comuna 4','C4', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA'),
('Ministerio de Ambiente y Espacio Publico','MAYEPGC', 'Buenos Aires', 'BA', 'Ciudad de Buenos Aires', 'CABA');


INSERT INTO `role` (`id_role`,`rolename`) VALUES 
(1,'ROLE_ADMIN'),
(2,'ROLE_MANAGER'),
(3,'ROLE_AREA'),
(4,'ROLE_USER');

-- role_admin
-- role_moderator
-- role_publisher


INSERT INTO `user` 
(`username`,`password`,`email`,`name`, `last_name`,`salt`, `id_area`,`gov_position`,`gov_sub_area`,`gov_sub_area_acronym`,
`place_of_residence`,`registration_date`,`last_password_change_date`,`last_login_date`,`closed_account_date`, `is_verified_official`, `enabled`) 
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


INSERT INTO `user_role` (`id_user`,`id_role`) VALUES 
(1,1),
(2,1),
(3,2),
(4,4),
(5,4),
(6,3), 
(7,3);

/*
INSERT INTO `comment` (`id_issue`,`id_user`, `creation_date`, `message`, `flag`) VALUES
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 4, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 3, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 5, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false ),
(82621, 6, NOW(), 'Aliquam non sodales nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', false );
*/
