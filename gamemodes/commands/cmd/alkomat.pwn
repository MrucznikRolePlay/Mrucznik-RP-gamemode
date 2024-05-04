//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ alkomat ]------------------------------------------------//
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

YCMD:alkomat(playerid, params[], help)
{
	new giveplayerid;
	if(sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "Uøyj /alkomat [ID gracza]");
		return 1;
	}
	if (IsAPolicja(playerid) || IsAHA(playerid))
	{
		if(OnDuty[playerid] == 0 && IsAPolicja(playerid))
		{
			sendErrorMessage(playerid, "Nie jesteú na s≥uøbie");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(GetDistanceBetweenPlayers(giveplayerid,playerid) < 10)
			{
				new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(giveplayerid,giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid,sendername, sizeof(sendername));
				if(IsPlayerSick(playerid, DRUG_GOOD))
				{
					format(string, sizeof(string), "Gracz %s jest pod wp≥ywem narkotykÛw.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else
				{
					format(string, sizeof(string), "Gracz %s jest czysty(narkotyki).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				if(PlayerDrunk[giveplayerid] >= 1 && PlayerDrunk[giveplayerid] <= 2 || GetPlayerDrunkLevel(playerid) >= 2000 && GetPlayerDrunkLevel(playerid) < 10000)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp≥ywem alkoholu(ma≥o).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else if(PlayerDrunk[giveplayerid] >= 3 || GetPlayerDrunkLevel(playerid) > 10000)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp≥ywem alkoholu(duøo).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else
				{
					format(string, sizeof(string), "Gracz %s jest trzeüwy(alkohol).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				format(string, sizeof(string), "* %s bada alkomatem %s", sendername, giveplayer);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				sendErrorMessage(playerid, "Gracz nie znajduje sie obok ciebie.");
			}
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteú policjantem, ani agentem FBI");
	}
	return 1;
}
