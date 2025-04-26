//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    news                                                   //
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
#include "news_impl.pwn"

//-------<[ initialize ]>-------
command_news()
{
    new command = Command_GetID("news");

    //aliases
    Command_AddAlt(command, "wiadomosc");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:news(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda pozwala wypowiada� si� na chacie San News - g��wnie uznawanym za radio.");
        return 1;
    }
    //fetching params
    new newsText[256];
    if(sscanf(params, "s[256]", newsText))
    {
        sendTipMessage(playerid, "U�yj /news [Na parametrze przetrzymywane jest to co gracz wpisa� u�ywaj�c komendy /news] ");
        return 1;
    }
    
    //command body
    return command_news_Impl(playerid, newsText);
}