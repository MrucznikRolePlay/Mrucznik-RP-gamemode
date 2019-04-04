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
stock CheckSpamEmoji(const text[], const akcjaEmoji[], const szukanaEmoji[], lenghtStr=2, bool:ignorecase=true)
{
	new emojiMessFix[256];
	strcat(emojiMessFix, text);
	if(strfind(emojiMessFix, szukanaEmoji, ignorecase) != -1)
	{
		new pos = strfind(emojiMessFix, szukanaEmoji, ignorecase); 
		new posA = strfind(emojiMessFix, " ", false, pos);

		//Je¿eli emotka jest wed³ug strfind - np. xD
		if(strfind(emojiMessFix, " ", false, pos) == -1)
		{
			strdel(emojiMessFix, pos, pos+lenghtStr);
			strins(emojiMessFix, akcjaEmoji, pos); 
			return emojiMessFix;
		}
		
		///Je¿eli emotka jest d³u¿sza - np XDDDD
		strdel(emojiMessFix, pos, posA);
		strins(emojiMessFix, akcjaEmoji, pos);
	}
	new strEmoji[256];
	strcat(strEmoji, emojiMessFix);
	return strEmoji; 
}
stock CheckEmoji(const text[])
{
	new emojiMessFix[256];
	strcat(emojiMessFix, text); 
	new strEmoji[256];


	regex_replace(emojiMessFix, regex_set(":{1}D{1,}"), "{C2A2DA}**Uœmiecha siê**{FFFFFF}", strEmoji, MATCH_DEFAULT, sizeof(strEmoji));
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Wystawia jêzyk**{FFFFFF}", ":P", 2,  true);
	/*
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Puszcza oczko**{FFFFFF}", ";)", 2, false);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Uœmiecha siê i puszcza oczko**{FFFFFF}",  ";D", 2, false);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Wystawia jêzyk i puszcza oczko**{FFFFFF}", ";d", 2, false);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Robi g³upi¹ minê**{FFFFFF}", "xD", 2,  true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Unosi jedn¹ brew do góry**{FFFFFF}", "o_O", 3, true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Uœmiecha siê**{FFFFFF}", ":)", 2, false);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Smuci siê**{FFFFFF}",  ":(", 2, false);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Otwiera usta szeroko**{FFFFFF}", ":O", 2,  true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Robi buŸkê**{FFFFFF}",  ":*", 2, true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**K³apie dziobem**{FFFFFF}", ":v", 2,  true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Krzywi siê**{FFFFFF}", ":s", 2, true);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Robi minê ala funia**{FFFFFF}", ":3", 2);
	
	CheckSpamEmoji(emojiMessFix, "{C2A2DA}**Robi okularki z d³oni**{FFFFFF}",  "o.o", 3, true);*/
	
	return strEmoji;
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

//-----------------<[ Komendy: ]>-------------------
CMD:sprawdzgwiazdki(playerid, params[])
{
	if(isnull(params))
	{
		sendTipMessage(playerid, "U¿yj /sprawdzgwiazdki [text]");
		return 1;
	}
	new string[256];
	format(string, sizeof(string), "%s mówi: %s", GetNick(playerid, true), params);
	SendClientMessage(playerid, -1, CheckStars(string));
	return 1;
}
CMD:news(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    new newcar = GetPlayerVehicleID(playerid);
	        if(PlayerInfo[playerid][pMuted] == 1)
			{
				sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ poniewa¿ zosta³eœ wyciszony");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ /news podczas s³u¿by administratora!"); 
				return 1;
			}

            new bool:inpos=false;
            for(new i=0;i<MAX_VEHICLES;i++)
            {
                if(Car_GetOwner(i) == FRAC_SN && Car_GetOwnerType(i) == CAR_OWNER_FRACTION)
                {
                    if(newcar == i)
                    {
                        inpos=true;
                        break;
                    }
                }
            }

			if(inpos ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 676.9533,-1339.5132,30.3588) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 660.1057,-1339.6501,29.3712) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 655.8636,-1377.5455,28.4672) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 652.1369,-1367.9576,28.5072) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 651.2371,-1367.7997,28.5072) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 667.8975,-1380.4872,28.4672))
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					CzitLog(string);
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					format(string, sizeof(string), "NR %s: %s", sendername, params);
					OOCNews(COLOR_NEWS,string);
                    //OOCNews(0xFF8C55FF, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			}
			else if(PlayerToPoint(10.5, playerid, 1820.0637,-1315.9836,109.9520))
			{
            	GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					CzitLog(string);
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					format(string, sizeof(string), "NR %s: %s", sendername, params);
					//OOCNews(COLOR_NEWS,string);
                    OOCNews(COLOR_NEWS, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			}
			else if(GetPLocal(playerid) == PLOCAL_ORG_SN)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					CzitLog(string);
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					format(string, sizeof(string), "NR %s: %s", sendername, params);
					//OOCNews(COLOR_NEWS,string);
                    OOCNews(COLOR_NEWS, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w wozie SAN News !");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Reporterem !");
		}
	}//not connected
	return 1;
}


