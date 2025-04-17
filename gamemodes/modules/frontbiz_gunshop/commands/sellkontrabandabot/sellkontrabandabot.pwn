//------------------------------------------<< Generated source >>-------------------------------------------//
//                                             sellkontrabandabot                                            //
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
#include "sellkontrabandabot_impl.pwn"

//-------<[ initialize ]>-------
command_sellkontrabandabot()
{
    new command = Command_GetID("sellkontrabandabot");

    //aliases
    Command_AddAlt(command, "sprzedajkontrabandebot");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:sellkontrabandabot(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Sprzedaj kontrabande botowi w GS");
        return 1;
    }
    //fetching params
    new kontrabanda;
    if(sscanf(params, "d", kontrabanda))
    {
        sendTipMessage(playerid, "U¿yj /sellkontrabandabot [ilosc] ");
        return 1;
    }
    
    //command body
    return command_sellkontrabandabot_Impl(playerid, kontrabanda);
}