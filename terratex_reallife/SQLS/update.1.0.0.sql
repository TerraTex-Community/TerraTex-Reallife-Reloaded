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
  `toInt` int(11) DEFAULT NULL,
  `toDim` int(11) DEFAULT NULL,
  `specialKey` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`ID`),
  KEY `objects_teleport_markers_objects_teleport_markers_ID_fk` (`toMarker`),
  KEY `objects_teleport_markers_specialKey_index` (`specialKey`),
  CONSTRAINT `objects_teleport_markers_objects_teleport_markers_ID_fk` FOREIGN KEY (`toMarker`) REFERENCES `objects_teleport_markers` (`ID`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `objects_teleport_markers` (`ID`, `x`, `y`, `z`, `interior`, `dimension`, `markerType`, `markerSize`, `toMarker`, `toPosX`, `toPosY`, `toPosZ`, `rzAfterTeleport`, `toInt`, `toDim`, `specialKey`, `description`) VALUES
(1, 1554.61, -1675.61, 16.1953, 0, 0, 'corona', '2.0', 2, NULL, NULL, NULL, NULL, 10, 0, NULL, 'LSPD outside Main Entrance'),
(2, 246.59, 107.791, 1002.19, 10, 0, 'corona', '2.0', 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 'LSPD Main Entrance');