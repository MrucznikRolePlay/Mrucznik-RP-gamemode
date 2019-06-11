//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 adminduty                                                 //
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
//Opis:
/*
	Zawiera system s³u¿by administratora.
	W tym pliku dok³adnie:
		> G³ówne CMD adminduty
		> Funkcja SprawdzZnaki
		> Funkcja AdminDutyPlayer - ustawia graczu adminduty
		> Funkcja GetPlayerAdminDutyStatus - pobiera status, czy gracz jest na adminduty.
		> Timer do AdminDuty
*/
// Autor: Simeone
// Data utworzenia: 04.05.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
SprawdzZnaki(text[])
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

GetPlayerAdminDutyStatus(playerid)
{
	new valueAdminStatus = GetPVarInt(playerid, "dutyadmin");
	return valueAdminStatus; 
}
AdminDutyPlayer(playerid, status)
{
	new string[128];	
	if(status == 1)//Je¿eli ma wejœæ
	{
		AdminDutyTimer[playerid] = SetTimerEx("AdminDutyCzas", 60000, true, "i", playerid);
		format(string, sizeof(string), "Administrator %s wszed³  na s³u¿bê administratora!", GetNick(playerid));
		SendAdminMessage(COLOR_RED, string); 
		MSGBOX_Show(playerid, "Admin Duty ~g~ON", MSGBOX_ICON_TYPE_OK);	
		SetPVarInt(playerid, "dutyadmin", 1);
		SetPlayerColor(playerid, 0xFF0000FF);
		firstDutyAdmin[playerid] = 1; 
	}
	else//Je¿eli ma zejœæ
	{	
		SetPVarInt(playerid, "dutyadmin", 0); 
		SetPlayerColor(playerid,TEAM_HIT_COLOR);
		//Komunikaty
		format(string, sizeof(string), "@DUTY: Wykona³eœ ->  %d banów | %d warnów | %d kicków | %d innych akcji!", iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid], (iloscInne[playerid]+iloscAJ[playerid])); 
		sendErrorMessage(playerid, string); 
		MSGBOX_Show(playerid, "Admin Duty ~r~OFF", MSGBOX_ICON_TYPE_OK);
		sendTipMessage(playerid, "Dziêkujemy za sumienn¹ s³u¿bê, administratorze!"); 	
		//Timer's kill
		KillTimer(AdminDutyTimer[playerid]);
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


//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end