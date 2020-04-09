CREATE TABLE IF NOT EXISTS `mru_bany` (
`UID` int(11) NOT NULL,
  `IP` varchar(32) COLLATE utf8_polish_ci NOT NULL DEFAULT 'nieznane',
  `dostal_uid` int(11) NOT NULL DEFAULT '0',
  `dostal` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT 'brak',
  `nadal_uid` int(11) NOT NULL DEFAULT '0',
  `nadal` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT 'SYSTEM DEFAULT',
  `czas` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `typ` int(11) NOT NULL DEFAULT '0',
  `powod` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'Brak'
) ENGINE=InnoDB AUTO_INCREMENT=70199 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;


ALTER TABLE `mru_bany`
 ADD PRIMARY KEY (`UID`), ADD KEY `dostal_uid` (`dostal_uid`), ADD KEY `IP` (`IP`);


ALTER TABLE `mru_bany`
MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=70199;