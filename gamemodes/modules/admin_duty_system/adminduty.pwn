//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera system admin duty stworzony na potrzeby administracji.
	W tym pliku dok³adnie:
		> G³ówne CMD adminduty
		> Funkcja SprawdzZnaki
		> Funkcja AdminDutyPlayer - ustawia graczu adminduty
		> Funkcja GetPlayerAdminDutyStatus - pobiera status, czy gracz jest na adminduty.
		> Timer do AdminDuty
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

stock SprawdzZnaki(text[])
{
	new checkAdminNameValue;
	if(strfind(text, "%") == -1 
	&& strfind(text, "_") == -1 
	&& strfind(text, " ") == -1
	&& strfind(text, "!") == -1
	&& strfind(text, "@") == -1
	&& strfind(text, "#") == -1
	&& strfind(text, "$") == -1
	&& strfind(text, "^") == -1
	&& strfind(text, "&") == -1
	&& strfind(text, "*") == -1
	&& strfind(text, "-") == -1
	&& strfind(text, "~") == -1
	&& strfind(text, "=") == -1
	&& strfind(text, "?") == -1
	&& strfind(text, ",") == -1
	&& strfind(text, ".") == -1
	&& strfind(text, "<") == -1
	&& strfind(text, ">") == -1
	&& strfind(text, ")") == -1
	&& strfind(text, "(") == -1
	&& strfind(text, "]") == -1
	&& strfind(text, "[") == -1
	&& strfind(text, "XD") == -1
	&& strfind(text, "}") == -1
	&& strfind(text, "{") == -1
	&& strfind(text, ":") == -1 
	&& strfind(text, "`") == -1 
	&& strfind(text, "/") == -1
	&& strfind(text, "|") == -1

	&& strfind(text, "kurwa") == -1
	&& strfind(text, "jebaæ") == -1
	&& strfind(text, "jebac") == -1
	&& strfind(text, "huj") == -1
	&& strfind(text, "cipa") == -1
	&& strfind(text, "kutas") == -1
	&& strfind(text, "chuj") == -1
	&& strfind(text, "69") == -1//Zabezpieczenie Anty-Jupik
	&& strfind(text, "¹") == -1
	&& strfind(text, "œ") == -1
	&& strfind(text, "¿") == -1
	&& strfind(text, "Ÿ") == -1
	&& strfind(text, "æ") == -1
	&& strfind(text, "ê") == -1
	&& strfind(text, "ñ") == -1
	&& strfind(text, "ó") == -1
	&& strfind(text, "+") == -1)
	{
		checkAdminNameValue = 0;
	}
	else
	{
		checkAdminNameValue = 1;
	}
	return checkAdminNameValue; 
}

