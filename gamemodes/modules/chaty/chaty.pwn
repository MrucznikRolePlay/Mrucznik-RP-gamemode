//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera chaty dostêpne dla wszystkich graczy oraz globalne chaty.
	Lista chatów:
		- lokalny /l
		- krzyk /k
		- szept /s
		- lokalny ooc /b
		- globalny ooc /o
		- opisuj¹cy akcje /me
		- opisuj¹cy otoczenie /do
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

stock WykonajEmotki(playerid, text[])
{
	new string[256];
	new emotki[7][] = {
		":)",
		";)",
		":(",
		":D",
		";D",
		"xD",
		":P"
	};
	new poss = strfind(text, emotki); 
	
	if(poss != -1)
	{
		strdel(string, poss+2, strlen(string));
	}
	return string;
}


stock KolorujWstawkiMe(text[])
{
	new string[256];
	strcat(string, text);
	new stars = strfind(string, "**");
	if(stars != -1)
	{
		new nextStars = strfind(string, "**", true, stars+2);
		if(nextStars != -1)
		{
			strdel(string, nextStars+2, strlen(string));
			strins(string, INCOLOR_PURPLE, stars);
		}
	}
	return string;
}


//-----------------<[ Komendy: ]>-------------------
CMD:local(playerid, params[]) return cmd_say(playerid, params);
CMD:l(playerid, params[]) return cmd_say(playerid, params);
CMD:say(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony", TEAM_CYAN_COLOR);
			return 1;
		}
		if(GetPVarInt(playerid, "dutyadmin") == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(l)ocal [tekst]");
			return 1;
		}
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s mówi: %s", GetNick(playerid, true), params);
			format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
            ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
            SetPlayerChatBubble(playerid,params,COLOR_FADE1,10.0,8000);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text2[64];

                strmid(text2, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                format(string, sizeof(string), "%s mówi: %s [.]", GetNick(playerid, true), params);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

                format(string, sizeof(string), "[.] %s", text2);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
            }
        }
		//Text 3 D
		format(string, sizeof(string), "mówi: %s", params);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,20.0,8000);
	}
	return 1;
}
CMD:krzyk(playerid, params[]) return cmd_k(playerid, params);
CMD:k(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPVarInt(playerid, "dutyadmin") == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /b [treœæ]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(k)rzyk [tekst]");
			return 1;
		}
		if (strfind(params , "{" , true)>=0 || strfind(params , "}" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GREY," U¿ywanie dodakowych kolorów wy³¹czone");
		}
		else
		{
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s krzyczy: %s!!", GetNick(playerid, true), params);
			format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
            ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text[64];

                strmid(text, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                format(string, sizeof(string), "%s krzyczy: %s", GetNick(playerid, true), params);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
                format(string, sizeof(string), "[.] %s!!", text);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
            }
        }
		//Text 3 D
        format(string, sizeof(string), "%s Krzyczy: %s!!", GetNick(playerid), params);
        printf("%s", string);
		//SetPlayerChatBubble(playerid,string,COLOR_WHITE,30.0,8000);
		if(!IsPlayerInAnyVehicle(playerid))
		{
			ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
		}
		}
	}
	return 1;
}

CMD:cicho(playerid, params[]) return cmd_szept(playerid, params);
CMD:s(playerid, params[]) return cmd_szept(playerid, params);
CMD:szept(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony", TEAM_CYAN_COLOR);
			return 1;
		}
		if(GetPVarInt(playerid, "dutyadmin") == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /b [treœæ]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(s)zept [tekst]");
			return 1;
		}
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s szepcze: %s", GetNick(playerid, true), params);
			format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
            ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text[64];

                strmid(text, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                format(string, sizeof(string), "%s szepcze: %s", GetNick(playerid, true), params);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                
                format(string, sizeof(string), "[.] %s", text);
				format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
                ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
		//Text 3 D
		format(string, sizeof(string), "Szepcze: %s", params);
        printf("%s", string);
		//SetPlayerChatBubble(playerid,string,COLOR_FADE1,5.0,8000);
	}
	return 1;
}

CMD:b(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /b [CZAT OOC]");
			return 1;
		}
		//format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", sendername, playerid, params);
		//ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		
		//Text 3 D
        if(strlen(params) < 78)
        {
            format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", sendername, playerid, params);
            ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
        else
        {
            new pos = strfind(params, " ", true, strlen(params) / 2);
            if(pos != -1)
            {
                new text[64];

                strmid(text, params, pos + 1, strlen(params));
                strdel(params, pos, strlen(params));

                //format(string, sizeof(string), "%s szepcze: %s", GetNick(playerid, true), params);
                //ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                format(string, sizeof(string), "%s [%d] Czat OOC: (( %s [.]", GetNick(playerid, true), playerid, params);
                ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                //format(string, sizeof(string), "[.] %s", text);
                //ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                format(string, sizeof(string), "[.] %s ))", text);
                ProxDetector(25.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
	    format(string, sizeof(string), "(( %s Napisa³: %s ))", GetNick(playerid, false), params);
        printf("%s", string);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,25.0,8000);
	}
	return 1;
}

CMD:me(playerid, params[]) return cmd_ja(playerid, params);
CMD:ja(playerid, params[])
{
	if(isnull(params))
	{
		sendTipMessage(playerid, "U¿yj /me [akcja]");
		return 1;
	}
	if(GetPVarInt(playerid, "dutyadmin") == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tego podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
		return 1;
	}
    new string[256];
    params[0] = tolower(params[0]);
    
    if(strlen(params) < 78)
    {
        format(string, sizeof(string), "* %s %s", GetNick(playerid, true), params);
        ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
    }
    else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "* %s %s [.]", GetNick(playerid, true), params);
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            
            format(string, sizeof(string), "[.] %s", text);
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
        }
    }
	return 1;
}

CMD:do(playerid, params[])
{
    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /do [opis sytuacji]");
        return 1;
    }
	if(GetPVarInt(playerid, "dutyadmin") == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tego podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
		return 1;
	}
    new string[256];
    
    if(strlen(params) < 78)
    {
        //format(string, sizeof(string), "* %s %s", GetNick(playerid, true), params);
        format(string, sizeof(string), "* %s (( %s ))", params, GetNick(playerid, true));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "* %s [.]", params);
            ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

            format(string, sizeof(string), "[.] %s (( %s ))", text, GetNick(playerid, true));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        }
    }
    return 1;
}

//end