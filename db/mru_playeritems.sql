CREATE TABLE IF NOT EXISTS `mru_playeritems` (
`id` int(11) NOT NULL,
  `UID` int(6) NOT NULL,
  `model` int(5) NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `rx` float NOT NULL DEFAULT '0',
  `ry` float NOT NULL DEFAULT '0',
  `rz` float NOT NULL DEFAULT '0',
  `sx` float NOT NULL DEFAULT '1',
  `sy` float NOT NULL DEFAULT '1',
  `sz` float NOT NULL DEFAULT '1',
  `bone` int(2) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=15320 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

ALTER TABLE `mru_playeritems`
 ADD PRIMARY KEY (`id`), ADD KEY `UID` (`UID`);

ALTER TABLE `mru_playeritems`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15320;
