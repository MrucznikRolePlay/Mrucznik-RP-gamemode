//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ selldom ]------------------------------------------------//
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

YCMD:selldom(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pDom] != 0)
	        {
	            new dom = PlayerInfo[playerid][pDom];
	            if(Dom[dom][hBlokada] == 1)
	        	{
                    sendErrorMessage(playerid, "Ten dom ma blokadê sprzedawania");
                    return 1;
	        	}
	            if(IsPlayerInRangeOfPoint(playerid, 10.0, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z]))
	            {
	                new giveplayerid, money;
					if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
					{
						sendTipMessage(playerid, "U¿yj /sprzedajdom [id/nick] [cena]");
						return 1;
					}
					money = FunkcjaK(string);
					if(!IsPlayerConnected(giveplayerid))
					{
						sendErrorMessage(playerid, "Nie ma takiego gracza");
						return 1;
					}

					if(money <= 9999)
					{
					    sendTipMessage(playerid, "Cena musi byæ powy¿ej 10 000$");
					    return 1;
					}
					if(money > 2000000000)
					{
					    sendTipMessage(playerid, "Cena musi byæ poni¿ej 2 000 000 000$ (2MLD, 2kkk)");
					    return 1;
					}
					if(PlayerInfo[giveplayerid][pDom] == 0)
					{
					    if(PlayerInfo[giveplayerid][pWynajem] == 0)
					    {
					        if(kaska[giveplayerid] >= money)
					        {
					            if(IsPlayerInRangeOfPoint(giveplayerid, 10.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
	            				{
	            				    if(PlayerInfo[giveplayerid][pLevel] < 3)
	            				    {
	            				        SendClientMessage(playerid, COLOR_GRAD2, "Gracz któremu sprzedajesz dom musi mieæ co najmniej 3 lvl!");
					    				return 1;
	            				    }
						            GetPlayerName(playerid, sendername, sizeof(sendername));
						            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
									format(string, sizeof(string), "Gracz %s proponuje ci sprzeda¿ swojego domu za %d$, aby go kupiæ wpisz /akceptuj dom.", sendername, money);
									SendClientMessage(giveplayerid, COLOR_WHITE, "Aby zobaczyæ informacje o proponowanym domu wpisz /dominfo przy domu.");
									SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "Zaoferowa³eœ graczowi %s sprzeda¿ swojego domu za %d$", giveplayer, money);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
									DomOffer[giveplayerid] = playerid;
									DomCena[giveplayerid] = money;
								}
								else
								{
								    sendTipMessage(playerid,"Gracz któremu chcesz sprzedaæ dom musi staæ przy twoim domu.");
								}
					        }
					        else
					        {
					            sendTipMessage(playerid,"Tego gracza nie staæ na kupno za t¹ cenê.");
					        }
					    }
					    else
					    {
					        sendTipMessage(playerid,"Ten gracz wynajmuje dom. Aby daæ mu swój dom poproœ go aby wpisa³ /unrent.");
					    }
					}
					else
					{
					    sendTipMessage(playerid,"Ten gracz posiada w³asny dom. Nie mo¿esz mu sprzedaæ domu.");
					}
	            }
	            else
	            {
	                sendTipMessage(playerid,"Musisz staæ przy swoim domu.");
	            }
	        }
	        else
	        {
	            sendTipMessage(playerid,"Nie posiadasz domu.");
	        }
	    }
	}
	return 1;
}
