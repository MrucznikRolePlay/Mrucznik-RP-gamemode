//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ sb ]--------------------------------------------------//
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

YCMD:sb(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /szukajbroni(/sb) [playerid/CzêœæNicku]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie!");
					return 1;
				}
				if (ProxDetectorS(8.0, playerid, giveplayerid) ||  PlayerInfo[playerid][pAdmin] > 0)
				{
				    if((!IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(giveplayerid)) || PlayerInfo[playerid][pAdmin] > 0)
				    {
					    if(giveplayerid == playerid && PlayerInfo[playerid][pAdmin] < 1)
						{
							sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz przeszukaæ samego siebie!");
							return 1;
						}
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new checker = 0;
						new BronieF[13][2];
						for(new i = 0; i < 13; i++) { GetPlayerWeaponData(giveplayerid, i, BronieF[i][0], BronieF[i][1]); }
					    format(string, sizeof(string), "|__________ Wynik przeszukania %s __________|", giveplayer);
						SendClientMessage(playerid, COLOR_P@, string);
					    if(BronieF[10][0] != 0)
					    {
					        format(string, sizeof(string), "Broñ bia³a: %s — %s", GunNames[BronieF[10][0]], (playerWeapons[giveplayerid][weaponLegal11] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
					    }
					    if(BronieF[1][0] != 0)
					    {
							format(string, sizeof(string), "Broñ bia³a: %s — %s", GunNames[BronieF[1][0]], (playerWeapons[giveplayerid][weaponLegal2] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[2][0] != 0)
					    {
							format(string, sizeof(string), "Pistolet: %s z %d nabojami — %s", GunNames[BronieF[2][0]], BronieF[2][1], (playerWeapons[giveplayerid][weaponLegal3] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[3][0] != 0)
					    {
							format(string, sizeof(string), "Strzelba: %s z %d nabojami — %s", GunNames[BronieF[3][0]], BronieF[3][1], (playerWeapons[giveplayerid][weaponLegal4] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[4][0] != 0)
					    {
							format(string, sizeof(string), "Pistolet maszynowy: %s z %d nabojami — %s", GunNames[BronieF[4][0]], BronieF[4][1], (playerWeapons[giveplayerid][weaponLegal5] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[5][0] != 0)
					    {
							format(string, sizeof(string), "Karabin: %s z %d nabojami — %s", GunNames[BronieF[5][0]], BronieF[5][1], (playerWeapons[giveplayerid][weaponLegal6] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[6][0] != 0)
					    {
							format(string, sizeof(string), "Snajperka: %s z %d nabojami — %s", GunNames[BronieF[6][0]], BronieF[6][1], (playerWeapons[giveplayerid][weaponLegal7] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[7][0] != 0)
					    {
							format(string, sizeof(string), "Broñ ciê¿ka: %s z %d nabojami — %s", GunNames[BronieF[7][0]], BronieF[7][1], (playerWeapons[giveplayerid][weaponLegal8] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[8][0] != 0)
					    {
							format(string, sizeof(string), "£adunek wybuchowy: %s z %d nabojami — %s", GunNames[BronieF[8][0]], BronieF[8][1], (playerWeapons[giveplayerid][weaponLegal9] == 1) ? ("LEGALNA") : ("NIEZNANE RÓD£O"));
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[9][0] != 0)
					    {
							format(string, sizeof(string), "Inne przedmioty: %s", GunNames[BronieF[9][0]]);
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[11][0] != 0)
					    {
							format(string, sizeof(string), "%s.", GunNames[BronieF[11][0]]);
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(BronieF[12][0] != 0)
					    {
							format(string, sizeof(string), "%s.", GunNames[BronieF[12][0]]);
							SendClientMessage(playerid, COLOR_P@, string);
							checker ++;
						}
						if(checker == 0)
						{
						    format(string, sizeof(string), "Bronie: %s", GunNames[BronieF[0][0]]);
							SendClientMessage(playerid, COLOR_P@, string);
						}
						if(PlayerInfo[playerid][pAdmin] < 1)
						{
							format(string, sizeof(string), "* %s przeszuka³ %s w poszukiwaniu broni.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Nikt z was nie mo¿e byæ w pojeŸdzie!");
				    	return 1;
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie!");
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
