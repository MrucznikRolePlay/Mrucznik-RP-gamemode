//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ dajlideraorg ]---------------------------------------------//
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

YCMD:dajlideraorg(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_MAKELEADER)) return 1;
    new id=-1, family;
	if( sscanf(params, "dK<fix>(-1)", family, id)) return sendTipMessage(playerid, "U¿yj /dajlideraorg [ORG ID] [ID/Nick]");
    if(family < 0 || family > MAX_ORG-1) return 1;
    if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(GetPlayerFraction(id) != 0 || GetPlayerOrg(id) != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma frakcje lub rodzine!");
        orgInvitePlayer(id, family);
        gPlayerOrgLeader[id] = true;
    }
    new str[128];
    if(id != -1)
    {
		new orgUID = orgID(family);
		if(orgUID != 0xFFFF)
		{
			format(str, sizeof(str), "Admin %s da³ Tobie kontrolê nad rodzin¹ %s (%d) - /pr", GetNickEx(playerid), OrgInfo[orgUID][o_Name], family);
			SendClientMessage(id, COLOR_LIGHTBLUE, str);
			format(str, sizeof(str), "Da³eœ kontrolê nad rodzin¹ %s (%d) graczowi %s", OrgInfo[orgUID][o_Name], family, GetNick(id));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
			
			//logi
            Log(adminLog, INFO, "Admin %s da³ graczowi %s lidera rodziny %d", GetPlayerLogName(playerid), GetPlayerLogName(id), family);
			
			PlayerInfo[id][pTeam] = 5;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "ERROR! Wyst¹pi³ b³¹d, zg³oœ okolicznoœci do Mrucznika na slacku.");
		}
    }
    else
    {
        MruMySQL_ListaLiderow(playerid, family);
    }
    return 1;
}
