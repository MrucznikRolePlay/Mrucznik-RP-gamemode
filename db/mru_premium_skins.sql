
CREATE TABLE IF NOT EXISTS `mru_premium_skins` (
  `s_charUID` int(11) NOT NULL,
  `s_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_premium_skins`
 ADD PRIMARY KEY (`s_charUID`,`s_ID`);
