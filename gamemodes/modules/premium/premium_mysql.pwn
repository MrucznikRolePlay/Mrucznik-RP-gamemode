//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  premium                                                  //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	Monetyzacja, us³ugi premium.
*/

//

//------------------<[ MySQL: ]>--------------------
MruMySQL_LoadPremiumData(playerid, &kpMC, &kpEnds, &kpStarted, &kpLastLogin, &kpActive)
{
	new qr[256];
	format(qr, sizeof(qr), "SELECT `p_MC`, UNIX_TIMESTAMP(`p_endDate`), UNIX_TIMESTAMP(`p_startDate`), UNIX_TIMESTAMP(`p_LastCheck`), `p_activeKp` FROM `mru_premium` WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	new Cache:result = mysql_query(mruMySQL_Connection, qr, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index_int(0, 0, kpMC);
		cache_get_value_index_int(0, 1, kpEnds);
		cache_get_value_index_int(0, 2, kpStarted);
		cache_get_value_index_int(0, 3, kpLastLogin);
		cache_get_value_index_int(0, 4, kpActive);
	}
	cache_delete(result);
}


MruMySQL_SetKP(playerid, time)
{
	mysql_query(mruMySQL_Connection, sprintf("INSERT INTO `mru_premium` (`p_endDate`, `p_charUID`, `p_LastCheck`, `p_startDate`, `p_activeKp`) \
		VALUES (FROM_UNIXTIME('%d'), '%d', NOW(), NOW(), 1) \
		ON DUPLICATE KEY UPDATE `p_endDate`='%d', `p_charUID`='%d', `p_LastCheck`=NOW(), `p_startDate`=NOW(), `p_activeKp`='1'", 
		time, PlayerInfo[playerid][pUID],
		time, PlayerInfo[playerid][pUID]
	));
}

MruMySQL_InsertSkin(playerid, id)
{
	new string[128];
	format(string, sizeof(string), "INSERT INTO `mru_premium_skins` (`s_charUID`, `s_ID`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], SkinyPremium[id][Model]);
    mysql_query(mruMySQL_Connection, string);
}

MruMySQL_RemoveKP(playerid)
{
	new query[128];
	format(query, sizeof(query), "UPDATE `mru_premium` SET `p_activeKp`=0, `p_endDate`=NOW() WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(mruMySQL_Connection, query);
}

MruMySQL_SaveMc(playerid)
{
	new query[128];
	format(query, sizeof(query), "INSERT INTO `mru_premium` (`p_charUID`, `p_MC`) VALUES('%d', '%d') \
		ON DUPLICATE KEY UPDATE `p_charUID`='%d', `p_MC`='%d'", 
		PlayerInfo[playerid][pUID], PremiumInfo[playerid][pMC], 
		PlayerInfo[playerid][pUID], PremiumInfo[playerid][pMC]
	);
	mysql_query(mruMySQL_Connection, query);
}

MruMySQL_LoadPlayerPremiumSkins(playerid)
{
	new qr[256];
	format(qr, sizeof(qr), "SELECT `s_ID` FROM `mru_premium_skins` WHERE `s_charUID`='%d'", PlayerInfo[playerid][pUID]);
	new Cache:result = mysql_query(mruMySQL_Connection, qr, true);
	new skinID;
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
		{
			cache_get_value_index_int(i, 0, skinID);
			VECTOR_push_back_val(VPremiumSkins[playerid], skinID);
		}
		cache_delete(result);
	}
}

MruMySQL_IsPhoneNumberAvailable(number) 
{
    if(100 <= number && number <= 150) return false;
    if(number == 555) return false;
    new string[70];
    format(string, sizeof(string), "SELECT `UID` FROM `mru_konta` WHERE `PhoneNr` = %d", number);
    new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result))
	{
		if(cache_num_rows())
		{
			cache_delete(result);
        	return false;
		}
	}
	cache_delete(result);
    return true;
}
//end