//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gspanel                                                  //
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


//

//------------------<[ Implementacja: ]>-------------------
command_gspanel_Impl(playerid)
{
    if(!IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_GUNSHOP) || !IsPlayerOrgLeader(playerid))
    {
        return noAccessMessage(playerid);
    }

    new bizId = IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_GUNSHOP);
    if(bizId != -1)
    {
        MruMessageFail(playerid, "By zarz¹dzaæ gunshopem, musisz znajdowaæ siê w jego interiorze.");
        return 1;
    }

    if(IsFrontBusinnesOwnedByOrg(bizId, GetPlayerOrg(playerid)))
    {
        MruMessageFail(playerid, "Twoja organizacja nie kontroluje tego gunshopu.");
        return 1;
    }
    
    SetPVarInt(playerid, "gspanel_bizId", bizId);
    SetPVarInt(playerid, "gspanel_gsid", bizId - GUNSHOP_FIRST_ID);
    GunShopPanel(playerid);
    return 1;
}

//end