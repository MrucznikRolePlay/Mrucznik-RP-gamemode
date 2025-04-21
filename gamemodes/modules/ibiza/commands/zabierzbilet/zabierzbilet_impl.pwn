//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                zabierzbilet                                               //
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
command_zabierzbilet_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pRank] >= 6) 
    {
        new bizId = GetIbizaOrVinyl(playerid);
		if (bizId == -1) return 1;
        if (playerid == giveplayerid) return 1;
        new var[128];
        if (bizId == FRONTBIZ_IBIZA) {
            if(IbizaTicket[giveplayerid] > 0)
            {
                IbizaTicket[giveplayerid] = 0;
                format(var, sizeof(var), "Zabra³eœ bilet %s", GetNick(giveplayerid));
                sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
                format(var, sizeof(var), "%s zabra³ ci bilet do Ibizy.", GetNick(playerid));
                sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, var);
            }
            else
            {
                sendTipMessage(playerid, "Gracz nie posiada biletu.");   
            }
        } else if (bizId == FRONTBIZ_VINYL) {
            if (GetPVarInt(playerid, "Vinyl-bilet"))  {
                DeletePVar(playerid, "Vinyl-bilet");
                format(var, sizeof(var), "Zabra³eœ bilet %s", GetNick(giveplayerid));
                sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
                format(var, sizeof(var), "%s zabra³ ci bilet do Vinyla.", GetNick(playerid));
                sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, var);
            }
            else
            {
                sendTipMessage(playerid, "Gracz nie posiada biletu.");   
            }
        }
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end