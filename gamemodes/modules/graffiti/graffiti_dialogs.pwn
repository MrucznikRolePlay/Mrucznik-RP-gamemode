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

//-----------------<[ Funkcje: ]>-------------------
graffiti_ShowCreationDialog(playerid)
{
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_ENTER_TEXT, DIALOG_STYLE_INPUT, "Graffiti", "\tWprowadŸ tekst(max 120 znaków)\n\nZachêcamy do zajrzenia w poradnik na forum dot. tworzenia graffiti!", "Dalej", "Anuluj");
}

graffiti_ShowColorMenu(playerid)
{
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_SELECT_COLOR, DIALOG_STYLE_LIST, "Wybierz podstawowy kolor", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF00}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary\n{E87E15}Pomarañczowy\n{FFE100}¯ó³ty\n{8400FF}Fioletowy\n{EE00FF}Ró¿owy", "Wybierz", "Anuluj");
}
graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == GRAFFITI_DIALOG_ENTER_TEXT)
	{
		if(response)
		{
			new string[128];
			if(isnull(inputtext)) return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
			if(strfind(inputtext, "\n") != -1) return GameTextForPlayer(playerid, "~r~Zakazane znaki!",2000, 5);
			format(string, sizeof(string), "%s", inputtext);
			Graffiti_Text[playerid] = string;
			graffiti_ShowColorMenu(playerid);
		}
		else return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
	}
	else if(dialogid == GRAFFITI_DIALOG_SELECT_COLOR)
	{
		if(response)
		{
			switch(listitem)
            {
 
                case 0: Graffiti_Color[playerid] = 0;
 
                case 1: Graffiti_Color[playerid] = 1;
 
                case 2: Graffiti_Color[playerid] = 2;
 
                case 3: Graffiti_Color[playerid] = 3;
 
                case 4: Graffiti_Color[playerid] = 4;
 
                case 5: Graffiti_Color[playerid] = 5;

				case 6: Graffiti_Color[playerid] = 6;

				case 7: Graffiti_Color[playerid] = 7;

				case 8: Graffiti_Color[playerid] = 8;

				case 9: Graffiti_Color[playerid] = 9;
 
            }
			graffiti_CreateGraffiti(playerid);
		}
		else return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
}
//end