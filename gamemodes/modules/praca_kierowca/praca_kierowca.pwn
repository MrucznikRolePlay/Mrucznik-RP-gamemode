//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               praca_kierowca                                              //
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
//Opis:
/*
	Praca kierowcy.
*/

//

#include "command_akceptuj.pwn"
#include "command_anuluj.pwn"
#include "command_wezwij.pwn"

//-----------------<[ Funkcje: ]>-------------------
IsATaxi(vehicleID)
{
	// taxi, cabbie
	return GetVehicleModel(vehicleID) == 420 || GetVehicleModel(vehicleID) == 438;
}

IsAMiniBus(vehicleID)
{
	// Moonbeam
	return GetVehicleModel(vehicleID) == 418;
}

IsABus(vehicleID)
{
	// Bus, Coach
	return GetVehicleModel(vehicleID) == 431 || GetVehicleModel(vehicleID) == 437;
}

IsATrain(vehicleID)
{
	// Brownstreak (osobowy), Freight (towarowy)
    return GetVehicleModel(vehicleID) == 538 || GetVehicleModel(vehicleID) == 537;
}

IsVehicleWithTaxometr(vehicleID)
{
    new i = VehicleUID[vehicleID][vUID];
    if(i == 0) return 0;

    if(IsCarOwnedByKT(vehicleID))
    {
		return 1;
    }

    if(IsCarOwnedByDriverJob(vehicleID))
	{
        return 1;
	}

	if(IsABus(vehicleID) || IsATaxi(vehicleID))
	{
		return 1;
	}

	if(IsAPlane(GetVehicleModel(vehicleID)) || IsAHeliModel(GetVehicleModel(vehicleID)))
	{
		return 1;
	}

	if(IsATrain(vehicleID))
	{
		return 1;
	}
	return 0;
}

CanPlayerUseTaxometr(playerid, vehicleID)
{
    if(IsCarOwnedByKT(vehicleID) && IsPlayerInFraction(playerid, FRAC_KT))
	{
		return 1;
	}

	if(IsCarOwnedByDriverJob(vehicleID) && GetPlayerJob(playerid) == JOB_DRIVER)
	{
		return 1;
	}

	if(IsCarOwner(playerid, vehicleID))
	{
		return 1;
	}
	return 0;
}

IsAPublicTransport(vehicleID)
{
    if((IsABus(vehicleID) || IsAMiniBus(vehicleID)) && (IsCarOwnedByKT(vehicleID) || IsCarOwnedByDriverJob(vehicleID))) 
	{
		return 1;
	}
	return 0;
}

IsCarOwnedByKT(vehicleID)
{
    new i = VehicleUID[vehicleID][vUID];
    if(i == 0) return 0;
	return CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_KT;
}

IsCarOwnedByDriverJob(vehicleID)
{
    new i = VehicleUID[vehicleID][vUID];
    if(i == 0) return 0;
	return CarData[i][c_OwnerType] == CAR_OWNER_JOB && CarData[i][c_Owner] == JOB_DRIVER;
}

Taxi_FareEnd(playerid)
{
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
	else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}
    for(new i=0;i<4;i++) if(TransportClient[playerid][i] != INVALID_PLAYER_ID) Taxi_Pay(TransportClient[playerid][i]); //Handle to 4 passenger
	
	TransportValue[playerid] = 0;
	TransportDuty[playerid] = 0;

	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid <= 0)
	{
		vehicleid = gLastCar[playerid];
	}
	if(vehicleid > 0)
	{
		new text3d = MAP_get_val_val(VehicleFareInfo, _:vehicleid);
		MAP_remove_val(VehicleFareInfo, _:vehicleid);
		DestroyDynamic3DTextLabel(text3d);
	}
	
	SetPlayerToTeamColor(playerid);

	MruMessageGoodInfo(playerid, "Wy³¹czy³eœ taksometr i zakoñczy³eœ s³u¿bê kierowcy.");
}

