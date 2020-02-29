//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 agraffiti                                                 //
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
#include "agraffiti_impl.pwn"

//-------<[ initialize ]>-------
command_agraffiti()
{
    new command = Command_GetID("agraffiti");

    //aliases
    Command_AddAlt(command, "agrafiti");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:agraffiti(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda administracyjna graffiti.");
        return 1;
    }
    //fetching params
    new opcja[36], id;
    if(sscanf(params, "s[36]D(-1)", opcja, id))
    {
        sendTipMessage(playerid, "U¿yj /agraffiti [Sprawdz, Reload, Goto, Lista] [GOTO->ID | Lista->ID] ");
        return 1;
    }
    
    //command body
    return command_agraffiti_Impl(playerid, opcja, id);
}