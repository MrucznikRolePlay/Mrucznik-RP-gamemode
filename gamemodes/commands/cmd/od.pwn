//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ od ]--------------------------------------------------//
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

YCMD:od(playerid, params[], help)
{
	new string[64];

	if(Mobile[playerid] == INVALID_PLAYER_ID || RingTone[playerid] == 0)
	{
		sendErrorMessage(playerid, "Nikt do Ciebie nie dzwoni.");
		return 1;
	}
	
	if(Callin[playerid] != CALL_NONE)
	{
		sendErrorMessage(playerid, "Ju¿ prowadzisz rozmowê.");
		return 1;
	}
	
	new callerid = Mobile[playerid];
	RingTone[playerid] = 0;
	Callin[playerid] = CALL_PLAYER;
	Callin[callerid] = CALL_PLAYER;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	
	sendTipMessageEx(callerid, COLOR_GRAD2, "Twój rozmówca odebra³ telefon.");
	sendTipMessageEx(playerid, COLOR_GRAD2, "Odebra³eœ telefon.");
	format(string, sizeof(string), "* %s odbiera telefon.", GetNick(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return 1;
}