stock GetPlayerAdminDutyStatus(playerid)
{
	new valueAdminStatus = GetPVarInt(playerid, "dutyadmin");
	return valueAdminStatus; 
}
stock AdminDutyPlayer(playerid, status)
{
	new string[128];
	GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
	GetPVarString(playerid, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname)); 
	new stringlog[325];//String do logu
	new y1,mi1,d1;//Data
	
	if(status == 1)//Je¿eli ma wejœæ
	{
		AdminDutyTimer[playerid] = SetTimerEx("AdminDutyCzas", 60000, true, "i", playerid);
		format(string, sizeof(string), "Administrator %s [%s] wszed³  na s³u¿bê administratora!", AdminName,FirstNickname);
		SendAdminMessage(COLOR_RED, string); 
		MSGBOX_Show(playerid, "Admin Duty ~g~ON", MSGBOX_ICON_TYPE_OK);	
		format(string, sizeof(string), "%s", AdminName); 
		SetPlayerName(playerid, string);
		SetPVarInt(playerid, "dutyadmin", 1);
		SetPlayerColor(playerid, 0xFF0000FF);
	
	}
	else//Je¿eli ma zejœæ
	{	
		GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
		GetPVarString(playerid, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname)); 
		format(string, sizeof(string), "%s", FirstNickname);
		SetPlayerName(playerid, string); 
		SetPVarInt(playerid, "dutyadmin", 0); 
		SetPlayerColor(playerid,TEAM_HIT_COLOR);
		
		//Komunikaty
		format(string, sizeof(string), "@DUTY: Wykona³eœ ->  %d banów | %d warnów | %d kicków | %d innych akcji!", iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid], iloscInne[playerid]); 
		sendErrorMessage(playerid, string); 
		MSGBOX_Show(playerid, "Admin Duty ~r~OFF", MSGBOX_ICON_TYPE_OK);
		sendTipMessage(playerid, "Dziêkujemy za sumienn¹ s³u¿bê, administratorze!"); 
		
		//LOG
		getdate(y1, mi1, d1); 
		format(stringlog, sizeof(stringlog), "[%d:%d:%d] Admin %s [%s] zakonczyl sluzbe - wykonal w czasie %d:%d [B%d/W%d/K%d/I%d] - gra dalej", d1, mi1, y1, FirstNickname, AdminName, AdminDutyGodziny[playerid], AdminDutyMinuty[playerid],iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid],iloscInne[playerid]); //GENERATE LOG
		AdminDutyLog(stringlog); //Create LOG
		
		//Log dla 0Verte [UID] [RRRR-MM-DD] [HH:mm] [Bany] [Warny] [AJ] [Kicki] [Inne] [Reporty+zapytania] [/w] [/w2] [powod zakoñczenia s³u¿by]
		format(stringlog, sizeof(stringlog), "%d %d-%d-%d %d:%d %d %d %d %d %d %d %d %d /AdminDuty(2x)", PlayerInfo[playerid][pUID], y1,mi1,d1, AdminDutyGodziny[playerid], AdminDutyMinuty[playerid], iloscBan[playerid], iloscWarn[playerid], iloscAJ[playerid], iloscKick[playerid], iloscInne[playerid], iloscZapytaj[playerid], iloscInWiadomosci[playerid], iloscOutWiadomosci[playerid]);
		AdminDutyMaszLog(stringlog);
		
		//Zerowanie zmiennych - po zejœciu z duty admina :) 
		iloscKick[playerid] = 0;
		iloscWarn[playerid] = 0;
		iloscBan[playerid] = 0;
		iloscInne[playerid] = 0;
		iloscAJ[playerid] = 0;
		iloscInWiadomosci[playerid] = 0;
		iloscOutWiadomosci[playerid] = 0;
		iloscZapytaj[playerid] = 0;
		
		//Timer's kill
		KillTimer(AdminDutyTimer[playerid]);
		AdminDutyGodziny[playerid] = 0;
		AdminDutyMinuty[playerid] = 0;
	
	}

	return 1;
}


//-----------------<[ Komendy: ]>-------------------
CMD:adminduty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
	
		new adminMaWolnyNick = 0;
		
		SetPVarString(playerid, "pAdminDutyNickOn", params);

		
		
		if(GetPlayerAdminDutyStatus(playerid) == 0)
		{
			if(isnull(params))
			{
				sendTipMessage(playerid, "U¿yj /adminduty [NICK 4UM]");
				return 1;
			}
			if(OnDuty[playerid] == 1 || JobDuty[playerid] == 1 || SanDuty[playerid] == 1)//Zabezpieczenie przed duty - odkryte w doœæ ciekawy sposób, dlatego traktujemy jako easter egg
			{
				sendTipMessage(playerid, "Najpierw zejdŸ z duty! Powodujesz bugi, które muszê naprawiaæ!");
				return 1;
			}
			else
			{
				if(strlen(params) < MAX_PLAYER_NAME)//Maksymalnie 32 znaki nicku
				{
					if(strlen(params) >= MIN_ADMIN_NAME)//Minimalnie 3 znaki
					{
						//Symbole i znaki specjalne
						if(SprawdzZnaki(params) ==  0)
						{
							foreach(Player, i)
							{
								if(strfind(GetNick(i), AdminName, true) != -1)
								{
									if(GetPVarInt(i, "dutyadmin") == 1)
									{
										adminMaWolnyNick = 1;
									}
								}
							}
							if(adminMaWolnyNick == 0)
							{
								AdminDutyPlayer(playerid, 1);
							}
							else
							{
								sendErrorMessage(playerid, "Ten nick jest ju¿ zajêty!");
								return 1;
							}
							
						}	
						else
						{
							sendErrorMessage(playerid, "U¿y³eœ nieprawid³owych znaków!"); 
							MSGBOX_Show(playerid, "Zle znaki!", MSGBOX_ICON_TYPE_ERROR);
							return 1;
						}
					}	
					else
					{
						sendErrorMessage(playerid, "Minimalna d³ugoœæ nicku to 3 znaki!"); 
						return 1;
					}
						
				}
				else
				{
					sendErrorMessage(playerid, "Maksymalna d³ugoœæ nicku to 32 znaki!"); 
					return 1;
				}
			}
				
			return 1;	
		}
		else if(GetPlayerAdminDutyStatus(playerid) == 1)//Wykonuje zejœcie z duty
		{	
			AdminDutyPlayer(playerid, 0); 
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ administratorem, wiêc nie mo¿esz tego u¿yæ!"); 
		MSGBOX_Show(playerid, "Nie masz uprawnien!", MSGBOX_ICON_TYPE_ERROR);
		return 1; 
	}

	return 1; 
}

