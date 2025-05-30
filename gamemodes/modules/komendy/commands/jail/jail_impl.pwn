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
command_jail_Impl(playerid, params[256])
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playa, money;
        if( sscanf(params, "k<fix>d", playa, money))
        {
            sendTipMessage(playerid, "U�yj /jail [playerid/Cz��Nicku] [czas(minuty)]");
            return 1;
        }


        if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
        {
            if(IsPlayerConnected(playa))
            {
                if(playa != INVALID_PLAYER_ID)
                {
                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Uwi�zi�e� %s.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTRED, string);
                    format(string, sizeof(string), "* Zosta�e� uwi�ziony przez Admina %s.", sendername);
                    SendClientMessage(playa, COLOR_LIGHTRED, string);
                    format(string, sizeof(string), "* %s zosta� uwi�ziony w wi�zieniu na %d minut przez admina %s.",giveplayer, money, sendername);
                    SendPunishMessage(string, playa);
                    RemovePlayerWeaponsTemporarity(playa);
                    PoziomPoszukiwania[playa] = 0;
                    PlayerInfo[playa][pJailed] = 1;
                    PlayerInfo[playa][pJailTime] = money * 60;
		            SetPlayerArrestPos(playa);
                    format(string, sizeof(string), "Zosta�e� uwi�ziony na %s minut.   Kaucja: Niedost�pna", money);
                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                }
            }
        } else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}

//end
