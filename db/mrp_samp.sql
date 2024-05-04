SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- User samp
--
CREATE USER 'samp'@'%' IDENTIFIED BY 'funia';
GRANT ALL PRIVILEGES ON *.* TO 'samp'@'%'; 

--
-- Database: `mrp_samp`
--
CREATE DATABASE IF NOT EXISTS `mrp_samp` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `mrp_samp`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CZYSTKA_KONTA` (IN `player` VARCHAR(24))  MODIFIES SQL DATA
    COMMENT 'Procedura wykonujaca czystke majatku'
BEGIN

DECLARE message VARCHAR(256);
DECLARE playerConnected INT;
DECLARE oldMoney INT;
DECLARE oldBank INT;
DECLARE oldHouse INT;
DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN 
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    ROLLBACK;
    SELECT CONCAT(@p1, ':', @p2);
END;

SELECT connected, Money, Bank, Dom INTO playerConnected, oldMoney, oldBank, oldHouse FROM mru_konta WHERE  `Nick`=player;

IF playerConnected = 0 THEN
	START TRANSACTION;

    # action
    UPDATE mru_konta SET Money=0, Bank=0, Dom=0, detskill=0, sexskill=0, boxskill=0, lawskill=0, mechskill=0, jackskill=0, carskill=0, newsskill=0, drugsskill=0, cookskill=0, fishskill=0, gunskill=0, truckskill=0 WHERE Nick=player;
    UPDATE mru_cars SET ownertype=0 WHERE ownertype=3 AND owner=(SELECT UID FROM mru_konta WHERE Nick=player);
    
    # log
    SET message = CONCAT('Wyczyszczono konto graczowi ', player, ' old money ', oldMoney, ' old bank ', oldBank, ' old house ', oldHouse, ' i pojazdy');
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
	COMMIT;
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DAJ_MC` (IN `name` VARCHAR(21), IN `mc` INT)  MODIFIES SQL DATA
BEGIN

DECLARE message VARCHAR(255);
DECLARE playerUID INT;
DECLARE oldMC INT;
DECLARE playerConnected INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN 
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       	ROLLBACK;
        SELECT CONCAT(@p1, ':', @p2);
    END;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;
SELECT `UID` INTO playerUID FROM `mru_konta` WHERE `Nick` LIKE name;
SET oldMC = 0;
SELECT `p_MC` INTO oldMC FROM mru_premium WHERE p_charUID=playerUID;

IF playerConnected = 0 THEN
	START TRANSACTION;
    
    # log
    SET message = CONCAT('Nadno graczowi ', name, ' mc ', mc, ' stare mc ', oldMC);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    
    # action
    INSERT INTO `mru_premium` (`p_charUID`, `p_MC`) VALUES(playerUID, mc) ON DUPLICATE KEY UPDATE `p_MC` = (`p_MC` + mc);
    
    COMMIT;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NADAJ_ADMINA` (IN `name` VARCHAR(24), IN `adminlvl` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN 
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    ROLLBACK;
    SELECT CONCAT(@p1, ':', @p2);
END;

START TRANSACTION;
SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN
    # log
    SET message = CONCAT('Nadano ', adminlvl, ' level admina graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Admin`=adminlvl WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NADAJ_LIDERA` (IN `player` VARCHAR(24), IN `leader` SMALLINT UNSIGNED, IN `leader_value` ENUM('1','2'))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN

DECLARE message VARCHAR(256);
DECLARE player_uid INTEGER;

SELECT `UID` INTO player_uid FROM mru_konta WHERE Nick LIKE player;

# action
INSERT INTO `mru_liderzy`(`NICK`, `UID`, `FracID`, `LiderValue`) 
VALUES (player, player_uid, leader, leader_value)
ON DUPLICATE KEY UPDATE 
`NICK`=player, `UID`=player_uid, `FracID`=leader, `LiderValue`=leader_value;

# log
SET message = CONCAT('Nadano lidera frakcji ', leader, ' graczowi ', player);
INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);

# feedback
SELECT message AS komunikat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NADAJ_LIDERA_RODZINY` (IN `player` VARCHAR(24), IN `family` SMALLINT UNSIGNED)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN

DECLARE message VARCHAR(256);

# action
UPDATE mru_konta SET FMember=family, `Rank`=1009 WHERE Nick LIKE player;

# log
SET message = CONCAT('Nadano lidera rodziny ', family, ' graczowi ', player);
INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);

# feedback
SELECT message AS komunikat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NADAJ_POLADMINA` (IN `name` VARCHAR(24), IN `adminlvl` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN 
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    ROLLBACK;
    SELECT CONCAT(@p1, ':', @p2);
END;

START TRANSACTION;
SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN
    # log
    SET message = CONCAT('Nadano ', adminlvl, ' level pol admina graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `PAdmin`=adminlvl WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POBIERZ_GRACZY_PO_IP` (IN `ipaddress` VARCHAR(16))  READS SQL DATA
SELECT DISTINCT k.UID, k.Nick, k.Level, l.IP, Count(l.IP) AS 'Ilość logowań'
FROM mru_konta k 
JOIN mru_logowania l ON k.UID=l.PID
WHERE IP LIKE ipaddress
GROUP BY k.UID, k.Nick, k.Level, l.IP
ORDER BY Count(l.IP) DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POBIERZ_IP_GRACZA` (IN `name` VARCHAR(24))  READS SQL DATA
SELECT DISTINCT k.UID, k.Nick, k.Level, l.IP, Count(l.IP) AS 'Ilość logowań'
FROM mru_konta k 
JOIN mru_logowania l ON k.UID=l.PID
WHERE Nick=name
GROUP BY IP
ORDER BY Count(l.IP) DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POBIERZ_LOGOWANIA_GRACZA` (IN `name` VARCHAR(24))  READS SQL DATA
SELECT DISTINCT k.UID, k.Nick, k.Level, l.IP, l.time
FROM mru_konta k 
JOIN mru_logowania l ON k.UID=l.PID
WHERE Nick=name
ORDER BY time DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POBIERZ_LOGOWANIA_Z_IP` (IN `ipaddress` VARCHAR(16))  READS SQL DATA
SELECT k.UID, k.Nick, k.Level, l.IP, l.time
FROM mru_konta k 
JOIN mru_logowania l ON k.UID=l.PID
WHERE IP LIKE ipaddress
ORDER BY time DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPRAWNIENIA_ADMINOW` ()  NO SQL
SELECT k.Nick, UPRAWNIENIA_NAZWY(flags) FROM `mru_uprawnienia` u join mru_konta k on k.uid=u.uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USUN_LIDERA` (IN `player` VARCHAR(24))  MODIFIES SQL DATA
BEGIN

DECLARE message VARCHAR(256);

# action
DELETE FROM mru_liderzy WHERE Nick=player;

# log
SET message = CONCAT('Usunieto lidera rodziny graczowi ', player);
INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);

# feedback
SELECT message AS komunikat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USUN_LIDERA_RODZINY` (IN `player` VARCHAR(24))  MODIFIES SQL DATA
BEGIN

DECLARE message VARCHAR(256);

# action
UPDATE mru_konta SET FMember=0, `Rank`=0 WHERE Nick LIKE player;

# log
SET message = CONCAT('Usunieto lidera frakcji graczowi ', player);
INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);

