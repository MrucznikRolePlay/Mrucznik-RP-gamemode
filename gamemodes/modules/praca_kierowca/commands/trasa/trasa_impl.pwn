//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   trasa                                                   //
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
command_trasa_Impl(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerFraction(playerid) != FRAC_KT && GetPlayerJob(playerid) != JOB_DRIVER)
	{
		MruMessageFail(playerid, "Nie jeste� kierowc� lub pracownikiem Korporacji Transportowej!");
		return 1;
	}
	
	if(!IsAPublicTransport(vehicleid))
	{
		MruMessageFail(playerid, "Nie jeste� w autobusie !");
		return 1;
	}

	new route = DrivingBusRoute[playerid];
	if(route != -1)
	{
		MruMessageFail(playerid, "Wykonujesz ju� tras� autobusow�, je�li chcesz j� zako�czy� i zmieni�, wpisz /zakoncztrase.");
		return 1;
	}

	ShowTrasaDialog(playerid);
    return 1;
}


ShowTrasaDialog(playerid)
{
	new string[256 * MAX_BUS_ROUTES];
	strcat(string, "Linia\tSkill\tSkill+1\tZysk\tCzas\tPrzystank�w\n");
	for(new i; i<MAX_BUS_ROUTES; i++)
	{
		if(BusRoute[i][br_Enabled])
		{
			new busStops = GetRouteBusStopsCount(i);
			strcat(string, sprintf(INCOLOR_DIALOG"%s\t"INCOLOR_WHITE"%d\t"INCOLOR_WHITE"%d%%\t"INCOLOR_GREEN"%d$\t"INCOLOR_WHITE"%dmin\t"INCOLOR_WHITE"%d\n", 
				BusRoute[i][br_Name], 
				BusRoute[i][br_Skill],  
				BusRoute[i][br_SkillChance],
				BusRoute[i][br_MoneyPerStop] * busStops,
				BusRoute[i][br_Time] / 60,
				busStops));
		}
		else
		{
			strcat(string, INCOLOR_RED"Linia nieaktywna\n");
		}
	}
	ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz tras� autobusow�", 
		string, "Wybierz", "Wyjdz");
}

command_trasa_dialog(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 8155)
	{
		if(response)
		{
			new route = listitem;
			new busStops = GetRouteBusStopsCount(route);
			new string[4096];
			new routeText[1024];
			new uniqDistricts;

			if(!BusRoute[route][br_Enabled])
			{
				MruMessageFail(playerid, "Linia nieaktywna");
				ShowTrasaDialog(playerid);
				return 1;
			}

			for(new i; i<MAX_BUS_STOPS; i++)
			{
				if(!BusStop[route][i][bs_Active])
				{
					break;
				}
				if(strfind(routeText, BusStop[route][i][bs_District], true) != -1)
				{
					continue;
				}
				uniqDistricts++;
				if(uniqDistricts % 5 == 0) strcat(routeText, "\n");
				strcat(routeText, sprintf("%s - ", BusStop[route][i][bs_District]));
			}
			new routeLen = strlen(routeText);
			if(routeLen > 3)
			routeText[strlen(routeText)-3] = '\0';

			format(string, sizeof(string), INCOLOR_GREEN"%s\n\
				"INCOLOR_DIALOG"%s\n\
				Trasa: %s\n\n\
				Trasa dost�pna od %d skilla\n\
				Ka�dy przystanek to %d procent szans na zwi�kszenie skilla o 1 punkt\n\
				Za ka�dy przejechany przystanek dostaniesz %d$\n\
				Trasa posiada %d przystank�w, przejechanie jej zajmuje �rednio %d minut\n\
				Za przejechanie ca�ej trasy mo�esz zarobi� %d$",
				BusRoute[route][br_Name],
				BusRoute[route][br_Description],
				routeText,
				BusRoute[route][br_Skill],
				BusRoute[route][br_SkillChance],
				BusRoute[route][br_MoneyPerStop],
				busStops,
				BusRoute[route][br_Time] / 60,
				BusRoute[route][br_MoneyPerStop] * busStops);
			
			ShowPlayerDialogEx(playerid, 8156, DIALOG_STYLE_MSGBOX, "Wybierz tras� autobusow�", 
				string, "Rozpocznij", "Wr��");
			SetPVarInt(playerid, "bus-route", route);
		}
		return 1;
	}
	if(dialogid == 8156)
	{
		if(response)
		{
			new route = GetPVarInt(playerid, "bus-route");
			if(GetPlayerJobSkill(playerid, JOB_DRIVER) < BusRoute[route][br_Skill])
			{
				MruMessageFail(playerid, sprintf("Ta trasa jest dost�pna od %d skill kierowcy (Ty masz %d)", 
					BusRoute[route][br_Skill], GetPlayerJobSkill(playerid, JOB_DRIVER)));
				ShowTrasaDialog(playerid);
				return 1;
			}
			StartBusRoute(playerid, route);
		}
		else
		{
			ShowTrasaDialog(playerid);
		}
		return 1;
	}
	return 0;
}

//end