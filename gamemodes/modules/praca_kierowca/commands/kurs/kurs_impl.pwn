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
    if(GetPlayerJob(playerid) != JOB_DRIVER && PlayerInfo[playerid][pMember] != 10 && PlayerInfo[playerid][pLider] == 10)
	{
		MruMessageFail(playerid, "Nie jesteœ kierowc¹ taksówki/autobusu.");
		return 1;
	}

	if(!IsPlayerInAnyVehicle(playerid))
	{
		MruMessageFail(playerid, "Musisz byæ w pojeŸdzie.");
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
		MruMessageFail(playerid, "W tym pojeŸdzie nie ma zamontowanego taskometru.");
		return 1;
	}

	if(!CanPlayerUseTaxometr(playerid, vehicleid))
	{
		MruMessageFail(playerid, "Nie masz uprawnieñ by korzystaæ z taksometru tego pojazdu.");
		return 1;
	}

	new string[128], sendername[MAX_PLAYER_NAME];
	if(IsAMiniBus(vehicleid) || IsABus(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 4 && IsCarOwner(playerid, vehicleid))
		{
			MruMessageFail(playerid, "Potrzebujesz 4 skilla by przewoziæ ludzi swoim w³asnym autobusem.");
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
		format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);
	}
	else if(IsATaxi(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 3)
		{
			MruMessageFail(playerid, "Potrzebujesz 3 skilla by korzystaæ z taksówek.");
			return 1;
		}

		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 4 && IsCarOwner(playerid, vehicleid))
		{
			MruMessageFail(playerid, "Potrzebujesz 4 skilla by przewoziæ ludzi swoj¹ w³asn¹ taksówk¹.");
			return 1;
		}

		new maxPrice = 100 + 100 * GetPlayerJobSkill(playerid, JOB_DRIVER);
		if(price < 25 || price > maxPrice) 
		{ 
			MruMessageFailF(playerid, "Cena biletu od $25 do $%d!", maxPrice); 
			return 1; 
		}
		TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Taksówkarz %s jest na s³u¿bie wpisz /wezwij taxi aby skorzystaæ z jego us³ug, koszt %d$ za kilometr", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);
	}
	else if(IsAPlane(vehicleid) || IsAHeliModel(vehicleid))
	{
		if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 5)
		{
			MruMessageFail(playerid, "Potrzebujesz 5 skilla by przewoziæ ludzi samolotem/helikopterem.");
			return 1;
		}

		new maxPrice = 1000 + 1000 * GetPlayerJobSkill(playerid, JOB_DRIVER);
		if(price < 25 || price > maxPrice) 
		{ 
			MruMessageFailF(playerid, "Cena biletu od $25 do $%d!", maxPrice); 
			return 1; 
		}
		TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Pilot %s jest na s³u¿bie wpisz /wezwij heli aby skorzystaæ z jego us³ug, koszt %d$ za kilometr", sendername, TransportValue[playerid]);
		OOCNews(COLOR_YELLOW,string);
	}
	else if(IsATrain(vehicleid))
	{
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Maszynista %s jest na s³u¿bie i kursuje po stanie San Andreas.", sendername);
		OOCNews(COLOR_YELLOW,string);
	}
	else
	{
		MruMessageFail(playerid, "Ten pojazd nie jest przystosowany do komercyjnego transportu osób.");
		return 1;
	}

	SetPlayerColor(playerid, COLOR_YELLOW);
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",7000,0,"d",playerid);
    return 1;
}

//end