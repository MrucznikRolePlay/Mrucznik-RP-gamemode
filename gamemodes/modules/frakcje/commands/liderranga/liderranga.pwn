//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 liderranga                                                //
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
#include "liderranga_impl.pwn"

//-------<[ initialize ]>-------
command_liderranga()
{
    new command = Command_GetID("liderranga");

    //aliases
    Command_AddAlt(command, "liderrank");
    Command_AddAlt(command, "liderrangi");
    Command_AddAlt(command, "leaderranga");
    Command_AddAlt(command, "leaderrank");
    Command_AddAlt(command, "leaderrangi");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:liderranga(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Edycja rang frakcji.");
        return 1;
    }
    //fetching params
    new rank, rankName[32];
    if(sscanf(params, "ds()[32]", rank, rankName))
    {
        sendTipMessage(playerid, "U¿yj /liderranga [numer rangi] [nazwa rangi (wpisz - aby usun¹æ, lub nic aby podejrzeæ)] ");
        return 1;
    }
    
    //command body
    return command_liderranga_Impl(playerid, rank, rankName);
}