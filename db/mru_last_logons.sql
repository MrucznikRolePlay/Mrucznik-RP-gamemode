CREATE TABLE IF NOT EXISTS `mru_last_logons` (
  `Nick` varchar(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_last_logons`
 ADD PRIMARY KEY (`Nick`);
