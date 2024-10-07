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
    new query[512], rowCount;
    mysql_query("SELECT `Type`, HEX(`Color`), `x`, `y`, `z`, `a`, `Int`, `Vw`, `LeaderStake`, `Name`, `Motd` FROM `mru_org` WHERE ID < "#MAX_ORG" ORDER BY ID");
    mysql_store_result();
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>e<dhffffddds[128]s[32]>", OrgInfo[rowCount]);
        rowCount++;
    }
    mysql_free_result();
    printf("Wczytano %d organizacji", rowCount);
}

SaveOrg(id)
{
    new query[1024];
	new name_escaped[32];
	new motto_escaped[128];
	mysql_real_escape_string(OrgInfo[id][o_Name], name_escaped);
	mysql_real_escape_string(OrgInfo[id][o_Motto], motto_escaped);
	
    format(query, sizeof(query), 
        "UPDATE `mru_org` SET " \
        "`Type`='%d', `Name`='%s', `Motd`='%s', `Color`=x'%08x', `x`='%f', `y`='%f', `z`='%f', `a`='%f', `Int`='%d', `VW`='%d', `LeaderStake`='%d' " \
        "WHERE ID=%d",
        OrgInfo[id][o_Type], 
        OrgInfo[id][o_Name], 
        OrgInfo[id][o_Motto], 
        OrgInfo[id][o_Color], 
        OrgInfo[id][o_Spawn][0],OrgInfo[id][o_Spawn][1],OrgInfo[id][o_Spawn][2],OrgInfo[id][o_Spawn][3], 
        OrgInfo[id][o_Int], OrgInfo[id][o_VW], 
        OrgInfo[id][o_LeaderStake],
        id);
    mysql_query(query);
    return 1;
}

CreateOrganisation(org, name[], color)
{
    OrgInfo[org][o_Type] = ORG_TYPE_ORGANIZATION;
    format(OrgInfo[org][o_Name], MAX_ORG_NAME_LENGTH, name);
    format(OrgInfo[org][o_Motto], 128, "");
    OrgInfo[org][o_Color] = color | 0xFFFFFFFF;
    OrgInfo[org][o_Spawn][0] = -5223.47;
    OrgInfo[org][o_Spawn][1] = 2167.22;
    OrgInfo[org][o_Spawn][2] = 5.3412;
    OrgInfo[org][o_Spawn][3] = 252.4531;
    OrgInfo[org][o_Int] = 0;
    OrgInfo[org][o_VW] = 0;
    OrgInfo[org][o_LeaderStake] = 5;

    SaveOrg(org);
}

RemoveOrganisation(org)
{
    foreach(new i : Player)
    {
        if(GetPlayerOrg(i) == org)
        {
		    RemovePlayerFromOrg(i);
            MruMessageBadInfo(i, "Ogranizacja w której by³eœ zosta³a usuniêta, zostajesz z niej wyrzucony!");
        }
    }

    ResetOrgBusinessesToDefault(org);
    MruMySQL_RemoveOrgAssets(org);

    Sejf_Rodziny[org] = 0;
    Rodzina_Mats[org] = 0;
    SejfR_Save(org);

    OrgInfo[org][o_Type] = ORG_TYPE_INACTIVE;
    format(OrgInfo[org][o_Name], MAX_ORG_NAME_LENGTH, "");
    format(OrgInfo[org][o_Motto], 128, "");
    OrgInfo[org][o_Color] = 0xFFFFFFFF;
    OrgInfo[org][o_Spawn][0] = 0.0;
    OrgInfo[org][o_Spawn][1] = 0.0;
    OrgInfo[org][o_Spawn][2] = 0.0;
    OrgInfo[org][o_Spawn][3] = 0.0;
    OrgInfo[org][o_Int] = 0;
    OrgInfo[org][o_VW] = 0;
    OrgInfo[org][o_LeaderStake] = 5;

    SaveOrg(org);
}

AccountOrgsCosts()
{
    new membersCost[MAX_ORG];

    // members cost
	new query[512];
	format(query, sizeof(query), "SELECT UID, FMember FROM `mru_konta` WHERE FMember!=0");
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows()) 
    {
		while(mysql_fetch_row_format(query, "|")) 
        {
			new playerUID, org;
			sscanf(query, "p<|>ii", playerUID, org);
            
            if(IsActiveOrg(org))
            {
                membersCost[org] += ORG_DAILY_MEMBER_COST;
                AccountOrgBenefitForPlayerUID(playerUID, org, -ORG_DAILY_MEMBER_COST);
            }
		}
	}
	mysql_free_result();

    for(new i=1; i<MAX_ORG; i++)
    {
        new cost = ORG_DAILY_COST + membersCost[i];
        SejfR_Add(i, -cost);
        Log(serverLog, INFO, "Dzienny koszt dla organizacji %d: %d$, nowy sejf: %d", i, cost, Sejf_Rodziny[i]);

        if(Sejf_Rodziny[i] <= DELETE_ORG_THRESHOLD)
        {
            RemoveOrganisation(i);
            Log(serverLog, INFO, "Organizacja zostala automatycznie usunieta z powodu dlugu %d$", Sejf_Rodziny[i]);
        }
    }
}

