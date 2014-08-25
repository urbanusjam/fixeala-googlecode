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
('coripel','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','coripel@gmail.com','Cora','Reyes Calens',NULL, 5, 'Responsable de area', curdate(), NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('fakeuser','20dc925be88e7d0bd130c6c2cf43a77eb344243f','fakeuser@gmail.com','Juan','Vasquez',NULL, 1, 'Presidente Comunal', curdate(), NULL, NULL,NULL,NULL,NULL,NULL,1,1),
('mock','3a49a0e2f78aa4d0300177f4588388a21833b0b5','mock@gmail.com','Julia','Rikiki', NULL, 1, 'Miembro Junta Comunal', curdate(), NULL, NULL,NULL,NULL,NULL,NULL,0,1),
('helloworld','dce876c90f1e39b5a195d468ebbdfb7f192c4c8a','helloworld@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'San Telmo',curdate(),NULL,NULL,NULL,0,1),
('dummy','37323501a7840726056e7d2159f2c776482f13ef','dummy@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',curdate(),NULL,NULL,NULL,0,1),
('comuna1',NULL,'comuna_uno@buenosaires.gob.ar',NULL,NULL, NULL, 1, 'Area', NULL, NULL, NULL,curdate(),NULL,NULL,NULL,1,1),
('comuna2',NULL,'comuna_dos@buenosaires.gob.ar',NULL,NULL, NULL, 2, 'Area', NULL, NULL, NULL,curdate(),NULL,NULL,NULL,1,1),
('user2','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user2@gmail.com','Cora','Reyes Calens',NULL, 5, 'Responsable de area', NULL, NULL, NULL,curdate(),NULL,NULL,NULL,1,1),
('user3','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user3@gmail.com','Juan','Vasquez',NULL, 1, 'Presidente Comunal', NULL, NULL, NULL,curdate(),NULL,NULL,NULL,1,1),
('user4','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user4@gmail.com','Julia','Rikiki', NULL, 1, 'Miembro Junta Comunal', NULL, NULL, NULL,curdate(),NULL,NULL,NULL,0,1),
('user5','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user5@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'San Telmo',curdate(),NULL,NULL,NULL,0,1),
('user6','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user6@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'La Boca',curdate(),NULL,NULL,NULL,0,1),
('user7','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user7@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',curdate(),NULL,NULL,NULL,0,1),
('user8','c7589745dd1841655ac79a8f6fbb8e63b01b1e00','user8@gmail.com',NULL,NULL, NULL, NULL, NULL, NULL, NULL, 'Caballito',curdate(),NULL,NULL,NULL,0,1);

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

INSERT INTO tag (tagname) VALUES ('ACERA');
INSERT INTO tag (tagname) VALUES ('AEROPUERTO');
INSERT INTO tag (tagname) VALUES ('ALUMBRADO');
INSERT INTO tag (tagname) VALUES ('AMBULANCIA');
INSERT INTO tag (tagname) VALUES ('ARBOLADO');
INSERT INTO tag (tagname) VALUES ('ASCENSOR');
INSERT INTO tag (tagname) VALUES ('ATENCION SOCIAL');
INSERT INTO tag (tagname) VALUES ('AVION / AVIONETA');
INSERT INTO tag (tagname) VALUES ('BACHE');
INSERT INTO tag (tagname) VALUES ('BALCON ');
INSERT INTO tag (tagname) VALUES ('BANCO / CAJERO / ENTIDAD FINANCIERA');
INSERT INTO tag (tagname) VALUES ('BEBIDAS ALCOHOLICAS');
INSERT INTO tag (tagname) VALUES ('BICISENDA');
INSERT INTO tag (tagname) VALUES ('CINE');
INSERT INTO tag (tagname) VALUES ('COLECTIVO');
INSERT INTO tag (tagname) VALUES ('DEMOLICION');
INSERT INTO tag (tagname) VALUES ('DESAGUE');
INSERT INTO tag (tagname) VALUES ('ESCOMBROS');
INSERT INTO tag (tagname) VALUES ('ESPACIO PUBLICO');
INSERT INTO tag (tagname) VALUES ('ESTABLECIMIENTO EDUCATIVO');
INSERT INTO tag (tagname) VALUES ('FARMACIA / PERFUMERIA');
INSERT INTO tag (tagname) VALUES ('GERIATRICO');
INSERT INTO tag (tagname) VALUES ('GUARDERIA / JARDIN DE INFANTES / PREESCOLAR');
INSERT INTO tag (tagname) VALUES ('HOSPITAL');
INSERT INTO tag (tagname) VALUES ('INSTITUTO / ACADEMIA');
INSERT INTO tag (tagname) VALUES ('INUNDACION');
INSERT INTO tag (tagname) VALUES ('LUMINARIA APAGADA / ROTA');
INSERT INTO tag (tagname) VALUES ('MAL ESTACIONAMIENTO');
INSERT INTO tag (tagname) VALUES ('MAMPOSTERIA');
INSERT INTO tag (tagname) VALUES ('MEDIOS (RADIODIFUSORA, CANAL TV, PRODUCTORA)');
INSERT INTO tag (tagname) VALUES ('MICRO');
INSERT INTO tag (tagname) VALUES ('OBRA ABANDONADA ');
INSERT INTO tag (tagname) VALUES ('OBRA EN CONSTRUCCION');
INSERT INTO tag (tagname) VALUES ('OBRA FINALIZADA');
INSERT INTO tag (tagname) VALUES ('PAVIMENTO');
INSERT INTO tag (tagname) VALUES ('PIROTECNIA');
INSERT INTO tag (tagname) VALUES ('PLAYA DE ESTACIONAMIENTO / GARAGE');
INSERT INTO tag (tagname) VALUES ('PLAZA');
INSERT INTO tag (tagname) VALUES ('PLUVIALES');
INSERT INTO tag (tagname) VALUES ('PODA DE RAMAS');
INSERT INTO tag (tagname) VALUES ('POLICIA');
INSERT INTO tag (tagname) VALUES ('PROTECCION AMBIENTAL');
INSERT INTO tag (tagname) VALUES ('PUENTE');
INSERT INTO tag (tagname) VALUES ('RECUPERADORES URBANOS');
INSERT INTO tag (tagname) VALUES ('REMIS');
INSERT INTO tag (tagname) VALUES ('RESIDUOS');
INSERT INTO tag (tagname) VALUES ('SANEAMIENTO URBANO');
INSERT INTO tag (tagname) VALUES ('SEGURIDAD');
INSERT INTO tag (tagname) VALUES ('SEMAFORO');
INSERT INTO tag (tagname) VALUES ('SUBTE');
INSERT INTO tag (tagname) VALUES ('SUMIDERO / ALCANTARILLA ');
INSERT INTO tag (tagname) VALUES ('SUPERMERCADO');
INSERT INTO tag (tagname) VALUES ('TAXI');
INSERT INTO tag (tagname) VALUES ('TEATRO / AUDITORIO');
INSERT INTO tag (tagname) VALUES ('TERMINAL DE COMBIS');
INSERT INTO tag (tagname) VALUES ('TERMINAL DE OMNIBUS');
INSERT INTO tag (tagname) VALUES ('TERRENO BALDIO');
INSERT INTO tag (tagname) VALUES ('TRANSPORTE Y TRANSITO');
INSERT INTO tag (tagname) VALUES ('TREN');
INSERT INTO tag (tagname) VALUES ('VEHICULO ABANDONADO');
INSERT INTO tag (tagname) VALUES ('VEREDA ROTAS');
INSERT INTO tag (tagname) VALUES ('VETERINARIA');
