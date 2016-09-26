ALTER TABLE user_data ADD afktime INT DEFAULT 0 NULL;

CREATE TABLE `log_playtime` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(255) DEFAULT NULL,
  `login` timestamp NOT NULL,
  `logout` timestamp NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `log_playtime_user_Nickname_fk` (`Nickname`),
  CONSTRAINT `log_playtime_user_Nickname_fk` FOREIGN KEY (`Nickname`) REFERENCES `user` (`Nickname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE faction_inventory ADD Tanksatz INT DEFAULT 50 NULL;