//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                sprzedajneon                                               //
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
#include "sprzedajneon_impl.pwn"

//-------<[ initialize ]>-------
command_sprzedajneon()
{
    new command = Command_GetID("sprzedajneon");

    //aliases
    Command_AddAlt(command, "sprzedajneony");
    Command_AddAlt(command, "sellneon");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:sprzedajneon(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Oferuje kupno neonu wskazanemu graczowi.");
        return 1;
    }
    //fetching params
    new giveplayerid, prowizja;
    if(sscanf(params, "rd", giveplayerid, prowizja))
    {
        sendTipMessage(playerid, "U¿yj /sprzedajneon [Nick/ID] [prowizja] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_sprzedajneon_Impl(playerid, giveplayerid, prowizja);
}