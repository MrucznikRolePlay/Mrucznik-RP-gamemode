//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 wywalklub                                                 //
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
command_wywalklub_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pRank] >= 2) 
    {
        new bizId = GetIbizaOrVinyl(playerid);
        if (bizId == -1) return 1;
        if (playerid == giveplayerid) return 1;
        new Float:x,
            Float:y,
            Float:z;
        GetPlayerPos(giveplayerid, x, y, z);
        if(IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z) && GetPlayerVirtualWorld(giveplayerid) == GetPlayerVirtualWorld(playerid))
        {
            new var[128];
            if (bizId == 39) {
                if(IbizaTicket[giveplayerid] > 0) IbizaTicket[giveplayerid] = 0;
                format(var, sizeof(var), "** %s wyrzuca %s z ibizy.", GetNick(playerid), GetNick(giveplayerid));
                ProxDetector(20.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(var, sizeof(var), "[IBIZA_INFO]%s wyrzuci³ %s z ibizy!", GetNick(playerid), GetNick(giveplayerid));
                SendOrgMessage(GetPlayerOrg(playerid), COLOR_P@, var);
                Wchodzenie(giveplayerid);
                IbizaWyjscie(playerid);
                SetPlayerVirtualWorld(giveplayerid, 0);
                SetPlayerPos(giveplayerid, 397.3062, -1805.8008, 7.8380);
            } else if (bizId == 40) {
                DeletePVar(giveplayerid, "Vinyl-bilet");
                format(var, sizeof(var), "** %s wyrzuca %s z vinyla.", GetNick(playerid), GetNick(giveplayerid));
                ProxDetector(20.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(var, sizeof(var), "[VINYL_INFO]%s wyrzuci³ %s z vinyla!", GetNick(playerid), GetNick(giveplayerid));
                SendOrgMessage(GetPlayerOrg(playerid), COLOR_P@, var);
                Wchodzenie(giveplayerid);
                SetPlayerVirtualWorld(giveplayerid, 0);
                SetPlayerPos(giveplayerid, 815.8209, -1386.7086, 13.6066);
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