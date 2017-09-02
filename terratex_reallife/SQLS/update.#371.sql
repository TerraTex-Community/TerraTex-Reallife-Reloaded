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
  `HoursWithoutAttack` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Hauptammunation LS', 2, -1, 1366.2, -1287.23, 13.5469, 75, 276, 1187.37, -1324.97, 13.5594, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Ammunation Grove Street', 2, -1, 2400.28, -1980.83, 13.5469, 95, 185, 2351.43, -1906.5, 13.5469, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Crackbude ', 1, -1, 2179.8, -1661.5, 14.8945, 79, 272, 2332.08, -1770.15, 13.5564, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Drogenversteck am Glenpark', 1, -1, 1809.57, -1170, 23.8281, 71, 312, 1872.05, -1372.02, 13.5334, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Ammunation am Come-A-Lot', 2, -1, 2158.5, 943.379, 10.8203, 108, 396, 2284.13, 1200.71, 10.8203, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Hauptammunation LV', 2, -1, 2538.39, 2082.63, 10.8203, 112, 265, 2572.88, 2258.19, 10.8133, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Drogenversteck Süd LV', 1, -1, 2425.37, 1899.14, 6.01562, 198, 456, 2596.58, 1726.8, 10.3833, 0);
INSERT INTO faction_gangfights (Name, Type, Owner, X, Y, Z, RSmall, RLarge, ASpawnX, ASpawnY, ASpawnZ, HoursWithoutAttack) VALUES ('Drogenversteck Nord LV', 1, -1, 2647.27, 828.799, 8.82031, 135, 398, 2632.43, 1079.42, 10.8203, 0);
