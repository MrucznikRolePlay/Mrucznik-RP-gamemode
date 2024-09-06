//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ zabierzlideraorg ]-------------------------------------------//
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

YCMD:zabierzlideraorg(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return 1;
    new id=-1;
	if( sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /zabierzlideraorg [ID/Nick]");
	if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(!IsPlayerOrgLeader(id)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma lidera rodziny!");
        new org = GetPlayerOrg(playerid);
        new str[128];
        format(str, 128, "Admin %s odebra³ Tobie kontrolê nad rodzin¹ %s", GetNickEx(playerid), OrgInfo[org][o_Name]);
        SendClientMessage(id, COLOR_LIGHTBLUE, str);
        format(str, 128, "Odebra³eœ kontrolê nad rodzin¹ %s graczowi %s", OrgInfo[org][o_Name], GetNick(id));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
        Log(adminLog, INFO, "Admin %s zabra³ graczowi %s lidera rodziny %s[%d]", GetPlayerLogName(playerid), GetPlayerLogName(id), OrgInfo[org][o_Name], org);
        
        RemovePlayerFromOrg(playerid);
    }
    return 1;
}
