//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   wyrok                                                   //
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
#include "wyrok_impl.pwn"

//-------<[ initialize ]>-------
command_wyrok()
{
    

    //aliases
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:wyrok(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Nadaje wyrok graczowi");
        return 1;
    }
    //fetching params
    new giveplayerid, czas, czas_sekundy, sygnatura[24];
    if(sscanf(params, "rds[24]", giveplayerid, czas, sygnatura))
    {
        sendTipMessage(playerid, "U¿yj /wyrok [Nick/ID] [Ilosc Dni] [Sygnatura Wyroku]");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))
    {
        sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
        return 1;
    }
    else
    {
        new Float:X_gpid, Float:Y_gpid, Float:Z_gpid;
        GetPlayerPos(giveplayerid, X_gpid, Y_gpid, Z_gpid);
        if(IsPlayerInRangeOfPoint(playerid, 3.0, X_gpid, Y_gpid, Z_gpid))
        {
            if(PlayerInfo[giveplayerid][zakuty] == 1)
            {
                if(czas > 0)
                {
                    czas_sekundy = czas * 86400;
                    //kod na wyrok
                }
            }
        }
    }
    //command body
    return command_wyrok_Impl(playerid, giveplayerid, czas, sygnatura);
}