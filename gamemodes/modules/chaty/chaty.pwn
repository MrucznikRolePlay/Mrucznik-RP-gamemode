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
	regex_replace(emojiMessFix, ":D+", "{C2A2DA}**Œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":P+", "{C2A2DA}**Wystawia jêzyk**{FFFFFF}");
	regex_replace(emojiMessFix, "[xX][dD]+", "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}");
	regex_replace(emojiMessFix, ";\\)+", "{C2A2DA}**Puszcza oczko z œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";D+", "{C2A2DA}**Puszcza oczko i uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";d+", "{C2A2DA}**Wystawia jêzyk i robi oczko**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\)+", "{C2A2DA}**Uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\(+", "{C2A2DA}**Smuci siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":O+", "{C2A2DA}**Otwiera usta szeroko**{FFFFFF}");
	regex_replace(emojiMessFix, ":\\*+", "{C2A2DA}**Puszcza ca³usa**{FFFFFF}");
	regex_replace(emojiMessFix, ":v+", "{C2A2DA}**K³apie dziobem**{FFFFFF}");
	regex_replace(emojiMessFix, ":s+", "{C2A2DA}**Krzywi siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":3+", "{C2A2DA}**Robi minê ala funia**{FFFFFF}");
	regex_replace(emojiMessFix, "o_o", "{C2A2DA}**Robi okulary z d³oni**{FFFFFF}");
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
	|| strfind(text , ":7" , true)>=0 
	|| strfind(text , ":2" , true)>=0 
	|| strfind(text , ":3" , true)>=0 
	|| strfind(text , ":4" , true)>=0 
	|| strfind(text , ":5" , true)>=0 
	|| strfind(text , ":6" , true)>=0 
	|| strfind(text , ":8" , true)>=0
	|| strfind(text, "lsrp", true)>=0
	|| strfind(text, "ls-rp", true)>=0
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
		Log(czitLog, INFO, string);
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
	new stringReturn[256];

	if(strfind(text, "jeb", true)>=0 
	||strfind(text , "huj" , true)>=0 
	|| strfind(text , "pizda" , true)>=0 
	|| strfind(text , "pizdy" , true)>=0 
	|| strfind(text , "frajer" , true)>=0
	|| strfind(text , "szmul" , true)>=0
	|| strfind(text , "dzban" , true)>=0  	
	|| strfind(text , "kurwa" , true)>=0
	|| strfind(text , "kutas" , true)>=0 
	|| strfind(text , "dupa" , true)>=0 
	|| strfind(text , "cipa" , true)>=0 
	|| strfind(text , "cipka" , true)>=0 
	|| strfind(text , "n00b" , true)>=0 
	|| strfind(text , "noob" , true)>=0 
	|| strfind(text , "n0b" , true)>=0)
	{
		if(playerid != 666)
		{
		
			SendClientMessage(playerid, COLOR_GRAD2, "Zosta³eœ ukarany grzywn¹ za wulgaryzmy! Kara: (20.000$)");
			format(stringReturn, sizeof(stringReturn), "AdmWarning: [%d] %s u¿ycie wulgaryzmów (kara -10 000$): %s.",playerid,GetNick(playerid),text);
			DajKase(playerid, -20000);
		}
		else
		{
			format(stringReturn, sizeof(stringReturn), "AdmWarning: %s - pojawi³y siê wulgaryzmy");
		}
		ABroadCast(COLOR_LIGHTRED,stringReturn,1000);
		Log(warningLog, INFO, stringReturn);
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
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		if(strlen(text) < 78)
		{
			
			format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
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

				format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s [..] ))", GetNick(playerid), text);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

				format(string, sizeof(string), "{C0C0C0}>>(([..] %s ))", text2);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			}
		}
		return 1;
	}
	if(strlen(text) < 78)
	{
		format(string, sizeof(string), "%s %s: %s", GetNick(playerid, true), jakMowi, text);
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

			format(string, sizeof(string), "%s %s: %s [.]", GetNick(playerid, true), jakMowi, text);
			ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

			format(string, sizeof(string), "[.] %s", text2);
			ProxDetector(rangeTalk, playerid, CorrectICForm(string), COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		}
	}
	if(chatBooble == true)
	{
		format(string, sizeof(string), "%s: %s", jakMowi, text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,20.0,8000);
	}	
	return 1;
}
PlayerTalkOOC(playerid, text[], Float:rangeTalk)
{
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(strlen(text) < 78)
        {
            format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
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

                format(string, sizeof(string), "[.] %s ))", text2);
                ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
	    format(string, sizeof(string), "(( %s Napisa³: %s ))", GetNick(playerid), text);
        printf("%s", string);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,25.0,8000);
	
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
		if(GetPVarInt(i, "TOG_frakcja_info") == 0)
		{
			fractionMessageRange++; 
			format(sContent, sizeof(sContent), "|___________ %s ___________|", FractionNames[GetPlayerFraction(playerid)]); 
			SendClientMessage(i, COLOR_WHITE, sContent); 
			format(sContent, sizeof(sContent), "%s %s: %s", FracRang[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]], GetNick(playerid, true), text);
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

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end