# feedback
SELECT message AS komunikat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZMIEN_DOM` (IN `name` VARCHAR(32), IN `dom` INT)  MODIFIES SQL DATA
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zmieniono dom na: ', dom, ' graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Dom`=dom WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZMIEN_NICK_GRACZA` (IN `name` VARCHAR(21), IN `newName` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zmieniono nicku graczowi: ', name, ' na nick: ', newName);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Nick`=newName WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_BOATLIC` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono BoatLic graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `BoatLic`=1 WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_CARLIC` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono carlic graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `CarLic`=1 WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_FISHLIC` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono FishLic graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `FishLic`=1 WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_FLYLIC` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono FlyLic graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `FlyLic`=1 WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_GUNLIC` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono GunLic graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `GunLic`=1 WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_HAJS` (IN `name` VARCHAR(21), IN `hajs` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;
DECLARE player_uid INTEGER;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;
SELECT `UID` INTO player_uid FROM mru_konta WHERE Nick LIKE name;

IF playerConnected = 0 THEN
    # log
    SET message = CONCAT('Oddano ', hajs, '$ graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Money`=`Money`+hajs WHERE `UID`=player_uid;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_BANK` (IN `name` VARCHAR(21), IN `hajs` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;
DECLARE player_uid INTEGER;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;
SELECT `UID` INTO player_uid FROM mru_konta WHERE Nick LIKE name;

IF playerConnected = 0 THEN
    # log
    SET message = CONCAT('Oddano ', hajs, '$ graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Bank`=`Bank`+hajs WHERE `UID`=player_uid;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_HASLO` (IN `name` VARCHAR(21))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;
DECLARE newPass VARCHAR(32);

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN
	SELECT LEFT(UUID(), 8) INTO newPass;

    # log
    SET message = CONCAT('Zmieniono haslo na: ', newPass, ' graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Key`=MD5(newPass), `Salt`='' WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_MATS` (IN `name` VARCHAR(21), IN `mats` INT)  MODIFIES SQL DATA
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN 
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
    ROLLBACK;
    SELECT CONCAT(@p1, ':', @p2);
END;

START TRANSACTION;
SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN
    # log
    SET message = CONCAT('Oddano ', mats, ' mats graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Materials`=`Materials`+mats WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_NR_TEL` (IN `name` VARCHAR(21), IN `numer` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zmieniono numer na: ', numer, ' graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `PhoneNr`=numer WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_POJAZD` (IN `name` VARCHAR(21), IN `veh` INT)  NO SQL
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;
DECLARE previousOwner INT;
DECLARE previousOwnerType INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;
SELECT owner, ownertype INTO previousOwner, previousOwnerType FROM mru_cars WHERE UID=veh;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono auto uid ', veh, ' graczowi: ', name, 'poprzedni owner', previousOwner, ' ownertype ', previousOwnerType);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_cars SET `owner`=(SELECT UID FROM mru_konta WHERE `Nick`=name), ownertype=3 WHERE UID=veh;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_SKIN_CYWILA` (IN `name` VARCHAR(21), IN `skin` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zmieniono skin na: ', skin, ' graczowi: ', name);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `Skin`=skin WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ZWROC_ZMIANE_NICKU` (IN `name` VARCHAR(21), IN `ilosc` INT)  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
DECLARE message VARCHAR(256);
DECLARE playerConnected INT;

SELECT connected INTO playerConnected FROM mru_konta WHERE `Nick`=name;

IF playerConnected = 0 THEN

    # log
    SET message = CONCAT('Zwrocono zmiane nicku graczowi: ', name, ' w ilosci:', ilosc);
    INSERT INTO actions (Data, Caller, Action) VALUES (NOW(), USER(), message);
    
    # action
    UPDATE mru_konta SET `ZmienilNick`=`ZmienilNick`+ilosc WHERE `Nick`=name;
    
    # feedback
    SELECT message AS komunikat;
ELSE
	SELECT 'Gracz jest na serwerze/nie ma takiego gracza.' AS komunikat;
END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CAR_NAME` (`carid` INTEGER) RETURNS VARCHAR(32) CHARSET latin1 DETERMINISTIC BEGIN
    CASE carid
        WHEN 400 THEN RETURN 'Landstalker';
        WHEN 401 THEN RETURN 'Bravura';
        WHEN 402 THEN RETURN 'Buffalo';
        WHEN 403 THEN RETURN 'TIR';
        WHEN 404 THEN RETURN 'Perennial';
        WHEN 405 THEN RETURN 'Sentinel';
        WHEN 406 THEN RETURN 'Wywrotka';
        WHEN 407 THEN RETURN 'Straz';
        WHEN 408 THEN RETURN 'Smieciarka';
        WHEN 409 THEN RETURN 'Limuzyna';
        WHEN 410 THEN RETURN 'Manana';
        WHEN 411 THEN RETURN 'Infernus';
        WHEN 412 THEN RETURN 'Voodoo';
        WHEN 413 THEN RETURN 'Pony';
        WHEN 414 THEN RETURN 'Mule';
        WHEN 415 THEN RETURN 'Cheetah';
        WHEN 416 THEN RETURN 'Karetka';
        WHEN 417 THEN RETURN 'Leviathan';
        WHEN 418 THEN RETURN 'Moonbeam';
        WHEN 419 THEN RETURN 'Esperanto';
        WHEN 420 THEN RETURN 'Taxi';
        WHEN 421 THEN RETURN 'Washington';
        WHEN 422 THEN RETURN 'Bobcat';
        WHEN 423 THEN RETURN 'Lodziarnia';
        WHEN 424 THEN RETURN 'BF Injection';
        WHEN 425 THEN RETURN 'Hunter';
        WHEN 426 THEN RETURN 'Premier';
        WHEN 427 THEN RETURN 'Enforcer';
        WHEN 428 THEN RETURN 'Securicar';
        WHEN 429 THEN RETURN 'Banshee';
        WHEN 430 THEN RETURN 'Predator';
        WHEN 431 THEN RETURN 'Bus';
        WHEN 432 THEN RETURN 'Czolg';
        WHEN 433 THEN RETURN 'Barracks';
        WHEN 434 THEN RETURN 'Hotknife';
        WHEN 435 THEN RETURN 'Przyczepa';
        WHEN 436 THEN RETURN 'Previon';
        WHEN 437 THEN RETURN 'Autobus';
        WHEN 438 THEN RETURN 'Taxi';
        WHEN 439 THEN RETURN 'Stallion';
        WHEN 440 THEN RETURN 'Rumpo';
        WHEN 441 THEN RETURN 'RC Bandit';
        WHEN 442 THEN RETURN 'Karawan';
        WHEN 443 THEN RETURN 'Packer';
        WHEN 444 THEN RETURN 'Monster';
        WHEN 445 THEN RETURN 'Admiral';
        WHEN 446 THEN RETURN 'Squalo';
        WHEN 447 THEN RETURN 'Seasparrow';
        WHEN 448 THEN RETURN 'Pizzaboy';
        WHEN 449 THEN RETURN 'Tramwaj';
        WHEN 450 THEN RETURN 'Przyczepa';
        WHEN 451 THEN RETURN 'Turismo';
        WHEN 452 THEN RETURN 'Speeder';
        WHEN 453 THEN RETURN 'Kuter';
        WHEN 454 THEN RETURN 'Tropic';
        WHEN 455 THEN RETURN 'Flatbed';
        WHEN 456 THEN RETURN 'Yankee';
        WHEN 457 THEN RETURN 'Caddy';
        WHEN 458 THEN RETURN 'Solair';
        WHEN 459 THEN RETURN 'Berkleys RC Van';
        WHEN 460 THEN RETURN 'Skimmer';
        WHEN 461 THEN RETURN 'PCJ-600';
        WHEN 462 THEN RETURN 'Faggio';
        WHEN 463 THEN RETURN 'Freeway';
        WHEN 464 THEN RETURN 'RC Baron';
        WHEN 465 THEN RETURN 'RC Raider';
        WHEN 466 THEN RETURN 'Glendale';
        WHEN 467 THEN RETURN 'Oceanic';
        WHEN 468 THEN RETURN 'Sanchez';
        WHEN 469 THEN RETURN 'Sparrow';
        WHEN 470 THEN RETURN 'Hummer';
        WHEN 471 THEN RETURN 'Quad';
        WHEN 472 THEN RETURN 'Coastguard';
        WHEN 473 THEN RETURN 'Ponton';
        WHEN 474 THEN RETURN 'Hermes';
        WHEN 475 THEN RETURN 'Sabre';
        WHEN 476 THEN RETURN 'Rustler';
        WHEN 477 THEN RETURN 'ZR-350';
        WHEN 478 THEN RETURN 'Walton';
        WHEN 479 THEN RETURN 'Regina';
        WHEN 480 THEN RETURN 'Comet';
        WHEN 481 THEN RETURN 'BMX';
        WHEN 482 THEN RETURN 'Burrito';
        WHEN 483 THEN RETURN 'Camper';
        WHEN 484 THEN RETURN 'Jacht';
        WHEN 485 THEN RETURN 'Baggage';
        WHEN 486 THEN RETURN 'Dozer';
        WHEN 487 THEN RETURN 'Maverick';
        WHEN 488 THEN RETURN 'Newsokopter';
        WHEN 489 THEN RETURN 'Rancher';
        WHEN 490 THEN RETURN 'Rancher FBI';
        WHEN 491 THEN RETURN 'Virgo';
        WHEN 492 THEN RETURN 'Greenwood';
        WHEN 493 THEN RETURN 'Jetmax';
        WHEN 494 THEN RETURN 'Hotring';
        WHEN 495 THEN RETURN 'Sandking';
        WHEN 496 THEN RETURN 'Blista Compact';
        WHEN 497 THEN RETURN 'Policyjny Maverick';
        WHEN 498 THEN RETURN 'Boxville';
        WHEN 499 THEN RETURN 'Benson';
        WHEN 500 THEN RETURN 'Mesa';
        WHEN 501 THEN RETURN 'RC Goblin';
        WHEN 502 THEN RETURN 'Hotring Racer';
        WHEN 503 THEN RETURN 'Hotring Racer';
        WHEN 504 THEN RETURN 'Bloodring Banger';
        WHEN 505 THEN RETURN 'Rancher';
        WHEN 506 THEN RETURN 'Super GT';
        WHEN 507 THEN RETURN 'Elegant';
        WHEN 508 THEN RETURN 'Kamping';
        WHEN 509 THEN RETURN 'Rower';
        WHEN 510 THEN RETURN 'Rower Gorski';
        WHEN 511 THEN RETURN 'Beagle';
        WHEN 512 THEN RETURN 'Cropdust';
        WHEN 513 THEN RETURN 'Stunt';
        WHEN 514 THEN RETURN 'Tanker';
        WHEN 515 THEN RETURN 'RoadTrain';
        WHEN 516 THEN RETURN 'Nebula';
        WHEN 517 THEN RETURN 'Majestic';
        WHEN 518 THEN RETURN 'Buccaneer';
        WHEN 519 THEN RETURN 'Shamal';
        WHEN 520 THEN RETURN 'Hydra';
        WHEN 521 THEN RETURN 'FCR-900';
        WHEN 522 THEN RETURN 'NRG-500';
        WHEN 523 THEN RETURN 'HPV1000';
        WHEN 524 THEN RETURN 'Cement Truck';
        WHEN 525 THEN RETURN 'Tow Truck';
        WHEN 526 THEN RETURN 'Fortune';
        WHEN 527 THEN RETURN 'Cadrona';
        WHEN 528 THEN RETURN 'Armatka Wodna';
        WHEN 529 THEN RETURN 'Willard';
        WHEN 530 THEN RETURN 'Forklift';
        WHEN 531 THEN RETURN 'Traktor';
        WHEN 532 THEN RETURN 'Combine';
        WHEN 533 THEN RETURN 'Feltzer';
        WHEN 534 THEN RETURN 'Remington';
        WHEN 535 THEN RETURN 'Slamvan';
        WHEN 536 THEN RETURN 'Blade';
        WHEN 537 THEN RETURN 'Freight';
        WHEN 538 THEN RETURN 'Streak';
        WHEN 539 THEN RETURN 'Vortex';
        WHEN 540 THEN RETURN 'Vincent';
        WHEN 541 THEN RETURN 'Bullet';
        WHEN 542 THEN RETURN 'Clover';
        WHEN 543 THEN RETURN 'Sadler';
        WHEN 544 THEN RETURN 'Straz';
        WHEN 545 THEN RETURN 'Hustler';
        WHEN 546 THEN RETURN 'Intruder';
        WHEN 547 THEN RETURN 'Primo';
        WHEN 548 THEN RETURN 'Cargobob';
        WHEN 549 THEN RETURN 'Tampa';
        WHEN 550 THEN RETURN 'Sunrise';
        WHEN 551 THEN RETURN 'Merit';
        WHEN 552 THEN RETURN 'Utility Truck';
        WHEN 553 THEN RETURN 'Nevada';
        WHEN 554 THEN RETURN 'Yosemite';
        WHEN 555 THEN RETURN 'Windsor';
        WHEN 556 THEN RETURN 'Monster';
        WHEN 557 THEN RETURN 'Monster';
        WHEN 558 THEN RETURN 'Uranus';
        WHEN 559 THEN RETURN 'Jester';
        WHEN 560 THEN RETURN 'Sultan';
        WHEN 561 THEN RETURN 'Stratum';
        WHEN 562 THEN RETURN 'Elegy';
        WHEN 563 THEN RETURN 'Raindance';
        WHEN 564 THEN RETURN 'RCTiger';
        WHEN 565 THEN RETURN 'Flash';
        WHEN 566 THEN RETURN 'Tahoma';
        WHEN 567 THEN RETURN 'Savanna';
        WHEN 568 THEN RETURN 'Bandito';
        WHEN 569 THEN RETURN 'Freight';
        WHEN 570 THEN RETURN 'Trailer';
        WHEN 571 THEN RETURN 'Kart';
        WHEN 572 THEN RETURN 'Turbowozek';
        WHEN 573 THEN RETURN 'Dune';
        WHEN 574 THEN RETURN 'Sweeper';
        WHEN 575 THEN RETURN 'Broadway';
        WHEN 576 THEN RETURN 'Tornado';
        WHEN 577 THEN RETURN 'AT-400';
        WHEN 578 THEN RETURN 'DFT-30';
        WHEN 579 THEN RETURN 'Huntley';
        WHEN 580 THEN RETURN 'Stafford';
        WHEN 581 THEN RETURN 'BF-400';
        WHEN 582 THEN RETURN 'SANvan';
        WHEN 583 THEN RETURN 'Tug';
        WHEN 584 THEN RETURN 'Trailer';
        WHEN 585 THEN RETURN 'Emperor';
        WHEN 586 THEN RETURN 'Wayfarer';
        WHEN 587 THEN RETURN 'Euros';
        WHEN 588 THEN RETURN 'Hotdog';
        WHEN 589 THEN RETURN 'Club';
        WHEN 590 THEN RETURN 'Trailer';
        WHEN 591 THEN RETURN 'Trailer';
        WHEN 592 THEN RETURN 'Andromada';
        WHEN 593 THEN RETURN 'Dodo';
        WHEN 594 THEN RETURN 'RC Cam';
        WHEN 595 THEN RETURN 'Launch';
        WHEN 596 THEN RETURN 'Radiowoz (LSPD)';
        WHEN 597 THEN RETURN 'Radiowoz (SFPD)';
        WHEN 598 THEN RETURN 'Radiowoz (LVPD)';
        WHEN 599 THEN RETURN 'Policyjny Jeep';
        WHEN 600 THEN RETURN 'Picador';
        WHEN 601 THEN RETURN 'Pancernik FBI';
        WHEN 602 THEN RETURN 'Alpha';
        WHEN 603 THEN RETURN 'Phoenix';
        WHEN 604 THEN RETURN 'Glendale';
        WHEN 605 THEN RETURN 'Sadler';
        WHEN 606 THEN RETURN 'Luggage Trailer';
        WHEN 607 THEN RETURN 'Luggage Trailer';
        WHEN 608 THEN RETURN 'Stair Trailer';
        WHEN 609 THEN RETURN 'Boxville';
        WHEN 610 THEN RETURN 'Kombajn';
        WHEN 611 THEN RETURN 'Utility Trailer';
        WHEN 612 THEN RETURN 'Brak pojazdu';
        WHEN 613 THEN RETURN 'Brak łodzi';
        WHEN 614 THEN RETURN 'Brak samolotu';
        ELSE RETURN 'BRAK';
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `IS_CAR_UNIQUE` (`carid` INT) RETURNS TINYINT(1) NO SQL
RETURN carid IN(403,406,407,408,413,414,416,423,425,427,428,430,431,432,433,437,440,441,442,443,444,447,448,455,456,457,459,460,461,464,465,476,481,485,486,490,494,497,498,499,501,502,503,504,509,510,514,515,520,523,524,525,528,530,531,532,539,544,548,552,556,557,564,571,573,574,577,578,582,583,588,592,594,596,597,598,599,601,609)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `UPRAWNIENIA_NAZWY` (`bity` INT) RETURNS TEXT CHARSET latin1 NO SQL
    DETERMINISTIC
BEGIN

DECLARE names TEXT; 
SET @names = "";

IF bity & 0b1 THEN 
    SET @names = CONCAT(@names, "PANEL | ");
END IF;
IF bity & 0b10 THEN 
    SET @names = CONCAT(@names, "KARY | ");
END IF;
IF bity & 0b100 THEN 
    SET @names = CONCAT(@names, "KARY_ZNAJDZ | ");
END IF;
IF bity & 0b1000 THEN 
    SET @names = CONCAT(@names, "KARY_UNBAN | ");
END IF;
IF bity & 0b10000 THEN 
    SET @names = CONCAT(@names, "KARY_BAN | ");
END IF;
IF bity & 0b100000 THEN 
    SET @names = CONCAT(@names, "ZG | ");
END IF;
IF bity & 0b1000000 THEN 
    SET @names = CONCAT(@names, "MAKEFAMILY | ");
END IF;
IF bity & 0b10000000 THEN 
    SET @names = CONCAT(@names, "MAKELEADER | ");
END IF;
IF bity & 0b100000000 THEN 
    SET @names = CONCAT(@names, "EDITPERM | ");
END IF;
IF bity & 0b1000000000 THEN 
    SET @names = CONCAT(@names, "EDITCAR | ");
END IF;
IF bity & 0b10000000000 THEN 
    SET @names = CONCAT(@names, "EDITRANG | ");
END IF;
IF bity & 0b100000000000 THEN 
    SET @names = CONCAT(@names, "GIVEHALF | ");
END IF;
IF bity & 0b1000000000000 THEN 
    SET @names = CONCAT(@names, "DELETEORG | ");
END IF; 

RETURN (@names);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE IF NOT EXISTS `actions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Data` datetime NOT NULL,
  `Caller` varchar(64) NOT NULL,
  `Action` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ibiza`
--

CREATE TABLE IF NOT EXISTS `ibiza` (
  `id` int(11) NOT NULL,
  `hajs` int(11) DEFAULT NULL,
  `opis` varchar(15) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `ibiza`
--

INSERT INTO `ibiza` (`id`, `hajs`, `opis`) VALUES
(1, 1572606715, 'Sejf'),
(2, 1, 'Cena Biletu');

-- --------------------------------------------------------

--
-- Table structure for table `ibizadrinki`
--

CREATE TABLE IF NOT EXISTS `ibizadrinki` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_bany`
--

CREATE TABLE IF NOT EXISTS `mru_bany` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `IP` varchar(32) COLLATE utf8_polish_ci NOT NULL DEFAULT 'nieznane',
  `dostal_uid` int(11) NOT NULL DEFAULT '0',
  `dostal` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT 'brak',
  `nadal_uid` int(11) NOT NULL DEFAULT '0',
  `nadal` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT 'SYSTEM DEFAULT',
  `czas` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `typ` int(11) NOT NULL DEFAULT '0',
  `powod` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'Brak',
  PRIMARY KEY (`UID`),
  KEY `dostal_uid` (`dostal_uid`),
  KEY `IP` (`IP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_business`
--

CREATE TABLE IF NOT EXISTS `mru_business` (
  `ID` int(11) NOT NULL,
  `ownerUID` int(11) NOT NULL,
  `ownerName` varchar(32) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `Name` varchar(64) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `enX` float NOT NULL,
  `enY` float NOT NULL,
  `enZ` float NOT NULL,
  `exX` float NOT NULL,
  `exY` float NOT NULL,
  `exZ` float NOT NULL,
  `exVW` int(11) NOT NULL,
  `exINT` int(11) NOT NULL,
  `pLocal` int(11) NOT NULL,
  `Money` int(11) NOT NULL,
  `Cost` int(11) NOT NULL,
  `Location` varchar(64) NOT NULL,
  `MoneyPocket` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ownerUID` (`ownerUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mru_business`
--

INSERT INTO `mru_business` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`) VALUES
(2, 0, 'Brak', 'Robois Food Mart Commerce', 1352.52, -1758.16, 13.5078, -25.8845, -185.869, 1003.55, 17, 17, 255, 5000, 0, 'Los Santos', 0),
(3, 0, 'Brak', '69 centów Unity Station', 1832.87, -1842.58, 13.5781, -27.4379, -57.5059, 1003.55, 6, 6, 255, 3500, 0, 'Los Santos', 0),
(4, 0, 'Brak', '24/7 Dillimore', 691.497, -546.814, 16.3359, -25.1326, -139.067, 1003.55, 16, 16, 255, 2000, 0, 'Los Santos', 0),
(5, 0, 'Brak', '24/7 BaySide', -2478.98, 2318.03, 4.9844, -30.9467, -89.6096, 1003.55, 5, 18, 255, 1000, 0, 'Los Santos', 0),
(6, 0, 'Brak', '24/7 Palomino Creek', 2334.32, 14.5263, 26.4843, 2334.32, 14.5263, 26.4843, 6, 0, 255, 1000, 0, 'Los Santos', 0),
(7, 0, 'Brak', 'Monopolowy Dillimore', 660.041, -609.519, 16.3359, 660.041, -609.519, 16.3359, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(8, 0, 'Brak', 'Monopolowy Las Collinas', 2743.18, -1103.77, 69.5781, 2743.18, -1103.77, 69.5781, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(9, 0, 'Brak', 'Monopolowy Blueberry', 254.452, -62.2356, 1.5781, 254.452, -62.2356, 1.5781, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(10, 0, 'Brak', 'ZIP Los Santos', 1457.1, -1138.52, 24.0009, 161.405, -94.2416, 1001.8, 18, 18, 255, 7000, 0, 'Los Santos', 0),
(11, 0, 'Brak', 'Binco Los Santos', 2244.49, -1664.93, 15.4766, 207.522, -109.745, 1005.13, 15, 15, 255, 7000, 0, 'Los Santos', 0),
(12, 0, 'Brak', 'Sub Urban Los Santos', 2112.84, -1212.61, 23.9646, 204.058, -47.1918, 1001.8, 1, 1, 255, 7000, 0, 'Los Santos', 0),
(13, 0, 'Brak', 'Victim Los Santos', 460.045, -1501.08, 31.0557, 225.031, -9.1838, 1002.22, 5, 5, 255, 7000, 0, 'Los Santos', 0),
(14, 0, 'Brak', 'Pro Laps Los Santos', 499.964, -1359.82, 16.2959, 206.463, -137.708, 1003.09, 3, 3, 255, 7000, 0, 'Los Santos', 0),
(15, 0, 'Brak', 'Warsztat Dillimore', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(16, 0, 'Brak', 'Verona Mall', 1128.78, -1424.25, 15.7981, 1128.78, -1424.25, 15.7981, 0, 0, 255, 10000, 10000, 'Los Santos', 0),
(17, 0, 'Brak', 'Centrum Handlowe Willofield', 2485.35, -1958.75, 13.581, -25.8845, -185.869, 1003.55, 17, 17, 255, 3000, 0, 'Los Santos', 0),
(18, 0, 'Brak', 'SexShop', 1087.77, -923.028, 43.3906, -100.267, -22.9376, 1000.72, 3, 3, 255, 3000, 0, 'Los Santos', 0),
(19, 0, 'Brak', 'Xoomer Vinewood', 999.801, -919.972, 42.3281, -30.9467, -89.6096, 1003.55, 18, 18, 255, 5000, 0, 'Los Santos', 0),
(20, 0, 'Brak', 'Going Idlewood', 1929.6, -1776.37, 13.5469, -30.9467, -89.6096, 1003.55, 20, 18, 255, 10000, 0, 'Los Santos', 0),
(21, 0, 'Brak', 'Xoomer Flint Country', -79.2933, -1169.57, 2.1592, -27.3123, -29.2776, 1003.55, 21, 4, 255, 3000, 0, 'Los Santos', 0),
(22, 0, 'Brak', 'Gasso Dillimore', 660.698, -573.473, 16.3359, 663.875, -573.343, 16.3359, -1, 0, 255, 5000, 0, 'Los Santos', 0),
(23, 0, 'Brak', 'Tosser Palomino Creek', 2579.39, 53.4918, 26.5547, -26.6916, -55.7149, 1003.55, 23, 6, 255, 2000, 0, 'Los Santos', 0),
(24, 0, 'Brak', 'Tosser Market', 1031.39, -1363.65, 13.5747, 1012.33, -1353.54, -6.7548, 5, 0, 255, 2500, 0, 'Los Santos', 0),
(25, 0, 'Brak', 'Studio tatuazu', 2069.3, -1779.81, 13.5593, -203.076, -24.1658, 1002.27, 25, 16, 255, 1000, 0, 'Los Santos', 0),
(26, 0, 'Brak', 'Studio tatuazu El Corona', 1975.89, -2036.7, 13.5469, -204.064, -9.17, 1002.27, 26, 17, 255, 2000, 0, 'Los Santos', 0),
(27, 0, 'Brak', 'Cluckin Bell Market', 927.696, -1352.95, 13.3438, 365.01, -10.9751, 1001.85, 9, 9, 255, 5000, 0, 'Los Santos', 0),
(28, 0, 'Brak', 'Cluckin Bell Willofield', 2397.35, -1898.31, 13.5469, 365.01, -10.9751, 1001.85, 10, 9, 255, 4000, 0, 'Los Santos', 0),
(29, 0, 'Brak', 'Cluckin Bell East LS', 2420.24, -1509.04, 24, 365.01, -10.9751, 1001.85, 11, 9, 255, 3500, 0, 'Los Santos', 0),
(30, 0, 'Brak', 'Burger Shot Vinewood', 1199.31, -918.647, 43.119, 363.413, -74.5786, 1001.51, 10, 10, 255, 6000, 0, 'Los Santos', 0),
(31, 0, 'Brak', 'Burger Shot Marina', 811.313, -1616.32, 13.5469, 363.413, -74.5786, 1001.51, 69, 10, 255, 5500, 0, 'Los Santos', 0),
(32, 0, 'Brak', 'The Well Stacked Pizza Co.', 2104.28, -1806.48, 13.6504, 2097.99, -1803.09, -54.9997, 1, 1, 255, 7500, 75000000, 'Los Santos', 0),
(33, 0, 'Brak', 'Jetty Lounge', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(34, 0, 'Brak', 'Paczkarnia', 1038.19, -1339.18, 13.7266, 377.127, -192.755, 1000.64, 17, 17, 255, 5000, 0, 'Los Santos', 0),
(35, 0, 'Brak', 'Ten Green Bottles', 2309.56, -1643.83, 14.827, 502.09, -68.2218, 998.758, 11, 11, 255, 4000, 0, 'Los Santos', 0),
(36, 0, 'Brak', 'U Kacpra', 1970.85, -1285.23, 28.4919, 1982.22, -1302.01, -8.8488, 17, 17, 255, 4500, 0, 'Los Santos', 0),
(37, 0, 'Brak', 'Carniceria El Pueblo', 2151.86, -1013.44, 62.8028, 2138.91, -1014.42, 67.3345, 1, 0, 255, 3000, 0, 'Los Santos', 0),
(38, 0, 'Brak', 'Russian Bar PC', 2323.21, 7.6547, 26.5648, 2323.21, 7.6547, 26.5648, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(39, 0, 'Brak', 'Cowboy Bar', 681.485, -473.816, 16.5363, -227.028, 1401.23, 27.7656, 18, 18, 255, 2500, 0, 'Los Santos', 0),
(40, 0, 'Brak', 'PigPen', 2421.23, -1220.47, 25.4835, 1204.91, -13.6694, 1000.92, 2, 2, 255, 9000, 0, 'Los Santos', 0),
(41, 0, 'Brak', 'Ibiza Club', 394.142, -1805.92, 7.8302, 394.142, -1805.92, 7.8302, 0, 0, 255, 10000, 0, 'Los Santos', 0),
(42, 0, 'Brak', 'Carniceria Pub', 2501.79, -1494.81, 24, 1212.02, -28.6631, 1000.95, 3, 3, 255, 2500, 0, 'Los Santos', 0),
(43, 0, 'Brak', 'Basen Tsunami', 1210.77, -1749, 13.5939, 1198.49, -1756.66, 13.7282, 43, 0, 255, 6500, 0, 'Los Santos', 0),
(44, 0, 'Brak', 'Tor rowerowy Masakra', 701.782, -519.482, 16.3321, -1128.55, 1066.32, 1345.74, 10, 10, 255, 3000, 0, 'Los Santos', 0),
(45, 0, 'Brak', 'Tor zuzlowy', -1150.06, -991.795, 129.219, -1150.06, -991.795, 129.219, 0, 0, 255, 3500, 0, 'Los Santos', 0),
(46, 0, 'Brak', 'Wynajem gokartów', 2281.13, -2365.04, 13.5469, 1494.33, 1304.94, 1093.29, 46, 3, 255, 2000, 0, 'Los Santos', 0),
(47, 0, 'Brak', 'Stadion', 2695.72, -1704.7, 11.8438, -1404.53, -259.06, 1043.66, 7, 7, 255, 5000, 0, 'Los Santos', 0),
(48, 0, 'Brak', 'Motel Dziki Tygrys', 1940.77, -2115.99, 13.6953, 964.107, -53.2055, 1001.12, 3, 3, 255, 2500, 1, 'Los Santos', 0),
(49, 0, 'Brak', 'Motel Jefferson', 2232.53, -1159.76, 25.8906, 2215.04, -1150.65, 1025.8, 15, 15, 255, 3000, 0, 'Los Santos', 0),
(50, 0, 'Brak', 'Magazyn Solaries Industries', 854.502, -605.019, 18.5099, 856.45, -615.489, -6.18033, 1, 0, 255, 5000, 0, 'Los Santos', 0),
(51, 0, 'Brak', 'Tartak', -548.264, -194.267, 78.4063, -548.264, -194.267, 78.4063, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(52, 0, 'Brak', 'Hilltop Farm', 1052.07, -345.527, 73.9922, 1052.07, -345.527, 73.9922, 0, 0, 255, 1000, 0, 'Los Santos', 0),
(53, 0, 'Brak', 'Browary FleishBerg', -50.0422, -269.363, 6.6332, 2532.24, -1281.79, 1048.29, 2, 2, 255, 0, 0, 'Los Santos', 0),
(54, 0, 'Brak', 'Truck Terminal', 200.073, -236.427, 1.5781, 200.073, -236.427, 1.5781, 0, 0, 255, 2000, 0, 'Los Santos', 0),
(55, 0, 'Brak', 'Bymber Casino', 1022.16, -1121.81, 23.8713, 1025.25, -1078.16, -67.5729, 55, 3, 255, 8000, 0, 'Los Santos', 0),
(56, 0, 'Brak', 'Zaklad Bukmacherski', 1631.97, -1172.37, 24.0843, -2158.36, 642.589, 1052.38, 1, 1, 255, 2500, 0, 'Los Santos', 0),
(57, 0, 'Brak', 'Biurowiec Orientalny', 2792.83, -1087.54, 30.7188, 388.864, 173.902, 1008.38, 3, 3, 255, 0, 0, 'Los Santos', 0),
(58, 0, 'Brak', 'Warsztat Niebieski', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(59, 0, 'Brak', 'Warsztat Czerwony', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(60, 0, 'Brak', 'Serwis samochodowy', 2494.17, -1464.71, 24.0255, 2494.17, -1464.71, 24.0255, 0, 0, 255, 3000, 0, 'Los Santos', 0),
(61, 0, 'Brak', 'Ammu Nation Dillimore', 712.141, -498.913, 16.3359, 314.821, -141.432, 999.602, 61, 7, 255, 3000, 0, 'Los Santos', 0),
(62, 0, 'Brak', 'Magazyny Market', 919.468, -1252.15, 16.2109, 1302.52, -1.78751, 1001.03, 62, 18, 255, 1000, 0, 'Los Santos', 0),
(63, 0, 'Brak', 'Bonehead Club', 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 'Los Santos', 0),
(64, 0, 'Brak', 'Vinyl Club', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(65, 0, 'Brak', 'Warsztat na Ganton', 0, 0, -100, 0, 0, -100, 0, 0, 255, 0, 0, 'Los Santos', 0),
(66, 0, 'Brak', 'Tosser Montgomery', 1383.22, 465.398, 20.1937, -25.1326, -139.067, 1003.55, 66, 16, 255, 2000, 0, 'Los Santos', 0),
(67, 0, 'Brak', 'Garaze Commerce', 1607.87, -1559.57, 14.1792, 1607.87, -1559.57, 14.1792, 0, 0, 255, 0, 0, 'Los Santos', 0),
(68, 0, 'Brak', 'Hippie Club', 1247.95, -1560.72, 13.5556, 1245.06, -1544.8, 3.141, 40, 0, 255, 0, 0, 'Los Santos', 0),
(69, 0, 'Brak', 'Lotnisko Verdant Meadows', 411.013, 2533.45, 19.1484, 411.013, 2533.45, 19.1484, 0, 0, 255, 8000, 1, 'Los Santos', 0),
(70, 0, 'Brak', 'Los Santos Civilian Defence', 1709.22, -1500.6, 13.5469, 315.706, -142.987, 999.602, 7, 7, 255, 10000, 0, 'Los Santos', 0),
(71, 0, 'Brak', 'Dildos Club', 2178.11, -1770.66, 13.5454, 2175.39, -1781.28, 19.3055, 71, 71, 71, 7500, 0, 'Los Santos', 0),
(72, 0, 'Brak', 'Marks Motel', 1113.09, -922.909, 43.3906, 1148.14, -877.54, 24.2688, 1, 1, 255, 7500, 0, 'Los Santos', 0),
(73, 0, 'Brak', 'Kimono Hotel', 1578.71, -1794.84, 13.2826, 1148.14, -877.54, 24.2688, 2, 2, 255, 10000, 0, 'Los Santos', 0),
(74, 0, 'Brak', 'The Rats', 1477.55, -1500.5, 13.5469, 1148.14, -877.54, 24.2688, 3, 3, 255, 5000, 0, 'Los Santos', 0),
(75, 0, 'Brak', 'Sondom Sex Toys', 1307.79, -1158.01, 23.8281, 963.858, -1349.25, -18.7611, -1, 0, 255, 7000, 0, 'Los Santos', 0),
(76, 0, 'Brak', 'Big D1CK Shop', 954.008, -1336, 13.5388, 963.858, -1349.25, -18.7611, 1, 1, 255, 5500, 0, 'Los Santos', 0),
(77, 0, 'Brak', 'Liquor Deli', 1978.96, -1761.15, 13.5469, -26.6916, -55.7149, 1003.55, 77, 6, 255, 6000, 0, 'Idlewood', 0),
(78, 0, 'Brak', 'Incognito Shop', 255.458, -192.146, 1.5781, 963.858, -1349.25, -18.7611, 2, 2, 255, 3500, 0, 'Los Santos', 0),
(79, 0, 'Brak', 'Mr. Mexicano', 1560.53, -1850.79, 13.5469, 963.858, -1349.25, -18.7611, 3, 3, 255, 12500, 0, 'Los Santos', 0),
(80, 0, 'Brak', 'Chinese Food', 1044.14, -1269.3, 13.7276, 1042.5, -1269.43, 13.5677, 1, 0, 255, 8500, 0, 'Los Santos', 0),
(81, 0, 'Brak', 'Cofee Shop Los Santos', 1419.21, -1623.94, 13.1601, 1417.92, -1639.85, 13.3529, 1, 0, 255, 18500, 0, 'Los Santos', 0),
(82, 0, 'Brak', 'Kamieniolom Las Venturas', 817.092, 856.768, 12.7891, -2029.8, -106.676, 1035.17, 82, 3, 255, 16000, 0, 'Los Santos', 0),
(83, 0, 'Brak', 'Stadion Dirting Race', 1099.68, 1601.79, 12.5469, 1063.39, 1529.93, 55.8786, 83, 83, 83, 16000, 0, 'Los Santos', 0),
(84, 0, 'Brak', 'Stadion Bandits', 1477, 2247.78, 11.0234, 1477, 2247.78, 11.0234, 0, 0, 255, 14500, 0, 'Los Santos', 0),
(85, 0, 'Brak', 'Szamboa Gym', 2229.22, -1721.96, 13.5678, 772.026, -4.3203, 1000.73, 0, 5, 255, 3500, 0, 'Los Santos', 0),
(86, 0, 'Brak', 'Jizzys Club', 1491.25, -1140.97, 24.0781, -2636.87, 1404.03, 906.461, 3, 3, 255, 7000, 0, 'Los Santos', 0),
(87, 0, 'Brak', 'Johnson Studio', 2292.31, -1723.35, 13.5469, -204.064, -9.17, 1002.27, 17, 17, 255, 3000, 0, 'Los Santos', 0),
(88, 0, 'Brak', 'Seven The Strip', 2194.5, 1990.74, 12.2969, -25.8845, -185.869, 1003.55, 88, 17, 255, 5000, 0, 'Los Santos', 0),
(89, 0, 'Brak', 'Seven Starfish Casino', 2546.43, 1972.14, 10.8203, 6.09118, -29.2719, 1003.55, 89, 10, 255, 5000, 0, 'Los Santos', 0),
(90, 0, 'Brak', 'Cluckin`Bell OVS', 2393.44, 2042.21, 10.8203, 2393.44, 2042.21, 10.8203, 0, 0, 255, 5000, 0, 'Los Santos', 0),
(91, 0, 'Brak', 'The Grand Plaza Casino', 2166.02, 2164.72, 10.8203, 2233.8, 1712.23, 1011.76, 91, 1, 255, 15000, 0, 'Los Santos', 0),
(92, 0, 'Brak', 'Binco TEI', 2102.34, 2257.61, 11.0234, 207.522, -109.745, 1005.13, 92, 15, 255, 5000, 0, 'Los Santos', 0),
(93, 0, 'Brak', 'Stacja Bone County', 662.69, 1717, 7.1875, -25.1326, -139.067, 1003.55, 93, 16, 255, 3000, 0, 'Los Santos', 0),
(94, 0, 'Brak', 'Magazyny LVA Freight Depot', 1442.46, 969.774, 10.8203, 1059.9, 2081.69, 10.8203, 94, 0, 255, 5000, 0, 'Los Santos', 0),
(95, 0, 'Brak', 'General Store w Creek', 2810.82, 1987.37, 10.8203, -30.9467, -89.6096, 1003.55, 95, 18, 255, 3000, 0, 'Los Santos', 0),
(96, 0, 'Brak', 'STEAKHOUSE', 1693.85, 2207.81, 11.0692, 363.413, -74.5786, 1001.51, 96, 10, 255, 4000, 0, 'Los Santos', 0),
(97, 0, 'Brak', 'Stacja Benzynowa XOOMER TEI', 2188.34, 2469.64, 11.2422, -26.6916, -55.7149, 1003.55, 97, 6, 255, 6000, 0, 'Los Santos', 0),
(98, 0, 'Brak', 'Rafineria Octane Springs', 640.36, 1237.41, 11.6913, 640.36, 1237.41, 11.6913, 0, 0, 255, 10000, 0, 'Los Santos', 0),
(99, 0, 'Brak', 'Bar UFO', -89.0713, 1378.49, 10.4698, -227.028, 1401.23, 27.7656, 99, 18, 255, 3000, 0, 'Los Santos', 0),
(100, 0, 'Brak', 'Snake Farm', -36.0322, 2349.9, 24.3026, 681.488, -446.39, -25.6099, 100, 1, 255, 2000, 0, 'Los Santos', 0),
(101, 0, 'Brak', 'Stacja Benzynowa TR', -1272.04, 2713.25, 50.2663, -27.3123, -29.2776, 1003.55, 101, 4, 255, 3000, 0, 'Los Santos', 0),
(102, 0, 'Brak', 'THE SMOKIN`BEEF GRILL', -857.813, 1536.02, 22.587, 365.01, -10.9751, 1001.86, 102, 9, 255, 3000, 0, 'Los Santos', 0),
(103, 0, 'Brak', 'Drzewo m?dro?ci', 1315.18, -899.715, 39.5781, 1315.18, 1315.18, 39.5781, 0, 0, 255, 5000, 0, 'Mulholland', 0),
(104, 0, 'Brak', 'Alhambra', 1835.92, -1682.43, 13.3694, 493.464, -24.0912, 1000.68, 104, 17, 255, 7500, 0, 'Idlewood', 0);

-- --------------------------------------------------------

--
-- Table structure for table `mru_cars`
--

CREATE TABLE IF NOT EXISTS `mru_cars` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `ownertype` int(11) NOT NULL DEFAULT '0' COMMENT 'INVALID 0 | FRACTION 1 | FAMILY 2 | PLAYER 3 | JOB 4 | SPECIAL 5 | PUBLIC  6 |',
  `owner` int(11) NOT NULL DEFAULT '0',
  `model` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `angle` float NOT NULL DEFAULT '0',
  `hp` float NOT NULL DEFAULT '1000',
  `tires` int(11) NOT NULL DEFAULT '0',
  `color1` int(11) NOT NULL DEFAULT '0',
  `color2` int(11) NOT NULL DEFAULT '0',
  `nitro` int(11) NOT NULL DEFAULT '0',
  `hydraulika` tinyint(1) NOT NULL DEFAULT '0',
  `felgi` int(11) NOT NULL DEFAULT '0',
  `malunek` int(11) NOT NULL DEFAULT '3',
  `spoiler` int(11) NOT NULL DEFAULT '0',
  `bumper1` int(11) NOT NULL DEFAULT '0',
  `bumper2` int(11) NOT NULL DEFAULT '0',
  `keys` int(11) NOT NULL DEFAULT '0',
  `neon` int(11) NOT NULL DEFAULT '0',
  `ranga` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '-1',
  `vw` int(11) NOT NULL DEFAULT '-1',
  `oldid` int(11) NOT NULL DEFAULT '0',
  `pdvehmod` int(11) NOT NULL DEFAULT '0',
  `Rejestracja` varchar(32) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  `mru_carscol` varchar(45) COLLATE utf8_polish_ci DEFAULT '0',
  PRIMARY KEY (`UID`),
  KEY `owner` (`owner`),
  KEY `ownertype` (`ownertype`)
) ENGINE=InnoDB AUTO_INCREMENT=66336 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_cars`
--

INSERT INTO `mru_cars` (`UID`, `ownertype`, `owner`, `model`, `x`, `y`, `z`, `angle`, `hp`, `tires`, `color1`, `color2`, `nitro`, `hydraulika`, `felgi`, `malunek`, `spoiler`, `bumper1`, `bumper2`, `keys`, `neon`, `ranga`, `int`, `vw`, `oldid`, `pdvehmod`, `Rejestracja`, `mru_carscol`) VALUES
(3, 1, 10, 420, 2429.01, -2118.41, 13.3342, 269.3, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(5, 1, 10, 438, 2428.81, -2128.59, 13.5595, 269.8, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(8, 1, 10, 438, 2428.76, -2133.61, 13.559, 269.7, 1000, 0, 129, 129, 1008, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(9, 1, 10, 438, 2428.77, -2123.5, 13.5598, 269.4, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(10, 1, 10, 431, 2481.08, -2138.14, 13.6636, 0.1, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(11, 1, 10, 431, 2486, -2138.19, 13.6547, 0, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(12, 1, 10, 487, 2477.43, -2071.89, 20.0024, 90.2, 1000, 0, 129, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(13, 1, 10, 487, 2472.44, -2099.85, 19.9987, 88.3, 1000, 0, 129, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(14, 1, 10, 487, 2511.95, -2121.31, 13.7795, 268.8, 1000, 0, 129, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(15, 1, 10, 560, 2460.73, -2140.41, 13.2194, 0.2, 1000, 0, 129, 129, 1010, 1, 1079, 3, 1139, 1169, 1141, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(16, 1, 10, 409, 2470.89, -2139.86, 13.3424, 359.6, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(17, 1, 10, 525, 2477.86, -2108.85, 13.4416, 89.3, 1000, 0, 129, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(20, 1, 10, 437, 2501.04, -2138.52, 13.6942, 0, 996.5, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(21, 1, 10, 485, 1888.52, -2295.51, 13.274, 270, 851.4, 0, 6, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(23, 1, 10, 608, 1888.55, -2305.92, 13.274, 270, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(24, 1, 9, 582, 269.752, -1621.25, 17.918, 260.4, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(25, 1, 9, 582, 271.017, -1613.43, 17.9113, 259.6, 996.8, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(26, 1, 9, 582, 268.3, -1629.3, 17.9146, 259.7, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(27, 1, 9, 582, 269.07, -1625.38, 17.9145, 259.3, 1000, 0, 134, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(28, 1, 9, 437, 304.639, -1594.73, 17.9598, 80.3, 1000, 0, 134, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(29, 1, 9, 487, 276.335, -1597.04, 115.032, 262.2, 1000, 0, 219, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(37, 1, 1, 490, 1545.72, -1655.05, 6.02632, 89.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(40, 1, 1, 525, 1585.67, -1667.72, 5.76955, 271.8, 989.9, 0, 205, 205, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(47, 1, 1, 560, 1528.56, -1683.92, 5.59591, 270.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(49, 1, 1, 415, 1578.46, -1711.26, 5.59709, 4, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(51, 1, 1, 601, 1526.46, -1644.66, 5.63094, 181.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(52, 1, 1, 427, 1534.51, -1645.1, 5.95381, 179.6, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(53, 1, 1, 596, 1602.28, -1700.26, 5.63275, 88.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(55, 1, 1, 596, 1594.62, -1605.84, 13.1716, 179.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(56, 1, 1, 596, 1565.87, -1605.53, 13.102, 180.2, 973.8, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '0'),
(59, 1, 1, 560, 1528.48, -1687.83, 5.5955, 270.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(62, 1, 1, 490, 1545.61, -1651.15, 5.99071, 89.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(65, 1, 1, 596, 1583.19, -1605.57, 13.0252, 179.1, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(66, 1, 1, 596, 1600.24, -1605.68, 13.2346, 181.6, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(67, 1, 1, 426, 1545.82, -1667.83, 5.634, 90, 998.9, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(68, 1, 1, 599, 1595.39, -1711.57, 6.05705, 358.4, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(70, 1, 1, 525, 1585.56, -1671.63, 5.77603, 270, 1000, 0, 205, 205, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(71, 1, 1, 497, 1569.99, -1643.1, 28.5773, 92.4, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '0'),
(72, 1, 1, 497, 1548.76, -1643.4, 28.5761, 89.5, 666.6, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '0'),
(73, 1, 1, 430, 2103.1, -97.2275, -0.219866, 123.1, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(75, 1, 1, 430, 2962, -1487.17, 0.015084, 166.8, 982.4, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(108, 1, 2, 469, 599.835, -1472.9, 80.1679, 271.7, 1000, 0, 6, 5, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1, '', '0'),
(109, 1, 2, 427, 1134.39, 1507.52, 6.82387, 89.8, 994.2, 0, 36, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(110, 1, 2, 427, 1134.34, 1513.36, 6.82249, 92.1, 995.9, 0, 36, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(111, 1, 2, 560, 601.115, -1520.06, 15.2202, 4.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, '', '0'),
(114, 1, 2, 490, 606.45, -1498.24, 15.089, 90.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '0'),
(115, 1, 2, 490, 1091.68, 1550.56, 6.64039, 179.7, 983.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(116, 1, 2, 487, 598.458, -1458.89, 80.3354, 270.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, '', '0'),
(118, 1, 2, 487, 599.173, -1444.37, 80.3694, 270.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, '', '0'),
(120, 1, 2, 426, 1083.18, 1534.02, 6.40992, 359.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(124, 1, 2, 579, 1107.82, 1518.07, 5.80544, 179.3, 996.3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(126, 1, 2, 490, 1095.57, 1550.69, 6.64053, 179.7, 984.8, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(129, 1, 4, 487, 1160.99, -1321.38, 31.6716, 270.5, 1000, 0, 3, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(134, 1, 4, 416, 1287.89, 764.811, 11.0714, 178.8, 961.1, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(142, 1, 4, 487, 1161.15, -1301.07, 31.6762, 269.5, 1000, 0, 3, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(147, 1, 2, 490, 606.567, -1491.12, 14.9658, 90.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(150, 1, 4, 497, 1159.69, -1365.38, 26.7657, 270.4, 1000, 0, 3, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(151, 1, 2, 560, 597.179, -1519.76, 15.2401, 359.8, 991.4, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(159, 1, 8, 609, 39.7423, -266.594, 2.05338, 266.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(186, 1, 8, 428, -12.1774, -231.922, 5.57788, 267.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(188, 1, 8, 560, 11.8924, -231.967, 5.13449, 86.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(189, 1, 8, 493, -103.534, -550.419, -0.127492, 91.6, 995.4, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(190, 1, 8, 522, 11.1275, -252.348, 4.99922, 86, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(191, 1, 8, 579, 12.0482, -224.153, 5.56953, 87.6, 971.5, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(193, 1, 11, 431, 1374.72, -1771.09, 13.7154, 269.3, 995, 0, 214, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(195, 1, 7, 415, 1772.78, -1542.33, 9.21232, 312, 980, 0, 0, 0, 0, 0, 0, 3, 0, 1140, 1170, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(200, 1, 11, 426, 1402.9, -1807.83, 13.2962, 356.5, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(201, 1, 11, 405, 1412.87, -1825.73, 13.4525, 0, 992.1, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(202, 1, 11, 484, 859.796, -2122.31, 0.619709, 178, 997.9, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(203, 1, 11, 519, 1823.43, -2625.38, 14.4661, 357.9, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(204, 1, 11, 405, 1416.3, -1825.71, 13.4218, 0.7, 999.4, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(205, 1, 11, 426, 1406.64, -1807.86, 13.2342, 359.2, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(206, 1, 11, 581, 1415.18, -1772.16, 13.007, 90, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, -1, -1, 0, 0, '', '0'),
(207, 1, 11, 581, 1415.18, -1770.16, 13.007, 90, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, -1, -1, 0, 0, '', '0'),
(208, 1, 8, 541, -905.423, 2676.07, 41.9953, 313.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(209, 1, 11, 541, 1407.02, -1771.87, 13.1247, 178.8, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(210, 1, 11, 496, 1350.91, -1820.59, 13.2551, 358.4, 990.5, 0, 18, 18, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(212, 1, 11, 496, 1358.73, -1820.33, 13.4591, 358, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(213, 1, 11, 496, 1374.49, -1820.15, 13.4294, 356.6, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(224, 2, 23, 522, 1804.84, -1138.33, 23.656, 88.6, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(241, 1, 1, 596, 1554.4, -1605.65, 13.1039, 180.6, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(250, 2, 1, 487, 1309.91, -1298.63, 35.7734, 0, 909, 0, 72, 82, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(256, 5, 3, 468, -1133.22, -1032.04, 128.882, 357.6, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(257, 5, 3, 468, -1130.02, -1031.99, 128.886, 357.6, 1000, 0, 2, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(258, 5, 3, 468, -1127.16, -1032.09, 128.887, 0.2, 1000, 0, 6, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(259, 5, 3, 468, -1123.56, -1032.16, 128.887, 356.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(261, 5, 3, 468, -1117.08, -1031.77, 128.887, 357.6, 1000, 0, 46, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(262, 5, 3, 468, -1111, -1028.97, 128.887, 86.6, 1000, 0, 16, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(263, 2, 9, 468, -770.396, 1639.12, 27.0328, 271.7, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(264, 2, 9, 468, -770.531, 1635.79, 26.9302, 269.9, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(265, 5, 1, 434, 551.792, -1285.53, 16.93, 0.4, 1000, 0, 186, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(266, 5, 1, 568, 536.988, -1286.53, 16.999, 359.1, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(267, 5, 1, 434, 544.179, -1286.14, 16.949, 7.3, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(268, 5, 1, 434, -1949.95, 258.194, 35.192, 70.6, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(269, 5, 1, 568, -1948.17, 264.809, 35.193, 72.5, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(270, 5, 1, 434, -1947.06, 270.381, 35.195, 66, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(271, 5, 1, 496, 567.884, -1286.86, 17.389, 10.6, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(272, 5, 1, 545, 566.078, -1278.19, 17.383, 12.1, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(273, 5, 1, 504, 563.915, -1268.17, 17.384, 12.1, 1000, 0, 0, 0, 0, 0, 1025, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(274, 5, 1, 424, 530.312, -1278.34, 17.343, 304.9, 1000, 0, 36, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(275, 5, 1, 424, 538.483, -1272.57, 17.384, 304.7, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(276, 5, 1, 495, 547.868, -1265.36, 17.385, 301, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(277, 5, 2, 571, 2286.21, -2354.5, 12.83, 225.8, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(278, 5, 2, 571, 2279.94, -2348.41, 12.831, 225.8, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(279, 5, 2, 571, 2291.79, -2345.53, 12.83, 227.3, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(280, 5, 2, 571, 2287.56, -2341.64, 12.83, 226.5, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(281, 5, 2, 571, 2299.68, -2338.32, 12.83, 224.3, 250, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(282, 5, 2, 571, 2295.39, -2334.94, 12.83, 227.8, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(283, 4, 7, 543, 2770.99, -1606.72, 10.861, 267.2, 1000, 0, 8, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(284, 4, 7, 543, 2770.71, -1614.93, 10.764, 269.2, 995.4, 0, 184, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(285, 4, 7, 543, 2771.06, -1615.19, 10.735, 271, 1000, 0, 1, 1, 1010, 1, 1083, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(286, 4, 7, 552, 2771.28, -1622.74, 10.626, 319.6, 1000, 0, 2, 1, 1010, 1, 1075, 3, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, '', '0'),
(287, 4, 7, 552, 2776.57, -1623.76, 10.81, 319.2, 1000, 0, 2, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, '', '0'),
(288, 4, 7, 552, 2782.27, -1624.03, 10.793, 325.6, 1000, 0, 2, 1, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, '', '0'),
(289, 4, 7, 552, 2791.81, -1623.54, 11.01, 358.2, 1000, 0, 2, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(290, 4, 7, 574, 2802.1, -1597.39, 10.902, 337.6, 1000, 0, 1, 10, 0, 0, 0, 3, 0, 0, 0, 0, 0, 400, 0, 0, 0, 0, '', '0'),
(291, 4, 7, 525, 2798.71, -1604.83, 10.904, 337.2, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 400, 0, 0, 0, 0, '', '0'),
(292, 4, 7, 525, 2804.78, -1590.48, 10.902, 338.7, 1000, 0, 1, 10, 0, 1, 0, 3, 0, 0, 0, 0, 0, 400, 0, 0, 0, 0, '', '0'),
(293, 4, 7, 525, 2781.92, -1602.24, 11.272, 270.7, 1000, 0, 1, 209, 0, 0, 0, 3, 0, 0, 0, 0, 0, 200, -1, -1, 0, 0, '', '0'),
(294, 4, 7, 525, 2796.59, -1612.01, 10.763, 340.1, 250, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, '', '0'),
(295, 4, 10, 418, 1145.85, -1754.93, 13.713, 326.7, 1000, 0, 8, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, '', '0'),
(296, 4, 10, 437, 1081.2, -1757.97, 13.516, 89.4, 1000, 0, 8, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, '', '0'),
(297, 4, 10, 418, 1098.82, -1757.99, 13.444, 89, 1000, 0, 8, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(298, 4, 10, 418, 1062.42, -1769.64, 13.461, 89.5, 1000, 0, 6, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(299, 4, 10, 418, 1062.08, -1746.19, 13.548, 270.2, 1000, 0, 126, 5, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(300, 4, 10, 418, 1099.31, -1766.72, 13.441, 89.2, 1000, 0, 8, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(301, 4, 10, 418, 1062.66, -1761, 13.496, 86.8, 1000, 0, 8, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(313, 4, 1, 579, 302.1, -1504.79, 24.474, 236.8, 1000, 0, 102, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(314, 4, 1, 598, 307.127, -1481.91, 24.349, 234.5, 1000, 0, 102, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 401, 0, 0, 0, 0, '', '0'),
(315, 4, 1, 579, 298.257, -1509.03, 24.419, 237.8, 1000, 0, 102, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(316, 4, 1, 470, 303.306, -1486.44, 24.394, 238.5, 1000, 0, 102, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(317, 4, 1, 490, 310.235, -1511.59, 24.54, 325.2, 1000, 0, 102, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, '', '0'),
(319, 4, 16, 578, 1806.36, -2029.49, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(320, 4, 16, 578, 1806.36, -2035.99, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(321, 4, 16, 578, 1806.36, -2042.49, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(322, 4, 16, 578, 1806.36, -2048.99, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(323, 4, 16, 578, 1806.36, -2055.49, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(324, 4, 16, 578, 1806.36, -2061.99, 13.98, 90, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, '', '0'),
(325, 4, 16, 530, 1770.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(326, 4, 16, 530, 1772.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(327, 4, 16, 530, 1775.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(328, 4, 16, 530, 1777.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(329, 4, 16, 530, 1767.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(330, 4, 16, 530, 1765.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(331, 4, 16, 530, 1762.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(332, 4, 16, 530, 1760.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(333, 4, 16, 530, 1757.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(334, 4, 16, 530, 1755.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(335, 4, 16, 530, 1752.94, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(336, 4, 16, 530, 1750.44, -2075.8, 13.135, 0, 1000, 0, 222, 222, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, '', '0'),
(362, 6, 0, 468, -1433.17, -592.492, 1055.65, 92.4, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 4, -1, 0, 0, '', '0'),
(363, 6, 0, 468, -1448.53, -584.494, 1055.49, 95.5, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '', '0'),
(364, 6, 0, 468, -1434.9, -585.126, 1055.25, 91.1, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 4, -1, 0, 0, '', '0'),
(365, 6, 0, 468, -1449.28, 1610.78, 1052.53, 272.8, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, '', '0'),
(366, 6, 0, 468, -1453.88, 1611.24, 1052.53, 89, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 14, -1, 0, 0, '', '0'),
(367, 6, 0, 468, -1454.47, 1614.33, 1052.53, 86.8, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 14, -1, 0, 0, '', '0'),
(368, 6, 0, 468, -1449.58, 1614.07, 1052.53, 269.2, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, '', '0'),
(375, 1, 10, 537, 2547.55, 2552.08, 10.547, 189.7, 1000, 0, -1, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, -1, -1, 0, 0, '', '0'),
(376, 1, 10, 538, 1617.63, -1955.26, 13.274, 75.8, 1000, 0, 99, 99, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, -1, -1, 0, 0, '', '0'),
(712, 1, 9, 541, 304.229, -1615.04, 17.4843, 79.6, 1000, 0, 8, 134, 1010, 0, 1075, 3, 0, 0, 0, 0, 0, 1, 0, 0, 49606, 0, '', '0'),
(4395, 1, 4, 407, 1179.03, -1365.21, 14.4168, 270, 999, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(4396, 1, 4, 431, 1250.1, 720.775, 10.9881, 0.9, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 2, 0, 0, '', '0'),
(5503, 1, 10, 560, 2445.58, -2140.36, 13.2611, 359.4, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(5504, 1, 10, 560, 2440.61, -2140.48, 13.261, 0, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(8403, 2, 16, 402, 1025.57, -1347.32, 13.5585, 90.3, 1000, 0, 223, 0, 1010, 0, 1096, 3, 0, 0, 0, 0, 18648, 6, 0, 0, 70069, 0, '', '0'),
(9015, 1, 10, 437, 2491.08, -2138.47, 13.6942, 0, 991.2, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(9016, 1, 10, 560, 2455.73, -2140.37, 13.2609, 359.4, 1000, 0, 129, 129, 1010, 0, 1079, 3, 1139, 1141, 1169, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(9754, 2, 22, 560, 1705.66, -1489.97, 13.0893, 178.6, 1000, 0, 141, 0, 1010, 0, 1082, 3, 1023, 1141, 1169, 0, 0, 4, 0, 0, 49626, 0, '', '0'),
(11276, 2, 23, 560, 1803.73, -1131.65, 23.7905, 140, 994.4, 0, 1, 11, 1010, 0, 1081, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(11277, 1, 5, 560, 735.244, -1438.48, 13.2441, 89, 1000, 0, 0, 15, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(11616, 2, 23, 428, 1788.3, -1124.19, 24.2119, 179.7, 1000, 0, 15, 15, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(11617, 1, 9, 560, 302.648, -1623.08, 17.5576, 78.1, 983.5, 0, 8, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(12390, 1, 9, 582, 270.403, -1617.27, 17.9181, 259.8, 1000, 0, 134, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(12391, 1, 9, 522, 300.163, -1643.23, 17.4285, 79.4, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(12392, 1, 9, 522, 299.646, -1638.97, 17.5434, 79.9, 1000, 0, 134, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(15807, 1, 8, 482, 12.1193, -228.433, 5.61684, 87.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(15886, 1, 1, 415, 1564.78, -1711.79, 5.59754, 358.2, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15888, 1, 1, 411, 1558.71, -1711.65, 5.6177, 358.3, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15893, 1, 1, 402, 1538.67, -1644.79, 6.0462, 180.8, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15894, 1, 1, 528, 1530.95, -1644.8, 5.87221, 180.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15895, 1, 1, 596, 1602.09, -1704.42, 5.62674, 88.6, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15897, 1, 1, 599, 1591.25, -1711.41, 5.99165, 0.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(15898, 1, 1, 415, 1574.87, -1711.88, 5.6624, 0.1, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15899, 1, 1, 523, 1603.3, -1688.88, 5.47203, 89, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(15901, 1, 1, 482, 1545.94, -1659.12, 6.02989, 89.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, '', '0'),
(17091, 1, 9, 560, 301.893, -1627, 17.5563, 80.8, 1000, 0, 8, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(17203, 1, 4, 482, 1176.67, -1308.78, 14.0007, 269.5, 1000, 0, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(17943, 2, 9, 468, -770.208, 1633.81, 26.8648, 263, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(18670, 2, 1, 426, 1282.92, -1376.74, 13.2413, 0.2, 1000, 0, 0, 174, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(18671, 2, 1, 426, 1282.88, -1369.6, 13.2438, 0.1, 1000, 0, 0, 174, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(18672, 2, 1, 426, 1282.96, -1361.97, 13.2482, 359.5, 1000, 0, 0, 252, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(18673, 2, 1, 580, 1275.96, -1360.1, 12.8947, 0.1, 1000, 0, 123, 69, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(18674, 2, 1, 490, 1276.36, -1366.77, 12.8918, 0.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(18708, 1, 2, 490, 1051.77, 1506.99, 6.43622, 270.7, 1000, 0, 223, 223, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(18711, 1, 2, 426, 1087.39, 1533.7, 6.42632, 0.3, 990.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(18723, 1, 2, 430, 741.795, -1913.55, 1.77464, 193.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, '', '0'),
(18990, 1, 2, 426, 606.486, -1494.6, 14.7233, 90.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '0'),
(21380, 1, 2, 426, 1078.87, 1533.97, 5.61373, 0.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(21381, 1, 2, 579, 1112.1, 1518.13, 6.29624, 180.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, '', '0'),
(24196, 2, 9, 421, 2128.66, -1738.93, 13.4455, 179.2, 1000, 0, 0, 0, 1010, 0, 1025, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(25781, 1, 11, 487, 1487.77, -1832.52, 13.6606, 177.6, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(30600, 1, 5, 579, 523.785, -1480.31, 14.4899, 181.6, 1000, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(31697, 1, 5, 579, 770.712, -1422.82, 13.4073, 4.6, 1000, 0, 0, 0, 1010, 1, 1073, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(31831, 1, 1, 523, 1603.19, -1687.01, 5.47212, 89.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 'SASP006', '0'),
(31836, 1, 9, 541, 303.299, -1619, 17.5445, 79, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 'SASP011', '0'),
(32076, 1, 10, 577, 1943.08, -2293.78, 13.4556, 5.5, 1000, 0, 129, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(34581, 1, 1, 596, 1571.59, -1605.53, 13.1033, 180.1, 985.9, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(37688, 1, 1, 596, 1548.62, -1605.72, 13.1031, 179.8, 997.4, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(37958, 1, 1, 430, 64.3142, -1553.64, -0.167562, 192.3, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(40110, 1, 2, 405, 1087.3, 1517.97, 6.29647, 179.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(40177, 1, 2, 560, 1111.65, 1533.98, 5.57558, 359.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(40416, 1, 4, 416, 1095.61, -1301.02, 13.7214, 359.9, 987, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(40432, 1, 4, 407, 1178.81, -1361.33, 14.4351, 270.6, 998.8, 0, 3, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(40436, 1, 4, 407, 1178.71, -1357.27, 14.4593, 270.3, 1000, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(40929, 1, 9, 409, 275.924, -1589.64, 17.6602, 259.4, 923.2, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, '', '0'),
(40933, 1, 9, 456, 277.245, -1586.02, 18.0343, 259.6, 998, 0, 8, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, '', '0'),
(41877, 1, 10, 437, 2496.06, -2138.53, 13.6942, 0.4, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(43160, 1, 5, 522, 716.063, -1427.07, 13.0992, 178.4, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(44332, 2, 22, 468, 1695.57, -1511.06, 13.0519, 359.5, 887.7, 0, 141, 200, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(44623, 2, 15, 525, 1760.51, -1680.15, 13.4382, 89.5, 998.4, 0, 124, 252, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(44624, 2, 15, 560, 1760.81, -1665.16, 13.2637, 89.8, 1000, 0, 4, 4, 1010, 0, 0, 3, 1139, 1141, 1169, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(46345, 1, 2, 560, 609.018, -1520.03, 15.397, 358.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(46535, 1, 1, 596, 1542.95, -1605.53, 13.1021, 179.6, 991.2, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(46536, 1, 1, 497, 1569.6, -1707.83, 28.5714, 88.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(46779, 1, 1, 596, 1560.12, -1605.57, 13.1036, 180.5, 995, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(47219, 2, 23, 522, 1804.91, -1146.81, 23.4948, 91.1, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(47390, 1, 4, 416, 1104.18, -1300.66, 13.7242, 359.9, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(49029, 1, 10, 499, 2511.37, -2070.56, 13.5517, 179.4, 980.1, 0, 39, 39, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(49030, 1, 10, 420, 2429.02, -2113.29, 13.3352, 269.3, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(49615, 1, 2, 405, 606.547, -1502.43, 14.8319, 90.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(49691, 1, 4, 416, 1283.55, 764.821, 11.0388, 179.7, 989, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(50013, 1, 2, 560, 593.31, -1519.45, 14.8672, 358.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(50261, 1, 10, 420, 2501.9, -2085.78, 13.3389, 269.8, 1000, 0, 6, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(51025, 1, 7, 484, 811.085, -2124.44, -0.018771, 175.8, 987.2, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(51174, 2, 1, 579, 1276.22, -1373.87, 12.9013, 358, 1000, 0, 44, 69, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(51175, 2, 1, 579, 1276.27, -1381.19, 12.8679, 359, 1000, 0, 44, 69, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(51176, 2, 1, 484, 869.384, -2123.06, 0.11783, 179.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(51178, 1, 8, 507, 12.0245, -244.967, 5.25437, 89, 982.9, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(51485, 2, 9, 468, 2181.07, -1784.22, 13.0262, 359.7, 960, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(51651, 1, 4, 472, 703.198, -1927.84, 0.914435, 179.6, 1000, 0, 3, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(52905, 1, 1, 560, 1546.09, -1676.39, 5.59558, 89.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(52906, 1, 1, 560, 1546.16, -1672.14, 5.59556, 89.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(52924, 1, 9, 487, 274.29, -1606.32, 115.489, 261.6, 1000, 0, 219, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(53830, 1, 9, 582, 271.741, -1609.39, 17.9184, 258.8, 1000, 0, 134, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(54039, 1, 2, 560, 604.612, -1520.17, 15.1999, 0.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(55035, 2, 23, 591, 1776.46, -1124.27, 24.6644, 180.3, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(55049, 2, 23, 403, 1776.6, -1133.27, 24.675, 180.3, 978.1, 0, 149, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(55375, 2, 23, 482, 1784.69, -1124.64, 24.2021, 182.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(55434, 1, 1, 426, 1587.63, -1711.56, 5.63347, 359.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(55435, 1, 1, 426, 1545.9, -1663.1, 5.63356, 89.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(55518, 1, 2, 490, 1051.84, 1511.17, 6.41424, 269.5, 1000, 0, 223, 223, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(55519, 1, 2, 445, 1079.04, 1517.83, 6.56584, 178.8, 989, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(55520, 1, 2, 445, 1075.06, 1517.93, 6.31326, 180.1, 998, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(55589, 1, 7, 487, 1522.73, -1458.14, 64.0338, 357.7, 987.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(56125, 2, 15, 560, 1760.89, -1672.67, 13.3391, 89.6, 1000, 0, 4, 4, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(56165, 2, 23, 522, 1805.04, -1145.57, 23.5264, 97.9, 998, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(56166, 2, 23, 522, 1804.93, -1143.9, 23.5723, 89, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(56167, 2, 23, 522, 1804.66, -1136.83, 23.6675, 92, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(56361, 2, 9, 409, 2174.91, -1808.99, 13.1545, 270.5, 958.7, 0, 3, 3, 1008, 0, 0, 3, 0, 0, 0, 0, 18652, 1, 0, 0, 0, 0, '', '0'),
(56484, 1, 11, 474, 1411.85, -1755.78, 13.3433, 179.6, 995.4, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(57308, 1, 4, 490, 1121.75, -1300.33, 13.7006, 0.3, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(57313, 4, 2, 405, 289.132, -1516.69, 24.595, 90.5, 994.4, 0, 2, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, '', '0'),
(57505, 1, 1, 599, 87.1293, -1556.44, 6.58198, 345, 1000, 0, 186, 186, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(58059, 1, 3, 430, 11.9039, -1552.31, -0.474971, 138.7, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(58400, 2, 23, 487, 1791.86, -1155.34, 29.0282, 180.5, 995.8, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(58711, 1, 1, 560, 1583.38, -1711.73, 5.54424, 0.1, 825, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(58724, 1, 11, 560, 1408.13, -1795.28, 13.2463, 91.8, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(58725, 1, 11, 560, 1408.3, -1785.27, 13.2674, 89.6, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(58726, 1, 11, 580, 1414.98, -1755.68, 13.343, 180.6, 1000, 0, 214, 214, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(58843, 2, 23, 522, 1804.83, -1139.65, 23.6407, 92, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(58844, 1, 2, 579, 1058.43, 1501.6, 6.52046, 359.7, 1000, 0, 255, 255, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(58845, 1, 2, 579, 1062.5, 1501.48, 5.80413, 0.8, 1000, 0, 255, 255, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(58861, 1, 2, 426, 1066.98, 1501.4, 6.45114, 359.7, 998.7, 0, 255, 255, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(58862, 1, 2, 426, 1070.55, 1501.43, 6.37975, 358.2, 1000, 0, 255, 255, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(58863, 2, 23, 560, 1798.82, -1131.52, 23.7908, 141.3, 1000, 0, 1, 1, 1010, 0, 1081, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(59027, 2, 23, 522, 1804.91, -1148.48, 23.4319, 90.1, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(59306, 1, 8, 596, -42.2566, -216.589, 5.10709, 174.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59307, 1, 8, 598, -38.2637, -216.934, 5.17593, 173.8, 989.5, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59309, 1, 8, 599, -30.5145, -217.812, 5.61823, 173.7, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59310, 1, 8, 490, -26.6325, -218.161, 5.55759, 175.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59311, 1, 8, 528, -22.7027, -218.544, 5.47332, 173.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59312, 1, 8, 407, -31.1731, -232.264, 5.6637, 269.7, 999.2, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59313, 1, 8, 416, -21.0718, -232.159, 5.57582, 270.1, 1000, 0, 1, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59315, 1, 8, 523, -46.5335, -215.757, 5.00017, 176.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59316, 1, 8, 523, -44.9366, -216.006, 5.00042, 174, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59317, 1, 8, 420, -18.7831, -218.706, 5.20988, 175.3, 1000, 0, 6, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59318, 1, 8, 470, -14.9281, -219.432, 5.42441, 172.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59319, 1, 8, 498, 12.2789, -224.141, 5.49882, 91.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59320, 1, 8, 409, -7.66424, -238.51, 5.22969, 179.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(59321, 1, 8, 560, 11.8525, -257.203, 5.13481, 92.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59322, 1, 8, 582, -11.4406, -220.412, 5.48979, 171.1, 1000, 0, 1, 84, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59323, 1, 8, 560, 11.7079, -236.439, 5.13471, 90.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59324, 1, 8, 560, 11.7308, -240.606, 5.13455, 89.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59325, 1, 8, 510, 11.3431, -248.485, 5.03343, 85, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59434, 2, 22, 470, 1705.37, -1518.94, 13.3077, 358.3, 792.6, 0, 0, 0, 1010, 1, 1082, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(59718, 1, 10, 420, 2429.1, -2108.34, 13.336, 269.3, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(59719, 1, 10, 456, 2516.44, -2071.2, 13.7338, 180.5, 1000, 0, 39, 39, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(59723, 1, 9, 560, 301.208, -1631.07, 17.5641, 79.2, 1000, 0, 8, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60003, 1, 4, 599, 1079.39, -1320.28, 13.7753, 270.1, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, '', '0'),
(60004, 1, 4, 598, 1075.82, -1308.85, 13.2753, 270.1, 991.9, 0, 3, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(60243, 2, 15, 456, 1759.61, -1669.29, 13.7343, 90.1, 1000, 0, 4, 4, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(60244, 2, 15, 552, 1760.39, -1675.62, 13.2555, 89.8, 1000, 0, 1, 4, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60246, 2, 15, 525, 1760.34, -1660.57, 13.4434, 90, 1000, 0, 3, 4, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60285, 1, 8, 522, -909.436, 2672.28, 41.9425, 134.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60296, 1, 8, 415, -7.60286, -252.225, 5.2011, 178.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60297, 1, 8, 415, -7.52375, -245.802, 5.15118, 181.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60298, 2, 7, 454, 2292.37, 518.09, 0.096218, 269.2, 982.5, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60394, 1, 1, 596, 1602.47, -1695.8, 5.62634, 90.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(60395, 1, 1, 596, 1602.64, -1691.97, 5.62664, 91.5, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(60469, 2, 16, 525, 997.346, -1364.53, 13.2006, 359.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60470, 2, 16, 525, 996.949, -1374.11, 13.1706, 359.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60474, 2, 16, 482, 979.417, -1260.69, 16.5341, 178.8, 1000, 0, 239, 205, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60475, 2, 16, 602, 1025.34, -1343.17, 13.5327, 90.7, 982.7, 0, 223, 239, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60487, 2, 18, 445, 452.939, -1811.76, 5.22544, 0.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 143780, 0, 0, 0, 0, 0, 0, '', '0'),
(60583, 2, 16, 560, 1025.8, -1351.51, 13.4318, 88.6, 986.3, 0, 239, 205, 0, 0, 0, 3, 0, 1140, 1170, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60584, 2, 16, 560, 1025.17, -1339.69, 13.4042, 90.1, 999.1, 0, 239, 205, 0, 0, 0, 3, 0, 1141, 1169, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60680, 2, 9, 426, -738.021, 1641.43, 27.0591, 181.3, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60715, 1, 9, 541, 304.937, -1611.17, 17.4844, 79.8, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60716, 1, 9, 560, 300.615, -1634.95, 17.5642, 80.5, 1000, 0, 8, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60717, 1, 9, 541, 305.713, -1603.07, 17.6758, 80.3, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60718, 1, 9, 541, 304.995, -1606.92, 17.6771, 80.3, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60719, 1, 9, 487, 273.352, -1614.45, 114.974, 261, 955, 0, 219, 219, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(60736, 2, 18, 402, 448.795, -1811.79, 5.2899, 359.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60763, 2, 16, 552, 1033.41, -1338.19, 13.4697, 268.6, 1000, 0, 205, 205, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60799, 2, 26, 515, 829.507, -607.813, 17.3982, 2.9, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60805, 2, 26, 530, 859.343, -603.68, 18.185, 356.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60807, 2, 26, 455, 820.05, -609.16, 16.7782, 0.3, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60817, 2, 26, 486, 857.24, -585.343, 18.3098, 179.1, 997.9, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60829, 1, 5, 487, 724.088, -1458.58, 22.4235, 1, 250, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(60830, 1, 5, 560, 713.655, -1438.77, 13.2442, 273.6, 250, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60831, 1, 5, 579, 703.965, -1422.74, 13.4726, 359.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(60832, 1, 5, 579, 699.122, -1436, 13.467, 328.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(60833, 1, 5, 482, 767.968, -1435.09, 13.6472, 356.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(60834, 1, 5, 550, 756.636, -1432.2, 13.3439, 89.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(60835, 1, 5, 521, 765.84, -1419.35, 13.1065, 5.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(60836, 1, 5, 521, 767.488, -1419.42, 13.1081, 358, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(60837, 1, 5, 498, 844.248, -600.584, 18.4921, 358.4, 992, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60848, 2, 5, 445, 489.153, -1524.01, 19.8733, 194.1, 1000, 0, 26, 26, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60849, 2, 5, 445, 490.707, -1530.71, 19.3471, 196, 1000, 0, 26, 26, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60850, 2, 5, 579, 481.802, -1527.21, 19.7646, 192.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60851, 2, 5, 498, 483.917, -1534.54, 19.4333, 199.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 0, 0, 0, '', '0'),
(60883, 2, 5, 470, 1131.42, -1696.35, 13.6484, 269.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(60884, 2, 5, 500, 1116.75, -1700.1, 13.6668, 270.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60885, 2, 5, 560, 1131.93, -1674.75, 13.3774, 272.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(60886, 2, 5, 576, 1223.14, -1559.54, 13.1404, 179.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60937, 2, 9, 433, -88.7368, -1217.57, 3.13903, 78, 995, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(60948, 1, 15, 560, 1090.68, -1217.01, 17.65, 358.9, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(60949, 1, 15, 482, 1098.2, -1190.48, 18.3912, 179, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(60950, 1, 15, 525, 1116.15, -1244.1, 16.0192, 0.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60961, 2, 18, 560, 440.284, -1812.33, 5.25218, 0.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 0, 0, 0, '', '0'),
(60962, 2, 9, 560, -883.861, 1520.35, 25.619, 349.6, 1000, 0, 123, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(60963, 2, 18, 411, 436.422, -1812.11, 5.27396, 0.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 0, 0, 0, '', '0'),
(60964, 1, 15, 562, 1095.72, -1218.2, 17.4637, 359.9, 518, 0, 56, 56, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60965, 1, 15, 554, 1086.12, -1195.59, 18.1505, 270, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(60993, 2, 18, 409, 422.133, -1796.92, 5.34688, 359.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61025, 1, 4, 525, 1075.96, -1302.03, 13.4316, 271, 989.6, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(61030, 2, 26, 440, 930.704, -1712.75, 13.6586, 90, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61032, 2, 26, 440, 930.593, -1716.41, 13.6624, 88.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61033, 2, 26, 554, 930.587, -1720.25, 13.6305, 89.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61034, 2, 26, 609, 872.094, -594.712, 18.1957, 87.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61067, 1, 15, 579, 1084, -1200.73, 17.6676, 180.1, 998.5, 0, 79, 79, 1010, 0, 1096, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61068, 2, 18, 451, 432.139, -1813.19, 5.34687, 0.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61070, 2, 18, 522, 421.69, -1808.14, 5.13685, 3.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61071, 2, 18, 522, 421.782, -1805.14, 5.13235, 358.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61093, 2, 18, 415, 452.686, -1801.59, 5.32028, 90.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61094, 2, 18, 541, 452.736, -1804.75, 5.32015, 89.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61302, 1, 2, 415, 1099.77, 1550.48, 5.64235, 179.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 7, 0, 2, 0, 0, '', '0'),
(61485, 2, 5, 560, 1131.99, -1678.27, 13.38, 270.2, 957.4, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(61486, 2, 5, 522, 1133.04, -1668.16, 13.2851, 270.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(61487, 2, 5, 498, 1127.15, -1664.07, 13.9016, 269, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61488, 2, 5, 482, 1135.63, -1664.08, 13.9842, 269.2, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61489, 2, 5, 470, 1131.38, -1693.21, 13.6457, 269.8, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(61612, 1, 5, 403, 665.08, -1547.2, 15.4592, 88.1, 999.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(61613, 1, 5, 591, 675.404, -1547.23, 15.4199, 88.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61736, 1, 15, 468, 1112.8, -1188.4, 18.0172, 90.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61769, 6, 118950, 444, 1051.68, 1525.36, 52.4949, 269.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61771, 2, 9, 560, -879.681, 1519.89, 25.6194, 353.6, 1000, 0, 123, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(61772, 6, 118950, 444, 1052.4, 1513.89, 51.6197, 270, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61773, 6, 118950, 444, 1141.44, 1548.67, 51.3654, 90.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61774, 6, 118950, 444, 1141.96, 1535.31, 52.3664, 89.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61775, 6, 118950, 444, 1142.55, 1523.52, 52.3487, 90.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61776, 6, 118950, 444, 1142.54, 1513.16, 51.5729, 89.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61854, 6, 118950, 444, 1052.02, 1548.83, 51.3535, 270, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61855, 6, 118950, 444, 1051.37, 1535.38, 52.3458, 270.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '0'),
(61882, 2, 16, 482, 973.079, -1262.61, 16.2134, 179.6, 1000, 0, 183, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(61889, 1, 2, 428, 614.365, -1515.55, 15.1028, 270.7, 1000, 0, 158, 158, 0, 0, 0, 3, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, '', '0'),
(62059, 1, 4, 490, 1108.4, -1300.73, 13.6662, 0, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(62060, 2, 9, 490, 1274.74, -813.736, 83.8016, 270.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(62061, 1, 4, 407, 1287.73, 747.99, 11.1245, 359.7, 981.5, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(62065, 1, 9, 582, 272.612, -1605.39, 17.9152, 259.2, 1000, 0, 8, 134, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(62066, 1, 9, 582, 273.348, -1601.4, 17.955, 260.1, 1000, 0, 134, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(62201, 1, 10, 560, 2450.6, -2140.41, 13.2613, 0.5, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(62214, 1, 7, 490, -1283.04, 2514.29, 87.2012, 177.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(62215, 1, 7, 490, -1278.59, 2514.2, 87.4312, 182.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(62365, 2, 5, 560, 1131.98, -1671.17, 13.3784, 269.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(62486, 1, 15, 402, 1097.71, -1227.03, 15.5249, 178.4, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(62487, 1, 15, 470, 1106.19, -1193.17, 18.1311, 179.8, 999.5, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(62531, 2, 9, 470, -766.445, 1601.32, 27.0424, 93.5, 1000, 0, 3, 3, 1010, 1, 1025, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(62615, 1, 1, 596, 1577.37, -1605.88, 13.1029, 179.9, 994.8, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(62616, 1, 1, 596, 1588.79, -1605.57, 13.1902, 180.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63054, 2, 3, 566, 2765.74, -1960.61, 13.0848, 179.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(63099, 1, 5, 480, 705.656, -1438.68, 13.3132, 298, 250, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63255, 2, 5, 507, 1124.82, -1706.75, 13.2834, 89.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63448, 1, 1, 560, 1546.05, -1680.24, 5.59549, 89.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(63535, 1, 8, 491, 1502.82, 710.423, 10.3984, 252.4, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63536, 1, 8, 491, 1512.19, 706.1, 10.4989, 239.6, 997.5, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63537, 1, 8, 491, 1494.16, 712.784, 10.4984, 264.4, 951.1, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63538, 1, 8, 491, 1484.16, 712.402, 10.4984, 274.3, 992.3, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63539, 1, 8, 491, 1473.72, 709.709, 10.4945, 291.3, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63544, 1, 8, 560, 294.731, -179.163, 1.28253, 91, 1000, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(63545, 1, 8, 560, 294.642, -175.243, 1.28367, 90.1, 1000, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(63548, 1, 8, 560, 1413.38, 705.101, 10.523, 269.2, 645.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(63550, 1, 8, 521, 1463, 723.089, 10.3941, 191.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(63551, 1, 8, 521, 1461.05, 722.612, 10.3917, 200, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(63555, 1, 8, 554, 1413.59, 742.925, 10.9056, 269, 1000, 0, 0, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(63556, 1, 8, 426, 1433.61, 733.231, 10.5535, 178.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63558, 1, 8, 551, 1433.69, 740.191, 10.6207, 180.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0');
INSERT INTO `mru_cars` (`UID`, `ownertype`, `owner`, `model`, `x`, `y`, `z`, `angle`, `hp`, `tires`, `color1`, `color2`, `nitro`, `hydraulika`, `felgi`, `malunek`, `spoiler`, `bumper1`, `bumper2`, `keys`, `neon`, `ranga`, `int`, `vw`, `oldid`, `pdvehmod`, `Rejestracja`, `mru_carscol`) VALUES
(63559, 1, 8, 429, 1413.59, 698.51, 10.5, 269.5, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(63561, 1, 8, 459, 1413.04, 749.507, 10.8737, 270.1, 1000, 0, 1, 8, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63566, 1, 8, 513, 1544.46, 783.184, 11.3724, 130.1, 915.4, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(63567, 1, 8, 469, 1481.44, 784.263, 10.624, 133.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(63568, 2, 9, 487, -755.921, 1628.64, 27.2946, 177.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(63673, 1, 13, 415, 197.684, -148.512, 1.35057, 1, 1000, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(63938, 1, 4, 490, 1113.69, -1300.59, 13.7002, 1.6, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(63939, 1, 4, 544, 1304.12, 748.612, 11.1237, 0.9, 1000, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(63940, 1, 4, 544, 1308.31, 748.576, 11.1244, 0.5, 992, 0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(63958, 1, 13, 415, 201.395, -148.428, 1.35229, 359.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(63963, 1, 13, 522, 210.276, -150.567, 1.1588, 307.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(63964, 2, 9, 541, 1282.73, -813.694, 83.2864, 269.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(64030, 1, 1, 470, 1602.52, -1683.93, 5.88307, 90.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 2, 0, 0, '', '0'),
(64069, 1, 2, 554, 1132.53, 1550.39, 5.9607, 180.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 2, 0, 0, '', '0'),
(64070, 1, 2, 601, 1134.2, 1524.09, 5.62926, 90.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, -1, 2, 0, 0, '', '0'),
(64071, 1, 2, 601, 1134.37, 1528.59, 5.62927, 89.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, -1, 2, 0, 0, '', '0'),
(64072, 1, 2, 440, 1128.39, 1551.01, 5.98226, 178.6, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 2, 0, 0, '', '0'),
(64073, 1, 2, 440, 1124.4, 1551.01, 5.98313, 180.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 2, 0, 0, '', '0'),
(64201, 1, 1, 497, 1549.13, -1707.83, 28.5715, 89.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64306, 1, 5, 482, 654.722, -444.666, 16.4626, 271.8, 895, 0, 252, 252, 1010, 1, 1078, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64489, 2, 18, 562, 444.353, -1812.33, 5.2055, 1.5, 1000, 0, 0, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64493, 1, 7, 487, 1537.81, -1457.9, 64.0359, 357.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, -1, 0, 0, 0, '', '0'),
(64494, 1, 7, 469, 1522.72, -1477.15, 63.8643, 178, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, '', '0'),
(64606, 1, 15, 559, 1113.89, -1193.5, 17.716, 182.8, 1000, 0, 98, 98, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(64607, 1, 15, 562, 1110.64, -1217.98, 17.463, 359.8, 988.3, 0, 86, 86, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(64608, 1, 15, 562, 1104.37, -1245.31, 15.6347, 39.2, 1000, 0, 112, 112, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64609, 1, 15, 477, 1090.56, -1231.07, 15.7017, 237.8, 1000, 0, 43, 43, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64610, 1, 15, 475, 1110.04, -1193.3, 17.8973, 178.6, 1000, 0, 0, 0, 1010, 0, 1097, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64611, 2, 13, 508, -1070.07, -1631.89, 76.7422, 354.3, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(64612, 2, 13, 498, -1103.14, -1622.38, 76.4986, 270.9, 1000, 0, 24, 24, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(64613, 2, 13, 468, -1098.08, -1654, 76.0361, 354.3, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(64614, 2, 13, 471, -1092.61, -1654.13, 75.856, 355.1, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64615, 2, 13, 471, -1095.35, -1653.77, 75.8554, 2, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64694, 2, 13, 543, -1094.96, -1613.09, 76.1847, 181.1, 1000, 0, 5, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64695, 2, 13, 478, -1063.38, -1611.68, 76.3581, 273.6, 1000, 0, 4, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64722, 2, 22, 487, 1681.91, -1506.87, 18.7014, 262.2, 1000, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, -1, 0, 0, 0, '', '0'),
(64723, 2, 22, 515, 1705.14, -1530.98, 14.402, 0.6, 1000, 0, 141, 141, 1010, 0, 1082, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(64724, 2, 22, 433, 1715.01, -1473.55, 13.9835, 90.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(64725, 2, 22, 470, 1705.48, -1508.78, 13.3833, 0.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, -1, 0, 0, 0, '', '0'),
(64726, 2, 22, 468, 1695.41, -1497.28, 13.0518, 359, 1000, 0, 141, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64727, 2, 22, 468, 1695.3, -1500.98, 13.0518, 2.1, 1000, 0, 141, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64728, 2, 22, 468, 1695.5, -1507.74, 13.052, 357.7, 1000, 0, 141, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64729, 2, 22, 468, 1695.41, -1504.24, 13.0512, 0, 1000, 0, 141, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(64730, 2, 22, 591, 1705.18, -1542.62, 14.0228, 1.5, 996.6, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64842, 2, 9, 489, -748.073, 1641.28, 27.3519, 182.3, 1000, 0, 123, 123, 1010, 1, 1025, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64895, 1, 14, 560, 2243.55, -1046.32, 53.7106, 43, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64896, 1, 14, 560, 2239.2, -1041.9, 55.1345, 44.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(64898, 1, 14, 522, 2220.59, -1044.19, 57.4107, 311.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(64929, 1, 1, 579, 1546.19, -1684.24, 5.82303, 88.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 2, 0, 0, '', '0'),
(64930, 1, 1, 579, 1546.07, -1688.25, 5.82331, 88.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, '', '0'),
(64950, 1, 10, 522, 2429.41, -2140, 13.1198, 315, 1000, 0, 129, 129, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(64951, 1, 10, 409, 2475.9, -2139.95, 13.356, 359.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(64966, 2, 9, 462, 2260.16, -1695.58, 13.3193, 2.8, 981.4, 0, 6, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, '', '0'),
(65004, 2, 9, 482, -741.572, 1641.27, 27.3948, 182.7, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 163507, 0, 0, 0, 0, 0, 0, '', '0'),
(65046, 1, 4, 416, 1099.78, -1300.77, 13.7241, 1.5, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65047, 1, 4, 416, 1091.3, -1301.09, 13.6455, 359.6, 1000, 0, 3, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65048, 1, 4, 426, 1076.06, -1305.42, 13.3219, 270.3, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(65050, 1, 4, 490, 1117.03, -1300.52, 13.7021, 1.2, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65053, 1, 4, 487, 1162.61, -1310.02, 31.6711, 269, 1000, 0, 3, 6, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65120, 2, 22, 415, 1708.8, -1482.84, 13.2852, 180.7, 1000, 0, 141, 141, 1010, 0, 1082, 3, 1023, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(65159, 1, 4, 472, 706.99, -1928.57, 0.650228, 180.6, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65167, 2, 5, 560, 1131.91, -1682.02, 13.3776, 271, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65168, 1, 8, 560, 1413.45, 702.005, 10.5256, 269.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65169, 2, 5, 522, 1137.21, -1668.3, 13.4203, 269.2, 999.8, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65197, 2, 16, 543, 1020.47, -1363.53, 13.3738, 0.8, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65235, 2, 9, 600, -744.912, 1641.39, 26.9762, 181, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65237, 2, 9, 579, -778.411, 1631.3, 27.0447, 169.9, 918.6, 0, 123, 0, 1010, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65259, 2, 9, 595, -858.986, 1385.17, 0.175045, 227.3, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(65260, 2, 9, 595, -850.259, 1386.09, 0.11426, 221.9, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65261, 2, 9, 470, -765.948, 1596.95, 27.1102, 98.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65282, 1, 13, 560, 205.555, -148.507, 1.39084, 0.8, 898.2, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65283, 1, 13, 560, 211.046, -154.264, 1.27264, 273.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, -1, 0, 0, 0, '', '0'),
(65284, 1, 13, 579, 196.571, -155.896, 1.45368, 179, 999.1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(65311, 2, 9, 545, -819.291, 1629.13, 26.8266, 178.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65384, 2, 22, 560, 1705.76, -1484.14, 13.0875, 178.8, 959, 0, 141, 0, 1010, 0, 0, 3, 1139, 1141, 1169, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(65386, 2, 14, 560, 1292.96, 224.147, 19.2596, 66.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65499, 2, 9, 424, 2331.82, 11.213, 26.2613, 267, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65526, 2, 18, 587, 439.681, -1800.83, 5.27254, 88.2, 997.9, 0, 0, 0, 1010, 0, 1082, 3, 1023, 0, 0, 168332, 0, 1, 0, 0, 0, 0, '', '0'),
(65540, 2, 9, 483, 2171.48, -1792.38, 13.3381, 274, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65541, 2, 5, 579, 1154.54, -1666.48, 13.7938, 358.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65542, 2, 5, 579, 1154.84, -1659.19, 13.793, 359.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65543, 2, 5, 426, 1132.34, -1707.19, 13.3612, 89.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65554, 1, 4, 579, 1079.54, -1316.89, 13.5119, 270.6, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, '', '0'),
(65555, 1, 4, 427, 1076.84, -1298.26, 13.6754, 270.6, 996.7, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(65581, 2, 3, 567, 2765.85, -1953.5, 13.0984, 180.1, 994.4, 0, 0, 0, 0, 1, 1077, 3, 0, 0, 0, 172185, 0, 1, 0, 0, 0, 0, '', '0'),
(65583, 1, 4, 416, 1079.01, -1324.07, 13.7415, 269.7, 1000, 0, 3, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65588, 2, 9, 554, -792.633, 1597.89, 27.2001, 180.2, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65589, 2, 9, 554, -787.838, 1596.2, 27.16, 169.5, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65590, 2, 9, 445, -821.194, 1601.96, 26.9979, 270.1, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65591, 2, 9, 445, -826.872, 1606.62, 27.0064, 357.7, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65592, 2, 9, 500, -797.311, 1591.29, 27.223, 89.8, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65593, 2, 9, 500, -797.352, 1588.59, 27.2235, 88.6, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65594, 2, 9, 492, 218.408, -233.291, 1.51818, 90.7, 909, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65595, 2, 9, 492, 211.752, -233.454, 1.56048, 90.7, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65614, 2, 9, 579, 2188.87, -1771.34, 13.3074, 357.7, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65615, 2, 9, 579, 2188.98, -1778.15, 13.3073, 358.3, 998.7, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65616, 2, 9, 579, 2189.03, -1785.32, 13.3074, 0.2, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65618, 2, 9, 522, 2153.38, -1789.6, 13.0783, 255.6, 992.2, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65619, 2, 9, 522, 2153.36, -1788.62, 13.0824, 258, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65620, 2, 9, 522, 2153.55, -1787.75, 13.0834, 263.3, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65621, 2, 9, 466, 2189.04, -1792.56, 13.1174, 0.1, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65622, 2, 9, 466, 2189.12, -1799.26, 13.1174, 0, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65623, 2, 9, 466, 2189.15, -1806.98, 13.117, 0.1, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65624, 2, 9, 580, 2181.47, -1765.04, 13.1721, 358.7, 972.3, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65625, 2, 9, 575, 2181.17, -1777.98, 12.9655, 359.6, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65632, 2, 9, 467, 2160.34, -1727.91, 13.1871, 88.4, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65644, 2, 5, 468, 1128.67, -1667.97, 13.2666, 270.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(65645, 2, 5, 468, 1125.13, -1668.08, 13.2579, 271, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65646, 2, 5, 554, 1131.92, -1689.76, 13.7555, 269, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65668, 1, 4, 416, 1178.42, -1339.06, 14.0289, 270.1, 1000, 0, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65669, 2, 9, 405, 2153.03, -1727.65, 13.407, 88.6, 1000, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65674, 2, 9, 498, -778.304, 1634.54, 27.1441, 169.4, 1000, 0, 123, 123, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65687, 1, 3, 497, 612.733, -598.686, 22.9233, 272.7, 1000, 0, 193, 193, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(65688, 1, 3, 497, 612.784, -608.52, 23.0029, 274.2, 1000, 0, 193, 193, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65689, 1, 3, 470, 590.248, -608.201, 19.3195, 271.1, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65690, 1, 3, 470, 590.162, -603.601, 19.2992, 270.7, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65691, 1, 3, 470, 590.249, -598.867, 19.1945, 269.7, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65692, 1, 3, 470, 590.16, -594.644, 19.1545, 269.6, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65693, 1, 3, 598, 589.716, -589.476, 18.9695, 267.6, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65694, 1, 3, 598, 589.725, -585.673, 18.9402, 269.5, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65695, 1, 3, 598, 589.711, -581.06, 18.9406, 269.1, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65696, 1, 3, 598, 589.666, -576.821, 18.9408, 269.5, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65697, 1, 3, 433, 638.667, -610.191, 16.7729, 88.2, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65698, 1, 3, 560, 589.45, -572.772, 18.8773, 269.8, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65699, 1, 3, 560, 589.366, -565.217, 18.8979, 270.7, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65700, 1, 3, 560, 589.436, -568.792, 18.8873, 269.7, 1000, 0, 141, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65701, 1, 3, 428, 589.898, -560.753, 19.3317, 269.1, 1000, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65736, 2, 18, 412, 456.99, -1812.02, 5.3847, 359, 991.5, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65746, 2, 28, 471, 2219.76, -1217.14, 23.3122, 268.9, 1000, 0, 205, 205, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65753, 1, 4, 442, 1076.05, -1294.65, 13.3736, 269.9, 956.7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65762, 1, 3, 548, 615.627, -576.779, 27.7814, 266.6, 970, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, -1, 0, 0, 0, '', '0'),
(65763, 1, 3, 470, 612.335, -597.542, 17.2266, 272.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(65764, 1, 3, 470, 612.37, -601.292, 17.2231, 268.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(65765, 1, 3, 595, 1626.8, 566.814, 0.070422, 180.5, 772.1, 0, 0, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65766, 1, 3, 595, 1623, 568.351, 0.192257, 181.8, 1000, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65767, 1, 3, 430, 1631.87, 568.075, -0.020553, 181.3, 992.8, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65768, 1, 3, 599, 596.942, -551.719, 19.3963, 179.3, 1000, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65769, 1, 3, 599, 601.135, -551.881, 19.2978, 179.6, 1000, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65770, 1, 3, 427, 590.766, -556.405, 19.3442, 268.3, 1000, 0, 141, 141, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65771, 1, 3, 553, 331.029, 1992.44, 19.0746, 124, 1000, 0, 193, 193, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(65824, 2, 40, 499, 942.804, -1754.58, 13.5386, 174, 1000, 0, 16, 13, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65826, 2, 40, 455, 946.638, -1756.07, 13.9835, 174.6, 987.2, 0, 16, 13, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65827, 2, 40, 524, 950.931, -1756.46, 14.4754, 172.7, 999.9, 0, 16, 13, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65828, 2, 40, 406, 960.663, -1754.98, 15.0712, 130.8, 1000, 0, 16, 13, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65831, 2, 9, 422, -945.342, 1423.03, 30.1577, 182.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65833, 2, 9, 422, -940.857, 1418.09, 30.1696, 270.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65838, 2, 40, 411, 939.097, -1753.39, 13.274, 176.8, 994.4, 0, 16, 16, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, '', '0'),
(65851, 1, 13, 560, 211.329, -157.267, 1.28322, 269.1, 871.3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65852, 1, 13, 560, 220.117, -140.669, 1.28372, 180.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65853, 1, 13, 560, 216.072, -140.548, 1.21767, 180, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65854, 1, 13, 490, 190.587, -133.316, 1.70463, 180.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, '', '0'),
(65855, 1, 13, 487, 200.722, -167.489, 1.7545, 88.4, 962.5, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(65856, 1, 13, 541, 212.093, -140.829, 1.20361, 179.3, 999.9, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65857, 1, 13, 579, 220.48, -161.34, 1.50986, 181.8, 990.1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65858, 1, 13, 470, 199.367, -135.095, 1.56825, 183.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65859, 1, 13, 445, 181.834, -139.82, 1.37524, 50.7, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65860, 1, 13, 562, 216.592, -161.022, 1.21375, 181.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65867, 2, 28, 492, 2200.72, -1224.49, 23.5942, 269.5, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 181788, 0, 1, 0, 0, 0, 0, '', '0'),
(65873, 2, 23, 560, 1793.37, -1131.55, 23.7869, 138.8, 1000, 0, 1, 0, 1010, 0, 1081, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(65874, 2, 23, 482, 1780.74, -1124.64, 24.2154, 181.1, 1000, 0, 0, 0, 1010, 0, 1098, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(65875, 2, 23, 426, 1785.91, -1145.03, 23.7129, 179.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 6, -1, 0, 0, 0, '', '0'),
(65884, 2, 28, 492, 2217.16, -1224.34, 23.5655, 269.6, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 181788, 0, 1, 0, 0, 0, 0, '', '0'),
(65914, 2, 28, 567, 2208.63, -1224.52, 23.6841, 270.2, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(65915, 2, 28, 412, 2199.04, -1217.05, 23.6502, 269.5, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, '', '0'),
(65916, 2, 28, 481, 2207.79, -1238.89, 23.6641, 321.8, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(65926, 2, 3, 522, 2757.05, -1946.48, 13.1165, 270.3, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, '', '0'),
(65927, 2, 3, 560, 2749.28, -1944.34, 13.4172, 269.5, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, '', '0'),
(65928, 2, 3, 487, 2746.76, -1932.65, 21.5341, 230.4, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, '', '0'),
(65959, 2, 18, 473, 419.789, -1911.42, -0.225703, 182.8, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66029, 1, 5, 543, 655.285, -447.454, 16.1361, 272, 1000, 0, 252, 252, 1010, 1, 1078, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66037, 2, 28, 579, 2207.06, -1217.09, 23.6891, 271.5, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(66038, 2, 28, 468, 2213.26, -1217.11, 23.4891, 278.7, 774.6, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(66039, 2, 28, 482, 2183.71, -1257.05, 24.1202, 78, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(66066, 2, 28, 468, 2216.36, -1217.2, 23.492, 274.1, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66119, 2, 28, 517, 2193.76, -1224.29, 23.6674, 269.8, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66120, 2, 28, 466, 2250.19, -1224.49, 23.5543, 269.6, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66121, 2, 28, 467, 2231.61, -1224.43, 23.5494, 270.6, 1000, 0, 79, 79, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66148, 1, 5, 484, 728.174, -1497.53, 0.324758, 179.1, 997.6, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, -1, 0, 0, 0, '', '0'),
(66149, 1, 5, 551, 524.009, -1490.48, 14.1752, 181, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66150, 1, 5, 540, 1148.62, -1137.41, 23.5165, 270.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66151, 1, 5, 475, 1156.91, -1127.67, 23.667, 178.9, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '0'),
(66152, 1, 5, 554, 851.584, -601.284, 18.5062, 358.1, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(66153, 1, 5, 482, 850.951, -589.208, 18.0991, 179, 1000, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, '', '0'),
(66195, 1, 4, 598, 1130.4, -1330.01, 13.342, 359.3, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, '', '0'),
(66196, 1, 4, 490, 1124.03, -1326.18, 13.5471, 0, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(66197, 1, 4, 579, 1110.98, -1325.71, 13.4561, 0.7, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0'),
(66198, 1, 4, 579, 1097.37, -1325.78, 13.4484, 359.7, 1000, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '', '0');

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
  `wosp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_config`
--

INSERT INTO `mru_config` (`san1`, `san2`, `gangzone`, `gangtimedelay`, `login_audio`, `stanowe_key`, `trucker_magazyn`, `wosp`) VALUES
('http://4stream.pl:18434', 'http://4stream.pl:18434', 0, 300, 'Login_1 Login_2 Login_3 Login_4 Login_5 Login_6', 1411, 8120, 1386075514);

-- --------------------------------------------------------

--
-- Table structure for table `mru_discord`
--

CREATE TABLE IF NOT EXISTS `mru_discord` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1 - frakcja, 2 - rodzina',
  `org_id` int(11) NOT NULL COMMENT 'id organizacji/frakcji',
  `channel_id` text NOT NULL COMMENT 'id kanalu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mru_discord`
--

INSERT INTO `mru_discord` (`id`, `type`, `org_id`, `channel_id`) VALUES
(1, 1, 1, '696503084230246441'),
(2, 1, 2, '696502567944847410'),
(3, 1, 3, '734539213307117587'),
(4, 1, 4, '696502406246301796'),
(5, 1, 5, '696503755629396029'),
(6, 1, 6, '734539708373401680'),
(7, 1, 7, '734539879798538240'),
(8, 1, 8, '696503652399185921'),
(9, 1, 9, '696503843168583721'),
(10, 1, 10, '696503261557162095'),
(11, 1, 11, '696503517099065434'),
(12, 1, 12, '734540464644161547'),
(13, 1, 13, '734540666914209852'),
(14, 1, 14, '734540802671378513'),
(15, 1, 15, '734541009836441680'),
(16, 1, 16, '734541164354732153'),
(17, 1, 17, '696506926825078864'),
(18, 2, 1, '696507102503632906'),
(19, 2, 3, '734541535038668870'),
(20, 2, 7, '734541682510397482'),
(21, 2, 15, '708050397872521328'),
(22, 2, 18, '699689749471953059'),
(23, 2, 23, '708050326338666648'),
(24, 2, 9, '721800286263443487'),
(25, 2, 28, '734542261051850822'),
(26, 2, 3, '737109963939250236');

-- --------------------------------------------------------

--
-- Table structure for table `mru_diseases`
--

CREATE TABLE IF NOT EXISTS `mru_diseases` (
  `uid` int(11) NOT NULL,
  `disease` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`disease`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_graffiti`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `mru_konta`
--

CREATE TABLE IF NOT EXISTS `mru_konta` (
  `UID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nick` varchar(24) COLLATE utf8_polish_ci NOT NULL,
  `Key` varchar(129) COLLATE utf8_polish_ci NOT NULL,
  `Salt` varchar(16) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  `Level` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `Admin` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `DonateRank` tinyint(4) NOT NULL DEFAULT '0',
  `UpgradePoints` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `ConnectedTime` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Registered` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Sex` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Age` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Origin` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `CK` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Muted` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Respect` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Money` int(11) NOT NULL DEFAULT '0',
  `Bank` int(11) NOT NULL DEFAULT '0',
  `Crimes` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Kills` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Deaths` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Arrested` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `WantedDeaths` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Phonebook` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `LottoNr` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Fishes` int(11) NOT NULL DEFAULT '0',
  `BiggestFish` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Job` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Paycheck` int(11) NOT NULL DEFAULT '0',
  `HeadValue` int(11) NOT NULL DEFAULT '0',
  `BlokadaPisania` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Jailed` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `AJreason` varchar(64) COLLATE utf8_polish_ci NOT NULL DEFAULT 'Brak (stary system)',
  `JailTime` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Materials` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `Drugs` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `Lider` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Member` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `FMember` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Rank` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Char` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Skin` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `JobSkin` int(11) NOT NULL DEFAULT '0',
  `ContractTime` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `DetSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `SexSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `BoxSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `LawSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `MechSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `JackSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `CarSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `NewsSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `DrugsSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `CookSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `FishSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `GunSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `TruckSkill` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `pSHealth` float NOT NULL DEFAULT '0',
  `pHealth` float NOT NULL DEFAULT '0',
  `VW` int(11) NOT NULL DEFAULT '0',
  `Int` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Local` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Team` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Model` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `PhoneNr` int(11) NOT NULL DEFAULT '0',
  `Dom` int(11) NOT NULL DEFAULT '0',
  `Bizz` int(11) NOT NULL DEFAULT '255',
  `BizzMember` int(11) NOT NULL DEFAULT '-1',
  `Wynajem` int(11) NOT NULL DEFAULT '0',
  `Pos_x` float NOT NULL DEFAULT '0',
  `Pos_y` float NOT NULL DEFAULT '0',
  `Pos_z` float NOT NULL DEFAULT '0',
  `CarLic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `FlyLic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `BoatLic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `FishLic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `GunLic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun0` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun1` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun2` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun3` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun4` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun5` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun6` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun7` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun8` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun9` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun10` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun11` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Gun12` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo0` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo1` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo2` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo3` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo4` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo5` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo6` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo7` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo8` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo9` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo10` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo11` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Ammo12` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `CarTime` int(11) NOT NULL DEFAULT '0',
  `PayDay` int(11) NOT NULL DEFAULT '0',
  `PayDayHad` int(11) NOT NULL DEFAULT '0',
  `CDPlayer` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Wins` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Loses` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `AlcoholPerk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `DrugPerk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `MiserPerk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `PainPerk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `TraderPerk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Tutorial` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Mission` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Warnings` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Block` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Fuel` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Married` int(11) NOT NULL DEFAULT '0',
  `MarriedTo` varchar(24) COLLATE utf8_polish_ci NOT NULL DEFAULT 'Nikt',
  `CBRADIO` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `PoziomPoszukiwania` int(11) NOT NULL DEFAULT '0',
  `Dowod` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `PodszywanieSie` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ZmienilNick` tinyint(3) UNSIGNED NOT NULL DEFAULT '2',
  `Wino` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Piwo` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Cygaro` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Sprunk` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `PodgladWiadomosci` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `StylWalki` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `PAdmin` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ZaufanyGracz` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Uniform` int(11) NOT NULL DEFAULT '0',
  `CruiseController` tinyint(1) NOT NULL DEFAULT '0',
  `FixKit` tinyint(4) NOT NULL DEFAULT '0',
  `Auto1` int(11) NOT NULL DEFAULT '0',
  `Auto2` int(11) NOT NULL DEFAULT '0',
  `Auto3` int(11) NOT NULL DEFAULT '0',
  `Auto4` int(11) NOT NULL DEFAULT '0',
  `Lodz` int(11) NOT NULL DEFAULT '0',
  `Samolot` int(11) NOT NULL DEFAULT '0',
  `Garaz` int(11) NOT NULL DEFAULT '0',
  `KluczykiDoAuta` int(11) NOT NULL DEFAULT '0',
  `Spawn` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `BW` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `Czystka` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `CarSlots` tinyint(3) UNSIGNED NOT NULL DEFAULT '4',
  `Hat` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `FW` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `Injury` smallint(3) NOT NULL DEFAULT '0',
  `HealthPacks` smallint(3) NOT NULL DEFAULT '0',
  `Immunity` int(11) NOT NULL DEFAULT '10',
  `connected` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UID`),
  UNIQUE KEY `Nick` (`Nick`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_kontakty`
--

CREATE TABLE IF NOT EXISTS `mru_kontakty` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `Owner` int(11) NOT NULL,
  `Number` int(11) NOT NULL,
  `Name` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_last_logons`
--

CREATE TABLE IF NOT EXISTS `mru_last_logons` (
  `Nick` varchar(21) NOT NULL,
  PRIMARY KEY (`Nick`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_liderzy`
--

CREATE TABLE IF NOT EXISTS `mru_liderzy` (
  `NICK` varchar(32) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `UID` int(11) NOT NULL,
  `FracID` int(11) NOT NULL DEFAULT '0',
  `LiderValue` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UID`),
  KEY `FracID` (`FracID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_nazwyrang`
--

CREATE TABLE IF NOT EXISTS `mru_nazwyrang` (
  `ID` int(11) NOT NULL,
  `typ` int(11) NOT NULL COMMENT '1 - frakcja 2 - rodzina',
  `rangi` varchar(256) COLLATE utf8_polish_ci NOT NULL COMMENT 'Skompresowane nazwy rang',
  PRIMARY KEY (`ID`,`typ`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_nazwyrang`
--

INSERT INTO `mru_nazwyrang` (`ID`, `typ`, `rangi`) VALUES
(0, 1, '-, -, Senior Special Agent, Police Officer IIIpI, Senior Special Agent, Sr. Special Agent II, Dyrektor ds finansow, Police Lieutenant II, Deputy TSU Commander, Senior Special Agent'),
(0, 2, 'Rosenberg Industries, Starszy wolontariusz, Asisst. Investigator, Opiekun porz?dkowych, Operations Agent III, Asisst. St. Attorney, Dowodz?cy kurwido?ka, Prokurator Generalny, Zast?pca Gubernatora, -'),
(1, 1, 'Police Officer I, Police Officer II, Police Officer III, Police Officer III, Sergeant I, Sergeant II, Lieutenant I, Lieutenant II, Captain I, Captain II'),
(1, 2, '-, Attorney Associate, Asisst. Invest., Investigator, Principal Invest., District Attorney, State Attorney, Sędzia Stanowy, Z-ca Prezesa, Prezes Sądu'),
(2, 1, '-, New Agent Trainee, Agent, Special Agent, Senior Agent, Supervisory Agent, Spec. Agent I.C., Associate Director, Deputy Director, Director'),
(2, 2, 'Diler, Złodziej, Latynos, Loco Gangster, Gangster Pro, Boss Protector, Boss, -, Boruta Gengmen, Boruta Master'),
(3, 1, 'Candidate, Private Cadet, Private, Specialist, Corporal, Sergeant, Master Sergeant, Sergeant Major, Warrant Officer, Lieutenant'),
(3, 2, 'Polak, Zwykły mieszkaniec, Diler, Gangster, Starszy Gangster, Zastępca Bossa, Boss, -, -, -'),
(4, 1, 'Probationary, Coroner/M.D., FF/PM I, FF/PM II, FF/PM III, Engineer/PiC, Lieutenant, Lieutenant II, Captain, Captain II'),
(4, 2, '-, Podturban, Kuzyn Turban, Brat Turban, Turban, Rodzic Turban, Senior Turban, -, -, -'),
(5, 1, 'Member, Wanna Be, Connectedguy, Familyfriend, Soldier, Capo, Consigliere, Streetboss, Underboss, Boss'),
(5, 2, 'Razvodnik, Vojnik, Desetar, Vodnik, Starij Vodnik, Zastavnik, Porucnik, Kapetan, Pukovnik, General'),
(6, 1, 'Bodyguard, Shatei, Kyodai, Wakagashira, Sateigashira, Saikokomon, Oyabun, -, -, -'),
(6, 2, 'Ochroniarz, Barman, Starszy Barman, Kierownik Barmanów, Asystent, Vice Kierownik KO, Kierownik KO, -, -, -'),
(7, 1, 'Training Agent, Special Agent I, Special Agent II, Special Agent III, Sr. Spec. Agent I, Sr. Spec. Agent II, Sr. Spec. Agent III, Sprv. Special Agent, Assistant SAC, Special Agent I.C.'),
(7, 2, 'Member, Wanna-be, Assosicate, Mercenary, Capitan, Unknown, Orginator, Spectaculary, Phantom, -'),
(8, 1, 'Operator mopa, Czyściciel noży, Relatywista moralny, Akwizytor eutanazji, Wirtuoz noża, Architekt rzezi, Siewca Śmierci, Mistrz zbrodni, -, -'),
(8, 2, 'Włóczęga, Mieszkaniec, -, -, Praktykant, Trener, Kierownik, Zastępca Prezesa, Prezes, -'),
(9, 1, 'Zawieszony, Spiker, Dziennikarz, Prezenter Muzyczny, Reporter, Reporter Śledczy, Redaktor Naczelny, Kierownik, Vice Dyrektor, Dyrektor'),
(9, 2, 'Test, Najemnik, Starszy Najemnik, Bojówka, Bojówka, Dowódca, Generał, Doradca Kalifa, Prawa Ręka Kalifa, Kalif'),
(10, 1, 'Mechanik, Kierowca, Starszy Kierowca, Taksówkarz, Pilot, Kierownik, Zastępca Prezesa, Prezes, -, -'),
(10, 2, 'Wanna Be, Member, Trusted Member, Old Bloods, B.D., B.K., -, -, -, -'),
(11, 1, 'Legenda, ...., ...., ..., Prokurator Stanowy, Sędzia Najwyższy, Senator, Sekretarz, Z-ca Gubernatora, Gubernator'),
(11, 2, 'Out soldier, Wanna Be, Member, Old member, Young soldier, Soldier, Young captain, Captain, Y.O.G, O.G'),
(12, 1, 'Homie, Little Gangster, Young Gangster, True Gangster, Big Gangster, R.G., Young O.G., O.G., -, -'),
(12, 2, 'Stażysta, Mechanik, Ochroniarz, Sprzedawca, Marketer, Zawodowy Sprzedawca, Kierownik, Inwestor, Vice Prezes, Prezes'),
(13, 1, 'Wanna Be, Member, Associate, Mercenary, Captain, Unknown, Orginator, Spectaculary, Phantom, -'),
(13, 2, 'Hangaround, Łotr, Pomagier, Cham, Redneck, Bimbrownik, Szef, -, -, -'),
(14, 1, 'Klapek, Mało znany, Cwaniaczek, Bandyta, Znany Gangster, Poważny Gangster, Prawa Ręka, Boss, Ojciec Chrzestny, -'),
(14, 2, 'Wanna Be, Wanna Be, Soldier, Lieutenant, Boss, Real Gangster, Lieutenant, Boss, -, -'),
(15, 1, 'Newbie, Member, Young Driver, Expert, Drifter, Legend Driver, Right Hand, Drift King, Vice Leader, Leader'),
(15, 2, 'Praktykant, Mechanik, Majster, Koordynator, Brygadzista, Mistrz, Kierownik, Zastępca, Prezes, Właściciel'),
(16, 1, 'Little Dodger, Soldat, Gefreiter, Feldwebel, Leutnant, Rittmeister, Major, General, Fuhrer, -'),
(16, 2, 'Zoltodziob, Stazysta, Pocz. Mechanik, Mechanik, Dos. Mechanik, Majster, Kierownik, Zastępca Prezesa, Prezes, -'),
(17, 1, 'Candidate, Firefighter, Selectional FF, Fire Officer, Lieutenant, Lieutenant II, Staff Aspirant, Captain, Assistant Brigadier, Brigadier'),
(17, 2, 'Kierowca, Barman, Kasjer, Ochroniarz, DJ, Szef Ochrony, Kierownik, Zastępca Prezesa, Prezes, Pani Prezes'),
(18, 1, '-, -, -, -, -, -, -, -, -, Komandos'),
(18, 2, 'Obsluga, Barman, Ochroniarz, Starszy ochroniarz, DeeJay, Kierownik barmanów, Kierownik ochrony, Kierownik klubu, Zastępca prezesa, Prezes'),
(19, 2, 'Stażysta, Pracownik, Kierownik, Menadżer, Złota Rączka, Majster, Prezes, Zastępca Doradcy, Doradca, Właściciel'),
(20, 2, 'Stazysta, Kelner, Kasjer, St. Kasjer, St. Kelner, Kierownik, Szef, -, -, -'),
(21, 2, 'Nowy Kurier, Kurier I, Kurier II, Kurier III, Kurier IV, Król Kurierów, Sprzedawca, Kierownik, Zastepca Prezesa, Prezes'),
(22, 2, 'Nowy kurier, Kurier, Doświadczony kurier, Sprzedawca, Kierownik, Zastępca prezesa, Prezes, Właściciel, Miś, -'),
(23, 2, 'Ochroniarz, Kurier, Starszy Kurier, Młodszy Sprzedawca, Sprzedawca, Starszy Sprzedawca, Kierownik, Zastępca Prezesa, Prezes, Właściciel'),
(24, 2, 'Świeżak, Początkujący, Wokalista, Producent, Kierownik, Zastępca Prezesa, Prezes, -, -, -'),
(25, 2, 'Pakiet Bronze, Pakiet Silver, Pakiet Gold, Pakiet Platinum, Pakiet Diamond, Pakiet Premium, RAK, -, -, -'),
(26, 2, 'Budowlaniec, -, -, Brygadier, Majster, Architekt, Kierownik budowy, -, -, -'),
(27, 2, 'Dedication, Friend, Novice, Haunted, Fallen, Countess, The Devil, Queen, -, -'),
(28, 2, 'Homie, Wanna Be, Fresh, Mobster, Real Gangster, YOG, OG, -, -, -'),
(29, 2, 'Outsider, Member, Wanna Be, Gangster, Hustler, Y.O.G, O.G, -, -, -'),
(30, 2, 'Cleaner, Fanny Worker, Barman, Fanny Dancer, Fanny Security, Manager, Owner, -, -, -'),
(31, 2, 'Sta¿ysta, Kelner, Kasjer, St. Kasjer, St. Kelner, Kierownik, Szef, O.G, -, -'),
(32, 2, '-, Trainee Agent I, Traine Agent II, Master Trainee, Agent-in-Charge, -, -, -, -, -'),
(33, 2, 'Recrut 0, Recrut 1, Recrut 2, Recrut 3, Recrut 4, Special Agent I, Special Agent II, -, -, -'),
(34, 2, 'Outsider, Wanna Be, Associate, Soldier, Captain, Underboss, Boss, -, -, -'),
(35, 2, 'Mechanic, Young Driver, Driver, Tuner, Experienced Driver, Driver Legend, Wolf King, Leader, -, -'),
(36, 2, 'Wanna Be, Pracownik, Zolnierz, Kapitan, Podszef, Doradca, Szef, -, -, -'),
(37, 2, 'Wanna Be, Watts Dweller, Dealer, Member, Gangbanger, Y.O.G., O.G., -, -, -'),
(38, 2, 'Noname, Wannabe, Nicpoń, Gniewny, Rozrabiaka, Drifter, Drift Master, Boss, -, -'),
(39, 2, 'Niewolnik, Wieśniak, Farmer, Kmieć, Zastępca gospodarza, Gospodarz, Gospodyni, -, -, -'),
(40, 2, 'Sprzątacz, Praktykant, Pracownik, Zaopatrzeniowiec, Logistyk, Serwisant, Monter, Kierownik, Z-ca Prezesa, Prezes'),
(41, 2, 'Gaijin, Bodigado, Heishi|, Himitsu-no, Maneja, Manejamein, Direkuta, Supabaiza, Saiko-komon, Oyabun'),
(42, 2, 'Outsider, Baby Gangster, Member, Old member, Dealer, Dope Dealer, Y.O.G, O.G, -, -'),
(43, 2, 'Sprz¹tacz, Barman, Ratownik, Ochrona, Kierownik Ochrony, Kierownik, Zastêpca Prezesa, Prezes, -, -'),
(45, 2, 'Wanna-Be, Member, Homie, Drug Diler, Y.O.G, O.G, -, -, -, -');

-- --------------------------------------------------------

--
-- Table structure for table `mru_opisy`
--

CREATE TABLE IF NOT EXISTS `mru_opisy` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `typ` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `desc` varchar(128) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`UID`),
  KEY `owner` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_org`
--

CREATE TABLE IF NOT EXISTS `mru_org` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UID` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Name` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `Motd` varchar(128) COLLATE utf8_polish_ci DEFAULT '0',
  `Color` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `Int` int(11) NOT NULL DEFAULT '0',
  `VW` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `UID` (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=708 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_org`
--

INSERT INTO `mru_org` (`ID`, `UID`, `Type`, `Name`, `Motd`, `Color`, `x`, `y`, `z`, `a`, `Int`, `VW`) VALUES
(549, 18, 5, 'Ibiza Club', 'Pozdrawiam, Jasia, Sylke,Daniela,Kube,Paprote,Klocucha,Bakusia', 897131520, 410.421, -1808.11, 5.54688, 62.6014, 0, 0),
(550, 17, 5, 'Vinyl Club', '2.11.2018 - 20;00 IMPREZA', 0, 816.221, -1386.19, 13.5996, 46.9039, 0, 0),
(575, 45, 0, 'Wydzial Ulepszen (SEJF KU)', '16711680', 0, 1472.9, -1013.24, 27.2578, 11.1092, 0, 0),
(588, 6, 0, 'Komisja Organizacyjna', '16711680', 0, 1464.36, -1027.38, 23.8281, 358.892, 0, 0),
(639, 26, 4, 'Solarin Industries', '?O PANIE, KTO PANU TAK SPIERDOLI??', 2441482312, 853.849, -602.477, 18.4219, 6.0748, 0, 0),
(644, 31, 4, 'Cowboy Bar', 'Jezeli nie wpisales sie na liste itp. Napisz po hasla do matijas i zrob to jak najszybciej!', 1199012102, 681.287, -475.89, 16.3359, 182.733, 0, 0),
(659, 0, 0, '', '0', 0, 0, 0, 0, 0, 0, 0),
(664, 1, 0, 'Supreme Court of San Andreas', '--', 2504626984, 1310.2, -1368.53, 13.5505, 179.737, 0, 0),
(676, 16, 4, 'EVS CAR SERVICE', 'Pam?taj aby trzyma? si? regulaminu i stosowa? si? do cen. Milej Gierki :)', 362252420, 1031.11, -1363.64, 13.5742, 254.143, 0, 0),
(684, 22, 4, 'AmmuNation Commerce', 'Hej misiaki tu wasz suggar daddy ', 2203123848, 1708.54, -1504.62, 13.5534, 100.306, 0, 0),
(691, 9, 2, 'Islamic State of Iraq and Sham', 'Wchodz?c pod slot automatycznie wyra?asz zgode na FCK/Okaleczanie. Zmienili?my spawn!', 1231120744, -781.498, 1559.85, 27.1172, 206.767, 0, 0),
(702, 40, 4, 'Dude Company', 'Pracujemy na wysokim poziomie!', 155735808, 939.24, -1745.16, 13.5469, 95.204, 0, 0),
(703, 23, 4, 'ammunation los santos', 'Alex Stanley tu by?', 18968920, 1779.54, -1144.99, 23.9772, 171.368, 0, 0),
(704, 2, 1, 'Varrios Los Aztecas', '0', 0, 0, 0, 0, 0, 0, 0),
(705, 28, 1, '54 Jeff Crips', 'Automatycznie bedac pod slotem wyrazasz zgode na CK', 70744328, 2208.08, -1231.01, 23.9788, 357.464, 0, 0),
(706, 3, 2, 'Promienna 14', 'prawdziwe patusy', 103220356, 2758.87, -1944.55, 13.551, 268.24, 0, 0),
(707, 15, 4, 'Dos Santos Car Service Idlewood', 'Jesli nie jestes na Discordzie warsztatu. Zg?os sie na forum do ToKioo I 4D1a9e', 1939437858, 1797.4, -1703.49, 13.5294, 3.71309, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mru_personalization`
--

CREATE TABLE IF NOT EXISTS `mru_personalization` (
  `UID` int(11) NOT NULL,
  `KontoBankowe` tinyint(1) NOT NULL DEFAULT '0',
  `Ogloszenia` tinyint(1) NOT NULL DEFAULT '0',
  `LicznikPojazdu` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaFrakcji` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaRodzin` tinyint(1) NOT NULL DEFAULT '0',
  `OldNick` tinyint(1) NOT NULL DEFAULT '0',
  `CBRadio` tinyint(1) NOT NULL DEFAULT '0',
  `Report` tinyint(1) DEFAULT '0',
  `DeathWarning` tinyint(1) NOT NULL DEFAULT '0',
  `KaryTXD` tinyint(1) NOT NULL DEFAULT '0',
  `NewNick` tinyint(1) NOT NULL DEFAULT '0',
  `newbie` tinyint(1) NOT NULL DEFAULT '0',
  `BronieScroll` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UID`),
  KEY `UID` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_playeritems`
--

CREATE TABLE IF NOT EXISTS `mru_playeritems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `UID` (`UID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_player_cooking`
--

CREATE TABLE IF NOT EXISTS `mru_player_cooking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `weight` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mru_premium`
--

CREATE TABLE IF NOT EXISTS `mru_premium` (
  `p_charUID` int(11) NOT NULL,
  `p_MC` int(11) NOT NULL DEFAULT '0',
  `p_startDate` datetime DEFAULT NULL,
  `p_endDate` datetime DEFAULT NULL,
  `p_LastCheck` datetime DEFAULT NULL,
  `p_activeKp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`p_charUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_premium_skins`
--

CREATE TABLE IF NOT EXISTS `mru_premium_skins` (
  `s_charUID` int(11) NOT NULL,
  `s_ID` int(11) NOT NULL,
  PRIMARY KEY (`s_charUID`,`s_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mru_rodziny`
--

CREATE TABLE IF NOT EXISTS `mru_rodziny` (
  `name` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_rodziny`
--

INSERT INTO `mru_rodziny` (`name`, `id`) VALUES
('FAMILY_SAD', 1),
('FAMILY_RSC', -1),
('FAMILY_ALHAMBRA', 16),
('FAMILY_VINYL', 17),
('FAMILY_IBIZA', 18),
('FAMILY_FDU', 14),
('FAMILY_LCN', 40),
('FAMILY_YKZ', 41),
('FAMILY_GROVE', 42),
('FAMILY_BALLAS', 43),
('FAMILY_VAGOS', 44),
('FAMILY_NOA', 45),
('FAMILY_WPS', 46),
('FAMILY_SEKTA', 27);

-- --------------------------------------------------------

--
-- Table structure for table `mru_sejfy`
--

CREATE TABLE IF NOT EXISTS `mru_sejfy` (
  `ID` int(11) NOT NULL,
  `typ` int(11) NOT NULL,
  `kasa` int(11) NOT NULL,
  `mats` int(11) NOT NULL,
  PRIMARY KEY (`ID`,`typ`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_sejfy`
--

INSERT INTO `mru_sejfy` (`ID`, `typ`, `kasa`, `mats`) VALUES
(1, 1, 0, 0),
(1, 2, 0, 0),
(2, 1, 0, 0),
(2, 2, 0, 0),
(3, 1, 0, 0),
(3, 2, 0, 0),
(4, 1, 0, 0),
(4, 2, 0, 0),
(5, 1, 0, 0),
(5, 2, 0, 0),
(6, 1, 0, 0),
(6, 2, 0, 0),
(7, 1, 0, 0),
(7, 2, 0, 0),
(8, 1, 0, 0),
(8, 2, 0, 0),
(9, 1, 0, 0),
(9, 2, 0, 0),
(10, 1, 0, 0),
(10, 2, 0, 0),
(11, 1, 0, 0),
(11, 2, 0, 0),
(12, 1, 0, 0),
(12, 2, 0, 0),
(13, 1, 0, 0),
(13, 2, 0, 0),
(14, 1, 0, 0),
(14, 2, 0, 0),
(15, 1, 0, 0),
(15, 2, 0, 0),
(16, 1, 0, 0),
(16, 2, 0, 0),
(17, 1, 0, 0),
(17, 2, 0, 0),
(18, 1, 0, 0),
(18, 2, 0, 0),
(19, 1, 0, 0),
(19, 2, 0, 0),
(20, 2, 0, 0),
(21, 2, 0, 0),
(22, 2, 0, 0),
(23, 2, 0, 0),
(24, 2, 0, 0),
(25, 2, 0, 0),
(26, 2, 0, 0),
(27, 2, 0, 0),
(28, 2, 0, 0),
(29, 2, 0, 0),
(30, 2, 0, 0),
(31, 2, 0, 0),
(32, 2, 0, 0),
(33, 2, 0, 0),
(34, 2, 0, 0),
(35, 2, 0, 0),
(36, 2, 0, 0),
(37, 2, 0, 0),
(38, 2, 0, 0),
(39, 2, 0, 0),
(40, 2, 0, 0),
(41, 2, 0, 0),
(42, 2, 0, 0),
(43, 2, 0, 0),
(44, 2, 0, 0),
(45, 2, 0, 0),
(46, 2, 0, 0),
(47, 2, 0, 0),
(48, 2, 0, 0),
(49, 2, 0, 0);

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
-- Table structure for table `mru_skins`
--

CREATE TABLE IF NOT EXISTS `mru_skins` (
  `typ` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `skins` varchar(1024) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`typ`,`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_skins`
--

INSERT INTO `mru_skins` (`typ`, `id`, `skins`) VALUES
(1, 1, '266, 265, 267, 280, 282, 284, 285, 71, 307, 306, 301, 20103, 20104, 20105, 20108, 20469, 20471, 20472, 20473, 20474, 20475, 20476, 20477, 20479, 20480, 20481, 20483, 20484, 20485, 20487, 20488, 20490, 20491, 20492, 20493, 20494, 20496, 20497, 20501, 20502, 20504, 20505, 20506, 20507, 20508, 20510, 20512, 20514, 20516, 20517, 20518, 20560, 20561, 20562, 20563, 20564, 20565, 20566, 20567, 20568, 20569, 20570, 20571, 20572, 20573, 20574, 20575, 20576, 20577, 20578, 20595, 20596, 20597'),
(1, 2, '286, 165, 166, 165, 295, 211'),
(1, 3, '282, 283, 310, 287, 288, 311, 302, 309, 303, 304, 305, 191, 20101, 20102'),
(1, 4, '70, 275, 274, 276, 219, 69, 148, 216, 308, 228, 297, 278, 277, 20101, 20102, 20455, 20456, 20460, 20461, 20464, 20465, 20466, 20467, 20468, 20643, 20644, 20645, 20646, 20647, 20648, 20649, 20650, 20651'),
(2, 41, '117, 118 , 121, 122, 123, 141, 170, 187, 186, 208, 120'),
(1, 7, '295,228,166,165,150,76,20520, 20521, 20522, 20523, 20457, 20458, 20459, 20462, 20463'),
(1, 8, '112, 127, 226, 234, 217, 20605, 20606, 20607, 20608, 20609, 20610, 20611, 20612'),
(1, 9, '188, 189, 190, 141, 304, 187, 240'),
(1, 10, '16, 216, 253, 255, 192, 250'),
(1, 11, '76, 60, 59, 150, 240, 141, 57, 147'),
(2, 42, '271, 270, 269, 105, 106, 107, 190'),
(2, 43, '21, 22, 102, 103, 104, 190'),
(2, 44, '108, 109, 110, 56, 48, 30, 41, 47, 273, 292'),
(2, 45, '8, 298, 124, 122, 98, 93, 193, 21, 170'),
(2, 46, '112, 121, 206, 202, 133, 291, 191'),
(1, 17, '277, 278, 279, 219, 148, 308, 309'),
(2, 14, '115, 270, 124, 122, 192, 42, 268'),
(2, 40, '258, 124, 126, 125, 211, 113, 111, 98, 40, 272, 214'),
(2, 1, '46, 166, 57, 98, 119, 186, 214, 211, 216, 219, 187, 40, 76, 141'),
(2, 3, '111'),
(1, 15, '8, 298, 124, 122, 98, 93,116, 126, 121'),
(1, 5, '98,111,124,125,126,272,40,214,113, 20598, 20599, 20600, 20601, 20602, 20603'),
(1, 6, '186,123,122,121,117,118,120,55,169,224,225,263'),
(1, 12, '271,270,269,105,106,107,190,86,149'),
(1, 13, '102,103,104,195,105,260,269 270,271, 20613, 20614, 20615, 303, 93, 125'),
(1, 14, '108,109,110,56'),
(2, 11, '287, 191'),
(2, 20, '296, 295, 294, 291, 290, 285, 227, 228, 166, 165, 164, 163'),
(2, 31, '102,103,104,4,5'),
(2, 27, '11, 17, 33, 40, 55, 68,  70, 76, 91, 93, 117, 118, 120, 125, 141, 169, 186, 233'),
(2, 7, '93, 125, 127, 217, 285, 169, 192, 98, 124, 271'),
(2, 4, '143'),
(2, 15, '268, 50, 8'),
(2, 16, '268, 50, 8'),
(2, 19, '268, 50, 8'),
(2, 5, '20623, 20624, 20625, 20626'),
(2, 2, '20616, 20617, 20618, 20619, 20620, 20621, 20622'),
(2, 9, '20637, 20638, 20639, 20640, 20641, 20642'),
(2, 28, '20631, 20632, 20633, 20634, 20635, 20636');

-- --------------------------------------------------------

--
-- Table structure for table `mru_strefy`
--

CREATE TABLE IF NOT EXISTS `mru_strefy` (
  `id` int(11) NOT NULL,
  `gang` int(11) NOT NULL,
  `expire` int(11) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_strefy`
--

INSERT INTO `mru_strefy` (`id`, `gang`, `expire`) VALUES
(0, 0, 1582742534),
(1, 0, 1591711337),
(2, 102, 1596142930),
(3, 0, 1592167539),
(4, 0, 1573073127),
(5, 102, 1595614192),
(6, 102, 1595767202),
(7, 102, 1595435951),
(8, 102, 1594761156),
(9, 128, 1596627244),
(10, 102, 1591471813),
(11, 0, 1595458851),
(12, 102, 1594925807),
(13, 102, 1596055126),
(14, 102, 1592183994),
(15, 102, 1594242818),
(16, 0, 1582918971),
(17, 114, 1588351932),
(18, 128, 1596528603),
(19, 128, 1592849898),
(20, 110, 1592746952),
(21, 110, 1592408662),
(22, 110, 1592815052),
(23, 110, 1591948718),
(24, 110, 1592828153),
(25, 110, 1592563912),
(26, 102, 1594591640),
(27, 110, 1592148974),
(28, 110, 1592041139),
(29, 102, 1595363332),
(30, 0, 1516285531),
(31, 0, 1582641704),
(32, 110, 1591898096),
(33, 102, 1594071964),
(34, 128, 1596736889),
(35, 102, 1592341910),
(36, 110, 1592226280),
(37, 110, 1592667484),
(38, 102, 1594673266),
(39, 102, 1594419522),
(40, 110, 1592484974),
(41, 110, 1592298060),
(42, 110, 1592335504),
(43, 104, 1572381766),
(44, 102, 1589678735),
(45, 102, 1589558704),
(46, 0, 1593810809),
(47, 102, 1590008908),
(48, 102, 1593718148),
(49, 102, 1589399851),
(50, 102, 1591815189),
(51, 102, 1591907109),
(52, 102, 1595156858),
(53, 104, 1570889851),
(54, 102, 1591987835),
(55, 102, 1590109808),
(56, 102, 1592077251),
(57, 102, 1592856267),
(58, 102, 1593632757),
(59, 102, 1592423491),
(60, 0, 1518986061),
(61, 102, 1590419738),
(62, 0, -1),
(63, 102, 1590779950),
(64, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `mru_strefylimit`
--

CREATE TABLE IF NOT EXISTS `mru_strefylimit` (
  `gang` int(11) NOT NULL,
  `data` int(11) NOT NULL,
  KEY `gang` (`gang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_strefylimit`
--

INSERT INTO `mru_strefylimit` (`gang`, `data`) VALUES
(7, 1408545872),
(9, 1411307396),
(8, 1413654275),
(6, 1414607334),
(107, 1417378910),
(123, 1418940064),
(116, 1429619663),
(104, 1430760156),
(4, 1439466942),
(43, 1439654727),
(10, 1439994432),
(5, 1440434757),
(42, 1440497728),
(109, 1441633997),
(144, 1442060976),
(106, 1442140985),
(125, 1487338848),
(126, 1494266148),
(108, 1498560323),
(133, 1500293999),
(134, 1502290406),
(111, 1507393483),
(136, 1509904852),
(142, 1518899661),
(143, 1521658401),
(131, 1533206350),
(105, 1570368653),
(16, 1582387164),
(103, 1585520252),
(12, 1586637243),
(114, 1588265532),
(14, 1592081139),
(13, 1592265002),
(110, 1592741753),
(102, 1596056530),
(128, 1596650489);

-- --------------------------------------------------------

--
-- Table structure for table `mru_uprawnienia`
--

CREATE TABLE IF NOT EXISTS `mru_uprawnienia` (
  `UID` int(11) NOT NULL,
  `FLAGS` bit(16) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`UID`),
  KEY `UID` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `mru_uprawnienia`
--

INSERT INTO `mru_uprawnienia` (`UID`, `FLAGS`) VALUES
(1, b'0111111111111111'),
(2, b'0111111111111111');

-- --------------------------------------------------------

--
-- Table structure for table `mru_ryby`
--

CREATE TABLE `mru_ryby` (
  `Player` int(11) NOT NULL,
  `Fish1` varchar(20) NOT NULL DEFAULT 'None',
  `Fish2` varchar(20) NOT NULL DEFAULT 'None',
  `Fish3` varchar(20) NOT NULL DEFAULT 'None',
  `Fish4` varchar(20) NOT NULL DEFAULT 'None',
  `Fish5` varchar(20) NOT NULL DEFAULT 'None',
  `Weight1` int(11) NOT NULL DEFAULT 0,
  `Weight2` int(11) NOT NULL DEFAULT 0,
  `Weight3` int(11) NOT NULL DEFAULT 0,
  `Weight4` int(11) NOT NULL DEFAULT 0,
  `Weight5` int(11) NOT NULL DEFAULT 0,
  `Fid1` int(11) NOT NULL DEFAULT 0,
  `Fid2` int(11) NOT NULL DEFAULT 0,
  `Fid3` int(11) NOT NULL DEFAULT 0,
  `Fid4` int(11) NOT NULL DEFAULT 0,
  `Fid5` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Player`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_bin;

-- --------------------------------------------------------

--
-- Table structure for table `mru_gspanel`
--

CREATE TABLE `mru_gspanel` (
  `orgid` int(11) NOT NULL,
  `gun` int(11) NOT NULL,
  `cena` int(11) NOT NULL,
  PRIMARY KEY (`orgid`,`gun`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_admini`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_admini` (
`UID` int(10) unsigned
,`Nick` varchar(24)
,`Level` tinyint(3) unsigned
,`Admin` smallint(5) unsigned
,`PAdmin` tinyint(3) unsigned
,`ZaufanyGracz` tinyint(3) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_biznesy`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_biznesy` (
`Nick` varchar(24)
,`BizID` int(11)
,`BizName` varchar(64)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_cars`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_cars` (
`UID` int(11)
,`ownertype` int(11)
,`owner` int(11)
,`model` int(11)
,`Nazwa` varchar(32)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_majatki`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_majatki` (
`UID` int(10) unsigned
,`Nick` varchar(24)
,`Level` tinyint(3) unsigned
,`Suma hajsu` bigint(12)
,`Sloty na pojazd` tinyint(3) unsigned
,`Ilość pojazdów` bigint(21)
,`W tym ilość unikatów` decimal(23,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_mru_konta`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_mru_konta` (
`UID` int(10) unsigned
,`Nick` varchar(24)
,`Level` tinyint(3) unsigned
,`ConnectedTime` smallint(5) unsigned
,`DonateRank` tinyint(4)
,`KontroPremium` int(11)
,`Money` int(11)
,`Bank` int(11)
,`Dom` int(11)
,`Job` tinyint(3) unsigned
,`Fraction` tinyint(3) unsigned
,`Family` tinyint(3) unsigned
,`Warnings` tinyint(3) unsigned
,`PhoneNr` int(11)
,`SkinCywila` smallint(5) unsigned
,`Uniform` int(11)
,`ZmianyNicku` tinyint(3) unsigned
,`CarLic` tinyint(3) unsigned
,`FlyLic` tinyint(3) unsigned
,`BoatLic` tinyint(3) unsigned
,`FishLic` tinyint(3) unsigned
,`GunLic` tinyint(3) unsigned
,`Smierci` smallint(5) unsigned
,`Materials` int(10) unsigned
,`detskill` smallint(5) unsigned
,`sexskill` smallint(5) unsigned
,`boxskill` smallint(5) unsigned
,`lawskill` smallint(5) unsigned
,`mechskill` smallint(5) unsigned
,`jackskill` smallint(5) unsigned
,`carskill` smallint(5) unsigned
,`newsskill` smallint(5) unsigned
,`drugsskill` smallint(5) unsigned
,`cookskill` smallint(5) unsigned
,`fishskill` smallint(5) unsigned
,`gunskill` smallint(5) unsigned
,`truckskill` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_organizacje`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_organizacje` (
`UID` int(10) unsigned
,`Nick` varchar(24)
,`Lider` int(11)
,`LeaderValue` int(11)
,`Frakcja` tinyint(3) unsigned
,`Rodzina` tinyint(3) unsigned
,`Praca` tinyint(3) unsigned
,`Ranga` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pojazdy_frakcji`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_pojazdy_frakcji` (
`UID` int(11)
,`owner` int(11)
,`model` int(11)
,`nazwa_modelu` varchar(32)
,`x` float
,`y` float
,`z` float
,`angle` float
,`hp` float
,`color1` int(11)
,`color2` int(11)
,`int` int(11)
,`vw` int(11)
,`ranga` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pojazdy_rodzin`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_pojazdy_rodzin` (
`UID` int(11)
,`owner` int(11)
,`model` int(11)
,`nazwa_modelu` varchar(32)
,`x` float
,`y` float
,`z` float
,`angle` float
,`hp` float
,`color1` int(11)
,`color2` int(11)
,`int` int(11)
,`vw` int(11)
,`ranga` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_unikaty`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_unikaty` (
`Car UID` int(11)
,`Owner` varchar(24)
,`Owner_UID` int(10) unsigned
,`Pojazd` varchar(32)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_unikaty_ilosc`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_unikaty_ilosc` (
`Car` varchar(32)
,`Ilosc` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_unikaty_owners`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_unikaty_owners` (
`UID` int(10) unsigned
,`Nick` varchar(24)
,`Level` tinyint(3) unsigned
,`Unikaty` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_uprawnienia`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS `view_uprawnienia` (
`UID` int(11)
,`Nick` varchar(24)
,`FLAGS` bit(16)
);

-- --------------------------------------------------------

--
-- Structure for view `view_admini`
--
DROP TABLE IF EXISTS `view_admini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_admini`  AS SELECT `mru_konta`.`UID` AS `UID`, `mru_konta`.`Nick` AS `Nick`, `mru_konta`.`Level` AS `Level`, `mru_konta`.`Admin` AS `Admin`, `mru_konta`.`PAdmin` AS `PAdmin`, `mru_konta`.`ZaufanyGracz` AS `ZaufanyGracz` FROM `mru_konta` WHERE ((`mru_konta`.`Admin` >= 1) OR (`mru_konta`.`PAdmin` >= 1) OR (`mru_konta`.`ZaufanyGracz` >= 1)) ORDER BY `mru_konta`.`Admin` ASC, `mru_konta`.`PAdmin` ASC, `mru_konta`.`ZaufanyGracz` ASC, `mru_konta`.`Level` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_biznesy`
--
DROP TABLE IF EXISTS `view_biznesy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_biznesy`  AS SELECT `k`.`Nick` AS `Nick`, `b`.`ID` AS `BizID`, `b`.`Name` AS `BizName` FROM (`mru_business` `b` left join `mru_konta` `k` on((`k`.`Bizz` = `b`.`ID`))) ORDER BY `b`.`ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_cars`
--
DROP TABLE IF EXISTS `view_cars`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cars`  AS SELECT `mru_cars`.`UID` AS `UID`, `mru_cars`.`ownertype` AS `ownertype`, `mru_cars`.`owner` AS `owner`, `mru_cars`.`model` AS `model`, `CAR_NAME`(`mru_cars`.`model`) AS `Nazwa` FROM `mru_cars` ORDER BY `mru_cars`.`UID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_majatki`
--
DROP TABLE IF EXISTS `view_majatki`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_majatki`  AS SELECT `k`.`UID` AS `UID`, `k`.`Nick` AS `Nick`, `k`.`Level` AS `Level`, (`k`.`Money` + `k`.`Bank`) AS `Suma hajsu`, `k`.`CarSlots` AS `Sloty na pojazd`, count(`c`.`model`) AS `Ilość pojazdów`, sum((case when `IS_CAR_UNIQUE`(`c`.`model`) then 1 else 0 end)) AS `W tym ilość unikatów` FROM (`mru_konta` `k` left join `mru_cars` `c` on(((`k`.`UID` = `c`.`owner`) and (`c`.`ownertype` = 3)))) GROUP BY `k`.`UID` ;

-- --------------------------------------------------------

--
-- Structure for view `view_mru_konta`
--
DROP TABLE IF EXISTS `view_mru_konta`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_mru_konta`  AS SELECT `mru_konta`.`UID` AS `UID`, `mru_konta`.`Nick` AS `Nick`, `mru_konta`.`Level` AS `Level`, `mru_konta`.`ConnectedTime` AS `ConnectedTime`, `mru_konta`.`DonateRank` AS `DonateRank`, `p`.`p_activeKp` AS `KontroPremium`, `mru_konta`.`Money` AS `Money`, `mru_konta`.`Bank` AS `Bank`, `mru_konta`.`Dom` AS `Dom`, `mru_konta`.`Job` AS `Job`, `mru_konta`.`Member` AS `Fraction`, `mru_konta`.`FMember` AS `Family`, `mru_konta`.`Warnings` AS `Warnings`, `mru_konta`.`PhoneNr` AS `PhoneNr`, `mru_konta`.`Skin` AS `SkinCywila`, `mru_konta`.`Uniform` AS `Uniform`, `mru_konta`.`ZmienilNick` AS `ZmianyNicku`, `mru_konta`.`CarLic` AS `CarLic`, `mru_konta`.`FlyLic` AS `FlyLic`, `mru_konta`.`BoatLic` AS `BoatLic`, `mru_konta`.`FishLic` AS `FishLic`, `mru_konta`.`GunLic` AS `GunLic`, `mru_konta`.`Deaths` AS `Smierci`, `mru_konta`.`Materials` AS `Materials`, `mru_konta`.`DetSkill` AS `detskill`, `mru_konta`.`SexSkill` AS `sexskill`, `mru_konta`.`BoxSkill` AS `boxskill`, `mru_konta`.`LawSkill` AS `lawskill`, `mru_konta`.`MechSkill` AS `mechskill`, `mru_konta`.`JackSkill` AS `jackskill`, `mru_konta`.`CarSkill` AS `carskill`, `mru_konta`.`NewsSkill` AS `newsskill`, `mru_konta`.`DrugsSkill` AS `drugsskill`, `mru_konta`.`CookSkill` AS `cookskill`, `mru_konta`.`FishSkill` AS `fishskill`, `mru_konta`.`GunSkill` AS `gunskill`, `mru_konta`.`TruckSkill` AS `truckskill` FROM (`mru_konta` left join `mru_premium` `p` on((`p`.`p_charUID` = `mru_konta`.`UID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_organizacje`
--
DROP TABLE IF EXISTS `view_organizacje`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_organizacje`  AS SELECT `mru_konta`.`UID` AS `UID`, `mru_konta`.`Nick` AS `Nick`, `mru_liderzy`.`FracID` AS `Lider`, `mru_liderzy`.`LiderValue` AS `LeaderValue`, `mru_konta`.`Member` AS `Frakcja`, `mru_konta`.`FMember` AS `Rodzina`, `mru_konta`.`Job` AS `Praca`, `mru_konta`.`Rank` AS `Ranga` FROM (`mru_konta` left join `mru_liderzy` on((`mru_konta`.`UID` = `mru_liderzy`.`UID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_pojazdy_frakcji`
--
DROP TABLE IF EXISTS `view_pojazdy_frakcji`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pojazdy_frakcji`  AS SELECT `mru_cars`.`UID` AS `UID`, `mru_cars`.`owner` AS `owner`, `mru_cars`.`model` AS `model`, `CAR_NAME`(`mru_cars`.`model`) AS `nazwa_modelu`, `mru_cars`.`x` AS `x`, `mru_cars`.`y` AS `y`, `mru_cars`.`z` AS `z`, `mru_cars`.`angle` AS `angle`, `mru_cars`.`hp` AS `hp`, `mru_cars`.`color1` AS `color1`, `mru_cars`.`color2` AS `color2`, `mru_cars`.`int` AS `int`, `mru_cars`.`vw` AS `vw`, `mru_cars`.`ranga` AS `ranga` FROM `mru_cars` WHERE (`mru_cars`.`ownertype` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `view_pojazdy_rodzin`
--
DROP TABLE IF EXISTS `view_pojazdy_rodzin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pojazdy_rodzin`  AS SELECT `mru_cars`.`UID` AS `UID`, `mru_cars`.`owner` AS `owner`, `mru_cars`.`model` AS `model`, `CAR_NAME`(`mru_cars`.`model`) AS `nazwa_modelu`, `mru_cars`.`x` AS `x`, `mru_cars`.`y` AS `y`, `mru_cars`.`z` AS `z`, `mru_cars`.`angle` AS `angle`, `mru_cars`.`hp` AS `hp`, `mru_cars`.`color1` AS `color1`, `mru_cars`.`color2` AS `color2`, `mru_cars`.`int` AS `int`, `mru_cars`.`vw` AS `vw`, `mru_cars`.`ranga` AS `ranga` FROM `mru_cars` WHERE (`mru_cars`.`ownertype` = 2) ;

-- --------------------------------------------------------

--
-- Structure for view `view_unikaty`
--
DROP TABLE IF EXISTS `view_unikaty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_unikaty`  AS SELECT `c`.`UID` AS `Car UID`, `k`.`Nick` AS `Owner`, `k`.`UID` AS `Owner_UID`, `CAR_NAME`(`c`.`model`) AS `Pojazd` FROM (`mru_cars` `c` join `mru_konta` `k` on((`c`.`owner` = `k`.`UID`))) WHERE (`IS_CAR_UNIQUE`(`c`.`model`) AND (`c`.`ownertype` = 3)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_unikaty_ilosc`
--
DROP TABLE IF EXISTS `view_unikaty_ilosc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_unikaty_ilosc`  AS SELECT `CAR_NAME`(`mru_cars`.`model`) AS `Car`, count(0) AS `Ilosc` FROM `mru_cars` WHERE (`IS_CAR_UNIQUE`(`mru_cars`.`model`) AND (`mru_cars`.`ownertype` = 3)) GROUP BY `mru_cars`.`model` ORDER BY `Ilosc` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `view_unikaty_owners`
--
DROP TABLE IF EXISTS `view_unikaty_owners`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_unikaty_owners`  AS SELECT `k`.`UID` AS `UID`, `k`.`Nick` AS `Nick`, `k`.`Level` AS `Level`, count(`c`.`UID`) AS `Unikaty` FROM (`mru_cars` `c` join `mru_konta` `k` on((`c`.`owner` = `k`.`UID`))) WHERE (`IS_CAR_UNIQUE`(`c`.`model`) AND (`c`.`ownertype` = 3)) GROUP BY `k`.`UID` ORDER BY `Unikaty` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `view_uprawnienia`
--
DROP TABLE IF EXISTS `view_uprawnienia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_uprawnienia`  AS SELECT `u`.`UID` AS `UID`, `k`.`Nick` AS `Nick`, `u`.`FLAGS` AS `FLAGS` FROM (`mru_uprawnienia` `u` join `mru_konta` `k` on((`u`.`UID` = `k`.`UID`))) ;
COMMIT;

--
-- Admin accounts
--
INSERT INTO `mru_konta`(`UID`, `Nick`, `Key`, `Salt`, `Admin`) VALUES 
(1, 'John_Mrucznik', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(2, 'Sven_Helvetica', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(3, 'Ryan_Gardner', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(4, 'Evan_Jones', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(5, 'Kenyon_Carrington', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(6, 'Shoji_Ertubo', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(7, 'Tommy_Evans', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(8, 'Xantiago_Diman', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(9, 'Michael_West', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(10, 'Andre_Schavione', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(11, 'Joey_Serratore', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(12, 'Kevin_Russell', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(13, 'Justin_Devilson', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(14, 'Stewart_West', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(15, 'Max_Light', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(16, 'Zack_Assas', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(17, 'Blake_Varisco', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(18, 'James_Duble', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(19, 'Quinton_Brown', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(20, 'Tom_Thompson', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(21, 'Devon_Pravesh', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(22, 'Kayden_Barlett', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(23, 'Tyreese_Carter', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(24, 'Fenrir_Skjolberg', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(25, 'Simon_Heratti', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(26, 'Jordan_Bellfort', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(27, 'Carlos_Kennedy', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(28, 'Dawid_Ciarkowskhi', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(29, 'Stormi_Brooks', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(30, 'Michael_Wizard', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(31, 'Luis_Ravens', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(32, 'Jacob_Williams', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(33, 'Saraya_Bellray', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(34, 'Phil_Gualtieri', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(35, 'Matthew_Kruger', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(36, 'Russ_Pham', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(37, 'Ales_Stradivacci', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(38, 'Testowy_Tester', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(39, 'Testowe_Konto', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(40, 'Testo_Testuj', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000),
(41, 'Test_Test', '4707212575974D8D221A726E5ED232980244245E5904774B5246A0351B105EECF040C2A0022CEAD924E10D7B6D598D7363A5B921DBCBAFF3784CAAE2AD71BB80', '3h5A7e3g25NBd7I', 5000);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
