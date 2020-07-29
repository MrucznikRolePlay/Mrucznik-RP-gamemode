//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   zjedz                                                   //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
zjedz_OnDialogResponse(playerid, listitem)
{
    MruMySQL_EatCookedMeal(playerid, DynamicGui_GetValue(playerid, listitem));
    MruMySQL_CookedMealsDialog(playerid);
    return 1;
}

command_zjedz_Impl(playerid)
{
    new Float:hp;
    GetPlayerHealth(playerid, hp);
    if(hp >= 100.0)
    {
        sendErrorMessage(playerid, "Jesteœ tak najedzony, ¿e nie zmieœcisz ju¿ wiêcej (masz pe³ne hp).");
        return 1;
    }
    
    if(gettime() - GetPVarInt(playerid, "lastDamage") < 60)
    {
        sendErrorMessage(playerid, "Nie mo¿esz jeœæ podczas walki!");
        return 1;
    }

    MruMySQL_CookedMealsDialog(playerid);
    return 1;
}

//end