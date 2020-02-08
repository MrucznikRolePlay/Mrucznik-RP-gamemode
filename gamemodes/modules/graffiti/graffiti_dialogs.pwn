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
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_ENTER_TEXT, DIALOG_STYLE_INPUT, "Graffiti", "WprowadŸ tekst(max 120 znaków)", "Dalej", "Anuluj");
}

graffiti_ShowColorMenu(playerid)
{
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_SELECT_COLOR, DIALOG_STYLE_LIST, "Graffiti", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF22}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary", "Wybierz", "Anuluj");
}
graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == GRAFFITI_DIALOG_ENTER_TEXT)
	{
		if(response)
		{
			new string[128];
			if(isnull(inputtext)) return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
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
 
                case 0: Graffiti_Color[playerid] = "000000";// CZARNY
 
                case 1: Graffiti_Color[playerid] = "FFFFFF"; // BIALY
 
                case 2: Graffiti_Color[playerid] = "F81414"; // CZERWONY
 
                case 3: Graffiti_Color[playerid] = "00FF22"; // ZIELONY
 
                case 4: Graffiti_Color[playerid] = "00CED1"; // NIEBIESKI
 
                case 5: Graffiti_Color[playerid] = "C3C3C3";  // SZARY
 
            }
			graffiti_CreateGraffiti(playerid);
		}
		else return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
	}
	//elseif dialogid select list
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
}
//end