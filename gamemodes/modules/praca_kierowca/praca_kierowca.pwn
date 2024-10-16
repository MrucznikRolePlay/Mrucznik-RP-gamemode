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

// ------------[ Kierowca Busa ]------------
StartBusRoute(playerid, route)
{
	DrivingBusRoute[playerid] = route;
	CurrentBusStop[playerid] = 0;
	SetPlayerRaceCheckpoint(playerid, 0, 
		BusStop[route][0][bs_StopX], BusStop[route][0][bs_StopY], BusStop[route][0][bs_StopZ],
		BusStop[route][1][bs_StopX], BusStop[route][1][bs_StopY], BusStop[route][1][bs_StopZ],
		4.0);

	PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
	SendClientMessage(playerid, COLOR_YELLOW, sprintf("|________________%s_________________|", BusRoute[route][br_Name]));
	SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpocz¹æ s³u¿by! Wpisz {FFFF00}/fare [cena]");
	SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyæ po wjechaniu w przystanek wpisz {FFFF00}/zd");
	SendClientMessage(playerid, COLOR_GREEN, "Je¿eli bêdziesz chcia³ przerwaæ trasê wczeœniej wpisz {FFFF00}/zakoncztrase");
	SendClientMessage(playerid, COLOR_YELLOW,         "|_____________>>/fare<<_____________|");
}

Przystanek(playerid, vehicleid, route, busstop)
{
	new next = busstop + 1;
	new afterNext = busstop + 2;
	new end;
	if(next == MAX_BUS_STOPS-1 || !BusStop[route][next][bs_Active])
	{
		end = 1;

		// koniec trasy
		PlayerPlaySound(playerid, 182, 0.0, 0.0, 0.0);
		SetTimerEx("StopPlayerSound", 8200, false, "%d", playerid);
	}
	else if(afterNext == MAX_BUS_STOPS-1 || !BusStop[route][afterNext][bs_Active])
	{
		// ostatni przystanek
		SetPlayerRaceCheckpoint(playerid, 1, 
			BusStop[route][next][bs_StopX], BusStop[route][next][bs_StopY], BusStop[route][next][bs_StopZ],
			0.0, 0.0, 0.0, 4.0);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
	}
	else
	{
		SetPlayerRaceCheckpoint(playerid, 0, 
			BusStop[route][next][bs_StopX], BusStop[route][next][bs_StopY], BusStop[route][next][bs_StopZ],
			BusStop[route][afterNext][bs_StopX], BusStop[route][afterNext][bs_StopY], BusStop[route][afterNext][bs_StopZ],
			4.0);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
	}

	new money = BusRoute[route][br_MoneyPerStop];
	if(random(100) < BusRoute[route][br_SkillChance])
	{
		IncreasePlayerJobSkill(playerid, JOB_DRIVER, 1);
	}

	GameTextForPlayer(playerid, sprintf("~g~+%d$", money), 4000, 1);
	DajKase(playerid, money);
	Log(payLog, INFO, "%s zarobi³ %d$ za przejechanie przystanku na linii %s", GetPlayerLogName(playerid), money, BusRoute[route][br_Name]);

	ChatMe(playerid, "naciska przycisk na desce rozdzielczej i otwiera drzwi. ((/zd by zamkn¹æ))");
	TogglePlayerControllable(playerid, 0);
	BusDoors[playerid] = 1;

	if(end)
	{
		EndBusRoute(playerid, vehicleid, route);
	}
	else
	{
		new routeText[1024];
		new uniqDistricts;
		for(new i=busstop+1; i <= MAX_BUS_STOPS; i++)
		{
			if(!BusStop[route][i][bs_Active])
			{
				break;
			}
			if(strfind(routeText, BusStop[route][i][bs_District], true) != -1)
			{
				continue;
			}
			if(uniqDistricts % 5 == 0)
			{
				strcat(routeText, "\n{A0A0A0}Trasa:{e2dff3} ");
			}
			uniqDistricts++;
			strcat(routeText, BusStop[route][i][bs_District]);
		}
		new routeLen = strlen(routeText);
		if(routeLen > 3)
		routeText[strlen(routeText)-3] = '\0';

		new busText[MAX_BUS_STOPS * (MAX_BUS_STOP_NAME + 3) + 1024];
		format(busText, sizeof(busText), 
			"%s\n\
			{A0A0A0}Nastêpny przystanek: {e2dff3}%s\n\
			%s", 
			BusRoute[route][br_Name],
			BusStop[route][next][br_Name],
			routeText);
		UpdateDynamic3DTextLabelText(Busnapisn[KomunikacjaMiejsca[vehicleid]], BusRoute[route][br_Color], busText);
	}
    return 1;
}

