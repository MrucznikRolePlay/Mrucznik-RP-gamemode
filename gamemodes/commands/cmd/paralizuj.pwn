//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ paralizuj ]-----------------------------------------------//
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


CMD:paralizuj(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(gTeam[playerid] == 2 || IsACop(playerid) || IsABOR(playerid))
		{
		    if(IsPlayerInAnyVehicle(playerid))
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz tego u¿yæ w pojeŸdzie !");
		        return 1;
		    }
		    new suspect;
            sscanf(params, "K<fix>(-1)", suspect);
            if(suspect == -1) suspect = GetClosestPlayer(playerid);
		    if(IsPlayerConnected(suspect))
			{
			    if(PlayerCuffed[suspect] > 0 || zakuty[suspect] >= 1)
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Gracz jest aktualnie zparali¿owany !");
			        return 1;
			    }
			    if(Spectate[suspect] != INVALID_PLAYER_ID)
				{
					sendTipMessageEx(playerid, COLOR_GRAD1, "Nikogo nie ma przy tobie!");
					return 1;
				}
			    if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
				{
				    if(GetPVarInt(playerid, "tazer") == 1)
				    {
					    if(IsACop(suspect) && OnDuty[suspect] == 1)
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz zparali¿owaæ PD / FBI / NG na s³u¿bie!");
					        return 1;
					    }
					    if(IsPlayerInAnyVehicle(suspect))
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Poszukiwany jest w pojeŸdzie, wyrzuæ go !");
					        return 1;
					    }
					    if(GetPlayerWeapon(suspect) >= 22)
      					{
    			    		sendTipMessageEx(playerid, COLOR_GRAD1, "Decydujesz siê nie podchodziæ do uzbrojonego przestêpcy, gdyz uwa¿asz to za zbyt niebezpiczne!");
      			    		return 1;
	       				}
					    GetPlayerName(suspect, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s wyci¹ga paralizator z kabury i odbezpiecza.", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						format(string, sizeof(string), "* Zosta³eœ sparali¿owany przez %s na 20 sekund.", sendername);
						SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Zparali¿owa³eœ %s na 30 sekund.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s strzela paralizatorem w %s, i parali¿uje go.", sendername ,playerid);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						GameTextForPlayer(suspect, "~r~Paraliz", 2500, 3);
						TogglePlayerControllable(suspect, 0);
						PlayerPlaySound(suspect, 6300, 0.0, 0.0, 0.0);
						PlayerPlaySound(playerid, 6300, 0.0, 0.0, 0.0);
						PlayerCuffed[suspect] = 1;
						PlayerCuffedTime[suspect] = 30;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Musisz mieæ wyjêty tazer! (/wtazer)");
					}
	            }
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Nikogo nie ma przy tobie!");
				    return 1;
				}
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z Policji / FBI / SASD !");
		}
	}//not connected
    return 1;
}



