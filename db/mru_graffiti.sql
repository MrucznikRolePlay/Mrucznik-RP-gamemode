CREATE TABLE IF NOT EXISTS `mru_graffiti` (
  `id` int(11) NOT NULL,
  `ownerName` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `text` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `kolor` smallint(2) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `xy` float NOT NULL,
  `yy` float NOT NULL,
  `zy` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
