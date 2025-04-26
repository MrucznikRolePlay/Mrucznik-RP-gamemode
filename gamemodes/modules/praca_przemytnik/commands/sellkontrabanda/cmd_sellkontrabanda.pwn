//------------------------------------------<< Generated source >>-------------------------------------------//
//                                              sellkontrabanda                                              //
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
#include "sellkontrabanda_impl.pwn"

//-------<[ initialize ]>-------
command_sellkontrabanda()
{
    new command = Command_GetID("sellkontrabanda");

    //aliases
    Command_AddAlt(command, "sprzedajkontrabande");
    Command_AddAlt(command, "sellkontraband");
    Command_AddAlt(command, "sellkontrabande");
    Command_AddAlt(command, "sellcontraband");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:sellkontrabanda(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Sprzedaj graczowi swoj� kontraband�.");
        return 1;
    }
    //fetching params
    new giveplayerid, count, price;
    if(sscanf(params, "k<fix>dd", giveplayerid, count, price))
    {
        sendTipMessage(playerid, "U�yj /sellkontrabanda [Nick/ID] [liczba] [cena] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_sellkontrabanda_Impl(playerid, giveplayerid, count, price);
}