//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zastrzyk ]-----------------------------------------------//
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

YCMD:zastrzyk(playerid, params[], help)
{
	new playa;
	if(sscanf(params, "k<fix>", playa))
	{
		sendTipMessage(playerid, "U¿yj /zastrzyk [ID gracza]");
		return 1;
	}
	
	if(!IsPlayerConnected(playa)) 
	{
		return sendErrorMessage(playerid, "Nie ma takiego gracza.");
	}

	if (PlayerInfo[playerid][pMember] == 4 && PlayerInfo[playerid][pRank] >= 4 || PlayerInfo[playerid][pLider] == 4)
	{
		new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		if(GetDistanceBetweenPlayers(playerid,playa) < 5 && Spectate[playa] == INVALID_PLAYER_ID)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					SetPlayerHealth(playa, 90);
					SendClientMessage(playa, COLOR_WHITE, "Lekarz da³ ci zastrzyk i wyleczy³ z choroby");
					format(string, sizeof(string),"* Lekarz %s wyci¹ga strzykawkê i wstrzykuje leki %s.", sendername, giveplayer);
					ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(string, sizeof(string), "%s czuje siê lepiej oraz pozby³ siê choroby.", giveplayer);
					ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					STDPlayer[playa] = 0;
					ZdejmijBW(playa);
				}
			}
		}
		else
		{
			format(string, sizeof(string),"Jesteœ zbyt daleko od gracza %s", giveplayer);
			sendErrorMessage(playerid, string);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz 4 rangi lub nie jesteœ medykiem!");
	}
	return 1;
}
