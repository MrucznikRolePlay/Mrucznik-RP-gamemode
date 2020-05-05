//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   chaty                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Podstawowe chaty oraz narzêdzia do ich pisania.
	Lista chatów:
		- [ic] /ad 
		- /live (/wywiad)
		- /news
		- /ro (rodziny ooc)
		- /fo (fraction ooc)
		- /r (rodziny ic)
		- /f (frakcje ic)
		- lokalny /l
		- krzyk /k
		- szept /s
		- lokalny ooc /b
		- globalny ooc /o
		- opisuj¹cy akcje /me
		- opisuj¹cy otoczenie /do
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
CheckStars(const text[])
{
    new Message[256];
    strcat(Message, text);
    new Stars = strfind(Message, "**");
    if (Stars != -1)
    {
        new nextStars = strfind(Message, "**", true, Stars+2);
        if (nextStars != -1)
        {
            strins(Message, "{C2A2DA}", Stars);
            strins(Message, "{FFFFFF}", nextStars+10);
        }
    }
    return Message;
}
CheckEmoji(const text[])
{
	new emojiMessFix[256];
	strcat(emojiMessFix, text); 
	regex_replace(emojiMessFix, ":D+", "{C2A2DA}**œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":P+", "{C2A2DA}**wystawia jêzyk**{FFFFFF}");
	regex_replace(emojiMessFix, "[xX][dD]+", "{C2A2DA}**œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";\\)+", "{C2A2DA}**puszcza oczko**{FFFFFF}");
	regex_replace(emojiMessFix, ";D+", "{C2A2DA}**puszcza oczko i œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";d+", "{C2A2DA}**wystawia jêzyk i puszcza oczko**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\)+", "{C2A2DA}**uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\(+", "{C2A2DA}**smuci siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":O+", "{C2A2DA}**dziwi siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\*+", "{C2A2DA}**puszcza ca³usa**{FFFFFF}");
	regex_replace(emojiMessFix, ":v+", "{C2A2DA}**k³apie dziobem**{FFFFFF}");
	regex_replace(emojiMessFix, ":s+", "{C2A2DA}**krzywi siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":3+", "{C2A2DA}**uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, "[oO]_o", "{C2A2DA}**dziwi siê**{FFFFFF}");
	return emojiMessFix;
}
CorrectICForm(const text[])
{
	new correctForm[256];
	format(correctForm, sizeof(correctForm), "%s", CheckEmoji(CheckStars(text)));
	return correctForm;
}
sprawdzReklame(text[], playerid)
{
	new valueAdd;
	if(strfind(text , "ip:" , true)>=0 
	|| strfind(text , "www." , true)>=0 
	|| strfind(text , ".pl" , true)>=0 
	|| strfind(text , "serw" , true)>=0  
	|| strfind(text , "serv" , true)>=0 
	|| strfind(text , ":7777" , true)>=0 
	|| strfind(text , ":2000" , true)>=0 
	|| strfind(text , ":3000" , true)>=0 
	|| strfind(text , ":4000" , true)>=0 
	|| strfind(text , ":5000" , true)>=0 
	|| strfind(text , ":6000" , true)>=0 
	|| strfind(text , ":8000" , true)>=0
	|| strfind(text, "lsrp", true)>=0
	|| strfind(text, "ls-rp", true)>=0
	|| strfind(text, "stories", true)>=0
	|| strfind(text, "n4g", true)>=0
	|| strfind(text, "fox", true)>=0)
	{
		new string[128];
		SendClientMessage(playerid, COLOR_GRAD2, "STOP REKLAMOM!");
		if(playerid != 666)
		{
			format(string, sizeof(string), "AdmWarning: %s [%d] REKLAMA: '' %s. '' ", GetNick(playerid), playerid, text);
		}
		else
		{
			format(string, sizeof(string), "AdmWarning: %s - Wykryto reklamê", text);
		}
		ABroadCast(COLOR_LIGHTRED,string,1);
		Log(warningLog, INFO, "%s reklamuje: %s", GetPlayerLogName(playerid), text);
		valueAdd=1;
	}
	else
	{
		valueAdd=0;
	}
	return valueAdd;
}

sprawdzWulgaryzmy(text[], playerid)
{
	new valueWulgaryzmy;
	
	if(CheckVulgarityString(text) != 0)
	{
		if(playerid != 666)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "Zosta³eœ ukarany grzywn¹ za wulgaryzmy! Kara: (20.000$)");
			ZabierzKase(playerid, 20000);
			Log(punishmentLog, INFO, "Gracz %s zosta³ ukarany kar¹ 20000$ za przeklinanie.", GetPlayerLogName(playerid));
		}
		Log(warningLog, INFO, "%s przeklina: %s", GetPlayerLogName(playerid), text);
		valueWulgaryzmy = 1;
	}
	else
	{
		valueWulgaryzmy=0;
	}
	return valueWulgaryzmy;
}
PlayerTalkIC(playerid, text[], jakMowi[], Float:rangeTalk,  bool:chatBooble=true)
{ 
	new string[256]; 
	if(strlen(jakMowi) <= 1)
	{
		sendErrorMessage(playerid, "B³¹d! Zbyt krótka wartoœæ 'jakMowi'"); 
		return 1;
	}
	text[0] = toupper(text[0]);
	new ostatnialitera = strlen(text)-1;
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		if(strlen(text) < 78)
		{
			
			if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
			else  format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
			ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
		}
		else
		{
			new pos = strfind(text, " ", true, strlen(text) / 2);
			if(pos != -1)
			{
				new text2[64];

				strmid(text2, text, pos + 1, strlen(text));
				strdel(text, pos, strlen(text));

				format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s [..] ))", GetNick(playerid), playerid, text);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

				if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{C0C0C0}>>(([..] %s ))", text2);
				else format(string, sizeof(string), "{C0C0C0}>>(([..] %s. ))", text2);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			}
		}
		return 1;
	}
	if(strlen(text) < 78)
	{
		if(strfind(jakMowi, "krzyczy", true, 0)  != -1)
		{
			format(string, sizeof(string), "%s %s: %s!", GetNick(playerid), jakMowi, text);
			ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			return 1;
		}
		if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s %s: %s", GetNick(playerid), jakMowi, text);
		else format(string, sizeof(string), "%s %s: %s.", GetNick(playerid), jakMowi, text);
		ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{
		new pos = strfind(text, " ", true, strlen(text) / 2);
		if(pos != -1)
		{
			new text2[64];

			strmid(text2, text, pos + 1, strlen(text));
			strdel(text, pos, strlen(text));

			format(string, sizeof(string), "%s %s: %s [.]", GetNick(playerid), jakMowi, text);
			ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "[.] %s", text2);
			else format(string, sizeof(string), "[.] %s.", text2);
			ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

		}
	}
	if(chatBooble == true)
	{
		if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s: %s", jakMowi, text);
		else format(string, sizeof(string), "%s: %s.", jakMowi, text);
		if(strfind(jakMowi, "szepcze", true, 0) != -1) SetPlayerChatBubble(playerid,string,COLOR_FADE1,5.0,8000);
		else SetPlayerChatBubble(playerid,string,COLOR_FADE1,20.0,8000);
	}	
	return 1;
}
PlayerTalkOOC(playerid, text[], Float:rangeTalk)
{
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		text[0] = toupper(text[0]);
		new ostatnialitera = strlen(text)-1;
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			if(strlen(text) < 78)
			{
				if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
				else format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s [..] ))", GetNick(playerid), playerid, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

					if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{C0C0C0}>>(([..] %s ))", text2);
					else format(string, sizeof(string), "{C0C0C0}>>(([..] %s. ))", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				}
			}
			return 1;
		}
		if(strlen(text) < 78)
        {
            if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
			else format(string, sizeof(string), "%s [%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
            ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
        else
        {
            new pos = strfind(text, " ", true, strlen(text) / 2);
            if(pos != -1)
            {
                new text2[64];

                strmid(text2, text, pos + 1, strlen(text));
                strdel(text, pos, strlen(text));

                format(string, sizeof(string), "%s [%d] Czat OOC: (( %s [.]", GetNick(playerid), playerid, text);
                ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

                if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "[.] %s ))", text2);
				else format(string, sizeof(string), "[.] %s. ))", text2);
                ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
	    if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "(( %s Napisa³: %s ))", GetNick(playerid), text);
		else format(string, sizeof(string), "(( %s Napisa³: %s. ))", GetNick(playerid), text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,25.0,8000);
	    Log(chatLog, INFO, "%s OOC: %s", GetPlayerLogName(playerid), text);
	}
	return 1;
}

