CREATE TABLE IF NOT EXISTS `steuer_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nickname` varchar(250) NOT NULL,
  `Type` varchar(250) NOT NULL,
  `Betrag` int NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

RENAME TABLE steuer_log TO log_steuern;
RENAME TABLE ad_log TO log_ad;
RENAME TABLE beleidigung_log TO log_badword;
RENAME TABLE biz_log TO log_biz;
RENAME TABLE casinolog TO log_casino;
RENAME TABLE chat_log TO log_chat;
RENAME TABLE delstvo TO log_delstvo;
RENAME TABLE fuehrerscheinloose TO log_loosedriverlicense;
RENAME TABLE playermoney_log TO log_playermoney;
RENAME TABLE premium_log TO log_premium;
RENAME TABLE serverwerbung_log TO log_serveradvertising;

DROP TABLE nickchange_log;
DROP TABLE test_log;
