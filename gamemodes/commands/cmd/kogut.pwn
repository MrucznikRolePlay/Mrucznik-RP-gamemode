//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ kogut ]-------------------------------------------------//
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

YCMD:kogut(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(IsPlayerInAnyVehicle(playerid))
	{
	    new playerState = GetPlayerState(playerid);
        if(playerState == PLAYER_STATE_DRIVER)
        {
            new veh = GetPlayerVehicleID(playerid);
		    if(IsAPolicja(playerid) || IsABOR(playerid))
		    {
		        if(PlayerInfo[playerid][pRank] >= 1)
		        {
					if(IsAKogutCar(veh))
			        {
						if(OnDuty[playerid] == 1)
						{
					        if(VehicleUID[veh][vSiren] != 0)
					        {
							    DestroyDynamicObject(VehicleUID[veh][vSiren]);
							    VehicleUID[veh][vSiren] = 0;
           						format(string, sizeof(string), "* %s zdejmuje kogut z dachu i chowa.", sendername);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					        }
					        else
					        {
							    PrzyczepKogut(playerid, veh);
								format(string, sizeof(string), "* %s przyczepia kogut na dach samochodu.", sendername);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							}
							sendErrorMessage(playerid, "OSTRZE¯ENIE: Nadu¿ywanie kogutów skutkuje natychmiastowym wyrzuceniem z frakcji.");
						}
						else
						{
						    sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie.");
						}
					}
					else
					{
					    sendErrorMessage(playerid, "Na tym pojeŸdzie nie mo¿na przyczepiæ koguta.");
			            return 1;
					}
                }
				else
				{
				    sendErrorMessage(playerid, "Potrzebujesz 1 lub wiêkszej rangi!");
     				return 1;
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie jesteœ z PD!");
            	return 1;
			}
        }
		else
		{
		    sendErrorMessage(playerid, "Musisz byæ kierowc¹!");
        	return 1;
		}
	}
	else
	{
        sendErrorMessage(playerid, "Musisz byæ w wozie");
        return 1;
	}
	return 1;
}
