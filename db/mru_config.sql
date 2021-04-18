CREATE TABLE IF NOT EXISTS `mru_config` (
  `san1` varchar(128) COLLATE utf8_polish_ci NOT NULL,
  `san2` varchar(128) COLLATE utf8_polish_ci NOT NULL,
  `gangzone` int(11) NOT NULL,
  `gangtimedelay` int(11) NOT NULL,
  `login_audio` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `stanowe_key` int(11) NOT NULL,
  `trucker_magazyn` int(11) NOT NULL,
  `wosp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

INSERT INTO `mru_config` (`san1`, `san2`, `gangzone`, `gangtimedelay`, `login_audio`, `stanowe_key`, `trucker_magazyn`, `wosp`) VALUES
('http://4stream.pl:18434', 'http://4stream.pl:18434', 0, 300, 'Login_1 Login_2 Login_3 Login_4 Login_5 Login_6', 1411, 20, 1386075514);
