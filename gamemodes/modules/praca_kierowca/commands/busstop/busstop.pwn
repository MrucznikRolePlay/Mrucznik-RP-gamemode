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
        sendTipMessage(playerid, "g");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, "b");
        sendTipMessage(playerid, "j");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "p");
        sendTipMessage(playerid, "i");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "k");
        sendTipMessage(playerid, "u");
        sendTipMessage(playerid, "p");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "h");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "c");
        sendTipMessage(playerid, "k");
        sendTipMessage(playerid, "p");
        sendTipMessage(playerid, "o");
        sendTipMessage(playerid, "i");
        sendTipMessage(playerid, "n");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "3");
        sendTipMessage(playerid, "d");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "x");
        sendTipMessage(playerid, "t");
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
        sendTipMessage(playerid, "d");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "l");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "t");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "|");
        sendTipMessage(playerid, " ");
        sendTipMessage(playerid, "i");
        sendTipMessage(playerid, "n");
        sendTipMessage(playerid, "s");
        sendTipMessage(playerid, "e");
        sendTipMessage(playerid, "r");
        sendTipMessage(playerid, "t");
        return 1;
    }
    
    //command body
    return command_busstop_Impl(playerid, route, busstop, action, param);
}