//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  kupbron                                                  //
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
// Autor: mrucznik
// Data utworzenia: 12.10.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kupbron_Impl(playerid)
{
    new bizId = IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_GUNSHOP);
    if(bizId == -1)
    {
        MruMessageFail(playerid, "By kupi� bro�, musisz znajdowa� si� w gunshopie.");
        return 1;
    }
    
    if (!IsFrontBusinnesOwnedByPlayerOrg(playerid, bizId))
    {
        MruMessageFail(playerid, "Ten gunshop nie nale�y do twojej organizacji.");
        return 1;
    }

    new gsid = GetGsBot(bizId);
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, GS_MatsBot[gsid][0], GS_MatsBot[gsid][1], GS_MatsBot[gsid][2]))
    {
        MruMessageFail(playerid, "Znajdujesz si� za daleko od bota sprzedawcy broni.");
        return 1;
    }

    if(PlayerInfo[playerid][pGunLic] != 1)
    {
        MruMessageFail(playerid, "Musisz posiada� licencj� na bro�, aby kupi� bro� w Gun Shopie.");
        return 1;
    }

    SetPVarInt(playerid, "gunshop_bizId", bizId);
    ShowBuyGunDialog(playerid);
    return 1;
}

ShowBuyGunDialog(playerid)
{
    new string[1024];
    new bizId = GetPVarInt(playerid, "gunshop_bizId");
    new org = GetPlayerOrg(playerid);

    DynamicGui_Init(playerid);
    strcat(string, "Bro�\tNaboje\tCena\n");
    for(new i; i<sizeof(GS_Guns); i++)
    {
        new gunid = GS_Guns[i];
        new gunIdx = GetGunIndex(gunid);
        new gunName[32];
        GetWeaponName(gunid, gunName);
        if(GS_BronCena[org][gunid] <= 0)
        {
            continue;
        }
        else if(Rodzina_Mats[org] < GunInfo[gunIdx][GunMaterialsCost])
        {
            strcat(string, sprintf(INCOLOR_RED"%s\tbrak materia��w\n", gunName));
        }
        else if(Rodzina_Contraband[org] < GunInfo[gunIdx][GunContrabandCost])
        {
            strcat(string, sprintf(INCOLOR_RED"%s\tbrak kontrabandy\n", gunName));
        }
        else
        {
            strcat(string, sprintf(INCOLOR_DIALOG"%s\t%d\t"INCOLOR_GREEN"%d$\n", gunName, GunInfo[gunIdx][GunAmmo], GS_BronCena[org][gunid]));
        }
        DynamicGui_AddRow(playerid, gunid);
    }

    if (DynamicGui_FreeRow(playerid) == 0)
        MruMessageFail(playerid, "Twoja organizacja nie sprzedaje �adnych broni");
    else {
        ShowPlayerDialogEx(playerid, D_GSPANEL_KUPBRON, DIALOG_STYLE_TABLIST_HEADERS, FrontBusiness[bizId][Name], 
            string, "Kup", "Wyjd�");
    }
}

//end