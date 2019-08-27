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
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG]==10 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
				{
					//SZUKANIE ADMINOW I P@ na serwerze

					new bool:liczydelko=false;
					foreach(new i : Player)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pAdmin] >= 1 || (PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] < 5))
							{
								liczydelko=true;
								break;
							}
						}
					}
					//koniec szukania adminkow
					if(liczydelko==true && PlayerInfo[playerid][pZG]==10)
					{
						sendTipMessageEx(playerid, COLOR_GRAD1, "Na serwerze s¹ admini, nie mo¿esz u¿yæ tej komendy!");
						return 1;
					}
					if(Spectate[playerid] != INVALID_PLAYER_ID)
					{
						Spectate[playerid] = INVALID_PLAYER_ID;
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
						SetPlayerPosEx(playerid,plocx,plocy+2, plocz);
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
