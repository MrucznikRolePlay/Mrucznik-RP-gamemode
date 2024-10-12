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
command_poddajsie_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 1)
	 	{
	 	    new playa;
			if( sscanf(params, "k<fix>", playa))
			{
				sendTipMessage(playerid, "U¿yj /poddajsie [Nick/ID]");
				SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: ta komenda proponuje poddanie siê przestêpcy");
				return 1;
			}


			if(IsPlayerConnected(playa))
		    {
   				if(playa != INVALID_PLAYER_ID)
			    {
				    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
					{
					    if(PoziomPoszukiwania[playa] >= 2)
					    {
					        if(playa != playerid)
					        {
					            if(lowcaz[playerid] == playa)
					            {
									new reward = PoziomPoszukiwania[playa] * 10000;
									new punishment = PoziomPoszukiwania[playa] * 1000;
									new bail = PoziomPoszukiwania[playa] * 16000;

							        GetPlayerName(playerid, sendername, sizeof(sendername));
				        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							        format(string, sizeof(string), "* £owca Nagród %s proponuje ci poddanie siê i trafienie do wiêzienia z kar¹ %d$ i kaucj¹ %d$. ", sendername, punishment, bail);
							        SendClientMessage(playa, COLOR_LIGHTBLUE, string);
									SendClientMessage(playa, COLOR_LIGHTBLUE, "Aby siê zgodziæ wpisz /poddajesie.");
							        format(string, sizeof(string), "* Zaproponowa³eœ %s poddanie siê, jeœli zostanie ono akceptowane zarobisz %d$",giveplayer, reward);
							        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							        poddaje[playa] = 1;
									lowcap[playa] = playerid;
									
									format(string, sizeof(string), "%s [%d] zaoferowa³ poddanie siê dla %s [%d]", GetNick(playerid), playerid, GetNick(playa), playa);
									SendMessageToAdmin(string, COLOR_P@);
								}
								else
								{
								    sendErrorMessage(playerid, "Nie masz zlecenia na tego gracza");
								}
							}
							else
							{
								sendErrorMessage(playerid, "Nie mo¿esz siê poddaæ samemu sobie");
                			}
					    }
					    else
					    {
					    	sendErrorMessage(playerid, "Ten gracz nie ma WL");
                		}
					}
					else
				    {
				    	sendErrorMessage(playerid, "Ten gracz jest za daleko");
               		}
				}
				else
				{
                    sendErrorMessage(playerid, "Taki gracz nie istnieje");
                }
			}
		}
		else
	   	{
	   		sendErrorMessage(playerid, "Nie jesteœ ³owc¹ nagród");
		}
	}
	return 1;
}

//end
