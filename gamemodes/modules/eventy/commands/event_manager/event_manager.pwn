//------------------------------------------<< Generated source >>-------------------------------------------//
//                                               event_manager                                               //
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
#include "event_manager_impl.pwn"

//-------<[ initialize ]>-------
command_event_manager()
{
    new command = Command_GetID("event_manager");

    //aliases
    Command_AddAlt(command, "e_m");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:event_manager(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda zarz¹dzaj¹ca eventami");
        return 1;
    }
    //fetching params
    new opcja[24], eventid, opcjaparam[24], argopcjaparam[24];
    if(sscanf(params, "S(info)[24]D(-1)S(Brak)[24]S(Brak)[24]", opcja, eventid, opcjaparam, argopcjaparam))
    {
        sendTipMessage(playerid, "U¿yj /event_manager [enabled/param/load/unload] [] [] [] ");
        return 1;
    }
    
    //command body
    return command_event_manager_Impl(playerid, opcja, eventid, opcjaparam, argopcjaparam);
}