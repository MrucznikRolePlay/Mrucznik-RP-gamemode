//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   felga                                                   //
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
#include "felga_impl.pwn"

//-------<[ initialize ]>-------
command_felga()
{
    new command = Command_GetID("felga");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:felga(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Montowanie innej felgi w samochodzie.");
        return 1;
    }
    //fetching params
    new giveplayerid, felga;
    if(sscanf(params, "k<fix>d", giveplayerid, felga))
    {
        sendTipMessage(playerid, "U�yj /felga [Nick/ID] [felga] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_felga_Impl(playerid, giveplayerid, felga);
}