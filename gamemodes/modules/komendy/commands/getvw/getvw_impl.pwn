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
command_getvw_Impl(playerid, params[256])
{
    new gracz, string[64];
	if( sscanf(params, "k<fix>", gracz))
	{
		sendTipMessage(playerid, "U�yj /getvw [nick/id]");
		return 1;
	}

	if(!IsPlayerConnected(gracz))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}

	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
	{
		format(string, sizeof(string), "VirtualWorld gracza %s to %d.", GetNick(gracz), GetPlayerVirtualWorld(gracz));
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

//end
