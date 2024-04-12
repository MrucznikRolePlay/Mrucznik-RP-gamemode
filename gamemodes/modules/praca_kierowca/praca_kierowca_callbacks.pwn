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

Driver_OnPassengerEnterVeh(driverid, passengerid)
{
	new string[MAX_MESSAGE_LENGTH];
	if(kaska[passengerid] < TransportValue[driverid])
	{
		format(string, sizeof(string), "* Potrzebujesz $%d aby wejœæ.", TransportValue[driverid]);
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
			if(PlayerInfo[passengerid][pLevel] < 3)
			{
				ZabierzKase(passengerid, floatround(TransportValue[driverid]/4));//moneycheat
				sendTipMessageEx(passengerid, COLOR_LIGHTBLUE, "Jesteœ nowym graczem, obowi¹zuje Cie rabat 75 procent na taksówkê.");
			}
			else
			{
				ZabierzKase(passengerid, floatround(TransportValue[driverid]));//moneycheat
			}
			TransportMoney[driverid] += TransportValue[driverid];
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
			TransportMoney[driverid] += TransportValue[driverid];
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
	if(CP[playerid]>=550 && CP[playerid]<=999)//Wywo³uje otwieranie drzwi gdy jest w CP od 550 do 999
	{
		Otwieramdrzwibusa(playerid);
	}
	if(CP[playerid]==1200)
	{
	    SendClientMessage(playerid, COLOR_GREY, "Dojecha³eœ do zajezdni i zakoñczy³eœ pracê.");
		Przystanek(playerid, COLOR_GREEN, "Korporacja Transportowa\n Wydzia³ Komunikacji Autbusowej");
		DisablePlayerCheckpoint(playerid);
		CP[playerid] = 0;
	}
	if(CP[playerid]==1201)
	{
	    SendClientMessage(playerid, COLOR_GREY, "Dojecha³eœ do zajezdni i zakoñczy³eœ pracê.");
		Przystanek(playerid, COLOR_YELLOW, "Los Santos Bus Department\n Komunikacja Miejska");
		DisablePlayerCheckpoint(playerid);
		CP[playerid] = 0;
	}
	//Linia numer 55 autobusa SYSTEM AUTOBUSÓW
	if(PlayerInfo[playerid][pLinia55]==1)
	{
		if(CP[playerid]==551) //Sprawdza czy dojecha³ do nastepnego
		{
			DisablePlayerCheckpoint(playerid); //usuwa cp i...
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpocz¹æ s³u¿by!!!");
			SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
			SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyæ po wjechaniu w przystanek wpisz /zd");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli bêdziesz chcia³ przerwaæ trasê wczeœniej wpisz /zakoncztrase");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Jefferson - Glen Park - Idlewood - El Corona - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "Linia numer: {3333FF}55 (niebieska) {FFFF00} Kierunek ==> {3333FF}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2248.4707,-1139.6617,25.7001, 4); //... ustawia nastepnego
			CP[playerid]=552; //przypisuje id dla cp
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);

		}
		else if(CP[playerid]==552)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1967.2327,-1198.9353,25.2217, 4);
			CP[playerid]=553;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Glen Park - Idlewood - El Corona - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Glen Park");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
		}
		else if(CP[playerid]==553)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1844.0139,-1361.4354,12.9694, 4);
			CP[playerid]=554;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - El Corona - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Skate Park");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		}
		else if(CP[playerid]==554)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Idlewood – Skate Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
			CP[playerid]=555;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: El Corona - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Unity Station");
		}
		else if(CP[playerid]==555)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4); //Przystanek Komisariat
			CP[playerid]=556;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta");
		}
		else if(CP[playerid]==556)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
			CP[playerid]=557;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Verte Bank ");
		}
		else if(CP[playerid]==557)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1008.5986,-1140.0272,23.2408, 4);
			CP[playerid]=558;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Bymber Casino ");
		}
		else if(CP[playerid]==558)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market – Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 836.6970,-1318.8370,12.9458, 4);
			CP[playerid]=559;
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Na najbli¿szym skrzy¿owaniu W LEWO");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Market Station");
		}
		else if(CP[playerid]==559)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 708.8574,-1391.8915,13.0002, 4);
			CP[playerid]=560;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Centrala SAN");
		}
		else if(CP[playerid]==560)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4);
			CP[playerid]=1008;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: G³ówna siedziba FBI (N/¯)");
		}
		else if(CP[playerid]==1008)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 354.7779,-1643.9617,32.4429, 4);
			CP[playerid]=562;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Molo Wêdkarskie ");
		}
		else if(CP[playerid]==562)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – Molo Wêdkarskie", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 378.3281,-1424.5344,34.2901, 4); //nawrotka CP
			CP[playerid]=1001;
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Przygotuj siê do wykonania NAWROTU");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			Przystanek(playerid, COLOR_BLUE, "Linia numer 55 \nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: MRUCZNIK TOWER ");
		}
		else if(CP[playerid]==1001)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek koñcowy {EE82EE}Rodeo – Biurowiec 'Mrucznik Tower'", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4); //CP mrucznik tower
			TogglePlayerControllable(playerid, 1);
			CP[playerid]=563;
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Za chwilê zbli¿ysz siê do koñca trasy! (1/2 zadania).");
			SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz odpocz¹æ nie wje¿d¿aj¹c w kolejny checkpoint lub ruszyæ dalej.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Odjazd nast¹pi po sygnale");
		}
		else if(CP[playerid]==563)
		{
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 359.0248,-1647.8008,32.3386, 4); //molo wêdkarskie
			CP[playerid]=564;
			ProxDetector(10.0, playerid, "Linia numer: {3333FF}55 (niebieska) {FFFF00} Kierunek ==> {3333FF}KOŒCIÓ£", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Molo Wêdkarskie");
		}
		else if(CP[playerid]==564)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – Molo Wêdkarskie", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
			CP[playerid]=1007;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: G³ówna siedziba FBI (N/¯) ");
		}
		else if(CP[playerid]==1007)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 723.2538,-1407.2189,12.9320, 4);
			CP[playerid]=566;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Centrala SAN ");
		}
		else if(CP[playerid]==566)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 830.8025,-1330.0034,13.5437, 4);
			CP[playerid]=567;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==567)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1034.3179,-1150.8452,23.2292, 4); //Bymber Kasyno
			CP[playerid]=568;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Bymber Casino ");
		}
		else if(CP[playerid]==568)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market – Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4); //Bank
			CP[playerid]=569;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Verte Bank ");
		}
		else if(CP[playerid]==569)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4); //Komisariat LS
			CP[playerid]=570;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta ");
		}
		else if(CP[playerid]==570)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4);
			CP[playerid]=571;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Unity Station ");
		}
		else if(CP[playerid]==571)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1853.2744,-1393.1622,12.9655, 4);
			CP[playerid]=572;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Skate Park ");
		}
		else if(CP[playerid]==572)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Idlewood – Skate Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
			CP[playerid]=573;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Glen Park - Jefferson\n{808080}Nastêpny przystanek: Glen Park ");
		}
		else if(CP[playerid]==573)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2255.2795,-1145.6331,26.0940, 4);
			CP[playerid]=574;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Jefferson\n{808080}Nastêpny przystanek: Motel Jefferson ");
		}
		else if(CP[playerid]==574)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2210.0313,-1440.1292,23.3929, 4); //Koñcowy CP po drugiej stronie
			CP[playerid]=575;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 55);
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Jefferson\n{808080}Nastêpny przystanek: KOŒCIÓ£ ");
		}
		else if(CP[playerid]==575)
		{
			if(BusCzit[playerid] == 1)
			{
				KickEx(playerid);
			}
			else
			{
				ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Jefferson – Koœció³", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				DisablePlayerCheckpoint(playerid);
				//TogglePlayerControllable(playerid, 0);//Zamra¿amy do póki nie odpowie co robi dalej
				//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi³eœ pe³n¹ trasê. Co zamierzasz teraz zrobiæ?\n\nWciœnij Ponów aby wczytaæ trasê jeszcze raz.\nWciœnij Inn¹ aby wybraæ inn¹ trasê.", "Ponów", "Inn¹");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 55 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				IncreasePlayerJobSkill(playerid, 9);
				GiveMoneyForBusStop(playerid, 55, true);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia55] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				comand_trasa_dialog_show(playerid);
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
				Przystanek(playerid, COLOR_BLUE, "Linia ZAJ\nLinia 55 do zajezdni Ocean Docks\n{778899}Trasa: Idlewood - Willowfield\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
				CP[playerid]=1200;
				}
				else if(GetPlayerJob(playerid) == JOB_DRIVER)
				{
				Przystanek(playerid, COLOR_BLUE, "Linia ZAJ\nLinia 55 do zajezdni Commerce\n{778899}Trasa: Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
				CP[playerid]=1201;
				}

			}
		}
	}
	// KONIEC LINII 55 AUTOBUSÓW

	//Linia numer 72 autobusa SYSTEM AUTOBUSÓW
	if(PlayerInfo[playerid][pLinia72]==1)
	{
		if(CP[playerid]==721) //Sprawdza czy dojecha³ do nastepnego
		{
			DisablePlayerCheckpoint(playerid); //usuwa cp i...
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpocz¹æ s³u¿by!!!");
			SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
			SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyæ po wjechaniu w przystanek wpisz /zd");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli bêdziesz chcia³ przerwaæ trasê wczeœniej wpisz /zakoncztrase");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
			ProxDetector(10.0, playerid, "Linia numer: {FFA500}72 (pomarañczowa)  {FFFF00}Kierunek ==> {FFA500}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2572.6025,-1728.8365,13.3093, 4);
			CP[playerid]=740; //przypisuje id dla cp up
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Ganton - Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Grove Street");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		}
		//nowe ganton GS lewo 2471,-1735.9000244141,13.39999961853
		//nowe ganton GS prawy 2590.6999511719,-1728.8000488281,13.39999961853
		else if(CP[playerid]==740)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2297.6785,-1655.4948,14.3767, 4);
			CP[playerid]=1009;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton – Grove Street", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Ganton - Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Bar Ten Green Bottles (N/¯)");
		}
		else if(CP[playerid]==1009)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2182.5671,-1708.4637,13.4766, 4); //
			CP[playerid]=722;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton – Bar Ten Green Bottles (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Si³ownia");
		}
		else if(CP[playerid]==722)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,  1890.3834,-1749.6218,12.9520, 4);//
			CP[playerid]=723;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Si³ownia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Stacja Benzynowa");
		}
		else if(CP[playerid]==723)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4);
			CP[playerid]=724;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta ");
		}
		else if(CP[playerid]==724)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
			CP[playerid]=725;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Verte Bank (jedn.) ");
		}
		else if(CP[playerid]==725)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1340.7183,-1346.4941,12.9510, 4); //stacja benz prawa
			CP[playerid]=726;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown – Bank (jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Ammu-Nation (jedn.)");
		}
		else if(CP[playerid]==726)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1208.1235,-1314.7834,12.9645, 4);
			CP[playerid]=727;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown - Ammu-Nation(jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Szpital");
		}
		else if(CP[playerid]==727)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 836.6970,-1318.8370,12.9458, 4);
			CP[playerid]=728;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market – Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==728)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4); //mrucznik tower
			CP[playerid]=729;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: MRUCZNIK TOWER ");
		}
		else if(CP[playerid]==729)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 260.5440,-1531.3761,32.1662, 4); //nawrotka przy mrucznik tower
			CP[playerid]=1003;
			ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Rodeo – Biurowiec 'Mrucznik Tower'", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! Ukoñczy³eœ trasê do Mrucznik Tower! (1/2 zadania). Mo¿esz tu odpocz¹æ.");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli chcesz jechaæ dalej wykonaj nawrót kieruj¹c siê do kolejnego checkpointu!");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Odjazd nast¹pi po sygnale!");
		}
		else if(CP[playerid]==1003)
		{
			TogglePlayerControllable(playerid, 1);
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 830.8025,-1330.0034,13.5437, 4);
			CP[playerid]=730;
			ProxDetector(10.0, playerid, "Linia numer: {FFA500}72 (pomarañczowa)  {FFFF00}Kierunek ==> {FFA500}BAZA MECHANIKÓW", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==730)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
			CP[playerid]=731;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa:  Market - Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Szpital ");

		}
		else if(CP[playerid]==731)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4);//komi LS
			CP[playerid]=734;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market - Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Urz¹d Miasta/Komisariat ");
		}
		else if(CP[playerid]==734)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1924.6978,-1754.4702,12.9486, 4);
			CP[playerid]=735;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Stacja Benzynowa ");
		}
		else if(CP[playerid]==735)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2162.4690,-1754.0964,12.9439, 4);
			CP[playerid]=736;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Si³ownia");
		}
		else if(CP[playerid]==736)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2314.7969,-1661.7714,13.8587  , 4);
			CP[playerid]=1010;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood - Szamboa Gym", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Ganton - East Los Santos\n{808080}Nastêpny przystanek: Bar Ten Green Bottles (N/¯) ");
		}
		else if(CP[playerid]==1010)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2489.3118,-1735.8690,13.3172 , 4);
			CP[playerid]=742;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Bar Ten Green Bottles (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Ganton - East Los Santos\n{808080}Nastêpny przystanek: Grove Street ");
		}
		else if(CP[playerid]==742)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2818.4243,-1576.9399,10.9287, 4);
			CP[playerid]=737;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Grove Street", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 72);
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Ganton - East Los Santos\n{808080}Nastêpny przystanek: BAZA MECHANIKÓW (pêtla) ");
		}
		else if(CP[playerid]==737)
		{
			if(BusCzit[playerid] == 1)
			{
				KickEx(playerid);
			}
			else
			{
				ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}East Los Santos - Baza Mechaników (pêtla)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				DisablePlayerCheckpoint(playerid);
				TogglePlayerControllable(playerid, 0);//Zamra¿amy do póki nie odpowie co robi dalej
				//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi³eœ pe³n¹ trasê. Co zamierzasz teraz zrobiæ?\n\nWciœnij Ponów aby wczytaæ trasê jeszcze raz.\nWciœnij Inn¹ aby wybraæ inn¹ trasê.", "Ponów", "Inn¹");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 72 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Chc¹c powtórzyæ t¹ trasê zawróæ wykorzystuj¹c parking znajduj¹cy siê na skrzy¿owaniu w w lewo.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				IncreasePlayerJobSkill(playerid, 6);
				GiveMoneyForBusStop(playerid, 72, true);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia72] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
				Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia ZAJ\nLinia 72 do zajezdni Ocean Docks\n{778899}Trasa: Idlewood - Willowfield\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
				CP[playerid]=1200;
				}
				else if(GetPlayerJob(playerid) == JOB_DRIVER)
				{
				Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia ZAJ\nLinia 72 do zajezdni Commerce\n{778899}Trasa: Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
				CP[playerid]=1201;
				}
			}
		}
	}
	// KONIEC LINII 72 AUTOBUSÓW
	//Linia numer 82 autobusa SYSTEM AUTOBUSÓW
	if(PlayerInfo[playerid][pLinia82]==1)
	{
		if(CP[playerid]==821) //Sprawdza czy dojecha³ do nastepnego
		{
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpocz¹æ s³u¿by!!!");
			SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
			SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyæ po wjechaniu w przystanek wpisz /zd");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli bêdziesz chcia³ przerwaæ trasê wczeœniej wpisz /zakoncztrase");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
			ProxDetector(10.0, playerid, "Linia numer: {DAA520}82 (¿ó³ta) {FFFF00}Kierunek ==> {DAA520}BAY SIDE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4); //... ustawia nastepnego KOMi (jedn)
			CP[playerid]=822; //przypisuje id dla cp up
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Urz¹d Miasta - East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta ");
		}
		else if(CP[playerid]==822)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2864.6250,-1539.0991,10.4947, 4);
			CP[playerid]=823;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Mechaników_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Kieruj siê do Alhambry, potem w LEWO.");
			SendClientMessage(playerid, COLOR_GREEN, "WjedŸ na autostradê, nastêpnie prosto do bazy mechaników.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Baza Mechaników ");

		}
		else if(CP[playerid]==823)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4);
			CP[playerid]=824;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Agencja Ochrony ");
		}
		else if(CP[playerid]==824)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2339.9377,39.4851,26.3359, 4);
			CP[playerid]=825;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do PC_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "JedŸ ci¹gle prosto zwyk³¹ drog¹. Nie zje¿d¿aj na autostradê.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: miasteczko Palomino Creek ");
		}
		else if(CP[playerid]==825)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1051.7797,-444.1544,51.0848, 4); //Przystanek PC
			CP[playerid]=826;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Palomino Creek", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Dillimore_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gdy przejedziesz po moœcie za 400m SKRÊÆ W LEWO na most.");
			SendClientMessage(playerid, COLOR_GREEN, "PóŸneij kieruj siê do tunelu. Ca³y czas prosto");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Hilltop Farm ");
		}
		else if(CP[playerid]==826)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 661.4372,-597.9591,15.7536, 4);
			CP[playerid]=827;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore – Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: miasteczko Dillimore ");
		}
		else if(CP[playerid]==827)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 235.2872,-54.7197,1.5620, 4);
			CP[playerid]=828;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Bluberry_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gdy miniesz komisariat SKRÊÆ W LEWO.");
			SendClientMessage(playerid, COLOR_GREEN, "JedŸ prosto drog¹ do i SKRÊÆ W LEWO do wyjazdu przy Cowboy Bar. Potem prosto.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Bluberry - Las Venturas\n{808080}Nastêpny przystanek: miasteczko Bluberry ");
		}
		else if(CP[playerid]==828)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, -2494.9761,2333.7603,4.9693, 4);//bay side koñcowy
			CP[playerid]=829;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Bluberry", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Bay Side_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Po wyjeŸdzie z Bluberry SKRÊÆ W LEWO");
			SendClientMessage(playerid, COLOR_GREEN, "Po przejechaniu 800m SKRÊÆ W PRAWO na most");
			SendClientMessage(playerid, COLOR_GREEN, "Nastêpnie za 300m SKRÊÆ W LEWO na autostrade. Dalej ca³y czas prosto.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Las Venturas\n{808080}Nastêpny przystanek: miasteczko Bay Side ");
		}
		else if(CP[playerid]==829)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, -2538.2993,2333.5835,4.8281, 4);
			CP[playerid]=1000;
			ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Bay Side", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! Ukoñczy³eœ trasê do Bay Side! (1/2 zadania)");
			SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz chwilkê odpocz¹æ, wjedŸ w kolejny checkpoint aby ruszyæ dalej!");
			SendClientMessage(playerid, COLOR_GREEN, "Dodatkowo otrzymujesz premiê paliwow¹ z uwagi na utrudniony dostêp do mechaników.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Gas[GetPlayerVehicleID(playerid)] = 100;
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Commerce\n{778899}Trasa: Bluberry - Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Odjazd nast¹pi po sygnale ");
		}
		else if(CP[playerid]==1000)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 229.9310,-170.9327,1.0001, 4);
			CP[playerid]=830;
			ProxDetector(10.0, playerid, "Linia numer: {DAA520}82 (¿ó³ta) {FFFF00}Kierunek ==> {DAA520}DWORZEC AUTOBUSOWY COMMERCE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			TogglePlayerControllable(playerid, 1);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Bluberry - Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Bluberry");
		}
		else if(CP[playerid]==830)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 684.2634,-569.5635,16.3208, 4);
			CP[playerid]=831;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Bluberry", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek:Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Dillimore");
		}
		else if(CP[playerid]==831)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1014.1871,-466.1351,50.5591, 4);
			CP[playerid]=832;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: Hilltop Farm");
		}
		else if(CP[playerid]==832)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2577.4602,39.4546,26.3359, 4); //PC prawa
			CP[playerid]=833;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore – Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Palomino Creek");
		}
		else if(CP[playerid]==833)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4); //nakijima prawa
			CP[playerid]=834;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Palomino Creek", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: East Los Santos - Commerce\n{808080}Nastêpny przystanek: Agencja Ochrony");
		}
		else if(CP[playerid]==834)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
			CP[playerid]=835;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos  - Commerce\n{808080}Nastêpny przystanek: Baza Mechaników");
		}
		else if(CP[playerid]==835)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1181.8771,-1748.0386,12.9679, 4);
			CP[playerid]=836;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Dworca_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "JedŸ ci¹gle autostrad¹.");
			SendClientMessage(playerid, COLOR_GREEN, "WyjedŸ na Idlewoo i kieruj siê ca³y czas prosto.");
			SendClientMessage(playerid, COLOR_GREEN, "Po przejechaniu spowalniacza, SKRÊÆ w LEWO i kieruj siê na dworzec.");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 82);
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Commerce\n{808080}Nastêpny przystanek: Dworzec Autobusowy / Basen");
		}
		else if(CP[playerid]==836)
		{
			if(BusCzit[playerid] == 1)
			{
				KickEx(playerid);
			}
			else
			{
				ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Commerce – Dworzec Autobusowy / Basen", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				DisablePlayerCheckpoint(playerid);
				TogglePlayerControllable(playerid, 0);//Zamra¿amy do póki nie odpowie co robi dalej
				//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi³eœ pe³n¹ trasê. Co zamierzasz teraz zrobiæ?\n\nWciœnij Ponów aby wczytaæ trasê jeszcze raz.\nWciœnij Inn¹ aby wybraæ inn¹ trasê.", "Ponów", "Inn¹");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 82 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				IncreasePlayerJobSkill(playerid, 11);
				GiveMoneyForBusStop(playerid, 82, true);
				if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 8670);
				else DajKase(playerid, 8670);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia82] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
				Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia ZAJ\nLinia 82 do zajezdni Ocean Docks\n{778899}Trasa: Pershing Square - Idlewood - Willowfield\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
				CP[playerid]=1200;
				}
				else if(GetPlayerJob(playerid) == JOB_DRIVER)
				{
				Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia ZAJ\nLinia 82 do zajezdni Commerce\n{778899}Trasa: Commerce\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
				CP[playerid]=1201;
				}
			}
		}
 	}
	// KONIEC LINII 82 AUTOBUSÓW system autobusów
    if(PlayerInfo[playerid][pLinia96]==1)
	{
		if(CP[playerid]==961) //Sprawdza czy dojecha³ do nastepnego
		{
	        DisablePlayerCheckpoint(playerid);
			/*GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "%s rozpocz¹³ trasê  na linii autobusowej numer {ADFF2F}96 Biurowiec <==> Baza Wojskowa{00D900C8}. Szczegó³owe informacje o trasach na /businfo", sendername);
			OOCNews(TEAM_GROVE_COLOR,string);*/
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Ocean Docks - Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Baza Wojskowa");
			ProxDetector(10.0, playerid, "Linia numer: {ADFF2F}96 (zielona) {FFFF00}Kierunek ==> {ADFF2F}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2512.0193,-2434.2727,13.7151, 4); //... ustawia nastepnego
			CP[playerid]=985; //przypisuje id dla cp up
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		}
		else if(CP[playerid]==985)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2228.8030,-2198.2109,12.9153, 4);//uszkodzony
			CP[playerid]=962;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Fabryka");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocean Docks – Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==962)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1992.8591,-2163.2961,13.3828, 4);//uszkodzony
			CP[playerid]=963;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocean Docks – Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==963)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=964;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko – Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==964)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
			CP[playerid]=965;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==965)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1463.1995,-1868.8994,13.3999, 4); //Przystanek commerce VB prawa
			CP[playerid]=966;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Verdant Bluffs / Urz¹d Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==966)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1181.8771,-1748.0386,12.9679, 4);
			CP[playerid]=967;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Verdant Bluffs / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==967)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1084.2205,-1569.8024,12.9443, 4);
			CP[playerid]=968;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Basen „Tsunami” / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==968)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 824.0928,-1624.2281,12.9477, 4);
			CP[playerid]=969;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Marina - Rodeo\n{808080}Nastêpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market – Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==969)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
			CP[playerid]=970;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: G³ówna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina – Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==970)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 535.0409,-1243.6492,16.0884, 4);// wypozyczalnia prawa
			CP[playerid]=971;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Wypo¿yczalnia Aut");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==971)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4);
			CP[playerid]=972;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: MRUCZNIK TOWER");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – Wypo¿yczalnia Pojazdów", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==972)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 276.5778,-1575.9937,32.8686, 4); //Koñcowy CP
			CP[playerid]=1004;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Odjazd nast¹pi po sygnale");
			ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Rodeo - Mrucznik Tower", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! Ukoñczy³eœ trasê do Mrucznik Tower! (1/2 zadania). Mo¿esz odpocz¹æ.");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli chcesz jechaæ dalej wykonaj nawrót kieruj¹c siê do kolejnego checkpointu!");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==1004)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 577.4726,-1236.8068,17.0600, 4); //Druga strona ulicy CP
			CP[playerid]=973;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Wypo¿yczalnia Aut");
			ProxDetector(10.0, playerid, "Linia numer: {ADFF2F}96 (zielona) {FFFF00}Kierunek ==> {ADFF2F}WIÊZIENIE STANOWE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	        TogglePlayerControllable(playerid, 1);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==973)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4); //Druga strona ulicy CP
			CP[playerid]=974;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: G³ówna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – Wypo¿yczalnia Pojazdów", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==974)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 840.9546,-1614.0339,12.9483, 4);
			CP[playerid]=975;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==975)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1105.6156,-1574.0813,12.9401, 4);
			CP[playerid]=976;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina – Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==976)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1173.1520,-1825.2843,13.1789, 4);
			CP[playerid]=977;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market – Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==977)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1492,-1875.8005,13.9999, 4);
			CP[playerid]=978;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Verdant Bluffs / Urz¹d Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Basen „Tsunami” / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==978)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4); //wiadukt lewy
			CP[playerid]=979;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Verdant Bluffs", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==979)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=980;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==980)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1977.1256,-2168.7412,12.9419, 4);
			CP[playerid]=981;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==981)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2228.8030,-2198.2109,12.9153, 4);
			CP[playerid]=982;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Fabryka");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko – Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==982)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2335.9858,-2355.0427,13.3828, 4);
			CP[playerid]=983;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==983)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2495.6113,-2408.0415,13.5445, 4);
			CP[playerid]=984;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==984)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2687.6597,-2406.9775,13.6017, 4);
			CP[playerid]=985;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: WIÊZIENIE STANOWE");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 96);
		}
		else if(CP[playerid]==985)
		{
		    if(BusCzit[playerid] == 1)
			{
			    KickEx(playerid);
			}
			else
			{
			    ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Ocean Docks – Wiêzienie Stanowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 96 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez sygan³ GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				IncreasePlayerJobSkill(playerid, 8);
				GiveMoneyForBusStop(playerid, 96, true);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia96] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 - niebieska (230$/p , 9min, 21p, +2)\nLinia 72 - pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia ZAJ\nLinia 96 do zajezdni Ocean Docks\n{778899}Trasa: Ocean Docks\n{808080}Zatrzymuje siê na przystankach");
					SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
					CP[playerid]=1200;
				}
				else if(GetPlayerJob(playerid) == JOB_DRIVER)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia ZAJ\nLinia 96 do zajezdni Commerce\n{778899}Trasa: Ocean Docks - Lotnisko - El Corona - Pershing Square - Commerce\n{808080}Zatrzymuje siê na przystankach");
					SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
					CP[playerid]=1201;
    			}
			}
		}
	}
	if(PlayerInfo[playerid][pLinia85]==1)//linia 85 system autobusów
	{
		if(CP[playerid]==501) //Sprawdza czy dojecha³ do nastepnego
		{
		    DisablePlayerCheckpoint(playerid);
			/*GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "%s rozpocz¹³ trasê  na linii autobusowej numer {FF00FF}85 Wysypisko <==> Szpital{00D900C8}. Szczegó³owe informacje o trasach na /businfo", sendername);
			OOCNews(TEAM_GROVE_COLOR,string);*/
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Willowfield - East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Cluckin Bell");
			ProxDetector(10.0, playerid, "Linia numer: {FF00FF}85 (ró¿owa) {FFFF00}Kierunek ==> {FF00FF}SZPITAL", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2415.8232,-1912.1696,12.9518, 4); //... ustawia nastepnego
			CP[playerid]=502; //przypisuje id dla cp up
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		}
		else if(CP[playerid]==502)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2488.0164,-1506.9924,23.3944, 4);//uszkodzony
			CP[playerid]=503;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Myjnia Samochodowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Cluck'in Bell", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==503)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
			CP[playerid]=504;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Baza Mechaników");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Myjnia Samochodowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==504)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4);
			CP[playerid]=505;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==505)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2541.5476,-1050.6461,68.9680, 4); //Przystanek commerce VB prawa
			CP[playerid]=506;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==506)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2202.1843,-1011.6302,61.2425, 4);
			CP[playerid]=507;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Las Colinas 32");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==507)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2248.4707,-1139.6617,25.7001, 4);
			CP[playerid]=508;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==508)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1967.2327,-1198.9353,25.2217, 4);
			CP[playerid]=509;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==509)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1810.9371,-1181.5383,23.2077, 4);
			CP[playerid]=510;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}Nastêpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==510)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4);// wypozyczalnia prawa
			CP[playerid]=511;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}Nastêpny przystanek: Verte Bank");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==511)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
			CP[playerid]=512;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Market\n{808080}Nastêpny przystanek: SZPITAL");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==512)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1203.7321,-1358.3251,12.9416, 4); //Koñcowy CP
			CP[playerid]=1005;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Market - Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Odjazd nast¹pi po sygnale");
			ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Market – Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! Ukoñczy³eœ trasê do Mrucznik Tower! (1/2 zadania). Mo¿esz odpocz¹æ.");
			SendClientMessage(playerid, COLOR_GREEN, "Je¿eli chcesz jechaæ dalej wykonaj nawrót kieruj¹c siê do kolejnego checkpointu!");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==1005)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4); //Druga strona ulicy CP
			CP[playerid]=513;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Nastêpny przystanek: Verte Bank");
			ProxDetector(10.0, playerid, "Linia numer: {FF00FF}85 (ró¿owa) {FF00FF}Kierunek ==> {ADFF2F}WYSYPISKO", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	        TogglePlayerControllable(playerid, 1);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==513)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1781.2218,-1167.9779,23.2261, 4); //Druga strona ulicy CP
			CP[playerid]=514;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Nastêpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==514)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
			CP[playerid]=515;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Nastêpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==515)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2255.2795,-1145.6331,26.0940, 4);
			CP[playerid]=516;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Jefferson - Las Colinas - East Los Santos - Willowfield\n{808080}Nastêpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==516)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2193.2642,-1012.3875,61.8830, 4);
			CP[playerid]=517;
		    Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Las Colinas 34");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==517)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2520.0220,-1044.3973,68.9851, 4);
			CP[playerid]=518;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==518)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4); //wiadukt lewy
			CP[playerid]=519;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==519)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2864.6250,-1539.0991,10.4947, 4);
			CP[playerid]=520;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Baza Mechaników");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==520)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2514.7009,-1501.5859,23.8281, 4);
			CP[playerid]=521;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: Myjnia Samochodowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==521)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2411.1692,-1908.5591,12.9485, 4);
			CP[playerid]=522;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: Cluckin Bell");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Myjnia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==522)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2118.5024,-1891.6978,12.9058, 4);
			CP[playerid]=523;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: WYSYPISKO");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Clukin Bell", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			GiveMoneyForBusStop(playerid, 85);
		}
		else if(CP[playerid]==523)
		{
		    if(BusCzit[playerid] == 1)
			{
			    KickEx(playerid);
			}
			else
			{
			    Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Ocead Docks\n{778899}Trasa: Willowfield\n{808080}Zatrzymuje siê na przystankach");
			    ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Willowfield – Wysypisko", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 85 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 6480$ premii za dwukrotne przejechanie trasy! (24 przystanki)");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				IncreasePlayerJobSkill(playerid, 85);
				GiveMoneyForBusStop(playerid, 85, true);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia96] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Ocean Docks\n{778899}Trasa: Willowfield - Ocean Docks\n{808080}Zatrzymuje siê na przystankach");
					SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
					CP[playerid]=1200;
				}
				else if(GetPlayerJob(playerid) == JOB_DRIVER)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Commerce\n{778899}Trasa: Willowfield - Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siê na przystankach");
					SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
					CP[playerid]=1201;
    			}
			}
		}
	}
	//koniec linii 85 i system autobusów
	return 0;
}

//end