CMD:live(playerid, params[]) return cmd_nazywo(playerid, params);
CMD:wywiad(playerid, params[]) return cmd_nazywo(playerid, params);
CMD:nazywo(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    if(TalkingLive[playerid] != INVALID_PLAYER_ID)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wywiad zakonczony.");
		        SendClientMessage(TalkingLive[playerid], COLOR_LIGHTBLUE, "* Wywiad zakoñczony.");
	            TalkingLive[TalkingLive[playerid]] = INVALID_PLAYER_ID;
                TalkingLive[playerid] = INVALID_PLAYER_ID;
		        return 1;
		    }
			
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /wywiad [playerid/CzêœæNicku]");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Nie mo¿esz dawaæ wywiadu podczas @Duty!");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
			{
				sendErrorMessage(playerid, "Ta osoba jest podczas s³u¿by administratora!");
				return 1;
			}


			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid) || Mobile[playerid] == giveplayerid)
					{
					    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_GREY, "Nie mo¿esz robiæ wywiadu z samym sob¹!"); return 1; }
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Oferujesz %s wywiad na ¿ywo.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s chce z tob¹ przeprowadziæ wywiad, wpisz (/akceptuj wywiad) aby akceptowaæ.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						LiveOffer[giveplayerid] = playerid;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Jesteœ za daleko od tego gracza.");
					    sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz przeprowadziæ wywiad telefoniczny dzwoni¹c do gracza i oferuj¹c mu wywiad komend¹ /wywiad.");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza!");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Reporterem !");
		}
	}
	return 1;
}
CMD:family(playerid, params[]) return cmd_rodzinny(playerid, params);
CMD:f(playerid, params[]) return cmd_rodzinny(playerid, params);
CMD:rodzinny(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /fo [treœæ]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/f)amily [tekst]");
			return 1;
		}
        if (GetPlayerOrg(playerid) != 0 || MozeMowicNaFamily(playerid) || PlayerInfo[playerid][pTajniak] >= 1)
		{
            new member = GetPlayerFraction(playerid);
		    if(member>0 && PlayerInfo[playerid][pTajniak] == 0)
		    {
                format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],sendername, params);
    			SendFamilyMessage(member, TEAM_AZTECAS_COLOR, string);

                //Tajniacy
                if(member == 5) SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
                else if(member == 6) SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
                else if(member == 12) SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
                else if(13 <= member <= 14) SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
            }
            else if(PlayerInfo[playerid][pTajniak] == 1)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_GROOVE][PlayerInfo[playerid][pRank]],sendername, params);
                SendFamilyMessage(FRAC_GROOVE, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 2)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_BALLAS][PlayerInfo[playerid][pRank]],sendername, params);
                SendFamilyMessage(FRAC_BALLAS, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 3)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_LCN][PlayerInfo[playerid][pRank]],sendername, params);
                SendFamilyMessage(FRAC_LCN, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 4)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_YKZ][PlayerInfo[playerid][pRank]],sendername, params);
                SendFamilyMessage(FRAC_YKZ, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 5)
			{
                format(string, sizeof(string), "** %s %s: %s **", FracRang[FRAC_VAGOS][PlayerInfo[playerid][pRank]],sendername, params);
                SendFamilyMessage(FRAC_VAGOS, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(5, TEAM_AZTECAS_COLOR, string);
			}
			else if(GetPlayerOrg(playerid) != 0)
		    {
                member = GetPlayerOrg(playerid);
                //Przypisane rangi
                if(strlen(FamRang[member][PlayerInfo[playerid][pRank]]) > 1) format(string, sizeof(string), "** %s %s: %s **", FamRang[member][PlayerInfo[playerid][pRank]],sendername, params);
                //Rangi podstawowe
                else format(string, sizeof(string), "** %s %s: %s **", FamRang[0][PlayerInfo[playerid][pRank]],sendername, params);
				SendNewFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
			}
            format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
			printf("%s", string);
			return 1;
		}
        else if(GetPlayerFraction(playerid) == FRAC_GOV || GetPlayerFraction(playerid) == FRAC_BOR|| GetPlayerOrg(playerid) == 1) //DMV i BOR po³aczenie + S¹d
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],sendername, params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
			SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            printf("%s", string);
			
			format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "%s mówi przez radio: %s", sendername, params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
      /*  else if(GetPlayerFraction(playerid) == FRAC_BOR)
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],sendername, params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
            SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            printf("%s", string);
        }*/
		else
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ we frakcji!");
			return 1;
		}
	}//not connected
	return 1;
}

