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

YCMD:apteczka(playerid, params[], help)
{
	if((PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4) && PlayerInfo[playerid][pBW] == 0)
	{
		if(PlayerInfo[playerid][pBW] != 0) return sendErrorMessage(playerid, "Jesteœ nieprzytomny!");
		new playa, health;
		if(sscanf(params, "k<fix>d", playa, health))
		{
			sendTipMessage(playerid, "U¿yj /apteczka [ID gracza] [¯ycia]");
			return 1;
		}
		if(!IsPlayerConnected(playa)) 
		{
			return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		}

		new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		
		if(GetDistanceBetweenPlayers(playerid,playa) < 5 && Spectate[playa] == INVALID_PLAYER_ID)
		{
			if(health < 25 || health > 110)
			{
				sendTipMessage(playerid, "Nie mo¿esz daæ graczowi wiêcej HP ni¿ 110, ani nie mniej ni¿ 25 !");
				return 1;
			}
			
			SetPlayerHealth(playa, health);
			SendClientMessage(playa, COLOR_WHITE, "Zostales uzdrowiony przez Lekarza");
			format(string, sizeof(string),"* Lekarz %s wyci¹ga apteczkê, banda¿uje rany oraz podaje leki %s.", sendername, giveplayer);
			ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(string, sizeof(string), "%s czuje siê lepiej dziêki interwencji lekarza.", giveplayer);
			ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			pobity[playa] = 0;
			ZdejmijBW(playa);
		}
		else
		{
			format(string, sizeof(string),"Jesteœ zbyt daleko od gracza %s", giveplayer);
			SendClientMessage(playerid, COLOR_GRAD1, string);
		}

	}
	else
	{
		new string[144], Float:health;
		if(PlayerInfo[playerid][pHealthPacks] < 1) return sendErrorMessage(playerid, "Nie posiadasz przy sobie apteczki, mo¿esz je kupiæ u Lekarzy!");
		if(PlayerInfo[playerid][pBW] > 0) return sendErrorMessage(playerid, "Nie mo¿esz siê opatrzyæ gdy jesteœ nieprzytomny!");
		if(PlayerInfo[playerid][pInjury] < 1) return sendErrorMessage(playerid, "Musisz byæ ranny by u¿yæ apteczki.");
		GetPlayerHealth(playerid, health);
		if(health >= HEALTH_PACK_HP)
		{
			sendTipMessage(playerid, "Nie jesteœ wystarczaj¹co ranny by u¿yæ apteczki.");
			return 1;
		}

		ZdejmijBW(playerid);
		SetPlayerHealth(playerid, HEALTH_PACK_HP);
		SendClientMessage(playerid, COLOR_WHITE, "Opatrzy³eœ swoje rany.");
		format(string, sizeof(string),"* %s wyci¹ga apteczkê, banda¿uje swoje rany oraz ³yka leki.", GetNick(playerid));
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		PlayerInfo[playerid][pHealthPacks]--;
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0999, 0, 0, 0, 0, 0, 0);
	}
	return 1;
}