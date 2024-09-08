//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   pobij                                                   //
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
#include "pobij_impl.pwn"

//-------<[ initialize ]>-------
command_pobij()
{
    

    //aliases
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:pobij(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Spróbuj pobiæ gracza. Konkurencja polegaj¹ca na szybkim i dok³adnym przepisywaniu tekstu.");
        return 1;
    }
    //fetching params
    new opponentid;
    if(sscanf(params, "k<fix>", opponentid))
    {
        sendTipMessage(playerid, "U¿yj /pobij [Nick/ID] ");
        return 1;
    }
    if(!IsPlayerConnected(opponentid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    //command body
    return command_pobij_Impl(playerid, opponentid);
}