CMD:familyooc(playerid, params[]) return cmd_fooc(playerid, params);
CMD:fo(playerid, params[]) return cmd_fooc(playerid, params);
CMD:rodzinnyooc(playerid, params[]) return cmd_fooc(playerid, params);
CMD:fooc(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    /*if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}*/
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/fo)oc [tekst]");
			return 1;
		}
		if (GetPlayerOrg(playerid) != 0 || MozeMowicNaFamily(playerid) || PlayerInfo[playerid][pTajniak] >= 1)
		{
		    new member = GetPlayerFraction(playerid);
            if(member > 0 && PlayerInfo[playerid][pTajniak] == 0)
            {
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
    			SendFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
                //Tajniacy
                if(member == 5) SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
                else if(member == 6) SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
                else if(member == 12) SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
                else if(13 <= member <= 14) SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
            }
			else if(PlayerInfo[playerid][pTajniak] == 1)
			{
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[FRAC_GROOVE][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendFamilyMessage(FRAC_GROOVE, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(1, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 2)
			{
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[FRAC_BALLAS][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendFamilyMessage(FRAC_BALLAS, TEAM_AZTECAS_COLOR, string);
                SendTajniakMessage(2, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 3)
			{
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[FRAC_LCN][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendFamilyMessage(FRAC_LCN, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(3, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 4)
			{
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[FRAC_YKZ][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendFamilyMessage(FRAC_YKZ, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(4, TEAM_AZTECAS_COLOR, string);
			}
			else if(PlayerInfo[playerid][pTajniak] == 5)
			{
                format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[FRAC_VAGOS][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendFamilyMessage(FRAC_VAGOS, TEAM_AZTECAS_COLOR, string);
				SendTajniakMessage(5, TEAM_AZTECAS_COLOR, string);
			}
			else if(GetPlayerOrg(playerid) != 0)
		    {
                member = GetPlayerOrg(playerid);
                //Przypisane rangi
                if(strlen(FamRang[member][PlayerInfo[playerid][pRank]]) > 1) format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FamRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                //Rangi podstawowe
                else format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FamRang[0][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
                SendNewFamilyMessage(member, TEAM_AZTECAS_COLOR, string);
			}
			printf("%s", string);
			return 1;
		}
        else if(GetPlayerFraction(playerid) == FRAC_GOV || GetPlayerFraction(playerid) == FRAC_BOR|| GetPlayerOrg(playerid) == 1) //DMV i BOR po³aczenie
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
			SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            printf("%s", string);
        }
       /* else if(GetPlayerFraction(playerid) == FRAC_BOR) //DMV i BOR po³aczenie
        {
            new member = GetPlayerFraction(playerid);
            format(string, sizeof(string), "** (( %s [%d] %s: %s. )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], sendername, params);
    		SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
            SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            printf("%s", string);
        }*/
		else
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ we frakcji!");
			return 1;
		}
	}
	return 1;
}
CMD:radio(playerid, params[]) return cmd_r(playerid, params);
CMD:r(playerid, params[])
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/r)adio [tekst]");
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /ro [treœæ]");
			return 1;
		}
        new member = GetPlayerFraction(playerid);
        if(0 < member <= 4 || member == 11 || member == 7 || member == 17)
	    {
            format(string, sizeof(string), "** %s %s: %s **", FracRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid, true), params);
            SendRadioMessage(member, TEAM_BLUE_COLOR, string);
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid, true), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            printf("%s", string);
			format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
        else if(GetPlayerOrg(playerid) == FAMILY_SAD) //SAD i BOR po³aczenie+DMV
        {
            member = GetPlayerOrg(playerid);
            format(string, sizeof(string), "** %s %s: %s **", FamRang[member][PlayerInfo[playerid][pRank]],GetNick(playerid, true), params);
            SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
			SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string); 
            SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid, true), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            printf("%s", string);
            format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
        }
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
	}
	return 1;
}

CMD:radioooc(playerid, params[]) return cmd_rooc(playerid, params);
CMD:ro(playerid, params[]) return cmd_rooc(playerid, params);
CMD:rooc(playerid, params[])
{
	new string[256];
	
	GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/r)adio [tekst]");
			return 1;
		}
        new member = GetPlayerFraction(playerid);
	    if(0 < member <= 4 || member == 11 || member == 7 || member == 17)
	    {
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank],AdminName, params);
				SendRadioMessage(member, TEAM_BLUE_COLOR, string);
				printf("%s", string);
				
			}
			else
			{
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank],GetNick(playerid, true), params);
				SendRadioMessage(member, TEAM_BLUE_COLOR, string);
				printf("%s", string);
			
			}
        }
        else if(GetPlayerOrg(playerid) == FAMILY_SAD) //SAD i BOR po³aczenie + DMV
        {
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				member = GetPlayerOrg(playerid);
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FamRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], AdminName, params);
				SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
				SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
				SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string); 
				printf("%s", string);
				
			}
			else
			{
				member = GetPlayerOrg(playerid);
				format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FamRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank], GetNick(playerid, true), params);
				SendFamilyMessage(FRAC_BOR, TEAM_AZTECAS_COLOR, string);
				SendNewFamilyMessage(FAMILY_SAD, TEAM_BLUE_COLOR, string);
				SendFamilyMessage(FRAC_GOV, TEAM_AZTECAS_COLOR, string); 
				printf("%s", string);
			
			}
        }
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
	}
	return 1;
}
CMD:advertise(playerid, params[]) return cmd_og(playerid, params);
CMD:ad(playerid, params[]) return cmd_og(playerid, params);
CMD:ogloszenie(playerid, params[]) return cmd_og(playerid, params);
CMD:og(playerid, params[])
{
    new string[256];
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ zalogowany!");
            return 1;
        }
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo¿esz pisaæ og³oszeñ podczas s³u¿by administratora!"); 
			return 1;
		}
        if(PlayerInfo[playerid][pPnumber] == 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie masz telefonu. Kup go w 24/7 !");
            return 1;
        }
        if(isnull(params))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: (/og)loszenie [tekst og³oszenia]");
            return 1;
        }
		if(sprawdzReklame(params, playerid) == 1)
		{
			return 1;
		}
		if(sprawdzWulgaryzmy(params, playerid) == 1)
		{
		
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
			return 1;
		}
		if ((!adds) && PlayerInfo[playerid][pDonateRank] < 2 && PlayerInfo[playerid][pAdmin] < 10)
		{
			format(string, sizeof(string), "Spróbuj póŸniej, %d sekund miêdzy og³oszeniami !",  (addtimer/1000));
			SendClientMessage(playerid, COLOR_GRAD2, string);
			return 1;
		}
		new payout = strlen(params) * 25;
		if(kaska[playerid] < payout)
		{
			format(string, sizeof(string), "* U¿y³eœ %d znaków i masz zap³aciæ $%d, nie posiadasz a¿ tyle.", strlen(params), payout);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			return 1;
		}
		DajKase(playerid, - payout);
		format(string, sizeof(string), "Og³oszenie: %s, Kontakt: %s Tel: %d",  params, GetNick(playerid, true), PlayerInfo[playerid][pPnumber]);
		OOCNews(TEAM_GROVE_COLOR,string);
		format(string, sizeof(string), "~r~Zaplaciles $%d~n~~w~Za: %d Znakow", payout, strlen(params));
		GameTextForPlayer(playerid, string, 5000, 5);
		if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pDonateRank] < 2)
		{
			SetTimer("AddsOn", addtimer, 0);adds = 0;
		}
        
    }
    return 1;
}
CMD:local(playerid, params[]) return cmd_say(playerid, params);
CMD:l(playerid, params[]) return cmd_say(playerid, params);
CMD:say(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 0)
		{
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Jesteœ uciszony! Nie mo¿esz mówiæ"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(l)ocal [tekst]");
			return 1;
		}
		
		PlayerTalkIC(playerid, params, "mówi", 8.0,  true); 		
	}

	return 1;
}
CMD:krzyk(playerid, params[]) return cmd_k(playerid, params);
CMD:k(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 0)
		{
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Jesteœ uciszony! Nie mo¿esz mówiæ"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(k) krzycz [tekst]");
			return 1;
		}
		
		PlayerTalkIC(playerid, params, "krzyczy", 15.0, true); 		
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
		ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:cicho(playerid, params[]) return cmd_szept(playerid, params);
CMD:s(playerid, params[]) return cmd_szept(playerid, params);
CMD:szept(playerid, params[])
{
	
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 0)
		{
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Jesteœ uciszony! Nie mo¿esz mówiæ"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /(l)ocal [tekst]");
			return 1;
		}
		
		PlayerTalkIC(playerid, params, "szepcze", 5.0,  true); 		
	}
	return 1;
}

CMD:b(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /b [CZAT OOC]");
			return 1;
		}
		PlayerTalkOOC(playerid, params, 25.0);

        
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