EndBusRoute(playerid, vehicleid, route, force=0)
{
	DrivingBusRoute[playerid] = -1;
	CurrentBusStop[playerid] = 0;
	if(!force) IncreasePlayerJobSkill(playerid, JOB_DRIVER, 1);
	DisablePlayerRaceCheckpoint(playerid);

	SendClientMessage(playerid, COLOR_YELLOW,sprintf("|_______________%s zakoñczona!_______________|", BusRoute[route][br_Name]));
	SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
	SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni.");
	SendClientMessage(playerid, COLOR_YELLOW,        "|_____________>>Bus Department<<_____________|");

	UpdateDynamic3DTextLabelText(Busnapisn[KomunikacjaMiejsca[vehicleid]], COLOR_YELLOW, "° Komunikacja miejska °");
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
			new buf[1024];

			// load route info
			fread(file, buf);
			sscanf(buf, "p<|>e<s["#MAX_BUS_ROUTE_NAME"]dddddds["#MAX_BUS_ROUTE_DESCRIPTION"]>", BusRoute[route]);

			// load bus stops
			new busstop;
			while(fread(file, buf))
			{
				if(busstop >= MAX_BUS_STOPS) break;
        		sscanf(buf, "p<|>e<ds["#MAX_BUS_STOP_NAME"]s["#MAX_BUS_STOP_DISTRICT"]dfffffffff>", BusStop[route][busstop]);
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
		fwrite(file, sprintf("%s|%d|%d|%d|%d|%d|%d|%s\n", 
			BusRoute[route][br_Name], 
			BusRoute[route][br_Color], 
			BusRoute[route][br_MoneyPerStop], 
			BusRoute[route][br_Skill], 
			BusRoute[route][br_Time], 
			BusRoute[route][br_SkillChance], 
			BusRoute[route][br_Enabled],
			BusRoute[route][br_Description]));

		// save bus stops info
		for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
		{
			if(!BusStop[route][busstop][bs_Active]) break;

			new buf[1024];
			format(buf, sizeof(buf), "%d|%s|%s|%d|%f|%f|%f|%f|%f|%f|%f|%f|%f\n", 
				BusStop[route][busstop][bs_Active],
				BusStop[route][busstop][bs_Name],
				BusStop[route][busstop][bs_District],
				BusStop[route][busstop][bs_Type],
				BusStop[route][busstop][bs_StopX], BusStop[route][busstop][bs_StopY], BusStop[route][busstop][bs_StopZ],
				BusStop[route][busstop][bs_ObjectX], BusStop[route][busstop][bs_ObjectY], BusStop[route][busstop][bs_ObjectZ],
				BusStop[route][busstop][bs_ObjectRX], BusStop[route][busstop][bs_ObjectRY], BusStop[route][busstop][bs_ObjectRZ]);
			fwrite(file, buf);
		}
		fclose(file);
	}
}

CreateBusStops(route)
{
	for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
	{
		if(!BusStop[route][busstop][bs_Active])
		{
			break;
		}
		new type = BusStop[route][busstop][bs_Type];
		new Float:textOffset;
		new model;
		if(type == BUS_STOP_TYPE_SMALL_BENCH)
		{
			model = 1229;
			textOffset = 1.4;

			// bench
			new Float:newX, Float:newY, Float:newZ;
			MoveObjectLeft3D(3.5, 
				BusStop[route][busstop][bs_ObjectX],
				BusStop[route][busstop][bs_ObjectY],
				BusStop[route][busstop][bs_ObjectZ] - 1.05,
				BusStop[route][busstop][bs_ObjectRX],
				BusStop[route][busstop][bs_ObjectRY],
				BusStop[route][busstop][bs_ObjectRZ], 
				newX, newY, newZ);
			BusStopsEntities[route][busstop][bs_BusStopBench] = CreateDynamicObject(1280,
				newX, newY, newZ,
				BusStop[route][busstop][bs_ObjectRX],
				BusStop[route][busstop][bs_ObjectRY],
				BusStop[route][busstop][bs_ObjectRZ]);
		}
		else if(type == BUS_STOP_TYPE_SMALL)
		{
			model = 1229;
			textOffset = 1.4;
		}
		else if(type == BUS_STOP_TYPE_BIG)
		{
			model = 1257;
			textOffset = 2.2;
		}
		else
		{
			model = type;
			textOffset = 1.6;
		}

		BusStopsEntities[route][busstop][bs_BusStopObject] = CreateDynamicObject(model, 
			BusStop[route][busstop][bs_ObjectX],
			BusStop[route][busstop][bs_ObjectY],
			BusStop[route][busstop][bs_ObjectZ],
			BusStop[route][busstop][bs_ObjectRX],
			BusStop[route][busstop][bs_ObjectRY],
			BusStop[route][busstop][bs_ObjectRZ]);

		new busStopText[512];
		strcat(busStopText, sprintf("%s\n", BusRoute[route][br_Name]));
		strcat(busStopText, sprintf("{A0A0A0}Przystanek: {e2dff3}%s", BusStop[route][busstop][bs_Name]));

		BusStopsEntities[route][busstop][bs_BusStop3DText] = CreateDynamic3DTextLabel(busStopText,  BusRoute[route][br_Color], 
			BusStop[route][busstop][bs_ObjectX],
			BusStop[route][busstop][bs_ObjectY],
			BusStop[route][busstop][bs_ObjectZ] + textOffset,
			30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
}

RecreateBusStops(route)
{
	// destroy current bus stops
	for(new busstop; busstop < MAX_BUS_STOPS; busstop++)
	{
		if(IsValidDynamicObject(BusStop[route][busstop][bs_BusStopObject]) && BusStop[route][busstop][bs_BusStopObject] != 0)
		{
			DestroyDynamicObject(BusStopsEntities[route][busstop][bs_BusStopObject]);
		}
		if(IsValidDynamicObject(BusStop[route][busstop][bs_BusStopBench]) && BusStop[route][busstop][bs_BusStopBench] != 0)
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
	if(isnull(BusStop[route][busstop][bs_Name]))
	{
		format(BusStop[route][busstop][bs_Name], MAX_BUS_STOP_NAME, "TODO");
		format(BusStop[route][busstop][bs_District], MAX_BUS_STOP_DISTRICT, "TODO");
	}
	BusStop[route][busstop][bs_Active] = 1;
	BusStop[route][busstop][bs_Type] = type;
	BusStop[route][busstop][bs_ObjectX] = x;
	BusStop[route][busstop][bs_ObjectY] = y;
	BusStop[route][busstop][bs_ObjectZ] = z;
	BusStop[route][busstop][bs_ObjectRX] = rx;
	BusStop[route][busstop][bs_ObjectRY] = ry;
	BusStop[route][busstop][bs_ObjectRZ] = rz;
	
	RecreateBusStops(route);
    SaveBusRoute(route);
}

GetRouteBusStopsCount(route)
{
	new busStops;
	for(busStops=0; busStops<MAX_BUS_STOPS; busStops++)
	{
		if(!BusStop[route][busStops][bs_Active])
		{
			break;
		}
	}
	return busStops;
}

//end