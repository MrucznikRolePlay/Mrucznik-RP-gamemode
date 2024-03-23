//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  kajdanki                                                 //
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
#include "kajdanki_impl.pwn"

//-------<[ initialize ]>-------
command_cuff()
{
    new command = Command_GetID("kajdanki");

    //aliases
    Command_AddAlt(command, "cuff");
    Command_AddAlt(command, "skuj");
    

    //permissions
    Group_SetCommand(Group_GetID("frakcja_LSPD"), command, true);
    Group_SetCommand(Group_GetID("frakcja_FBI"), command, true);
    Group_SetCommand(Group_GetID("frakcja_SASP"), command, true);
    Group_SetCommand(Group_GetID("frakcja_USSS"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:kajdanki(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zak³adanie kajdanek.");
        return 1;
    }
    //fetching params
    new cuffedplayerid;
    if(sscanf(params, "r", cuffedplayerid))
    {
        sendTipMessage(playerid, "U¿yj /kajdanki [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(cuffedplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_kajdanki_Impl(playerid, cuffedplayerid);
}