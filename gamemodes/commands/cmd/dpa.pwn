//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ dpa ]--------------------------------------------------//
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

YCMD:dpa(playerid, params[], help)
{
	new para1;
	if(sscanf(params, "k<fix>", para1))
	{
		sendTipMessage(playerid, "U¿yj /dpa [playerid/CzêœæNicku]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		if(IsPlayerConnected(para1))
		{
			if(para1 != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[para1][pNewAP] >= 1 && PlayerInfo[para1][pNewAP] <= 3)
				{
					new string[128], giveplayer[MAX_PLAYER_NAME];
					PlayerInfo[para1][pNewAP] -= 1;
					new level = PlayerInfo[para1][pNewAP];
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "   Zosta³eœ zdegradowany przez admina %s, masz teraz %d rangê pó³admina", GetNickEx(playerid), level);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zdegradowa³eœ gracza %s, ma teraz %d rangê pó³admina.", giveplayer, level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie jest pó³adminem!");
				}
			}
		}
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
