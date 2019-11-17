//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ federalne ]-----------------------------------------------//
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

YCMD:federalne(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	 	if(!IsAFBI(playerid))
	 	{
	 		sendErrorMessage(playerid, "Nie jesteœ agentem FBI!");
		    return 1;
		}
	    if(OnDuty[playerid] != 1 )
		{
		    sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
		    return 1;
		}
		new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj (/fed)eralne [playerid/CzêœæNicku] [popelnione przestepstwo]");
			return 1;
		}

		if (IsAFBI(playerid))
		{
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (!(IsACop(giveplayerid) && OnDuty[giveplayerid] == 1))
					{
						if(spamwl[giveplayerid] == 0)
						{
						    if(PoziomPoszukiwania[giveplayerid] <= 6)
						    {
								GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								PoziomPoszukiwania[giveplayerid] = 6;
								spamwl[giveplayerid] = 1;
								SetTimerEx("spamujewl",60000,0,"d",giveplayerid);
								SetPlayerCriminal(giveplayerid,playerid, result);
								SendClientMessage(giveplayerid, COLOR_LFBI, "   Pope³ni³eœ przestêpstwo federalne, twoj¹ sprawê przejê³o FBI !");
								SendClientMessage(playerid, COLOR_LFBI, "   Oskar¿y³eœ gracza o przestêpstwo federalne. Ma on teraz 6 Poziom Poszukiwania !");
								if(strfind(result, "ucieczka", true) != -1)
								{
									if(ProxDetectorS(80.0, playerid, giveplayerid))
									{
										if(poscig[giveplayerid] != 1)
										{
											SendClientMessage(playerid,COLOR_LIGHTBLUE,"Rozpocz¹³eœ poœcig! Trwa on 7 minut.");
											SendClientMessage(giveplayerid,COLOR_PANICRED,"|_________________Tryb Poœcigu_________________|");
											SendClientMessage(giveplayerid,COLOR_WHITE,"S³u¿by porz¹dkowe ruszy³y za tob¹ w poœcig! W takim wypadku najlepiej siê poddaæ!");
											SendClientMessage(giveplayerid,COLOR_WHITE,"W trybie poœcigu nie mozesz wyjœæ z gry, zgin¹æ oraz byæ AFK.");
											SendClientMessage(giveplayerid,COLOR_WHITE,"Z³amanie tych zasad skutkuje kar¹ nadawan¹ automatycznie.");
											SendClientMessage(giveplayerid,COLOR_PANICRED,"|______________________________________________|");
											poscig[giveplayerid] = 1;
											SetTimerEx("PoscigTimer",7*60000,0,"d",giveplayerid);
										}
									}
									else
									{
										sendErrorMessage(playerid, "Gracz jest za daleko by nadaæ mu tryb poœcigu.");
										return 1;
									}
								}
								return 1;
							}
							else
							{
							    sendErrorMessage(playerid, "Ten gracz jest ju¿ œcigany za przestêpstwo federalne");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Da³eœ ju¿ poziom poszukiwania, poczekaj 1 minute (zapobiega spamowaniu WL)");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie mo¿esz dawaæ Wanted Level policjantom na s³u¿bie!");
					}
				}
			}
			else
 			{
				format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
				sendErrorMessage(playerid, string);
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ z FBI!");
		}
	}
	return 1;
}
