//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera chaty dostêpne dla wszystkich graczy oraz globalne chaty.
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
/*
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
*/
stock CheckStars(const text[])
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
stock CheckEmoji(const text[])
{
	new emojiMessFix[256];
	strcat(emojiMessFix, text); 
	regex_replace(emojiMessFix, ":{1}D{1,}", "{C2A2DA}**Œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}P{1,}", "{C2A2DA}**Wystawia jêzyk**{FFFFFF}");
	regex_replace(emojiMessFix, "x{1}D{1,}", "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}");
	regex_replace(emojiMessFix, "X{1}d{1,}", "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}");
	regex_replace(emojiMessFix, "X{1}D{1,}", "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}");
	regex_replace(emojiMessFix, "x{1}d{1,}", "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}");
	regex_replace(emojiMessFix, ";{1}){1,}", "{C2A2DA}**Puszcza oczko z œmieje siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";{1}D{1,}", "{C2A2DA}**Puszcza oczko i uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, ";{1}d{1,}", "{C2A2DA}**Wystawia jêzyk i robi oczko**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}){1,}", "{C2A2DA}**Uœmiecha siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}({1,}", "{C2A2DA}**Smuci siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}O{1,}", "{C2A2DA}**Otwiera usta szeroko**{FFFFFF}");
	//regex_replace(emojiMessFix, ":{1}*{1,}", "{C2A2DA}**Robi buŸkê**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}v{1,}", "{C2A2DA}**K³apie dziobem**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}s{1,}", "{C2A2DA}**Krzywi siê**{FFFFFF}");
	regex_replace(emojiMessFix, ":{1}3{1,}", "{C2A2DA}**Robi minê ala funia**{FFFFFF}");
	regex_replace(emojiMessFix, "o{1}_{1}o{1}", "{C2A2DA}**Robi okulary z d³oni**{FFFFFF}");
	return emojiMessFix;
}
stock CorrectICForm(const text[])
{
	new correctForm[256];
	format(correctForm, sizeof(correctForm), "%s", CheckEmoji(CheckStars(text)));
	return correctForm;
}
stock sprawdzReklame(text[], playerid)
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
		CzitLog(string);
		valueAdd=1;
	}
	else
	{
		valueAdd=0;
	}
	return valueAdd;
}
stock sprawdzWulgaryzmy(text[], playerid)
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
		WarningLog(stringReturn);
		valueWulgaryzmy = 1;
	}
	else
	{
		valueWulgaryzmy=0;
	}
	return valueWulgaryzmy;
}
stock PlayerTalkIC(playerid, text[], jakMowi[], Float:rangeTalk,  bool:chatBooble=true)
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
stock PlayerTalkOOC(playerid, text[], Float:rangeTalk)
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

//end