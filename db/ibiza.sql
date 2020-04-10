CREATE TABLE IF NOT EXISTS `ibiza` (
  `id` int(11) NOT NULL,
  `hajs` int(11) DEFAULT NULL,
  `opis` varchar(15) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

ALTER TABLE `ibiza`
 ADD PRIMARY KEY (`id`);

INSERT INTO `ibiza` (`id`, `hajs`, `opis`) VALUES
(1, 1572606715, 'Sejf'),
(2, 1, 'Cena Biletu');
