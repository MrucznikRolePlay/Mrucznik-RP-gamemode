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
	mysql_query(qr);
	mysql_store_result();
	{
		mysql_fetch_row_format(qr, "|");
        mysql_free_result();
        sscanf(qr, "p<|>ddddd", kpMC, kpEnds, kpStarted, kpLastLogin, kpActive);
	}
}


MruMySQL_SetKP(playerid, time)
{
	new query[256];
	format(query, sizeof(query), "SELECT `p_charUID` FROM `mru_premium` WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		format(query, sizeof(query), "UPDATE `mru_premium` SET `p_endDate`=FROM_UNIXTIME('%d'), `p_startDate`=NOW(), `p_LastCheck`=NOW(), `p_activeKp`=1 WHERE `p_charUID`='%d'", 
			time, PlayerInfo[playerid][pUID]);
		mysql_query(query);
	}
	else
	{
		format(query, sizeof(query), "INSERT INTO `mru_premium` (`p_endDate`, `p_charUID`, `p_LastCheck`, `p_startDate`, `p_activeKp`) VALUES(FROM_UNIXTIME('%d'), '%d', NOW(), NOW(), 1)", 
			time, PlayerInfo[playerid][pUID]);
		mysql_query(query);
	}
	mysql_free_result();
}

MruMySQL_InsertSkin(playerid, id)
{
	new string[128];
	format(string, sizeof(string), "INSERT INTO `mru_premium_skins` (`s_charUID`, `s_ID`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], SkinyPremium[id][Model]);
    mysql_query(string);
}

MruMySQL_RemoveKP(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `p_charUID` FROM `mru_premium` WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	mysql_store_result();
	{
		if(mysql_num_rows())
		{
			format(query, sizeof(query), "UPDATE `mru_premium` SET `p_activeKp`=0, `p_endDate`=NOW() WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
			mysql_query(query);
		}
		else
		{
			Log(premiumLog, ERROR, "ERROR: ZabierzKP zosta³o wykonane na osobie, która nie posiada³a premium! %s", GetPlayerLogName(playerid));
		}
        mysql_free_result();
	}
}

MruMySQL_SaveMc(playerid)
{
	new query[128];
    format(query, sizeof(query), "SELECT `p_charUID` FROM `mru_premium` WHERE `p_charUID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
        format(query, sizeof(query), "UPDATE `mru_premium` SET `p_MC`='%d' WHERE `p_charUID`='%d'", PremiumInfo[playerid][pMC], PlayerInfo[playerid][pUID]);
        mysql_query(query);
    }
    else
    {
        mysql_free_result();
        if(PremiumInfo[playerid][pMC] > 0)
        {
            format(query, sizeof(query), "INSERT INTO `mru_premium` (`p_charUID`, `p_MC`) VALUES('%d', '%d')", PlayerInfo[playerid][pUID], PremiumInfo[playerid][pMC]);
            mysql_query(query);
        }
    }
}

MruMySQL_LoadPlayerPremiumSkins(playerid)
{
	new qr[256];
	format(qr, sizeof(qr), "SELECT `s_ID` FROM `mru_premium_skins` WHERE `s_charUID`='%d'", PlayerInfo[playerid][pUID]);
	mysql_query(qr);
	new skinID;
	mysql_store_result();
	{
		if(mysql_num_rows()>0)
		{
			while(mysql_fetch_row_format(qr, "|"))
			{
				sscanf(qr, "p<|>d", skinID);
				VECTOR_push_back_val(VPremiumSkins[playerid], skinID);
			}
		}
        mysql_free_result();
	}
}

MruMySQL_InsertPremiumItem(playerid, itemid)
{
    new str[256];
    format(str, 256, "INSERT INTO `mru_playeritems` (`model`, `UID`, `bone`, `x`, `y`, `z`, `rx`, `ry`, `rz`) VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f')", 
		PrzedmiotyPremium[itemid][Model], 
		PlayerInfo[playerid][pUID], 
		2, //TODO
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0
	);
    mysql_query(str);
    new id = mysql_insert_id();
    return id;
}

MruMySQL_LoadPlayerPremiumItems(playerid)
{
	new str[256], model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, active, bone;
    format(str, 256, "SELECT `model`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz`, `active`,`bone` FROM `mru_playeritems` WHERE `UID`='%d'", PlayerInfo[playerid][pUID]);
    mysql_query(str);
    mysql_store_result();
    while(mysql_fetch_row_format(str, "|"))
    {
        sscanf(str, "p<|>dfffffffffdd", model, x, y, z, rx, ry, rz, sx, sy, sz, active, bone);
		VECTOR_push_back_val(VPremiumItems[playerid], model);
		if(active)
		{
			AttachPremiumItem(playerid, model, bone, x,y,z, rx,ry,rz, sx,sy,sz);
		}
    }
    mysql_free_result();
}


MruMySQL_UpdatePremiumItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone, active) {
    new str[256];
    format(str, 256, "UPDATE mru_playeritems SET `model`='%d', `bone`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f', `active`='%d' WHERE `uid`=%d AND model='%d'", 
		model, bone, x,y,z,rx,ry,rz, active, PlayerInfo[playerid][pUID], model);
    mysql_query(str);
}

MruMySQL_IsPhoneNumberAvailable(number) {
    
    if(100 >= number <= 150) return false;
    if(number == 555) return false;
    new string[70];
    format(string, sizeof(string), "SELECT `UID` FROM `mru_konta` WHERE `PhoneNr` = %d", number);
    mysql_query(string);
    mysql_store_result();
    if(mysql_num_rows() > 0)
    {
        mysql_free_result();
        return true;
    }
    mysql_free_result();
    return false;
}
//end