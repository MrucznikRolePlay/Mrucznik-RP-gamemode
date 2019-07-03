//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                setloglevel                                                //
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
// Autor: Mrucznik
// Data utworzenia: 18.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_setloglevel_Impl(playerid, logname[32], loglevel)
{
    if(!IsAKox(playerid)) {
        return noAccessMessage(playerid);
    }

    new Logger:logger;
    switch (YHash(logname))
    {
        case _H<admin>: logger = adminLog;
        case _H<pay>: logger = payLog;
        case _H<premium>: logger = premiumLog;
        case _H<punishment>: logger = punishmentLog;
        case _H<warning>: logger = warningLog;
        case _H<nick>: logger = nickLog;
        case _H<sejf>: logger = sejfLog;
        case _H<server>: logger = serverLog;
        case _H<command>: logger = commandLog;
        case _H<chat>: logger = chatLog;
        case _H<damage>: logger = damageLog;
        case _H<connect>: logger = connectLog;
        case _H<money>: logger = moneyLog;
        case _H<error>: logger = errorLog;
        case _H<adminduty>: logger = admindutyLog;
        case _H<admindutymasz>: logger = admindutyMaszLog;
        default: return sendErrorMessage(playerid, "Z³y typ logów!");
    }
    SetLogLevel(logger, E_LOGLEVEL:loglevel);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Ustawiono gataliwoœæ logów %s na poziom %d", logname, loglevel));
    Log(adminLog, INFO, "Admin %s ustawi³ gadatliwoœæ logów %s na poziom %d", GetPlayerLogName(playerid), logname, loglevel);
    return 1;
}

//end