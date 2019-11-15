//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ unbw ]-------------------------------------------------//
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

YCMD:bw(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] >= 5000)
	{
		new giveplayerid, czas;
		if(sscanf(params, "k<fix>d", giveplayerid, czas))
		{
			sendTipMessage(playerid, "U¿yj /bw [ID/NICK GRACZA] [czas w sekundach]"); //
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");

		new Float:x, Float:y, Float:z;
		GetPlayerPos(giveplayerid, x, y, z);
		PlayerInfo[giveplayerid][pBW] = czas;
		SetSpawnInfo(giveplayerid, 0, GetPlayerSkin(giveplayerid), x, y, z, 0.0, 0, 0, 0, 0, 0, 0);
		SetPVarInt(giveplayerid, "bw-skin",  GetPlayerSkin(giveplayerid));
		SetPVarInt(giveplayerid, "bw-vw", GetPlayerVirtualWorld(giveplayerid));
		SetPVarInt(giveplayerid, "bw-int", GetPlayerInterior(giveplayerid));
		SetPlayerSpawn(giveplayerid);
		SendClientMessage(playerid, COLOR_GRAD2, "Nadano BW");
	}
    return 1;
}
