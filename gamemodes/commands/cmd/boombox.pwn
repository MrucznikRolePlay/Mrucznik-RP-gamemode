//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ boombox ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:boombox(playerid, params[], help)
{
    new sub[16], var[128];
    sscanf(params, "S()[16]S()[128]", sub, var);

    new frac = GetPlayerFraction(playerid);
    if(GetPlayerOrg(playerid) == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Boombox tylko dla gangów!");
    if(frac == 0 && !IsAGang(playerid) && IsAClubBusinessOwner(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Boombox tylko dla organizacji typu gang/biznes/klub!");
    new owner;

    if(frac == 0) owner = 100+GetPlayerOrg(playerid);
    else owner = frac;

    new id=-1;
    for(new i=0;i<MAX_BOOMBOX;i++)
    {
        if(BoomBoxData[i][BBD_Gang] == owner)
        {
            id=i;
            break;
        }
    }
    if(id != -1)
    {
        if(isnull(sub))
        {
            if(BoomBoxData[id][BBD_Carried]-1 == playerid)
            {
                if(GetPlayerVirtualWorld(playerid) == 0)
                {
                    if(GetPVarInt(playerid, "zoneid") == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
                    else if(ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
                }
                BBD_Putdown(playerid, id);
            }
            else
            {
                if(!IsPlayerInRangeOfPoint(playerid, 1.4, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z])) return sendTipMessageEx(playerid, COLOR_GRAD2, "Musisz byæ obok boomboxa.");
                if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) return sendTipMessageEx(playerid, COLOR_GRAD2, "Przykucnij do radia.");
                BBD_Pickup(playerid, id);
            }
        }
        else
        {
            if(PlayerInfo[playerid][pAdmin] > 0)
            {
                if(strcmp(sub, "usun", true) == 0)
                {
                    new bbxid = strval(var);
                    for(new i=0;i<MAX_BOOMBOX;i++)
                    {
                        if(BoomBoxData[i][BBD_Gang] == bbxid)
                        {
                            if(BoomBoxData[i][BBD_Obj] != 0) DestroyDynamicObject(BoomBoxData[i][BBD_Obj]);
                            BoomBoxData[i][BBD_x] = 0;
                            BoomBoxData[i][BBD_y] = 0;
                            BoomBoxData[i][BBD_z] = 0;
                            BoomBoxData[i][BBD_Standby] = false;
                            BoomBoxData[i][BBD_Carried] = -1;
                            BoomBoxData[i][BBD_ID] = 0;
                            BoomBoxData[i][BBD_Gang] = 0;
                            SendClientMessage(playerid, -1, "DONE.");
                            break;
                        }
                    }
                    return 1;
                }
            }

            if(strcmp(sub, "znajdz", true) == 0 || strcmp(sub, "znajdŸ", true) == 0)
            {
                SetPlayerCheckpoint(playerid, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z], 2.0);
                SendClientMessage(playerid, -1, "Je¿eli nie mo¿esz znaleŸæ boombox'a poproœ administratora o usuniêcie go.");
                return 1;
            }

            if(!IsPlayerInRangeOfPoint(playerid, 1.4, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z])) return sendTipMessageEx(playerid, COLOR_GRAD2, "Musisz byæ obok boomboxa.");
            if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) return sendTipMessageEx(playerid, COLOR_GRAD2, "Przykucnij do radia.");
            
            if(GetPlayerVirtualWorld(playerid) == 0)
            {
                if(GetPVarInt(playerid, "zoneid") == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
                else if(ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
            }
            if(strcmp(sub, "off", true) == 0)
            {
                BoomBoxData[id][BBD_Standby] = false;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s wy³¹cza boomboxa.", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
            else if(strcmp(sub, "on", true) == 0)
            {
                if(strlen(BoomBoxData[id][BBD_URL]) < 10) return 1;
                BoomBoxData[id][BBD_Standby] = true;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s w³¹cza boomboxa.", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
            else if(strcmp(sub, "url", true) == 0)
            {
                format(BoomBoxData[id][BBD_URL], 128, "%s", var);
                BoomBoxData[id][BBD_Standby] = true;
                BoomBoxData[id][BBD_Refresh] = true;
                BBD_Turn(id);
                format(var, sizeof(var), "** %s zmienia nutê w boomboxie", GetNick(playerid));
	            ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
        }
    }
    else
    {
        if(GetPlayerVirtualWorld(playerid) == 0)
        {
            if(GetPVarInt(playerid, "zoneid") == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
            else if(ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Komenda dostêpna tylko na strefie gangu.");
        }

        id = BBD_GetID();
        if(id == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Osi¹gniêto limit boomboxów (15).");
        BoomBoxData[id][BBD_ID] = owner+1;
        BoomBoxData[id][BBD_Gang] = owner;
        BBD_Pickup(playerid, id);
    }
    return 1;
}
