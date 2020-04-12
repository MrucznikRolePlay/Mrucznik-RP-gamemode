
CREATE TABLE IF NOT EXISTS `ibizadrinki` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;


ALTER TABLE `ibizadrinki`
 ADD PRIMARY KEY (`id`);
