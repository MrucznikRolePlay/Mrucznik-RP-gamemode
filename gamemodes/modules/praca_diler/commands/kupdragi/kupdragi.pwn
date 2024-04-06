//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  kupdragi                                                 //
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
#include "kupdragi_impl.pwn"

//-------<[ initialize ]>-------
command_kupdragi()
{
    new command = Command_GetID("kupdragi");

    //aliases
    Command_AddAlt(command, "kupnarkotyki");
    Command_AddAlt(command, "buydrugs");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:kupdragi(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Kup narkotyki od dilera w lodziarni.");
        return 1;
    }
    //fetching params
    new weight;
    if(sscanf(params, "d", weight))
    {
        sendTipMessage(playerid, "U¿yj /kupdragi [waga] ");
        return 1;
    }
    
    //command body
    return command_kupdragi_Impl(playerid, weight);
}