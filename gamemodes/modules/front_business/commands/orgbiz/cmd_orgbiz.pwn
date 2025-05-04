//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   orgbiz                                                  //
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
#include "orgbiz_impl.pwn"

//-------<[ initialize ]>-------
command_orgbiz()
{
    new command = Command_GetID("orgbiz");

    //aliases
    Command_AddAlt(command, "orgbiznes");
    Command_AddAlt(command, "bizorg");
    Command_AddAlt(command, "orgb");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:orgbiz(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zarz�dzanie biznesem organizacyjnym.");
        return 1;
    }
    //fetching params
    new action[16], param[128];
    if(sscanf(params, "s[16]S()[128]", action, param))
    {
        sendTipMessage(playerid, "U�yj /orgbiz [akcja] [parametry] ");
        sendTipMessage(playerid, "Dost�pne parametry: lista / zmienczas");
        return 1;
    }
    
    //command body
    return command_orgbiz_Impl(playerid, action, param);
}