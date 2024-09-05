//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ liderpomoc ]----------------------------------------------//
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

YCMD:liderpomoc(playerid, params[], help)
{
	if (PlayerInfo[playerid][pLider] >= 1 || IsPlayerOrgLeader(playerid))
	{
		ShowPlayerDialogEx(playerid, DIALOG_LIDER01, DIALOG_STYLE_MSGBOX, "Komendy Lidera", "/przyjmij - Przyjmujesz danego gracza do swojej - rodziny/frakcji\n/zwolnij - Wyrzucasz danego gracza ze swojej - rodziny/frakcji\n/dajrange - Wystawiasz danemu graczowi range (1-6)\n/awans - Dajesz cz³onkowi frakcji/rodziny awans\n/degraduj - Degradujesz cz³onka z danej rangi na ni¿sz¹.\n/pracownicy - Pokazuje liste pracowników online\n/lidercar - zarz¹dzanie pojazdami organizacji.\n/liderranga - Zmiana nazw rang.", "Zamknij", "");
		if(PlayerInfo[playerid][pLider] == 11)
		{
			ShowPlayerDialogEx(playerid, DIALOG_LIDER02, DIALOG_STYLE_MSGBOX, "Komendy Lidera", "/podatek(/dajpodatek) - dajesz pieniadze policjantom", "Zamknij", "");
		}
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
