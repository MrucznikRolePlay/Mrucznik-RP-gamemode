//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                gunshoppanel                                               //
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
// Autor: wiger
// Data utworzenia: 18.02.2024
//Opis:
/*
	Panel zarzadzania sklepem z bronia
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock dgspanel(playerid) {
    ShowPlayerDialogEx(playerid, D_GSPANEL, DIALOG_STYLE_LIST, "Panel gunshopu", "Ustaw ceny broni\nUstaw ceny mats u bota", "Wybierz", "Anuluj");
}
stock dgspanel_bronie(playerid) {
	new gsid = GetPlayerOrg(playerid)-21;
    new bronie[] = {8, 22, 25, 23, 24, 29, 30, 31, 33, 27, 28, 34, 9, 39, 37};
    new string[1024];
    DynamicGui_Init(playerid);
    for(new i=0; i<sizeof(bronie); i++) {
        new gunName[32];
        GetWeaponName(bronie[i], gunName, 32);
        format(string, sizeof(string), "%s{FFFFFF}%s\t{008000}%i$\n", string, gunName, GS_BronCena[gsid][bronie[i]]);
        DynamicGui_AddRow(playerid, bronie[i]);
    }
    ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE, DIALOG_STYLE_TABLIST, "Panel gunshopu > Ceny broni", string, "Wybierz", "Wróæ");
}

//end