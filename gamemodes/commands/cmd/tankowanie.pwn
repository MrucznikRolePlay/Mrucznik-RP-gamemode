//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ tankowanie ]----------------------------------------------//
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

YCMD:tankowanie(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][Job] == 7 || (PlayerInfo[playerid][pMember] == 10 && PlayerInfo[playerid][Rank] == 0) || IsANoA(playerid))
	    {
			new playa, money;
			if( sscanf(params, "k<fix>d", playa, money))
			{
				sendTipMessage(playerid, "U¿yj /tankowanie [playerid/CzêœæNicku] [cena]");
				return 1;
			}
			if(money < 600 || money > 2500) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od 600$ do 2500$!"); return 1; }
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
			        if(ProxDetectorS(8.0, playerid, playa) && IsPlayerInAnyVehicle(playa) && Spectate[playa] == INVALID_PLAYER_ID)
					{
					    if(SpamujeMechanik[playerid] == 0)
					    {
					        if(!IsPlayerInAnyVehicle(playerid))
					        {
							    //if(playa == playerid) { SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz zatankowaæ swojego auta!"); return 1; }
							    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
							    format(string, sizeof(string), "* Oferujesz %s zatankowanie jego auta za $%d .",giveplayer,money);
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								format(string, sizeof(string), "* Mechanik %s proponuje ci dotankowanie twojego auta za $%d, (wpisz /akceptuj tankowanie) aby akceptowaæ.",sendername,money);
								SendClientMessage(playa, COLOR_LIGHTBLUE, string);
								RefillOffer[playa] = playerid;
								RefillPrice[playa] = money;
								SpamujeMechanik[playerid] = 1;
								SetTimerEx("AntySpamMechanik",30000,0,"d",playerid);
							}
							else
							{
							    sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz tankowaæ auta bêd¹c w wozie.");
							}
                        }
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Poczekaj 30 sekund.");
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie / nie jest w samochodzie.");
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza.");
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ mechanikiem!");
	        return 1;
	    }
	}
	return 1;
}
