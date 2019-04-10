//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ulecz ]-------------------------------------------------//
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

CMD:heal(playerid, params[]) return cmd_ulecz(playerid, params);
CMD:ulecz(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
	{
		new giveplayerid, moneys;
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if( sscanf(params, "k<fix>d", giveplayerid, moneys))
		{
			if(PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pDom] || PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pWynajem] && Dom[PlayerInfo[playerid][pDom]][hUL_D] != 0)
			{
				new dom = PlayerInfo[playerid][pDom];
				if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]))
				{
					if(Dom[dom][hApteczka] != 0)
					{
						new Float:HP;
						GetPlayerHealth(playerid, HP);
						if(HP >= 100.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz apteczki.");
						    return 1;
						}
						else
						{
						    SetPlayerHealth(playerid, 100.0);
						    //Dom[dom][hMagazyn]--;
                            sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowej apteczki.");
                            return 1;
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GRAD2, "W tym domu nie ma apteczki.");
					    return 1;
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ w domu.");
				    return 1;
				}
			}
			else
			{
				sendTipMessage(playerid, "U¿yj /ulecz [playerid/CzêœæNicku] [cena]");
				return 1;
			}
		}

		if(moneys < 0 || moneys > 0) { sendTipMessageEx(playerid, COLOR_GREY, "Pieni¹dze za leczenie pobierz od gracza rêcznie."); return 1; }
		if (giveplayerid == playerid)
		{
			sendTipMessageEx(playerid, COLOR_GRAD1, "Nie mo¿esz uleczyæ samego siebie!");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
		    if(giveplayerid != INVALID_PLAYER_ID)
		    {
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new giveambu = GetPlayerVehicleID(giveplayerid);
				new playambu = GetPlayerVehicleID(playerid);
				if(gTeam[playerid] == TEAM_CYAN||PlayerInfo[playerid][pMember]==4||PlayerInfo[playerid][pLider]==4)//model
				{
					if (IsAnAmbulance(playambu) && playambu == giveambu)
					{
						new Float:tempheal;
						GetPlayerHealth(giveplayerid,tempheal);
						if(tempheal >= 100.0)
						{
							sendTipMessageEx(playerid, TEAM_GREEN_COLOR,"Ta osoba nie potrzebuje leczenia.");
							return 1;
						}
						format(string, sizeof(string), "~y~Uleczyles ~n~~w~%s~n~~g~$%d", giveplayer,moneys);
						GameTextForPlayer(playerid, string, 5000, 1);
						DajKase(playerid,moneys);
						DajKase(giveplayerid,-moneys);
						new hp = 0;
					    if(PlayerInfo[playerid][pPainPerk] > 0)
					    {
					        hp = 20 * PlayerInfo[playerid][pPainPerk]; hp += 100;
							SetPlayerHealth(giveplayerid, hp);
					    }
					    else
					    {
					        hp = 100;
					        SetPlayerHealth(giveplayerid, 100);
					    }
						PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
						PlayerPlaySound(giveplayerid, 1150, 0.0, 0.0, 0.0);
						format(string, sizeof(string), "Zostales uzdrowiony o %d puntow zycia koszt -$%d",hp,moneys);
						sendTipMessageEx(giveplayerid, TEAM_GREEN_COLOR,string);
						if(STDPlayer[giveplayerid] > 0)
			            {
							STDPlayer[giveplayerid] = 0;
							sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Nie jesteœ ju¿ zara¿ony chorob¹ dziêki pomocy lekarza !");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie jesteœ w pojeŸdzie medycznym / Chopper !");
						return 1;
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie jesteœ medykiem !");
					return 1;
				}
			}
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

