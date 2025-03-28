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
command_zmienplec_Impl(playerid, params[256])
{
    new playa;
	if(sscanf(params, "k<fix>", playa))
	{
		sendTipMessage(playerid, "U�yj /zmienplec [ID gracza]");
		return 1;
	}
	if (PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS || GetPlayerJob(playerid) == JOB_MEDIC)
	{
		new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		if(GetDistanceBetweenPlayers(playerid,playa) < 5)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					//if(GetPlayerVirtualWorld(playerid) > 90 && IsPlayerInRangeOfPoint(playerid, 100.0, 1103.4714,-1298.0918,21.552))
					if(PlayerInfo[playerid][pLocal] == PLOCAL_FRAC_LSMC || IsAtHealingPlace(playerid))
					{
                        if(kaska[playerid] < 50000) return sendErrorMessage(playerid, "Nie masz 50 000$ na operacj�.");
						format(string, sizeof(string),"Przeprowadzi�e� operacje zmiany p�ci na %s. Koszt: 50 000$", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        ZabierzKase(playerid, 50000);
                        Sejf_Add(FRAC_ERS, 50000);
						if(PlayerInfo[playa][pSex] == 1)
						{
							format(string, sizeof(string), "Lekarz %s przeprowadzi� na tobie operacje zmiany p�ci. Jeste� teraz kobiet�!", giveplayer);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Operacja zmiany p�ci powiod�a si�! %s jest teraz kobiet� ((%s))", giveplayer, sendername);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							PlayerInfo[playa][pSex] = 2;
						}
						else
						{
							format(string, sizeof(string), "Lekarz %s przeprowadzi� na tobie operacje zmiany p�ci. Jeste� teraz m�czyzn�!", giveplayer);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Operacja zmiany p�ci powiod�a si�! %s jest teraz m�czyzn� ((%s))", giveplayer, sendername);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							PlayerInfo[playa][pSex] = 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie jeste� w szpitalu lub karetce (/wejdzw)!");
					}
				}
			}
		}
		else
		{
			format(string, sizeof(string),"Jeste� zbyt daleko od gracza %s.", playa);
			sendErrorMessage(playerid, string);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz 3 rangi lub nie jeste� medykiem!");
	}
	return 1;
}

//end
