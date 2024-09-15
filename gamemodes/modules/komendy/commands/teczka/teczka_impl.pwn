//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_teczka_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			new giveplayerid, moneys;
			if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
			{
				sendTipMessage(playerid, "U¿yj /teczka [playerid/CzêœæNicku] [iloœæ]");
				return 1;
			}
			moneys = FunkcjaK(string);

			if(PlayerInfo[playerid][pConnectTime] == 0)
			{
				sendTipMessage(playerid, "Zanim bêdziesz móg³ p³aciæ, musisz graæ wiêcej ni¿ 1 godzinê online!");
			    return 1;
			}

			if(PlayerInfo[playerid][pLevel] < 2)
			{
				sendTipMessage(playerid, "Musisz mieæ 2 level aby p³aciæ teczk¹");
				return 1;
			}
			if(moneys < 1 || moneys > 1000001)
			{
			    sendTipMessage(playerid, "Kwota musi wynosiæ mniej ni¿ 1 000 000$ .");
			    return 1;
			}
			if(AntySpam[playerid] == 1)
			{
			    sendTipMessage(playerid, "Odczekaj 15 sekund lub skorzystaj z przelewu");
				return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID && playerid != giveplayerid)
			    {
			        if(PlayerInfo[giveplayerid][pLocal] == 106)
					{
						sendErrorMessage(playerid, "Komenda nie dzia³a w tym miejscuu");
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
							Log(payLog, INFO, "%s da³ %s kwotê %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), moneys);
							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "* %s wyci¹ga teczkê i podaje %s.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							AntySpam[playerid] = 1;
							SetTimerEx("AntySpamTimer",15000,0,"d",playerid);
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
	}
	return 1;
}

//end
