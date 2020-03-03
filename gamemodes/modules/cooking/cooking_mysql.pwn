//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  cooking                                                  //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: mrucznik
// Data utworzenia: 03.03.2020
//Opis:
/*
	System gotowania potraw
*/

//

// DB structure:
// CREATE TABLE IF NOT EXISTS `mru_player_cooking` (
//   `PID` int(11) NOT NULL,
//   `slot` int(11) NOT NULL,
//   `name` varchar(20) COLLATE latin1_general_ci NOT NULL,
//   `weight` int(11) NOT NULL,
//   `id` int(11) NOT NULL
// ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

// ALTER TABLE `mru_player_cooking`
//  ADD PRIMARY KEY (`PID`,`slot`);

//------------------<[ MySQL: ]>--------------------
MruMySQL_SaveCooking(playerid)
{
	new query[512];
	format(query, sizeof(query), "INSERT INTO mru_player_cooking (PID, slot, name, weight, id) VALUES \
		('%d', '%d', '%s', '%d', '%d') \
		ON DUPLICATE KEY UPDATE (name=VALUES(name), weight=VALUES(weight), id=VALUES(id))"
		PlayerInfo[playerid][pUID], 0, Cooking[playerid][pCook][0], Cooking[playerid][pCook][0], Cooking[playerid][pCookID1],
	);
	mysql_query(query);
	return 1;
}

MruMySQL_LoadCooking(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT PID, slot, name, weight, id FROM mru_player_cooking WHERE PID='%d' ORDER BY slot ASC",
		PlayerInfo[playerid][pUID]
	);
	return 1;
}

//end