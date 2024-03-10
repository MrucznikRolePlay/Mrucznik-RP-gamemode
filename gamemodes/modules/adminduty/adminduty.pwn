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
GetPlayerAdminDutyStatus(playerid)
{
	new valueAdminStatus = GetPVarInt(playerid, "dutyadmin");
	return valueAdminStatus; 
}
AdminDutyPlayer(playerid, status)
{
	SetPVarInt(playerid, "dutyadmin", status); 
	SetPVarInt(playerid, "support_duty", status);
	new string[128];	
	if(status == 1)//Je¿eli ma wejœæ
	{
		AdminDutyTimer[playerid] = SetTimerEx("AdminDutyCzas", 60000, true, "i", playerid);
		format(string, sizeof(string), "Administrator %s wszed³ na s³u¿bê administratora!", GetNickEx(playerid));
		SendAdminMessage(COLOR_RED, string); 
		MSGBOX_Show(playerid, "Admin Duty ~g~ON", MSGBOX_ICON_TYPE_OK);	
		SetPlayerColor(playerid, 0xFF0000FF);
		firstDutyAdmin[playerid] = 1; 
		SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Stawiasz siê na s³u¿bie nowym graczom. Aby sprawdziæ zg³oszenia wpisz {00FF00}/tickets");
	}
	else//Je¿eli ma zejœæ
	{	
		SetPlayerColor(playerid, TEAM_HIT_COLOR);
		//Komunikaty
		format(string, sizeof(string), "@DUTY: Wykona³eœ ->  %d banów | %d warnów | %d kicków | %d innych akcji!", iloscBan[playerid],iloscWarn[playerid],iloscKick[playerid], (iloscInne[playerid]+iloscAJ[playerid])); 
		sendErrorMessage(playerid, string); 
		MSGBOX_Show(playerid, "Admin Duty ~r~OFF", MSGBOX_ICON_TYPE_OK);
		sendTipMessage(playerid, "Dziêkujemy za sumienn¹ s³u¿bê, administratorze!"); 	
		//Timer's kill
		KillTimer(AdminDutyTimer[playerid]);
		if(EnableZGIfNoAdmins())
			SendClientMessage(playerid, COLOR_LIGHTRED, "Poniewa¿ by³eœ ostatnim administratorem na s³u¿bie, zaufani gracze dostaj¹ uprawnienia");
	}
	return 1;
}
EnableZGIfNoAdmins() {
	new admin_count = 0;
	foreach(new i: Player) {
		if(GetPlayerAdminDutyStatus(i))
			admin_count++;
	}
	if (admin_count == 0) {
		if(!ZaufaniON) {
			ZaufaniON = true;
			foreach(new i: Player) {
				if(PlayerInfo[i][pZG])
					SendClientMessage(i, COLOR_BROWN, "¯adnego administratora nie ma na s³u¿bie. Uprawnienia ZG w³¹czone.");
			}
			return 1;
		}
	}
	return 0;
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