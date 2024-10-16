//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
Driver_OnPlayerDisconnect(playerid)
{
    if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999)
	{
		MruMessageBadInfoF(TransportDriver[playerid], "Gracz %s opuœci³ taksówkê (/q).", GetNick(playerid));
        Taxi_Pay(playerid);
	}

    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
    else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}


	foreach(new i : Player)
	{
	    if(IsPlayerConnected(i) && i != playerid)
	    {
	        if(TaxiAccepted[i] < 500)
	        {
		        if(TaxiAccepted[i] == playerid)
		        {
		            TaxiAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient Taxi~n~~r~Wyszedl z gry", 5000, 1);
		            TaxiCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	        else if(BusAccepted[i] < 500)
	        {
		        if(BusAccepted[i] == playerid)
		        {
		            BusAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient autobusu~n~~r~Wyszedl z gry", 5000, 1);
		            BusCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	    }
	}
}

Driver_OnPassengerExitVehicle(playerid)
{
	if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999) //Taxi client pay
	{
		Taxi_Pay(playerid);
	}
}

Driver_OnPlayerShoot(playerid, Float:x, Float:y, Float:z)
{
	if(GetPVarInt(playerid, "placing-bus-stop") == 1)
	{
		new type = GetPVarInt(playerid, "placing-bus-stop-type");
		new model;
		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		if(type == BUS_STOP_TYPE_BIG)
		{
			model = 1257;
			angle += 90.0;
		}
		else if(type == BUS_STOP_TYPE_SMALL || type == BUS_STOP_TYPE_SMALL_BENCH)
		{
			model = 1229;
		}

		new Float:unused, Float:colH;
		GetModelBoundingBox(model, unused, unused, colH, unused, unused, unused);

		new obj = CreateDynamicObject(model, x, y, z - colH, 0.0, 0.0, angle);
		EditDynamicObject(playerid, obj);
		MruMessageGoodInfo(playerid, "Teraz edytuj pozycje obiektu.");
		return 1;
	}
	return 0;
}

Driver_OnPlayerEditObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(GetPVarInt(playerid, "placing-bus-stop") == 1)
	{
		if(response == EDIT_RESPONSE_CANCEL)
		{
			DestroyDynamicObject(objectid);
			MruMessageBadInfo(playerid, "Anulowa³eœ stawianie przystanku");
			DeletePVar(playerid, "placing-bus-stop");
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			new route = GetPVarInt(playerid, "placing-bus-stop-route");
			new busstop = GetPVarInt(playerid, "placing-bus-stop-id");
			new type = GetPVarInt(playerid, "placing-bus-stop-type");

			DestroyDynamicObject(objectid);
			PlaceBusStop(route, busstop, type, x, y, z, rx, ry, rz);
			Streamer_Update(playerid);
			DeletePVar(playerid, "placing-bus-stop");
			MruMessageGoodInfo(playerid, sprintf("Przystanek %d trasy %d o typie %d postawiony pomyœlnie.", busstop, route, type));
		}
		return 1;
	}
	return 0;
}

Driver_OnPassengerEnterVeh(driverid, passengerid)
{
	new string[MAX_MESSAGE_LENGTH];
	if(kaska[passengerid] < TransportValue[driverid])
	{
		format(string, sizeof(string), "* Nie posiadasz przy sobie $%d ¿eby pokryæ koszt transportu. Opuszczasz pojazd.", TransportValue[driverid]);
		SendClientMessage(passengerid, COLOR_LIGHTBLUE, string);
		RemovePlayerFromVehicleEx(passengerid);
	}
	else
	{
		if(TransportDuty[driverid] == 1)
		{
			format(string, sizeof(string), "* Stawka wynosi $%d za kilometr.", TransportValue[driverid]);
			SendClientMessage(passengerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "* Klient %s wszed³ do Twojej taryfy.", GetNick(passengerid));
			SendClientMessage(driverid, COLOR_LIGHTBLUE, string);
			SetPVarInt(passengerid, "taxi-slot", GetPlayerVehicleSeat(passengerid)-1);
			TransportDist[driverid] = 0.0;
			TransportDist[passengerid] = 0.0;
			TransportDriver[passengerid] = driverid;
			TransportClient[driverid][GetPVarInt(passengerid, "taxi-slot")] = passengerid;
			Taxi_ShowHUD(passengerid);
			Taxi_ShowHUD(driverid);
		}
		else if(TransportDuty[driverid] == 2)
		{
			format(string, sizeof(string), "* Zap³aci³eœ $%d Za bilet.", TransportValue[driverid]);
			SendClientMessage(passengerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "* Klient %s wszed³ do autobusu i skasowa³ bilet.", GetNick(passengerid));
			SendClientMessage(driverid, COLOR_LIGHTBLUE, string);
			ZabierzKase(passengerid, TransportValue[driverid]);//moneycheat
			DajKase(driverid, TransportValue[driverid]);
		}
	}
	return 1;
}

Driver_OnPlayerEnterCheckpoint(playerid)
{
	if(TaxiCallTime[playerid] > 0 && TaxiAccepted[playerid] < 999)
	{
	    TaxiAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		TaxiCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	else if(BusCallTime[playerid] > 0 && BusAccepted[playerid] < 999)
	{
	    BusAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		BusCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	return 0;
}

Driver_OnPlayerEnterRaceCP(playerid)
{
	new route = DrivingBusRoute[playerid];
	if(route != -1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(KomunikacjaMiejsca[vehicleid] == -1) 
		{
			return 1;
		}

		Przystanek(playerid, vehicleid, route, CurrentBusStop[playerid]);
		return 1;
	}
	return 0;
}

//end