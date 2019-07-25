//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ panelbiznesu ]----------------------------------------------//
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

YCMD:panelbiznesu(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new pChoice[124];
		if(sscanf(params, "s[124]", pChoice))
		{
			sendTipMessage(playerid, "Wpisz /panelbiz [Choice_Name]");
			sendTipMessage(playerid, "Mo¿liwe do wyboru: Przyjmij, Zwolnij, Wp³ac, Wyp³ac"); 
			return 1;
		}
		if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
		{
			sendTipMessage(playerid, "Nie jesteœ w ¿adnym biznesie!"); 
			return 1; 
		}
		if(PlayerInfo[playerid][pBusinessOwner] == INVALID_BIZ_ID)
		{
			sendErrorMessage(playerid, "Nie jesteœ liderem biznesu"); 
			return 1;
		}
		new string[256];
		if(strcmp(pChoice, "Przyjmij",  false, 124))
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zatrudniæ w swoim biznesie.\n",
			Business[b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 1); 
		}
		else if(strcmp(pChoice, "Zwolnij", false, 124))
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zwolniæ ze swojego biznesu.\n",
			Business[b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 2); 
		}
		else if(strcmp(pChoice, "Wplac", false, 124))
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wp³aciæ\ndo swojego sejfu!",
			Business[b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 3); 
		}
		else if(strcmp(pChoice, "Wyplac", false, 124))
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wyp³aciæ\nze swojego sejfu biznesowego",
			Business[b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 4); 
		}
		else
		{
			sendErrorMessage(playerid, "Niepoprawny Choice_Name!"); 
		}
	}
	return 1;
}
