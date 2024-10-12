//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_ip_Impl(playerid, params[256])
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];

    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        new giveplayerid;
        if( sscanf(params, "k<fix>", giveplayerid))
        {
            sendTipMessage(playerid, "U¿yj /ip [playerid]");
            sendTipMessage(playerid, "FUNKCJA: Pokazuje IP wybranego gracza.");
            return 1;
        }
        if(IsPlayerConnected(giveplayerid))
        {
            new ip[32];
            GetPlayerIp(giveplayerid,ip,32);
            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
            format(string, sizeof(string), "-| %s IP: %s |-", giveplayer,ip);
            SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
            Log(adminLog, INFO, "Admin %s u¿y³ /ip na graczu %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
        } else
        {
            format(string, sizeof(string), "Nie znaleziono gracza o nicku/id %s", params);
            sendErrorMessage(playerid, string);
        }
    } else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end
