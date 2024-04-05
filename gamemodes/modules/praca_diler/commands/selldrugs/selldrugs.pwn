//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 selldrugs                                                 //
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
#include "selldrugs_impl.pwn"

//-------<[ initialize ]>-------
command_selldrugs()
{
    new command = Command_GetID("selldrugs");

    //aliases
    Command_AddAlt(command, "sprzedajnarkotyki");
    Command_AddAlt(command, "sprzedajdragi");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:selldrugs(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Sprzeda¿ narkotyków.");
        return 1;
    }
    //fetching params
    new giveplayerid, weight, price;
    if(sscanf(params, "rdd", giveplayerid, weight, price))
    {
        sendTipMessage(playerid, "U¿yj /selldrugs [Nick/ID] [waga (gram)] [cena] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_selldrugs_Impl(playerid, giveplayerid, weight, price);
}