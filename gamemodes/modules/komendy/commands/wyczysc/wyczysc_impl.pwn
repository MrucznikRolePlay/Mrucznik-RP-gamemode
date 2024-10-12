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
command_wyczysc_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    new tmpcar = GetPlayerVehicleID(playerid);
 		if(IsAPolicja(playerid))
		{
			if((tmpcar != INVALID_VEHICLE_ID && IsACopCar(tmpcar)) || IsAtClearCrimesPlace(playerid))
			{
				new giveplayerid;
				if( sscanf(params, "k<fix>",giveplayerid))
				{
					sendTipMessage(playerid, "U¿yj /oczysc [playerid/CzêœæNicku]");
					return 1;
				}

				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						if(PoziomPoszukiwania[giveplayerid] > 2)
						{
							sendTipMessageEx(playerid, COLOR_GRAD1, "Mo¿esz oczyœciæ tylko graczy z 1-2 WL");
							return 1;
						}
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Oczyœci³eœ z zarzutów %s.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Policjant %s oczyœci³ ciê z zarzutów (Wanted Level).", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "HQ: Policjant %s oczyœci³ z zarzutów %s",sendername, giveplayer);
						SendFamilyMessage(1, COLOR_PANICRED, string, true);
						format(string, sizeof(string), "HQ: Policjant %s oczyœci³ z zarzutów %s",sendername, giveplayer);
						SendFamilyMessage(2, COLOR_PANICRED, string, true);
						PoziomPoszukiwania[giveplayerid] = 0;
						SetPlayerWantedLevel(giveplayerid, PoziomPoszukiwania[giveplayerid]);
						ClearCrime(giveplayerid);
						SetPlayerToTeamColor(giveplayerid);
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie ma takiego gracza!");
				}
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w wozie policyjnym ani na komisariacie !");
			}
		}
		else
		{
	    	sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ policjantem / Agentem FBI / Policjantem Stanowym !");
		}
	}//not connected
	return 1;
}

//end
