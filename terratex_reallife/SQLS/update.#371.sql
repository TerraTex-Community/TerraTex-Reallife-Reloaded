DROP TABLE faction_shops;

CREATE TABLE `faction_gangfights` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Type` int(11) DEFAULT 0 COMMENT '0-onlyMoney,1-drugs,2-mats',
  `Owner` int(11) DEFAULT -1,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `RSmall` int(11) DEFAULT 20,
  `RLarge` int(11) DEFAULT 100,
  `ASpawnX` float DEFAULT NULL,
  `ASpawnY` float DEFAULT NULL,
  `ASpawnZ` float DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

