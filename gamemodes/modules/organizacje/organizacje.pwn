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
LoadOrganisations()
{
    new lQuery[256], rowCount, lRow;
    mysql_query("SELECT * FROM `mru_org` ORDER BY ID");
    mysql_store_result();
    while(mysql_fetch_row_format(lQuery, "|"))
    {
        sscanf(lQuery, "p<|>de<ds[32]s[128]hffffdd>", lRow, OrgInfo[rowCount]);
        rowCount++;
    }
    mysql_free_result();
    printf("%d | Wczytano organizacje", rowCount);
}

SaveOrg(id, savetype)
{
    new query[512];
	new name_escaped[32];
	new motd_escaped[128];
	mysql_real_escape_string(OrgInfo[id][o_Name], name_escaped);
	mysql_real_escape_string(OrgInfo[id][o_Motd], motd_escaped);
	
    switch(savetype)
    {
        case ORG_SAVE_TYPE_BASIC: 
        {
            format(query, sizeof(query), "UPDATE `mru_org` SET `Type`='%d', `Color`=x'%08x', `x`='%f', `y`='%f', `z`='%f', `a`='%f', `Int`='%d', `VW`='%d' WHERE `ID`='%d'",
                OrgInfo[id][o_Type], 
                OrgInfo[id][o_Color], 
                OrgInfo[id][o_Spawn][0],OrgInfo[id][o_Spawn][1],OrgInfo[id][o_Spawn][2],OrgInfo[id][o_Spawn][3], 
                OrgInfo[id][o_Int], OrgInfo[id][o_VW], 
                id);
        }
        case ORG_SAVE_TYPE_DESC: 
        {
            format(query, sizeof(query), "UPDATE `mru_org` SET `Name`='%s', `Motd`='%s' WHERE `ID`='%d'", 
                name_escaped, motd_escaped, id);
        }
    }
    mysql_query(query);
    return 1;
}

GetPlayerOrgType(playerid) 
{
	return GetOrgType(GetPlayerOrg(playerid));
}

GetOrgType(id)
{
    if(!IsOrgValid(id)) return ORG_TYPE_INACTIVE;
    return OrgInfo[id][o_Type];
}

IsOrgValid(id)
{
    if(id <= 0 || id >= MAX_ORG) return 0;
    if(OrgInfo[id][o_Type] == ORG_TYPE_INACTIVE) return 0;
    return 1;
}

GetFreeOrgSlot()
{
    for(new i=0; i<MAX_ORG; i++)
    {
        if(OrgInfo[i][o_Type] == ORG_TYPE_INACTIVE)
        {
            return i;
        }
    }
    return -1;
}

InvitePlayerToOrg(playerid, org, leader=false)
{
    if(!IsOrgValid(org)) return 0;

    PlayerInfo[playerid][pOrg] = org;
	if(OrgSkins[org][0] > 0)
	{
		PlayerInfo[playerid][pUniform] = OrgSkins[org][0];
	}
    if(leader)
    {
        PlayerInfo[playerid][pRank] = 1000;
    }

    MruMessageGoodInfoF(playerid, "Zosta³eœ przyjêty do organizacji %s.", OrgInfo[org][o_Name]);
	MruMySQL_SavePlayerFamily(playerid);
    return 1;
}

RemovePlayerFromOrg(playerid)
{
    new org = PlayerInfo[playerid][pOrg];
    PlayerInfo[playerid][pOrg] = 0;
	PlayerInfo[playerid][pRank] = 0;
    PlayerInfo[playerid][pUniform] = 0;
	MruMySQL_SavePlayerFamily(playerid);

    if(!IsOrgValid(org)) return 0;
    MruMessageBadInfoF(playerid, "Zosta³eœ wyrzucony z organizacji %s.", OrgInfo[org][o_Name]);
    return 1;
}

SetOrgName(orgid, name[])
{
    if(!IsOrgValid(orgid)) return 0;
    if(strlen(name) < 3 || strlen(name) > 31) return 0;

    format(OrgInfo[orgid][o_Name], 32, "%s", name);
    return 1;
}

SetOrgMOTD(org, lMotd[])
{
    if(!IsOrgValid(org)) return 0;
    if(strlen(lMotd) > 127) return 0;

    if(strlen(lMotd) == 0) strdel(OrgInfo[org][o_Motd], 0, 128);
    else format(OrgInfo[org][o_Motd], 128, "%s", lMotd);
    return 1;
}

SetOrgSpawnAtPlayerPos(playerid, org)
{
    if(!IsOrgValid(org)) return 0;

    GetPlayerPos(playerid, OrgInfo[org][o_Spawn][0], OrgInfo[org][o_Spawn][1], OrgInfo[org][o_Spawn][2]);
    GetPlayerFacingAngle(playerid, OrgInfo[org][o_Spawn][3]);
	SaveOrg(org, ORG_SAVE_TYPE_BASIC);

    MruMessageGoodInfo(playerid, "Spawn organizacji ustawiony w tym miejscu zmieniony.");
    return 1;
}

GivePlayerOrgRank(playerid, callerid, rank)
{
    new org = PlayerInfo[playerid][pOrg];
    if(!IsOrgValid(org)) return 0;

    PlayerInfo[playerid][pRank] = rank;
	MruMySQL_SetAccInt("Rank", GetNickEx(playerid), rank);

    MruMessageGoodInfoF(playerid, "Otrzyma³eœ %d rangê (%s) w organizacji %s. Nada³: %s.", rank, (strlen(OrgRank[org][rank]) > 1) ? (OrgRank[PlayerInfo[playerid][pOrg]][rank]) : (OrgRank[0][rank]), OrgInfo[org][o_Name], (callerid == INVALID_PLAYER_ID) ? ("SYSTEM") : (GetNick(callerid)));
    return 1;
}

GetPlayerOrg(playerid)
{
	return PlayerInfo[playerid][pOrg];
}

IsPlayerOrgLeader(playerid, checkOrg=-1)
{
    new org = GetPlayerOrg(playerid);
    if(!IsOrgValid(org)) return false;
    if(checkOrg != -1 && checkOrg != org) return false;

    return GetPlayerRank(playerid) >= 1000;
}

GetPlayerRank(playerid)
{
    return PlayerInfo[playerid][pRank];
}

SendNewFamilyMessage(family, color, string[])
{
    if(family == 0) return;

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