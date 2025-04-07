//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    kurs                                                   //
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
// Data utworzenia: 31.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kurs_Impl(playerid, price)
{
    if(GetPlayerJob(playerid) != JOB_DRIVER && GetPlayerFraction(playerid) != 10)
	{
		MruMessageFail(playerid, "Nie jeste� w pracy kierowcy lub w Korporacji Tranportowej.");
		return 1;
	}

	if(!IsPlayerInAnyVehicle(playerid))
	{
		MruMessageFail(playerid, "Musisz by� w poje�dzie.");
		return 1;
	}

	if(AntySpam[playerid] != 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 7 sekund !");
		return 1;
	}

	if(TransportDuty[playerid] > 0)
	{
		Taxi_FareEnd(playerid);
		return 1;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsVehicleWithTaxometr(vehicleid))
	{
		MruMessageFail(playerid, "W tym poje�dzie nie ma zamontowanego taskometru.");
		return 1;
	}

	if(!CanPlayerUseTaxometr(playerid, vehicleid))
	{
		MruMessageFail(playerid, "Nie masz uprawnie� by korzysta� z taksometru tego pojazdu.");
		return 1;
	}

	if(GetPlayerVehicleSeat(playerid) != 0)
	{
		MruMessageFail(playerid, "Musisz by� kierowc�!");
		return 1;
	}

	new string[128], sendername[MAX_PLAYER_NAME];
	if(IsAMiniBus(vehicleid) || IsABus(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 4 && IsCarOwner(playerid, vehicleid))
		{
			MruMessageFail(playerid, "Potrzebujesz 4 skilla by przewozi� ludzi swoim w�asnym autobusem.");
			return 1;
		}

		new maxPrice = 1000 + 1000 * GetPlayerJobSkill(playerid, JOB_DRIVER);
		if(price < 25 || price > maxPrice) 
		{ 
			MruMessageFailF(playerid, "Cena biletu od $25 do $%d!", maxPrice); 
			return 1; 
		}
		BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= price;
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Kierowca autobusu %s jest na s�u�bie, cena biletu: %d$", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);

		new text3d = CreateDynamic3DTextLabel(sprintf("Bilet: $%d", price), 
			COLOR_YELLOW, 0.0, 0.0, 0.3, 10.0, INVALID_PLAYER_ID, vehicleid);
		MAP_insert_val_val(VehicleFareInfo, _:vehicleid, text3d);
	}
	else if(IsATaxi(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 3)
		{
			MruMessageFail(playerid, "Potrzebujesz 3 skilla by korzysta� z taks�wek.");
			return 1;
		}

		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 4 && IsCarOwner(playerid, vehicleid))
		{
			MruMessageFail(playerid, "Potrzebujesz 4 skilla by przewozi� ludzi swoj� w�asn� taks�wk�.");
			return 1;
		}

		new maxPrice = 100 + 100 * GetPlayerJobSkill(playerid, JOB_DRIVER);
		if(price < 25 || price > maxPrice) 
		{ 
			MruMessageFailF(playerid, "Cena za kilometr od $25 do $%d!", maxPrice); 
			return 1; 
		}
		TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Taks�wkarz %s jest na s�u�bie wpisz /wezwij taxi aby skorzysta� z jego us�ug, koszt %d$ za kilometr", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);

		new text3d = CreateDynamic3DTextLabel(sprintf("Stawka kilometrowa: $%d", price), 
			COLOR_YELLOW, 0.0, 0.0, 0.3, 10.0, INVALID_PLAYER_ID, vehicleid);
		MAP_insert_val_val(VehicleFareInfo, _:vehicleid, text3d);
	}
	else if(IsAPlane(vehicleid) || IsAHeliModel(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 5)
		{
			MruMessageFail(playerid, "Potrzebujesz 5 skilla by przewozi� ludzi samolotem/helikopterem.");
			return 1;
		}

		new maxPrice = 1000 + 1000 * GetPlayerJobSkill(playerid, JOB_DRIVER);
		if(price < 25 || price > maxPrice) 
		{ 
			MruMessageFailF(playerid, "Cena za kilometr od $25 do $%d!", maxPrice); 
			return 1; 
		}
		TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Pilot %s jest na s�u�bie wpisz /wezwij heli aby skorzysta� z jego us�ug, koszt %d$ za kilometr", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);
		
		new text3d = CreateDynamic3DTextLabel(sprintf("Stawka kilometrowa: $%d", price), 
			COLOR_YELLOW, 0.0, 0.0, 0.3, 10.0, INVALID_PLAYER_ID, vehicleid);
		MAP_insert_val_val(VehicleFareInfo, _:vehicleid, text3d);
	}
	else if(IsATrain(vehicleid))
	{
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Maszynista %s jest na s�u�bie i kursuje po stanie San Andreas.", sendername);
		OOCNews(COLOR_YELLOW,string);
	}
	else
	{
		MruMessageFail(playerid, "Ten pojazd nie jest przystosowany do komercyjnego transportu os�b.");
		return 1;
	}

	SetPlayerColor(playerid, COLOR_YELLOW);
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",7000,0,"d",playerid);
    return 1;
}

//end