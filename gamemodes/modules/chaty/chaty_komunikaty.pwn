//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera wszelkie chaty globalne (komunikaty)
	Wliczamy w to:
		> DMV - wiadomoœæ rz¹dowa
		
*/
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

//

//-----------------<[ Funkcje: ]>-------------------
stock GetFractionColor(fraction)
{
	new fracColor;
	if(fraction == 1)
	{
		fracColor = COLOR_LIGHTBLUE;
	}
	if(fraction == 2)
	{
		fracColor = COLOR_LFBI;
	}
	if(fraction == 3)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 4)
	{
		fracColor = COLOR_LIGHTBLUE; 
	}
	if(fraction == 5)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 6)
	{
		fracColor = COLOR_WHITE; 
	}
	if(fraction == 7)
	{
		fracColor = COLOR_PURPLE;
	}
	if(fraction == 8)
	{
		fracColor = COLOR_BLUE;
	}
	if(fraction == 9)
	{
		fracColor = COLOR_NEWS;
	}
	if(fraction == 10)
	{
		fracColor = COLOR_YELLOW;
	}
	if(fraction == 11)
	{
		fracColor = COLOR_LIGHTGREEN;
	}
	if(fraction == 12)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 13)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 14)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 15)
	{
		fracColor = COLOR_BROWN;
	}
	if(fraction == 16)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 17)
	{
		fracColor = COLOR_LIGHTRED;
	}
	if(fraction == 18)
	{
		fracColor = COLOR_WHITE;
	}
	return fracColor;
}
stock sendFractionMessageToAll(playerid, text[])
{
	new sContent[256];
	format(sContent, sizeof(sContent), "|___________ %s ___________|", FractionNames[GetPlayerFraction(playerid)]); 
	SendClientMessageToAll(COLOR_WHITE, sContent); 
	format(sContent, sizeof(sContent), "%s %s: %s", FracRang[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]], GetNick(playerid, true), text);
	SendClientMessageToAll(GetFractionColor(PlayerInfo[playerid][pMember]), sContent);

	return 1;
}

//-----------------<[ Komendy: ]>-------------------
CMD:frakcjainfo(playerid, params[]) return cmd_fi(playerid, params[]);
CMD:fi(playerid, params[])
{
	new string[256];
	new content[256];
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerFraction(playerid) == 0 
		|| GetPlayerFraction(playerid) == 6
		|| GetPlayerFraction(playerid) == 8
		|| GetPlayerFraction(playerid) == 12
		|| GetPlayerFraction(playerid) == 13
		|| GetPlayerFraction(playerid) == 14
		|| GetPlayerFraction(playerid) == 16)
		{
			noAccessMessage(playerid);
			return 1;
		}
		if(PlayerInfo[playerid][pRank] < 3)
		{
			noAccessMessage(playerid); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ podczas @duty"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /frakcjainfo (/fi) [tekst]"); 
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPVarString(playerid, "trescOgloszenia", content, sizeof(content));
		if(PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] >= 1)
		{
			PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15-komunikatMinuty[playerid];
			format(string, sizeof(string), "Wys³a³eœ og³oszenie o tej samej treœci, odczekaj jeszcze %d minut", PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas]);
			sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string); 
			format(string, sizeof(string), "{A0522D}Ostatnie og³oszenie: {FFFFFF}%s", content);
			sendTipMessage(playerid, string);
			return 1;
		}
		if(strfind(params, content, false) == -1)
		{
			SetPVarString(playerid, "trescOgloszenia", params);
			sendFractionMessageToAll(playerid, GetPlayerFraction(playerid), params); 
			komunikatTimeZerowanie[playerid] = SetTimerEx("KomunikatCzasZerowaie", 60000, true, "i", playerid);
			sendTipMessage(playerid, "Odczekaj 5 minut przed wys³aniem ponownego komunikatu o {AC3737}tej samej treœci"); 
			return 1;
		}
		SendClientMessage(playerid, -1, " "); 
		sendTipMessageEx(playerid, COLOR_WHITE, "Wys³a³eœ og³oszenie o tej samej treœci w czasie mniejszym jak {AC3737}5 minut!");
		sendTipMessageEx(playerid, COLOR_WHITE, "{C0C0C0}Zostajesz ukarany kar¹ Anty-Spam na {AC3737}15 minut");
		komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);		
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15;
		format(string, sizeof(string), "[ANTY_SPAM] %s otrzyma³ blokadê na 15 minut za wys³anie 2x tego samego komunikatu!", GetNick(playerid, true));
		SendAdminMessage(COLOR_BLUE, string);
	}
	return 1;
}

CMD:komunikat(playerid, params[])
{
    new string[256], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    if(!IsPlayerConnected(playerid)) return 1;
    if(!GetPlayerOrg(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w ¿adnej rodzinie!");
    if(PlayerInfo[playerid][pRank] < 5) return sendErrorMessage(playerid, "Musisz mieæ 5 range aby tego u¿ywaæ !");
    if(isnull(params)) return sendErrorMessage(playerid, "U¿yj: /komunikat [tekst]");
    if(CMDKomunikat == 1) return sendErrorMessage(playerid, "Komunikat by³ u¿yty przed chwil¹!");
    if(IsAPrzestepca(playerid)) return sendErrorMessage(playerid, "Nie mo¿esz byæ w gangu/mafii!");
    if(PlayerInfo[playerid][pBP])
    {
        format(string, sizeof(string), "   Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
        SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
        return 1;
    }
    format(string, sizeof(string), "|___________ %s ___________|", OrgInfo[gPlayerOrg[playerid]][o_Name]);
    SendClientMessageToAll(COLOR_WHITE, string);
    format(string, sizeof(string), "%s: %s", sendername, params);
    SendClientMessageToAll(COLOR_BLUE, string);
    CMDKomunikat = 1;
    SetTimer("KomunikatTimer", 60000, false);
    return 1;
}

//end