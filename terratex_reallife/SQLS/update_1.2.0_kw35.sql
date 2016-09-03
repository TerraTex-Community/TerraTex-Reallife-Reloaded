INSERT INTO `objects_businesses` (`ID`, `Name`, `Preis`, `Kasse`, `x`, `y`, `z`) VALUES (NULL, 'Tombupot Lotterie', '150000', '0', '1628.5', '-1171.5', '24.1');
UPDATE `objects_teleport_markers` SET `x` = '1317.09' WHERE `objects_teleport_markers`.`ID` = 40;
INSERT INTO `objects_sprunk` (`ID`, `X`, `Y`, `Z`, `Rot`, `Kommentar`) VALUES (NULL, '-19.084', '-57.047', '1003.547', '180', '24/7 Shop 2');

ALTER TABLE `objects_drivein` ADD `size` FLOAT NOT NULL DEFAULT '4' AFTER `z`;
INSERT INTO `objects_drivein` (`ID`, `x`, `y`, `z`, `size`, `typ`) VALUES (NULL, '1766.60546875', '-1892.126953125', '13', '1', 'pizza');