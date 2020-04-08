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
graffiti_ShowEditTextDialog(playerid, f)
{
	SetPVarInt(playerid, "GraffitiEDIT", f);
	ShowPlayerDialogEx(playerid, 1254, DIALOG_STYLE_INPUT, "Graffiti", "WprowadŸ tekst(max 120 znaków)\n\nZachêcamy do zajrzenia w poradnik na forum dot. tworzenia graffiti!", "Dalej", "Anuluj");
}
graffiti_ShowEditColorDialog(playerid)
{
	ShowPlayerDialogEx(playerid, 1253, DIALOG_STYLE_LIST, "Wybierz podstawowy kolor", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF00}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary\n{E87E15}Pomarañczowy\n{FFE100}¯ó³ty\n{8400FF}Fioletowy\n{EE00FF}Ró¿owy", "Wybierz", "Anuluj");
}
graffiti_ShowCreationDialog(playerid)
{
	ShowPlayerDialogEx(playerid, 1251, DIALOG_STYLE_INPUT, "Graffiti", "WprowadŸ tekst(max 120 znaków)\n\nZachêcamy do zajrzenia w poradnik na forum dot. tworzenia graffiti!", "Dalej", "Anuluj");
}
graffiti_ShowListDialog(playerid)
{
	DynamicGui_Init(playerid);
	graffiti_CountGraffs(playerid);
    graffiti_GetGraffitiIDs(playerid);
	new dialogstring[2048];
    if(Graffiti_Amount[playerid] > 0)
    {	
        new f, licznik = 1;
        for(new i; i < Graffiti_Amount[playerid]; i++)
        {	
            f = Graffiti_PlayerList[playerid][i];
			strdel(GraffitiInfo[f][grafText], 30, 128);
			strreplace(GraffitiInfo[f][grafText], "\n", "~n~", .ignorecase = true);
            format(dialogstring, sizeof(dialogstring), "%s{FAF000}[%d]»\t{FFFFFF}%s...\n", dialogstring, licznik, GraffitiInfo[f][grafText]);
			DynamicGui_AddRow(playerid, f, 1);
			licznik++;
		}
    }
    else
    {
        format(dialogstring, sizeof(dialogstring), "%s{FF0000}Brak!\n", dialogstring);
		DynamicGui_AddBlankRow(playerid);
    }
	ShowPlayerDialogEx(playerid, 1250, DIALOG_STYLE_LIST, "Lista graffiti", dialogstring, "ZnajdŸ", "X");
}

graffiti_ShowColorMenu(playerid)
{
	ShowPlayerDialogEx(playerid, 1252, DIALOG_STYLE_LIST, "Wybierz podstawowy kolor", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF00}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary\n{E87E15}Pomarañczowy\n{FFE100}¯ó³ty\n{8400FF}Fioletowy\n{EE00FF}Ró¿owy", "Wybierz", "Anuluj");
}

graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1250)
	{
		if(response)
		{
			new graffiti_id = DynamicGui_GetValue(playerid, listitem);
			new graffiti_existing = DynamicGui_GetDataInt(playerid, listitem);
			new Float:x,Float:y,Float:z;
			x = GraffitiInfo[graffiti_id][grafXpos];
			y = GraffitiInfo[graffiti_id][grafYpos];
			z = GraffitiInfo[graffiti_id][grafZpos];
			if(graffiti_existing == 1) SetPlayerCheckpoint(playerid, x, y, z, 2);
			sendTipMessage(playerid, "Stworzono znacznik gdzie to graffiti siê znajduje.");
			return 1;
		}
	}
	else if(dialogid == 1251)
	{
		if(response)
		{
			new string[128];
			if(isnull(inputtext)) 
			{
				DeletePVar(playerid, "GraffitiEDIT");
				return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
			}
			format(string, sizeof(string), "%s", inputtext);
			Graffiti_Text[playerid] = string;
			graffiti_ShowColorMenu(playerid);
			return 1;
		}
		else 
		{
			DeletePVar(playerid, "GraffitiEDIT");
			return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
		}
	}
	else if(dialogid == 1252)
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
			return 1;
		}
		else return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
	}
	else if(dialogid == 1253)
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
			new f = GetPVarInt(playerid, "GraffitiEDIT");
			graffiti_EditGraffiti(playerid, f);
			GameTextForPlayer(playerid, "~g~Zaaktualizowano!", 2000, 5);
			return 1;
		}
		else
		{
			DeletePVar(playerid, "GraffitiEDIT");
			return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
		}
	}
	else if(dialogid == 1254)
	{
		if(response)
		{
			new string[128];
			if(isnull(inputtext)) 
			{
				DeletePVar(playerid, "GraffitiEDIT");
				return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
			}
			if(strfind(inputtext, "\n") != -1) return GameTextForPlayer(playerid, "~r~Zakazane znaki!",2000, 5);
			format(string, sizeof(string), "%s", inputtext);
			Graffiti_Text[playerid] = string;
			graffiti_ShowEditColorDialog(playerid);
			return 1;
		}
		else 
		{
			DeletePVar(playerid, "GraffitiEDIT");
			return GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
		}
	}
	return 1;
}

// hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
// {
	
// }
//end