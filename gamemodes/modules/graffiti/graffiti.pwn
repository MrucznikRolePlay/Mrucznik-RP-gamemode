//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  graffiti                                                 //
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
// Autor: Sanda³
// Data utworzenia: 01.02.2020
//Opis:
/*
	System graffiti
*/

//
#include <YSI\y_hooks>
#include "graffiti_dialogs.pwn"
hook OnPlayerConnect(playerid)
{
    graffiti_ZerujZmienne(playerid);
}
//-----------------<[ Funkcje: ]>-------------------
graffiti_ZerujZmienne(playerid)
{
	Graffiti_Color[playerid] = -1;
	Graffiti_Text[playerid] = "";
}

graffiti_ShowCreationDialog(playerid)
{
	ShowPlayerDialog(playerid, GRAFFITI_DIALOG_ENTER_TEXT, DIALOG_STYLE_INPUT, "Graffiti", "WprowadŸ tekst(max 120 znaków)", "Dalej", "Anuluj");
}

graffiti_ShowColorMenu(playerid)
{
	ShowPlayerDialog(playerid, GRAFFITI_DIALOG_SELECT_COLOR, DIALOG_STYLE_LIST, "Graffiti", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF22}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary", "Wybierz", "Anuluj");
}
//end