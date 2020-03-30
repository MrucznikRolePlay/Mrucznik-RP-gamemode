//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ bw ]-------------------------------------------------//
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

YCMD:bw(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] >= 100 || IsAScripter(playerid))
	{
		new giveplayerid, czas, string[144];
		if(sscanf(params, "k<fix>d", giveplayerid, czas))
		{
			sendTipMessage(playerid, "U¿yj /bw [ID/NICK GRACZA] [czas w sekundach]"); //
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		if(czas > BW_TIME_CRIMINAL)
		{
			format(string, sizeof(string), "Tip: Maksymalny czas BW to [%d] sekund", BW_TIME_CRIMINAL);
			return sendTipMessage(playerid, string);
		}
		NadajBW(giveplayerid, czas, false);
		format(string, sizeof(string), "Administrator %s nada³ Ci BW na %d sekund", GetNickEx(playerid), czas); 
		sendTipMessageEx(giveplayerid, COLOR_P@, string); 
		SendClientMessage(playerid, COLOR_GRAD2, "Nadano BW");
	}
    return 1;
}
