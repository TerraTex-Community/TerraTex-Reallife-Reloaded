ALTER TABLE `objects_drivein` ADD `size` FLOAT NOT NULL DEFAULT '4' AFTER `z`;
INSERT INTO `objects_drivein` (`ID`, `x`, `y`, `z`, `size`, `typ`) VALUES (NULL, '1766.60546875', '-1892.126953125', '13', '1', 'pizza');
