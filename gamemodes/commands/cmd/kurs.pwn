//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kurs ]-------------------------------------------------//
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

YCMD:kurs(playerid, params[], help)
{
	if(PlayerInfo[playerid][pJob] == 10 || PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
	{
		if(GetPlayerState(playerid) == 2)
		{
			if(AntySpam[playerid] != 0)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 7 sekund !");
				return 1;
			}

			new vehicleid = GetPlayerVehicleID(playerid);
			new string[128], moneys, sendername[MAX_PLAYER_NAME];

			//stare:
			if(TransportDuty[playerid] > 0)
			{
                Taxi_FareEnd(playerid);
				return 1;
			}
			if(IsATaxiCar(vehicleid))
			{
                if(JobDuty[playerid] == 0) return sendTipMessageEx(playerid, COLOR_GREY, "Nie jestes na s³u¿bie!");
				sscanf(params, "D(0)", moneys);
                if(IsAMiniBus(vehicleid))
		  	    {
                    if(moneys < 25 || moneys > 1500) { sendTipMessageEx(playerid, COLOR_GREY, "Cena biletu od $25 do $1500 !"); return 1; }
                    BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
					GetPlayerName(playerid,sendername,sizeof(sendername));
					format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
					OOCNews(COLOR_YELLOW,string);
                }
                else if(GetVehicleModel(vehicleid) == 431 || GetVehicleModel(vehicleid) == 437)
                {
					return sendTipMessageEx(playerid,COLOR_GREY,"W tym pojeŸdzie nie mo¿esz wejœæ na s³u¿bê !"); 
					// na proœbê lidera blokada busów
                    /*if(moneys < 25 || moneys > 2500) { sendTipMessageEx(playerid, COLOR_GREY, "Cena biletu od $25 do $2500 !"); return 1; }
					BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
					GetPlayerName(playerid,sendername,sizeof(sendername));
					format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: $%d.", sendername, TransportValue[playerid]);
					OOCNews(TEAM_GROVE_COLOR,string);*/
                }
                else if(IsATrain(vehicleid))
                {
					GetPlayerName(playerid,sendername,sizeof(sendername));
					format(string, sizeof(string), "Maszynista %s jest na s³u¿bie i kursuje po stanie San Andreas.", sendername);
					OOCNews(COLOR_YELLOW,string);
                }
                else if(IsAPlane(vehicleid))
                {
                    if(moneys < 900 || moneys > 5000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $900 do $5000!"); return 1; }
    				TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = moneys;
    				GetPlayerName(playerid,sendername,sizeof(sendername));
    				format(string, sizeof(string), "Pilot %s jest na s³u¿bie wpisz /wezwij heli aby skorzystaæ z jego us³ug, koszt %d$", sendername, TransportValue[playerid]);
    				OOCNews(COLOR_YELLOW,string);
                }
                else
                {
					if(GetVehicleModel(vehicleid) == 418 || GetVehicleModel(vehicleid) == 525 || GetVehicleModel(vehicleid) == 402 || GetVehicleModel(vehicleid) == 541) return sendTipMessageEx(playerid,COLOR_GREY,"W tym pojeŸdzie nie mo¿esz wejœæ na s³u¿bê !");
    				if(moneys < 150 || moneys > 2000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $150 do $2000 !"); return 1; }
    				TaxiDrivers += 1; TransportDuty[playerid] = 1; TransportValue[playerid] = moneys;
    				GetPlayerName(playerid,sendername,sizeof(sendername));
    				format(string, sizeof(string), "Taksówkarz %s jest na s³u¿bie wpisz /wezwij taxi aby skorzystaæ z jego us³ug, koszt %d$", sendername, TransportValue[playerid]);
    				OOCNews(COLOR_YELLOW,string);
                }
			}
			else if(IsAMiniBus(vehicleid))
			{
				if(PlayerInfo[playerid][pJob] == 10)
				{
					if( sscanf(params, "d", moneys))
					{
						sendTipMessage(playerid, "U¿yj /fare [cena]");
						return 1;
					}
					if(PlayerInfo[playerid][pCarSkill] >= 51 && PlayerInfo[playerid][pCarSkill] <= 101)
					{
						if(moneys < 25 || moneys > 300) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $25 do $300 !"); return 1; }
						BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
						GetPlayerName(playerid,sendername,sizeof(sendername));
						format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
						OOCNews(COLOR_YELLOW,string);
						return 1;
					}
					if(PlayerInfo[playerid][pCarSkill] >= 101  && PlayerInfo[playerid][pCarSkill] <= 201)
					{
						if(moneys < 25 || moneys > 400) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $25 do $400 !"); return 1; }
						BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
						GetPlayerName(playerid,sendername,sizeof(sendername));
						format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
						OOCNews(COLOR_YELLOW,string);
						return 1;
					}
					if(PlayerInfo[playerid][pCarSkill] >= 201  && PlayerInfo[playerid][pCarSkill] <= 401)
					{
						if(moneys < 25 || moneys > 600) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $25 do $600 !"); return 1; }
						BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
						GetPlayerName(playerid,sendername,sizeof(sendername));
						format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
						OOCNews(COLOR_YELLOW,string);
						return 1;
					}
					if(PlayerInfo[playerid][pCarSkill] >= 401)
					{
						if(moneys < 25 || moneys > 1200) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $25 do $1200 !"); return 1; }
						BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
						GetPlayerName(playerid,sendername,sizeof(sendername));
						format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
						OOCNews(COLOR_YELLOW,string);
						return 1;
					}
					else
					{
						if(moneys < 25 || moneys > 200) { sendTipMessageEx(playerid, COLOR_GREY, "Cena kursu od $25 do $200 !"); return 1; }
						BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
						GetPlayerName(playerid,sendername,sizeof(sendername));
						format(string, sizeof(string), "Kierowca autobusu %s jest na s³u¿bie, cena biletu: %d$", sendername, TransportValue[playerid]);
						OOCNews(COLOR_YELLOW,string);
					}
				}
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
		}
		else
		{
			sendTipMessageEx(playerid,COLOR_GREY,"Nie jesteœ kierowc¹ !");
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid,"Nie jesteœ taksówkarzem / busiarzem !");
		return 1;
	}
	return 1;
}
