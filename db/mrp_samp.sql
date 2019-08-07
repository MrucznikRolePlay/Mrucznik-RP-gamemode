-- phpMyAdmin SQL Dump
-- version 4.3.10.0-5spoofy-1.2p
-- http://www.phpmyadmin.net
--
-- Host: 10.8.8.26:3306
-- Generation Time: Aug 28, 2015 at 08:10 PM
-- Server version: 5.6.25-73.1
-- PHP Version: 5.3.10-1ubuntu3.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mrp_samp`
--

-- --------------------------------------------------------

--
-- Table structure for table `ibiza`
--

CREATE TABLE IF NOT EXISTS `ibiza` (
  `id` int(11) NOT NULL,
  `hajs` int(11) DEFAULT NULL,
  `opis` varchar(15) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibizadrinki`
--

CREATE TABLE IF NOT EXISTS `ibizadrinki` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_bany`
--

CREATE TABLE IF NOT EXISTS `mru_bany` (
  `UID` int(11) NOT NULL,
  `IP` varchar(32) COLLATE utf8_polish_ci NOT NULL DEFAULT 'nieznane',
  `dostal_uid` int(11) NOT NULL,
  `dostal` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `nadal_uid` int(11) NOT NULL,
  `nadal` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `czas` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `typ` int(11) NOT NULL,
  `powod` varchar(64) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20523 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_boosts`
--

