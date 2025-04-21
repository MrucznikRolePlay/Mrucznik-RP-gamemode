//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               setkontrabanda                                              //
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
// Autor: mrucznik
// Data utworzenia: 03.05.2024


//

//------------------<[ Implementacja: ]>-------------------
command_setkontrabanda_Impl(playerid, giveplayerid, value)
{
    if(PlayerInfo[playerid][pAdmin] != 5000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    PlayerInfo[giveplayerid][pContraband] = value;
    
    MruMessageGoodInfoF(playerid, "Ustawi³eœ %s kontrabandê na %d", GetNick(giveplayerid), value);
    MruMessageGoodInfoF(giveplayerid, "Admin %s ustawi³ Ci kontrabandê na %d", GetNick(playerid), value);
    Log(adminLog, INFO, "Admin %s ustawi³ %s kontrabandê na [%d]", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), value);
    return 1;
}

//end