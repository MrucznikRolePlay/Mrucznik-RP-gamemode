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
		- cb-radio /cb
		- prywatne wiadomoœci /w
*/
//Adnotacje:
/*
	W razie lagów mo¿na to zoptymalizowaæ by ca³e parsowanie textu by³o w 1 funkcji
	TODO:
	regex'y dla chatów IC (dozwolone tylko konkretne znaki)
	Anty reklama i anty bluzgi na chatach globalnych
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
chaty_Init()
{
	chaty_LoadCommands();
}

//CHWILOWO PRZENIESIONE DO DZIA£ANIA KODU
new PlayerARGBinds[MAX_PLAYERS][10][256]; //1.28mb
stock ZamienZnalezioneBindy(playerid, text[])
{
	new bufor[512], znajdz;
	strcat(bufor, text, sizeof(bufor));
	while (znajdz != -1)
	{
		znajdz = strfind(bufor, "#", false, znajdz);
		if(bufor[znajdz+1] >= '0' && bufor[znajdz+1] <= '9')
		{
			new numer = bufor[znajdz+1]-'0';
			strdel(bufor, znajdz, znajdz+2);
			strins(bufor, PlayerARGBinds[playerid][numer], znajdz);
			
			znajdz = znajdz-2+strlen(PlayerARGBinds[playerid][numer]);
		}
		else if(bufor[znajdz+1]=='G')
		{
			new nick[MAX_PLAYER_NAME];
			new giveplayerid = GetClosestPlayer(playerid);
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				GetPlayerName(giveplayerid, nick, sizeof(nick));
				strdel(bufor, znajdz, znajdz+2);
				strins(bufor, nick, znajdz);
			
				znajdz = znajdz-2+strlen(nick);
			}
			else
			{
				znajdz+=2;
			}
		}
	}
	return bufor;
}


stock ChatICAdditions(playerid, text[])
{
	new string[256];
	strcat(string, ZamienZnalezioneBindy(playerid, text));
	format(string, sizeof(string), "%s", WykonajEmotki(playerid, string));
	format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
	return string;
}

stock ChatOOCAdditions(playerid, text[])
{
	new string[256]; 
	strcat(string, ZamienZnalezioneBindy(playerid, text));
	return string;
}

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
	
	strcat(string, text);
	new bool:brakZamian;
	do
	{
		brakZamian = false;
		for(new i=0; i<sizeof(emotki); i++)
		{
			new pozycjaEmotki = strfind(string, emotki[i]);
			if(pozycjaEmotki != -1)
			{
				defer WyswietlMeEmotki(playerid, i);
				strdel(string, pozycjaEmotki, pozycjaEmotki+strlen(emotki[i]));
				brakZamian = true;
			}
		}
	}
	while(brakZamian);
	return string;
}

timer WyswietlMeEmotki[0](playerid, emotka)
{
	emotki[7][] = {
		"uœmiecha siê.",
		"puszcza oczko.",
		"zasmuci³ siê.",
		"œmieje siê.",
		"puszcza oczko wpadaj¹c w gromki œmiech.",
		"skis³ ze œmiechu.",
		"wystawia jêzyk."
	};
	Me(playerid, emotki[emotka]);
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


//----------< Chaty > --------------
stock Chat(playerid, text[])
{
	if(text[0] =='\0') return 1;
	
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi: %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4); //animacja mowy
	}
	//Log(ChatLog, INFO, text);
	return 1;
}

stock Krzyk(playerid, text[])
{
	if(text[0] =='\0') return 1;

	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy(w pojeŸdzie): %s!!", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_FADE2);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy: %s!!", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_FADE2);
		//ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);
	}
	//Log(ChatLog, INFO, text);
	return 1;
}

stock Szept(playerid, text[])
{
	if(text[0] =='\0') return 1;
	
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze: %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE5);
		//ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);
	}
	//Log(ChatLog, INFO, text);
	return 1;
}

stock ChatOOC(playerid, text[])
{
	new string[256];
	format(string, sizeof(string), "(( %s ))", text);
	SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
	format(string, sizeof(string), "%s [%d] Czat OOC: %s", GetNick(playerid), playerid, string);
    RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
	//Log(ChatLog, INFO, string);
	return 1;
}

stock GlobalOOC(playerid, text[])
{
	format(string, sizeof(string), "(( %s [%d]: %s ))", GetNick(playerid), playerid, text);
    MruMessageToAll(playerid, COLOR_WHITE, string);
	//Log(ChatLog, INFO, string);
	return 1;
}

stock Me(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "* %s *", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s %s", GetNick(playerid), text);
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "%s [/me:] %s", GetNick(playerid), text);
	//Log(ChatLog, INFO, string);
	return 1;
}

stock Do(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "** %s **", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s ((%s))", text, GetNick(playerid));
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "%s [/do:] %s", GetNick(playerid), text);
	//Log(ChatLog, INFO, string);
	return 1;
}

stock CBRadio(playerid, text[])
{
	new string[256];
	format(string, sizeof(string), "%s mówi przez CB-Radio: %s", GetNick(playerid), text);
	foreach( new i : GroupMember(LoggedPlayers))
	{
		if(IsPlayerInAnyVehicle(i))
		{
			MruMessage(i, COLOR_GREEN, string);
		}
	}
	//Log(ChatLog, INFO, string);
}

stock PrywatnaWiadomosc(playerid, giveplayerid, text[])
{
	MruMessageF(giveplayerid, COLOR_NEWS, "» %s (ID: %d) wiadomoœæ: %s", GetNick(playerid), playerid, text);
	MruMessageF(playerid,  COLOR_YELLOW, "« Wiadomoœæ wys³ana do %s (ID: %d)%s: %s", GetNick(giveplayerid), giveplayerid, (!IsPlayerPaused(giveplayerid)) ? (""): (" [AFK] "), text);
	
	PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
	PlayerPlaySound(giveplayerid, 1057, 0.0, 0.0, 0.0);
	
	//Log(ChatLog, INFO, "Gracz %s wys³a³ prywatn¹ wiadomoœæ do %s o treœci: %s", GetNick(playerid), GetNick(giveplayerid), text);
	return 1;
}

//------------------<[ MySQL: ]>--------------------

//---

//-----------------<[ Komendy: ]>-------------------
chaty_LoadCommands()
{
	Command_AddAlt(CMD:l, "local");
	Command_AddAlt(CMD:l, "say");
	Command_AddAlt(CMD:l, "powiedz");
	Group_SetCommand(LoggedPlayers, CMD:l, true);
	
	Command_AddAlt(CMD:k, "shout");
	Command_AddAlt(CMD:k, "krzyk");
	Command_AddAlt(CMD:k, "krzycz");
	Group_SetCommand(LoggedPlayers, CMD:k, true);
	
	Command_AddAlt(CMD:s, "szept");
	Command_AddAlt(CMD:s, "szepcz");
	Group_SetCommand(LoggedPlayers, CMD:s, true);
	
	Command_AddAlt(CMD:me, "ja");
	Group_SetCommand(LoggedPlayers, CMD:me, true);
	
	Command_AddAlt(CMD:do, "akcja");
	Group_SetCommand(LoggedPlayers, CMD:do, true);
	
	Group_SetCommand(LoggedPlayers, CMD:b, true);
	
	Command_AddAlt(CMD:cb, "cbradio");
	Group_SetCommand(LoggedPlayers, CMD:cb, true);
	
	Command_AddAlt(CMD:w, "pm");
	Command_AddAlt(CMD:w, "wiadomosc");
	Command_AddAlt(CMD:w, "whisper");
	Group_SetCommand(LoggedPlayers, CMD:w, true);
}

CMD:l(playerid, params[], help)
{ //chat
    if ( help ) return CMDHelp(playerid, "Podstawowy czat IC (mowa postaci).");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /l [tekst]");
	
	Chat(playerid, ChatICAdditions(playerid, params));
    return 1;
}

CMD:k(playerid, params[], help)
{ //krzyk
    if ( help ) return CMDHelp(playerid, "Podstawowy czat IC (krzyk postaci).");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /k [tekst]");
	
	Krzyk(playerid, ChatICAdditions(playerid, params));
    return 1;
}

CMD:s(playerid, params[], help)
{ //szept
    if ( help ) return CMDHelp(playerid, "Podstawowy czat IC (szept postaci).");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /s [tekst]");
	
	Szept(playerid, ChatICAdditions(playerid, params));
    return 1;
}

CMD:b(playerid, params[], help)
{ //szept
    if ( help ) return CMDHelp(playerid, "Podstawowy czat OOC (wiadomoœæ do graczy woko³o).");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /b [tekst]");
	
	ChatOOC(playerid, ChatOOCAdditions(playerid, params));
    return 1;
}

CMD:o(playerid, params[], help)
{ //szept
    if ( help ) return CMDHelp(playerid, "Globalny czat OOC (widoczny dla wszystkich graczy na serwerze).");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /o [tekst]");
	
	ChatOOC(playerid, ChatOOCAdditions(playerid, params));
    return 1;
}

CMD:me(playerid, params[], help)
{ //ja
    if ( help ) return CMDHelp(playerid, "S³u¿y do opisu czynnoœci które wykonuje postaæ.");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /me [akcja]");
	
	Me(playerid, ZamienZnalezioneBindy(playerid, params));
    return 1;
}

CMD:do(playerid, params[], help)
{ //do
    if ( help ) return CMDHelp(playerid, "S³u¿y do opisu otoczenia, wygl¹du czy sytuacji w jakiej znalaz³a siê nasza postaæ.");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /do [akcja]");
	
	Do(playerid, ZamienZnalezioneBindy(playerid, params));
    return 1;
}

CMD:cb(playerid, params[], help)
{ //chat
    if ( help ) return CMDHelp(playerid, "CB radio pozwala siê komunikowaæ z graczami, którzy s¹ w samochodzie z zakupionym CB-radiem.");
	
	if (isnull(params)) return CMDInfo(playerid, "U¿ycie: /cb [tekst]");
	
	CBRadio(playerid, ZamienZnalezioneBindy(playerid, params));
    return 1;
}

CMD:w(playerid, params[], help)
{ //chat
    if ( help ) return CMDHelp(playerid, "Wysy³a prywatn¹ wiadomoœæ do drugiego gracza.");
	
	new string[256], giveplayerid;
	
	if(sscanf(params, "us[256]", giveplayerid, string)) 
		return CMDInfo(playerid, "U¿ycie: /w [ID/Nick] [wiadomoœæ]");
		
	PrywatnaWiadomosc(playerid, giveplayerid, ZamienZnalezioneBindy(playerid, string));
    return 1;
}

//end