CMD:dmv(playerid, params[]) return cmd_dmv_info(playerid, params);
CMD:dmv_info(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new content[256];

    if(IsPlayerConnected(playerid))
    {
		if(!IsAUrzednik(playerid))
		{
 			sendErrorMessage(playerid, "Nie jesteœ urzêdnikiem!");
		    return 1;
		}
		if(PlayerInfo[playerid][pRank] < 2)
		{
		    sendErrorMessage(playerid, "Musisz mieæ 2 range aby tego u¿ywaæ!");
		    return 1;
		}
		if(GetPVarInt(playerid, "dutyadmin") == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Napisz to poprzez /o treœæ");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/dmv)-info [tekst]");
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
		    format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPVarString(playerid, "trescOgloszenia", content, sizeof(content));
		if(spamujeKomunikatami[playerid] == 1)
		{
			new ammountTime;
			ammountTime = 15-komunikatMinuty[playerid];
			format(string, sizeof(string), "Wys³a³eœ og³oszenie o tej samej treœci, odczekaj jeszcze %d minut", ammountTime);
			sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string); 
			format(string, sizeof(string), "{A0522D}Ostatnie og³oszenie: {FFFFFF}%s", content);
			sendTipMessage(playerid, string);
			return 1;
		}
		if(!strcmp(params, content, false))
		{
			sendTipMessageEx(playerid, COLOR_WHITE, "Marcepan Marks mówi: Wys³a³eœ og³oszenie o tej samej treœci! Zostajesz ukarany kar¹ Anty-Spam na 15 minut");
			spamujeKomunikatami[playerid] = 1;
			komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);	
		}
		else
		{
			SetPVarString(playerid, "trescOgloszenia", params);
			SendClientMessageToAll(COLOR_WHITE, "|___________ Wiadomoœæ Rz¹dowa ___________|");
			format(string, sizeof(string), "Urzêdnik %s: %s", sendername, params);
			SendClientMessageToAll(COLOR_YELLOW, string);
			
		}
	}
	return 1;
}