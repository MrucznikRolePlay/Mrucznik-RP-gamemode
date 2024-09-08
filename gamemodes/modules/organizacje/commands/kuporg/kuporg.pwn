//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   kuporg                                                  //
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
#include "kuporg_impl.pwn"

//-------<[ initialize ]>-------
command_kuporg()
{
    new command = Command_GetID("kuporg");

    //aliases
    Command_AddAlt(command, "kuporganizacje");
    Command_AddAlt(command, "zalozorganizacje");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:kuporg(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Kup slot na organizacje.");
        return 1;
    }
    //fetching params
    new color, orgType, name[32];
    if(sscanf(params, "hds[32]", color, orgType, name))
    {
        sendTipMessage(playerid, "U¿yj /kuporg [kolor w formacie hex (np. F1A151)] [typ organizacji (1 - Gang, 2 - Mafia)] [nazwa] ");
        sendTipMessage(playerid, "Koszt stworzenia organizacji: "#CREATE_ORG_COST"$ i "#CREATE_ORG_CONTRABAND_COST" kontrabandy.");
        sendTipMessage(playerid, "Gangi mog¹ przejmowaæ strefy gangów w Los Santos.");
        sendTipMessage(playerid, "Mafie mog¹ przejmowaæ biznesy w Vice City.");
        return 1;
    }
    
    //command body
    return command_kuporg_Impl(playerid, color, orgType, name);
}