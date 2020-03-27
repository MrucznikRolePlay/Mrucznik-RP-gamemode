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
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "k<fix>", plo))
		{
			sendTipMessage(playerid, "U¿yj /goto [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;

		if (IsPlayerConnected(plo))
		{
		    if(plo != INVALID_PLAYER_ID)
		    {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if (PlayerInfo[playerid][Admin] >= 1 || PlayerInfo[playerid][HalfAdmin] >= 1 || PlayerInfo[playerid][pZG]==10 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
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
					GetPlayerPos(plo, plocx, plocy, plocz);
					SetPlayerInterior(playerid, GetPlayerInterior(plo));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(plo));
					if(PlayerInfo[plo][pInt] > 0)
					{
						PlayerInfo[playerid][pInt] = PlayerInfo[plo][pInt];
						PlayerInfo[playerid][pLocal] = PlayerInfo[plo][pLocal];
					}
					if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
					{
						//SetPlayerInterior(playerid,1);
						PlayerInfo[playerid][pInt] = 1;
					}
					if (GetPlayerState(playerid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(playerid);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPos(playerid,plocx,plocy+2, plocz);
					}
					_MruAdmin(playerid, "Zosta³eœ teleportowany!");
				}
				else
				{
					noAccessMessage(playerid);
				}
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
