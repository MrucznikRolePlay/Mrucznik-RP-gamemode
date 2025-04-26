//------------------------------------------<< Generated source >>-------------------------------------------//
//                                               setzonecontrol                                              //
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
#include "setzonecontrol_impl.pwn"

//-------<[ initialize ]>-------
command_setzonecontrol()
{
    new command = Command_GetID("setzonecontrol");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:setzonecontrol(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Nadaje kontrole nad dan� stref�.");
        return 1;
    }
    //fetching params
    new zoneid, org;
    if(sscanf(params, "dd", zoneid, org))
    {
        sendTipMessage(playerid, "U�yj /setzonecontrol [ID strefy] [ID organizacji] ");
        return 1;
    }
    
    //command body
    return command_setzonecontrol_Impl(playerid, zoneid, org);
}