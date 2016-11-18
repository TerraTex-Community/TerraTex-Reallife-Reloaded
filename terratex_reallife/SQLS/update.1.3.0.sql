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

CREATE TABLE `objects_fuel_stations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GasPumps` varchar(1024) DEFAULT '[[]]',
  `Price` decimal(3,0) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -94.0146484375, "y":-1175.1796875, "z":1.9937258958817, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -100.0068359375, "y":-1172.4462890625, "z":2.1999135017395, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -2244.3984375, "y":-2561.1142578125, "z":31.648958206177, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -2029.322265625, "y":157.6513671875, "z":28.563018798828, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1466.109375, "y":1863.4296875, "z":32.36164855957, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1674.6298828125, "y":404.2578125, "z":7.1708655357361, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 70.408203125, "y":1218.744140625, "z":18.53918838501, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 2145.826171875, "y":2750.6884765625, "z":10.547393798828, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 2638.873046875, "y":1104.259765625, "z":10.543460845947, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 2115.998046875, "y":922.5361328125, "z":10.547393798828, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1594.5703125, "y":2206.6318359375, "z":10.547393798828, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1485.7421875, "y":-2425.939453125, "z":13.5546875, "size":6}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 658.2744140625, "y":-560.224609375, "z":16.063018798828, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1005.279296875, "y":-933.251953125, "z":41.1796875, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1938.9326171875, "y":-1773.38671875, "z":12.3828125, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 2311.5166015625, "y":-2420.005859375, "z":-0.26488932967186, "size":6}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 2199.6396484375, "y":2474.56640625, "z":10.8203125, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1114.0859375, "y":-174.078125, "z":14.24893283844, "size":6}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1638.0517578125, "y":554.4462890625, "z":-0.74756044149399, "size":6}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1300.533203125, "y":1436.0380859375, "z":10.910797119141, "size":6}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 300.2060546875, "y":2065.2939453125, "z":17.640625, "size":3}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 1643.57, "y":83.45, "z":36.1, "size":2}, {"x" : 1642.3, "y":77.95, "z":36.1, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1609.7587890625, "y":-2718.27734375, "z":48.266124725342, "size":2},{"x" : -1603.6376953125, "y":-2709.052734375, "z":48.261840820312, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -2414.8896484375, "y":975.119140625, "z":45.023956298828, "size":2},{"x" : -2406.9833984375, "y":971.8740234375, "z":45.02632522583, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1674.1083984375, "y":418.0009765625, "z":7.1729331016541, "size":2},{"x" : -1674.6298828125, "y":404.2578125, "z":7.1708655357361, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : 621.5537109375, "y":1679.708984375, "z":6.7192716598511, "size":2},{"x" : 609.0615234375, "y":1699.529296875, "z":6.7210984230042, "size":2},{"x" : 615.46875, "y":1690.236328125, "z":6.7192645072937, "size":2}]]', 5);
INSERT INTO objects_fuel_stations (GasPumps, Price) VALUES ('[[{"x" : -1329.486328125, "y":2671.9453125, "z":49.789577484131, "size":2},{"x" : -1327.01953125, "y":2682.8017578125, "z":49.789585113525, "size":2}]]', 5);

ALTER TABLE objects_businesses ADD PaidUntil INT DEFAULT 0 NULL;
