//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ worek ]-------------------------------------------------//
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
	Creative 27 luty 2020
*/


// Notatki skryptera:
/*
	
*/

YCMD:worek(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsAPrzestepca(playerid))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /worek [playerid/CzêœæNicku]");
				return 1;
			}

			if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz za³o¿yæ/œci¹gn¹æ sobie samemu worka!"); return 1; }

		    if(IsPlayerConnected(giveplayerid))
			{
				if(!ProxDetectorS(8.0, playerid, giveplayerid))
				{
					sendTipMessageEx(playerid, COLOR_GREY, "U¿yj /worek [playerid/CzêœæNicku] bêd¹c w pobli¿u ofiary !");
					return 1;
				}

				if(Worek_MamWorek[giveplayerid])
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* %s œci¹gn¹³ Ci worek z g³owy, odzyska³eœ orientacjê w terenie.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Œci¹gn¹³eœ %s worek z g³owy.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s œci¹ga %s worek z g³owy.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					Worek_MamWorek[giveplayerid] = 0;
					Worek_KomuZalozylem[Worek_KtoZalozyl[giveplayerid]] = INVALID_PLAYER_ID;
					Worek_Uzyty[Worek_KtoZalozyl[giveplayerid]] = 0;
					Worek_KtoZalozyl[giveplayerid] = INVALID_PLAYER_ID;
					UnHave_Worek(giveplayerid);
				}
				else
				{	
					if(Worek_Uzyty[playerid])
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Masz tylko jeden worek, zdejmij go poprzedniej osobie !");
						return 1;
					}
					else
					{
						if(PlayerInfo[giveplayerid][pInjury] == 0 && PlayerTied[giveplayerid] == 0 && pobity[giveplayerid] == 0)
						{
							sendErrorMessage(playerid, "Mo¿esz za³o¿yæ worek na g³owê tylko graczowi, który jest pobity/zwi¹zany lub ranny.");
							return 1;
						}

						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s za³o¿y³ Ci worek na g³owê, straci³eœ orientacjê w terenie.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Za³o¿y³eœ %s worek na g³owê.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s zak³ada %s worek na g³owê.", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Worek_MamWorek[giveplayerid] = 1;
						Worek_KomuZalozylem[playerid] = giveplayerid;
						Worek_Uzyty[playerid] = 1;
						Worek_KtoZalozyl[giveplayerid] = playerid;

						Have_Worek(giveplayerid);

						//SetTimerEx("timer_MaWorek",2000,0,"d",giveplayerid);
						//todo timer:
						//osoba musi byc ranna/pobita, jezeli zakladajacy worek oddali sie na ~50 metrow lub wyjdzie z gry lub pojdzie afk dluzej niz 2 minuty worek zostanie zdjety
					}
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
			noAccessMessage(playerid);
		}
	}
	return 1;
}
