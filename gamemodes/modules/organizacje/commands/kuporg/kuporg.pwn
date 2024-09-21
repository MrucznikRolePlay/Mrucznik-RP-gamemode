//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   kuporg                                                  //
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
#include "kuporg_impl.pwn"

//-------<[ initialize ]>-------
command_kuporg()
{
    new command = Command_GetID("kuporg");

    //aliases
    Command_AddAlt(command, "kuporganizacje");
    Command_AddAlt(command, "zalozorganizacje");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:kuporg(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Kup slot na organizacje.");
        return 1;
    }
    //fetching params
    new color, name[34];
    if(sscanf(params, "hs[34]", color, name))
    {
        sendTipMessage(playerid, "U¿yj /kuporg [kolor w formacie hex (np. F1A151FF)] [nazwa (max 32 znaki)] ");
        sendTipMessage(playerid, "Koszt stworzenia organizacji: "#CREATE_ORG_COST"$ i "#CREATE_ORG_CONTRABAND_COST" kontrabandy.");
        return 1;
    }
    
    //command body
    return command_kuporg_Impl(playerid, color, name);
}