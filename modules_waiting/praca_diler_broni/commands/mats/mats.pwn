//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    mats                                                   //
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
#include "mats_impl.pwn"

//-------<[ initialize ]>-------
command_mats()
{
    new command = Command_GetID("mats");

    //aliases
    Command_AddAlt(command, "materialy");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:mats(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zarz¹dzanie materia³ami do sprzeda¿y broni.");
        return 1;
    }
    //fetching params
    new opcja[32];
    if(sscanf(params, "s[32]", opcja))
    {
        sendTipMessage(playerid, "U¿yj /mats [opcja] ");
        return 1;
    }
    
    //command body
    return command_mats_Impl(playerid, opcja);
}