CREATE TABLE IF NOT EXISTS `mru_boosts` (
  `UID` int(11) NOT NULL,
  `PID` int(11) NOT NULL,
  `boostid` tinyint(3) unsigned NOT NULL,
  `expire` smallint(6) NOT NULL,
  `count` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_cars`
--

CREATE TABLE IF NOT EXISTS `mru_cars` (
  `UID` int(11) NOT NULL,
  `ownertype` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `angle` float NOT NULL,
  `hp` float NOT NULL DEFAULT '1000',
  `tires` int(11) NOT NULL,
  `color1` int(11) NOT NULL,
  `color2` int(11) NOT NULL,
  `nitro` int(11) NOT NULL,
  `hydraulika` tinyint(1) NOT NULL,
  `felgi` int(11) NOT NULL,
  `malunek` int(11) NOT NULL DEFAULT '3',
  `spoiler` int(11) NOT NULL,
  `bumper1` int(11) NOT NULL,
  `bumper2` int(11) NOT NULL,
  `keys` int(11) NOT NULL,
  `neon` int(11) NOT NULL,
  `ranga` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '-1',
  `vw` int(11) NOT NULL DEFAULT '-1',
  `oldid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24956 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_commands`
--

CREATE TABLE IF NOT EXISTS `mru_commands` (
  `cmd` varchar(16) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_config`
--

CREATE TABLE IF NOT EXISTS `mru_config` (
  `san1` varchar(128) COLLATE utf8_polish_ci NOT NULL,
  `san2` varchar(128) COLLATE utf8_polish_ci NOT NULL,
  `gangzone` int(11) NOT NULL,
  `gangtimedelay` int(11) NOT NULL,
  `login_audio` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `stanowe_key` int(11) NOT NULL,
  `trucker_magazyn` int(11) NOT NULL,
  `wosp` int(11) NOT NULL,
  `FracLiders` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_doors`
--

CREATE TABLE IF NOT EXISTS `mru_doors` (
  `UID` int(11) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `owner` int(11) NOT NULL,
  `ox` float NOT NULL,
  `oy` float NOT NULL,
  `oz` float NOT NULL,
  `oa` float NOT NULL,
  `ix` float NOT NULL,
  `iy` float NOT NULL,
  `iz` float NOT NULL,
  `ia` float NOT NULL,
  `ovw` smallint(5) unsigned NOT NULL,
  `oint` smallint(5) unsigned NOT NULL,
  `ivw` smallint(5) unsigned NOT NULL,
  `iint` smallint(5) unsigned NOT NULL,
  `lights` tinyint(1) NOT NULL DEFAULT '1',
  `lock` tinyint(1) NOT NULL,
  `title` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `flags` bit(8) NOT NULL DEFAULT b'1',
  `oplata` int(11) NOT NULL,
  `url` varchar(128) CHARACTER SET utf8 NOT NULL,
  `audioplay` tinyint(1) NOT NULL,
  `fire` tinyint(1) NOT NULL,
  `elevator` int(11) NOT NULL,
  `order` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `parent` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_frac`
--

CREATE TABLE IF NOT EXISTS `mru_frac` (
  `UID` int(11) NOT NULL,
  `typ` tinyint(3) unsigned NOT NULL,
  `name` varchar(40) COLLATE utf8_polish_ci NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `a` float NOT NULL,
  `vw` smallint(5) unsigned NOT NULL,
  `int` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_konta`
--

CREATE TABLE IF NOT EXISTS `mru_konta` (
  `UID` int(10) unsigned NOT NULL,
  `Nick` varchar(24) COLLATE utf8_polish_ci NOT NULL,
  `Key` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Admin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DonateRank` tinyint(4) NOT NULL DEFAULT '0',
  `UpgradePoints` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ConnectedTime` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Registered` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Age` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Origin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CK` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Muted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Respect` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Money` int(11) NOT NULL DEFAULT '5000000',
  `Bank` int(11) NOT NULL,
  `Crimes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Kills` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Deaths` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Arrested` smallint(5) unsigned NOT NULL DEFAULT '0',
  `WantedDeaths` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Phonebook` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LottoNr` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Fishes` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BiggestFish` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Job` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Paycheck` int(11) NOT NULL,
  `HeadValue` int(11) NOT NULL,
  `BlokadaPisania` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Jailed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `JailTime` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Materials` int(10) unsigned NOT NULL DEFAULT '0',
  `Drugs` int(10) unsigned NOT NULL DEFAULT '0',
  `Member` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FMember` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Rank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Char` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Skin` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ContractTime` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DetSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SexSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `BoxSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LawSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MechSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `JackSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CarSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NewsSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DrugsSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CookSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FishSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `GunSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TruckSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pSHealth` float NOT NULL,
  `pHealth` float NOT NULL,
  `Int` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Local` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Team` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Model` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PhoneNr` int(11) NOT NULL,
  `Dom` int(11) NOT NULL,
  `Bizz` int(11) NOT NULL DEFAULT '255',
  `Wynajem` int(11) NOT NULL,
  `Pos_x` float NOT NULL,
  `Pos_y` float NOT NULL,
  `Pos_z` float NOT NULL,
  `CarLic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FlyLic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BoatLic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FishLic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `GunLic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun0` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun11` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Gun12` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Ammo0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo7` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo8` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo9` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo10` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo11` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ammo12` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CarTime` int(11) NOT NULL,
  `PayDay` int(11) NOT NULL,
  `PayDayHad` int(11) NOT NULL,
  `CDPlayer` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Wins` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Loses` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AlcoholPerk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DrugPerk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MiserPerk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PainPerk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TraderPerk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Tutorial` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Mission` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Warnings` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Block` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Fuel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Married` int(11) NOT NULL,
  `MarriedTo` varchar(24) COLLATE utf8_polish_ci NOT NULL DEFAULT 'Nikt',
  `CBRADIO` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PoziomPoszukiwania` int(11) NOT NULL,
  `Dowod` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PodszywanieSie` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ZmienilNick` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Wino` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Piwo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Cygaro` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Sprunk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PodgladWiadomosci` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StylWalki` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PAdmin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ZaufanyGracz` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Auto1` int(11) NOT NULL,
  `Auto2` int(11) NOT NULL,
  `Auto3` int(11) NOT NULL,
  `Auto4` int(11) NOT NULL,
  `Lodz` int(11) NOT NULL,
  `Samolot` int(11) NOT NULL,
  `Garaz` int(11) NOT NULL,
  `KluczykiDoAuta` int(11) NOT NULL,
  `Spawn` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BW` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Czystka` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CarSlots` tinyint(3) unsigned NOT NULL DEFAULT '5',
  `Hat` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FW` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `connected` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=77462 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_konta_oszustwa`
--

CREATE TABLE IF NOT EXISTS `mru_konta_oszustwa` (
  `UID` int(10) unsigned NOT NULL,
  `Nick` varchar(24) COLLATE utf8_polish_ci NOT NULL,
  `Key` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `Level` int(11) NOT NULL DEFAULT '1',
  `Admin` int(11) NOT NULL DEFAULT '0',
  `DonateRank` tinyint(4) NOT NULL DEFAULT '0',
  `UpgradePoints` int(11) NOT NULL DEFAULT '0',
  `ConnectedTime` int(11) NOT NULL DEFAULT '0',
  `Registered` int(11) NOT NULL DEFAULT '0',
  `Sex` int(11) NOT NULL DEFAULT '0',
  `Age` int(11) NOT NULL DEFAULT '0',
  `Origin` int(11) NOT NULL DEFAULT '0',
  `CK` int(11) NOT NULL,
  `Muted` int(11) NOT NULL,
  `Respect` int(11) NOT NULL,
  `Money` int(11) NOT NULL,
  `Bank` int(11) NOT NULL,
  `Crimes` int(11) NOT NULL,
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `Arrested` int(11) NOT NULL,
  `WantedDeaths` int(11) NOT NULL,
  `Phonebook` int(11) NOT NULL,
  `LottoNr` int(11) NOT NULL,
  `Fishes` int(11) NOT NULL,
  `BiggestFish` int(11) NOT NULL,
  `Job` int(11) NOT NULL,
  `Paycheck` int(11) NOT NULL,
  `HeadValue` int(11) NOT NULL,
  `BlokadaPisania` int(11) NOT NULL,
  `Jailed` int(11) NOT NULL,
  `JailTime` int(11) NOT NULL,
  `Materials` int(11) NOT NULL,
  `Drugs` int(11) NOT NULL,
  `Lider` int(11) NOT NULL,
  `Member` int(11) NOT NULL,
  `FMember` int(11) NOT NULL DEFAULT '0',
  `Rank` int(11) NOT NULL,
  `Char` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `ContractTime` int(11) NOT NULL,
  `DetSkill` int(11) NOT NULL,
  `SexSkill` int(11) NOT NULL,
  `BoxSkill` int(11) NOT NULL,
  `LawSkill` int(11) NOT NULL,
  `MechSkill` int(11) NOT NULL,
  `JackSkill` int(11) NOT NULL,
  `CarSkill` int(11) NOT NULL,
  `NewsSkill` int(11) NOT NULL,
  `DrugsSkill` int(11) NOT NULL,
  `CookSkill` int(11) NOT NULL,
  `FishSkill` int(11) NOT NULL,
  `GunSkill` int(11) NOT NULL,
  `TruckSkill` int(11) NOT NULL,
  `pSHealth` float NOT NULL,
  `pHealth` float NOT NULL,
  `Int` int(11) NOT NULL,
  `Local` int(11) NOT NULL,
  `Team` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `PhoneNr` int(11) NOT NULL,
  `Dom` int(11) NOT NULL,
  `Bizz` int(11) NOT NULL DEFAULT '255',
  `Wynajem` int(11) NOT NULL,
  `Pos_x` float NOT NULL,
  `Pos_y` float NOT NULL,
  `Pos_z` float NOT NULL,
  `CarLic` int(11) NOT NULL,
  `FlyLic` int(11) NOT NULL,
  `BoatLic` int(11) NOT NULL,
  `FishLic` int(11) NOT NULL,
  `GunLic` int(11) NOT NULL,
  `Gun0` int(11) NOT NULL,
  `Gun1` int(11) NOT NULL,
  `Gun2` int(11) NOT NULL,
  `Gun3` int(11) NOT NULL,
  `Gun4` int(11) NOT NULL,
  `Gun5` int(11) NOT NULL,
  `Gun6` int(11) NOT NULL,
  `Gun7` int(11) NOT NULL,
  `Gun8` int(11) NOT NULL,
  `Gun9` int(11) NOT NULL,
  `Gun10` int(11) NOT NULL,
  `Gun11` int(11) NOT NULL,
  `Gun12` int(11) NOT NULL,
  `Ammo0` int(11) NOT NULL,
  `Ammo1` int(11) NOT NULL,
  `Ammo2` int(11) NOT NULL,
  `Ammo3` int(11) NOT NULL,
  `Ammo4` int(11) NOT NULL,
  `Ammo5` int(11) NOT NULL,
  `Ammo6` int(11) NOT NULL,
  `Ammo7` int(11) NOT NULL,
  `Ammo8` int(11) NOT NULL,
  `Ammo9` int(11) NOT NULL,
  `Ammo10` int(11) NOT NULL,
  `Ammo11` int(11) NOT NULL,
  `Ammo12` int(11) NOT NULL,
  `CarTime` int(11) NOT NULL,
  `PayDay` int(11) NOT NULL,
  `PayDayHad` int(11) NOT NULL,
  `CDPlayer` int(11) NOT NULL,
  `Wins` int(11) NOT NULL,
  `Loses` int(11) NOT NULL,
  `AlcoholPerk` int(11) NOT NULL,
  `DrugPerk` int(11) NOT NULL,
  `MiserPerk` int(11) NOT NULL,
  `PainPerk` int(11) NOT NULL,
  `TraderPerk` int(11) NOT NULL,
  `Tutorial` int(11) NOT NULL,
  `Mission` int(11) NOT NULL,
  `Warnings` int(11) NOT NULL,
  `Block` int(11) NOT NULL,
  `Fuel` int(11) NOT NULL,
  `Married` int(11) NOT NULL,
  `MarriedTo` varchar(24) COLLATE utf8_polish_ci NOT NULL DEFAULT 'Nikt',
  `CBRADIO` int(11) NOT NULL,
  `PoziomPoszukiwania` int(11) NOT NULL,
  `Dowod` int(11) NOT NULL,
  `PodszywanieSie` int(11) NOT NULL,
  `ZmienilNick` int(11) NOT NULL DEFAULT '2',
  `Wino` int(11) NOT NULL,
  `Piwo` int(11) NOT NULL,
  `Cygaro` int(11) NOT NULL,
  `Sprunk` int(11) NOT NULL,
  `PodgladWiadomosci` int(11) NOT NULL,
  `StylWalki` int(11) NOT NULL,
  `PAdmin` int(11) NOT NULL,
  `ZaufanyGracz` int(11) NOT NULL,
  `Auto1` int(11) NOT NULL,
  `Auto2` int(11) NOT NULL,
  `Auto3` int(11) NOT NULL,
  `Auto4` int(11) NOT NULL,
  `Lodz` int(11) NOT NULL,
  `Samolot` int(11) NOT NULL,
  `Garaz` int(11) NOT NULL,
  `KluczykiDoAuta` int(11) NOT NULL,
  `Spawn` int(11) NOT NULL,
  `BW` int(11) NOT NULL,
  `Czystka` int(11) NOT NULL,
  `CarSlots` int(2) NOT NULL DEFAULT '4',
  `Hat` int(1) NOT NULL,
  `FW` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_logowania`
--

CREATE TABLE IF NOT EXISTS `mru_logowania` (
  `UID` bigint(20) NOT NULL,
  `PID` int(7) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IP` varchar(16) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1323716 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_nazwyrang`
--

CREATE TABLE IF NOT EXISTS `mru_nazwyrang` (
  `ID` int(11) NOT NULL,
  `typ` int(11) NOT NULL COMMENT '1 - frakcja 2 - rodzina',
  `rangi` varchar(256) COLLATE utf8_polish_ci NOT NULL COMMENT 'Skompresowane nazwy rang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_opisy`
--

CREATE TABLE IF NOT EXISTS `mru_opisy` (
  `UID` int(11) NOT NULL,
  `typ` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `desc` varchar(128) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=13359 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_org`
--

CREATE TABLE IF NOT EXISTS `mru_org` (
  `ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Name` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `Motd` varchar(128) COLLATE utf8_polish_ci DEFAULT '0',
  `Color` decimal(11,0) NOT NULL DEFAULT '0',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `a` float NOT NULL,
  `Int` int(11) NOT NULL,
  `VW` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_partie`
--

CREATE TABLE IF NOT EXISTS `mru_partie` (
  `UID` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `owner` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `members` tinyint(3) unsigned NOT NULL,
  `cash` int(11) NOT NULL,
  `motd` varchar(128) COLLATE utf8_polish_ci NOT NULL,
  `akcja` int(11) NOT NULL DEFAULT '-1',
  `ulotka` tinyint(4) NOT NULL DEFAULT '-1',
  `kandydat` varchar(32) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_partie_akcje`
--

CREATE TABLE IF NOT EXISTS `mru_partie_akcje` (
  `UID` int(11) NOT NULL,
  `partia_id` int(11) NOT NULL,
  `podpisy` smallint(5) unsigned NOT NULL,
  `nazwa` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `typ` tinyint(3) unsigned NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_partie_hasla`
--

CREATE TABLE IF NOT EXISTS `mru_partie_hasla` (
  `UID` int(11) NOT NULL,
  `partia_id` int(11) NOT NULL,
  `haslo` varchar(64) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_partie_m`
--

CREATE TABLE IF NOT EXISTS `mru_partie_m` (
  `UID` int(11) NOT NULL,
  `PUID` int(11) NOT NULL,
  `OUID` int(11) NOT NULL,
  `Rank` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_partie_podpisy`
--

CREATE TABLE IF NOT EXISTS `mru_partie_podpisy` (
  `UID` int(11) NOT NULL,
  `AUID` int(11) NOT NULL,
  `PUID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1296 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_playeritems`
--

CREATE TABLE IF NOT EXISTS `mru_playeritems` (
  `id` int(11) NOT NULL,
  `UID` int(6) NOT NULL,
  `model` int(5) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `sx` float NOT NULL,
  `sy` float NOT NULL,
  `sz` float NOT NULL,
  `order` int(2) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=14743 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_pp`
--

CREATE TABLE IF NOT EXISTS `mru_pp` (
  `UID` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IP` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `name` varchar(24) COLLATE utf8_polish_ci NOT NULL,
  `surname` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `email` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `control` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `mc` int(6) NOT NULL,
  `amount` int(4) NOT NULL,
  `code` varchar(22) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3330 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_premium`
--

CREATE TABLE IF NOT EXISTS `mru_premium` (
  `UID` int(11) NOT NULL,
  `puid` int(11) NOT NULL,
  `mc` int(11) NOT NULL,
  `start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_check` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hours` int(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1278 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_premiumcode`
--

CREATE TABLE IF NOT EXISTS `mru_premiumcode` (
  `UID` int(11) NOT NULL,
  `MC_ID` int(11) NOT NULL,
  `IP` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `name` varchar(24) COLLATE utf8_polish_ci NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2699 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_premiumsales`
--

CREATE TABLE IF NOT EXISTS `mru_premiumsales` (
  `UID` int(11) NOT NULL,
  `typ` int(11) NOT NULL,
  `opis` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `ilosc` int(11) NOT NULL,
  `cena` int(11) NOT NULL,
  `left` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_properties`
--

CREATE TABLE IF NOT EXISTS `mru_properties` (
  `UID` int(10) unsigned NOT NULL,
  `name` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `typ` tinyint(3) unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_prop_owners`
--

CREATE TABLE IF NOT EXISTS `mru_prop_owners` (
  `UID` int(11) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `prop_uid` int(11) NOT NULL,
  `share` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_rodziny`
--

CREATE TABLE IF NOT EXISTS `mru_rodziny` (
  `name` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_sejfy`
--

CREATE TABLE IF NOT EXISTS `mru_sejfy` (
  `ID` int(11) NOT NULL,
  `typ` int(11) NOT NULL,
  `kasa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_serverinfo`
--

CREATE TABLE IF NOT EXISTS `mru_serverinfo` (
  `aktywne` int(11) NOT NULL,
  `info` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

-- --------------------------------------------------------

--
-- Table structure for table `mru_shopitems`
--

CREATE TABLE IF NOT EXISTS `mru_shopitems` (
  `UID` int(11) NOT NULL,
  `typ` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `cena` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_shopsale`
--

CREATE TABLE IF NOT EXISTS `mru_shopsale` (
  `model` int(11) NOT NULL,
  `sale` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_skins`
--

CREATE TABLE IF NOT EXISTS `mru_skins` (
  `typ` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `skins` varchar(128) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_strefy`
--

CREATE TABLE IF NOT EXISTS `mru_strefy` (
  `id` int(11) NOT NULL,
  `gang` int(11) NOT NULL,
  `expire` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_strefylimit`
--

CREATE TABLE IF NOT EXISTS `mru_strefylimit` (
  `gang` int(11) NOT NULL,
  `data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_ticketvalue`
--

CREATE TABLE IF NOT EXISTS `mru_ticketvalue` (
  `UID` int(11) NOT NULL,
  `typ` tinyint(3) unsigned NOT NULL,
  `id` int(11) NOT NULL,
  `value1` mediumint(8) unsigned NOT NULL,
  `value2` mediumint(8) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_uprawnienia`
--

CREATE TABLE IF NOT EXISTS `mru_uprawnienia` (
  `UID` int(11) NOT NULL,
  `FLAGS` bit(16) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_weaponskill`
--

CREATE TABLE IF NOT EXISTS `mru_weaponskill` (
  `UID` int(11) NOT NULL,
  `puid` int(11) NOT NULL,
  `skill` varchar(56) COLLATE utf8_polish_ci NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0'
) ENGINE=InnoDB AUTO_INCREMENT=9538 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_weryfikacje`
--

CREATE TABLE IF NOT EXISTS `mru_weryfikacje` (
  `UID` int(11) NOT NULL,
  `PID` int(11) NOT NULL,
  `password` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `name` varchar(24) COLLATE utf8_polish_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_wybory`
--

CREATE TABLE IF NOT EXISTS `mru_wybory` (
  `UID` int(11) NOT NULL,
  `PUID` int(10) unsigned NOT NULL,
  `kandydat` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ibiza`
--
ALTER TABLE `ibiza`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ibizadrinki`
--
ALTER TABLE `ibizadrinki`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mru_bany`
--
ALTER TABLE `mru_bany`
  ADD PRIMARY KEY (`UID`), ADD KEY `dostal_uid` (`dostal_uid`), ADD KEY `IP` (`IP`);

--
-- Indexes for table `mru_boosts`
--
ALTER TABLE `mru_boosts`
  ADD PRIMARY KEY (`UID`), ADD KEY `PID` (`PID`);

--
-- Indexes for table `mru_cars`
--
ALTER TABLE `mru_cars`
  ADD PRIMARY KEY (`UID`), ADD KEY `owner` (`owner`), ADD KEY `ownertype` (`ownertype`);

--
-- Indexes for table `mru_doors`
--
ALTER TABLE `mru_doors`
  ADD PRIMARY KEY (`UID`), ADD KEY `owner` (`owner`), ADD KEY `type` (`type`);

--
-- Indexes for table `mru_frac`
--
ALTER TABLE `mru_frac`
  ADD PRIMARY KEY (`UID`), ADD KEY `typ` (`typ`);

--
-- Indexes for table `mru_konta`
--
ALTER TABLE `mru_konta`
  ADD PRIMARY KEY (`UID`), ADD UNIQUE KEY `Nick` (`Nick`);

--
-- Indexes for table `mru_konta_oszustwa`
--
ALTER TABLE `mru_konta_oszustwa`
  ADD PRIMARY KEY (`UID`), ADD UNIQUE KEY `Nick` (`Nick`);

--
-- Indexes for table `mru_logowania`
--
ALTER TABLE `mru_logowania`
  ADD PRIMARY KEY (`UID`), ADD KEY `PID` (`PID`);

--
-- Indexes for table `mru_nazwyrang`
--
ALTER TABLE `mru_nazwyrang`
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `mru_opisy`
--
ALTER TABLE `mru_opisy`
  ADD PRIMARY KEY (`UID`), ADD KEY `owner` (`owner`);

--
-- Indexes for table `mru_org`
--
ALTER TABLE `mru_org`
  ADD PRIMARY KEY (`ID`), ADD KEY `UID` (`UID`);

--
-- Indexes for table `mru_partie`
--
ALTER TABLE `mru_partie`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_partie_akcje`
--
ALTER TABLE `mru_partie_akcje`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_partie_hasla`
--
ALTER TABLE `mru_partie_hasla`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_partie_m`
--
ALTER TABLE `mru_partie_m`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_partie_podpisy`
--
ALTER TABLE `mru_partie_podpisy`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_playeritems`
--
ALTER TABLE `mru_playeritems`
  ADD PRIMARY KEY (`id`), ADD KEY `UID` (`UID`);

--
-- Indexes for table `mru_pp`
--
ALTER TABLE `mru_pp`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_premium`
--
ALTER TABLE `mru_premium`
  ADD PRIMARY KEY (`UID`), ADD KEY `puid` (`puid`);

--
-- Indexes for table `mru_premiumcode`
--
ALTER TABLE `mru_premiumcode`
  ADD PRIMARY KEY (`UID`), ADD KEY `MC_ID` (`MC_ID`);

--
-- Indexes for table `mru_premiumsales`
--
ALTER TABLE `mru_premiumsales`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_properties`
--
ALTER TABLE `mru_properties`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_prop_owners`
--
ALTER TABLE `mru_prop_owners`
  ADD PRIMARY KEY (`UID`), ADD KEY `owner_uid` (`owner_uid`), ADD KEY `prop_uid` (`prop_uid`);

--
-- Indexes for table `mru_sejfy`
--
ALTER TABLE `mru_sejfy`
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `mru_shopitems`
--
ALTER TABLE `mru_shopitems`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `mru_skins`
--
ALTER TABLE `mru_skins`
  ADD KEY `id` (`id`);

--
-- Indexes for table `mru_strefy`
--
ALTER TABLE `mru_strefy`
  ADD KEY `id` (`id`);

--
-- Indexes for table `mru_strefylimit`
--
ALTER TABLE `mru_strefylimit`
  ADD KEY `gang` (`gang`);

--
-- Indexes for table `mru_ticketvalue`
--
ALTER TABLE `mru_ticketvalue`
  ADD PRIMARY KEY (`UID`), ADD KEY `id` (`id`);

--
-- Indexes for table `mru_uprawnienia`
--
ALTER TABLE `mru_uprawnienia`
  ADD PRIMARY KEY (`UID`), ADD KEY `UID` (`UID`);

--
-- Indexes for table `mru_weaponskill`
--
ALTER TABLE `mru_weaponskill`
  ADD PRIMARY KEY (`UID`), ADD KEY `puid` (`puid`);

--
-- Indexes for table `mru_weryfikacje`
--
ALTER TABLE `mru_weryfikacje`
  ADD PRIMARY KEY (`UID`), ADD KEY `PID` (`PID`);

--
-- Indexes for table `mru_wybory`
--
ALTER TABLE `mru_wybory`
  ADD PRIMARY KEY (`UID`), ADD KEY `PUID` (`PUID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mru_bany`
--
ALTER TABLE `mru_bany`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20523;
--
-- AUTO_INCREMENT for table `mru_boosts`
--
ALTER TABLE `mru_boosts`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `mru_cars`
--
ALTER TABLE `mru_cars`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24956;
--
-- AUTO_INCREMENT for table `mru_doors`
--
ALTER TABLE `mru_doors`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=206;
--
-- AUTO_INCREMENT for table `mru_frac`
--
ALTER TABLE `mru_frac`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `mru_konta`
--
ALTER TABLE `mru_konta`
  MODIFY `UID` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77462;
--
-- AUTO_INCREMENT for table `mru_konta_oszustwa`
--
ALTER TABLE `mru_konta_oszustwa`
  MODIFY `UID` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mru_logowania`
--
ALTER TABLE `mru_logowania`
  MODIFY `UID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1323716;
--
-- AUTO_INCREMENT for table `mru_opisy`
--
ALTER TABLE `mru_opisy`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13359;
--
-- AUTO_INCREMENT for table `mru_org`
--
ALTER TABLE `mru_org`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=111;
--
-- AUTO_INCREMENT for table `mru_partie`
--
ALTER TABLE `mru_partie`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `mru_partie_akcje`
--
ALTER TABLE `mru_partie_akcje`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `mru_partie_hasla`
--
ALTER TABLE `mru_partie_hasla`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `mru_partie_m`
--
ALTER TABLE `mru_partie_m`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=288;
--
-- AUTO_INCREMENT for table `mru_partie_podpisy`
--
ALTER TABLE `mru_partie_podpisy`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1296;
--
-- AUTO_INCREMENT for table `mru_playeritems`
--
ALTER TABLE `mru_playeritems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14743;
--
-- AUTO_INCREMENT for table `mru_pp`
--
ALTER TABLE `mru_pp`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3330;
--
-- AUTO_INCREMENT for table `mru_premium`
--
ALTER TABLE `mru_premium`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1278;
--
-- AUTO_INCREMENT for table `mru_premiumcode`
--
ALTER TABLE `mru_premiumcode`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2699;
--
-- AUTO_INCREMENT for table `mru_premiumsales`
--
ALTER TABLE `mru_premiumsales`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mru_properties`
--
ALTER TABLE `mru_properties`
  MODIFY `UID` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT for table `mru_prop_owners`
--
ALTER TABLE `mru_prop_owners`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `mru_shopitems`
--
ALTER TABLE `mru_shopitems`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT for table `mru_ticketvalue`
--
ALTER TABLE `mru_ticketvalue`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=71;
--
-- AUTO_INCREMENT for table `mru_weaponskill`
--
ALTER TABLE `mru_weaponskill`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9538;
--
-- AUTO_INCREMENT for table `mru_weryfikacje`
--
ALTER TABLE `mru_weryfikacje`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `mru_wybory`
--
ALTER TABLE `mru_wybory`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
