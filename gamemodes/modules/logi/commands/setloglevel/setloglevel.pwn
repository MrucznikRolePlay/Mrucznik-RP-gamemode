//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                setloglevel                                                //
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
#include "setloglevel_impl.pwn"

//-------<[ initialize ]>-------
command_setloglevel()
{
    new command = Command_GetID("setloglevel");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:setloglevel(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Ustawia poziom gadatliwoœci logów.");
        return 1;
    }
    //fetching params
    new logname[32], loglevel;
    if(sscanf(params, "s[32]d", logname, loglevel))
    {
        sendTipMessage(playerid, "U¿yj /setloglevel [log (admin, pay, premium, punishment, warning, nick, sejf, server, command, chat, damage, connect, money, adminduty)] [level (0-none | 1-debug | 2-info | 4-warning | 8 - ERROR | 15 - all)] ");
        return 1;
    }
    
    //command body
    return command_setloglevel_Impl(playerid, logname, loglevel);
}