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
        sendTipMessage(playerid, "Panel zarz¹dzania biznesem.");
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