Taxi_Pay(playerid)
{
    new taxidriver = TransportDriver[playerid];
    if(IsPlayerConnected(taxidriver))
	{
        new slot = GetPVarInt(playerid, "taxi-slot");
        new string[64];
        new cost = TransportValue[taxidriver] + floatround(TransportValue[taxidriver]*TransportDist[playerid]);
		
		if(kaska[playerid] < cost)
		{
			PoziomPoszukiwania[playerid] += 1;
			SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Kradzie¿ taksówkarska (brak pieniêdzy na sp³ate)");
			format(string, sizeof(string), "Klient nie posiada³ pe³nej kwoty.");
			SendClientMessage(taxidriver, COLOR_RED, string);
		}
		
		if(TransportDist[playerid] > 1.5)
		{
			GiveTaxiBonusForUniquePlayer(taxidriver, playerid);
			IncreasePlayerJobSkill(taxidriver, JOB_DRIVER, 3);
		}

		ZabierzKase(playerid, cost);
		DajKase(taxidriver, cost);
		Log(payLog, INFO, "%s zarobi³ $%d za podwiezienie %s", GetPlayerLogName(taxidriver), cost, GetPlayerLogName(playerid));

	    format(string, sizeof(string), "~w~Klient opuscil taxi~n~~g~Zarobiles $%d", cost);
	    GameTextForPlayer(taxidriver, string, 5000, 1);

	    format(string, sizeof(string), "~w~Opusciles taksowke~n~~g~Zaplaciles $%d", cost);
	    GameTextForPlayer(playerid, string, 5000, 1);

        TransportDist[playerid] = 0.0;

        TransportClient[taxidriver][slot] = INVALID_PLAYER_ID;
		SetPVarInt(taxidriver, "dont-update-pos", 1);

        Taxi_HideHUD(playerid);
        new bool:hide=true;
        for(new i=0;i<4;i++)
        {
            if(TransportClient[taxidriver][slot] != INVALID_PLAYER_ID)
            {
                hide = false;
                break;
            }
        }
        if(hide) 
		{
			SetPVarInt(taxidriver, "dont-update-pos", 0);
			Taxi_HideHUD(taxidriver);
		}

        TransportDriver[playerid] = 999;
	}
}

