//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   napad                                                   //
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
#include "napad_impl.pwn"

//-------<[ initialize ]>-------
command_napad()
{
    new command = Command_GetID("napad");

    //aliases
    Command_AddAlt(command, "napadnij");
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:napad(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda zarz¹dzania napadem.");
        return 1;
    }
    //fetching params
    new actionToDo[64], giveplayerid;
    if(sscanf(params, "s[64]r", actionToDo, giveplayerid))
    {
        sendTipMessage(playerid, "U¿yj /napad [Akcja] [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_napad_Impl(playerid, actionToDo, giveplayerid);
}