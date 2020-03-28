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
	new qr[256];
	format(qr, sizeof(qr), "SELECT `disease` FROM `mru_diseases` WHERE `UID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(qr);
	mysql_store_result();
	{
		if(mysql_num_rows() > 0)
		{
			new eDiseases:diseaseType;
			while(mysql_fetch_row_format(qr, "|"))
			{
				sscanf(qr, "p<|>d", diseaseType);
				InfectPlayerWithoutSaving(playerid, diseaseType);
			}
		}
        mysql_free_result();
	}
}

MruMySQL_AddDisease(playerid, eDiseases:disease)
{
	new string[128];
	format(string, sizeof(string), "INSERT INTO `mru_diseases` (`uid`, `disease`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], disease);
    mysql_query(string);
}

MruMySQL_RemoveDisease(playerid, eDiseases:disease)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM `mru_diseases` WHERE `uid`='%d' AND `disease`='%d'", PlayerInfo[playerid][pUID], disease);
    mysql_query(string);
}

MruMySQL_RemoveAllDiseases(playerid)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM `mru_diseases` WHERE `uid`='%d'", PlayerInfo[playerid][pUID]);
    mysql_query(string);
}

//end