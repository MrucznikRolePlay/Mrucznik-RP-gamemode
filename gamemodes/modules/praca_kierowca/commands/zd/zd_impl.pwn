//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     zd                                                    //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_zd_Impl(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerFraction(playerid) != FRAC_KT && GetPlayerJob(playerid) != JOB_DRIVER)
	{
		MruMessageFail(playerid, "Nie jesteœ kierowc¹ lub pracownikiem Korporacji Transportowej!");
		return 1;
	}
	
	if(!IsAPublicTransport(vehicleid))
	{
		MruMessageFail(playerid, "Nie jesteœ w autobusie !");
		return 1;
	}

	new route = DrivingBusRoute[playerid];
	if(route == -1)
	{
		MruMessageFail(playerid, "Nie wykonujesz aktualnie ¿adnej trasy autobusowej.");
		return 1;
	}

	if(BusDoors[playerid] == 0)
	{
		MruMessageFail(playerid, "Drzwi autobusu s¹ ju¿ zamkniête !");
		return 1;
	}

	new timerDelay = 1000;
	if(BusRoute[route][br_Time] > 0)
	{
		new timeDiff = gettime() - BusStartTime[playerid];
		new stops = GetRouteBusStopsCount(route);
		new timePerStop = (BusRoute[route][br_Time] / 2) / stops;
		new okDiff = timePerStop * CurrentBusStop[playerid];
		if(timeDiff < okDiff)
		{
			timerDelay = min(1000, okDiff - timeDiff);
		}
	}

	ChatMe(playerid, "naciska guzik i powoli zamyka drzwi");
	defer ZamykanieDrzwi[timerDelay](playerid);
	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Trwa zamykanie drzwi...", 4000, 3);
    return 1;
}


timer ZamykanieDrzwi[1000](playerid) 
{
	TogglePlayerControllable(playerid, 1);
	PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~g~Drzwi zamkniete!", 4000, 3);
	BusDoors[playerid] = 0;
	return 1;
}

//end