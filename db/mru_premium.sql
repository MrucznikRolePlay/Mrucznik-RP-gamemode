CREATE TABLE IF NOT EXISTS `mru_premium` (
  `p_charUID` int(11) NOT NULL,
  `p_MC` int(11) NOT NULL DEFAULT '0',
  `p_startDate` datetime DEFAULT NULL,
  `p_endDate` datetime DEFAULT NULL,
  `p_LastCheck` datetime DEFAULT NULL,
  `p_activeKp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_premium`
 ADD PRIMARY KEY (`p_charUID`);
