//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ qf ]--------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:qf(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pMember] >= 1 || GetPlayerOrg(playerid) != 0)
	    {
			if(PlayerInfo[playerid][pLider] > 0)
			{
				sendTipMessage(playerid, "Nie mo¿esz odjeœæ z lidera.", COLOR_LIGHTBLUE);
				return 1;
			}
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			sendTipMessage(playerid, "Odszed³eœ z frakcji, jesteœ teraz cywilem!", COLOR_LIGHTBLUE);
			Log(commandLog, INFO, "Gracz %s opuœci³ frakcjê %d.", GetPlayerLogName(playerid), PlayerInfo[playerid][pMember]);
			gTeam[playerid] = 3;
			PlayerInfo[playerid][pMember] = 0;
			PlayerInfo[playerid][pRank] = 0;
            orgUnInvitePlayer(playerid);
			MedicBill[playerid] = 0;
			SetPlayerSpawnSkin(playerid);
			UsunBron(playerid);
			SetPVarInt(playerid, "mozeUsunacBronie", 0);
			return 1;
		}
		else
		{
		    sendErrorMessage(playerid, "Nie masz frakcji");
		}
	}
	return 1;
}
