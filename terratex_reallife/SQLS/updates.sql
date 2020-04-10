ALTER TABLE `faction_names` ADD `NumberPlate` VARCHAR(6) NOT NULL AFTER `Name`;
UPDATE `faction_names` SET `NumberPlate` = 'SAPD' WHERE `faction_names`.`ID` = 1;
UPDATE `faction_names` SET `NumberPlate` = 'GS' WHERE `faction_names`.`ID` = 2;
UPDATE `faction_names` SET `NumberPlate` = 'News' WHERE `faction_names`.`ID` = 3;
UPDATE `faction_names` SET `NumberPlate` = 'Taxi' WHERE `faction_names`.`ID` = 4;
UPDATE `faction_names` SET `NumberPlate` = 'SEK' WHERE `faction_names`.`ID` = 5;
UPDATE `faction_names` SET `NumberPlate` = 'LLS' WHERE `faction_names`.`ID` = 6;
UPDATE `faction_names` SET `NumberPlate` = 'NAME' WHERE `faction_names`.`ID` = 7;
UPDATE `faction_names` SET `NumberPlate` = 'TBA' WHERE `faction_names`.`ID` = 8;
UPDATE `faction_names` SET `NumberPlate` = 'LVPD' WHERE `faction_names`.`ID` = 9;
UPDATE `faction_names` SET `NumberPlate` = 'SAM' WHERE `faction_names`.`ID` = 10;
UPDATE `faction_names` SET `NumberPlate` = 'CF' WHERE `faction_names`.`ID` = 11;
UPDATE `faction_names` SET `NumberPlate` = 'PP' WHERE `faction_names`.`ID` = 12;
UPDATE `faction_names` SET `NumberPlate` = 'SR' WHERE `faction_names`.`ID` = 13;


ALTER TABLE `user` CHANGE `werber` `werber` TEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL;
ALTER TABLE `user` CHANGE `werber` `werber` VARCHAR(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;
UPDATE user SET werber = null;
ALTER TABLE `user` ADD CONSTRAINT `werberToNickname` FOREIGN KEY (`werber`) REFERENCES `user`(`Nickname`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `user_gold` ADD `CoronaSkillBooster` INT NOT NULL DEFAULT '0';
ALTER TABLE `user_gold` ADD `CoronaMoneyBooster` INT NOT NULL DEFAULT '0';
ALTER TABLE `user_gold` ADD `HufeisenfinderImprover` INT NOT NULL DEFAULT '0';
