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
LoadMats3DText() 
{
    for(new i=0; i<3; i++)
    {
        GS_Text[i] = CreateDynamic3DTextLabel("/kupbron /sprzedajmatsbot", COLOR_BLUE, 
            GS_MatsBot[i][0], GS_MatsBot[i][1], GS_MatsBot[i][2], 6.0, 
            INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GS_MatsBotVw[i]);
        UpdateMats3DText(i);
    }
}

UpdateMats3DText(gsid) 
{
    new cena = GS_MatsCena[gsid];
    new str[128];
    if(cena)
        format(str, 128, "/kupbron /sprzedajmatsbot\nCena za 5000 mats: {00FFFF}$%i", cena*5000);
    else
        strcat(str, "/kupbron /sprzedajmatsbot\n{FF0000}Sprzeda¿ wy³¹czona!");
    UpdateDynamic3DTextLabelText(GS_Text[gsid], COLOR_BLUE, str);
}

GunShopPanel(playerid) 
{
    new bizId = GetPVarInt(playerid, "gspanel_bizId");
    ShowPlayerDialogEx(playerid, D_GSPANEL, DIALOG_STYLE_LIST, 
        sprintf("Panel gunshopu - %s", FrontBusiness[bizId][Name]), 
        "Ustaw ceny broni\nUstaw ceny mats u bota", "Wybierz", "Anuluj");
}

GunShopPanel_Bronie(playerid) 
{
    new bizId = GetPVarInt(playerid, "gspanel_bizId");
    new gsid = bizId - GUNSHOP_FIRST_ID;
    new string[1024];
    DynamicGui_Init(playerid);
    for(new i; i<sizeof(GS_Guns); i++) 
    {
        new gunName[32];
        GetWeaponName(GS_Guns[i], gunName);
        format(string, sizeof(string), "%s{FFFFFF}%s\t{008000}%i$\n", string, gunName, GS_BronCena[gsid][GS_Guns[i]]);
        DynamicGui_AddRow(playerid, GS_Guns[i]);
    }
    ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE, DIALOG_STYLE_TABLIST, "Panel gunshopu > Ceny broni", string, "Wybierz", "Wróæ");
}

//end