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

//end