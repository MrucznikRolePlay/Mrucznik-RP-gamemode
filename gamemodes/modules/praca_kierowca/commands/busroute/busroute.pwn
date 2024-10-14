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
        sendTipMessage(playerid, "D");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, "s");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, "ê");
        sendTipMessage(playerid, "p");
        sendTipMessage(playerid, "n");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "a");
        sendTipMessage(playerid, "k");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "j");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, ":");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "d");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "s");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "r");
        sendTipMessage(playerid, "i");
        sendTipMessage(playerid, "b");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "n");
        sendTipMessage(playerid, "a");
        sendTipMessage(playerid, "m");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "m");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, "n");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "y");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "s");
        sendTipMessage(playerid, "k");
        sendTipMessage(playerid, "i");
        sendTipMessage(playerid, "l");
        sendTipMessage(playerid, "l");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "d");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "l");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, "e");
        return 1;
    }
    
    //command body
    return command_busroute_Impl(playerid, route, action, param);
}