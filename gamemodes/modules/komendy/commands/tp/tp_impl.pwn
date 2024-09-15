//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_tp_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer01[MAX_PLAYER_NAME];
	new giveplayer02[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new plo, plo1;
		if( sscanf(params, "k<fix>k<fix>", plo1, plo))
		{
			sendTipMessage(playerid, "U¿yj /tp [playerid/CzêœæNicku] [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;

		if (IsPlayerConnected(plo) && IsPlayerConnected(plo1))
		{
		    if(plo != INVALID_PLAYER_ID && plo1 != INVALID_PLAYER_ID)
		    {
				GetPlayerName(plo1, giveplayer01, sizeof(giveplayer01));
				GetPlayerName(plo, giveplayer02, sizeof(giveplayer02));
				
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
				{
					if(Spectate[playerid] != INVALID_PLAYER_ID)
					{
						Spectate[playerid] = INVALID_PLAYER_ID;
					}
					GetPlayerPos(plo, plocx, plocy, plocz);
					SetPlayerInterior(plo1, GetPlayerInterior(plo));
					SetPlayerVirtualWorld(plo1, GetPlayerVirtualWorld(plo));
					format(string, sizeof(string), "Zosta³eœ teleportowany do %s (ID: %d) przez Admina %s.", giveplayer02, plo, GetNickEx(playerid));
					SendClientMessage(plo1, COLOR_GRAD1, string);
					format(string, sizeof(string), "Teleportowano tutaj %s (ID: %d) przez Admina %s.", giveplayer01, plo1, GetNickEx(playerid));
					SendClientMessage(plo, COLOR_GRAD1, string);
					format(string, sizeof(string), "Teleportowano %s (ID: %d) do %s (ID: %d).", giveplayer01, plo1, giveplayer02, plo);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					if(PlayerInfo[plo][pInt] > 0)
					{
						PlayerInfo[plo1][pInt] = PlayerInfo[plo][pInt];
						PlayerInfo[plo1][pLocal] = PlayerInfo[plo][pLocal];
					}
					if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
					{
						//SetPlayerInterior(playerid,1);
						PlayerInfo[plo1][pInt] = 1;
					}
					if (GetPlayerState(plo1) == 2)
					{
						new tmpcar = GetPlayerVehicleID(plo1);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPos(plo1,plocx,plocy+2, plocz);
					}
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
		else
		{
			format(string, sizeof(string), "%d lub %d nie jest aktywnym graczem.", plo, plo1);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

//end
