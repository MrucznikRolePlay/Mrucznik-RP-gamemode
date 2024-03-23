//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                ip5                                                //
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
#include "ip5_impl.pwn"

//-------<[ initialize ]>-------
command_ip5()
{
    

    //aliases
    

    //permissions
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:ip5(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Wyœwietlanie 5 ostatnich adresów IP, na których gra³ gracz pod danym nickiem.");
        return 1;
    }
    //fetching params

    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /ip5 [Nick/ID] ");
        return 1;
    }

    new offline = false;
    new giveplayer[MAX_PLAYER_NAME];
    if(sscanf(params, "r", giveplayer) || !IsPlayerConnected(giveplayer[0]))
    {
        new formatString[8];
        format(formatString, sizeof(formatString), "s[%d]", MAX_PLAYER_NAME);
        sscanf(params, formatString, giveplayer);
        offline = true;
    }
    //command body
    return command_ip5_Impl(playerid, giveplayer, offline);
}

YCMD:ip5addfake(playerid, params[], help)
{
    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /ip5addfake [Nick/ID]");
        return 1;
    }

    new ipString[32];
    new string[128];
    format(ipString, sizeof(ipString), "%d.%d.%d.%d", random(256), random(256), random(256), random(256));
    IP5AddIPToList(params, ipString);
    format(string, sizeof(string), "Dodano adres %s pod nick %s.", ipString, params);
    SendClientMessage(playerid, COLOR_LIGHTRED, string);

    return 1;
}

/*
*/