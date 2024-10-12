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
command_setveh_Impl(playerid, params[256])
{
    new string[256];

    if(IsPlayerConnected(playerid))
    {
		new para1, nrcar, level;
		if( sscanf(params, "k<fix>dd", para1, nrcar, level))
		{
			sendTipMessage(playerid, "U¿yj /zmienauto [playerid/CzêœæNicku] [Nr. z listy (nie UID!)] [UID pojazdu]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 2000 || Uprawnienia(playerid, ACCESS_EDITCAR))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            if(nrcar >= 1 && nrcar <= MAX_CAR_SLOT)
					{
                        new lID = -1;
                        if(level != 0)
                        {
                            lID = Car_GetIDXFromUID(level);
                            if(lID == -1)
                            {
                                sendTipMessage(playerid, "Pojazd nie by³ wczytany do systemu, inicjalizacja ...", COLOR_GRAD2);
                                lID = Car_LoadEx(level);
                                if(lID == -1) return SendClientMessage(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
                            }
                        }
                        if(PlayerInfo[para1][pCars][nrcar-1] != 0)
                        {
                            format(string, 256, "Gracz posiada³ auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, 256, "Admin %s zmieni³ Ci auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", GetNickEx(playerid), CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            SendClientMessage(para1, COLOR_LIGHTBLUE, string);

                            CarData[PlayerInfo[para1][pCars][nrcar-1]][c_OwnerType] = INVALID_CAR_OWNER;
                            Car_Save(PlayerInfo[para1][pCars][nrcar-1], CAR_SAVE_OWNER);
                        }

                        if(PlayerInfo[para1][pCars][nrcar-1] != 0)
                        {
                            Log(serverLog, WARNING, "Gracz %s posiada³ auto %s na slocie %d. Pojazd zostaje bez w³asciciela.", 
                                GetPlayerLogName(para1),
                                GetCarDataLogName(PlayerInfo[para1][pCars][nrcar-1]),
                                nrcar);
                        }

                        if(level != 0)
                        {
    						format(string, sizeof(string), " Ustawiono pojazd %s (%d) graczowi %s.", VehicleNames[CarData[lID][c_Model]-400],level,GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						Log(adminLog, INFO, "Admin %s da³ %s auto %s na slot %d", 
                                GetPlayerLogName(playerid),
                                GetPlayerLogName(para1),
                                GetCarDataLogName(lID),
                                nrcar);

                            PlayerInfo[para1][pCars][nrcar-1] = lID;

                            CarData[lID][c_OwnerType] = CAR_OWNER_PLAYER;
                            CarData[lID][c_Owner] = PlayerInfo[para1][pUID];
                            Car_Save(lID, CAR_SAVE_OWNER);
                        }
                        else
                        {
                            format(string, sizeof(string), " Usuniêto pojazd ze slotu %d graczowi %s.", nrcar, GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						Log(adminLog, INFO, "Admin %s usun¹³ %s auto %s ze slotu %d", 
                                GetPlayerLogName(playerid),
                                GetPlayerLogName(para1),
                                GetCarDataLogName(lID),
                                nrcar);

                            PlayerInfo[para1][pCars][nrcar-1] = 0;
                        }
					}
					else
					{
					    sendTipMessage(playerid, "Numer pojazdu od 1!");
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
