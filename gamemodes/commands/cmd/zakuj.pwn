//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zakuj ]-------------------------------------------------//
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

YCMD:zakuj(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(gTeam[playerid] == 2 || IsACop(playerid) || IsABOR(playerid))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /skuj [playerid/CzêœæNicku]");
				return 1;
			}

		    if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(gTeam[giveplayerid] == 2 || IsACop(giveplayerid))
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz skuæ policjanta !");
				        return 1;
			        }
				    if(PlayerCuffed[giveplayerid] > 0)
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Gracz jest ju¿ skuty !");
				        return 1;
				    }
					if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    new car = GetPlayerVehicleID(playerid);
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz skuæ samego siebie!"); return 1; }
					    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(giveplayerid, car))
					    {
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
					        format(string, sizeof(string), "* Zosta³eœ skuty przez %s, nie mo¿esz siê ruszaæ.", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Sku³eœ %s, nie mo¿e siê teraz ruszaæ.", giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* %s Zakuwa rêce %s, aby nigdzie nie uciek³.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GameTextForPlayer(giveplayerid, "~r~Skuty", 2500, 3);
							TogglePlayerControllable(giveplayerid, 0);
							PlayerCuffed[giveplayerid] = 2;
							PlayerCuffedTime[giveplayerid] = 180;
					    }
					    else
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Gracz nie jest w twoim pojeŸdzie lub nie jesteœ kierowc¹ !");
					        return 1;
					    }
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ z Policji / FBI / SASD !");
		}
	}
	return 1;
}
