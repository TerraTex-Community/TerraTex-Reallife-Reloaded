ALTER TABLE user_gold ADD SkillBooster INT DEFAULT 0 NULL;

ALTER TABLE user ADD Gender VARCHAR(20) DEFAULT "anonym" NULL;

ALTER TABLE user_data ADD children VARCHAR(255) DEFAULT "{}" NULL;

CREATE TABLE `data_crimes_categories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CategorieName` varchar(255) DEFAULT NULL,
  `Order` int(11) DEFAULT '50',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `data_crimes_list` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CategorieID` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Percentage` int(11) DEFAULT '5',
  `MinPercentage` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `data_crimes_list_data_crimes_categories_ID_fk` (`CategorieID`),
  CONSTRAINT `data_crimes_list_data_crimes_categories_ID_fk` FOREIGN KEY (`CategorieID`) REFERENCES `data_crimes_categories` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE log_chat ENGINE=MyISAM;

CREATE TABLE `log_kills` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Attacker` varchar(255) DEFAULT NULL,
  `Target` varchar(255) DEFAULT NULL,
  `AttackerFaction` int(11) DEFAULT NULL,
  `TargetFaction` int(11) DEFAULT NULL,
  `BlacklistOrWantedkill` int(11) DEFAULT '0',
  `WeaponID` int(11) DEFAULT '0',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `user_crimes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(255) DEFAULT NULL,
  `CrimeID` int(11) DEFAULT NULL,
  `CrimePercentage` int(11) DEFAULT NULL,
  `AdditionalReason` text,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ReporterDisplay` varchar(255) DEFAULT NULL,
  `ReporterUser` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_crimes_user_Nickname_fk` (`Nickname`),
  KEY `user_crimes_user_Nickname_fk_2` (`ReporterUser`),
  CONSTRAINT `user_crimes_user_Nickname_fk` FOREIGN KEY (`Nickname`) REFERENCES `user` (`Nickname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_crimes_user_Nickname_fk_2` FOREIGN KEY (`ReporterUser`) REFERENCES `user` (`Nickname`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `data_crimes_categories` (`ID`, `CategorieName`, `Order`) VALUES(1000, 'Admincrimes', 1000);
INSERT INTO `data_crimes_list` (`ID`, `CategorieID`, `Name`, `Percentage`, `MinPercentage`) VALUES(1000, 1000, 'SDM', 50, 50);
INSERT INTO `data_crimes_list` (`ID`, `CategorieID`, `Name`, `Percentage`, `MinPercentage`) VALUES(1001, 1000, 'SDM - Extrem', 100, 100);

ALTER TABLE user_gold
ADD CONSTRAINT user_gold_user_Nickname_fk
FOREIGN KEY (Nickname) REFERENCES user (Nickname) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE user_achievements DROP Erfolg_Rubbellosgluck;
ALTER TABLE user_achievements DROP Erfolg_10erLos;

ALTER TABLE objects_houses_wishes DROP FOREIGN KEY objects_houses_wishes_ibfk_1;
ALTER TABLE objects_houses_wishes
ADD CONSTRAINT objects_houses_wishes_ibfk_1
FOREIGN KEY (Nickname) REFERENCES user (Nickname) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE user_vehicles ADD lastHealth FLOAT DEFAULT 1000 NULL;
ALTER TABLE user_vehicles ADD lastPosition VARCHAR(255) DEFAULT '[[0,0,0,0,0,0,0,0]]' NULL;
ALTER TABLE user_vehicles ADD lastDamageStates VARCHAR(512) DEFAULT '[[]]' NULL;

CREATE TABLE `log_lotto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Number1` int(11) DEFAULT NULL,
  `Number2` int(11) DEFAULT NULL,
  `Number3` int(11) DEFAULT NULL,
  `CorrectNumbers` int(11) DEFAULT 0,
  `Winnerlist` text,
  `winnerPrice` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `log_tow_police` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Owner` varchar(255) DEFAULT NULL,
  `Officer` varchar(255) DEFAULT NULL,
  `CarSlot` int(11) DEFAULT NULL,
  `Reason` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `log_anonym` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `who` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `message` text,
  `factionFrom` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `log_car_deletes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Owner` varchar(255) DEFAULT NULL,
  `SlotId` int(11) DEFAULT NULL,
  `VehicleModel` int(11) DEFAULT NULL,
  `Reason` text,
  `DeletedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `log_car_deletes_user_Nickname_fk` (`Owner`),
  CONSTRAINT `log_car_deletes_user_Nickname_fk` FOREIGN KEY (`Owner`) REFERENCES `user` (`Nickname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE log_playermoney ADD AdditionalData TEXT DEFAULT null NULL;

ALTER TABLE data_crimes_categories ADD hidden INT DEFAULT 0 NULL;

INSERT INTO `objects_businesses` (`ID`, `Name`, `Preis`, `Kasse`, `x`, `y`, `z`) VALUES (NULL, 'Tombupot Lotterie', '150000', '0', '1628.5', '-1171.5', '24.1');
UPDATE `objects_teleport_markers` SET `x` = '1317.09' WHERE `objects_teleport_markers`.`ID` = 40;
INSERT INTO `objects_sprunk` (`ID`, `X`, `Y`, `Z`, `Rot`, `Kommentar`) VALUES (NULL, '-19.084', '-57.047', '1003.547', '180', '24/7 Shop 2');

ALTER TABLE `objects_drivein` ADD `size` FLOAT NOT NULL DEFAULT '4' AFTER `z`;
INSERT INTO `objects_drivein` (`ID`, `x`, `y`, `z`, `size`, `typ`) VALUES (NULL, '1766.60546875', '-1892.126953125', '13', '1', 'pizza');

INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Kleinverbrechen', 100, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Verbrechen im Straßenverkehr', 200, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Transporte / Events / Gruppenverbrechen', 300, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Illegaler Besitz / Handel', 400, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Gewaltverbrechen / Verbrechen mit Waffen', 500, 0);

INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (900, 'Aufenthalt außerhalb von Los Santos ohne Reisepass', 10, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (900, 'Fehlender Personalausweis trotz Ausweispflicht in San Andreas (ab 25 Spielstunden)', 10, 2);

INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Notrufmissbrauch', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Sachbeschädigung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, '(versuchter) Diebstahl', 15, 7);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Ernstzunehmende Drohung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'versuchte Erpressung', 8, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Behinderung von Beamtenarbeit', 8, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Erregung öffentlichen Ärgernisses', 4, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Illegales Straßenrennen', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Flucht aus einer Verkehrskontrolle', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Durchfahren einer Grenze ohne Maut zu Bezahlen', 25, 15);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Fahren eines Waffenmaterialtransportes', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Atommülltransporters', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Geldtransporter', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Alkatraztransport', 60, 30);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Flucht aus einem Alkatraztransport', 100, 50);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Geiselnahme', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenkonsum (mehr als 15g im Blut)', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz bis 50g', 15, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz ab 50g', 30, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz unbekannter Menge (weißes Päckchen)', 30, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenverkauf', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz bis 100 Teile', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz ab 100 Teile', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz unbekannter Menge (klirrender Beutel)', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenverkauf', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Illegale Werbung', 50, 25);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Körperverletzung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Vorsätzliches Tragen von Schusswaffen in der Öffentlichkeit', 15, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Waffennutzung / Beschuss', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Mord', 35, 15);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Mehrfachmord', 45, 25);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Terroranschlag', 80, 50);

SET FOREIGN_KEY_CHECKS=0;
SET GLOBAL FOREIGN_KEY_CHECKS=0;
INSERT INTO `objects_teleport_markers` (`ID`, `x`, `y`, `z`, `interior`, `dimension`, `markerType`, `markerSize`, `toMarker`, `toPosX`, `toPosY`, `toPosZ`, `rzAfterTeleport`, `toInt`, `toDim`, `specialKey`, `description`) VALUES
(59, 1788.37, -1298.52, 12.7, 0, 0, 'corona', 2.0, 60, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Hochhaus neben Glenpark IN'),
(60, 1824.51, -1300.54, 119.734, 0, 0, 'corona', 2.0, 59, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Hochhaus neben Glenpark OUT');
SET FOREIGN_KEY_CHECKS=1;
SET GLOBAL FOREIGN_KEY_CHECKS=1;

UPDATE objects_houses SET city = 2 WHERE ID = 18 OR ID = 93;