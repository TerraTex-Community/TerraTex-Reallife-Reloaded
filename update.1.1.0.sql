CREATE TABLE `user_gold` (
  `Nickname` varchar(255) NOT NULL,
  `Gold` int(11) DEFAULT '0',
  `FoodBooster` int(11) DEFAULT '0',
  `HufeisenBooster` int(11) DEFAULT '0',
  `FuelBooster` int(11) DEFAULT '0',
  PRIMARY KEY (`Nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE user_licenses ADD industrialFishingLic INT(1) DEFAULT 0 NULL;