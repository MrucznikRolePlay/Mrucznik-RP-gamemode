//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  busroute                                                 //
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
#include "busroute_impl.pwn"

//-------<[ initialize ]>-------
command_busroute()
{
    new command = Command_GetID("busroute");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:busroute(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Edycja trasy autobusowej.");
        return 1;
    }
    //fetching params
    new route, action[32], param[128];
    if(sscanf(params, "ds[32]S()[128]", route, action, param))
    {
        sendTipMessage(playerid, "U¿yj /busroute [id trasy] [akcja] [parametry] ");
        sendTipMessage(playerid, "Dostêpne akcje: describe | name | color| money | skill | time | enable");
        return 1;
    }
    
    //command body
    return command_busroute_Impl(playerid, route, action, param);
}