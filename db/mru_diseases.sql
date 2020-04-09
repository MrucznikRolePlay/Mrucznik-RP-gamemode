CREATE TABLE IF NOT EXISTS `mru_diseases` (
  `uid` int(11) NOT NULL,
  `disease` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `mru_diseases`
 ADD PRIMARY KEY (`uid`,`disease`);
