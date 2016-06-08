CREATE TABLE IF NOT EXISTS `steuer_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(250) NOT NULL,
  `Type` varchar(250) NOT NULL,
  `Betrag` int NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
