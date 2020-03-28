//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wezportfel ]----------------------------------------------//
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

YCMD:wezportfel(playerid, params[], help)
{
	if(IsAPrzestepca(playerid))
	{
		if(PlayerInfo[playerid][Rank] < 3)
		{
			sendTipMessage(playerid, "Potrzebujesz rangi 3 lub wy¿szej, ¿eby móc zabieraæ pieni¹dze!");
			return 1;
		}
		new giveplayerid;
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /wezportfel [id/nick]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
		{
			if(PlayerTied[giveplayerid] == 0)
			{
				sendTipMessage(playerid, "Ta osoba nie jest zwi¹zana!");
				return 1;
			}
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				new car = GetPlayerVehicleID(playerid);
				new pieniadze;
				if(giveplayerid == playerid) { sendErrorMessage(playerid, "Nie mo¿esz zwi¹zaæ sam siebie!"); return 1; }
				if(IsPlayerInAnyVehicle(playerid) && (GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3) && IsPlayerInVehicle(giveplayerid, car))
				{
					if(okradziony[giveplayerid] == 0)
					{
						if(kaska[giveplayerid] >= 1)
						{
							if(PlayerInfo[giveplayerid][OnlineHours] >= 2)
							{
								new string[128];
								pieniadze = kaska[giveplayerid] / 4;
								if(pieniadze > 1000000)
								{
									pieniadze = 1000000;
								}
								
                                SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("%s zabra³ Ci portfel z $%d w œrodku", GetNick(playerid), pieniadze));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Zabra³eœ portfel %s, w œrodku jest $%d", GetNick(giveplayerid), pieniadze));

								format(string, sizeof(string), "* %s zabiera portfel %s razem z %d$", GetNick(playerid), GetNick(giveplayerid), pieniadze);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								Log(payLog, INFO, "%s zabra³ portfel %s razem z %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), pieniadze);
								DajKase(playerid, pieniadze);
								ZabierzKase(giveplayerid, pieniadze);
								okradziony[giveplayerid] = 1;
								PoziomPoszukiwania[playerid] += 3;
								SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Porwanie + kradzie¿");
							}
							else
							{
								sendErrorMessage(playerid, "Ten gracz za ma³o gra !");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Ten gracz nie ma nic przy sobie !");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Ta osoba nie ma portfela, ju¿ jej ktoœ zabra³ !");
					}

				}
				else
				{
					sendErrorMessage(playerid, "Jeden z was nie jest w samochodzie !");
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz nie jest w pobli¿u Ciebie !");
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza !");
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ cz³onkiem / liderem rodziny !");
	}
	return 1;
}
