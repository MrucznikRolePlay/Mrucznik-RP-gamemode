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
        MruMessageFail(playerid, "By kupiæ broñ, musisz znajdowaæ siê w gunshopie.");
        return 1;
    }

    new gsid = bizId - GUNSHOP_FIRST_ID;
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, GS_MatsBot[gsid][0], GS_MatsBot[gsid][1], GS_MatsBot[gsid][2]))
    {
        MruMessageFail(playerid, "Znajdujesz siê za daleko od bota sprzedawcy broni.");
        return 1;
    }

    if(PlayerInfo[playerid][pGunLic] != 1)
    {
        MruMessageFail(playerid, "Musisz posiadaæ licencjê na broñ, aby kupiæ broñ w Gun Shopie.");
        return 1;
    }

    SetPVarInt(playerid, "gunshop_bizId", bizId);
    SetPVarInt(playerid, "gunshop_gsid", gsid);
    ShowBuyGunDialog(playerid);
    return 1;
}

ShowBuyGunDialog(playerid)
{
    new string[1024];
    new bizId = GetPVarInt(playerid, "gunshop_bizId");
    new gsid = GetPVarInt(playerid, "gunshop_gsid");
    new org = FrontBusiness[bizId][Owner];

    strcat(string, "Broñ\tNaboje\tCena\n");
    for(new i; i<sizeof(GS_Guns); i++)
    {
        new gunid = GS_Guns[i];
        new gunIdx = GetGunIndex(gunid);
        new gunName[32];
        GetWeaponName(gunid, gunName);
        if(GS_BronCena[gsid][gunid] <= 0)
        {
            strcat(string, sprintf(INCOLOR_RED"%s\tnie sprzedajemy\n", gunName));
        }
        else if(Rodzina_Mats[org] < GunInfo[gunIdx][GunMaterialsCost])
        {
            strcat(string, sprintf(INCOLOR_RED"%s\tbrak materia³ów\n", gunName));
        }
        else
        {
            strcat(string, sprintf(INCOLOR_DIALOG"%s\t%d\t"INCOLOR_GREEN"%d$\n", gunName, GunInfo[gunIdx][GunAmmo], GS_BronCena[gsid][gunid]));
        }
    }

    ShowPlayerDialogEx(playerid, D_GSPANEL_KUPBRON, DIALOG_STYLE_LIST, sprintf("Gunshop %s", FrontBusiness[bizId][Name]), 
        string, "Kup", "WyjdŸ");
}

//end