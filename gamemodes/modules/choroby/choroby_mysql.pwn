//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  choroby                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020
//Opis:
/*
	System chorób.
*/

//

/* Create table query:
	CREATE TABLE IF NOT EXISTS `mru_diseases` (
		`uid` int(11) NOT NULL,
		`disease` int(11) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

	ALTER TABLE `mru_diseases` ADD PRIMARY KEY (`uid`,`disease`);
*/

//------------------<[ MySQL: ]>--------------------
MruMySQL_LoadDiseasesData(playerid)
{
	new Cache:result = mysql_query(mruMySQL_Connection, sprintf("SELECT `disease` FROM `mru_diseases` WHERE `UID`='%d'", PlayerInfo[playerid][pUID]));
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
		{
			new eDiseases:diseaseType;
			cache_get_value_index_int(i, 0, diseaseType);
			InfectPlayerWithoutSaving(playerid, diseaseType);
		}
		cache_delete(result);
	}
}

MruMySQL_AddDisease(playerid, eDiseases:disease)
{
	new string[128];
	format(string, sizeof(string), "INSERT INTO `mru_diseases` (`uid`, `disease`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], disease);
    mysql_query(mruMySQL_Connection, string);
}

MruMySQL_RemoveDisease(playerid, eDiseases:disease)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM `mru_diseases` WHERE `uid`='%d' AND `disease`='%d'", PlayerInfo[playerid][pUID], disease);
    mysql_query(mruMySQL_Connection, string);
}

MruMySQL_RemoveAllDiseases(playerid)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM `mru_diseases` WHERE `uid`='%d'", PlayerInfo[playerid][pUID]);
    mysql_query(mruMySQL_Connection, string);
}

//end