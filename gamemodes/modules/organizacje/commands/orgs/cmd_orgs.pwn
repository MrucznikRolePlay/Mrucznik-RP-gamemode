//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    orgs                                                   //
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
#include "orgs_impl.pwn"

//-------<[ initialize ]>-------
command_orgs()
{
    new command = Command_GetID("orgs");

    //aliases
    Command_AddAlt(command, "organizacje");
    Command_AddAlt(command, "rodziny");
    Command_AddAlt(command, "biznesy");
    Command_AddAlt(command, "mafie");
    Command_AddAlt(command, "gangi");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:orgs(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Pokazuje liste organizacji i ich pracownik�w.");
        return 1;
    }
    //fetching params
    new orgid;
    if(sscanf(params, "D(-1)", orgid))
    {
        sendTipMessage(playerid, "U�yj /orgs [id organizacji] ");
        return 1;
    }
    
    //command body
    return command_orgs_Impl(playerid, orgid);
}