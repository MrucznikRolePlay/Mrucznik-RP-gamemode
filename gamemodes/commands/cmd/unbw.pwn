//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ unbw ]-------------------------------------------------//
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

YCMD:unbw(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /unbw [ID]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		if(PlayerInfo[id][pBW] > 0)
		{
			PlayerInfo[id][pBW] = 2;
		}
		else if(PlayerInfo[id][pInjury] > 0)
		{
			PlayerInfo[id][pInjury] = 0;
			PlayerInfo[id][pBW] = 2;
		}
		else
		{
			return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie jest ranny.");
		}

		SendClientMessage(playerid, COLOR_GRAD2, "Zdjêto BW.");
		SetPlayerChatBubble(id, " ", 0xFF0000FF, 100.0, 1000);
	}
    return 1;
}