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
command_unbp_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
	{
		new giveplayerid; 
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U�yj /unbp [ID GRACZA]"); 
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza"); 
			return 1;
		}
		new string[128];
		format(string, sizeof(string), "null");
		SetPVarString(giveplayerid, "trescOgloszenia", string);			
		PlayerInfo[giveplayerid][pBlokadaPisaniaFrakcjaCzas] = 0;
		PlayerInfo[giveplayerid][pBP] = 0;
		KillTimer(komunikatTime[giveplayerid]);
		format(string, sizeof(string), "Administrator %s zdj�� Ci blokad� pisania.", GetNickEx(playerid));
		sendTipMessageEx(giveplayerid, COLOR_P@, string);
		format(string, sizeof(string), "Administrator %s zdj�� blokad� dla %s.", GetNickEx(playerid), GetNick(giveplayerid));
		SendAdminMessage(COLOR_RED, string);
		
	}
	else
	{
		sendErrorMessage(playerid, "Brak uprawnie�"); 
	}
	return 1;
}

//end
