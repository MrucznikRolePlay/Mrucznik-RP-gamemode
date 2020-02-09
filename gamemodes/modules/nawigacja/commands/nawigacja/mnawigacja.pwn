//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 mnawigacja                                                //
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
#include "mnawigacja_impl.pwn"

//-------<[ initialize ]>-------
command_mnawigacja()
{
    new command = Command_GetID("mnawigacja");

    //aliases
    Command_AddAlt(command, "mnaw");
    Command_AddAlt(command, "nawiguj");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mnawigacja(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda pozwalaj¹ca odpaliæ nawigacjê");
        return 1;
    }
    
    
    //command body
    return command_mnawigacja_Impl(playerid);
}