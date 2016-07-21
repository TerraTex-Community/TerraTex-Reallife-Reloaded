ALTER TABLE user_gold ADD SkillBooster INT DEFAULT 0 NULL;

ALTER TABLE user ADD Gender VARCHAR(20) DEFAULT "anonym" NULL;

ALTER TABLE user_data ADD children VARCHAR(255) DEFAULT "{}" NULL;

CREATE TABLE `data_crimes_categories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CategorieName` varchar(255) DEFAULT NULL,
  `Order` int(11) DEFAULT '50',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1

CREATE TABLE `data_crimes_list` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CategorieID` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Percentage` int(11) DEFAULT '5',
  `MinPercentage` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `data_crimes_list_data_crimes_categories_ID_fk` (`CategorieID`),
  CONSTRAINT `data_crimes_list_data_crimes_categories_ID_fk` FOREIGN KEY (`CategorieID`) REFERENCES `data_crimes_categories` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1

ALTER TABLE log_chat ENGINE=MyISAM;

CREATE TABLE log_kills
(
    ID INT PRIMARY KEY,
    Attacker VARCHAR(255),
    Target VARCHAR(255),
    AttackerFaction INT,
    TargetFaction INT,
    BlacklistOrWantedkill INT DEFAULT 0,
    WeaponID INT DEFAULT 0,
    Timestamp TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE `user_crimes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(255) DEFAULT NULL,
  `CrimeID` int(11) DEFAULT NULL,
  `CrimePercentage` int(11) DEFAULT NULL,
  `AdditionalReason` text,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `user_crimes_user_Nickname_fk` (`Nickname`),
  CONSTRAINT `user_crimes_user_Nickname_fk` FOREIGN KEY (`Nickname`) REFERENCES `user` (`Nickname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1