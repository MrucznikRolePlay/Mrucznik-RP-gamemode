//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  akceptuj                                                 //
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
#include "akceptuj_impl.pwn"

//-------<[ initialize ]>-------
command_akceptuj()
{
    new command = Command_GetID("akceptuj");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:akceptuj(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Akceptuje ofertê od gracza.");
        return 1;
    }
    //fetching params
    new nazwa[32];
    if(sscanf(params, "s[32]", nazwa))
    {
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Accept __________________|");
        SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: /akceptuj [nazwa]");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: sex, dragi, naprawa, prawnik, pancerz, praca, wywiad, tankowanie");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: auto, taxi, bus, heli, boks, medyk, mechanik, mandat, kuracje");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: rozwod, swiadek, slub, pojazd, wynajem, wizytowka, uwolnienie, biznes");
        SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
        return 1;
    }
    
    //command body
    return command_akceptuj_Impl(playerid, nazwa);
}