//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                bpracownicy                                                //
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
#include "bpracownicy_impl.pwn"

//-------<[ initialize ]>-------
command_bpracownicy()
{
    new command = Command_GetID("bpracownicy");

    //aliases
    Command_AddAlt(command, "biznespracownicy");
    Command_AddAlt(command, "businessworkers");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:bpracownicy(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Wyœwietla listê pracowników online biznesu.");
        return 1;
    }
    
    
    //command body
    return command_bpracownicy_Impl(playerid);
}