//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adminstats ]----------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

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

