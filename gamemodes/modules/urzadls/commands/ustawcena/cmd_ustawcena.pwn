//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 ustawcena                                                 //
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
#include "ustawcena_impl.pwn"

//-------<[ initialize ]>-------
command_ustawcena()
{
    new command = Command_GetID("ustawcena");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:ustawcena(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Ustawia cen� poszczeg�lnej licencji w Urz�dzie Miasta Los Santos");
        return 1;
    }
    //fetching params
    new valueChoice, valueCost;
    if(sscanf(params, "dd", valueChoice, valueCost))
    {
        sendTipMessage(playerid, "U�yj /ustawcena [To co gracz wybra�] [Nowa cena licencji] ");
        return 1;
    }
    
    //command body
    return command_ustawcena_Impl(playerid, valueChoice, valueCost);
}