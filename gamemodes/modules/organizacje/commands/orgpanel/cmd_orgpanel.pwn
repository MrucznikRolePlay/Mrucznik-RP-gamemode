//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  orgpanel                                                 //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "orgpanel_impl.pwn"

//-------<[ initialize ]>-------
command_orgpanel()
{
    new command = Command_GetID("orgpanel");

    //aliases
    Command_AddAlt(command, "pr");
    Command_AddAlt(command, "panelrodziny");
    Command_AddAlt(command, "panelorganizacji");
    Command_AddAlt(command, "panelorg");
    Command_AddAlt(command, "rpanel");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:orgpanel(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Panel lidera organizacji przest�pczej.");
        return 1;
    }
    //fetching params
    new action[16], param[256];
    if(sscanf(params, "s[16]S()[256]", action, param))
    {
        sendTipMessage(playerid, "U�yj /orgpanel [akcja] [parametry akcji] ");
        sendTipMessage(playerid, "Dost�pne akcje: nazwa / motto / kolor / spawn / przyjmij / zwolnij / ranga / pracownicy / stawka / oddaj / usun");
        sendTipMessage(playerid, "Dost�pne akcje: stworzrange / pojazd / sejf / skin [kup/sprzedaj]");
        return 1;
    }
    
    //command body
    return command_orgpanel_Impl(playerid, action, param);
}