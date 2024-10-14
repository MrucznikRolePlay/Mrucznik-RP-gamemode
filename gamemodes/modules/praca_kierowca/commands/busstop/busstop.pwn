//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  busstop                                                  //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "busstop_impl.pwn"

//-------<[ initialize ]>-------
command_busstop()
{
    new command = Command_GetID("busstop");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:busstop(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Edytuje przystanek autobusowy.");
        return 1;
    }
    //fetching params
    new route, busstop, action[32], param[128];
    if(sscanf(params, "dds[32]S()[128]", route, busstop, action, param))
    {
        sendTipMessage(playerid, "U¿yj /busstop [id trasy] [id przystanku] [akcja] [parametry] ");
        sendTipMessage(playerid, "Dostêpne akcje: describe | goto | place | name | checkpoint | delete | insert");
        return 1;
    }
    
    //command body
    return command_busstop_Impl(playerid, route, busstop, action, param);
}