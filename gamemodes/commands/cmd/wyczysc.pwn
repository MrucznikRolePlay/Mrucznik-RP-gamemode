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

CMD:clear(playerid, params[]) return cmd_wyczysc(playerid, params);
CMD:oczysc(playerid, params[]) return cmd_wyczysc(playerid, params);
CMD:wyczysc(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    new tmpcar = GetPlayerVehicleID(playerid);
 		if(IsACop(playerid))
		{
			if (IsACopCar(tmpcar) || PlayerToPoint(15.0, playerid, 253.9280,69.6094,1003.6406) || PlayerToPoint(20.0, playerid, 246.3568,120.3933,1003.2682) || PlayerToPoint(50, playerid, 1189.5999755859,-1574.6999511719,-54.5 ) || PlayerInfo[playerid][pLocal] == 210)
			{
				new giveplayerid;
				if( sscanf(params, "k<fix>",giveplayerid))
				{
					sendTipMessage(playerid, "U¿yj /oczysc [playerid/CzêœæNicku]");
					return 1;
				}

				if(PoziomPoszukiwania[giveplayerid] > 1)
				{
					sendTipMessageEx(playerid, COLOR_GRAD1, "Mo¿esz oczyœciæ tylko graczy z 1 WL");
					return 1;
				}

				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Oczyœci³eœ z zarzutów %s.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Policjant %s oczyœci³ ciê z zarzutów (Wanted Level).", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "HQ: Polijant %s oczyœci³ z zarzutów %s",sendername, giveplayer);
						SendFamilyMessage(1, COLOR_PANICRED, string);
						format(string, sizeof(string), "HQ: Polijant %s oczyœci³ z zarzutów %s",sendername, giveplayer);
						SendFamilyMessage(2, COLOR_PANICRED, string);
						PoziomPoszukiwania[giveplayerid] = 0;
						ClearCrime(giveplayerid);
						if(gTeam[giveplayerid]==4)
						{
						    gTeam[giveplayerid] = 3;
						    SetPlayerToTeamColor(giveplayerid);
						}
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
