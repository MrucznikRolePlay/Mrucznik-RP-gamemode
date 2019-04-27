//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ pl ]--------------------------------------------------//
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

YCMD:pl(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /pl(pokazlicencje) [playerid/CzêœæNicku]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
			    if (ProxDetectorS(8.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{
				    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz pokazaæ licencji samemu sobie, u¿yj /licencje!"); return 1; }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
				    new text1[20];
			        new text2[20];
			        new text3[20];
			        new text4[20];
			        new text5[20];
					if(PlayerInfo[playerid][pCarLic] == 1) { text1 = "Tak"; } else { text1 = "Brak"; }
                    if(PlayerInfo[playerid][pFlyLic]) { text4 = "Tak"; } else { text4 = "Brak"; }
					if(PlayerInfo[playerid][pBoatLic]) { text2 = "Tak"; } else { text2 = "Brak"; }
			        if(PlayerInfo[playerid][pFishLic]) { text3 = "Tak"; } else { text3 = "Brak"; }
			        if(PlayerInfo[playerid][pGunLic]) { text5 = "Tak"; } else { text5 = "Brak"; }
			        format(string, sizeof(string), "|__________ Licenses of %s __________|", sendername);
			        SendClientMessage(giveplayerid, COLOR_WHITE, string);
			        format(string, sizeof(string), "** Prawo jazdy: %s.", text1);
					SendClientMessage(giveplayerid, COLOR_GREY, string);
					format(string, sizeof(string), "** Licencja na latanie: %s.", text4);
					SendClientMessage(giveplayerid, COLOR_GREY, string);
					format(string, sizeof(string), "** Licencja p³ywanie: %s.", text2);
					SendClientMessage(giveplayerid, COLOR_GREY, string);
					format(string, sizeof(string), "** Karta wêdkarska: %s.", text3);
					SendClientMessage(giveplayerid, COLOR_GREY, string);
					format(string, sizeof(string), "** Licencja broñ: %s.", text5);
					SendClientMessage(giveplayerid, COLOR_GREY, string);
					format(string, sizeof(string), "* %s pokaza³ tobie licencje.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Pokaza³eœ licencje %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
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
