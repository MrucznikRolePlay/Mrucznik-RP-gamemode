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
	if(cache_is_valid(result))
	{
		cache_get_value_index_int(0, 0, kpMC);
		cache_get_value_index_int(0, 1, kpEnds);
		cache_get_value_index_int(0, 2, kpStarted);
		cache_get_value_index_int(0, 3, kpLastLogin);
		cache_get_value_index_int(0, 4, kpActive);
		cache_delete(result);
	}
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
	//TODO: MySQL
	// new query[128];
    // format(query, sizeof(query), "SELECT `p_charUID` FROM `mru_premium` WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	// mysql_query(query);
	// mysql_store_result();
    // if(mysql_num_rows())
    // {
    //     mysql_free_result();
    //     format(query, sizeof(query), "UPDATE `mru_premium` SET `p_MC`='%d' WHERE `p_charUID`='%d'", PremiumInfo[playerid][pMC], PlayerInfo[playerid][pUID]);
    //     mysql_query(query);
    // }
    // else
    // {
    //     mysql_free_result();
    //     if(PremiumInfo[playerid][pMC] > 0)
    //     {
    //         format(query, sizeof(query), "INSERT INTO `mru_premium` (`p_charUID`, `p_MC`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], PremiumInfo[playerid][pMC]);
    //         mysql_query(query);
    //     }
    // }
}

MruMySQL_LoadPlayerPremiumSkins(playerid)
{
	//TODO: MySQL
	// new qr[256];
	// format(qr, sizeof(qr), "SELECT `s_ID` FROM `mru_premium_skins` WHERE `s_charUID`='%d'", PlayerInfo[playerid][pUID]);
	// mysql_query(qr);
	// new skinID;
	// mysql_store_result();
	// {
	// 	if(mysql_num_rows()>0)
	// 	{
	// 		while(mysql_fetch_row_format(qr, "|"))
	// 		{
	// 			sscanf(qr, "p<|>d", skinID);
	// 			VECTOR_push_back_val(VPremiumSkins[playerid], skinID);
	// 		}
	// 	}
    //     mysql_free_result();
	// }
}

MruMySQL_IsPhoneNumberAvailable(number) {
    
	//TODO: MySQL
    // if(100 <= number && number <= 150) return false;
    // if(number == 555) return false;
    // new string[70];
    // format(string, sizeof(string), "SELECT `UID` FROM `mru_konta` WHERE `PhoneNr` = %d", number);
    // mysql_query(string);
    // mysql_store_result();
    // if(mysql_num_rows() > 0)
    // {
    //     mysql_free_result();
    //     return false;
    // }
    // mysql_free_result();
    // return true;
}
//end