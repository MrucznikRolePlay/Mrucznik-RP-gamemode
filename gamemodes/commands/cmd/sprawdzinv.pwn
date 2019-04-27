//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ sprawdzinv ]----------------------------------------------//
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

YCMD:sprawdzinv(playerid, params[], help)
{
	new string[64];

    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
	{
	    new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /sprawdzinv [id gracza]");
			return 1;
		}

		new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "State %d .",GetPlayerState(giveplayerid));
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	return 1;
}
