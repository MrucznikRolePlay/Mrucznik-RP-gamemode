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
command_setplocal_Impl(playerid, params[256])
{
    new giveplayerid, wartosc, string[128];
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "k<fix>d", giveplayerid, wartosc))
		{
			sendTipMessage(playerid, "U¿yj /setplocal [id] [wartosc]");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendTipMessage(playerid, "Nie ma takiego gracza"); 
			return 1;
		}
		if(!IsAScripter(playerid) || PlayerInfo[playerid][pAdmin] <= 200)
		{
			sendTipMessage(playerid, "Brak uprawnieñ"); 
			return 1;
		}
		format(string, sizeof(string), "PLocal gracza %s zosta³ zmieniony przez admina %s na %d", GetNick(giveplayerid), GetNickEx(playerid), wartosc);
		SendPunishMessage(string, giveplayerid);
		SetPLocal(giveplayerid, wartosc);
	}
	return 1;
}

//end
