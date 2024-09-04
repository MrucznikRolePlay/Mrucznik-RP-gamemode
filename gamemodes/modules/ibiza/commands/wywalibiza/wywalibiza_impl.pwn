//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 wywalibiza                                                //
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
// Autor: Sanda³
// Data utworzenia: 14.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_wywalibiza_Impl(playerid, giveplayerid)
{
    if(IsAClub(playerid) && PlayerInfo[playerid][pRank] >= 2) 
    {
        new Float:x,
            Float:y,
            Float:z;
        GetPlayerPos(giveplayerid, x, y, z);
        if(IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
        {
            if(GetPlayerVirtualWorld(giveplayerid) == 21 || GetPlayerVirtualWorld(giveplayerid) == 22 || GetPlayerVirtualWorld(giveplayerid) == 23 || GetPlayerVirtualWorld(giveplayerid) == 24 || GetPlayerVirtualWorld(giveplayerid) == 26 || GetPlayerVirtualWorld(giveplayerid) == 27)
            {
                if(giveplayerid == playerid) return 1;
                new var[128];
                if(IbizaTicket[giveplayerid] > 0) IbizaTicket[giveplayerid] = 0;
                format(var, sizeof(var), "** %s wyrzuca %s z ibizy.", GetNick(playerid), GetNick(giveplayerid));
                ProxDetector(20.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(var, sizeof(var), "[IBIZA_INFO]%s wyrzuci³ %s z ibizy!", GetNick(playerid), GetNick(giveplayerid));
                SendNewFamilyMessage(GetPlayerOrg(playerid), COLOR_P@, var);
                Wchodzenie(giveplayerid);
                SetPlayerVirtualWorld(giveplayerid, 0);
                SetPlayerPos(giveplayerid, 397.3062, -1805.8008, 7.8380);
            }
            else
            {
                sendTipMessage(playerid, "Gracz nie jest w ibizie.");
            }
        }
        else
        {
            sendTipMessage(playerid, "Nie znajdujesz siê obok niego.");
        }
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end