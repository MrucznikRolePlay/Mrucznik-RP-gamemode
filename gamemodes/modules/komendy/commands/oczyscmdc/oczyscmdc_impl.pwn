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
command_oczyscmdc_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 2)
	 	{
	    	new playa;
			if( sscanf(params, "k<fix>", playa))
			{
				sendTipMessage(playerid, "U¿yj /oczyscmdc [Nick/ID] (koszt -300$)");
				SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: ta komenda czysci kartoteki policyjne gracza (koszt -300$)");
				return 1;
			}


			if(IsPlayerConnected(playa))
		    {
   				if(playa != INVALID_PLAYER_ID)
			    {
				    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
					{
					    if(kaska[playerid] > 300)
						{
		        			GetPlayerName(playerid, sendername, sizeof(sendername));
		        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		        			format(string, sizeof(string), "* Oczyœci³eœ kartoteki gracza %s (-300$)",giveplayer);
						    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					        format(string, sizeof(string), "* Prawnik %s oczyœci³ kartoteki Policji na twój temat",sendername);
					        SendClientMessage(playa, COLOR_LIGHTBLUE, string);
					        format(string, sizeof(string),"* %s wykonuje parê telefonów i oczyszcza kartoteki %s.", sendername, giveplayer);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            ZabierzKase(playerid, 300);
                            format(string, sizeof(string), "~r~-$%d", 300);
							GameTextForPlayer(playerid, string, 5000, 1);
                    		PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
                    		ClearCrime(playa);
						}
						else
						{
						    sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci pieniêdzy ($300).");
						}
                    }
					else
					{
					    sendErrorMessage(playerid, "Gracz jest za daleko.");
					}
				}
				else
				{
				    sendErrorMessage(playerid, "Nie ma takiego gracza.");
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ prawnikiem.");
		}
	}
	return 1;
}

//end
