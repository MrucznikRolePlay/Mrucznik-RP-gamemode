//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gotocar ]------------------------------------------------//
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

YCMD:gotocar(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new testcar;
		if( sscanf(params, "d", testcar))
		{
			sendTipMessage(playerid, "U¿yj /gotocar [carid]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			new Float:cwx2,Float:cwy2,Float:cwz2;
			GetVehiclePos(testcar, cwx2, cwy2, cwz2);
			new ca_VW = GetVehicleVirtualWorld(testcar); 
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid, ca_VW); 
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, cwx2, cwy2, cwz2);
			}
			else
			{
				SetPlayerPos(playerid, cwx2, cwy2, cwz2);
			}
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
