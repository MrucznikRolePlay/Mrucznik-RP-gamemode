//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gangzone                                                 //
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
// Data utworzenia: 06.09.2024
//Opis:
/*
	System wojen gangów.
*/

//

//-----------------<[ Funkcje: ]>-------------------
DestroyGangzones()
{
	for(new i;i<MAX_ZONES;i++)
    {
        GangZoneDestroy(ZoneIDs[i]);
    }
}


public Zone_HideInfo(playerid)
{
    ZoneTXD_Hide(playerid);
    ZonePlayerTimer[playerid]=0;
}

ZoneTXD_Unload()
{
    for(new i=0;i<5;i++) TextDrawDestroy(Text:i);
}


Zone_StartAttack(zoneid, attacker, defender)
{
    ZoneAttack[zoneid] = true; //make

    if(attacker > 100) //gangi
    {
        if(defender > 100) //gang-gang
        {
            foreach(new i : Player)
            {
                if(GetPlayerOrg(i) == attacker-100)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttacker[i] = true;
                    SetPlayerCriminal(i, INVALID_PLAYER_ID, "Wojna gangów", false);
                }
                else if(GetPlayerOrg(i) == defender-100)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_pod_atakiem!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneDefender[i] = true;
                }
            }
        }
        else
        {
            foreach(new i : Player) //gang-frac
            {
                if(GetPlayerOrg(i) == attacker-100)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttacker[i] = true;
                    SetPlayerCriminal(i, INVALID_PLAYER_ID, "Wojna gangów", false);
                }
                else if(defender != 0 && GetPlayerFraction(i) == defender)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_pod_atakiem!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneDefender[i] = true;
                }
            }
        }
    }
    else  //frac
    {
        if(defender > 100) //frac - gang
        {
            foreach(new i : Player)
            {
                if(GetPlayerFraction(i) == attacker)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttacker[i] = true;
                    SetPlayerCriminal(i, INVALID_PLAYER_ID, "Wojna gangów", false);
                }
                else if(GetPlayerOrg(i) == defender-100)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_pod_atakiem!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneDefender[i] = true;
                }
            }
        }
        else
        {
            foreach(new i : Player) //frac - frac
            {
                if(GetPlayerFraction(i) == attacker)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttacker[i] = true;
                    SetPlayerCriminal(i, INVALID_PLAYER_ID, "Wojna gangów", false);
                }
                else if(defender != 0 && GetPlayerFraction(i) == defender)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_pod_atakiem!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneDefender[i] = true;
                }
            }
        }
    }

    new str[128];
    format(str, 128, "DELETE FROM `mru_strefylimit` WHERE `gang`='%d'", attacker);
    mysql_query(str);
    format(str, 128, "INSERT INTO `mru_strefylimit` (`gang`, `data`) VALUES ('%d', '%d')", attacker, gettime());
    mysql_query(str);
    format(str, 128, "UPDATE `mru_strefy` SET `expire`='%d' WHERE `id`='%d'", gettime()+86400, zoneid);
    mysql_query(str);

    ZoneProtect[zoneid] = 1;
    ZoneAttackData[zoneid][2] = attacker;
    ZoneAttackData[zoneid][3] = defender;
    ZoneGangLimit[attacker] = false;
    format(str, 128, "ZONEDEFTIME_%d", zoneid);
    SetSVarInt(str, ZONE_DEF_TIME);
    ZoneAttackTimer[zoneid] = SetTimerEx("Zone_AttackEnd", ZONE_DEF_TIME*1000, 0, "iii", zoneid, attacker, defender);
    printf("[GangZone] Atak na strefê %d przez %d. Atakuje %d osób broni %d osób.", zoneid, attacker, ZoneAttackData[zoneid][0], ZoneAttackData[zoneid][1]);
}

Zone_GangUpdate(bool:cash=false)
{
    new string[256];
    new gangid, timegang;
    mysql_query("SELECT * FROM `mru_strefylimit`");
    mysql_store_result();
    while(mysql_fetch_row_format(string, "|"))
    {
        sscanf(string, "p<|>dd", gangid, timegang);
        if(!(0 <= gangid <= MAX_FRAC)) continue;
        if(gettime()-timegang >= 86400) ZoneGangLimit[gangid] = true; //1 day
        else ZoneGangLimit[gangid] = false;
    }
    mysql_free_result();
    if(cash)
    {
        for(new i=0;i<MAX_ZONES;i++)
        {
            if(ZoneControl[i] > 0 && ZoneControl[i] < 100)
            {
                //Sejf_Add(ZoneControl[i], Zone_GetCash(i));
            }
            else if(ZoneControl[i]>100)
            {
                //SejfR_Add(ZoneControl[i]-100, Zone_GetCash(i));
            }
        }
    }
}

