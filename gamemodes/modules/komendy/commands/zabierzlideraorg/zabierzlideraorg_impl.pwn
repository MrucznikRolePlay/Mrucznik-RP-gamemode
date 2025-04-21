//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_zabierzlideraorg_Impl(playerid, params[256])
{
    if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return 1;
    new id=-1;
	if( sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U�yj /zabierzlideraorg [ID/Nick]");
	if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(!IsPlayerOrgLeader(id)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma lidera organizacji!");
        new org = GetPlayerOrg(playerid);
        new str[128];
        format(str, 128, "Admin %s odebra� Tobie kontrol� nad rodzin� %s", GetNickEx(playerid), OrgInfo[org][o_Name]);
        SendClientMessage(id, COLOR_LIGHTBLUE, str);
        format(str, 128, "Odebra�e� kontrol� nad rodzin� %s graczowi %s", OrgInfo[org][o_Name], GetNick(id));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
        Log(adminLog, INFO, "Admin %s zabra� graczowi %s lidera organizacji %s", GetPlayerLogName(playerid), GetPlayerLogName(id), GetOrgLogName(org));
        
        RemovePlayerFromOrg(playerid);
    }
    return 1;
}

//end
