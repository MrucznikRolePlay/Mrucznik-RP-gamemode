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

YCMD:checkbw(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /checkbw [ID]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		if(PlayerInfo[id][pBW] == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma BW.");
		new string[144]; 
		format(string, sizeof(string), "Graczowi %s zosta³o do koñca BW: %d", GetNick(id), PlayerInfo[id][pBW]); 
		SendClientMessage(playerid, COLOR_GRAD2, string);
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz uprawnieñ.");
	}
    return 1;
}
