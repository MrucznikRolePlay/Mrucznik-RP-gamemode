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
command_qf_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		new org = GetPlayerOrg(playerid);
		new frac = PlayerInfo[playerid][pMember];
	    if(frac >= 1 || org != 0)
	    {
			if(PlayerInfo[playerid][pLider] > 0 || IsPlayerOrgLeader(playerid))
			{
				sendTipMessage(playerid, "Nie mo¿esz odjeœæ z lidera.", COLOR_LIGHTBLUE);
				return 1;
			}
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			if (org) {
				sendTipMessage(playerid, "Odszed³eœ z organizacji, jesteœ teraz cywilem!", COLOR_LIGHTBLUE);
				Log(serverLog, INFO, "%s opuœci³ organizacjê %s.", GetPlayerLogName(playerid), GetOrgLogName(org));
			} else {
				sendTipMessage(playerid, "Odszed³eœ z frakcji, jesteœ teraz cywilem!", COLOR_LIGHTBLUE);
				Log(serverLog, INFO, "%s opuœci³ frakcjê %s.", GetPlayerLogName(playerid), GetFractionLogName(frac));
			}
			PlayerInfo[playerid][pMember] = 0;
			PlayerInfo[playerid][pRank] = 0;
            RemovePlayerFromOrg(playerid);
			MedicBill[playerid] = 0;
			SetPlayerSpawnSkin(playerid);
			return 1;
		}
		else
		{
		    sendErrorMessage(playerid, "Nie masz frakcji");
		}
	}
	return 1;
}

//end
