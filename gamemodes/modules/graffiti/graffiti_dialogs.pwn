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
graffiti_ShowListDialog(playerid)
{
	graffiti_CountGraffs(playerid);
    graffiti_GetGraffitiIDs(playerid);
	new dialogstring[2048];
	DynamicGui_Init(playerid);
    if(Graffiti_Amount[playerid] > 0)
    {	
        new f;
        //show dialog 
		format(dialogstring, sizeof(dialogstring), "Lista twoich graffiti:\n");
		DynamicGui_AddBlankRow(playerid);
		format(dialogstring, sizeof(dialogstring), "%s--------------------------------\n");
		DynamicGui_AddBlankRow(playerid);
        for(new i; i < Graffiti_Amount[playerid]; i++)
        {	
            f = Graffiti_PlayerList[playerid][i];
			strdel(GraffitiInfo[f][grafText], 30, 128);
            format(dialogstring, sizeof(dialogstring), "%s[%d]\t%s...\n", dialogstring, f, GraffitiInfo[f][grafText]);
			DynamicGui_AddRow(playerid, f);
		}
    }
    else
    {
		format(dialogstring, sizeof(dialogstring), "Lista twoich graffiti:\n");
		DynamicGui_AddBlankRow(playerid);
        format(dialogstring, sizeof(dialogstring), "%sBrak\n", dialogstring);
		DynamicGui_AddBlankRow(playerid);
    }
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_LIST, DIALOG_STYLE_LIST, "Lista graffiti", dialogstring, "ZnajdŸ", "X");
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
	else if(dialogid == GRAFFITI_DIALOG_LIST)
	{
		if(response)
		{
			new graffiti_id = DynamicGui_GetValue(playerid, listitem);
			new Float:x,Float:y,Float:z;
			x = GraffitiInfo[graffiti_id][grafXpos];
			y = GraffitiInfo[graffiti_id][grafYpos];
			z = GraffitiInfo[graffiti_id][grafZpos];
			SetPlayerCheckpoint(playerid, x, y, z, 2);
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
}
//end