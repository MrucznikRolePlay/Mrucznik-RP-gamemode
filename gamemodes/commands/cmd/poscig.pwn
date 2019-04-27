//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ poscig ]------------------------------------------------//
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

YCMD:poscig(playerid, params[], help)
{
	if(IsACop(playerid))
	{
		if(OnDuty[playerid] == 1)
		{
			new giveplayerid;
			if(sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /poscig [id/nick]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
			{
				if(PoziomPoszukiwania[giveplayerid] >= 1)
				{
					if(ProxDetectorS(20.0, playerid, giveplayerid))
					{
						if(poscig[giveplayerid] == 1)
						{
							sendErrorMessage(playerid, "Ten gracz ma ju¿ poœcig!");
							return 1;
						}
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"Rozpocza³eœ poœcig! Trwa on 7 minut.");
						SendClientMessage(giveplayerid,COLOR_PANICRED,"|_________________Tryb Poœcigu_________________|");
						SendClientMessage(giveplayerid,COLOR_WHITE,"S³u¿by porz¹dkowe ruszy³y za tob¹ w poœcig! W takim wypadku najlepiej siê poddaæ!");
						SendClientMessage(giveplayerid,COLOR_WHITE,"W trybie poœcigu nie mozesz wyjœæ z gry, zgin¹æ oraz byæ AFK.");
						SendClientMessage(giveplayerid,COLOR_WHITE,"Z³amanie tych zasad skutkuje kar¹ nadawan¹ automatycznie.");
						SendClientMessage(giveplayerid,COLOR_PANICRED,"|______________________________________________|");
						poscig[giveplayerid] = 1;
						SetTimerEx("PoscigTimer",7*60000,0,"d",giveplayerid);
					}
					else
					{
						sendErrorMessage(playerid, "Ten gracz nie jest w pobli¿u Ciebie !");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie ma WL !");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza !");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie !");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z PD !");
	}
	return 1;
}

