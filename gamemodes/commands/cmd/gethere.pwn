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
		new Float:plocx,Float:plocy,Float:plocz;


		if(plo != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
			{
				GetPlayerPos(playerid, plocx, plocy, plocz);
				if(IsPlayerInAnyVehicle(plo))
				{
					if(PlayerInfo[playerid][pInt] == 0)
					{
						if(plocz > 930.0)
						{
							PlayerInfo[plo][pInt] = 1;
							SetPlayerInterior(plo, 1);
						}
						else
						{
							SetPlayerInterior(plo,0);
						}
					}
					if (GetPlayerState(plo) == 2)
					{
						new tmpcar = GetPlayerVehicleID(plo);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPos(plo,plocx,plocy+2, plocz);
					}
				}
				else
				{
					SetPlayerPos(plo, plocx+1, plocy+1, plocz+1.3);
				}
				SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
				SetPlayerInterior(plo, GetPlayerInterior(playerid));

				if(PlayerInfo[playerid][pInt] > 0)
				{
					SetPlayerInterior(plo,PlayerInfo[playerid][pInt]);
					PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
					PlayerInfo[plo][pLocal] = PlayerInfo[playerid][pLocal];
				}

				sendTipMessageEx(plo, COLOR_GRAD1, "Zosta³eœ teleportowany");
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
