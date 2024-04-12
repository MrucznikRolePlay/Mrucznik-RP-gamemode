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

GiveMoneyForBusStop(playerid, route, bool:finish)
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

	if(finish == true)
	{
		money *= 3; // bonus x3 za ukoñczenie ca³ej trasy
	}

	SendClientMessage(playerid, COLOR_GREEN, sprintf("+%d$", money));
	DajKase(playerid, money);
	Log(payLog, INFO, "%s zarobi³ %d$ za przejechanie przystanku na linii %d", GetLogName(playerid), money, route);
}

/*forward NextPrzystanek(playerid, msg[]);
public Next(playerid, msg[])
{
	SendClientMessage(playerid, COLOR_WHITE, msg);
    ProxDetector(15.0, playerid, msg, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);//system autobusów
    return 1;
    printf("second has passed, also we have a message: %s", msg);
    return 1;
}*/

CreateBusPickups()
{
	CreateDynamicPickup(1239, 2, 2452.005859375,-1666.1260986328,13.477073669434 , -1); // Przystanek koñcowy: Ganton - Grove Street
	CreateDynamicPickup(1239, 2, 2163.0180664063,-1758.4976806641,13.547880172729, -1); // Idlewood - Silownia
	CreateDynamicPickup(1239, 2, 2179.3752441406,-1711.3572998047,13.526877403259, -1); // Idlewood - Silownia
	CreateDynamicPickup(1239, 2, 1890.3483886719,-1744.2761230469,13.546875, -1); // Idlewood - Stacja benzynowa
	CreateDynamicPickup(1239, 2, 1925.3206787109,1760.4560546875,13.546875, -1); // Idlewood - Stacja benzynowa
	CreateDynamicPickup(1239, 2, 1743.8525390625,-1810.5493164063,13.568388938904, -1); // El Corona - Unity Station
	CreateDynamicPickup(1239, 2, 1790.5799560547,-1839.7934570313,13.572521209717, -1); // El Corona - Unity Station
	CreateDynamicPickup(1239, 2, 1523.8828125,-1694.9890136719,13.546875, -1); // Pershing Square - Komisariat
	CreateDynamicPickup(1239, 2, 1535.2431640625,-1647.8034667969,13.546875, -1); // Pershing Square - Komisariat
	CreateDynamicPickup(1239, 2, 1363.3416748047,-1275.2260742188,13.546875, -1); // Downtown - Ammu-Nation
	CreateDynamicPickup(1239, 2, 1336.8793945313,-1348.0667724609,13.546875, -1); // Downtown - Ammu-Nation
	CreateDynamicPickup(1239, 2, 1451.1014404297,-1041.8737792969,23.828125, -1); // Downtown - Bank
	CreateDynamicPickup(1239, 2, 1451.2653808594,-1025.9205322266,23.828125, -1); // Downtown - Bank
	CreateDynamicPickup(1239, 2, 1782.1417236328,-1163.5463867188,23.828125, -1); // Downtown - Mrucznikowy Gun Shop
	CreateDynamicPickup(1239, 2, 1811.40234375,-1185.9276123047,23.828125, -1); // Downtown - Mrucznikowy Gun Shop
	CreateDynamicPickup(1239, 2, 1964.6368408203,-1201.1809082031,25.785903930664, -1); //bus glen
	CreateDynamicPickup(1239, 2, 2316.6101074219,-1665.5198974609,14.251803398132, -1); // Ganton - Bar "Ten green bottles"
	CreateDynamicPickup(1239, 2, 2296.3830566406,-1653.36328125,14.82245349884, -1); // Ganton - Bar "Ten green bottles"
	CreateDynamicPickup(1239, 2, 2226.7065429688,-2204.9982910156,13.546875, -1); // "Ocean Docks - Fabryka"
	CreateDynamicPickup(1239, 2, 2741.4299316406,-2000.4523925781,13.5546875, -1); //"Playa del Seville - Osiedle mieszkaniowe"
	CreateDynamicPickup(1239, 2, 2763.8073730469,-1937.013671875,13.539384841919, -1); //"Playa del Seville - Osiedle mieszkaniowe2"
	CreateDynamicPickup(1239, 2, 2847.9274902344,-1563.1618652344,11.093752861023, -1); //"East Beach - Baza Mechanikow"
	CreateDynamicPickup(1239, 2, 2867.8012695313,-1539.7840576172,11.093752861023, -1); //"East Beach - Baza Mechanikow2"
	CreateDynamicPickup(1239, 2, 2843.7377929688,-1097.9293212891,24.118738174438, -1); //"East Beach - Zaklad Bukmacherski"
	CreateDynamicPickup(1239, 2, 2832.1416015625,-1101.7882080078,24.260314941406, -1); //"East Beach - Zaklad Bukmacherski"
	CreateDynamicPickup(1239, 2, 2436.2917480469,-1262.3370361328,24.0, -1); //"East Los Santos - Pig Pen"
	CreateDynamicPickup(1239, 2, 2389.1911621094,-1250.794921875,23.902835845947, -1); //"East Los Santos - Pig Pen"
	CreateDynamicPickup(1239, 2, 2254.9758300781,-1151.0307617188,26.672472000122, -1); // "Jefferson - Motel Jefferson"
	CreateDynamicPickup(1239, 2, 2248.9545898438,-1132.9829101563,26.325132369995, -1); // "Jefferson - Motel Jefferson"
	CreateDynamicPickup(1239, 2, 1307.6668701172,-916.51196289063,38.873985290527, -1); //"Temple - 24/7"
	CreateDynamicPickup(1239, 2, 1318.3203125,-939.79602050781,37.822116851807, -1); //"Temple - 24/7"
	CreateDynamicPickup(1239, 2, 1036.2315673828,-1155.5111083984,23.820327758789, -1); // "Market - Kasyno"
	CreateDynamicPickup(1239, 2, 1008.0661621094,-1133.0928955078,23.828125, -1); // "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 1036.2315673828,-1155.5111083984,23.820327758789, -1); //  "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 1008.0661621094,-1133.0928955078,23.828125, -1); //  "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 911.25482177734,-1380.9995117188,13.489659309387, -1); //"Market - Cluckin&Bell"
	CreateDynamicPickup(1239, 2, 923.01147460938,-1340.8969726563,13.501903533936, -1); //"Market - Cluckin&Bell"
	CreateDynamicPickup(1239, 2, 723.23773193359,-1413.8408203125,13.51894569397, -1); // "Rodeo - Wloska Restauracja / Studio SAN"
	CreateDynamicPickup(1239, 2, 709.17822265625,-1387.4063720703,13.687715530396, -1); // "Rodeo - Wloska Restauracja / Studio SAN"
	CreateDynamicPickup(1239, 2, 359.1096496582,-1653.7490234375,32.904319763184, -1); //"Rodeo - Klub wedkarski"
	CreateDynamicPickup(1239, 2, 351.99530029297,-1636.6911621094,33.115753173828, -1); //"Rodeo - Klub wedkarski"
	CreateDynamicPickup(1239, 2, 335.34939575195,-1529.0958251953,33.285037994385, -1); //"Rodeo - Mark's Plaza"
	CreateDynamicPickup(1239, 2, 1978.0007324219,-1196.2591552734,25.851963043213, -1); //"Glen park"
}

//end