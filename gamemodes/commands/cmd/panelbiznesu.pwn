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
	Komenda pozwalaj¹ca wykorzystaæ potencja³ swojego biznesu. Mo¿na przyj¹æ b¹dŸ zwolniæ pracownika (cz³onka),
	a tak¿e wp³aciæ b¹dŸ wyp³aciæ pieni¹dze z sejfu biznesu. 
*/


// Notatki skryptera:
/*
Komenda wywo³uj¹ca dialogi	
*/

YCMD:panelbiznesu(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new pChoice[32];
        new giveplayerid=-1;
        if( sscanf(params, "s[32]R(0)", pChoice, giveplayerid))
        {
            SendClientMessage(playerid, COLOR_WHITE, "|_____________ Business Panel _______________|");
            SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: /panelbiz [nazwa]");
            SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Przyjmij, Zwolnij, Wplac, Wyplac");
            SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
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
		if(strcmp(pChoice, "Przyjmij", false) == 0)
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zatrudniæ w swoim biznesie.\n",
			Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 1); 
		}
		else if(strcmp(pChoice, "Zwolnij", false) == 0)
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zwolniæ ze swojego biznesu.\n",
			Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 2); 
		}
		else if(strcmp(pChoice, "Wplac", false) == 0)
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wp³aciæ\ndo swojego sejfu!",
			Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
			ShowPlayerDialogEx(playerid, DIALOG_PANEL_BIZ, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
			SetPVarInt(playerid, "bizWhatToDo", 3); 
		}
		else if(strcmp(pChoice, "Wyplac", false) == 0)
		{
			format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wyp³aciæ\nze swojego sejfu biznesowego",
			Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
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