GetFractionColor(fraction)
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

sendFractionMessageToAll(playerid, text[])
{
	new sContent[256];
	foreach(new i : Player) 
	{
		if(GetPVarInt(i, "TOG_frakcja_info") == 0 && PlayerPersonalization[i][PERS_FAMINFO] == 0)
		{
			fractionMessageRange++; 
			format(sContent, sizeof(sContent), "|___________ %s ___________|", FractionNames[GetPlayerFraction(playerid)]); 
			SendClientMessage(i, COLOR_WHITE, sContent); 
			format(sContent, sizeof(sContent), "%s %s: %s", FracRang[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]], GetNickEx(playerid), text);
			SendClientMessage(i, GetFractionColor(PlayerInfo[playerid][pMember]), sContent); 
		}
	}
	format(sContent, sizeof(sContent), "Wiadomoœæ dotar³a do %d graczy", fractionMessageRange); 
	sendTipMessage(playerid, sContent); 
	fractionMessageRange = 0; 
	return 1;
}

showTimedMsgBox(playerid, delay, text[]) {
	CzasInformacyjnego[playerid] = delay;
	PlayerTextDrawHide(playerid, TextInformacyjny[playerid]);
	PlayerTextDrawSetString(playerid, TextInformacyjny[playerid], text);
	PlayerTextDrawShow(playerid, TextInformacyjny[playerid]);
	return true;
}

