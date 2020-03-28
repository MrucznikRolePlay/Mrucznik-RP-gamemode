//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zdejmijbpk ]----------------------------------------------//
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

YCMD:zdejmijbpk(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHalfAdmin] >= 1 || IsAScripter(playerid))
	{
		new giveplayerid; 
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /zdejmijbpk [ID GRACZA]"); 
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
		KillTimer(komunikatTime[giveplayerid]);
		format(string, sizeof(string), "Administrator %s zdj¹³ Ci blokadê pisania na komunikatach frakcyjnych", GetNickEx(playerid));
		sendTipMessageEx(playerid, COLOR_P@, string);
		format(string, sizeof(string), "Administrator %s zdj¹³ blokadê dla %s. Mo¿e on teraz swobodnie pisaæ komunikat frakcyjny", GetNickEx(playerid), GetNick(giveplayerid));
		SendAdminMessage(COLOR_RED, string);
		
	}
	else
	{
		sendErrorMessage(playerid, "Brak uprawnieñ"); 
	}
	return 1;
}
