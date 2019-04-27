//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wyscig ]------------------------------------------------//
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

YCMD:wyscig(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	if(IsANoA(playerid))
	{
		if(PlayerInfo[playerid][pRank] >= 2)
		{
			if(owyscig[playerid] != 666)
			{
				new playa;
				if( sscanf(params, "k<fix>", playa))
				{
					sendTipMessage(playerid, "U¿yj /wyscig [Nick/ID]");
					return 1;
				}


				//
				if(ProxDetectorS(10.0, playerid, playa))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "%s przydzieli³ ci udzia³ w wyœcigu \"%s\".", sendername, Wyscig[owyscig[playerid]][wNazwa]);
					SendClientMessage(playa, 0xFFC0CB, string);
					format(string, sizeof(string), "Przydzieli³eœ %s udzia³ w wyœcigu. Aby rozpocz¹æ wyœcig, poproœ zawodników o ustawienie siê na mecie i wpisz /wyscig-start.", giveplayer);
					SendClientMessage(playerid, 0xFFC0CB, string);
					ScigaSie[playa] = owyscig[playerid];
					SetPlayerRaceCheckpoint(playa,0,wCheckpoint[owyscig[playerid]][0][0], wCheckpoint[owyscig[playerid]][0][1], wCheckpoint[owyscig[playerid]][0][2],wCheckpoint[owyscig[playerid]][1][0], wCheckpoint[owyscig[playerid]][1][1], wCheckpoint[owyscig[playerid]][1][2], 10);
				}
				else
				{
					sendErrorMessage(playerid, "Jesteœ za daleko od gracza");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie organizuj wyœcigu! Aby to zbiæ, u¿yj panelu wyœcigów (/wyscigi)" );
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnieñ (wymagana 2 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z NoA");
	}
	return 1;
}