public Zone_AttackEnd(zoneid, attacker, defender)
{
    ZoneAttack[zoneid] = false;
    new str[128];
    if(ZoneAttackData[zoneid][1] < ZoneAttackData[zoneid][0]) //win
    {
        format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", attacker, zoneid);
        mysql_query(str);

        ZoneControl[zoneid] = attacker;
        new thisorg = ZoneControl[zoneid]-100;
        foreach(new i : Player)
        {
			GangZoneHideForPlayer(i, zoneid);
			GangZoneShowForPlayer(i, zoneid, OrgInfo[thisorg][o_Color] | 0x44);
        }
        
        if(attacker > 100) //gangi
        {
            if(defender > 100) //gang-gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //gang-frac
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
        else  //frac
        {
            if(defender > 100) //frac - gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //frac - frac
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
    }
    else
    {

        if(attacker > 100) //gangi
        {
            if(defender > 100) //gang-gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //gang-frac
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
        else  //frac
        {
            if(defender > 100) //frac - gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //frac - frac
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
    }
    format(str, 128, "ZONEDEFTIME_%d", zoneid);
    DeleteSVar(str);
    printf("FINAL Attackers: %d Defenders: %d", ZoneAttackData[zoneid][0], ZoneAttackData[zoneid][1]);
    GangZoneStopFlashForAll(zoneid);
    ZoneAttackData[zoneid][0] = 0;
    ZoneAttackData[zoneid][1] = 0;
}

Zone_Sync(playerid)
{
    new frac = GetPlayerFraction(playerid);
    if(frac == 0) frac = GetPlayerOrg(playerid);
    for(new i=0;i<MAX_ZONES;i++)
    {
        if(ZoneAttack[i])
        {
            if(ZoneAttackData[i][2] > 100)
            {
                if(frac == ZoneAttackData[i][2]-100)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atakujesz_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
                else if(frac == ZoneAttackData[i][3]-100)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
            }
            else
            {
                if(frac == ZoneAttackData[i][2])
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atakujesz_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
                else if(frac == ZoneAttackData[i][3])
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
            }
        }
    }
}

Zone_Load()
{
    new query[128];
    mysql_query("SELECT * FROM `mru_strefy`");
    mysql_store_result();
    new id, kontrol, expire, time=gettime();
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ddd", id, kontrol, expire);
        ZoneControl[id] = kontrol;
        if(expire == -1) ZoneProtect[id] = 1;
        else if(time - expire < 86400) ZoneProtect[id] = 1;
        else ZoneProtect[id] = 0;
    }
    mysql_free_result();

    if(ZoneControl[id] > 100)
    {
        if(ZoneControl[id]-100 == 0)
        {
            ZoneControl[id] = 0;
            ZoneProtect[id] = 0;
        }
    }

    Zone_GangUpdate();

    for(new i=0;i<MAX_ZONES;i++)
    {
        id = GangZoneCreate(Zone_Data[i][0],Zone_Data[i][1],Zone_Data[i][2],Zone_Data[i][3]);
        ZoneIDs[i] = id;
        Zone_Area[i] = ((Zone_Data[i][2]-Zone_Data[i][0])*(Zone_Data[i][3]-Zone_Data[i][1]));
    }
}

Zone_CheckPossToAttack(playerid, zoneid)
{
    if(ZoneProtect[zoneid] == 1)
    {
        MSGBOX_Show(playerid, "Strefa_chroniona", MSGBOX_ICON_TYPE_WARNING);
        return false;
    }
    new fam = GetPlayerOrg(playerid);
    if(fam != 0)
    {
        if(OrgInfo[fam][o_Color] & 0xFF000069 == 0xFF000069)
        {
            MSGBOX_Show(playerid, "Zmien_kolor_swojej_organizacji_(/pr_kolor)", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    new vic, att;
    if(ZoneControl[zoneid] == 0) //neutralne
    {
        new org = GetPlayerFraction(playerid);
        foreach(new i : Player)
        {
            if(GetPVarInt(i, "zoneid") == zoneid)
            {
                if(org != 0)
                {
                    if(org == GetPlayerFraction(i))
                    {
                        att++;
                    }
                }
                else
                {
                    if(fam == GetPlayerOrg(i))
                    {
                        att++;
                    }
                }
            }
        }
        if(att < Zone_MinimumPeople(zoneid))
        {
            MSGBOX_Show(playerid, "Brak_wymaganej_liczby_atakujacych!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    else
    {
        new
            zonec = ZoneControl[zoneid],
            org = GetPlayerFraction(playerid);
        if(zonec == org || zonec-100 == fam) return false;
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        foreach(new i : Player)
        {
            if(zonec > 100)
            {
                if(GetPlayerOrg(i) == zonec-100)
                {
                    vic++;
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttackData[zoneid][1]++;
                }
            }
            else
            {
                if(GetPlayerFraction(i) == zonec)
                {
                    vic++;
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttackData[zoneid][1]++;
                }
            }
            if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
            {
                if(org != 0)
                {
                    if(org == GetPlayerFraction(i))
                    {
                        att++;
                    }
                }
                else
                {
                    if(fam == GetPlayerOrg(i))
                    {
                        att++;
                    }
                }
            }
        }
        if(att < Zone_MinimumPeople(zoneid))
        {
            MSGBOX_Show(playerid, "Brak_wymaganej_liczby_atakujacych!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
        if(vic < att)
        {
            MSGBOX_Show(playerid, "Brak_aktywnych_obroncow!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    ZoneAttackData[zoneid][0] = att;
    return true;
}

ZoneTXD_Show(playerid, zoneid)
{
    ZoneTXD_Hide(playerid);
    new bool:gang=false;
    new frac=GetPlayerFraction(playerid);
    if(IsAPrzestepca(playerid) && PlayerInfo[playerid][pRank] > 3) gang = true;
    if(ZoneControl[zoneid] != 0 && (ZoneControl[zoneid] == frac || ZoneControl[zoneid]-100==GetPlayerOrg(playerid))) gang = false;

    for(new i=0;i<3;i++)
    {
        TextDrawShowForPlayer(playerid, ZoneTXD[i]);
    }
    if(gang && ZoneProtect[zoneid] == 0) TextDrawShowForPlayer(playerid, ZoneTXD[3]);

    new str[128];
    if(ZoneControl[zoneid] != 0)
    {
        new orgid = ZoneControl[zoneid]-100;
        if(ZoneControl[zoneid] <= 100)
            format(str, 128, "Kontrolowana~n~przez: ~g~~h~%s", FractionNames[ZoneControl[zoneid]]);
        else if(orgid < MAX_ORG)
            format(str, 128, "Kontrolowana~n~przez: ~g~~h~%s", OrgInfo[orgid][o_Name]);
    }
    else format(str, 128, "Kontrolowana~n~przez: %s", "Brak");
    PlayerTextDrawSetString(playerid, ZonePTXD_Name[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Name[playerid]);

    format(str, 128, "Zysk:~n~____%d$", Zone_GetCash(zoneid));
    PlayerTextDrawSetString(playerid, ZonePTXD_Cash[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Cash[playerid]);

    format(str, 128, "Powierzchnia:~n~____%.2f km", Zone_Area[zoneid]/10000);
    PlayerTextDrawSetString(playerid, ZonePTXD_Area[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Area[playerid]);

    format(str, 128, "Wymagana liczba~n~atakujacych:____%d", Zone_MinimumPeople(zoneid));
    PlayerTextDrawSetString(playerid, ZonePTXD_Member[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Member[playerid]);

    SetPVarInt(playerid, "zoneid", zoneid);
}

ZoneTXD_Hide(playerid)
{
    for(new i=0;i<5;i++)
    {
        TextDrawHideForPlayer(playerid, ZoneTXD[i]);
    }
    PlayerTextDrawHide(playerid, ZonePTXD_Name[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Cash[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Area[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Member[playerid]);
}

Zone_MinimumPeople(zoneid)
{
    new Float:area = Zone_Area[zoneid]/10000;
    new ppl;
    if(0 < area < 1.0) ppl = 3;
    else if(1.0 <= area < 2.0) ppl = 5;
    else if(2.0 <= area < 4.0) ppl = 7;
    else if(4.0 <= area < 8.0) ppl = 10;
    else if(8.0 <= area < 12.0) ppl = 15;
    else if(12.0 <= area < 15.0) ppl = 25;
    else if(15.0 <= area < 20.0) ppl = 35;
    else ppl = 40;
    #if defined ZONE_REMOVE_LIMIT
    ppl = 1;
    #endif
    return ppl;
}

Zone_GetCash(zoneid)
{
    new Float:area = Zone_Area[zoneid]/10000;
    // za 1km^2 - 1.000 co PayDay?
    if(zoneid == 0 || zoneid == 19 || zoneid == 47 || zoneid == 59) area = 2.5;
    return floatround(area*750);
}

Zone_ClearVariables(playerid)
{
    ZoneAttacker[playerid] = false;
    ZoneDefender[playerid] = false;
    for(new i=0;i<MAX_ZONES;i++) bInZone[playerid][i] = false;
}

//end