//------------------<[ Z 3.0: ]>--------------------
stock ChatIC(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi: %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4); //animacja mowy
	}
	Log(chatLog, INFO, "Chat IC: %s", text);
	return 1;
}

stock ActorChat(actorid, actor[], text[]) //TODO: better actor chat
{
	new Float:x, Float:y, Float:z;
	GetDynamicActorPos(actorid, x, y, z);
	return SystemRangeMessageColor(
		x, y, z, 
		GetDynamicActorVirtualWorld(actorid), 
		sprintf("%s Mówi: %s", actor, text), 
		CHAT_RANGE, 
		COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5
	);
}

stock Krzyk(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy(w pojeŸdzie): %s!!", GetNick(playerid), text);
		RangeMessageColor(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy: %s!!", GetNick(playerid), text);
		RangeMessageColor(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
	}
	Log(chatLog, INFO, "Krzyk: %s", text);
	return 1;
}

stock Szept(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze: %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	Log(chatLog, INFO, "Szept: %s", text);
	return 1;
}

stock ChatOOC(playerid, text[])
{
	new string[256];
	format(string, sizeof(string), "(( %s ))", text);
	SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
	format(string, sizeof(string), "%s [%d] Czat OOC: %s", GetNick(playerid), playerid, string);
    RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	Log(chatLog, INFO, "Chat OOC: %s", text);
	return 1;
}

stock ChatMe(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "* %s *", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s %s", GetNick(playerid), text);
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "--/me:-- %s", text);
	Log(chatLog, INFO, "Chat me: %s", text);
	return 1;
}