CMD:adminstats(playerid)
{
	if(PlayerInfo[playerid][pAdmin] >= 1 )
	{
		new string[325];
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
			GetPVarString(playerid, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname)); 
			format(string, sizeof(string), "{C0C0C0}Statystyki\n{800080}Nick administratora:{C0C0C0}%s\n{800080}Nick IC: {C0C0C0}%s\n{800080}Nadane Bany: {C0C0C0}%d\n{800080}Nadane Warny: {C0C0C0}%d\n{800080}Nadane Kicki: {C0C0C0}%d\n{800080}Inne akcje: {C0C0C0}%d\n\n{C2A2DA}Na s³u¿bie ju¿: {C0C0C0}%d godzin i %d minut", AdminName, FirstNickname,iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid],iloscInne[playerid],AdminDutyGodziny[playerid], AdminDutyMinuty[playerid]);
			ShowPlayerDialogEx(playerid, 1091, DIALOG_STYLE_MSGBOX, "System @DUTY", string, "Okej", "");
			
		
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ podczas s³u¿by administratora!"); 
		}
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

CMD:checkadminstats(playerid, params[])
{
	new SenderAdminName[MAX_PLAYER_NAME];
	new FirstSenderAdminName[MAX_PLAYER_NAME];
	new string[325];
	new giveplayerid;
	if(sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U¿yj /checkadminstats [ID]");
		return 1;
	}
	if(PlayerInfo[playerid][pAdmin] >= 1000) 
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pNewAP] >= 1)
			{
				if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
				{
					
					GetPVarString(giveplayerid, "pAdminDutyNickOn", SenderAdminName, sizeof(SenderAdminName)); 
					GetPVarString(giveplayerid, "pAdminDutyNickOff", FirstSenderAdminName, sizeof(FirstSenderAdminName)); 
					
					format(string, sizeof(string), "{C0C0C0}Statystyki\n{800080}Nick administratora:{C0C0C0}%s\n{800080}Nick IC: {C0C0C0}%s\n{800080}Nadane Bany: {C0C0C0}%d\n{800080}Nadane Warny: {C0C0C0}%d\n{800080}Nadane Kicki: {C0C0C0}%d\n{800080}Inne akcje: {C0C0C0}%d\n\n{C2A2DA}Na s³u¿bie ju¿: {C0C0C0}%d godzin i %d minut", SenderAdminName, FirstSenderAdminName,iloscBan[giveplayerid],iloscWarn[giveplayerid],iloscKick[giveplayerid],iloscInne[giveplayerid],AdminDutyGodziny[giveplayerid], AdminDutyMinuty[giveplayerid]);
					ShowPlayerDialogEx(playerid, 1091, DIALOG_STYLE_MSGBOX, "System @DUTY", string, "Okej", "");
					return 1;
				}
				else
				{
					format(string, sizeof(string), "Gracz %s nie jest podczas s³u¿by!", GetNick(giveplayerid));
					sendErrorMessage(playerid, string); 
					return 1;
				}
			}
			else
			{
				format(string, sizeof(string), "Gracz %s nie jest administratorem!", GetNick(giveplayerid));
				sendErrorMessage(playerid, string); 
				return 1;
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
		noAccessMessage(playerid);
	}

	return 1;
}









//-----------------<[ Timery: ]>-------------------

forward AdminDutyCzas(playerid);
public AdminDutyCzas(playerid)
{
	AdminDutyMinuty[playerid]++;
	if(AdminDutyMinuty[playerid] == 60)
	{
		AdminDutyGodziny[playerid]++;
		AdminDutyMinuty[playerid] = 0;
	
	}
	return 1;
}
//end