
CREATE TABLE IF NOT EXISTS `mru_org` (
`ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Name` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `Motd` varchar(128) COLLATE utf8_polish_ci DEFAULT '0',
  `Color` int(11) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `Int` int(11) NOT NULL DEFAULT '0',
  `VW` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

ALTER TABLE `mru_org`
 ADD PRIMARY KEY (`ID`), ADD KEY `UID` (`UID`);

ALTER TABLE `mru_org`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=0;

INSERT INTO `mru_org` (`ID`, `UID`, `Type`, `Name`, `Motd`, `Color`, `x`, `y`, `z`, `a`, `Int`, `VW`) VALUES
(546, 19, 4, 'WOLNY WARSZTAT 2', '16711680', 0, 0, 0, 0, 0, 0, 0),
(549, 18, 5, 'Ibiza Club', 'Przypominam, ze macie 24h aby wpisac sie na liste pracowników. Nie wpisanie sie = Wylot!', 561285170, 403.516, -1801.61, 7.82812, 1.31537, 0, 0),
(550, 17, 5, 'Vinyl Club', '2.11.2018 - 20;00 IMPREZA', 0, 816.221, -1386.19, 13.5996, 46.9039, 0, 0),
(573, 15, 4, 'Dos Santos Car Service Idlewood', 'Ucz sie, pracuj ciezko dnia kazdego. Trening czyni mistrzem, duzo w tym dobrego', 580088356, 1768.3, -1679.88, 14.4102, 89.2539, 0, 0),
(575, 45, 0, 'Wydzial Ulepszen (SEJF KU)', '16711680', 0, 1472.9, -1013.24, 27.2578, 11.1092, 0, 0),
(588, 6, 0, 'Komisja Organizacyjna', '16711680', 0, 1464, -1033.39, 23.6562, 268.892, 0, 0),
(602, 43, 4, 'Basen Tsunami', '16711680', 0, 0, 0, 0, 0, 0, 0),
(619, 10, 0, 'Organizacja epizodyczna', '16711680', 0, -61.4289, -1140.24, 1.07812, 121.792, 0, 0),
(633, 30, 4, 'Ekipa remontowa', '16711680', 0, 1280.57, -1335.83, 13.372, 76.5794, 0, 0),
(634, 50, 0, 'Rz?d', '16711680', 0, 0, 0, 0, 0, 0, 0),
(639, 26, 4, 'Solarin Industries', '?O PANIE, KTO PANU TAK SPIERDOLI??', 880214820, 853.849, -602.477, 18.4219, 6.0748, 0, 0),
(640, 23, 4, 'Ammu Nation Los Santos', 'Sprawd?cie nowy cennik zmiana od 09.03.2020r. Cennik na czas istnienia konkurencji.', 890444096, 1787.58, -1164.99, 23.8281, 172.877, 0, 0),
(644, 31, 4, 'Cowboy Bar', 'Jezeli nie wpisales sie na liste itp. Napisz po hasla do matijas i zrob to jak najszybciej!', 1731814402, 681.287, -475.89, 16.3359, 182.733, 0, 0),
(659, 0, 0, '', '0', 0, 0, 0, 0, 0, 0, 0),
(662, 2, 3, 'Fearless Drivers', 'Drive fast and never let me catch you!', 1414004770, 1389.45, 476.836, 20.0446, 158.207, 0, 0),
(663, 4, 3, 'Night Kids', '0', 1736671844, 2767.24, -2452.12, 13.6432, 359.841, 0, 0),
(664, 1, 0, 'Supreme Court of San Andreas', 'Ignorantia legis excusat neminem\\r\\n\\r\\n', 121046320, 1310.05, -1369.67, 13.5653, 179.239, 0, 0),
(665, 27, 3, '30139', 'Welcome to hell.', 155191552, 844.672, -1073.65, 24.3639, 169.529, 0, 0),
(670, 21, 4, 'AmmuNation Willowfield', 'Zmiany na forum. Prosze sie zapoznac. Min. Aktu listy mats, awanse co tydz.', 1683167094, 2404.82, -1984.74, 13.5469, 267.711, 0, 0),
(672, 9, 1, 'Crips', '79', 588334984, 2157.02, -1707.71, 15.0859, 3.03164, 0, 0),
(673, 5, 2, 'Eagles of Underforest', 'Chcesz miec problem? To nie ma problemu.', 103944230, 2444.13, -1964.25, 13.5469, 185.974, 0, 0),
(675, 8, 1, 'do stref', '0', 896571032, 2371.87, -1044.96, 54.1231, 279.875, 0, 0),
(676, 16, 4, 'EVS CAR SERVICE', 'Witamy', 2425592102, 1029.08, -1363.83, 13.5707, 44.1908, 0, 0),
(677, 3, 3, 'Tehikili Suruculer', 'Selam, kardes!', 906446386, 1383.09, 465.391, 20.1944, 154.092, 0, 0),
(678, 11, 1, '051 glen park hustlers', '0', 0, 0, 0, 0, 0, 0, 0),
(679, 7, 2, 'Clique against society', '0', 0, 0, 0, 0, 0, 0, 0);
