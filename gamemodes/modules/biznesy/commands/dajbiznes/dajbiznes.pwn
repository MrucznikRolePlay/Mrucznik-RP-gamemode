//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 dajbiznes                                                 //
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
#include "dajbiznes_impl.pwn"

//-------<[ initialize ]>-------
command_dajbiznes()
{
    

    //aliases
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:dajbiznes(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda, która nadaje biznes dla gracza. Niezale¿nie od odleg³oœci.");
        return 1;
    }
    //fetching params
    new giveplayerid, valueBiz;
    if(sscanf(params, "rd", giveplayerid, valueBiz))
    {
        sendTipMessage(playerid, "U¿yj /dajbiznes [Nick/ID] [BIZ_ID] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_dajbiznes_Impl(playerid, giveplayerid, valueBiz);
}