stock ChatDo(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "** %s **", text);
	SetPlayerChatBubble(playerid,string, COLOR_DO, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s ((%s))", text, GetNick(playerid));
    RangeMessageColor(playerid, string, zasieg, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
	format(string, sizeof(string), "--/do:-- %s", text);
	Log(chatLog, INFO, "Chat do: %s", text);
	return 1;
}

//------------------<[ MruMessage: ]>--------------------

stock MruMessage(playerid, kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessage(playerid, kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessage(playerid, kolor, bufor);
		return 1;
	}
	else
	{
		return SendClientMessage(playerid, kolor, text);
	}
}

stock MruMessageToAll(kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessageToAll(kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessageToAll(kolor, bufor);
	}
	else
	{
		return SendClientMessageToAll(kolor, text);
	}
	return 1;
}

stock MruMessageF(playerid, color, fstring[], {Float, _}:...) //by Y_Less edited by Mrucznik
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
    if(n)
    {
        new message[256],arg_start,arg_end;
        #emit CONST.alt        fstring
        #emit LCTRL          5
        #emit ADD
        #emit STOR.S.pri        arg_start

        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= BYTES_PER_CELL;
            #emit LOAD.S.pri      arg_end
        }
        while(arg_end > arg_start);

        #emit PUSH.S          fstring
        #emit PUSH.C          256
        #emit PUSH.ADR         message

        n += BYTES_PER_CELL * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C         format

        n += BYTES_PER_CELL;
        #emit LCTRL          4
        #emit LOAD.S.alt        n
        #emit ADD
        #emit SCTRL          4

        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, message);
        } else {
            return MruMessage(playerid, color, message);
        }
    } else {
        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, fstring);
        } else {
            return MruMessage(playerid, color, fstring);
        }
    }
}

stock SystemRangeMessage(Float:x, Float:y, Float:z, vw, kolor, text[], Float:zasieg=30.0)
{ //wiadomoœæ wyœwietlana w okreœlonym zasiêgu
	foreach(new i : Player)
	{
		if(gPlayerLogged[i] == 0) continue;
		if(GetPlayerVirtualWorld(i) == vw || vw == -1)
		{
			if(IsPlayerInRangeOfPoint(i, zasieg, x, y, z))
			{
				MruMessage(i, kolor, text);
			}
		}
	}
	return 1;
}

stock RangeMessage(playerid, kolor, text[], Float:zasieg=30.0)
{ //wiadomoœæ wyœwietlana w okreœlonym zasiêgu
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	return SystemRangeMessage(x, y, z, GetPlayerVirtualWorld(playerid), kolor, text, zasieg);
}

stock SystemRangeMessageColor(Float:x, Float:y, Float:z, vw, text[], Float:zasieg, kolor1, kolor2, kolor3, kolor4, kolor5)
{
	foreach(new i : Player)
	{
		if(gPlayerLogged[i] == 0) continue;
		if(GetPlayerVirtualWorld(i) == vw || vw == -1)
		{
			new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
			if(distance <= zasieg)
			{
				if(distance <= zasieg/16)
					MruMessage(i, kolor1, text);
				else if(distance <= zasieg/8)
					MruMessage(i, kolor2, text);
				else if(distance <= zasieg/4)
					MruMessage(i, kolor3, text);
				else if(distance <= zasieg/2)
					MruMessage(i, kolor4, text);
				else
					MruMessage(i, kolor5, text);
			}
		}
	}
	return 1;
}

stock RangeMessageColor(playerid, text[], Float:zasieg, kolor1, kolor2, kolor3, kolor4, kolor5)
{ //wiadomoœæ wyœwietlana w okreœlonym zasiêgu kolorowana w zale¿noœci od odleg³oœci
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	
	return SystemRangeMessageColor(x, y, z, GetPlayerVirtualWorld(playerid), text, zasieg, kolor1, kolor2, kolor3, kolor4, kolor5);
}

//-----------------<[ Komendy: ]>-------------------

//end