Taxi_HideHUD(playerid)
{
    TextDrawHideForPlayer(playerid, TAXI_BG[0]);
    TextDrawHideForPlayer(playerid, TAXI_BG[1]);
    PlayerTextDrawHide(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawHide(playerid, TAXI_COST[playerid]);
}

Taxi_ShowHUD(playerid)
{
    TextDrawShowForPlayer(playerid, TAXI_BG[0]);
    TextDrawShowForPlayer(playerid, TAXI_BG[1]);
    PlayerTextDrawSetString(playerid, TAXI_DIST[playerid], "_");
    PlayerTextDrawSetString(playerid, TAXI_COST[playerid], "_");
    PlayerTextDrawShow(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawShow(playerid, TAXI_COST[playerid]);
}

StartBusRoute(playerid, listitem)
{
	new routeTime;
	switch(listitem)
	{
		case 0: // Linia 55
		{
			PlayerInfo[playerid][pLinia55] = 1;
			CP[playerid] = 551;
			routeTime = 60000*6;

			SetPlayerCheckpoint(playerid, 2215.8428,-1436.8223,23.4033, 4);
			Przystanek(playerid, COLOR_BLUE, "Linia nr. 55\n{808080}Dojazd do trasy.\nWszytkie przystanki NA ¯¥DANIE (N/¯)");
		}
		case 1: // linia 72
		{
			PlayerInfo[playerid][pLinia72] = 1;
			CP[playerid] = 721;
			routeTime = 60000*6;

			SetPlayerCheckpoint(playerid, 2818.4243,-1576.9399,10.9287, 4);
			Przystanek(playerid, COLOR_NEWS, "Linia nr. 72 (dojazd)\n{808080}Kierunek: BAZA MECHANIKÓW (pêtla) \nWszytkie przystanki NA ¯¥DANIE (N/¯)");
		}
		case 2: // linia 96
		{
			PlayerInfo[playerid][pLinia96] = 1;
			CP[playerid] = 961;
			routeTime = 60000*5;

			SetPlayerCheckpoint(playerid, 2687.6597,-2406.9775,13.6017, 4);
			Przystanek(playerid, COLOR_GREEN, "Linia nr. 96\n{808080}Dojazd do trasy.\nWszytkie przystanki NA ¯¥DANIE (N/¯)");

		}
		case 3: // linia 82
		{
			PlayerInfo[playerid][pLinia82] = 1;
			CP[playerid] = 821;
			routeTime = 60000*6;

			SetPlayerCheckpoint(playerid, 1173.1520,-1825.2843,13.1789, 4);
			Przystanek(playerid,COLOR_YELLOW, "Linia nr. 82\n{808080}Dojazd do trasy.\nWszytkie przystanki NA ¯¥DANIE (N/¯)");
		}
		case 4: // linia 85
		{
			PlayerInfo[playerid][pLinia85] = 1;
			CP[playerid] = 501;
			routeTime = 60000*8;

			SetPlayerCheckpoint(playerid, 2119.7363,-1896.8149,13.1345, 4);
			Przystanek(playerid, COLOR_GREEN, "Linia nr. 85\n{808080}Dojazd do trasy.\nWszytkie przystanki NA ¯¥DANIE (N/¯)");
		}
	}

	SendClientMessage(playerid, COLOR_YELLOW, " Rozpoczynasz wyznaczon¹ trasê. Pod¹¿aj za sygna³em GPS.");
	PlayerInfo[playerid][pNatrasiejest] = 1;
	SetTimerEx("AntyBusCzit", routeTime, 0, "d", playerid);
	BusCzit[playerid] = 1;
}

Przystanek(playerid, color, tekst[])
{
    new car = GetPlayerVehicleID(playerid);
    if(KomunikacjaMiejsca[car] == -1) return 0;
	UpdateDynamic3DTextLabelText(Busnapisn[KomunikacjaMiejsca[car]], color, tekst);
    return 1;
}

GiveMoneyForBusStop(playerid, route, finish=false)
{
	new money;
	switch(route)
	{
		case 55: { money = 460; }
		case 72: { money = 400; }
		case 96: { money = 620; }
		case 82: { money = 1200; }
		case 85: { money = 540; }
	}

	if(finish)
	{
		money *= 3; // bonus x3 za ukoñczenie ca³ej trasy
	}

	SendClientMessage(playerid, COLOR_GREEN, sprintf("+%d$", money));
	DajKase(playerid, money);
	Log(payLog, INFO, "%s zarobi³ %d$ za przejechanie przystanku na linii %d", GetPlayerLogName(playerid), money, route);
}

GiveTaxiBonusForUniquePlayer(playerid, clientid)
{
	new bonus = 15_000;
	new playerUID = PlayerInfo[playerid][pUID];
	new clientUID = PlayerInfo[clientid][pUID];

	new redisKey[64];
	format(redisKey, sizeof(redisKey), "player:%d:taxi-client:%d", playerUID, clientUID);
	if(Redis_Exists(RedisClient, redisKey))
	{
		return;
	}

	Redis_SetInt(RedisClient, redisKey, 1);
	RedisExpire(redisKey, 86_400); // expire after 24h

	MruMessageGoodInfoF(playerid, "Otrzymujesz %d$ bonusu za przewiezienie unikalnego gracza!", bonus);
	DajKase(playerid, bonus);
	Log(payLog, INFO, "%s otrzyma³ %d$ za przewiezienie unikalnego gracza %s taxówk¹", GetPlayerLogName(playerid), GetPlayerLogName(clientid), bonus);
}

//-----------------<[ Bus Routes: ]>-------------------
LoadBusRoutes()
{	
	// Load bus stops
	for(new route; route<MAX_BUS_ROUTES; route++)
	{
		new File:file;
		new filename[64];
		format(filename, sizeof(filename), "bus/route_%d.txt", route);
		file = fopen(filename, io_read);
		if(file)
		{
			new buf[512];

			// load route info
			fread(file, buf);
			sscanf(buf, "p<|>e<s[64]ddd>", BusRoute[route]);

			// load bus stops
			new busstop;
			while(fread(file, buf))
			{
				if(busstop >= MAX_BUS_STOPS) break;
        		sscanf(buf, "p<|>e<ds[64]dfffffffff>", BusStops[route][busstop]);
				busstop++;
			}
			fclose(file);
		}
	}
	
	// Create bus stops
	for(new route; route<MAX_BUS_ROUTES; route++)
	{
		CreateBusStops(route);
	}
}

SaveBusRoute(route)
{
	new File:file;
	new filename[64];
	format(filename, sizeof(filename), "bus/route_%d.txt", route);
	file = fopen(filename, io_write);
	if(file)
	{
		// save route info
		fwrite(file, sprintf("%s|%d|%d|%d\n", 
			BusRoute[route][br_Name], 
			BusRoute[route][br_Color], 
			BusRoute[route][br_MoneyPerStop], 
			BusRoute[route][br_Skill]));

		// save bus stops info
		for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
		{
			if(!BusStops[route][busstop][bs_Active]) break;

			fwrite(file, sprintf("%d|%s|%d|%f|%f|%f|%f|%f|%f|%f|%f|%f\n", 
				BusStops[route][busstop][bs_Active],
				BusStops[route][busstop][bs_Name],
				BusStops[route][busstop][bs_Type],
				BusStops[route][busstop][bs_StopX], BusStops[route][busstop][bs_StopY], BusStops[route][busstop][bs_StopZ],
				BusStops[route][busstop][bs_ObjectX], BusStops[route][busstop][bs_ObjectY], BusStops[route][busstop][bs_ObjectZ],
				BusStops[route][busstop][bs_ObjectRX], BusStops[route][busstop][bs_ObjectRY], BusStops[route][busstop][bs_ObjectRZ]));
		}
		fclose(file);
	}
}

CreateBusStops(route)
{
	new lastBusStopName[MAX_BUS_STOP_NAME];
	new lastBusStop;
	for(lastBusStop=0; lastBusStop < MAX_BUS_STOPS; lastBusStop++)
	{
		if(!BusStops[route][lastBusStop][bs_Active])
		{
			lastBusStop--;
			break;
		}
	}
	if(lastBusStop == 0)
	{
		return;
	}
	format(lastBusStopName, sizeof(lastBusStopName), BusStops[route][lastBusStop][bs_Name]);

	for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
	{
		if(!BusStops[route][busstop][bs_Active])
		{
			break;
		}
		new type = BusStops[route][busstop][bs_Type];
		new Float:textOffset;
		new model;
		if(type == BUS_STOP_TYPE_SMALL)
		{
			model = 1229;
			textOffset = 1.4;

			// bench
			new Float:newX, newY, newZ;
			MoveObjectLeft3D(3.5, 
				BusStops[route][busstop][bs_ObjectX],
				BusStops[route][busstop][bs_ObjectY],
				BusStops[route][busstop][bs_ObjectZ] - 1.05,
				BusStops[route][busstop][bs_ObjectRX],
				BusStops[route][busstop][bs_ObjectRY],
				BusStops[route][busstop][bs_ObjectRZ], 
				newX, newY, newZ);
			BusStopsEntities[route][busstop][bs_BusStopBench] = CreateDynamicObject(1280,
				newX, newY, newZ,
				BusStops[route][busstop][bs_ObjectRX],
				BusStops[route][busstop][bs_ObjectRY],
				BusStops[route][busstop][bs_ObjectRZ]);
		}
		else
		{
			model = 1257;
			textOffset = 1.4;
		}

		BusStopsEntities[route][busstop][bs_BusStopObject] = CreateDynamicObject(model, 
			BusStops[route][busstop][bs_ObjectX],
			BusStops[route][busstop][bs_ObjectY],
			BusStops[route][busstop][bs_ObjectZ],
			BusStops[route][busstop][bs_ObjectRX],
			BusStops[route][busstop][bs_ObjectRY],
			BusStops[route][busstop][bs_ObjectRZ]);

		// Create bus stop description
		new routeText[(MAX_BUS_STOP_NAME + 3) * MAX_BUS_STOPS + MAX_BUS_STOP_NAME];
		for(new i; i < lastBusStop-busstop; i++)
		{
			if(i % 10 == 0)
			{
				strcat(routeText, "\n{778899}Trasa:");
			}
			new currStop = busstop + 1;
			strcat(routeText, BusStops[route][currStop][bs_Name]);
			strcat(routeText, " - ");
		}
		strcat(routeText, BusStops[route][lastBusStop][bs_Name]);

		new busStopText[MAX_BUS_ROUTE_NAME + (MAX_BUS_STOP_NAME + 3) * MAX_BUS_STOPS + MAX_BUS_STOP_NAME + 16 + 32 + MAX_BUS_STOP_NAME];
		format(busStopText, sizeof(busStopText), 
			"%s\nKierunek: %s%s", 
			BusRoute[route][br_Name], 
			lastBusStopName, routeText);
		new nextStop = busstop + 1;
		if(nextStop < MAX_BUS_STOPS && BusStops[route][nextStop][bs_Active])
		{
			format(busStopText, sizeof(busStopText), "%s\n{808080}Nastêpny przystanek: %s",
				busStopText, BusStops[route][nextStop][bs_Name]);
		}
		BusStopsEntities[route][busstop][bs_BusStop3DText] = CreateDynamic3DTextLabel(busStopText,  BusRoute[route][br_Color], 
			BusStops[route][busstop][bs_ObjectX],
			BusStops[route][busstop][bs_ObjectY],
			BusStops[route][busstop][bs_ObjectZ] + textOffset,
			30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
}

RecreateBusStops(route)
{
	// destroy current bus stops
	for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
	{
		if(IsValidDynamicObject(BusStops[route][busstop][bs_BusStopObject]) && BusStops[route][busstop][bs_BusStopObject] != 0)
		{
			DestroyDynamicObject(BusStopsEntities[route][busstop][bs_BusStopObject]);
		}
		if(IsValidDynamicObject(BusStops[route][busstop][bs_BusStopBench]) && BusStops[route][busstop][bs_BusStopBench] != 0)
		{
			DestroyDynamicObject(BusStopsEntities[route][busstop][bs_BusStopBench]);
		}
		if(IsValidDynamic3DTextLabel(BusStopsEntities[route][busstop][bs_BusStop3DText]) && BusStopsEntities[route][busstop][bs_BusStop3DText] != 0)
		{
			DestroyDynamic3DTextLabel(BusStopsEntities[route][busstop][bs_BusStop3DText]);
		}
	}

	// create new bus stops
	CreateBusStops(route);
}

PlaceBusStop(route, busstop, type, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(isnull(BusStops[route][busstop][bs_Name]))
	{
		format(BusStops[route][busstop][bs_Name], MAX_BUS_STOP_NAME, "TODO");
	}
	BusStops[route][busstop][bs_Active] = 1;
	BusStops[route][busstop][bs_Type] = type;
	BusStops[route][busstop][bs_ObjectX] = x;
	BusStops[route][busstop][bs_ObjectY] = y;
	BusStops[route][busstop][bs_ObjectZ] = z;
	BusStops[route][busstop][bs_ObjectRX] = rx;
	BusStops[route][busstop][bs_ObjectRY] = ry;
	BusStops[route][busstop][bs_ObjectRZ] = rz;
	
	RecreateBusStops(route);
    SaveBusRoute(route);
}
//end