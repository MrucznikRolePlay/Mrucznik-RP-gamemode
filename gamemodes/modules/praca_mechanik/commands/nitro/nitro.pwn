//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   nitro                                                   //
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
// Kod wygenerowany automatycznie narzÍdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN• NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "nitro_impl.pwn"

//-------<[ initialize ]>-------
command_nitro()
{
    new command = Command_GetID("nitro");

    //aliases
    Command_AddAlt(command, "nos");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:nitro(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zamontuj nitro w pojeüdzie.");
        return 1;
    }
    //fetching params
    new giveplayerid;
    if(sscanf(params, "k<fix>", giveplayerid))
    {
        sendTipMessage(playerid, "Uøyj /nitro [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_nitro_Impl(playerid, giveplayerid);
}