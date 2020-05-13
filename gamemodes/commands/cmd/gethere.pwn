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
					GetPlayerPos(playerid, plocx, plocy, plocz);
					if(PlayerInfo[playerid][pInt] > 0)
					{
						SetPlayerInterior(plo,PlayerInfo[playerid][pInt]);
						PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
						PlayerInfo[plo][pLocal] = PlayerInfo[playerid][pLocal];
					}
					if(PlayerInfo[playerid][pInt] == 0)
					{
						SetPlayerInterior(plo,0);
					}
					if(plocz > 930.0 && PlayerInfo[playerid][pInt] == 0) //the highest land point in sa = 526.8
					{
						SetPlayerInterior(plo,1);
						PlayerInfo[plo][pInt] = 1;
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
                    SetPlayerInterior(plo, GetPlayerInterior(playerid));
					SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
					sendTipMessageEx(plo, COLOR_GRAD1, "Zosta?e? teleportowany");
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
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

				sendTipMessageEx(plo, COLOR_GRAD1, "Zosta³eœ teleportowany");
				sendTipMessage(playerid, "Teleportowales gracza do siebie!");
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
