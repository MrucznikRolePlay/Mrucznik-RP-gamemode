//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pancerz                                                  //
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
// Data utworzenia: 18.08.2024


//

//------------------<[ Implementacja: ]>-------------------
command_pancerz_Impl(playerid)
{
    if(GetPlayerSmugglingItem(playerid, SMUGGLING_ITEM_ARMOR) == 0)
    {
        MruMessageFail(playerid, "Najpierw musisz kupiæ kamizelkê kuloodporn¹ u przemytnika.");
        return 1;
    }

    if(IsPlayerInFight(playerid))
    {
        MruMessageFail(playerid, "Nie mo¿esz za³o¿yæ kamizelki kuloodpornej podczas walki (60 sekund po otrzymaniu obra¿eñ)!");
        return 1;
    }

    TakeSmugglingItem(playerid, SMUGGLING_ITEM_ARMOR);

    SetPlayerArmour(playerid, 100);
    ChatMe(playerid, "zak³ada kamizelkê kuloodporn¹");
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, false, 0, 1);
    return 1;
}

//end