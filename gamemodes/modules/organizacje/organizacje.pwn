//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                organizacje                                                //
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
// Data utworzenia: 15.05.2019
//Opis:
/*
	System organizacji przestêpczych.
*/

//
//-----------------<[ Funkcje: ]>-------------------
orgLoad()
{
    new lQuery[256], lID, lRow;
    mysql_query("SELECT * FROM `mru_org`");
    mysql_store_result();
    while(mysql_fetch_row_format(lQuery, "|"))
    {
        sscanf(lQuery, "p<|>de<dds[32]s[128]hffffdd>", lRow, OrgInfo[lID]);
        lID++;
    }
    mysql_free_result();
    printf("%d | Wczytano organizacje", lID);
}

orgSave(lID, savetype)
{
    if(!orgIsValid(lID)) return 0;
    new lQuery[512];
	new name_escaped[32];
	new motd_escaped[128];
	mysql_real_escape_string(OrgInfo[lID][o_Name], name_escaped);
	mysql_real_escape_string(OrgInfo[lID][o_Motd], motd_escaped);
	
    switch(savetype)
    {
        case ORG_SAVE_TYPE_BASIC: format(lQuery, sizeof(lQuery), "UPDATE `mru_org` SET `Type`='%d', `Color`=x'%08x', `x`='%f', `y`='%f', `z`='%f', `a`='%f', `Int`='%d', `VW`='%d' WHERE `UID`='%d'",
        OrgInfo[lID][o_Type],OrgInfo[lID][o_Color],OrgInfo[lID][o_Spawn][0],OrgInfo[lID][o_Spawn][1],OrgInfo[lID][o_Spawn][2],OrgInfo[lID][o_Spawn][3], OrgInfo[lID][o_Int], OrgInfo[lID][o_VW], OrgInfo[lID][o_UID]);
        case ORG_SAVE_TYPE_DESC: format(lQuery, sizeof(lQuery), "UPDATE `mru_org` SET `Name`='%s', `Motd`='%s' WHERE `UID`='%d'", name_escaped, motd_escaped, OrgInfo[lID][o_UID]);
    }
    if(lQuery[0]) mysql_query(lQuery);
    return 1;
}

orgAdd(typ, name[], uid, id)
{
    OrgInfo[id][o_UID] = uid;
    OrgInfo[id][o_Type] = typ;
    OrgInfo[id][o_Color] = 0xFF0000;
    orgSetName(id, name);
    new lStr[128];
	new name_escaped[32];
	mysql_real_escape_string(OrgInfo[id][o_Name], name_escaped);
    format(lStr, 128, "INSERT INTO `mru_org` (`UID`, `Name`, `Type`) VALUES ('%d', '%s', '%d')", uid, name_escaped, typ);
    mysql_query(lStr);
}

GetPlayerOrgType(playerid) 
{
	return orgType(gPlayerOrg[playerid]);
}

orgType(lID)
{
    if(lID == 0xFFFF) return 0;
    return OrgInfo[lID][o_Type];
}

orgID(uid)
{
    for(new i=0;i<MAX_ORG;i++)
    {
        if(OrgInfo[i][o_UID] == uid)
        {
            return i;
        }
    }
    return 0xFFFF;
}

orgIsValid(orgid)
{
    if(orgid < 0 || orgid > MAX_ORG-1) return 0;
    if(OrgInfo[orgid][o_UID] == 0) return 0;
    return 1;
}

orgGetFreeSlot()
{
    for(new i=0;i<MAX_ORG;i++)
    {
        if(OrgInfo[i][o_UID] == 0)
        {
            return i;
        }
    }
    return 0xFFFF;
}

orgInvitePlayer(playerid, orguid)
{
    new orgid = orgID(orguid);
    if(!orgIsValid(orgid)) return 0;
    gPlayerOrg[playerid] = orgid;
    PlayerInfo[playerid][pOrg] = orguid;
	if(FAM_SKINS[orguid][0] > 0)
	{
		PlayerInfo[playerid][pUniform] = FAM_SKINS[orguid][0];
	}
    gPlayerOrgLeader[playerid] = false;
    new lStr[64];
    format(lStr, 64, "ORG » Zosta³eœ przyjêty do organizacji %s.", OrgInfo[orgid][o_Name]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, lStr);
	MruMySQL_SavePlayerFamily(playerid);
    return 1;
}

