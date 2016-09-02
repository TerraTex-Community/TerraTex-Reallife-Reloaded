ALTER TABLE `objects_drivein` ADD `size` FLOAT NOT NULL AFTER `z`;
UPDATE `objects_drivein` SET `size`=4;
INSERT INTO `objects_drivein` (`ID`, `x`, `y`, `z`, `size`, `typ`) VALUES (NULL, '1766.60546875', '-1892.126953125', '13', '1', 'pizza');
