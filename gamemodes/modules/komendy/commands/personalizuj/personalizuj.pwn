//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                personalizuj                                               //
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
#include "personalizuj_impl.pwn"

//-------<[ initialize ]>-------
command_personalizuj()
{
    new command = Command_GetID("personalizuj");

    //aliases
    Command_AddAlt(command, "personalizacja");
    Command_AddAlt(command, "personalize");
    Command_AddAlt(command, "ustawienia");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:personalizuj(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "");
        return 1;
    }
    //fetching params
    new param[256];
    if(sscanf(params, "S()[256]", param))
    {
        sendTipMessage(playerid, "U¿yj /personalizuj [] ");
        return 1;
    }
    
    //command body
    return command_personalizuj_Impl(playerid, param);
}