//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ wyczysc ]------------------------------------------------//
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

YCMD:wyczysc(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    new tmpcar = GetPlayerVehicleID(playerid);
 		if(IsAPolicja(playerid))
		{
			if ((tmpcar != INVALID_VEHICLE_ID && IsACopCar(tmpcar)) || 
			PlayerToPoint(15.0, playerid, 253.9280,69.6094,1003.6406) || 
			PlayerToPoint(20.0, playerid, 246.3568,120.3933,1003.2682) || 
			PlayerToPoint(50, playerid, 1189.5999755859,-1574.6999511719,-54.5 ) || 
			PlayerToPoint(50, playerid, -1672.8372,890.2657,-48.9141 ) || //komisariat LSPD
			PlayerInfo[playerid][pLocal] == 210)
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
