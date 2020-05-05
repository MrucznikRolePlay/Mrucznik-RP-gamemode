//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ przeszukaj ]----------------------------------------------//
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

YCMD:przeszukaj(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /przeszukaj [playerid/CzêœæNicku]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
			    if (ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{
				    if(!IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(giveplayerid))
				    {
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz przeszukaæ samego siebie!"); return 1; }
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
					    new text1[60], text2[60], text3[60], text4[60], text5[60];
					    if(PlayerInfo[giveplayerid][pDrugs] > 0) { format(text1, sizeof(text1), "| Narkotyki (%d)", PlayerInfo[giveplayerid][pDrugs]); } else { text1 = "| Pusta kieszeñ"; }
					    if(PlayerInfo[giveplayerid][pMats] > 0) { format(text2, sizeof(text2), "| Materia³y (%d)", PlayerInfo[giveplayerid][pMats]); } else { text2 = "| Pusta kieszeñ"; }
					    if(PlayerHasFishes(giveplayerid)) { text3 = "| Ryby"; } else { text3 = "| Pusta kieszeñ"; }
					    if(PlayerInfo[giveplayerid][pPhoneBook] > 0) { text4 = "| Ksi¹¿ka tel"; } else { text4 = "| Pusta kieszeñ"; }
					    if(PlayerInfo[giveplayerid][pCDPlayer] > 0) { text5 = "| MP3"; } else { text5 = "| Pusta kieszeñ"; }
					    format(string, sizeof(string), "|__________ Wynik przeszukania %s __________|", giveplayer);
				        SendClientMessage(playerid, COLOR_WHITE, string);
				        format(string, sizeof(string), "%s.", text1);
						SendClientMessage(playerid, COLOR_GREY, string);
						format(string, sizeof(string), "%s.", text2);
						SendClientMessage(playerid, COLOR_GREY, string);
						format(string, sizeof(string), "%s.", text3);
						SendClientMessage(playerid, COLOR_GREY, string);
						format(string, sizeof(string), "%s.", text4);
						SendClientMessage(playerid, COLOR_GREY, string);
						format(string, sizeof(string), "%s.", text5);
						SendClientMessage(playerid, COLOR_GREY, string);
						format(string, sizeof(string), "* %s przeszuka³ %s w poszukiwaniu nielegalnych rzeczy.", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz byæ w pojeŸdzie !");
				    	return 1;
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
				    return 1;
				}
			}
		}
        else
        {
            sendErrorMessage(playerid, "Nie ma takiego gracza !");
            return 1;
        }
	}
    return 1;
}
