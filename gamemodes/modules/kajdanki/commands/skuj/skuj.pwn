//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    skuj                                                   //
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
#include "skuj_impl.pwn"

//-------<[ initialize ]>-------
command_skuj()
{
    new command = Command_GetID("skuj");

    //aliases
    Command_AddAlt(command, "cuff");
    Command_AddAlt(command, "kajdanki");
    

    //permissions
    Group_SetCommand(Group_GetID("frakcja_LSPD"), command, true);
    Group_SetCommand(Group_GetID("frakcja_FBI"), command, true);
    Group_SetCommand(Group_GetID("frakcja_SASP"), command, true);
    Group_SetCommand(Group_GetID("frakcja_USSS"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:skuj(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Zak³adanie kajdanek.");
        return 1;
    }
    //fetching params
    new cuffedplayerid;
    if(sscanf(params, "k<fix>", cuffedplayerid))
    {
        sendTipMessage(playerid, "U¿yj /skuj [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(cuffedplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_skuj_Impl(playerid, cuffedplayerid);
}