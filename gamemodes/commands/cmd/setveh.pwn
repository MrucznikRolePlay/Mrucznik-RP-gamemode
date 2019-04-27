//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ setveh ]------------------------------------------------//
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

YCMD:setveh(playerid, params[], help)
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

		if (PlayerInfo[playerid][pAdmin] >= 2000)
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
                            format(string, 256, "Admin %s zmieni³ Ci auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", GetNick(playerid), CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            SendClientMessage(para1, COLOR_LIGHTBLUE, string);

                            CarData[PlayerInfo[para1][pCars][nrcar-1]][c_OwnerType] = INVALID_CAR_OWNER;
                            Car_Save(PlayerInfo[para1][pCars][nrcar-1], CAR_SAVE_OWNER);
                        }

                        if(PlayerInfo[para1][pCars][nrcar-1] != 0)
                        {
                            format(string, 256, "Gracz posiada³ auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            StatsLog(string);
                        }

                        if(level != 0)
                        {
    						format(string, sizeof(string), " Ustawiono pojazd %s (%d) graczowi %s.", VehicleNames[CarData[lID][c_Model]-400],level,GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						format(string, sizeof(string), "%s dal %s auto %s UID %d na slot %d /setcar", GetNick(playerid), GetNick(para1), VehicleNames[CarData[lID][c_Model]-400], level, nrcar);
    						StatsLog(string);

                            PlayerInfo[para1][pCars][nrcar-1] = lID;

                            //Car_SortPlayerCars(para1);

                            CarData[lID][c_OwnerType] = CAR_OWNER_PLAYER;
                            CarData[lID][c_Owner] = PlayerInfo[para1][pUID];
                            Car_Save(lID, CAR_SAVE_OWNER);
                        }
                        else
                        {
                            format(string, sizeof(string), " Usuniêto pojazd ze slotu %d graczowi %s.", nrcar, GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						format(string, sizeof(string), "%s usun¹³ pojazd %s ze slotu %d /setcar", GetNick(playerid), GetNick(para1), nrcar);
    						StatsLog(string);

                            PlayerInfo[para1][pCars][nrcar-1] = 0;

                            //Car_SortPlayerCars(para1);
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
