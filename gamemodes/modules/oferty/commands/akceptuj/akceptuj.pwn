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
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Sex, Dragi, Naprawa, Prawnik, Pancerz, Praca, Wywiad, Tankowanie");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Auto, Taxi, Bus, Heli, Boks, Medyk, Mechanik, Mandat, kuracje");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Rozwod, Swiadek, Slub, Pojazd, Wynajem, Wizytowka, Uwolnienie, biznes");
        SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
        return 1;
    }
    
    //command body
    return command_akceptuj_Impl(playerid, nazwa);
}