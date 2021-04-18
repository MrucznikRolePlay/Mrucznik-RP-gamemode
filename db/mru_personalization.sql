
CREATE TABLE IF NOT EXISTS `mru_personalization` (
  `UID` int(11) NOT NULL,
  `KontoBankowe` tinyint(1) NOT NULL DEFAULT '0',
  `Ogloszenia` tinyint(1) NOT NULL DEFAULT '0',
  `LicznikPojazdu` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaFrakcji` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaRodzin` tinyint(1) NOT NULL DEFAULT '0',
  `OldNick` tinyint(1) NOT NULL DEFAULT '0',
  `CBRadio` tinyint(1) NOT NULL DEFAULT '0',
  `Report` tinyint(1) DEFAULT '0',
  `DeathWarning` tinyint(1) NOT NULL DEFAULT '0',
  `KaryTXD` tinyint(1) NOT NULL DEFAULT '0',
  `NewNick` tinyint(1) NOT NULL DEFAULT '0',
  `newbie` tinyint(1) NOT NULL DEFAULT '0',
  `BronieScroll` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_personalization`
 ADD PRIMARY KEY (`UID`), ADD KEY `UID` (`UID`);
