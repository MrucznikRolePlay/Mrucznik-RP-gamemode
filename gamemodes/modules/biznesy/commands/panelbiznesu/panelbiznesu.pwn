//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                panelbiznesu                                               //
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
#include "panelbiznesu_impl.pwn"

//-------<[ initialize ]>-------
command_panelbiznesu()
{
    new command = Command_GetID("panelbiznesu");

    //aliases
    Command_AddAlt(command, "bizpanel");
    Command_AddAlt(command, "bizpan");
    Command_AddAlt(command, "panelbiz");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:panelbiznesu(playerid, params[], help)
{
    if (help)
    {
        SendClientMessage(playerid, COLOR_WHITE, "|_____________ Business Panel _______________|");
        SendClientMessage(playerid, COLOR_WHITE, "U¿YJ: /panelbiz [nazwa]");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Przyjmij, Zwolnij, Wplac, Wyplac");
        SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Stan");
        SendClientMessage(playerid, COLOR_GREY, "JU¯ NIED£UGO - Ulepsz, Schowaj, Wez");
        SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
        return 1;
    }
    //fetching params
    new choice[32];
    if(sscanf(params, "s[32]", choice))
    {
        sendTipMessage(playerid, "U¿yj /panelbiznesu [opcja] ");
        return 1;
    }
    
    //command body
    return command_panelbiznesu_Impl(playerid, choice);
}