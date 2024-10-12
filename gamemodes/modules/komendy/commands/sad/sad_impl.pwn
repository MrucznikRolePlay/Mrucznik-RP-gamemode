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
command_sad_Impl(playerid, params[256])
{
    new string[256];
	new sendername[MAX_PLAYER_NAME];
	new content[256];

    if(IsPlayerConnected(playerid))
    {
		if(GetPlayerFraction(playerid) != FRAC_GOV && PlayerInfo[playerid][pRank] > 4)
		{
 			sendErrorMessage(playerid, "Nie jesteœ z s¹du!");
		    return 1;
		}
		if(PlayerInfo[playerid][pRank] < 3)
		{
		    sendErrorMessage(playerid, "Musisz mieæ 3 range aby tego u¿ywaæ !");
		    return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Napisz to poprzez /o treœæ");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj: /sad [tekst]");
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
			SendClientMessageToAll(COLOR_WHITE, "|___________ Wiadomoœæ S¹du ___________|");
			format(string, sizeof(string), "Sêdzia %s: %s", sendername, params);
			SendClientMessageToAll(COLOR_LIGHTGREEN, string);
			komunikatTimeZerowanie[playerid] = SetTimerEx("KomunikatCzasZerowaie", 60000, true, "i", playerid);
			sendTipMessage(playerid, "Odczekaj 5 minut przed wys³aniem ponownego komunikatu o {AC3737}tej samej treœci"); 
			return 1;
		}
		SendClientMessage(playerid, -1, " "); 
		sendTipMessageEx(playerid, COLOR_WHITE, "Wys³a³eœ og³oszenie o tej samej treœci w czasie mniejszym jak {AC3737}5 minut!");
		sendTipMessageEx(playerid, COLOR_WHITE, "{C0C0C0}Zostajesz ukarany kar¹ Anty-Spam na {AC3737}15 minut");
		komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);		
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15;
		format(string, sizeof(string), "[ANTY_SPAM] %s otrzyma³ blokadê na 15 minut za wys³anie 2x tego samego komunikatu!", GetNickEx(playerid));
		SendAdminMessage(COLOR_BLUE, string);
	}
	return 1;
}

//end
