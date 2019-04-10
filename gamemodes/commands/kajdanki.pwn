//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kajdanki ]-----------------------------------------------//
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

CMD:kajdanki(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsACop(playerid) || (IsABOR(playerid) && PlayerInfo[playerid][pRank] > 0))
		{
			if(uzytekajdanki[playerid] != 1)
			{
				new giveplayerid;
				if(sscanf(params, "k<fix>", giveplayerid))
				{
					sendTipMessage(playerid, "U¿yj /kajdanki [id gracza]");
					return 1;
				}
                if(IsACop(playerid))
                {
                    if(OnDuty[playerid] == 0)
					{
						sendErrorMessage(playerid,"Nie jesteœ na s³u¿bie!");
						return 1;
					}
                }
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
						{
							if(GetPlayerState(playerid) == 1 && GetPlayerState(giveplayerid) == 1)
							{
								if(zakuty[giveplayerid] == 0)
								{
									if(uzytekajdanki[giveplayerid] == 0)
									{
										if(GUIExit[playerid] == 0 && GUIExit[giveplayerid] == 0)
										{
											new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
											if(IsACop(giveplayerid) && OnDuty[giveplayerid] == 1)
											{
												sendErrorMessage(playerid, "Nie mo¿esz skuæ policjanta na s³u¿bie!");
												return 1;
											}
											if(PoziomPoszukiwania[giveplayerid] == 0)
											{
												sendTipMessage(playerid,"Chyba nie chcesz aresztowaæ niewinnego cz³owieka?");
												return 1;
											}
											GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
											GetPlayerName(playerid, sendername, sizeof(sendername));
											format(string, sizeof(string), "* %s wyci¹ga kajdanki i próbuje je za³o¿yæ %s.", sendername ,giveplayer);
											ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
											ShowPlayerDialogEx(giveplayerid, 98, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za³o¿yæ ci kajdanki, jeœli osacza ciê niedu¿a liczba policjantów mo¿esz spróbowaæ siê wyrwaæ\nJednak pamiêtaj jeœli siê wyrwiesz i jesteœ uzbrojony policjant ma prawo ciê zabiæ. \nMo¿esz tak¿e dobrowolnie poddaæ siê policjantom.", "Poddaj siê", "Wyrwij siê");
											PDkuje[giveplayerid] = playerid;
											uzytekajdanki[giveplayerid] = 1;
											SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
										}
									}
									else
									{
										sendErrorMessage(playerid, "Odczekaj 30 sekund zanim znowu za³o¿ysz kajdanki temu graczowi!");
									}
								}
								else
								{
									sendErrorMessage(playerid, "Ten gracz ma ju¿ za³o¿one kajdanki!");
								}
							}
							else
							{
								sendErrorMessage(playerid, "Nikt z was nie mo¿e byæ siê w wozie!");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Jesteœ za daleko od gracza !");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie ma takiego gracza !");
					}
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ju¿ u¿ywasz swoje kajdanki !");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ policjantem lub GSA z rang¹ 2");
		}
	}
	return 1;
}

