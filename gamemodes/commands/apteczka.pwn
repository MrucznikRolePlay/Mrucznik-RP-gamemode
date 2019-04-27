//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ apteczka ]-----------------------------------------------//
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

CMD:apteczka(playerid, params[])
{
	new playa, health;
	if(sscanf(params, "k<fix>d", playa, health))
	{
		sendTipMessage(playerid, "U¿yj /apteczka [ID gracza] [¯ycia]");
		return 1;
	}
	if (PlayerInfo[playerid][pMember] == 4 && PlayerInfo[playerid][pRank] >= 2 || PlayerInfo[playerid][pLider] == 4)
	{
		new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		if(playa == playerid)
		{
			sendErrorMessage(playerid, "Nie mo¿esz uzdrowiæ samego siebie!");
			return 1;
		}
		
		if(GetDistanceBetweenPlayers(playerid,playa) < 5 && Spectate[playa] == INVALID_PLAYER_ID)
		{
			if(health < 25 || health > 110)
			{
				sendTipMessage(playerid, "Nie mo¿esz daæ graczowi wiêcej HP ni¿ 110, ani nie mniej ni¿ 25 !");
				return 1;
			}
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					SetPlayerHealth(playa, health);
					SendClientMessage(playa, COLOR_WHITE, "Zostales uzdrowiony przez Lekarza");
					format(string, sizeof(string),"* Lekarz %s wyci¹ga apteczkê, banda¿uje rany oraz podaje leki %s.", sendername, giveplayer);
					ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(string, sizeof(string), "%s czuje siê lepiej dziêki interwencji lekarza.", giveplayer);
					ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					pobity[playa] = 0;
					PlayerInfo[playa][pBW] = 2;
				}
			}
		}
		else
		{
			format(string, sizeof(string),"Jesteœ zbyt daleko od gracza %s", giveplayer);
			SendClientMessage(playerid, COLOR_GRAD1, string);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz 2 rangi lub nie jesteœ medykiem!");
	}
	return 1;
}

