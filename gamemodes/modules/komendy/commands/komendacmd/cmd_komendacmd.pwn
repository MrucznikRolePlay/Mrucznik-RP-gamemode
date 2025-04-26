//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 komendacmd                                                //
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
#include "komendacmd_impl.pwn"

//-------<[ initialize ]>-------
command_komendacmd()
{
    new command = Command_GetID("komendacmd");

    //aliases
    Command_AddAlt(command, "command");
    Command_AddAlt(command, "komenda");
    Command_AddAlt(command, "cmd");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:komendacmd(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda s�u�y do wy�wietlania informacji o innych komendach.");
        return 1;
    }
    //fetching params
    new param[256];
    if(sscanf(params, "S()[256]", param))
    {
        sendTipMessage(playerid, "U�yj /komendacmd [] ");
        return 1;
    }
    
    //command body
    return command_komendacmd_Impl(playerid, param);
}