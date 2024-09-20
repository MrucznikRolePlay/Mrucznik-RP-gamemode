//------------------------------------------<< Generated source >>-------------------------------------------//
//                                              sprzedajprzemyt                                              //
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
#include "sprzedajprzemyt_impl.pwn"

//-------<[ initialize ]>-------
command_sprzedajprzemyt()
{
    new command = Command_GetID("sprzedajprzemyt");

    //aliases
    Command_AddAlt(command, "sprzedajprzemyt");
    Command_AddAlt(command, "sellsmuggled");
    Command_AddAlt(command, "sellprzemyt");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:sprzedajprzemyt(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Oferuje graczowi przedmiot z przemytu na sprzeda¿.");
        return 1;
    }
    //fetching params
    new giveplayerid, nazwa[32], price;
    if(sscanf(params, "k<fix>s[32]d", giveplayerid, nazwa, price))
    {
        sendTipMessage(playerid, "U¿yj /sprzedajprzemyt [Nick/ID] [jetpack/pancerz] [cena] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_sprzedajprzemyt_Impl(playerid, giveplayerid, nazwa, price);
}