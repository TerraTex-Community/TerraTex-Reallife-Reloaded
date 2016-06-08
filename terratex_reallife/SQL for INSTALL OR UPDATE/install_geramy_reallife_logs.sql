-- phpMyAdmin SQL Dump
-- version 4.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 13. Nov 2014 um 18:08
-- Server Version: 10.0.10-MariaDB
-- PHP-Version: 5.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `geramy_reallife_logs`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ad_log`
--

CREATE TABLE IF NOT EXISTS `ad_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Text` longtext NOT NULL,
  `Datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beleidigung_log`
--

CREATE TABLE IF NOT EXISTS `beleidigung_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Message` longtext CHARACTER SET utf8 NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bestraft_per_system` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `biz_log`
--

CREATE TABLE IF NOT EXISTS `biz_log` (
`ID` int(11) NOT NULL,
  `BizID` int(11) NOT NULL,
  `Betrag` int(11) NOT NULL,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `casinolog`
--

CREATE TABLE IF NOT EXISTS `casinolog` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Spiel` varchar(255) NOT NULL,
  `Betrag` int(11) NOT NULL DEFAULT '0',
  `tagesgewinn` int(11) NOT NULL DEFAULT '0',
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `chat_log`
--

CREATE TABLE IF NOT EXISTS `chat_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Message` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MEMORY DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delstvo`
--

CREATE TABLE IF NOT EXISTS `delstvo` (
`ID` int(11) NOT NULL,
  `Wer` varchar(250) NOT NULL,
  `Wieviele` int(11) NOT NULL,
  `Von` varchar(250) NOT NULL,
  `Grund` text NOT NULL,
  `Wann` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fuehrerscheinloose`
--

CREATE TABLE IF NOT EXISTS `fuehrerscheinloose` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Fraktion` int(11) NOT NULL DEFAULT '0',
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `nickchange_log`
--

CREATE TABLE IF NOT EXISTS `nickchange_log` (
`ID` int(11) NOT NULL,
  `FromName` varchar(128) NOT NULL,
  `ToName` varchar(128) NOT NULL,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Admin` varchar(128) DEFAULT NULL,
  `UUID` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `playermoney_log`
--

CREATE TABLE IF NOT EXISTS `playermoney_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(250) NOT NULL,
  `UniqueID` varchar(128) NOT NULL,
  `Typ` enum('Money','Bank') NOT NULL,
  `Kategorie` varchar(250) NOT NULL COMMENT 'Kategorie wird durch Script vorgegeben',
  `Betrag` float NOT NULL,
  `Stand` int(11) NOT NULL DEFAULT '0',
  `Grund` text,
  `GrundZusatz` text,
  `Datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DateStamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `premium_log`
--

CREATE TABLE IF NOT EXISTS `premium_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `how` varchar(255) NOT NULL DEFAULT 'echtgeld'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `serverwerbung_log`
--

CREATE TABLE IF NOT EXISTS `serverwerbung_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `Message` longtext NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `test_log`
--

CREATE TABLE IF NOT EXISTS `test_log` (
`ID` int(11) NOT NULL,
  `Nickname` varchar(255) NOT NULL,
  `cmd` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `args` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `counter` int(11) NOT NULL,
  `timer` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ad_log`
--
ALTER TABLE `ad_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `beleidigung_log`
--
ALTER TABLE `beleidigung_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `biz_log`
--
ALTER TABLE `biz_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `casinolog`
--
ALTER TABLE `casinolog`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `chat_log`
--
ALTER TABLE `chat_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `delstvo`
--
ALTER TABLE `delstvo`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fuehrerscheinloose`
--
ALTER TABLE `fuehrerscheinloose`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `nickchange_log`
--
ALTER TABLE `nickchange_log`
 ADD PRIMARY KEY (`ID`), ADD KEY `UUID` (`UUID`);

--
-- Indexes for table `playermoney_log`
--
ALTER TABLE `playermoney_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `premium_log`
--
ALTER TABLE `premium_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `serverwerbung_log`
--
ALTER TABLE `serverwerbung_log`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `test_log`
--
ALTER TABLE `test_log`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ad_log`
--
ALTER TABLE `ad_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `beleidigung_log`
--
ALTER TABLE `beleidigung_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `biz_log`
--
ALTER TABLE `biz_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `casinolog`
--
ALTER TABLE `casinolog`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `chat_log`
--
ALTER TABLE `chat_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `delstvo`
--
ALTER TABLE `delstvo`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `fuehrerscheinloose`
--
ALTER TABLE `fuehrerscheinloose`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nickchange_log`
--
ALTER TABLE `nickchange_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `playermoney_log`
--
ALTER TABLE `playermoney_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `premium_log`
--
ALTER TABLE `premium_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `serverwerbung_log`
--
ALTER TABLE `serverwerbung_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `test_log`
--
ALTER TABLE `test_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
