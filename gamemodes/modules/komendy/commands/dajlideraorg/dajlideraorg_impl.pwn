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
command_dajlideraorg_Impl(playerid, params[256])
{
    if(!Uprawnienia(playerid, ACCESS_MAKELEADER)) return 1;
    new id=-1, family;
	if( sscanf(params, "dK<fix>(-1)", family, id)) return sendTipMessage(playerid, "U�yj /dajlideraorg [ORG ID] [ID/Nick]");
    if(family < 0 || family > MAX_ORG-1) return 1;
    if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(GetPlayerFraction(id) != 0 || GetPlayerOrg(id) != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma frakcje lub rodzine!");
        InvitePlayerToOrg(id, family, MAIN_LEADER_RANK);
    }
    new str[128];
    if(id != -1)
    {
		if(IsActiveOrg(family))
		{
			format(str, sizeof(str), "Admin %s da� Tobie kontrol� nad rodzin� %s (%d) - /pr", GetNickEx(playerid), OrgInfo[family][o_Name], family);
			SendClientMessage(id, COLOR_LIGHTBLUE, str);
			format(str, sizeof(str), "Da�e� kontrol� nad rodzin� %s (%d) graczowi %s", OrgInfo[family][o_Name], family, GetNick(id));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
			
			//logi
            Log(adminLog, INFO, "Admin %s da� graczowi %s lidera organizacji %s", GetPlayerLogName(playerid), GetPlayerLogName(id), GetOrgLogName(family));
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Ta organizacja jest nieaktywna, musisz stworzy� organizacje /kuporg je�li chcesz doda� now�.");
		}
    }
    else
    {
        MruMySQL_ListaLiderow(playerid, family);
    }
    return 1;
}

//end
