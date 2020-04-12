
CREATE TABLE IF NOT EXISTS `mru_liderzy` (
  `NICK` varchar(32) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `UID` int(11) NOT NULL,
  `FracID` int(11) NOT NULL DEFAULT '0',
  `LiderValue` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_liderzy`
 ADD PRIMARY KEY (`UID`), ADD KEY `FracID` (`FracID`);