AccountOrgBenefitForPlayerUID(playerUID, org, benefit)
{
    RedisIncrBy(sprintf("player:%d:org:%d:benefit", playerUID, org), benefit);
}

GetPlayerOrgBenefit(playerUID, org)
{
    return RedisGetInt(sprintf("player:%d:org:%d:benefit", playerUID, org));
}

GetPlayerTakeoverPoints(playerUID, org)
{
    return RedisGetInt(sprintf("player:%d:org:%d:takeoverPoints", playerUID, org));
}

IncrPlayerTakeoverPoints(playerid, org, value=1)
{
    RedisIncrBy(sprintf("player:%d:org:%d:takeoverPoints", PlayerInfo[playerid][pUID], org), value);
}

IsActiveOrg(id)
{
    if(id <= 0 || id >= MAX_ORG) return 0;
    if(OrgInfo[id][o_Type] == ORG_TYPE_INACTIVE) return 0;
    return 1;
}

GetFreeOrgSlot()
{
    for(new i=1; i<MAX_ORG; i++)
    {
        if(OrgInfo[i][o_Type] == ORG_TYPE_INACTIVE)
        {
            return i;
        }
    }
    return -1;
}

InvitePlayerToOrg(playerid, org, rank=0)
{
    if(!IsActiveOrg(org)) return 0;

    PlayerInfo[playerid][pOrg] = org;
	if(OrgSkins[org][0] > 0)
	{
		PlayerInfo[playerid][pUniform] = OrgSkins[org][0];
	}
    PlayerInfo[playerid][pRank] = rank;

    ResetPlayerOrgStatistics(playerid);
	MruMySQL_SavePlayerOrganisation(playerid);
    return 1;
}

RemovePlayerFromOrg(playerid)
{
    ResetPlayerOrgStatistics(playerid);
    
    new org = PlayerInfo[playerid][pOrg];
    PlayerInfo[playerid][pOrg] = 0;
	PlayerInfo[playerid][pRank] = 0;
    PlayerInfo[playerid][pUniform] = 0;
	MruMySQL_SavePlayerOrganisation(playerid);

    if(!IsActiveOrg(org)) return 0;
    MruMessageBadInfoF(playerid, "Zosta³eœ wyrzucony z organizacji %s.", OrgInfo[org][o_Name]);
    return 1;
}

SetOrgName(org, name[])
{
    if(!IsActiveOrg(org)) return 0;

    format(OrgInfo[org][o_Name], MAX_ORG_NAME_LENGTH, "%s", name);
    SaveOrg(org);
    return 1;
}

SetOrgMotto(org, motto[])
{
    if(!IsActiveOrg(org)) return 0;

    format(OrgInfo[org][o_Motto], 128, "%s", motto);
    SaveOrg(org);
    return 1;
}

SetOrgSpawnAtPlayerPos(playerid, org)
{
    if(!IsActiveOrg(org)) return 0;

    GetPlayerPos(playerid, OrgInfo[org][o_Spawn][0], OrgInfo[org][o_Spawn][1], OrgInfo[org][o_Spawn][2]);
    GetPlayerFacingAngle(playerid, OrgInfo[org][o_Spawn][3]);
	SaveOrg(org);
    return 1;
}

GivePlayerOrgRank(playerid, rank)
{
    new org = PlayerInfo[playerid][pOrg];
    if(!IsActiveOrg(org)) return 0;

    PlayerInfo[playerid][pRank] = rank;
	MruMySQL_SetAccInt("Rank", GetNickEx(playerid), rank);
    return 1;
}

GetPlayerOrg(playerid)
{
	return PlayerInfo[playerid][pOrg];
}

IsPlayerOrgLeader(playerid, checkOrg=-1)
{
    new org = GetPlayerOrg(playerid);
    if(!IsActiveOrg(org)) return false;
    if(checkOrg != -1 && checkOrg != org) return false;

    return GetPlayerRank(playerid) == MAIN_LEADER_RANK;
}

GetPlayerRank(playerid)
{
    return PlayerInfo[playerid][pRank];
}

SendOrgMessage(family, color, string[])
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
    if(GetPlayerOrg(playerid) > 0)
    {
        return 1;
    }
	return 0;
}

IsAClubBusinessOwner(playerid)
{
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_CLUB))
    {
        return 1;
    }
	return 0;
}

IsAPoolBusinessOwner(playerid)
{
    return IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_BOAT);
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

ResetPlayerOrgStatistics(playerid)
{
    RedisDelete(sprintf("player:%d:org:%d:benefit", PlayerInfo[playerid][pUID], GetPlayerOrg(playerid)));
    RedisDelete(sprintf("player:%d:org:%d:takeoverPoints", PlayerInfo[playerid][pUID], GetPlayerOrg(playerid)));
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end