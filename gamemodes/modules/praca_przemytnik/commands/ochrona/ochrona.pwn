//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  ochrona                                                  //
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
#include "ochrona_impl.pwn"

//-------<[ initialize ]>-------
command_ochrona()
{
    new command = Command_GetID("ochrona");

    //aliases
    Command_AddAlt(command, "pancerz");
    Command_AddAlt(command, "sprzedajkamizelke");
    Command_AddAlt(command, "sprzedajpancerz");
    Command_AddAlt(command, "sellarmor");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:ochrona(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Oferuje graczowi kamizelkê kuloodporn¹.");
        return 1;
    }
    //fetching params
    new giveplayerid, price;
    if(sscanf(params, "rd", giveplayerid, price))
    {
        sendTipMessage(playerid, "U¿yj /ochrona [Nick/ID] [cena] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_ochrona_Impl(playerid, giveplayerid, price);
}