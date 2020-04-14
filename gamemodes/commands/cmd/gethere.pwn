//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gethere ]------------------------------------------------//
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

YCMD:gethere(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "k<fix>", plo))
		{
			sendTipMessage(playerid, "U¿yj /tm [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:X,Float:Y,Float:Z;


		if(plo != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
			{
				GetPlayerPos(playerid, X, Y, Z);
				if(IsPlayerInAnyVehicle(plo))
				{
					SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
					SetPlayerInterior(plo, GetPlayerInterior(playerid));
					LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid));
					SetPlayerPos(plo, X+1, Y+1, Z+1.3);
					SetVehiclePos(GetPlayerVehicleID(plo), X+1, Y+1, Z+1.3);
					PutPlayerInVehicle(plo, GetPlayerVehicleID(plo), GetPlayerVehicleSeat(plo));
				}
				else
				{
					SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
					SetPlayerInterior(plo, GetPlayerInterior(playerid));
					SetPlayerPos(plo, X+1, Y+1, Z+1.3);
				}
				if(PlayerInfo[playerid][pInt] > 0)
				{
					PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
					PlayerInfo[plo][pLocal] = PlayerInfo[playerid][pLocal];
				}
				TextDrawShowForPlayer(playerid, Text:InfoT[playerid]);
				TextDrawSetString(Text:InfoT[playerid], "Teleportowales gracza do siebie!");
				SetTimerEx("InfoHide", 5000, 0, "u", playerid);
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
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
