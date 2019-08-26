//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ fdaj ]-------------------------------------------------//
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

YCMD:fdaj(playerid, params[], help)
{
	new string[256];
    if(PlayerInfo[playerid][pAdmin] >=10 || IsAScripter(playerid))
	{
	    new giveplayerid, level;
		if( sscanf(params, "k<fix>d", giveplayerid, level))
		{
			sendTipMessage(playerid, "U¿yj /fdaj [id gracza] [id stylu]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    SetPlayerFightingStyle(playerid, level);
			format(string, sizeof(string), "Administrator %s ustawi³ Ci styl walki na %d", GetNick(playerid), level); 
			sendTipMessageEx(giveplayerid, COLOR_P@, string); 
			format(string, sizeof(string), "Ustawi³eœ styl walki dla %s na %d", GetNick(giveplayerid), level);
			sendTipMessageEx(playerid, COLOR_P@, string); 
		}
	}
	return 1;
}
