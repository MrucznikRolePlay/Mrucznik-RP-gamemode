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
	if(!CanPlayerUseTaxometr(playerid, vehicleid))
	{
		MruMessageFail(playerid, "W tym pojeŸdzie nie ma zamontowanego taskometru lub nie masz uprawnieñ by z niego korzystaæ.");
		return 1;
	}

	new string[128], sendername[MAX_PLAYER_NAME];
	if(IsVehicleWithTaxometr(vehicleid))
	{
		new maxPrice = 100 + 100 * GetPlayerJobSkill(playerid, JOB_DRIVER);

		if(IsAMiniBus(vehicleid))
		{
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
		else if(GetVehicleModel(vehicleid) == 431 || GetVehicleModel(vehicleid) == 437)
		{
			if(price < 25 || price > maxPrice) 
			{ 
				MruMessageFailF(playerid, "Cena biletu od $25 do $%d!", maxPrice); 
				return 1; 
			}
			BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= price;
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: $%d.", sendername, TransportValue[playerid]);
			OOCNews(TEAM_GROVE_COLOR,string);
		}
		else if(IsATrain(vehicleid))
		{
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "Maszynista %s jest na s³u¿bie i kursuje po stanie San Andreas.", sendername);
			OOCNews(COLOR_YELLOW,string);
		}
		else if(IsAPlane(vehicleid))
		{
			if(price < 900 || price > 5000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $900 do $5000!"); return 1; }
			TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "Pilot %s jest na s³u¿bie wpisz /wezwij heli aby skorzystaæ z jego us³ug, koszt %d$", sendername, TransportValue[playerid]);
			OOCNews(COLOR_YELLOW,string);
		}
		else
		{
			if(GetVehicleModel(vehicleid) == 418 || GetVehicleModel(vehicleid) == 525 || GetVehicleModel(vehicleid) == 402 || GetVehicleModel(vehicleid) == 541) return sendTipMessageEx(playerid,COLOR_GREY,"W tym pojeŸdzie nie mo¿esz wejœæ na s³u¿bê !");
			if(price < 150 || price > 2000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $150 do $2000 !"); return 1; }
			TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = price;
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "Taksówkarz %s jest na s³u¿bie wpisz /wezwij taxi aby skorzystaæ z jego us³ug, koszt %d$", sendername, TransportValue[playerid]);
			OOCNews(COLOR_YELLOW,string);
		}

		SetPlayerColor(playerid, COLOR_YELLOW);
	}
	else if(IsATrain(vehicleid))//poci¹gi
	{
		format(string, sizeof(string), "Koleje Brown Streak rozpoczê³y trasê po stanie San Andreas!");
		OOCNews(COLOR_YELLOW,string);
	}
	else
	{
		sendTipMessageEx(playerid,COLOR_GREY,"W tym pojeŸdzie nie mo¿esz wejœæ na s³u¿bê !");
		return 1;
	}

	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",7000,0,"d",playerid);
    return 1;
}

//end