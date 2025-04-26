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
    for(new i=0; i<sizeof(GS_Text); i++)
    {
        GS_Text[i] = CreateDynamic3DTextLabel("Przejmij ten sklep z broni¹\naby uzyskaæ dostêp do bota!", COLOR_BLUE, 
            GS_MatsBot[i][0], GS_MatsBot[i][1], GS_MatsBot[i][2], 6.0, 
            INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GS_MatsBotVw[i]);
        new bizId = i < 3
            ? i + GUNSHOP_FIRST_ID
            : i + FIRST_LS_FRONTBUSINESS_ID - 3;
        new org = FrontBusiness[bizId][Owner];
        if (IsActiveOrg(org))
            UpdateMats3DText(org);
    }
}

UpdateMats3DText(org) 
{
    new mats = GS_MatsCena[org];
    new kontra = GS_KontraCena[org];
    new str[256];
    strcat(str, "/kupbron /sprzedajmatsbot /sellkontrabandabot\n");
    if(mats)
        format(str, 256, "%sCena za 5000 mats: {00FFFF}$%i\n", str, mats*5000);
    else
        strcat(str, "{FF0000}Sprzeda¿ mats wy³¹czona!\n");
    if(kontra)
        format(str, 256, "%s{0080FF}Cena za 1 kontrabande: {00FFFF}$%i", str, kontra);
    else
        strcat(str, "{FF0000}Sprzeda¿ kontrabandy wy³¹czona!");
    
    new gsid = 0;
    for (new i=0; i<sizeof(FrontBusiness); i++) {
        if (FrontBusiness[i][Type] == FRONT_BIZ_TYPE_GUNSHOP) {
            if (FrontBusiness[i][Owner] == org)
                UpdateDynamic3DTextLabelText(GS_Text[gsid], COLOR_BLUE, str);
            gsid++;
        }
    }
}

GunShopPanel(playerid) 
{
    ShowPlayerDialogEx(playerid, D_GSPANEL, DIALOG_STYLE_LIST, 
        "Panel gunshopu",
        "Ustaw ceny broni\nUstaw ceny mats u bota\nUstaw ceny kontrabandy u bota", "Wybierz", "Anuluj");
}

GunShopPanel_Bronie(playerid) 
{
    new orgid = GetPlayerOrg(playerid);
    new string[1024];
    DynamicGui_Init(playerid);
    for(new i; i<sizeof(GS_Guns); i++) 
    {
        new gunName[32];
        GetWeaponName(GS_Guns[i], gunName);
        format(string, sizeof(string), "%s{FFFFFF}%s\t{008000}%i$\n", string, gunName, GS_BronCena[orgid][GS_Guns[i]]);
        DynamicGui_AddRow(playerid, GS_Guns[i]);
    }
    ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE, DIALOG_STYLE_TABLIST, "Panel gunshopu > Ceny broni", string, "Wybierz", "Wróæ");
}

GetGunIndex(gunid)
{
    for(new i; i<sizeof(GunInfo); i++)
    {
        if(GunInfo[i][GunId] == gunid) return i;
    }
    return -1;
}

GetGsBot(bizid)
{
    if (bizid < FIRST_LS_FRONTBUSINESS_ID)
        return bizid - GUNSHOP_FIRST_ID;
    return bizid - FIRST_LS_FRONTBUSINESS_ID + 3;
}

//end