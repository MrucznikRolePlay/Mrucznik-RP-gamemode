//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ plac ]-------------------------------------------------//
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

YCMD:plac(playerid, params[], help)
{
	new string[64];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			new giveplayerid, moneys;
			if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
			{
				sendTipMessage(playerid, "U¿yj /plac [playerid/CzêœæNicku] [iloœæ]");
				return 1;
			}
			moneys = FunkcjaK(string);


			if(moneys < 1 || moneys > 100001)
			{
			    sendTipMessage(playerid, "Kwota musi wynosiæ mniej ni¿ 100 000$ .");
			    return 1;
			}
			if(moneys > 12500 && PlayerInfo[playerid][pLevel] < 2 && PlayerInfo[playerid][pLocal] != 108)
			{
				return sendTipMessage(playerid, "Nie mo¿esz p³aciæ wiêcej niz $12500");
			}
			if(PlayerInfo[playerid][pOnlineHours] == 0)
			{
				sendTipMessage(playerid, "Zanim bêdziesz móg³ p³aciæ, musisz graæ wiêcej ni¿ 1 godzinê online!");
			    return 1;
			}
			if(AntySpam[playerid] == 1)
			{
			    sendTipMessage(playerid, "Odczekaj 15 sekund, poœwiêæ ten czas na wykonanie akcji RP");
				return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(PlayerInfo[giveplayerid][pLocal] == 106)
					{
						sendTipMessage(playerid, "Komenda nie dzia³a w tym miejscu.");
						return 1;
					}
			        if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
					{
						sendErrorMessage(playerid, "Jesteœ za daleko od gracza.");
						return 1;
					}
					if (ProxDetectorS(5.0, playerid, giveplayerid))
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new playermoney = kaska[playerid];
						if (moneys > 0 && playermoney >= moneys)
						{
							ZabierzKase(playerid, moneys);
							DajKase(giveplayerid, moneys);
							format(string, sizeof(string), "   Da³eœ %s(gracz: %d), $%d.", giveplayer,giveplayerid, moneys);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "   Otrzyma³eœ $%d od %s(gracz: %d).", moneys, sendername, playerid);
							SendClientMessage(giveplayerid, COLOR_GRAD1, string);
							Log(payLog, INFO,  "%s da³ %s kwotê %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), moneys);
							if(moneys >= 1000000)
							{
								ABroadCast(COLOR_YELLOW,string,1);
							}
							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "* %s wyci¹ga pieni¹dze i daje je %s.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							if(IsPlayerInRangeOfPoint(playerid, 20.0, 2414.0461,-1604.5720,2420.4224) && PlayerInfo[giveplayerid][pMember] == 11)
							{
							}
							else
							{
								AntySpam[playerid] = 1;
								SetTimerEx("AntySpamTimer",15000,0,"d",playerid);
							}
						}
						else
						{
							sendErrorMessage(playerid, "Nieprawid³owa iloœæ pieniêdzy.");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Jesteœ za daleko od gracza.");
					}
				}//invalid id
			}
			else
			{
				format(string, sizeof(string), "%d nie jest na serwerze.", giveplayerid);
				sendErrorMessage(playerid, string);
			}
		}
		else
		{
		    KickEx(playerid);
		}
	}
	return 1;
}
