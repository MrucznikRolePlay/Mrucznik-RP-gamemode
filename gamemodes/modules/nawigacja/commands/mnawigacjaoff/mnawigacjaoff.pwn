//------------------------------------------<< Generated source >>-------------------------------------------//
//                                               mnawigacjaoff                                               //
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
#include "mnawigacjaoff_impl.pwn"

//-------<[ initialize ]>-------
command_mnawigacjaoff()
{
    new command = Command_GetID("mnawigacjaoff");

    //aliases
    Command_AddAlt(command, "mnawoff");
    Command_AddAlt(command, "nawoff");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mnawigacjaoff(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Wy³¹cza punkt zaznaczony na nawigacji");
        return 1;
    }
    
    
    //command body
    return command_mnawigacjaoff_Impl(playerid);
}