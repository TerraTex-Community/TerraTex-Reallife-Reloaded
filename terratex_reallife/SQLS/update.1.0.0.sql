CREATE TABLE `objects_teleport_markers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `interior` int(11) DEFAULT 0,
  `dimension` int(11) DEFAULT 0,
  `markerType` varchar(255) DEFAULT 'corona',
  `markerSize` decimal(10,1) DEFAULT '2.0',
  `toMarker` int(11) DEFAULT NULL,
  `toPosX` int(11) DEFAULT NULL,
  `toPosY` int(11) DEFAULT NULL,
  `toPosZ` int(11) DEFAULT NULL,
  `rzAfterTeleport` int(11) DEFAULT NULL,
  `toInt` int(11) NOT NULL DEFAULT 0,
  `toDim` int(11) NOT NULL DEFAULT 0,
  `specialKey` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`ID`),
  KEY `objects_teleport_markers_objects_teleport_markers_ID_fk` (`toMarker`),
  KEY `objects_teleport_markers_specialKey_index` (`specialKey`),
  CONSTRAINT `objects_teleport_markers_objects_teleport_markers_ID_fk` FOREIGN KEY (`toMarker`) REFERENCES `objects_teleport_markers` (`ID`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


TRUNCATE TABLE objects_teleport_markers;
SET FOREIGN_KEY_CHECKS=0;
SET GLOBAL FOREIGN_KEY_CHECKS=0;
INSERT IGNORE INTO objects_teleport_markers (ID, `x`, `y`, z, interior, `dimension`, markerType, markerSize, toMarker, toPosX, toPosY, toPosZ, rzAfterTeleport, toInt, toDim, specialKey, description) VALUES
(1, 1554.61, -1675.61, 16.1953, 0, 0, 'corona', '2.0', 2, NULL, NULL, NULL, NULL, 10, 0, NULL, 'LSPD outside'),
(2, 246.59, 107.791, 1002.19, 10, 0, 'corona', '2.0', 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LSPD Main Entrance'),
(3, 1368.45, -1279.84, 13.5469, 0, 0, 'corona', '2.0', 4, NULL, NULL, NULL, NULL, 7, 0, 'ammonation', 'Ammonation LS Outside'),
(4, 316.012, -143.652, 999.602, 7, 0, 'corona', '2.0', 3, NULL, NULL, NULL, NULL, 0, 0, 'ammonation', 'Ammonation LS Inside'),
(5, 2556.97, 2065.31, 11.0995, 0, 0, 'corona', '2.0', 6, NULL, NULL, NULL, NULL, 7, 1, 'ammonation', 'Ammonation LV Outside'),
(6, 316.012, -143.652, 999.602, 7, 1, 'corona', '2.0', 5, NULL, NULL, NULL, NULL, 0, 0, 'ammonation', 'Ammonation LV Inside'),
(7, 1567.8, -1333.49, 16.4844, 0, 0, 'corona', '2.0', 8, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Startower floor'),
(8, 1548.71, -1363.74, 326.218, 0, 0, 'corona', '2.0', 7, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Startower roof'),
(9, 1381.41, -1088.75, 27.4493, 0, 0, 'corona', '2.0', 10, NULL, NULL, NULL, NULL, 1, 0, NULL, 'Bank outside'),
(10, 1542.05, 1694.66, 8373.98, 1, 0, 'corona', '2.0', 9, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Bank Inside'),
(11, 1480.88, -1770.94, 18.7958, 0, 0, 'corona', '2.0', 12, NULL, NULL, NULL, NULL, 3, 0, NULL, 'Stadthalle outside'),
(12, 390.094, 173.843, 1007.36, 3, 0, 'corona', '2.0', 11, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Stadthalle Inside'),
(13, 2196.2, 1677.27, 12.3672, 0, 0, 'corona', '2.0', 14, NULL, NULL, NULL, NULL, 1, 0, NULL, 'Casino Outside'),
(14, 2233.67, 1713.81, 1012.25, 1, 0, 'corona', '2.0', 13, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Casino Inside'),
(15, 2495.4, -1690.55, 14.7656, 0, 0, 'corona', '2.0', 16, NULL, NULL, NULL, NULL, 3, 0, NULL, 'Grove Outside'),
(16, 2495.99, -1692.27, 1014.39, 3, 0, 'corona', '2.0', 15, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Grove Inside'),
(17, 2166.39, -1671.76, 15.0742, 0, 0, 'corona', '2.0', 18, NULL, NULL, NULL, NULL, 5, 0, NULL, 'Drughouse LS'),
(18, 318.916, 1114.88, 1083.88, 5, 0, 'corona', '2.0', 17, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Drughouse Inside LS'),
(19, 1568.6, -1690.06, 6.21875, 0, 0, 'corona', '2.0', 20, NULL, NULL, NULL, NULL, 10, 0, NULL, 'LSPD Garage'),
(20, 228.83, 114.55, 999.016, 10, 0, 'corona', '2.0', 19, NULL, NULL, NULL, NULL, 0, 0, 'onlypolice', 'LSPD Knast to Garage'),
(21, 1836.73, -1682.91, 13.3359, 0, 0, 'corona', '2.0', 22, NULL, NULL, NULL, NULL, 17, 0, NULL, 'Alhambra Outside'),
(22, 493.173, -24.3262, 1000.68, 17, 0, 'corona', '2.0', 21, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Alhambra Inside'),
(23, 2310.22, -1643.67, 14.827, 0, 0, 'corona', '2.0', 24, NULL, NULL, NULL, NULL, 11, 0, NULL, 'Ten Green Bottles Outside'),
(24, 501.889, -68.2734, 998.758, 11, 0, 'corona', '2.0', 23, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Ten Green Bottles Inside'),
(25, 2421.47, -1219.57, 25.5407, 0, 0, 'corona', '2.0', 26, NULL, NULL, NULL, NULL, 2, 0, NULL, 'Pig Pen Outside'),
(26, 1204.82, -13.6611, 1000.92, 2, 0, 'corona', '2.0', 25, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Pig Pen Inside'),
(27, 2233.33, -1333.35, 23.9816, 0, 0, 'corona', '2.0', 28, NULL, NULL, NULL, NULL, 2, 0, NULL, 'Church Outside'),
(28, 2534.18, -1232.58, 21163.9, 2, 0, 'corona', '2.0', 27, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Church Inside'),
(29, 1591.57, 1784.56, 30.9546, 0, 0, 'corona', '2.0', 30, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Medic Base Floor'),
(30, 1585.03, 1796.75, 10.8203, 0, 0, 'corona', '2.0', 29, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Medic Base Roof'),
(31, 1631.83, -1172.67, 24.08, 0, 0, 'corona', '2.0', 32, NULL, NULL, NULL, NULL, 3, 0, NULL, 'Tombupot Los Santos Outside '),
(32, 834.35, 7.38, 1004.19, 3, 0, 'corona', '2.0', 31, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Tombupot Los Santos Inside'),
(33, 2202.06, 2124.66, 10.82, 0, 0, 'corona', '2.0', 34, NULL, NULL, NULL, NULL, 1, 0, NULL, 'Tombupot Las Venturas Outside'),
(34, -2158.64, 642.89, 1052.38, 1, 0, 'corona', '2.0', 33, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Tombupot Las Venturas Inside'),
(35, 2069.43, -1411.21, 48.5263, 0, 0, 'corona', '2.0', 36, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Medic Base Los Santos Floor'),
(36, 2034.18, -1401.67, 17.2949, 0, 0, 'corona', '2.0', 35, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Medic Base Los Santos Roof'),
(37, 3409.6, 88.8281, 17.2312, 0, 0, 'corona', '2.0', 38, NULL, NULL, NULL, NULL, 2, 0, NULL, 'Alkatraz Outside'),
(38, 3448.47, 98.3437, 700.969, 2, 0, 'corona', '2.0', 37, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Alkatraz Inside'),
(39, 1290.81, -1160.44, 23.961, 0, 0, 'corona', '2.0', 40, NULL, NULL, NULL, NULL, 1, 0, NULL, 'Cinema entrance 1 Outside'),
(40, 1316.09, -1683.29, 1482.05, 1, 0, 'corona', '2.0', 39, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Cinema entrance 1 Inside'),
(41, 1283.78, -1160.44, 23.961, 0, 0, 'corona', '2.0', 42, NULL, NULL, NULL, NULL, 1, 0, NULL, 'Cinema Entrance 2 Outside'),
(42, 1317.09, -1688.93, 1482.05, 1, 0, 'corona', '2.0', 41, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Cinema entrance 2 Inside'),
(43, -2624.59, 1412.75, 7.09375, 0, 0, 'corona', '2.0', 44, NULL, NULL, NULL, NULL, 3, 0, NULL, 'jizzy floor outside'),
(44, -2636.68, 1402.46, 906.461, 3, 0, 'corona', '2.0', 43, NULL, NULL, NULL, NULL, 0, 0, NULL, 'jizzy floor inside'),
(45, -2660.63, 1421.27, 23.8984, 0, 0, 'corona', '2.0', 46, NULL, NULL, NULL, NULL, 3, 0, NULL, 'jizzy roof outside'),
(46, -2660.89, 1417.67, 922.195, 3, 0, 'corona', '2.0', 45, NULL, NULL, NULL, NULL, 0, 0, NULL, 'jizzy roof inside'),
(47, 2193.17, -1151.27, 33.524, 0, 0, 'corona', '2.0', 48, NULL, NULL, NULL, NULL, 15, 0, NULL, 'Jefferson Motel E1 outside'),
(48, 2193.32, -1147.67, 1033.8, 15, 0, 'corona', '2.0', 47, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Jefferson Motel E1 Inside'),
(49, 2233.11, -1159.67, 25.8906, 0, 0, 'corona', '2.0', 50, NULL, NULL, NULL, NULL, 15, 0, NULL, 'Jefferson Motel E2 Outside'),
(50, 2214.38, -1150.53, 1025.8, 15, 0, 'corona', '2.0', 49, NULL, NULL, NULL, NULL, 0, 0, NULL, 'Jefferson Motel E2 Inside'),
(51, 2289.95, 2431.62, 10.8203, 0, 0, 'corona', '2.0', 52, NULL, NULL, NULL, NULL, 3, 0, NULL, 'LVPD E1 Outside'),
(52, 238.79, 138.633, 1003.02, 3, 0, 'corona', '2.0', 51, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LVPD E1 Inside'),
(53, 2339.85, 2458.2, 14.9688, 0, 0, 'corona', '2.0', 54, NULL, NULL, NULL, NULL, 3, 0, NULL, 'LVPD E2 Outside'),
(54, 288.849, 166.921, 1007.17, 3, 0, 'corona', '2.0', 53, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LVPD E2 Inside'),
(55, 2268, 2449.29, 3.53125, 0, 0, 'corona', '2.0', 56, NULL, NULL, NULL, NULL, 3, 0, NULL, 'LVPD Garage to Knast'),
(56, 196.204, 168.799, 1003.02, 3, 0, 'corona', '2.0', 55, NULL, NULL, NULL, NULL, 0, 0, 'onlypolice', 'LVPD Knast to Garage'),
(57, 2252.5, 2452.4, 39.1546, 0, 0, 'corona', '2.0', 58, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LVPD Garage to Roof'),
(58, 2297.12, 2468.81, 10.8203, 0, 0, 'corona', '2.0', 57, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LVPD Roof to Garage');
SET FOREIGN_KEY_CHECKS=1;
SET GLOBAL FOREIGN_KEY_CHECKS=1;