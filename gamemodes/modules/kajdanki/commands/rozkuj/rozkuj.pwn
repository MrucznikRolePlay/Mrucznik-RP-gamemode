//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   rozkuj                                                  //
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
#include "rozkuj_impl.pwn"

//-------<[ initialize ]>-------
command_rozkuj()
{
    new command = Command_GetID("rozkuj");

    //aliases
    Command_AddAlt(command, "uncuff");
    Command_AddAlt(command, "odkuj");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    Group_SetCommand(Group_GetID("frakcja_LSPD"), command, true);
    Group_SetCommand(Group_GetID("frakcja_FBI"), command, true);
    Group_SetCommand(Group_GetID("frakcja_SASP"), command, true);
    Group_SetCommand(Group_GetID("frakcja_USSS"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:rozkuj(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Rozkucie kajdanek.");
        return 1;
    }
    //fetching params
    new uncuffedplayerid;
    if(sscanf(params, "r", uncuffedplayerid))
    {
        sendTipMessage(playerid, "U¿yj /rozkuj [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(uncuffedplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_rozkuj_Impl(playerid, uncuffedplayerid);
}