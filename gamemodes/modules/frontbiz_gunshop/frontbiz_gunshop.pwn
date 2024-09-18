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
stock LoadMats3DText() 
{
    for(new i=0; i<3; i++)
    {
        GS_Text[i] = CreateDynamic3DTextLabel("/sprzedajmatsbot", COLOR_BLUE, GS_MatsBot[i][0], GS_MatsBot[i][1], GS_MatsBot[i][2], 6.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GS_MatsBotVw[i]);
        UpdateMats3DText(i);
    }
}

stock UpdateMats3DText(gsid) 
{
    new cena = GS_MatsCena[gsid];
    new str[128];
    if(cena)
        format(str, 128, "/sprzedajmatsbot\nCena za 5000 mats: {00FFFF}$%i", cena*5000);
    else
        strcat(str, "/sprzedajmatsbot\n{FF0000}Sprzeda¿ wy³¹czona!");
    UpdateDynamic3DTextLabelText(GS_Text[gsid], COLOR_BLUE, str);
}

stock dgspanel(playerid) 
{
    new caption[64];
    format(caption, 64, "Panel gunshopu - %s", OrgInfo[GetPlayerOrg(playerid)][o_Name]);
    ShowPlayerDialogEx(playerid, D_GSPANEL, DIALOG_STYLE_LIST, caption, "Ustaw ceny broni\nUstaw ceny mats u bota", "Wybierz", "Anuluj");
}

stock dgspanel_bronie(playerid) 
{
	new gsid = GetPlayerOrg(playerid)-21;
    new bronie[] = {8, 22, 25, 23, 24, 29, 30, 31, 33, 27, 28, 34, 9, 39, 37};
    new string[1024];
    DynamicGui_Init(playerid);
    for(new i=0; i<sizeof(bronie); i++) 
    {
        new gunName[32];
        GetWeaponName(bronie[i], gunName, 32);
        format(string, sizeof(string), "%s{FFFFFF}%s\t{008000}%i$\n", string, gunName, GS_BronCena[gsid][bronie[i]]);
        DynamicGui_AddRow(playerid, bronie[i]);
    }
    ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE, DIALOG_STYLE_TABLIST, "Panel gunshopu > Ceny broni", string, "Wybierz", "Wróæ");
}

//end