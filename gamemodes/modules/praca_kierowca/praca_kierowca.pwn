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

	if((IsATaxi(vehicleID) || IsABus(vehicleID) || IsAMiniBus(vehicleID)) && 
		IsCarOwner(vehicleID) && GetPlayerJobSkill(playerid, JOB_DRIVER) == 5)
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
    new string[128];
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
	else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}
    for(new i=0;i<4;i++) if(TransportClient[playerid][i] != INVALID_PLAYER_ID) Taxi_Pay(TransportClient[playerid][i]); //Handle to 4 passenger

	TransportDuty[playerid] = 0;
	format(string, sizeof(string), "Zakoñczy³eœ s³u¿bê, zarobi³eœ $%d dla Korporacji Transportowej", TransportMoney[playerid]);

	_MruGracz(playerid, string);


	if(GetPlayerFraction(playerid) != FRAC_KT) 
	{
		DajKase(playerid, TransportMoney[playerid]);
		Log(payLog, INFO, "%s zarobi³ $%d na s³u¿bie taksówkarza.", GetPlayerLogName(playerid), TransportMoney[playerid]);
	}
    else
    {
        Sejf_Add(FRAC_KT, TransportMoney[playerid]);
		Log(payLog, INFO, "%s zarobil $%d dla KT na s³u¿bie taksówkarza.", GetPlayerLogName(playerid), TransportMoney[playerid]);
    }
	TransportValue[playerid] = 0; TransportMoney[playerid] = 0;
	
	SetPlayerToTeamColor(playerid);
}

Taxi_Pay(playerid)
{
    new taxidriver = TransportDriver[playerid];
    if(IsPlayerConnected(taxidriver))
	{
        new slot = GetPVarInt(playerid, "taxi-slot");
        new string[64];
		new doZaplaty = 0;
        TransportCost[playerid] = floatround(TransportValue[taxidriver]*TransportDist[playerid]);
		
	    if(PlayerInfo[playerid][pLevel] < 3)
	    {
			if(kaska[playerid] < floatround(TransportCost[playerid]*0.25))
			{
				ZabierzKase(playerid, floatround(kaska[playerid] + 5000));//moneycheat
				doZaplaty = floatround(kaska[playerid] + 5000);
				PoziomPoszukiwania[playerid] += 1;
				SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Kradzie¿ taksówkarza(brak pieniêdzy na sp³ate)");
				format(string, sizeof(string), "Klient nie posiada³ pe³nej kwoty.");
				SendClientMessage(taxidriver, COLOR_RED, string);
			}
			else
			{
				ZabierzKase(playerid, floatround(TransportCost[playerid]*0.25));//moneycheat
				doZaplaty = floatround(TransportCost[playerid]*0.25);
			} 
	    }
	    else
	    {
	    	if(kaska[playerid] < floatround(TransportCost[playerid]))
			{
				ZabierzKase(playerid, floatround(kaska[playerid] + 10000));//moneycheat
				doZaplaty = floatround(kaska[playerid] + 10000);
				PoziomPoszukiwania[playerid] += 1;
				SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Kradzie¿ taksówkarza(brak pieniêdzy na sp³ate)");
				format(string, sizeof(string), "Klient nie posiada³ pe³nej kwoty.");
				SendClientMessage(taxidriver, COLOR_RED, string);
			}
			else 
			{
				ZabierzKase(playerid, floatround(TransportCost[playerid]));//moneycheat
				doZaplaty = floatround(TransportCost[playerid]);
			}
	    }
		
		TransportMoney[taxidriver] += doZaplaty;

	    format(string, sizeof(string), "~w~Klient opuscil taxi~n~~g~Zarobiles $%d",doZaplaty+TransportValue[taxidriver]);
	    GameTextForPlayer(taxidriver, string, 5000, 1);

		TransportCost[playerid] = 0;
        TransportDist[playerid] = 0.0;

        TransportClient[taxidriver][slot] = INVALID_PLAYER_ID;

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
        if(hide) Taxi_HideHUD(taxidriver);

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
		case 55: { money = 920; }
		case 72: { money = 800; }
		case 96: { money = 1240; }
		case 82: { money = 2400; }
		case 85: { money = 1080; }
	}

	if(finish)
	{
		money *= 3; // bonus x3 za ukoñczenie ca³ej trasy
	}

	SendClientMessage(playerid, COLOR_GREEN, sprintf("+%d$", money));
	DajKase(playerid, money);
	Log(payLog, INFO, "%s zarobi³ %d$ za przejechanie przystanku na linii %d", GetPlayerLogName(playerid), money, route);
}

//end