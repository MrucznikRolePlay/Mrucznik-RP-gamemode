//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gotopos ]------------------------------------------------//
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

YCMD:gotopos(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
		    new Float:x, Float:y, Float:z;
			if( !sscanf(params, "p<,>fff", x,y,z) || !sscanf(params, "p< >fff", x,y,z))
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, x, y, z);
				}
				else
				{
					SetPlayerPos(playerid, x, y, z);
				}
				_MruAdmin(playerid, "Zosta�e� teleportowany");
			}
			else
			{
				sendTipMessage(playerid, "U�yj /gotopos [x] [y] [z]");
				return 1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
