//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ unspec ]------------------------------------------------//
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

YCMD:unspec(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 3 || IsAScripter(playerid))
        {
			PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
			PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			SetPlayerToTeamColor(playerid);
			MedicBill[playerid] = 0;
			SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2], 10.0, -1, -1, -1, -1, -1, -1);
			Spectate[playerid] = INVALID_PLAYER_ID;
			TogglePlayerSpectating(playerid, 0);
		}
	}
	return 0;
}
