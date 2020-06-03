
CREATE TABLE IF NOT EXISTS `mru_player_cooking` (
`id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `weight` int(11) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;


ALTER TABLE `mru_player_cooking`
 ADD PRIMARY KEY (`id`), ADD KEY `owner` (`owner`);


ALTER TABLE `mru_player_cooking`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;