orgUnInvitePlayer(playerid)
{
    new orgid = gPlayerOrg[playerid];
    PlayerInfo[playerid][pOrg] = 0;
	PlayerInfo[playerid][pRank] = 0;
    PlayerInfo[playerid][pUniform] = 0;
    gPlayerOrg[playerid] = 0xFFFF;
    new lStr[64];
    if(!orgIsValid(orgid)) return 0;
    format(lStr, 64, "ORG » Zosta³eœ wyproszony z organizacji %s.", OrgInfo[orgid][o_Name]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, lStr);
    gPlayerOrgLeader[playerid] = false;
	MruMySQL_SavePlayerFamily(playerid);
    return 1;
}

orgSetName(orgid, name[])
{
    if(!orgIsValid(orgid)) return 0;
    if(strlen(name) < 3 || strlen(name) > 31) return 0;
    format(OrgInfo[orgid][o_Name], 32, "%s", name);
    return 1;
}

orgSetMotd(orgid, lMotd[])
{
    if(!orgIsValid(orgid)) return 0;
    if(strlen(lMotd) > 127) return 0;
    if(strlen(lMotd) == 0) strdel(OrgInfo[orgid][o_Motd], 0, 128);
    else format(OrgInfo[orgid][o_Motd], 128, "%s", lMotd);
    return 1;
}

orgSetSpawnAtPlayerPos(playerid, orgid)
{
    if(!orgIsValid(orgid)) return 0;
    GetPlayerPos(playerid, OrgInfo[orgid][o_Spawn][0], OrgInfo[orgid][o_Spawn][1], OrgInfo[orgid][o_Spawn][2]);
    GetPlayerFacingAngle(playerid, OrgInfo[orgid][o_Spawn][3]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "ORG » Spawn zmieniony.");
	orgSave(orgid, ORG_SAVE_TYPE_BASIC);
    return 1;
}

orgGivePlayerRank(playerid, callerid, rankid)
{
    new orgid = gPlayerOrg[playerid];
    if(!orgIsValid(orgid)) return 0;
    new lStr[128];
    format(lStr, 128, "ORG » Otrzyma³eœ %d rangê (%s) w organizacji %s. Nada³: %s.", rankid, (strlen(FamRang[PlayerInfo[playerid][pOrg]][rankid]) > 1) ? (FamRang[PlayerInfo[playerid][pOrg]][rankid]) : (FamRang[0][rankid]), OrgInfo[orgid][o_Name], (callerid == INVALID_PLAYER_ID) ? ("SYSTEM") : (GetNick(callerid)));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, lStr);
    PlayerInfo[playerid][pRank] = rankid;
	MruMySQL_SetAccInt("Rank", GetNickEx(playerid), rankid);
    return 1;
}

GetPlayerOrg(playerid)
{
	return PlayerInfo[playerid][pOrg];
}

IsPlayerOrgLeader(playerid)
{
    new orgid = gPlayerOrg[playerid];
    if(!orgIsValid(orgid)) return 0;
    return gPlayerOrgLeader[playerid];
}

SendNewFamilyMessage(family, color, string[])
{
	foreach(new i : Player)
	{
		if(GetPlayerOrg(i) == family)
		{
			if(!gFam[i])
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}

IsAPrzestepca(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerOrg(playerid) > 0)
		{
		    return 1;
		}
	}
	return 0;
}

stock IsAGang(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerOrgType(playerid) == ORG_TYPE_GANG)
		{
		    return 1;
		}
	}
	return 0;
}

stock IsAMafia(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerOrgType(playerid) == ORG_TYPE_MAFIA)
		{
		    return 1;
		}
	}
	return 0;
}

IsAClubBusinessOwner(playerid)
{
	return GetPlayerOrgType(playerid) == ORG_TYPE_CLUB;
}

IsAGunShopBusinessOwner(playerid) // TODO: change
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerOrg(playerid) == 21 || GetPlayerOrg(playerid) == 22 || GetPlayerOrg(playerid) == 23)
		{
		    return 1;
		}
	}
	return 0;
}

IsAPoolBusinessOwner(playerid) // TODO: change
{
    return IsAPoolBusinessOwner(playerid);
}

CheckFamilyChatPermission(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(GetPlayerOrg(playerid) != 0 || (GetPlayerFraction(playerid) > 7 && GetPlayerFraction(playerid) < 11))
		{
		    return 1;
		}
	}
	return 0;
}

GivePlayerOrgGun(playerid)
{
    if(GetPlayerOrg(playerid) != 0)
    {
        if(PlayerInfo[playerid][pGun1] == 0)
        {
            PlayerInfo[playerid][pGun1] = 5; PlayerInfo[playerid][pAmmo1] = 1;
            playerWeapons[playerid][weaponLegal2] = 1;
        }
    }
	return 1;
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end