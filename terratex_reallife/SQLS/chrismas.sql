CREATE TABLE `data_chrismas` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `data_chrismas_user_Nickname_fk` (`Nickname`),
  CONSTRAINT `data_chrismas_user_Nickname_fk` FOREIGN KEY (`Nickname`) REFERENCES `user` (`Nickname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;