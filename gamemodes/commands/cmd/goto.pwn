//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ goto ]-------------------------------------------------//
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

YCMD:goto(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "k<fix>", plo))
		{
			sendTipMessage(playerid, "U¿yj /to [playerid/CzêœæNicku]");
			return 1;
		}

		if(plo != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG]==10 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
			{
				if(Spectate[playerid] != INVALID_PLAYER_ID)
				{
					PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
					PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
					SetPlayerToTeamColor(playerid);
					MedicBill[playerid] = 0;
					Spectate[playerid] = INVALID_PLAYER_ID;
					//TogglePlayerSpectating(playerid, 0);
					GameTextForPlayer(playerid, "L O A D I N G", 1000, 3);
					SetTimerEx("SpecEnd", 500, false, "d", playerid);
				}
				
				new Float:X,Float:Y,Float:Z;
				GetPlayerPos(plo, X, Y, Z);
				if(IsPlayerInAnyVehicle(playerid))
				{
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(plo));
					SetPlayerInterior(playerid, GetPlayerInterior(plo));
					LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(plo));
					SetPlayerPos(playerid, X+1, Y+1, Z+1.3);
					SetVehiclePos(GetPlayerVehicleID(playerid), X+1, Y+1, Z+1.3);
					PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), GetPlayerVehicleSeat(playerid));
				}
				else
				{
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(plo));
					SetPlayerInterior(playerid, GetPlayerInterior(plo));
					SetPlayerPos(playerid, X+1, Y+1, Z+1.3);
				}
				if(PlayerInfo[plo][pInt] > 0)
				{
					PlayerInfo[playerid][pInt] = PlayerInfo[plo][pInt];
					PlayerInfo[playerid][pLocal] = PlayerInfo[plo][pLocal];
				}

				TextDrawShowForPlayer(playerid, Text:InfoT[playerid]);
				TextDrawSetString(Text:InfoT[playerid], "Teleportowales sie jako admin pomyslnie!");
				SetTimerEx("InfoHide", 5000, 0, "u", playerid);
			}
			else
			{
				noAccessMessage(playerid);
			}
		}
		else
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", plo);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
