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
	&& strfind(text, "§") == -1
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
		SetPlayerName(playerid, Odpolszcz(string));
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