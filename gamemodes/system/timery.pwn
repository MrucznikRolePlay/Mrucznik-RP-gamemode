//timery.pwn

forward AC_AntyVehSpamLag();

//25.06.2014 Aktualizacja timerów (wszystkich) - optymalizacja Kubi
forward SpecToggle(playerid);
public SpecToggle(playerid)
{
    Streamer_ToggleAllItems(playerid, STREAMER_TYPE_OBJECT, 1);
    sendTipMessage(playerid, "Wczytywanie obiektów!");
}
forward SpawnPosInfo(playerid);
public SpawnPosInfo(playerid)
{
	new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    SetPVarFloat(playerid,"xposspawn",x);
    SetPVarFloat(playerid,"yposspawn",y);
    SetPVarFloat(playerid,"zposspawn",z);
}

public SprzedajMatsTimer(playerid,giveplayerid)
{
	if(GetPVarInt(giveplayerid, "OKupMats") == 1)
	{
		SetPVarInt(giveplayerid, "OKupMats", 0);
		SetPVarInt(giveplayerid, "Mats-id", 0);
  		SetPVarInt(giveplayerid, "Mats-kasa", 0);
    	SetPVarInt(giveplayerid, "Mats-mats", 0);
    	sendErrorMessage(giveplayerid, "Sprzeda¿ mats zosta³a anulowana!");
	}
	if(GetPVarInt(playerid, "OSprzedajMats") == 1)
	{
		SetPVarInt(playerid, "OSprzedajMats", 0);
		sendErrorMessage(playerid, "Sprzeda¿ mats zosta³a anulowana!");
	}
	return 1;
}

forward StopPlayerSound(playerid);
public StopPlayerSound(playerid)
{
	PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
}

forward ActorsFix(playerid);
public ActorsFix(playerid)
{
	new playerVW = GetPlayerVirtualWorld(playerid); 
	new playerINT = GetPlayerInterior(playerid); 
	RepairActors(playerVW, playerINT);
	if(IsAScripter(playerid))
	{
		sendTipMessage(playerid, "Reset Aktorów - UDANY"); 
	}
	return 1;
}
//Naprawianie timer
public Naprawa(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new string[256];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
		RepairCar[playerid] = GetPlayerVehicleID(playerid);
		SetVehicleHealth(RepairCar[playerid], 1000.0);
		RepairVehicle(RepairCar[playerid]);

		CarData[VehicleUID[RepairCar[playerid]][vUID]][c_Tires] = 0;
		CarData[VehicleUID[RepairCar[playerid]][vUID]][c_HP] = 1000.0;

		PlayerPlaySound(RepairCar[playerid], 1140, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1140, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "* Twój samochód zosta³ naprawiony za $%d przez mechanika %s.",RepairPrice[playerid],giveplayer);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* Naprawi³eœ pojazd %s, otrzymujesz $%d.",giveplayer,RepairPrice[playerid]);
		SendClientMessage(RepairOffer[playerid], COLOR_LIGHTBLUE, string);
		format(string, sizeof(string),"* Mechanik %s naprawia pojazd %s i chowa narzêdzia do skrzynki.",giveplayer,VehicleNames[GetVehicleModel(RepairCar[playerid])-400]);
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(string, sizeof(string), "* Silnik pojazdu znów dzia³a jak nale¿y (( %s ))", giveplayer);
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		PlayerInfo[RepairOffer[playerid]][pMechSkill] ++;
		if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 50)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 100)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 200)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 400)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		ZabierzKase(playerid, RepairPrice[playerid]);
		DajKase(RepairOffer[playerid], RepairPrice[playerid]);
		RepairOffer[playerid] = 999;
		RepairPrice[playerid] = 0;
		Naprawiasie[playerid] = 0;
	}
	else
	{
		SendClientMessage(playerid, -1, "Naprawa przerwana - wyszed³eœ z pojazdu");
	}
    return 1;
}

//===============[VINYL CLUB]=======
forward textVinylT();
public textVinylT(){
	new Float:Pos[3];
	GetDynamicObjectPos(text_Vinyl, Pos[0], Pos[1], Pos[2]);
	if(Pos[2] == -21.528980){
		MoveDynamicObject(text_Vinyl, 817.176879, -1386.975463, -23.0, 1);
	}else{
		MoveDynamicObject(text_Vinyl, 817.176879, -1386.975463, -21.528980, 1);
	}
	return 1;
}

forward FreezePlayer(playerid);
public FreezePlayer(playerid){
	TogglePlayerControllable(playerid, 1);
	if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)
	{
		ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 1, 0, 1); 
	}
	return 1;
}

forward SetTimeAndWeather (playerid);
public SetTimeAndWeather(playerid)
{
	new weatherID, timeVal; 
	weatherID = GetPVarInt(playerid, "WeatherToSet"); 
	timeVal = GetPVarInt(playerid, "TimeToSet");
	SetPlayerTime(playerid, timeVal, 0);
	SetPlayerWeather(playerid, weatherID);
	sendTipMessage(playerid, "Pomyœlnie ustalono pogodê i czas dla VW"); 
	KillTimer(SetTAWForPlayer[playerid]); 
	return 1;
}


//KONIEC
forward odczekaj15sec(playerid);
public odczekaj15sec(playerid)
{
	SetPVarInt(playerid, "CanDoIt", 0); 
	SetPVarInt(playerid, "WhatToDo", 0);
	KillTimer(odczekajTimer[playerid]);
	return 1; 
}
forward glosuj_admin_ankieta();
public glosuj_admin_ankieta()
{
	new string[128];
	glosowanie_admina_status = 0;
	SendAdminMessage(COLOR_RED, "=====[WYNIKI G£OSOWANIA]======"); 
	format(string, sizeof(string), "U¿ytkownicy, którzy g³osowali na TAK: %d", glosowanie_admina_tak);
	SendAdminMessage(COLOR_P@, string);
	format(string, sizeof(string), "U¿ytkownicy, którzy g³osowali na NIE: %d", glosowanie_admina_nie);
	SendAdminMessage(COLOR_P@, string);
	
	return 1;
}
//System Po¿arów v0.1
forward UsunPozar();
public UsunPozar()
{
    DeleteAllFire();
    return 1;
}
//Komendy Admina - Timer na oddanie HP
forward OddajZycieTimer(playerid);
public OddajZycieTimer(playerid)
{
	new stathptime = (GetPVarInt(playerid, "statusZycia")/1000);
	dajHPSekunda[playerid]++;
	if(dajHPSekunda[playerid] == stathptime)
	{
		new Float:ammoutHP;
		SetPlayerHealth(playerid, 1);
		ammoutHP = GetPVarFloat(playerid, "odnowaZyciaAdmin");
		SetPlayerHealth(playerid, ammoutHP);
		KillTimer(TimerOddaniaZycia[playerid]);
	}
	return 1;
}
forward JedzenieCooldown(playerid);
public JedzenieCooldown(playerid)
{
	new timeSec[MAX_PLAYERS];
	timeSec[playerid]++;
	if(timeSec[playerid] == 2)
	{
		TimerJedzenie[playerid] = 0;
		KillTimer(ZarcieCooldown[playerid]);
	}
	return 1;
}
//dialogi

forward timerDialogs(playerid);
public timerDialogs(playerid)
{
	dialTime[playerid]++; 
	if(dialTime[playerid] == 3)
	{
		dialTime[playerid] = 0; 
		dialAccess[playerid] = 0; 
		KillTimer(dialTimer[playerid]);
	}
	return 1;
}
//Anty-Komunikat-Timer
forward KomunikatCzas(playerid);
public KomunikatCzas(playerid)
{
	komunikatMinuty[playerid]++;
	if(komunikatMinuty[playerid] == 15)
	{
		new string[128];
		format(string, sizeof(string), "null");
		sendTipMessage(playerid, "Zakoñczono odliczanie - Mo¿esz ponownie wys³aæ komunikat frakcyjny"); 
		SetPVarString(playerid, "trescOgloszenia", string);
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 0;
		KillTimer(komunikatTime[playerid]);
	}
	return 1;
}
forward KomunikatCzasZerowanie(playerid);
public KomunikatCzasZerowanie(playerid)
{
	komunikatMinutyZerowanie[playerid]++;
	if(komunikatMinutyZerowanie[playerid] == 5)
	{
		new string[128];
		format(string, sizeof(string), "null"); 
		sendTipMessage(playerid, "Zakoñczono odliczanie - Mo¿esz ponowie wys³aæ komunikat frakcyjny"); 
		SetPVarString(playerid, "trescOgloszenia", string);
		KillTimer(komunikatTimeZerowanie[playerid]); 
	}

	return 1;
}

SendFireMessage(where[], why[], who[])
{
    SendSingleFireMessage(0xFFFFFFAA, "--------[ PO¯AR ]--------");
	SendSingleFireMessage(0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!");
	SendSingleFireMessage(0xAA3333AA, sprintf("MIEJSCE PO¯ARU: %s", where));
	SendSingleFireMessage(0xAA3333AA, sprintf("PRZYCZYNA PO¯ARU: %s", why));
	SendSingleFireMessage(0xAA3333AA, sprintf("ZG£OSI£: %s", who));
	SendSingleFireMessage(0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!");
	SendSingleFireMessage(0xFFFFFFAA, "--------[ PO¯AR ]--------");
}

SendSingleFireMessage(color, message[])
{
	SendFamilyMessage(FRAC_ERS, color, message);
	SendJobMessage(JOB_MEDIC, color, message);
}

//End komunikatów
forward AktywujPozar();
public AktywujPozar()
{
    SetTimer("UsunPozar", 3300_000, false); // po 55 minutach po¿ar gaœnie
    new losowy = random(28);
	ActiveFire = losowy - 1;
	if(losowy == 1)
	{
		SendFireMessage("Pole Position Club", "Gor¹ca striptizerka", "Barman");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Pole Position Club",1);
		AddFire(-4099.0014, 785.1650, 9.7375, 400);
		AddFire(-4101.2124, 782.6776, 7.0180, 400);
		AddFire(-4103.4726, 779.8381, 9.1447, 400);
		AddFire(-4105.6113, 779.0171, 4.7291, 400);
		AddFire(-4101.5922, 781.8870, 4.1410, 400);
		AddFire(-4111.4843, 777.7865, 8.7337, 400);
		AddFire(-4111.8168, 777.6309, 4.5463, 400);
		AddFire(-4106.1250, 772.1428, 4.5633, 400);
		AddFire(-4095.7746, 779.8300, 4.3690, 400);
		AddFire(-4088.7441, 804.2030, 5.8938, 400);
		AddFire(-4108.0791, 802.6027, 997.0234, 400);
		AddFire(-4111.0722, 811.7543, 998.1328, 400);
		AddFire(-4117.7573, 807.3981, 998.0703, 400);
		AddFire(-4117.4477, 799.5679, 997.8747, 400);
		AddFire(-4113.7656, 801.9726, 997.8671, 400);
		AddFire(-4113.8671, 806.7150, 998.0390, 400);
		AddFire(-4121.2373, 802.9171, 998.0106, 400);
    }
	else if(losowy == 2)
	{
		SendFireMessage("Malibu Club", "Shot palonego absynthu", "Franek Poscigowy");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Malibu Club",1);
    	AddFire(-3711.5034, 2170.9409, 5.9262, 400);
		AddFire(-3707.0126, 2174.3344, 6.0075, 400);
		AddFire(-3705.2858, 2177.6303, 8.6564, 400);
		AddFire(-3715.8337, 2166.9033, 7.3070, 400);
		AddFire(-3710.8076, 2161.7502, 3.7361, 400);
		AddFire(-3699.7641, 2172.2976, 3.6400, 400);
		AddFire(-3700.7197, 2160.9960, 4.2663, 400);
		AddFire(-3722.9133, 2162.3874, 5.6347, 400);
		AddFire(-3723.1430, 2159.4270, 5.6347, 400);
		AddFire(-3719.6557, 2173.0971, 997.5328, 400);
		AddFire(-3719.4873, 2169.0866, 997.5312, 400);
		AddFire(-3719.6704, 2169.0925, 997.5312, 400);
		AddFire(-3710.5544, 2180.4392, 997.9967, 400);
		AddFire(-3706.4687, 2183.6708, 998.2032, 400);
		AddFire(-3713.9938, 2184.8557, 997.2143, 400);
		AddFire(-3734.4301, 2180.9531, 999.1660, 400);
		AddFire(-3736.4414, 2175.7998, 996.5312, 400);
		AddFire(-3721.2333, 2179.2609, 996.5312, 400);
		AddFire(-3734.8759, 2194.1621, 998.4207, 400);
		AddFire(-3730.3994, 2194.1621, 998.4962, 400);
		AddFire(-3734.3212, 2190.7124, 997.5531, 400);
    }
	else if(losowy == 3)
	{
		SendFireMessage("Love Fist Bar", "Przeci¹¿enie wzmacniacza", "Jezz Torrent");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Love Fist Bar",1);
		AddFire(-5075.2299, 3405.1948, 4.6527, 400);
		AddFire(-5075.1513, 3399.5952, 4.6344, 400);
		AddFire(-5075.6723, 3405.5107, 8.7860, 400);
		AddFire(-5075.6723, 3408.2324, 10.8375, 400);
		AddFire(-5075.6723, 3410.3798, 9.7145, 400);
		AddFire(-5075.6738, 3412.6247, 10.2441, 400);
		AddFire(-5075.6738, 3412.7485, 6.4034, 400);
		AddFire(-5076.6591, 3410.8964, 5.1325, 400);
		AddFire(-5076.7182, 3409.4689, 4.6919, 400);
		AddFire(-4794.5986, 2893.3352, 996.1406, 400);
		AddFire(-4792.6708, 2886.6774, 996.2239, 400);
		AddFire(-4792.2998, 2893.0175, 996.0468, 400);
		AddFire(-4791.9946, 2895.9670, 995.7118, 400);
		AddFire(-4801.3271, 2897.7053, 994.9921, 400);
		AddFire(-4800.7202, 2894.1359, 995.5549, 400);
		AddFire(-4797.4018, 2892.3908, 994.9921, 400);
		AddFire(-4802.7329, 2880.2968, 995.5754, 400);
		AddFire(-4802.7807, 2883.4792, 995.5546, 400);
		AddFire(-4793.5854, 2882.7685, 994.9921, 400);
		AddFire(-4794.3725, 2880.4282, 994.9921, 400);
		AddFire(-4800.1665, 2877.0187, 995.1594, 400);
    }
	else if(losowy == 4)
	{
		SendFireMessage("Cafe Robina", "Jajecznica na bekonie", "Klient");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Cafe Robina",1);
		AddFire(-5367.6357, 1642.1871, 7.1062, 400);
		AddFire(-5372.1113, 1641.7890, 7.2000, 400);
		AddFire(-5368.4023, 1641.8265, 5.4156, 400);
		AddFire(-5362.5825, 1629.6480, 5.8268, 400);
		AddFire(-5367.7656, 1617.6192, 5.2927, 400);
		AddFire(-5372.4296, 1620.4407, 6.4871, 400);
		AddFire(-5372.8813, 1623.4473, 6.4073, 400);
		AddFire(-5373.1860, 1626.6683, 6.5017, 400);
		AddFire(-5373.6254, 1629.5211, 6.4238, 400);
		AddFire(-5374.0771, 1632.1821, 6.3347, 400);
		AddFire(-5375.1318, 1638.3770, 6.3470, 400);
		AddFire(-5374.5981, 1635.2518, 6.4026, 400);
		AddFire(-5372.7197, 1637.0668, 1000.2918, 400);
		AddFire(-5372.0180, 1634.1188, 1000.2918, 400);
		AddFire(-5371.1577, 1632.1221, 1000.5171, 400);
		AddFire(-5368.0903, 1632.6411, 1000.2918, 400);
		AddFire(-5368.7778, 1636.5987, 1000.2918, 400);
		AddFire(-5365.4423, 1634.3016, 1001.3002, 400);
		AddFire(-5365.9130, 1636.3101, 1001.4121, 400);
		AddFire(-5365.4370, 1637.7226, 1001.3468, 400);
		AddFire(-5365.5771, 1638.7396, 1001.4128, 400);
		AddFire(-5366.1826, 1628.1030, 1000.2992, 400);
		AddFire(-5363.8349, 1629.5499, 1000.2918, 400);
		AddFire(-5367.7416, 1617.7056, 1000.3880, 400);
    }
	else if(losowy == 5)
	{
		SendFireMessage("Taco Apocalypse", "Ostry sos Chilli", "Meksykaniec");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Taco Apocalypse",1);
    	AddFire(-4960.9960, 3578.6591, 5.3040, 400);
		AddFire(-4958.5361, 3575.9296, 5.5174, 400);
		AddFire(-4954.9995, 3581.1899, 5.2817, 400);
		AddFire(-4958.8940, 3582.8395, 6.0454, 400);
		AddFire(-4955.7275, 3585.6462, 6.1000, 400);
		AddFire(-4959.6953, 3590.3171, 6.1020, 400);
		AddFire(-4961.6464, 3594.0502, 6.0797, 400);
		AddFire(-4956.3881, 3594.2387, 5.4358, 400);
		AddFire(-4953.0908, 3595.5793, 6.9778, 400);
		AddFire(-4952.5297, 3590.8942, 6.9716, 400);
		AddFire(-4952.8095, 3593.2133, 5.5438, 400);

    }
	else if(losowy == 6)
	{
		SendFireMessage("Niebieski Parasol", "Za s³ona zupa", "Kelner");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Niebieski parasol",1);
		AddFire(-4950.9804, 2502.2084, 10.4173, 400);
		AddFire(-4946.2036, 2501.0571, 10.6754, 400);
		AddFire(-4940.6650, 2503.3466, 10.6595, 400);
		AddFire(-4937.9453, 2508.0705, 10.2027, 400);
		AddFire(-4950.4072, 2506.2827, 10.4661, 400);
		AddFire(-4953.8320, 2497.2299, 9.7818, 400);
		AddFire(-4953.8901, 2494.3266, 9.7818, 400);
		AddFire(-4945.9731, 2492.4387, 10.4810, 400);
		AddFire(-4943.8837, 2482.7138, 10.4385, 400);
		AddFire(-4953.4394, 2484.2343, 10.4848, 400);
		AddFire(-4951.1376, 2480.1909, 10.5673, 400);
		AddFire(-4939.8261, 2529.6389, 10.6450, 400);
		AddFire(-4935.9003, 2532.7192, 10.6085, 400);
		AddFire(-4943.5917, 2532.8300, 10.6595, 400);
		AddFire(-4945.0639, 2536.5610, 10.4537, 400);
		AddFire(-4931.9863, 2533.2177, 10.4630, 400);
    }
	else if(losowy == 7)
	{
		SendFireMessage("Mansion Weinfall", "Grillowanie termitem", "Przechodzeñ");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Mansion Weinfall",1);
		AddFire(-4093.2451, 681.2468, 7.7386, 400);
		AddFire(-4095.9848, 683.9639, 7.8909, 400);
		AddFire(-4094.7988, 685.8900, 5.3662, 400);
		AddFire(-4091.6882, 682.6721, 4.6736, 400);
		AddFire(-4093.5039, 679.4355, 4.7486, 400);
		AddFire(-4098.9707, 678.6906, 4.5730, 400);
		AddFire(-4097.8925, 683.2999, 4.4102, 400);
		AddFire(-4096.9482, 690.0032, 5.1342, 400);
		AddFire(-4096.3715, 697.6108, 5.9040, 400);
		AddFire(-4086.1206, 680.3910, 5.6865, 400);
		AddFire(-4079.9506, 681.9512, 5.7954, 400);
		AddFire(-4071.5302, 684.3638, 5.8663, 400);
    }
	else if(losowy == 8)
	{
		SendFireMessage("Cafe Under Tree", "Atak kosmitów", "Anonim");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Cafe Under Tree",1);
    	AddFire(-5114.0673, 2295.8793, 4.0079, 400);
		AddFire(-5114.0815, 2299.5966, 4.2153, 400);
		AddFire(-5114.1113, 2302.8603, 5.6842, 400);
		AddFire(-5114.1005, 2305.7907, 4.2933, 400);
		AddFire(-5114.1528, 2309.1450, 7.3322, 400);
		AddFire(-5105.3608, 2305.5295, 3.0407, 400);
		AddFire(-5121.4624, 2311.9316, 3.7391, 400);

    }
	else if(losowy == 9)
	{
		SendFireMessage("Palm Restaurant", "Samozap³on nawozu do palm", "Ogrodnik");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Palm Restaurant",1);
    	AddFire(-4011.2539, 1254.4381, 5.8923, 400);
		AddFire(-4011.2539, 1249.2283, 5.3703, 400);
		AddFire(-4011.2534, 1244.6735, 5.0974, 400);
		AddFire(-4011.2539, 1242.1922, 5.8737, 400);
		AddFire(-4011.2539, 1237.6668, 5.5609, 400);
		AddFire(-4008.8061, 1232.8229, 5.7850, 400);
		AddFire(-4008.5483, 1228.8531, 5.4193, 400);
		AddFire(-4008.2592, 1235.7944, 5.8245, 400);
		AddFire(-4008.5649, 1227.5419, 5.2352, 400);
		AddFire(-4011.3500, 1232.0720, 5.7267, 400);
		AddFire(-4010.4458, 1235.0366, 5.4019, 400);
		AddFire(-4007.6025, 1245.6499, 5.4493, 400);
		AddFire(-4005.9023, 1243.1599, 5.6565, 400);
		AddFire(-4003.5473, 1250.0092, 5.5366, 400);
		AddFire(-4004.8842, 1247.1850, 5.7926, 400);
		AddFire(-4003.6135, 1250.9403, 5.3936, 400);
		AddFire(-4007.1035, 1248.8498, 5.6306, 400);
		AddFire(-4001.0722, 1243.0032, 4.1609, 400);
		AddFire(-4001.1923, 1248.8598, 4.7380, 400);
		AddFire(-4002.3747, 1233.8602, 4.5874, 400);
		AddFire(-4006.0766, 1228.6485, 4.7331, 400);
    }
	else if(losowy == 10)
	{
		SendFireMessage("Crab Bar", "Atak wegetarian", "Kucharz");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Crab Bar",1);
		AddFire(-5030.0937, 2994.4335, 4.7473, 400);
		AddFire(-5031.2504, 2992.9702, 6.0043, 400);
		AddFire(-5028.8623, 2996.0241, 7.0403, 400);
		AddFire(-5031.8989, 2997.4057, 5.9705, 400);
		AddFire(-5035.0063, 2998.2248, 5.9624, 400);
		AddFire(-5039.4755, 2998.5212, 5.7204, 400);
		AddFire(-5043.5317, 2998.9829, 5.8454, 400);
		AddFire(-5035.5620, 2999.5097, 8.1854, 400);
		AddFire(-5041.2973, 2999.1433, 10.4230, 400);
		AddFire(-5043.4345, 3004.5268, 13.3634, 400);
	}
	else if(losowy == 11)
	{
		SendFireMessage("Crocs Bar", "Bójka", "Konfident");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Crocs Bar",1);
    	AddFire(-5300.7187, 2376.3549, 4.9006, 400);
		AddFire(-5297.5161, 2376.3549, 6.5699, 400);
		AddFire(-5296.2456, 2376.3549, 9.6149, 400);
		AddFire(-5294.8613, 2376.3549, 5.7295, 400);
		AddFire(-5291.5522, 2376.3549, 9.5409, 400);
		AddFire(-5291.2216, 2376.3549, 4.8627, 400);
		AddFire(-5288.2456, 2376.3549, 8.6379, 400);
		AddFire(-5286.8906, 2376.3549, 5.1562, 400);
		AddFire(-5293.6357, 2376.3549, 9.6282, 400);
		AddFire(-5282.6831, 2376.3549, 9.4214, 400);
		AddFire(-5279.1772, 2376.3549, 9.9130, 400);
	}
	else if(losowy == 12)
	{
		SendFireMessage("Ammu-Nation Ocean Beach", "Test koktajlu Molotova", "Pracownik");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Ammu-Nation Ocean Beach",1);
    	AddFire(-4259.1748, 762.7202, 4.6265, 400);
		AddFire(-4258.8994, 766.1691, 4.7210, 400);
		AddFire(-4258.9599, 768.6765, 3.9669, 400);
		AddFire(-4260.4160, 767.5731, 7.4333, 400);
		AddFire(-4258.2246, 770.5593, 7.7017, 400);
		AddFire(-4258.4013, 772.2121, 4.5241, 400);
		AddFire(-4258.2353, 774.2861, 5.5295, 400);
		AddFire(-4258.0302, 776.8585, 4.5928, 400);
		AddFire(-4257.2812, 781.8440, 9.9492, 400);
		AddFire(-4258.2978, 770.1652, 9.7417, 400);
		AddFire(-4258.1582, 771.7418, 9.7290, 400);
		AddFire(-4259.0073, 761.9127, 9.7007, 400);
		AddFire(-4262.7382, 761.0623, 4.2908, 400);
		AddFire(-4257.5522, 782.3413, 6.5294, 400);
		AddFire(-4257.4912, 782.3361, 6.5148, 400);
	}
	else if(losowy == 13)
	{
		SendFireMessage("Ammu-Nation North Point", "Ogniste przeceny", "Galerianka");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Ammu-Nation North Point",1);
    	AddFire(-3846.2707, 3300.6115, 1212.7875, 400);
		AddFire(-3845.2175, 3300.4006, 1216.9465, 400);
		AddFire(-3843.4633, 3300.6271, 1214.6146, 400);
		AddFire(-3842.1789, 3300.6237, 1213.2374, 400);
		AddFire(-3841.0329, 3302.4948, 1215.7044, 400);
		AddFire(-3838.5354, 3302.0444, 1213.2315, 400);
		AddFire(-3839.5798, 3300.3964, 1216.7691, 400);
		AddFire(-3835.9868, 3300.6621, 1215.6394, 400);
		AddFire(-3836.1584, 3300.6364, 1213.9162, 400);
		AddFire(-3831.0544, 3300.6335, 1215.1641, 400);
		AddFire(-3834.7028, 3300.3928, 1216.8853, 400);
		AddFire(-3830.1506, 3300.6181, 1212.6899, 400);
	}
	else if(losowy == 14)
	{
		SendFireMessage("Ammu-Nation Downtown", "Detonacja Claymore w WC", "Klient");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Ammu-Nation Downtown",1);
    	AddFire(-4882.5151, 3449.7287, 7.8994, 400);
		AddFire(-4881.4990, 3449.7304, 5.0931, 400);
		AddFire(-4879.1796, 3449.7343, 7.5763, 400);
		AddFire(-4877.8627, 3450.9807, 5.2933, 400);
		AddFire(-4876.3784, 3451.4567, 6.2526, 400);
		AddFire(-4875.4306, 3451.3242, 4.5364, 400);
		AddFire(-4873.3925, 3449.7233, 7.3252, 400);
		AddFire(-4870.1489, 3449.7253, 6.1319, 400);
		AddFire(-4867.1879, 3449.7312, 7.2988, 400);
		AddFire(-4867.2070, 3449.6232, 4.6091, 400);
		AddFire(-4872.1230, 3449.0603, 11.1556, 400);
		AddFire(-4877.2490, 3449.0187, 9.4223, 400);
		AddFire(-4880.9208, 3448.9946, 11.3011, 400);
	}
	else if(losowy == 15)
	{
		SendFireMessage("Stacja Benzynowa Vice City", "Strza³ w instrybutor", "Vlogger");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Stacja Benzynowa Vice City",1);
    	AddFire(-4170.4111, 1178.8525, 3.9239, 400);
		AddFire(-4166.4301, 1178.3299, 5.9870, 400);
		AddFire(-4162.3295, 1178.3299, 3.9992, 400);
		AddFire(-4155.5532, 1178.3299, 5.7508, 400);
		AddFire(-4153.7226, 1178.3299, 4.1293, 400);
		AddFire(-4159.0512, 1178.3299, 4.4095, 400);
		AddFire(-4166.2695, 1178.3299, 8.1711, 400);
		AddFire(-4156.6777, 1178.3299, 7.9420, 400);
		AddFire(-4167.5048, 1191.2703, 4.0137, 400);
		AddFire(-4164.8437, 1191.5770, 4.0712, 400);
		AddFire(-4161.6333, 1191.6577, 6.7392, 400);
		AddFire(-4155.2875, 1191.6453, 9.2032, 400);
		AddFire(-4158.2207, 1192.1231, 4.0712, 400);
		AddFire(-4160.2397, 1191.2703, 3.9912, 400);
		AddFire(-4156.4379, 1192.6682, 4.0712, 400);
		AddFire(-4148.4306, 1174.4979, 6.4448, 400);
		AddFire(-4146.6718, 1174.1102, 4.0037, 400);
		AddFire(-4137.4785, 1181.9432, 9.2033, 400);
		AddFire(-4141.9199, 1176.1468, 6.9633, 400);
		AddFire(-4140.7617, 1172.9193, 5.9670, 400);
		AddFire(-4141.6782, 1169.5010, 5.1938, 400);
		AddFire(-4133.5219, 1174.7054, 4.0713, 400);
		AddFire(-4160.8793, 1159.2314, 5.3244, 400);
		AddFire(-4158.7070, 1163.9459, 4.5076, 400);
		AddFire(-4163.5996, 1163.9459, 5.6482, 400);
		AddFire(-4160.2949, 1161.5289, 6.9868, 400);
		AddFire(-4159.9736, 1161.3045, 3.9239, 400);
		AddFire(-4168.6284, 1198.2580, 9.2032, 400);
		AddFire(-4136.1762, 1203.1990, 11.7118, 400);
		AddFire(-4135.1240, 1202.3991, 9.1429, 400);
	}
	else if(losowy == 16)
	{
		SendFireMessage("Tor wyœcigowy na pla¿y", "Piekielny upa³", "Surfer");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Tor wyœcigowy na pla¿y",1);
		AddFire(-3463.4716, 2988.3137, 7.8651, 400);
		AddFire(-3458.8693, 2987.3662, 7.6701, 400);
		AddFire(-3461.2888, 2987.8750, 10.0233, 400);
		AddFire(-3462.2395, 2988.0661, 10.3359, 400);
		AddFire(-3453.9077, 3038.8566, 15.5117, 400);
		AddFire(-3453.1315, 3040.2236, 14.9144, 400);
		AddFire(-3452.4645, 3041.3981, 13.0711, 400);
		AddFire(-3332.2871, 3023.6169, 11.0407, 400);
		AddFire(-3331.6484, 3025.0673, 10.5056, 400);
		AddFire(-3331.2507, 3025.9699, 8.9163, 400);
		AddFire(-3333.3942, 3021.1035, 8.7085, 400);
		AddFire(-3339.3164, 3060.9895, 11.6252, 400);
		AddFire(-3342.0908, 3057.2375, 10.4488, 400);
		AddFire(-3342.0649, 3057.2724, 9.6274, 400);
		AddFire(-3309.6398, 3124.0229, 12.0788, 400);
		AddFire(-3310.2111, 3124.6740, 11.0493, 400);
		AddFire(-3307.4628, 3121.5419, 10.3211, 400);
	}
	else if(losowy == 17)
	{
		SendFireMessage("Tor wyœcigowy Dirt", "Palenie sprzêg³a", "Instruktor");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Tor wyœcigowy Dirt",1);
		AddFire(-4549.4565, 3667.9060, 7.1114, 400);
		AddFire(-4555.4580, 3667.9060, 9.4352, 400);
		AddFire(-4544.1816, 3667.9060, 4.4970, 400);
		AddFire(-4545.7202, 3667.9060, 3.9256, 400);
		AddFire(-4538.4355, 3667.9060, 6.9187, 400);
		AddFire(-4520.7553, 3667.9060, 8.8753, 400);
		AddFire(-4516.6870, 3667.9060, 8.8572, 400);
		AddFire(-4606.5791, 3716.9814, 4.5429, 400);
		AddFire(-4615.0297, 3729.3754, 4.6845, 400);
		AddFire(-4624.0029, 3734.9609, 4.4624, 400);
		AddFire(-4658.7377, 3705.8530, 5.5898, 400);
		AddFire(-4677.0673, 3712.8652, 5.6128, 400);
		AddFire(-4690.8764, 3686.0437, 10.1215, 400);
		AddFire(-4709.8334, 3654.4990, 8.4415, 400);
		AddFire(-4714.1010, 3664.1145, 6.9394, 400);
		AddFire(-4714.3378, 3663.8593, 6.9747, 400);
		AddFire(-4745.6708, 3662.1013, 5.8931, 400);
		AddFire(-4763.4189, 3665.2626, 5.8339, 400);
		AddFire(-4761.2465, 3665.2875, 5.7248, 400);
	}
	else if(losowy == 18)
	{
		SendFireMessage("Dirt Ring", "Nieudana sztuczka kaskaderska", "Widz");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Dirt Ring",1);
		AddFire(-5309.4487, 3580.2973, 13.5746, 400);
		AddFire(-5309.6538, 3581.7104, 13.5746, 400);
		AddFire(-5309.6328, 3586.0358, 14.9829, 400);
		AddFire(-5309.5561, 3592.1425, 14.2357, 400);
		AddFire(-5310.8920, 3599.7087, 14.1100, 400);
		AddFire(-5313.5952, 3615.0046, 13.5011, 400);
		AddFire(-5315.9462, 3628.3610, 12.8130, 400);
		AddFire(-5309.4658, 3594.7097, 18.4972, 400);
		AddFire(-5307.3833, 3582.7722, 19.2268, 400);
		AddFire(-5308.7109, 3572.3449, 18.3434, 400);
		AddFire(-5309.6196, 3575.3994, 14.5407, 400);
		AddFire(-5309.5249, 3570.1054, 14.0278, 400);
		AddFire(-5311.2402, 3560.4313, 15.4757, 400);
		AddFire(-5314.0053, 3544.6525, 13.0137, 400);
		AddFire(-5316.1914, 3532.2539, 14.1556, 400);
		AddFire(-5314.7392, 3538.1743, 17.0172, 400);
		AddFire(-5292.7915, 3557.0456, 14.5710, 400);
		AddFire(-5292.7915, 3573.9079, 14.2255, 400);
		AddFire(-5292.7915, 3598.5493, 13.8719, 400);
		AddFire(-5299.9638, 3577.4843, 13.5289, 400);
		AddFire(-5302.0659, 3566.1347, 13.5289, 400);
	}
	else if(losowy == 19)
	{
		SendFireMessage("Rockstar Casino", "Awaria ko³a fortuny", "Hazardzista");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Rockstar Casino",1);
		AddFire(-4756.1782, 3420.2705, 5.0192, 400);
		AddFire(-4753.4047, 3420.2707, 5.5175, 400);
		AddFire(-4756.5688, 3419.6533, 11.2384, 400);
		AddFire(-4754.4418, 3419.6535, 9.2932, 400);
		AddFire(-4749.6831, 3420.2705, 7.1347, 400);
		AddFire(-4748.2226, 3420.2707, 7.1403, 400);
		AddFire(-4759.8715, 3420.2705, 6.9341, 400);
		AddFire(-4762.3720, 3420.2775, 7.2433, 400);
		AddFire(-4761.8999, 3419.7395, 10.3942, 400);
		AddFire(-4747.4379, 3413.1950, 4.9751, 400);
		AddFire(-4754.0727, 3410.9689, 4.7971, 400);
		AddFire(-4758.8012, 3411.4619, 4.7971, 400);
		AddFire(-4763.2583, 3406.3447, 5.7073, 400);
		AddFire(-4767.3125, 3414.0283, 10.9345, 400);
		AddFire(-4771.9228, 3414.0283, 6.9253, 400);
		AddFire(-4743.2353, 3414.0283, 10.7503, 400);
		AddFire(-4739.2314, 3414.0283, 7.5215, 400);
	}
	else if(losowy == 20)
	{
		SendFireMessage("Pay 'N' Spray Ocean Beach", "Eksperymentalne paliwo", "Mechanik");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Pay 'N' Spray Ocean Beach",1);
		AddFire(-4208.1225, 997.4619, 8.3951, 400);
		AddFire(-4207.7998, 994.2773, 4.0561, 400);
		AddFire(-4207.7998, 990.4114, 7.2524, 400);
		AddFire(-4208.1225, 987.6510, 4.2649, 400);
		AddFire(-4213.5449, 985.2304, 5.4632, 400);
		AddFire(-4197.5991, 976.0374, 6.4967, 400);
		AddFire(-4208.1225, 972.5946, 8.1641, 400);
		AddFire(-4213.9702, 974.0557, 11.1603, 400);
		AddFire(-4213.9702, 981.7552, 10.8329, 400);
		AddFire(-4217.7724, 984.6561, 9.3752, 400);
		AddFire(-4213.9702, 988.8543, 11.2270, 400);
		AddFire(-4213.9702, 996.8407, 12.0182, 400);
		AddFire(-4213.8115, 996.3172, 3.9266, 400);
		AddFire(-4208.1225, 984.4678, 3.9790, 400);
		AddFire(-4213.3354, 977.5470, 3.9266, 400);
	}
	else if(losowy == 21)
	{
		SendFireMessage("Pay 'n' Spray Vice Point", "Dachowanie", "Listonosz");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Pay 'n' Spray Vice Point",1);
		AddFire(-3865.6474, 2693.2407, 5.0610, 400);
		AddFire(-3875.5322, 2681.2656, 5.3475, 400);
		AddFire(-3875.5322, 2682.5351, 8.1100, 400);
		AddFire(-3875.5322, 2676.7480, 9.2821, 400);
		AddFire(-3875.5322, 2686.1677, 8.8486, 400);
		AddFire(-3875.5322, 2688.7949, 5.1450, 400);
		AddFire(-3880.9545, 2688.1259, 5.4982, 400);
		AddFire(-3870.6274, 2675.9882, 4.6967, 400);
		AddFire(-3881.3798, 2697.1723, 12.7361, 400);
		AddFire(-3881.3798, 2689.5371, 11.4583, 400);
		AddFire(-3881.3798, 2686.2153, 13.6773, 400);
		AddFire(-3881.3798, 2679.9233, 12.2988, 400);
		AddFire(-3874.8779, 2679.0673, 8.1919, 400);
		AddFire(-3874.9199, 2682.3764, 4.6582, 400);
		AddFire(-3864.4331, 2685.2988, 5.0771, 400);
	}
	else if(losowy == 22)
	{
		SendFireMessage("Pay 'n' Spray Vice Port", "Palenie gumy", "Babcia klozetowa");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Pay 'n' Spray Vice Port",1);
		AddFire(-5099.2333, 974.7965, 5.1983, 400);
		AddFire(-5105.3833, 976.6154, 6.4059, 400);
		AddFire(-5105.3837, 973.1872, 9.0960, 400);
		AddFire(-5105.3833, 980.5744, 8.8798, 400);
		AddFire(-5105.3833, 983.7277, 6.7717, 400);
		AddFire(-5110.6386, 983.7866, 7.7204, 400);
		AddFire(-5108.6708, 988.4194, 5.3936, 400);
		AddFire(-5105.2880, 997.3254, 8.0648, 400);
		AddFire(-5110.5595, 996.0603, 5.7288, 400);
		AddFire(-5111.1699, 992.5671, 11.6576, 400);
		AddFire(-5111.1699, 984.9616, 12.5772, 400);
		AddFire(-5106.6699, 977.1725, 9.1930, 400);
		AddFire(-5111.1699, 974.3908, 12.5833, 400);
		AddFire(-5111.1699, 971.4519, 10.7022, 400);
		AddFire(-5110.4458, 971.3386, 7.0068, 400);
		AddFire(-5105.3833, 974.3684, 8.4153, 400);
		AddFire(-5107.0913, 976.0390, 5.2138, 400);
	}
	else if(losowy == 23)
	{
		SendFireMessage("Pay 'n' Spray Little Haiti", "Brak napiwku", "Przera¿ony klient");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Pay 'n' Spray Little Haiti",1);
		AddFire(-5063.2954, 2143.8588, 4.5671, 400);
		AddFire(-5078.9550, 2128.1789, 7.7652, 400);
		AddFire(-5076.7216, 2132.4262, 9.4495, 400);
		AddFire(-5073.9614, 2133.1872, 7.8315, 400);
		AddFire(-5073.9609, 2137.4025, 5.7175, 400);
		AddFire(-5073.9609, 2140.8442, 7.9226, 400);
		AddFire(-5070.0249, 2140.1342, 4.5671, 400);
		AddFire(-5073.4497, 2135.4406, 6.5916, 400);
		AddFire(-5075.9321, 2130.5686, 4.6079, 400);
		AddFire(-5073.9287, 2133.2199, 4.5667, 400);
		AddFire(-5073.9628, 2153.0356, 7.5781, 400);
		AddFire(-5078.9902, 2152.9201, 4.7094, 400);
		AddFire(-5079.8100, 2148.7373, 11.0123, 400);
		AddFire(-5079.8100, 2141.6733, 12.0851, 400);
		AddFire(-5079.8105, 2138.1010, 10.0402, 400);
		AddFire(-5079.8105, 2131.0034, 12.0745, 400);
		AddFire(-5064.5595, 2136.9084, 4.5671, 400);
	}
	else if(losowy == 24)
	{
		SendFireMessage("Klub Golfowy", "Strza³ w rurê z gazem", "Asystent Instruktora");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Klub Golfowy",1);
		AddFire(-4101.9287, 2527.6953, 17.4388, 400);
		AddFire(-4097.6767, 2529.2299, 17.4833, 400);
		AddFire(-4104.8515, 2526.4548, 15.5505, 400);
		AddFire(-4104.6323, 2524.9584, 15.4232, 400);
		AddFire(-4101.8662, 2516.9877, 16.7471, 400);
		AddFire(-4098.8154, 2509.8032, 16.7341, 400);
		AddFire(-4105.0073, 2517.8493, 15.2319, 400);
		AddFire(-4110.0449, 2521.0539, 15.4865, 400);
		AddFire(-4115.9833, 2521.7304, 17.3868, 400);
		AddFire(-4120.3920, 2519.8593, 17.1768, 400);
		AddFire(-4124.4418, 2518.1406, 17.1765, 400);
		AddFire(-4105.8144, 2510.8195, 15.2319, 400);
		AddFire(-4105.6137, 2508.9191, 16.7714, 400);
		AddFire(-4108.0371, 2518.4150, 15.6485, 400);
		AddFire(-4104.2646, 2512.0395, 15.6485, 400);
		AddFire(-4102.8085, 2509.6425, 15.6485, 400);
		AddFire(-4082.4409, 2513.1950, 15.2319, 400);
		AddFire(-4095.2797, 2495.8134, 15.5706, 400);
		AddFire(-4097.5341, 2499.6342, 15.6562, 400);
		AddFire(-4084.5917, 2516.2719, 17.5815, 400);
		AddFire(-4084.3327, 2520.3217, 17.5411, 400);
		AddFire(-4100.2055, 2501.2167, 19.6525, 400);
		AddFire(-4095.8427, 2503.3425, 16.9409, 400);
		AddFire(-4109.3378, 2501.4687, 20.6034, 400);
		AddFire(-4116.7617, 2508.3979, 26.1910, 400);
		AddFire(-4094.5266, 2517.4023, 25.1952, 400);
		AddFire(-4093.1757, 2508.1284, 20.6513, 400);
		AddFire(-4104.8320, 2513.3198, 25.4900, 400);
	}
	else if(losowy == 25)
	{
		SendFireMessage("Klub Jachtowy", "Odpalanie cygara od banknotu", "Milioner");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Klub Jachtowy",1);
		AddFire(-4433.8876, 944.8691, 2.8907, 400);
		AddFire(-4434.9521, 952.8477, 2.9631, 400);
		AddFire(-4428.7275, 951.3454, 2.6633, 400);
		AddFire(-4428.7275, 948.7353, 4.6152, 400);
		AddFire(-4428.7280, 946.1713, 2.8110, 400);
		AddFire(-4429.2197, 942.1599, 3.8666, 400);
		AddFire(-4429.2202, 936.3128, 4.4851, 400);
		AddFire(-4429.2202, 932.2536, 4.8567, 400);
		AddFire(-4429.2197, 928.1384, 3.7969, 400);
		AddFire(-4431.7817, 927.9924, 2.7497, 400);
		AddFire(-4434.3115, 934.5546, 2.1817, 400);
		AddFire(-4434.4736, 939.8625, 2.1817, 400);
		AddFire(-4435.0571, 959.6466, 2.1817, 400);
		AddFire(-4434.3798, 966.4470, 2.1817, 400);
		AddFire(-4432.3447, 980.8255, 4.0253, 400);
		AddFire(-4432.3447, 973.0300, 4.1723, 400);
		AddFire(-4430.1875, 961.6776, 5.8854, 400);
		AddFire(-4429.2197, 959.4172, 3.1400, 400);
		AddFire(-4429.2197, 956.5507, 4.7999, 400);
		AddFire(-4430.4199, 952.0536, 9.5047, 400);
		AddFire(-4429.9541, 948.7400, 10.2595, 400);
		AddFire(-4429.5844, 946.1082, 8.4848, 400);
		AddFire(-4434.2119, 948.6433, 5.9496, 400);
	}
	else if(losowy == 26)
	{
		SendFireMessage("Stocznia", "Spawanie drewna", "Doker");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Stocznia",1);
		AddFire(-4937.3925, 745.7929, 8.6480, 400);
		AddFire(-4939.9389, 739.6729, 11.8428, 400);
		AddFire(-4941.1987, 736.6442, 8.8173, 400);
		AddFire(-4943.9721, 729.9783, 7.2241, 400);
		AddFire(-4945.6821, 725.8676, 11.8127, 400);
		AddFire(-4944.6611, 723.9910, 8.7619, 400);
		AddFire(-4942.1166, 723.0132, 12.4334, 400);
		AddFire(-4939.3085, 721.9342, 9.2594, 400);
		AddFire(-4940.6318, 716.4757, 8.7009, 400);
		AddFire(-4944.1699, 708.3834, 12.3727, 400);
		AddFire(-4904.3583, 722.2756, 6.4356, 400);
		AddFire(-4905.5932, 719.2155, 8.5672, 400);
		AddFire(-4907.4614, 714.5877, 6.4325, 400);
		AddFire(-4908.4399, 712.1630, 8.5357, 400);
		AddFire(-4894.0307, 746.3796, 6.4323, 400);
		AddFire(-4895.9335, 741.6613, 8.7181, 400);
		AddFire(-4897.9067, 736.7772, 6.4127, 400);
		AddFire(-4898.9238, 734.2622, 8.2672, 400);
		AddFire(-4899.5034, 732.2023, 6.7314, 400);
		AddFire(-4895.4033, 729.8438, 10.6619, 400);
		AddFire(-4887.6801, 726.7236, 10.5129, 400);
		AddFire(-4879.1391, 723.2731, 10.1999, 400);
		AddFire(-4886.2050, 719.0316, 10.6162, 400);
		AddFire(-4898.3862, 723.9528, 10.4127, 400);
		AddFire(-4932.7578, 717.5865, 6.2604, 400);
		AddFire(-4890.7270, 699.2888, 10.5048, 400);
		AddFire(-4900.1850, 703.1063, 10.2227, 400);
		AddFire(-4907.2983, 705.9775, 10.3531, 400);
		AddFire(-4909.9780, 707.7092, 7.5398, 400);
		AddFire(-4920.2084, 744.2813, 7.9523, 400);
		AddFire(-4916.4296, 744.2158, 7.6090, 400);
		AddFire(-4916.2363, 744.2125, 7.5276, 400);
		AddFire(-4912.8466, 744.1537, 7.6494, 400);
		AddFire(-4922.0932, 733.2620, 5.3452, 400);
		AddFire(-4913.7924, 729.1463, 5.3491, 400);
		AddFire(-4914.4130, 714.2532, 5.7774, 400);
	}
	else if(losowy == 27)
	{
		SendFireMessage("Fabryka klamek samochodowych", "Wybuch skrzyni z klamkami", "S¹siad");
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: Fabryka klamek samochodowych",1);
		AddFire(-4112.4394, 3192.8950, 6.3328, 400);
		AddFire(-4115.7221, 3194.8269, 4.2745, 400);
		AddFire(-4115.8876, 3198.3410, 4.2694, 400);
		AddFire(-4117.8881, 3197.1687, 6.1974, 400);
		AddFire(-4114.0351, 3201.6093, 5.5962, 400);
		AddFire(-4115.1293, 3197.0310, 9.3327, 400);
		AddFire(-4114.1508, 3219.9833, 6.9431, 400);
		AddFire(-4112.4575, 3208.3596, 4.9805, 400);
		AddFire(-4118.9467, 3198.6909, 10.8099, 400);
		AddFire(-4116.3842, 3209.9675, 11.2832, 400);
		AddFire(-4113.8647, 3211.9567, 4.7456, 400);
		AddFire(-4116.3071, 3201.5332, 8.3302, 400);
		AddFire(-4116.1826, 3201.4609, 8.3447, 400);
		AddFire(-4119.4106, 3196.6220, 9.3884, 400);
		AddFire(-4117.6044, 3194.0981, 9.2666, 400);
		AddFire(-4112.4877, 3187.9726, 9.2357, 400);
		AddFire(-4111.8305, 3191.0852, 9.2322, 400);
		AddFire(-4125.3203, 3195.5913, 11.0113, 400);
		AddFire(-4131.6367, 3197.0397, 10.9779, 400);
		AddFire(-4137.4267, 3198.3525, 11.4004, 400);
		AddFire(-4121.4428, 3179.6662, 9.6147, 400);
		AddFire(-4120.6640, 3171.0170, 9.2549, 400);
		AddFire(-4125.6337, 3169.1760, 10.1080, 400);
		AddFire(-4111.5581, 3178.5539, 6.9872, 400);
		AddFire(-4109.2529, 3188.9567, 6.8580, 400);
		AddFire(-4110.4848, 3183.3967, 4.4733, 400);
		AddFire(-4108.1723, 3167.8100, 4.6055, 400);
		AddFire(-4107.6826, 3173.1501, 7.9629, 400);
		AddFire(-4108.4487, 3164.7995, 7.7667, 400);
	}
    return 1;
}

//tazer
forward DostalTazerem(playerid);
public DostalTazerem(playerid)
{
    TogglePlayerControllable(playerid, 1);
    TazerAktywny[playerid] = 0;
    GameTextForPlayer(playerid, "JUZ MOZESZ SIE RUSZAC!", 3000, 5);
    ClearAnimations(playerid);
    SetPlayerDrunkLevel(playerid, 3000);
    return 1;
}
//tazer

//po /ob

forward WstalPoOB(playerid);
public WstalPoOB(playerid)
{
    GameTextForPlayer(playerid, "Odzyskales sprawnosc", 3000, 5);
    ClearAnimations(playerid);
	return 1;
}

//AFK timer
forward PlayerAFK(playerid, afktime, breaktime);
public PlayerAFK(playerid, afktime, breaktime)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	if(IsPlayerPaused(playerid))
	{
		new caption[32];
		if(afktime < 60)
			format(caption, sizeof(caption), "[AFK] %d sekund (%d)", afktime, playerid);
		else
			format(caption, sizeof(caption), "[AFK] %d min. %d sek (%d)", afktime/60, afktime%60, playerid);


		if(afktime == 840 && GetPlayerAdminDutyStatus(playerid) == 1)
		{
			GameTextForPlayer(playerid, "~r~Rusz sie! Anty-AFK!",5000, 5);
			SendClientMessage(playerid, COLOR_PANICRED, "Za minutê zostaniesz wyrzucony za Anty-AFK.");
		}
		else if(afktime == 1740 && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid)))
		{
			GameTextForPlayer(playerid, "~r~Rusz sie! Anty-AFK!",5000, 5);
			SendClientMessage(playerid, COLOR_PANICRED, "Za minutê zostaniesz wyrzucony za Anty-AFK.");
		}
		else if(afktime == 1140 && IsPlayerPremiumOld(playerid))
		{
			GameTextForPlayer(playerid, "~r~Rusz sie! Anty-AFK!",5000, 5);
			SendClientMessage(playerid, COLOR_PANICRED, "Za minutê zostaniesz wyrzucony za Anty-AFK.");
		}
		else if(afktime == 540)
		{
			GameTextForPlayer(playerid, "~r~Rusz sie! Anty-AFK!",5000, 5);
			SendClientMessage(playerid, COLOR_PANICRED, "Za minutê zostaniesz wyrzucony za Anty-AFK.");
		}
		if(afktime > 600 && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid)))
		{
			if(GetPlayerAdminDutyStatus(playerid) == 0)
			{
				if(afktime > 1800 && PlayerInfo[playerid][pAdmin] != 5000)
				{
					SendClientMessage(playerid, 0xAA3333AA, "Zosta³eœ skickowany za zbyt d³ugie AFK (30 minut).");
					SetTimerEx("KickEx", 500, false, "i", playerid);
				}
				SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
				
			}
			else
			{
				if(afktime > 900 && PlayerInfo[playerid][pAdmin] != 5000)
				{
					SendClientMessage(playerid, 0xAA3333AA, "Nie wolno afczyæ podczas @Duty! Otrzymujesz Kicka za AFK (15min)");
					SetTimerEx("KickEx", 500, false, "i", playerid);
				}
				SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
			}
		}
		else if(afktime > 600 && IsPlayerPremiumOld(playerid))
		{
			if(afktime > 1200)
			{
				SendClientMessage(playerid, 0xAA3333AA, "Zosta³eœ skickowany za zbyt d³ugie AFK (20 minut).");
				SetTimerEx("KickEx", 500, false, "i", playerid);
			}
			SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
		}
		else if(afktime > 600)
		{
			SendClientMessage(playerid, 0xAA3333AA, "Zosta³eœ skickowany za zbyt d³ugie AFK (10 minut).");
			SetTimerEx("KickEx", 500, false, "i", playerid);
		}
		else
		{
			SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
		}
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime+1, 0);
	}
	else
	{
		if(breaktime > afktime || breaktime > 180)
		{
			printf("%s byl afk przez %d", GetNickEx(playerid), afktime);
			afk_timer[playerid] = -1;
		}
		else
		{
			afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime, breaktime+1);
		}
	}
	return 1;
}

forward CheckChangeWeapon();
public CheckChangeWeapon()
{
	foreach (new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}

		new weaponID = GetPlayerWeapon(i);
		new playerState = GetPlayerState(i);
		if(MyWeapon[i]!=weaponID)
		{
			if(gPlayerLogged[i] == 1 || TutTime[i] >= 1)
			{
				if(playerState == 1)
				{
					if(GetPVarInt(i, "dutyadmin") == 0)
					{
						if(PlayerInfo[i][pInjury] > 0 || PlayerInfo[i][pBW] > 0)
						{
							return PlayerChangeWeaponOnInjury(i);
						}
						// else
						// {
						// 	if(PlayerPersonalization[i][PERS_GUNSCROLL] == 1) return SetPlayerArmedWeapon(i, MyWeapon[i]);
						// 	if(PokazDialogBronie(i) == 0)
						// 	{
						// 		MyWeapon[i] = 0;
						// 		SetPlayerArmedWeapon(i, 0);
						// 	}
						// }
					}
				}
			}
			else
			{
				ResetPlayerWeapons(i);
			}
		}
	}
	return 1;
}


forward MainTimer();
public MainTimer()
{
    JednaSekundaTimer();
	SlapperTimer();
    if(TICKS_Second)
    {
        Spectator();
        GangZone_Process();
    }
    if(TICKS_3Sec == 2)
    {
    	AC_AntyVehSpamLag();
        VehicleUpdate();
        CustomPickups();
        GangZone_ShowInfoToParticipants();
    }
    if(TICKS_MySQLRefresh == 14)
    {
        MySQL_Refresh();
        CheckGas();
    }
    if(TICKS_HalfMin == 29)
    {
        CarCheck();
    }
    if(TICKS_1Min == 59)
    {
		PlayersCheckerMinute();
        SyncUp();
		TimeUpdater();
    }
    if(TICKS_5Min == (60*5)-1)
    {
        Production();
    }
    if(TICKS_15Min == (60*15)-1)
    {
        ServerStuffSave();
        IdleKick();
    }
    if(TICKS_30Min == (60*30)-1)
    {
        SaveAccounts();
    }

    PatrolGPS();

    //ADD TIME
    if(TICKS_Second)
        TICKS_Second = false;
    else
        TICKS_Second = true;

    if(TICKS_3Sec == 3)
        TICKS_3Sec = 0;
    else
        TICKS_3Sec++;

    if(TICKS_MySQLRefresh == 15)
        TICKS_MySQLRefresh = 0;
    else
        TICKS_MySQLRefresh++;

    if(TICKS_HalfMin == 30)
        TICKS_HalfMin = 0;
    else
        TICKS_HalfMin++;

    if(TICKS_1Min == 60)
        TICKS_1Min = 0;
    else
        TICKS_1Min++;

    if(TICKS_5Min == 60*5)
        TICKS_5Min = 0;
    else
        TICKS_5Min++;

    if(TICKS_15Min == 60*15)
        TICKS_15Min = 0;
    else
        TICKS_15Min++;

    if(TICKS_30Min == 60*30)
        TICKS_30Min = 0;
    else
        TICKS_30Min++;
}

forward SaveMyAccountTimer(playerid);
public SaveMyAccountTimer(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 1)
		{
			MruMySQL_SaveAccount(playerid);
		}
	}
	return 1;
}

public ServerStuffSave()
{
    for(new i=0;i<MAX_FRAC;i++)
    {
        Sejf_Save(i);
        if(RANG_ApplyChanges[0][i]) EDIT_SaveRangs(0, i);
    }
    for(new i=1;i<MAX_ORG;i++)
    {
        SejfR_Save(i);
        if(RANG_ApplyChanges[1][i]) EDIT_SaveRangs(1, i);
    }
    new lTime = gettime();
    for(new i=0;i<MAX_OILS;i++)
    {
        if(Oil_IsValid(i))
        {
            if(OilData[i][oilTime]+3600 < lTime)
            {
                Oil_Destroy(i);
            }
        }
    }
}

public Spectator()
{
	new string[128], specid, Float:specHP, specNAME[MAX_PLAYER_NAME+1], weaponID, playerState;

    if(PDGPS != -1)
	{
        new Float:x, Float:y, Float:z;
		GetPlayerPos(PDGPS, x, y, z);
		foreach(new i : Player)
		{
			if(IsAPolicja(i) || IsAMedyk(i) || GetPlayerFraction(i) == FRAC_BOR || (PlayerInfo[i][pMember] == 9 && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1) )
			{
				if(zawodnik[i] == 0)
					SetPlayerCheckpoint(i, x, y, z, 4.0);
			}
		}
	}

	foreach(new i : Player)
	{
        if(!IsPlayerConnected(i)) continue;
		if(IsPlayerNPC(i))
		{
			continue;
		}

        if(ScenaCreated)
        {
            if(GetPVarInt(i, "scena-audio") == 0)
            {
                if(IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2]))
                {
                    PlayAudioStreamForPlayer(i, ScenaAudioStream, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2], 100.0, 1);
                    SetPVarInt(i, "scena-audio", 1);
                }
            }
            else if(GetPVarInt(i, "scena-audio") == 1)
            {
                if(!IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2]))
                {
                    StopAudioStreamForPlayer(i);
                    SetPVarInt(i, "scena-audio", 0);
                }
            }
        }
		
        //Vinyl audio check
        if(!GetPVarInt(i, "VINYL-stream"))
        {
            if(IsPlayerInRangeOfPoint(i, VinylAudioPos[3], VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2]) && (GetPlayerVirtualWorld(i) == 71 || GetPlayerVirtualWorld(i) == 72))
            {
                SetPVarInt(i, "VINYL-stream", 1);
                PlayAudioStreamForPlayer(i, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            }
        }
        else
        {
            if(!IsPlayerInRangeOfPoint(i, VinylAudioPos[3], VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2]))
            {
                SetPVarInt(i, "VINYL-stream", 0);
                StopAudioStreamForPlayer(i);
            }
        }
        //END vinyl
		//Ibiza audio check
        if(GetPVarInt(i, "IBIZA-stream") == 0)
        {
            if(IsPlayerInRangeOfPoint(i, IbizaAudioPos[3], IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && (GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                SetPVarInt(i, "IBIZA-stream", 1);
                PlayAudioStreamForPlayer(i, IBIZA_Stream,IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2], IbizaAudioPos[3], 1);
            }
        }
        else
        {
            if(!IsPlayerInRangeOfPoint(i, IbizaAudioPos[3], IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && !(GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                SetPVarInt(i, "IBIZA-stream", 0);
                StopAudioStreamForPlayer(i);
            }
        }
        //END ibiza
		if(GetPlayerPing(i) >= 2000 && PlayerInfo[i][pAdmin] == 0)
		{
			if(gPlayerLogged[i] == 1)
			{
				if(!IsPlayerPremiumOld(i))
				{
					SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka, POWÓD: Ping wiêkszy ni¿ 2 000");
					KickEx(i, "ping");
				}
			}
		}
        //BW
		if(PlayerInfo[i][pInjury] > 0)
        {
            RannyTimer(i);
        }
        if(PlayerInfo[i][pBW] > 0)
        {
			BWTimer(i);
        }
		if((specid = Spectate[i]) != INVALID_PLAYER_ID)
		{
			if(IsPlayerConnected(specid))
			{
				new specIP[32];
				GetPlayerName(specid, specNAME, sizeof(specNAME));
				GetPlayerHealth(specid, specHP);
				GetPlayerIp(specid, specIP, sizeof(specIP));
				if(PlayerInfo[i][pAdmin] >= 5 || IsAScripter(i)) format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~%s(ID:%d)~n~~y~HP:%.1f~n~~y~IP: %s",specNAME,specid,specHP,specIP);
				else format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~%s(ID:%d)~n~~y~HP:%.1f",specNAME,specid,specHP);
				GameTextForPlayer(i, string, 2500, 3);
				SpectateTime[i]++;
				if(GetPlayerInterior(i) != GetPlayerInterior(specid))
				{
                    SetPlayerInterior(i,GetPlayerInterior(specid));
				}
				if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(specid))
				{
					SetPlayerVirtualWorld(i,GetPlayerInterior(specid));
				}
                if(IsPlayerInAnyVehicle(specid) && GetPVarInt(i, "spec-type") != 2) PlayerSpectateVehicle(i, GetPlayerVehicleID(specid), SPECTATE_MODE_NORMAL), SetPVarInt(i, "spec-type", 2);
                else if(!IsPlayerInAnyVehicle(specid) && GetPVarInt(i, "spec-type") != 1) PlayerSpectatePlayer(i, specid, SPECTATE_MODE_NORMAL), SetPVarInt(i, "spec-type", 1);
			}
		}
		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			if(!LegalJetpack(i))
			{
				SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
			}
		}

        weaponID = GetPlayerWeapon(i);
        playerState = GetPlayerState(i);

		if(gPlayerLogged[i] == 1 || TutTime[i] >= 1)
		{
			if(playerState >= 1 && playerState <= 6)
			{
				new ac_val = WeaponAC(i);
				if(ac_val)
				{
					if(AntySpawnBroni[i] >= 1)
					{
						AntySpawnBroni[i] --;
					}
					else
					{
						format(string, sizeof(string), "Dosta³eœ kicka od systemu, powód: Spawn Broni [%d]", ac_val);
						SendClientMessage(i, COLOR_PANICRED, string);
						KickEx(i, "spawn broni");
					}
				}
				if(weaponID >= 2 && weaponID <= 45)
				{
                    switch(weaponID)
                    {
    					case 2://kij golfowy
    					{
    						if(PlayerInfo[i][pGun1] != 2)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 3://pa³ka policyjna
    					{
    						if(PlayerInfo[i][pGun1] != 3)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
                        case 4://nó¿
    					{
    						if(PlayerInfo[i][pGun1] != 4 && PlayerInfo[i][pMember] != 8 && PlayerInfo[i][pLider] != 8)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 5://bejzbol
    					{
    						if(PlayerInfo[i][pGun1] != 5)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 6://³opata
    					{
    						if(PlayerInfo[i][pGun1] != 6)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 7://bliard
    					{
    						if(PlayerInfo[i][pGun1] != 7)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 8://katana
    					{
    						if(PlayerInfo[i][pGun1] != 8)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 9://pi³a
    					{
    						if(PlayerInfo[i][pGun1] != 9)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 10://Purple Dildo
    					{
    						if(PlayerInfo[i][pGun10] != 10)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 11://Small White Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 11)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 12://Large White Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 12)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 13://Silver Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 13)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 14://kwiaty
    					{
    						if(PlayerInfo[i][pGun10] != 14)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 15://laska
    					{
    						if(PlayerInfo[i][pGun10] != 15)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 16://granat
    					{
    						if(PlayerInfo[i][pGun8] != 16)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 17://granat dymny
    					{
    						if(PlayerInfo[i][pGun8] != 17)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 18://molotov
    					{
    						if(PlayerInfo[i][pGun8] != 18)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					//Broñ 19, 20 i 21 nie istniej¹
    					case 22://9mm
    					{
    						if(PlayerInfo[i][pGun2] != 22)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 23://9mm t³umik
    					{
    						if(PlayerInfo[i][pGun2] != 23)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 24://desert eagle
    					{
    						if(PlayerInfo[i][pGun2] != 24)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 25://Shotgun
    					{
    						if(PlayerInfo[i][pGun3] != 25)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 26://obrzyny
    					{
    						if(PlayerInfo[i][pGun3] != 26)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 27://spas12
    					{
    						if(PlayerInfo[i][pGun3] != 27)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 28://uzi
    					{
    						if(PlayerInfo[i][pGun4] != 28)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 29://mp5
    					{
    						if(PlayerInfo[i][pGun4] != 29)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 30://ak-47
    					{
    						if(PlayerInfo[i][pGun5] != 30)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 31://m4
    					{
    						if(PlayerInfo[i][pGun5] != 31)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 32://tec9
    					{
    						if(PlayerInfo[i][pGun4] != 32)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 33://rifle
    					{
    						if(PlayerInfo[i][pGun6] != 33)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 34://snajperka
    					{
    						if(PlayerInfo[i][pGun6] != 34)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 35://rakietnica
    					{
    						if(PlayerInfo[i][pGun7] != 35)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 36://bazooka
    					{
    						if(PlayerInfo[i][pGun7] != 36)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 37://ogniomiotacz
    					{
    						if(PlayerInfo[i][pGun7] != 37)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 38://minigun
    					{
    						if(PlayerInfo[i][pGun7] != 38)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 39://c4
    					{
    						if(PlayerInfo[i][pGun8] != 39)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
                        }
    					case 41://sprej
    					{
    						if(PlayerInfo[i][pGun9] != 41)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 42://gaœnica
    					{
    						if(PlayerInfo[i][pGun9] != 42)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 43://aparat
    					{
    						if(PlayerInfo[i][pGun9] != 43)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 44://Nightvision Goggles
    					{
    						if(PlayerInfo[i][pGun11] != 44)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
    					case 45://Thermal Goggles
    					{
    						if(PlayerInfo[i][pGun11] != 45)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i, "spawn broni");
                                }
    						}
    					}
                    }
					if( playerState == 2 || playerState == 3)
					{
						if(weaponID == 24 || weaponID == 27 || weaponID == 31)
						{
							SetPlayerArmedWeapon(i, 0 );
						}
						else
						{
							SetPlayerArmedWeapon(i, weaponID );
						}
					}
				}
			}
		}
		else
		{
			ResetPlayerWeapons(i);
		}
	//}
	//tu bylo /me wyciaga bron
	}
    return 1;
}

public SyncUp()
{
	SyncTime();
	DollahScoreUpdate();
	return 1;
}

public SyncTime()
{
	new string[64];
	new tmphour,tmpminute,tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	if(tmphour != GLOB_LastHour)
	{
		format(string, sizeof(string), "Jest teraz godzina {0073FF}%d:00",tmphour);
		BroadCast(COLOR_WHITE,string);
        GLOB_LastHour=tmphour;
		if (realtime)
		{
            new ltime=0;
            ltime = CallRemoteFunction("GetRealTime", "d", tmphour);
			SetWorldTime(ltime == 0 ? tmphour : ltime);
			ServerTime = tmphour;
		}
		PayDay();
	}
	return 1;
}

public SaveAccounts()
{
    foreach(new i : Player)
	{
		if(PlayerInfo[i][pJob] > 0)
		{
			if(PlayerInfo[i][pContractTime] < 25)
			{
				PlayerInfo[i][pContractTime] ++;
			}
		}
	}
	return 1;
}

public Production()
{
	foreach(new i : Player)
	{
		if(PlayerDrunk[i] > 0) { PlayerDrunkTime[i] = 0; GameTextForPlayer(i, "~p~Jestes mniej pijany~n~~r~Pijaku", 3500, 1); }
		if(GetPlayerDrunkLevel(i) < 1999 && PlayerDrunk[i] > 0) { PlayerDrunk[i] = 0; PlayerDrunkTime[i] = 0; GameTextForPlayer(i, "~p~Wytrzezwiales~n~~r~Pijaku", 3500, 1); }
		if(PlayerInfo[i][pPayDay] < 6 && !IsPlayerPaused(i)) { PlayerInfo[i][pPayDay] += 1; } //+ 5 min to PayDay anti-abuse
		new wl = PoziomPoszukiwania[i];
		PlayerInfo[i][pWL] = wl;
	}
	return 1;
}

public CustomPickups()
{
	new mystate;
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
        mystate = GetPlayerState(i);

		if(ShowPlayerJobMessage(i, mystate))
		{
			return 1;
		}

		if(mystate == 1)
		{
			if (IsPlayerInRangeOfPoint(i, 2.0, 323.0342,1118.5804,1083.8828))
			{//Buyable Drugs for Drug Dealers
				GameTextForPlayer(i, "~w~Wpisz /get dragi aby wziac ~r~Dragi~y~ na sprzedaz~n~Dostosowane do twojego skillu", 5000, 3);
			}
			else if (IsPlayerInRangeOfPoint(i, 3, 1481.1531,-1770.0277,18.7958))
			{
				GameTextForPlayer(i, "~y~Witamy przed ~r~Ratuszem~n~~w~Wpisz /wejdz aby wejsc", 5000, 5);
			}
			else if (IsPlayerInRangeOfPoint(i, 2.0, 327.5762,-1546.8887,13.8364))
			{
				GameTextForPlayer(i, "~g~Wpisz ~w~/kamera-w ~g~aby ogladac kamere", 5000, 3);
			}
			else if (IsAtBankomat(i))
			{
				GameTextForPlayer(i, "~g~Uzyj ~w~/wplac ~g~lub ~w~/wyplac~n~ ~g~aby skorzystac z bankomatu", 5000, 3);
			}
			else if(IsPlayerInRangeOfPoint(i, 2.0,-50,-269,6.599999))
			{
				if(OrderReady[i] > 0)
				{
					switch (OrderReady[i])
					{
						case 1:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 4, 1);
							ZabierzKase(i, 25_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 2:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 4, 1);
							ZabierzKase(i, 40_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 3:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 31, 2050); GivePlayerWeapon(i, 4, 1);
							ZabierzKase(i, 60_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							PlayerInfo[i][pGun5] = 31; PlayerInfo[i][pAmmo5] = 2050;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 4:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 30, 2050); GivePlayerWeapon(i, 4, 1);
							ZabierzKase(i, 55_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							PlayerInfo[i][pGun5] = 30; PlayerInfo[i][pAmmo5] = 2050;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 5:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 31, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 100);
							ZabierzKase(i, 80_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							PlayerInfo[i][pGun5] = 31; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 6:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 25, 100); GivePlayerWeapon(i, 30, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 100);
							ZabierzKase(i, 75_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 25; PlayerInfo[i][pAmmo3] = 100;
							PlayerInfo[i][pGun5] = 30; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 7:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 27, 107); GivePlayerWeapon(i, 31, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 100);
							ZabierzKase(i, 85_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 27; PlayerInfo[i][pAmmo3] = 107;
							PlayerInfo[i][pGun5] = 31; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 8:
						{
							GivePlayerWeapon(i, 24, 107); GivePlayerWeapon(i, 29, 2030); GivePlayerWeapon(i, 27, 107); GivePlayerWeapon(i, 30, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 100);
							ZabierzKase(i, 80_00);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 107;
							PlayerInfo[i][pGun4] = 29; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 27; PlayerInfo[i][pAmmo3] = 107;
							PlayerInfo[i][pGun5] = 30; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 100;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 9:
						{
							GivePlayerWeapon(i, 24, 207); GivePlayerWeapon(i, 28, 2030); GivePlayerWeapon(i, 27, 207); GivePlayerWeapon(i, 31, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 200);
							ZabierzKase(i, 100_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 207;
							PlayerInfo[i][pGun4] = 28; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 27; PlayerInfo[i][pAmmo3] = 207;
							PlayerInfo[i][pGun5] = 31; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 200;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
						case 10:
						{
							GivePlayerWeapon(i, 24, 207); GivePlayerWeapon(i, 28, 2030); GivePlayerWeapon(i, 27, 207); GivePlayerWeapon(i, 30, 2050); GivePlayerWeapon(i, 4, 1); GivePlayerWeapon(i, 34, 200);
							ZabierzKase(i, 95_000);
							PlayerInfo[i][pGun1] = 4; PlayerInfo[i][pAmmo1] = 1;
							PlayerInfo[i][pGun2] = 24; PlayerInfo[i][pAmmo2] = 207;
							PlayerInfo[i][pGun4] = 28; PlayerInfo[i][pAmmo4] = 2030;
							PlayerInfo[i][pGun3] = 27; PlayerInfo[i][pAmmo3] = 207;
							PlayerInfo[i][pGun5] = 30; PlayerInfo[i][pAmmo5] = 2050;
							PlayerInfo[i][pGun6] = 34; PlayerInfo[i][pAmmo6] = 200;
							SetPlayerArmour(i, 90);
							SetPlayerHealth(i, 100);
							SendClientMessage(i, COLOR_LIGHTBLUE, "* Zabra³eœ zamówiony towar.");
						}
					}

					OrderReady[i] = 0;

					new redisKey[40];
					format(redisKey, sizeof(redisKey), "player:%d:contracts-done", PlayerInfo[i][pUID]);
					RedisIncrBy(redisKey, -1);
					RedisExpire(redisKey);
				}
			}
		}
		if(mystate == PLAYER_STATE_DRIVER)
		{
			new cooldown = GetPVarInt(i, "pay-n-spray-dialog");
			if(cooldown <= 0)
			{
				new Float:health;
				GetVehicleHealth(GetPlayerVehicleID(i), health);
				if(health <= 1000.0 && IsPlayerAtPayNSpray(i))
				{
					new price = 7500;
					if(IsBusinessTypeOwnedByPlayerOrg(i, FRONT_BIZ_TYPE_SPRAY))
					{
						price /= 2;
					}
					ShowPlayerDialogEx(i, 9145, DIALOG_STYLE_MSGBOX, "Naprawa pojazdu", sprintf("Czy chcesz naprawiæ swój pojazd za %d$?", price), "Napraw", "WyjdŸ");
					SetPVarInt(i, "pay-n-spray-dialog", 15);
					return 1;
				}
			}
			else
			{
				SetPVarInt(i, "pay-n-spray-dialog", cooldown - 1);
			}
		}

        if(IsPlayerInAnyVehicle(i)) continue;
        for(new j=0;j<MAX_BOOMBOX;j++)
        {
            if(BoomBoxData[j][BBD_x] == 0.0 || !BoomBoxData[j][BBD_Standby]) continue;
            if(IsPlayerInRangeOfPoint(i, MAX_BBD_DISTANCE, BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z]))
            {
                if(GetPVarInt(i, "bbdid") != BoomBoxData[j][BBD_ID])
                {
                    SetPVarInt(i, "bbdid", BoomBoxData[j][BBD_ID]);
                    PlayAudioStreamForPlayer(i, BoomBoxData[j][BBD_URL], BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z], MAX_BBD_DISTANCE, 1);
                }
                break;
            }
            else if(GetPVarInt(i, "bbdid") == BoomBoxData[j][BBD_ID])
            {
                SetPVarInt(i, "bbdid", 0);
                StopAudioStreamForPlayer(i);
            }
        }
	}
	return 1;
}

public IdleKick()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
		if(PlayerInfo[i][pAdmin] < 1 || PlayerInfo[i][pNewAP] < 1)
		{
			GetPlayerPos(i, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]);
			if(PlayerPos[i][0] == PlayerPos[i][3] && PlayerPos[i][1] == PlayerPos[i][4] && PlayerPos[i][2] == PlayerPos[i][5] && gPlayerLogged[i] == 1)
			{
				KickEx(i, "nieaktywnoœæ");
			}
			PlayerPos[i][3] = PlayerPos[i][0];
			PlayerPos[i][4] = PlayerPos[i][1];
			PlayerPos[i][5] = PlayerPos[i][2];
		}
	}
	return 1;
}

forward RPGTimer();
public RPGTimer()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
	    if(!IsPlayerConnected(i)) continue;
		new rpggun;
        new rpgammo;
        new string[128];
        GetPlayerWeaponData(i, 7, rpggun, rpgammo);
        if(rpggun == 35 && rpgammo == 0 && PlayerInfo[i][pAdmin] < 1)//rpg czit
        {
			MruDialog(i, "ACv2: Kod #2005", "Zosta³eœ wyrzucony za weapon hack RPG.");
			format(string, sizeof string, "ACv2 [#2005]: %s zosta³ wyrzucony za weapon hack RPG.", GetNick(i));
			SendCommandLogMessage(string);
			Log(punishmentLog, INFO, "ACv2 [#2005]: %s zosta³ wyrzucony za weapon hack RPG.", GetPlayerLogName(i));
			KickEx(i, "rpg");
		}
	}
	return 1;
}
public SlapperTimer()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
		if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
		{
			new Float:pAC_Pos[3],Float:VS ;
			GetPlayerVelocity(i, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
			VS = VectorSize(pAC_Pos[0], pAC_Pos[1], pAC_Pos[2])*136.6666;
			if(floatround(VS,floatround_round) >= 350)
			{
				if(PlayerSlapperWarning[i] >= 5)
				{
					MruMySQL_Banuj(i, "Anti-Slapper");
					Log(punishmentLog, INFO, "%s zosta³ zbanowany za podejrzenie slappera (%d speeda on-foot, %d ostrze¿eñ)", GetPlayerLogName(i), floatround(VS,floatround_round), PlayerSlapperWarning[i]);
					KickEx(i, "anti-slapper");
				}
				else
				{
					new ip[16];
					GetPlayerIp(i, ip, sizeof(ip));
					SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] prawdopodobnie czituje. | Slapper [%d/5]", 
					GetNickEx(i), i, ip, PlayerSlapperWarning[i]), 
					0xFF00FFFF);
					PlayerSlapperWarning[i]++;
				}
			}
		}
	}
}
public JednaSekundaTimer()
{
    //25.06.2014
    new State, Float:pancerzyy,string[128],vehicleid,VehicleModel,
        Float:x, Float:y, Float:z, Float:health, Float:Dis,
        pZone[MAX_ZONE_NAME], ammo, weaponID, weaponState, Float:vel[3];

    new plname[MAX_PLAYER_NAME],level, Float:angle,Lost = 0, trigger = 0,winner[MAX_PLAYER_NAME], loser[MAX_PLAYER_NAME],titel[MAX_PLAYER_NAME];

	foreach(new i : NPC)
	{
		if(BotSmugglingPackages > 0 && !IsPlayerInAnyVehicle(i) && strcmp(GetNick(i), "Bot_Przemytnik", true) == 0)
		{
			SetPlayerSkin(i, 1);
			PutPlayerInVehicle(i, SmugglingBoat, 0);
		}
	}

    foreach(new i : Player)
	{
        if(!IsPlayerConnected(i)) continue;
        State = GetPlayerState(i);
        GetPlayerPos(i, x, y, z);
		GetPlayerArmour(i, pancerzyy);
        vehicleid = GetPlayerVehicleID(i);

		JednaSekundaTimer_Kajdanki(i);
		ViceCity_JednaSekundaTimer();
		
		//dzwonek telefonu
		if(RingTone[i] > 0 && Mobile[i] >= 0)
		{
			if(RingTone[i] >= 60)
			{
				StopACall(i);
			}
			else
			{
				if(RingTone[i]%3 == 0)
				{
					PlayerPlaySound(i, 23000, 0.0, 0.0, 0.0);
				}
				if(RingTone[i]%12 == 0 || RingTone[i] == 1)
				{
					new caller = Mobile[i];
					new slotKontaktu = PobierzSlotKontaktuPoNumerze(i, PlayerInfo[caller][pPnumber]);
					if(slotKontaktu >= 0)
					{
						format(string, sizeof(string), "Twój telefon dzwoni, (aby odebraæ wpisz: /od) dzwoni¹cy: %s (%d)", Kontakty[i][slotKontaktu][eNazwa], PlayerInfo[caller][pPnumber]);
					}
					else
					{
						format(string, sizeof(string), "Twój telefon dzwoni, (aby odebraæ wpisz: /od) dzwoni¹cy: %d", PlayerInfo[caller][pPnumber]);
					}
					SendClientMessage(i, COLOR_YELLOW, string);
					format(string, sizeof(string), "* Telefon %s zaczyna dzwoniæ.", GetNick(i));
					ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					PlayerPlaySound(i, 23000, 0.0, 0.0, 0.0);
				}
				RingTone[i]++;
			}
		}
		if(CellTime[i] > 0)
		{
			CellTime[i]++;
		}
		
		if(State == PLAYER_STATE_DRIVER || State == PLAYER_STATE_PASSENGER)
		{
			if(!ToggleSpeedo[i])
			{
				VehicleModel = GetVehicleModel(vehicleid);
				if(VehicleModel != 0)
				{
					GetVehicleHealth(vehicleid, health);

					if(VehicleModel==509||VehicleModel==481||VehicleModel==510)
					{
						SetVehicleHealth(vehicleid, 1000.0);
						Gas[vehicleid] = 100;
					}
					if(VehicleModel==520||VehicleModel==476||VehicleModel==593||VehicleModel==553||VehicleModel==513||VehicleModel==512||VehicleModel==577||VehicleModel==592||VehicleModel==511||VehicleModel==539||VehicleModel==464||VehicleModel==519)
					{
						Gas[vehicleid] = 100;
					}

					GetVehicleVelocity(vehicleid, vel[0], vel[1], vel[2]);
					Dis = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;

					GetPlayer2DZone(i, pZone, MAX_ZONE_NAME);
					format(string, 128,"Speed: %dkm/h~n~Paliwo: %d~n~Stan: %d\%~n~GPS: %s~n~%s" ,floatround(Dis), floatround(Gas[vehicleid]),floatround(health/10), pZone, VehicleNames[GetVehicleModel(vehicleid)-400]);
					PlayerTextDrawSetString(i, Licznik[i], string);
				}

				OldCoordsX[i] = x; OldCoordsY[i] = y;
			}
		}
		
		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			if(!ToggleSpeedo[i])
			{
				GetPlayerVelocity(i, vel[0], vel[1], vel[2]);
				Dis = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;

				GetPlayer2DZone(i, pZone, MAX_ZONE_NAME);
				format(string, 128, "Speed: %dkm/h~n~Paliwo: %d~n~Stan: OK\%~n~GPS: %s~n~Jetpack" , 
					floatround(Dis), floatround(JetpackGas[i]), pZone);
				PlayerTextDrawSetString(i, Licznik[i], string);
			}

			if(GetPVarInt(i, "jetpack-licznik") == 0)
			{
				PlayerTextDrawShow(i, Licznik[i]);
			}

			// decrease jet fuel
			SetPVarInt(i, "jetpack-licznik", 1);
			if(JetpackGas[i] <= 0)
			{
				if(JetpackEnabled[i]) 
				{ // check so if player is afk there is no spam of messages
					ChatDo(i, "Plecak odrzutowy przesta³ dzia³aæ z powodu braku paliwa.");
				}
				DisableJetpack(i);
			} else {
				JetpackGas[i] --;
			}
			OldCoordsX[i] = x; OldCoordsY[i] = y;
		}
		else if(GetPVarInt(i, "jetpack-licznik") >= 1)
		{
			DeletePVar(i, "jetpack-licznik");
			PlayerTextDrawHide(i, Licznik[i]);
			SetSmugglingItem(i, SMUGGLING_ITEM_JETPACK_GAS, JetpackGas[i]);
		}
        //PAYDAY
        level = PlayerInfo[i][pLevel];
		if(level >= 0 && level <= 2) { PlayerInfo[i][pPayCheck] += 1; }
		else if(level >= 3 && level <= 4) { PlayerInfo[i][pPayCheck] += 2; }
		else if(level >= 5 && level <= 6) { PlayerInfo[i][pPayCheck] += 3; }
		else if(level >= 7 && level <= 8) { PlayerInfo[i][pPayCheck] += 4; }
		else if(level >= 9 && level <= 10) { PlayerInfo[i][pPayCheck] += 5; }
		else if(level >= 11 && level <= 12) { PlayerInfo[i][pPayCheck] += 6; }
		else if(level >= 13 && level <= 14) { PlayerInfo[i][pPayCheck] += 7; }
		else if(level >= 15 && level <= 16) { PlayerInfo[i][pPayCheck] += 8; }
		else if(level >= 17 && level <= 18) { PlayerInfo[i][pPayCheck] += 9; }
		else if(level >= 19 && level <= 20) { PlayerInfo[i][pPayCheck] += 10; }
		else if(level >= 21) { PlayerInfo[i][pPayCheck] += 11; }
        //JAIL
		if(PlayerInfo[i][pJailed] > 0 && PlayerInfo[i][pJailed] != 10)
		{
			if(PlayerInfo[i][pJailTime] > 0 && WantLawyer[i] == 0 && gPlayerSpawned[i] == 1)
			{
				PlayerInfo[i][pJailTime]--;
			}
			if(PlayerInfo[i][pJailed] == 2)
			{
				if(!IsPlayerInRangeOfPoint(i, 90.0, SpawnStanowe[0][0], SpawnStanowe[0][1], SpawnStanowe[0][2]) && !IsPlayerInRangeOfPoint(i, 90.0, SpawnStanoweVC[0][0], SpawnStanoweVC[0][1], SpawnStanoweVC[0][2]))
				{
					SetPlayerStateArrestPos(i);
					sendErrorMessage(i, "Nie znajdujesz siê w Wiêzieniu Stanowym! Pozycja przywrócona do poprawnej!");
				}
			}
			if(PlayerInfo[i][pJailed] == 3)
			{
				if(!IsPlayerInRangeOfPoint(i, AJ_MAXRANGE, AJ_POSX, AJ_POSY, AJ_POSZ))
				{
					sendErrorMessage(i, "Nie znajdujesz siê w AJ! Pozycja przywrócona do poprawnej!");
					SetPlayerSpawn(i); 
				}
			}
			if(PlayerInfo[i][pJailTime] <= 0 && WantLawyer[i] == 0)
			{
				PlayerInfo[i][pJailTime] = 0;
				if(PlayerInfo[i][pJailed] == 1)
				{
					SetPlayerArrestFreePos(i);
					GameTextForPlayer(i, "~w~Wolnosc!", 5000, 1);
				}
				else if(PlayerInfo[i][pJailed] == 2)
				{
					UnJailDeMorgan(i);
					GameTextForPlayer(i, "~w~Wolnosc!", 5000, 1);
				}
				else if(PlayerInfo[i][pJailed] == 3)
				{
					SetPlayerInterior(i, 0);
					PlayerInfo[i][pJailed] = 0;
					PlayerInfo[i][pJailTime] = 0;
					SetPlayerVirtualWorld(i, 0);
					PlayerInfo[i][pMuted] = 0;
					SetPlayerPos(i,1481.1666259766,-1790.2204589844,156.7875213623);
					format(string, sizeof(string), "~w~Wolnosc~n~~r~GRAJ RP!!!");
					GameTextForPlayer(i, string, 5000, 1);
					SetPVarInt(i, "skip_bw", 1);
					SetPlayerHealth(i, 0.0);
					PlayerPlaySound(i, 39000, 0.0, 0.0, 0.0);
					StopAudioStreamForPlayer(i);
					if((GetPVarInt(i, "DostalDM2") == 1) || strfind((PlayerInfo[i][pAJreason]), "DM2", true) > 0
					&& strfind((PlayerInfo[i][pAJreason]), "Death Match 2", true) > 0)
					{
						format(string, sizeof(string), "[Marcepan Marks] Zabra³em graczowi %s broñ [Odsiedzia³ karê za DM2]", GetNick(i));
						SendAdminMessage(COLOR_PANICRED, string);
						format(string, sizeof(string), "%s zabra³em twoj¹ broñ. Z pozdrowieniami - Marcepan Marks", GetNick(i));
						sendTipMessage(i, string);
						SetTimerEx("AntySB", 5000, 0, "d", i);
						AntySpawnBroni[i] = 5;
						ResetPlayerWeapons(i);
						UsunBron(i);
					}
				}
				PlayerInfo[i][pJailed] = 0;
				SendClientMessage(i, COLOR_GRAD1,"   Wolnoœæ! Odsiedzia³eœ karê, mamy nadzieje ¿e to ciê czegoœ nauczy³o.");
				format(string, sizeof(string), "~g~Wolnosc!~n~~w~Staraj sie byc lepszym obywatelem");
				GameTextForPlayer(i, string, 5000, 1);
				ClearCrime(i);
				SetPlayerToTeamColor(i);
				StopAudioStreamForPlayer(i);
			}
		}
        //AUDIO
		if(GetPVarInt(i, "sanaudio") == 0 && SANradio != 0)
		{
			if(IsPlayerInRangeOfPoint(i,SANzasieg,SANx, SANy, SANz))
			{
				SetPVarInt(i, "sanaudio", 1);
				PlayAudioStreamForPlayer(i, SANrepertuar, SANx, SANy, SANz, SANzasieg, 1);
			}
		}
		else if(GetPVarInt(i, "kluboweaudio") == 0 && KLUBOWEradio != 0 && !GetPVarInt(i, "HaveAMp3Stream"))
		{
			if(IsPlayerInRangeOfPoint(i,KLUBOWEzasieg,KLUBOWEx, KLUBOWEy, KLUBOWEz))
			{
				SetPVarInt(i, "kluboweaudio", 1);
				PlayAudioStreamForPlayer(i, KLUBOWErepertuar, KLUBOWEx, KLUBOWEy, KLUBOWEz, KLUBOWEzasieg, 1);
			}
		}
		else if(GetPVarInt(i, "sanaudio") == 1 && SANradio != 0)
		{
			if(!IsPlayerInRangeOfPoint(i,SANzasieg,SANx, SANy, SANz))
			{
				SetPVarInt(i, "sanaudio", 0);
				StopAudioStreamForPlayer(i);
			}
		}
		if(State == PLAYER_STATE_DRIVER)
		{
			if(IsPlayerInRangeOfPoint(i, 7.0, 2064.0703,-1831.3167,13.3853) || IsPlayerInRangeOfPoint(i, 5.0, 1351.0012,-1818.5981,13.3031) || IsPlayerInRangeOfPoint(i, 7.0, 1024.8514,-1022.2302,31.9395) || IsPlayerInRangeOfPoint(i, 7.0, 486.9398,-1742.4130,10.9594) || IsPlayerInRangeOfPoint(i, 7.0, -1904.2325,285.3743,40.8843)  || IsPlayerInRangeOfPoint(i, 7.0, 720.0876,-458.3574,16.3359) || IsPlayerInRangeOfPoint(i, 7.0, -2425.9668,1023.2122,50.1248) || IsPlayerInRangeOfPoint(i, 7.0, 1972.6704,2163.9829,10.7942) || IsPlayerInRangeOfPoint(i, 7.0, -100.3769,1115.7079,19.4688) || IsPlayerInRangeOfPoint(i, 7.0, -1420.5669,2584.1997,55.5703))
			{
				if(naprawiony[i] == 0)
				{
					GetVehicleHealth(vehicleid, health);
					if(health <= 999)
					{
						new cena_naprawy = 7500;

						if(IsAPorzadkowy(i) && IsPlayerInTheirFractionVehicle(i))
						{// dla pojazdów frakcji porz¹dkowych 50% nale¿noœci idzie z sejfu
							new player_frac = GetPlayerFraction(i);
							new price_half = floatround(0.5 * float(cena_naprawy));
							if(Sejf_Frakcji[player_frac] >= price_half && kaska[i] >= price_half)
							{
								Sejf_Add(player_frac, -price_half);
								cena_naprawy = price_half;
								SendClientMessage(i, COLOR_LIGHTBLUE,"Po³owa kosztów naprawy zosta³a op³acona ze œrodków frakcji.");
							}
						}
						if(IsBusinessTypeOwnedByPlayerOrg(i, FRONT_BIZ_TYPE_SPRAY))
						{
							cena_naprawy /= 2;
						}

				        sendTipMessageFormat(i, "Zap³aci³eœ $%d za wizytê w warsztacie", cena_naprawy);
				        ZabierzKase(i, cena_naprawy);
						RepairVehicle(vehicleid);
						naprawiony[i] = 1;
						SetTimerEx("Naprawianie",10000,0,"d",i);

						// give 50% of the money to the owner of the spray
						new bizId = IsPlayerAtFrontBusinnesZone(i);
						if(bizId != -1)
						{
							GenerateFrontBusinessIncome(bizId, cena_naprawy/2);
						}
					}
				}
			}
		}

        if(SafeTime[i] > 0)//3minuty na zalogowanie
		{
			SafeTime[i]--;
			if(SafeTime[i] == 1)
			{
				if(gPlayerAccount[i] == 1 && gPlayerLogged[i] == 0)
				{
					if(!IsPlayerNPC(i))
					{
						KickEx(i, "zbyt d³ugie logowanie");
					}
				}
			}
		}

		Driver_JednaSekundaTimer(i);

		if(PoziomPoszukiwania[i] >= 1)
		{
		    PlayerInfo[i][pWL] = PoziomPoszukiwania[i];
		}
		if(PlayerInfo[i][pJailed] == 1 || PlayerInfo[i][pJailed] == 2)
		{
		    if(PoziomPoszukiwania[i] >= 1)
		    {
		    	PoziomPoszukiwania[i] = 0;
		    	PlayerInfo[i][pWL] = 0;
		    }
		}

		if(GetPVarInt(i, "dont-update-pos") != 1)
		{
			SavePlayerPos[i][LastX] = x;
			SavePlayerPos[i][LastY] = y;
			SavePlayerPos[i][LastZ] = z;
		}
// serce zapisu broni
		if(State >= 1 && State <= 6)
		{
			if(GetPVarInt(i, "ammohackdetect") == 1) KickEx(i, "ammo hack");
			if(MaZapisanaBron(i))
			{
                weaponID = GetPlayerWeapon(i);
                ammo = GetPlayerAmmo(i);
                weaponState = GetPlayerWeaponState(i);
				if(weaponID == PlayerInfo[i][pGun2] && PlayerInfo[i][pGun2] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo2] >= 0)
					{
						if(PlayerInfo[i][pAmmo2] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo2] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun3] && PlayerInfo[i][pGun3] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo3] >= 0)
					{

						if(PlayerInfo[i][pAmmo3] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo3] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun4] && PlayerInfo[i][pGun4] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo4] >= 0)
					{

						if(PlayerInfo[i][pAmmo4] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo4] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun5] && PlayerInfo[i][pGun5] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo5] >= 0)
					{
						if(PlayerInfo[i][pAmmo5] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo5] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun6] && PlayerInfo[i][pGun6] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo6] >= 0)
					{
						if(PlayerInfo[i][pAmmo6] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo6] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun7] && PlayerInfo[i][pGun7] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo7] >= 0)
					{
						if(PlayerInfo[i][pAmmo7] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo7] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun8] && PlayerInfo[i][pGun8] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo8] >= 0)
					{
						if(PlayerInfo[i][pAmmo8] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo8] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun9] && PlayerInfo[i][pGun9] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo9] >= 0)
					{
						if(PlayerInfo[i][pAmmo9] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo9] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun11] && PlayerInfo[i][pGun11] == 46)
				{
					if(weaponState == 0 && PlayerInfo[i][pAmmo11] <= 0)
					{
						if(weaponState == 0 && weaponID == PlayerInfo[i][pGun11])
						{
							PlayerInfo[i][pGun11] = 0;
							PlayerInfo[i][pAmmo11] = 0;
						}
					}
				}
			}
		}
		

        if(UsedFind[i] >= 1)
		{
			UsedFind[i] += 1;
			if(UsedFind[i] >= 120)
			{
				UsedFind[i] = 0;
			}
		}
        if(GetPVarInt(i, "wysekszony") > 0) {
            SetPVarInt(i, "wysekszony", GetPVarInt(i, "wysekszony")-1);
        }
        if(GetPVarInt(i, "wytazerowany") > 0) {
            SetPVarInt(i, "wytazerowany", GetPVarInt(i, "wytazerowany")-1);
        }
        if(GetPVarInt(i, "wydragowany") > 0) {
            SetPVarInt(i, "wydragowany", GetPVarInt(i, "wydragowany")-1);
        }
        if(GetPVarInt(i, "wyreportowany") > 0) {
            SetPVarInt(i, "wyreportowany", GetPVarInt(i, "wyreportowany")-1);
        }
        if(GetPVarInt(i, "finding") == 1) {
            new findtime = GetPVarInt(i, "findtime");
            if(findtime == 0) {
                SetPVarInt(i, "finding", 0);
                SetPVarInt(i, "findtime", 0);
                SetPVarInt(i, "findingId", 999);
                SetPVarInt(i, "findingRange", 0);
                GangZoneDestroy(pFindZone[i]);
                GameTextForPlayer(i, "~r~Strefa Ulegla Destrukcji", 2500, 1);
            } else { 
                new kogo = GetPVarInt(i, "findingId");
                new range = GetPVarInt(i, "findingRange");
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(kogo, X,Y,Z);
                if(pFindZone[i]) GangZoneDestroy(pFindZone[i]);
                pFindZone[i] = GangZoneCreate(X-range, Y-range, X+range, Y+range);
                GangZoneShowForPlayer(i, pFindZone[i], 0xff00eeBB);
                SetPVarInt(i, "findtime", findtime-1);
            }
        }
		if(MedicTime[i] > 0)
		{
			if(MedicTime[i] == 3)
			{
				SetPlayerInterior(i, 5);
				GetPlayerPos(i, x,y,z);
				SetPlayerCameraPos(i, x + 3, y, z);
				SetPlayerCameraLookAt(i,x,y,z);
			}
			MedicTime[i] ++;
			if(MedicTime[i] >= NeedMedicTime[i])
			{
				format(string, sizeof(string), "DOKTOR: %d zosta³eœ uleczony.", i);
				SendClientMessage(i, TEAM_CYAN_COLOR, string);
				TogglePlayerControllable(i, 1);
				MedicBill[i] = 0;
				MedicTime[i] = 0;
				NeedMedicTime[i] = 0;
				PlayerInfo[i][pDeaths] += 1;
				PlayerFixRadio(i);
				SetPlayerSpawn(i);
			}
		}
		if(WantLawyer[i] >= 1)
		{
			CallLawyer[i] = 111;
			if(WantLawyer[i] == 1)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			WantLawyer[i] ++;
			if(WantLawyer[i] == 8)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			if(WantLawyer[i] == 15)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			if(WantLawyer[i] >= 20)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Nie mo¿esz ju¿ wezwaæ prawnika, Czas odsiadki rozpoczêty.");
				WantLawyer[i] = 0;
				CallLawyer[i] = 0;
			}
		}
		if(TutTime[i] >= 1 && !IsPlayerNPC(i))
		{
			GetPlayerVelocity(i, x, y, z);
			if( x > 0.1 || y > 0.1)
			{
				SendClientMessage(i, COLOR_LIGHTBLUE, "AC: Kick za ucieczkê z samouczka!");
				KickEx(i, "ucieczka z samouczka");
			}
			TutTime[i] += 1;
			if(TutTime[i] == 3)
			{
				SetPlayerPos(i, 849.62371826172, -989.92199707031, -5.0);
				SetPlayerCameraPos(i, 849.62371826172, -989.92199707031, 53.211112976074);// kamera
				SetPlayerCameraLookAt(i, 907.40313720703, -913.14117431641, 77.788856506348);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: Pocz¹tek ____|");
				SendClientMessage(i, COLOR_WHITE, "Ooo... nowy na serwerze.... wiêc musisz o czymœ wiedzieæ.");
				SendClientMessage(i, COLOR_WHITE, "Jest to serwer Role Play(RP). Role Playing to odzwierciedlanie realnego ¿ycia w grze.");
				SendClientMessage(i, COLOR_WHITE, "Skoro ju¿ wiesz, co to jest Role Play musisz poznaæ zasady panuj¹ce na naszym serwerze.");
				SendClientMessage(i, COLOR_WHITE, "W tym celu przejdziesz teraz drobny samouczek tekstowy, który przygotuje Ciê do rozgrywki!"); 
			}
			else if(TutTime[i] == 14)
			{
				SetPlayerPos(i, 326.09194946289, -1521.3157958984, 20.0);
				SetPlayerCameraPos(i, 398.16021728516, -1511.9237060547, 78.641815185547);// kamera
				SetPlayerCameraLookAt(i, 326.09194946289, -1521.3157958984, 42.154850006104);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - DM i Nick ____|");
			}
			else if(TutTime[i] == 16)
			{
				SendClientMessage(i, COLOR_WHITE, "Na serwerze obowi¹zuje absolutny zakaz jakiegokolwiek DeathMatch`u(DM).");
				SendClientMessage(i, COLOR_WHITE, "Nie chcemy na serwerze osób które bezmyœlnie zabijaj¹ wszystko co siê rusza.");
				SendClientMessage(i, COLOR_WHITE, "Chodzi o to, ¿e w prawdziwym ¿yciu, nie zabija³byœ wszystkich dooko³a.");
				SendClientMessage(i, COLOR_WHITE, "Wiêc jeœli chcesz kogoœ zabiæ, musisz mieæ naprawdê wa¿ny powód.");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze trzeba mieæ nick typu Imie_Nazwisko (np. Jan_Kowalski)");
				SendClientMessage(i, COLOR_WHITE, "Jeœli masz inny nick ni¿ Imie_Nazwisko to poproœ admina o zmianê go.");
			}
			else if(TutTime[i] == 30)
			{
				SetPlayerPos(i, 1016.9872436523, -1372.0234375, -5.0);
				SetPlayerCameraPos(i, 1053.3154296875, -1326.3295898438, 28.300031661987);// kamera
				SetPlayerCameraLookAt(i, 1016.9872436523, -1372.0234375, 15.836219787598);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - Bug Using i cheatowanie ____|");
			}
			else if(TutTime[i] == 32)
			{
				SendClientMessage(i, COLOR_WHITE, "Je¿eli widzisz, ¿e ktoœ cheatuje, powiadom administratorów przez komendê /report.");
				SendClientMessage(i, COLOR_WHITE, "Nie wolno u¿ywaæ Bugów (np. znasz jakiegoœ buga który daje ci kase).");
				SendClientMessage(i, COLOR_WHITE, "Jeœli masz czity, wy³¹cz je i idŸ na jakiœ inny serwer. Tu nie mo¿na czitowaæ.");
				SendClientMessage(i, COLOR_WHITE, "Osoba korzystaj¹ca z Cheatów i Bugów mo¿e zostaæ zbanowana lub ostrze¿ona.");
			}
			else if(TutTime[i] == 52)
			{
				SetPlayerPos(i, 1352.2797851563, -1757.189453125, -5.0);
				SetPlayerCameraPos(i, 1352.4576416016, -1725.1925048828, 23.291763305664);// kamera
				SetPlayerCameraLookAt(i, 1352.2797851563, -1757.189453125, 13.5078125);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady Serwera - OOC i IC ____|");
			}
			else if(TutTime[i] == 54)
			{
				SendClientMessage(i, COLOR_WHITE, "A wiêc musisz wiedzieæ co to jest OOC i IC, oraz poprawnie to interpretowaæ.");
				SendClientMessage(i, COLOR_WHITE, "Ta zasada jest bardzo wa¿na, wiêc czytaj uwa¿nie, oraz zapamiêtaj to.");
				SendClientMessage(i, COLOR_WHITE, "OOC to wszystko co NIE JEST zwi¹zane z twoj¹ postaci¹.(np. twoja szko³a).");
				SendClientMessage(i, COLOR_WHITE, "OOC to wszytskie rzeczy zwi¹zane z tob¹ w realu, oraz z komendami, adminami itp.");
				SendClientMessage(i, COLOR_WHITE, "Rzeczy OOC piszemy w chatach: /b /o /i oraz /ro i /depo");
				SendClientMessage(i, COLOR_WHITE, "Poprawnie napisany tekst OOC: /b elo, jesteœ adminem? /b jak tam w szkole? itp.");
			}
			else if(TutTime[i] == 74)
			{
				SetPlayerPos(i, 370.02825927734, -2083.5886230469, -10.0);
				SetPlayerCameraPos(i, 340.61755371094, -2091.701171875, 22.800081253052);// kamera
				SetPlayerCameraLookAt(i, 370.02825927734, -2083.5886230469, 8.1386299133301);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - IC ____|");
			}
			else if(TutTime[i] == 76)
			{
				SendClientMessage(i, COLOR_WHITE, "Musisz te¿ wiedzieæ co to jest IC, oraz poprawnie to interpretowaæ.");
				SendClientMessage(i, COLOR_WHITE, "IC to tak jakby przeciwnoœæ OOC. To wszystko co JEST zwi¹zane z twoj¹ postaci¹.");
				SendClientMessage(i, COLOR_WHITE, "Rzeczy IC piszemy w chatach: /l /s /k /t /ad oraz w zwyk³ym chacie itp.");
				SendClientMessage(i, COLOR_WHITE, "Poprawnie napisany teskt IC: /l witam pana /k staæ policja, rêce do góry! itp.");
			}
			else if(TutTime[i] == 96)
			{
				SetPlayerPos(i, 1172.8602294922, -1331.978515625, -5.0);
				SetPlayerCameraPos(i, 1228.7977294922, -1345.1479492188, 21.532119750977);// kamera
				SetPlayerCameraLookAt(i, 1172.8602294922, -1331.978515625, 14.317019462585);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - MG i PG ____|");
			}
			else if(TutTime[i] == 98)
			{
				SendClientMessage(i, COLOR_WHITE, "MG (MetaGamming) - to wykorzystywanie informacji OOC do IC.");
				SendClientMessage(i, COLOR_WHITE, "Czyli widzisz nick nad g³ow¹ gracza i mówisz do niego na chacie IC po imieniu");
				SendClientMessage(i, COLOR_WHITE, "Lub wtedy gdy ktoœ mówi na /b jestem liderem LCN, a ty siê go pytasz o pracê w LCN");
				SendClientMessage(i, COLOR_WHITE, "PG - to zmuszanie kogoœ do akcji RP, mimo i¿ ta osoba tego nie chce.");
				SendClientMessage(i, COLOR_WHITE, "Czyli np. ktoœ podchodzisz do kogoœ i dajesz /me bije Johna tak ¿e umiera, to jest PG.");
			}
			else if(TutTime[i] == 112)
			{
				SetPlayerPos(i, 412.80743408203, -1312.4066162109, -5.0);
				SetPlayerCameraPos(i, 402.2776184082, -1351.4703369141, 43.704566955566);// kamera
				SetPlayerCameraLookAt(i, 412.80743408203, -1312.4066162109, 39.677307128906);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zakoñczenie ____|");
			}
			else if(TutTime[i] == 114)
			{
				SendClientMessage(i, COLOR_WHITE, "Masz sie trzymac wymienionych zasad zrozumiano?.");
				SendClientMessage(i, COLOR_WHITE, "Poprostu pamiêtaj o nich i ciesz siê gr¹, a jak nie... ");
				SendClientMessage(i, COLOR_WHITE, "Zapewne masz jeszcze sporo pytañ dotycz¹cych gry. Spokojnie, znajdziesz na nie odpowiedŸ!");
				SendClientMessage(i, COLOR_WHITE, "Mo¿esz œmia³o pytaæ administratora (/admins), poprzez zapytania (/zapytaj), b¹dŸ te¿ [.]");
				SendClientMessage(i, COLOR_WHITE, "[.] poprzez chat dla nowych graczy /newbie. To ju¿ koniec samouczka. ");
				SendClientMessage(i, COLOR_WHITE, "Zasad, poradników i pomocy jest znacznie wiêcej na naszym forum! OdwiedŸ je: https://mrucznik-rp.pl");
			}
			else if(TutTime[i] == 124)
			{
				SendClientMessage(i, COLOR_WHITE, "Jeœli chcesz szybko zarobiæ trochê pieniêdzy - podobno wêdkarstwo jest teraz op³acalne...");
				SendClientMessage(i, COLOR_WHITE, "Udaj siê na molo z ko³em, z³ap parê ryb (/fish) a nastêpnie sprzedaj w 24/7!");

				SetPVarInt(i, "AntyCheatOff", 1);

				TogglePlayerSpectating(i, false);
				
				SetPlayerPos(i, 208.3876,-34.8742,1001.9297);
				SetPlayerFacingAngle(i, 138.8926);

				SetPlayerCameraPos(i, 206.288314, -38.114028, 1002.229675);
				SetPlayerCameraLookAt(i, 208.775955, -34.981678, 1001.929687);
			}
			else if(TutTime[i] == 125)
			{
				TutTime[i] = 0; PlayerInfo[i][pTut] = 1;
				gOoc[i] = 0; gNews[i] = 0; gFam[i] = 0;
				MedicBill[i] = 0;
				PlayerInfo[i][pMuted] = 0;
				
				SendClientMessage(i, COLOR_NEWS, "A teraz wybierz, jak ma wygl¹daæ twoja postaæ.");
				SetPVarInt(i, "wyborPierwszego", 1);
				NowaWybieralka_Setup(i);
			}
		}
		if(PlayerTazeTime[i] >= 1)
		{
			PlayerTazeTime[i] += 1;
			if(PlayerTazeTime[i] == 15)
			{
				PlayerTazeTime[i] = 0;
			}
			else
			{
				GetPlayerFacingAngle(i, angle);
				SetPlayerFacingAngle(i, angle + 90);
			}
		}
		if(PlayerDrunk[i] >= 5)
		{
			PlayerDrunkTime[i] += 1;
			if(PlayerDrunkTime[i] == 8)
			{
				PlayerDrunkTime[i] = 0;
				GetPlayerFacingAngle(i, angle);
				if(IsPlayerInAnyVehicle(i))
				{
					if(GetPlayerState(i) == 2)
					{
						GetPlayerName(i, plname, sizeof(plname));
						format(string, sizeof(string), "%s Krzyczy: AAAAAhHahahahhaaa!!", plname);
						ProxDetector(30.0, i, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
					}
				}
				else
				{
					SetPlayerSpecialAction(i, SPECIAL_ACTION_DRINK_BEER);
					ApplyAnimation(i,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);
				}
			}
		}
		if(PlayerInfo[i][pCarTime] > 0)
		{
			if(PlayerInfo[i][pCarTime] <= 0)
			{
				PlayerInfo[i][pCarTime] = 0;
			}
			else
			{
				PlayerInfo[i][pCarTime] -= 1;
			}
		}
		if(BoxWaitTime[i] > 0)
		{
			if(BoxWaitTime[i] >= BoxDelay)
			{
				BoxDelay = 0;
				BoxWaitTime[i] = 0;
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				GameTextForPlayer(i, "~g~Walka rozpoczeta", 5000, 1);
				TogglePlayerControllable(i, 1);
				RoundStarted = 1;
			}
			else
			{
				format(string, sizeof(string), "%d", BoxDelay - BoxWaitTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				BoxWaitTime[i] += 1;
			}
		}
		if(RoundStarted > 0)
		{
			if(PlayerBoxing[i] > 0)
			{
				GetPlayerHealth(i, health);
				if(health < 12)
				{
					if(i == Boxer1) { Lost = 1; trigger = 1; }
					else if(i == Boxer2) { Lost = 2; trigger = 1; }
				}
				if(health < 28) { GetPlayerFacingAngle(i, angle); SetPlayerFacingAngle(i, angle + 85); }
				if(trigger)
				{
					if(Lost == 1)
					{
						if(IsPlayerConnected(Boxer1) && IsPlayerConnected(Boxer2))
						{
							SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186); SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
							SetPlayerInterior(Boxer1, 5); SetPlayerInterior(Boxer2, 5);
							GetPlayerName(Boxer1, loser, sizeof(loser));
							GetPlayerName(Boxer2, winner, sizeof(winner));
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pLoses] += 1; }
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pWins] += 1; }
							if(TBoxer < 255)
							{
								if(IsPlayerConnected(TBoxer))
								{
									if(TBoxer != Boxer2)
									{
										if(PlayerInfo[Boxer2][pJob] == 12)
										{
											TBoxer = Boxer2;
											GetPlayerName(TBoxer, titel, sizeof(titel));
											format(plname, sizeof(plname), "%s", titel);
											strmid(Titel[TitelName], plname, 0, strlen(plname), 255);
											Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
											Titel[TitelLoses] = PlayerInfo[TBoxer][pLoses];
											SaveBoxer();
											format(string, sizeof(string), "Boks News: %s wygra³ walkê z Mistrzem %s i teraz to ON jest Mistrzem Boksu.",  titel, loser);
											OOCOff(COLOR_WHITE,string);
										}
										else
										{
											SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* zosta³byœ mistrzem bokserskim gdybyœ mia³ pracê boxera !");
										}
									}
									else
									{
										GetPlayerName(TBoxer, titel, sizeof(titel));
										format(string, sizeof(string), "Boks News: Mistrz boksu %s wygra³ walkê z %s.",  titel, loser);
										OOCOff(COLOR_WHITE,string);
										Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
										Titel[TitelLoses] = PlayerInfo[Boxer2][pLoses];
										SaveBoxer();
									}
								}
							}//TBoxer
							format(string, sizeof(string), "* Przegra³eœ walkê z %s.", winner);
							SendClientMessage(Boxer1, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer1, "~r~you lost", 3500, 1);
							format(string, sizeof(string), "* Wygra³eœ walkê z %s.", loser);
							SendClientMessage(Boxer2, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer2, "~r~Wygrales", 3500, 1);
							if(GetPlayerHealth(Boxer1, health) < 20)
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer1, 30.0);
							}
							else
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer1, 50.0);
							}
							if(GetPlayerHealth(Boxer2, health) < 10)
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wykoñczony, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer2, 30.0);
							}
							else
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer2, 50.0);
							}
							GameTextForPlayer(Boxer1, "~g~Walka skonczona", 5000, 1); GameTextForPlayer(Boxer2, "~g~Walka skonczona", 5000, 1);
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pBoxSkill] += 1; }
							PlayerBoxing[Boxer1] = 0;
							PlayerBoxing[Boxer2] = 0;
						}
					}
					else if(Lost == 2)
					{
						if(IsPlayerConnected(Boxer1) && IsPlayerConnected(Boxer2))
						{
							SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186); SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
							SetPlayerInterior(Boxer1, 5); SetPlayerInterior(Boxer2, 5);
							GetPlayerName(Boxer1, winner, sizeof(winner));
							GetPlayerName(Boxer2, loser, sizeof(loser));
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pLoses] += 1; }
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pWins] += 1; }
							if(TBoxer < 255)
							{
								if(IsPlayerConnected(TBoxer))
								{
									if(TBoxer != Boxer1)
									{
										if(PlayerInfo[Boxer1][pJob] == 12)
										{
											TBoxer = Boxer1;
											GetPlayerName(TBoxer, titel, sizeof(titel));
											format(plname, sizeof(plname), "%s", titel);
											strmid(Titel[TitelName], plname, 0, strlen(plname), 255);
											Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
											Titel[TitelLoses] = PlayerInfo[TBoxer][pLoses];
											SaveBoxer();
											format(string, sizeof(string), "Boks News: %s wygra³ walkê z Mistrzem %s i teraz to ON jest Mistrzem Boksu.",  titel, loser);
											OOCOff(COLOR_WHITE,string);
										}
										else
										{
											SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* zosta³byœ mistrzem bokserskim gdybyœ mia³ pracê boxera !");
										}
									}
									else
									{
										GetPlayerName(TBoxer, titel, sizeof(titel));
										format(string, sizeof(string), "Boks News: Mistrz boksu %s wygra³ walkê z %s.",  titel, loser);
										OOCOff(COLOR_WHITE,string);
										Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
										Titel[TitelLoses] = PlayerInfo[Boxer1][pLoses];
										SaveBoxer();
									}
								}
							}//TBoxer
							format(string, sizeof(string), "* Przegra³eœ walkê z %s.", winner);
							SendClientMessage(Boxer2, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer2, "~r~Przegrana", 3500, 1);
							format(string, sizeof(string), "* Wygra³eœ walkê z %s.", loser);
							SendClientMessage(Boxer1, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer1, "~g~Wygrana", 3500, 1);
							if(GetPlayerHealth(Boxer1, health) < 20)
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer1, 30.0);
							}
							else
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer1, 50.0);
							}
							if(GetPlayerHealth(Boxer2, health) < 20)
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer2, 30.0);
							}
							else
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer2, 50.0);
							}
							GameTextForPlayer(Boxer1, "~g~Koniec walki", 5000, 1); GameTextForPlayer(Boxer2, "~g~Koniec walki", 5000, 1);
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pBoxSkill] += 1; }
							PlayerBoxing[Boxer1] = 0;
							PlayerBoxing[Boxer2] = 0;
						}
					}
					InRing = 0;
					RoundStarted = 0;
					Boxer1 = 255;
					Boxer2 = 255;
					TBoxer = 255;
					trigger = 0;
				}
			}
		}
		if(CzasInformacyjnego[i] > 0)
        {
            CzasInformacyjnego[i]--;
            if(CzasInformacyjnego[i] == 0)
            {
                PlayerTextDrawHide(i, TextInformacyjny[i]);
            }
        }
		if(FindTime[i] > 0)
		{
			if(FindTime[i] == FindTimePoints[i]) { FindTime[i] = 0; FindTimePoints[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", FindTimePoints[i] - FindTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				FindTime[i] += 1;
				GetPlayerPos(TaxiAccepted[i], x, y, z);
				SetPlayerCheckpoint(i, x, y, z, 5);
			}
		}
		if(MedicCallTime[i] > 0)
		{
			if(MedicCallTime[i] == 120) { MedicCallTime[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", 120 - MedicCallTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				MedicCallTime[i] += 1;
			}
		}
		if(MechanicCallTime[i] > 0)
		{
			if(MechanicCallTime[i] == 120) { MechanicCallTime[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", 120 - MechanicCallTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				MechanicCallTime[i] += 1;
			}
		}
		if(PlayerTied[i])
		{
			if(PlayerTiedTime[i] <= 0)
			{
                GetPlayerName(i, winner, sizeof(winner));
				format(string, sizeof(string), "* %s po wielu próbach poluzowa³ sznur i jest wolny.", winner);
				ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				GameTextForPlayer(i, "~r~Jestes wolny!", 2500, 3);
				PlayerTiedTime[i] = 0;
				isBeatenUp[i] = false;
				PlayerInfo[i][pMuted] = 0;
				PlayerTied[i] = false;
                PlayerInfo[i][pBW]=0;
                TogglePlayerControllable(i, 1);
                SetPVarInt(i, "bw-sync", 0);
                PlayerInfo[i][pMuted] = 0;
			}
			else
			{
				PlayerTiedTime[i] -= 1;
			}
		}

		#if defined _ZLODZIEJ_AUT
			if(stole_a_car_seconds_to_find_cp[i] > 0)
			{
				stole_a_car_seconds_to_find_cp[i]--;
			}
		#endif
	}

	return 1;
}

//11.06.2014
public CheckGas()
{
	new string[128], vehicle, engine,lights,alarm,doors,bonnet,boot,objective;
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
			vehicle = GetPlayerVehicleID(i);
			GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
			if(Gas[vehicle] >= 1)
			{
				if(engine != 0)
				{
					if(Gas[vehicle] <= 10) { PlayerPlaySound(i, 1085, 0.0, 0.0, 0.0); }
					if(Gas[vehicle] > 100) { Gas[vehicle] = 100; }
					if(gGas[i] == 1)
					{
						format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Paliwo:~w~ %d%",Gas[vehicle]);
						GameTextForPlayer(i,string,15500,3);
					}
					if(IsAPlane(vehicle) || IsABoat(vehicle))
					{
						Gas[vehicle]++;
					}
					Gas[vehicle]--;
				}
			}
			else
			{
				GameTextForPlayer(i,"~w~~n~~n~~n~~n~~n~~n~~n~~n~Brak paliwa w wozie, silnik zgasl",1500,3);
				SetVehicleParamsEx(vehicle,0,lights,alarm,doors,bonnet,boot,objective);
			}
		}
	}
	return 1;
}

//11.06.2014
public Fillup()
{
    new VID, FillUp, string[128];
	foreach(new i : Player)
   	{
		if(IsPlayerNPC(i))
		{
			continue;
		}
		VID = GetPlayerVehicleID(i);
		if(Gas[VID] <= 100) FillUp = GasMax - Gas[VID];
		else FillUp = 0;
		if(Refueling[i] == 1)
		{
			new FillUpPrice = FillUp * 120;
			new discount = false;

			new player_frac = GetPlayerFraction(i);
			new price_half = floatround(0.5 * float(FillUpPrice));
			if(IsAPorzadkowy(i) && IsPlayerInTheirFractionVehicle(i))
			{// dla pojazdów frakcji porz¹dkowych 50% nale¿noœci idzie z sejfu
				if(Sejf_Frakcji[player_frac] >= price_half)
				{
					FillUpPrice = price_half;
					discount = true;
				}
			}

			new bizId = IsPlayerAtFrontBusinnesZone(i);
			if(IsBusinessTypeOwnedByPlayerOrg(i, FRONT_BIZ_TYPE_GAS_STATION))
			{
				MruMessageGoodInfo(i, "Twoja organizacja posiada t¹ stacjê bezynow¹, wiêc nie p³acisz nic za tankowanie.");
				AccountBusinessProfit(bizId, FillUpPrice);
				FillUpPrice = 0;
			}
			
			// 50% of gas price goes to the owner of the gas station
			if(bizId != -1 && FrontBusiness[bizId][Type] == FRONT_BIZ_TYPE_GAS_STATION)
			{
				GenerateFrontBusinessIncome(bizId, FillUpPrice/2);
			}

			if(kaska[i] >= FillUpPrice)
			{
				Gas[VID] += FillUp;
				format(string,sizeof(string),"Pojazd zatankowany za: $%d.",FillUpPrice);
				SendClientMessage(i, COLOR_LIGHTBLUE,string);
				ZabierzKase(i, FillUpPrice);

				if(discount)
				{
					Sejf_Add(player_frac, -price_half);
					SendClientMessage(i, COLOR_LIGHTBLUE,"Po³owa kosztów tankowania zosta³a op³acona ze œrodków frakcji.");
				}
			}
			else
			{
				format(string,sizeof(string),"Nie posiadasz doœæ pieniêdzy ($%d) aby zatankowaæ ten pojazd.", FillUpPrice);
				sendErrorMessage(i,string);
			}

			Refueling[i] = 0;
		}
	}
	return 1;
}

public PlayersCheckerMinute()
{
	foreach(new j : Player)
	{
		if(IsPlayerNPC(j))
		{
			continue;
		}
		if(gPlayerLogged[j] > 0)
		{
			if(GetPlayerSkin(j) == 0 && GetPlayerAdminDutyStatus(j) == 0 && GetPVarInt(j, "IsAGetInTheCar") == 0)
			{
				if(PlayerInfo[j][pSkin] > 0)
				{
					SetPlayerSpawnSkin(j);
				}
				else 
				{
					//PlayerInfo[j][pSkin] = 299; na potem
					SetPlayerSkinEx(j, 299);
					sendTipMessage(j, "Posiada³eœ skin CJ-a ID [0] - przywróciliœmy Ci domyœlny skin. Uwa¿asz, ¿e to b³¹d? Zg³oœ utratê w dziale b³êdów.");
					sendTipMessage(j, "[.] opisz dok³adnie co siê sta³o, np. dosta³eœ unfrakcjê lub jesteœ w organizacji, frakcji. Pomocna bêdzie ka¿da informacja.");
				}
			}
		}
	}
}
//11.06.2014
public CarCheck()
{
	new string[128], lTime = gettime();
	foreach(new j : Player)
	{
		if(IsPlayerNPC(j))
		{
			continue;
		}
        if(kaska[j] < 0)
		{
			if(MoneyMessage[j]==0)
			{
				format(string, sizeof(string), "Masz d³ugi, musisz zarobiæ do nastêpnej wyp³aty $%d inaczej naœlemy na ciebie policje.",PlayerInfo[j][pCash]);
				SendClientMessage(j, COLOR_LIGHTRED, string);
				MoneyMessage[j] = 1;
			}
		}
		else
		{
			MoneyMessage[j] = 0;
		}
        if(PlayerInfo[j][pCarLic] > 1000)
        {
            if(lTime > PlayerInfo[j][pCarLic])
            {
                PlayerInfo[j][pCarLic] = 0;
                SendClientMessage(j, COLOR_LIGHTRED, "Blokada licencji na prowadzenie pojazdu minê³a!");
            }
        }
	}	
    //Kolczatki 23.08
    new time = gettime();
    for(new i=0;i<MAX_KOLCZATEK;i++)
    {
        if(KolID[i] != -1)
        {
            if(KolTime[i] <= time)
            {
                Kolczatka_Delete(i);
            }
        }
    }
    //For oil only
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        bOilOccur[i] = false;
    }
	return 1;
}

public GangZone_Process()
{
    new Float:x, Float:y, Float:z;
    foreach(new i : Player)
    {
        GetPlayerPos(i, x, y, z);
        for(new g=0;g<MAX_ZONES;g++) //zone loop
        {
            if(x >= Zone_Data[g][0] && x <= Zone_Data[g][2] && y >= Zone_Data[g][1] && y <= Zone_Data[g][3])
            {
                if(!bInZone[i][g])
                {
                    printf("%s entered gangzone %d", GetNick(i), g);
                    bInZone[i][g] = true;
                    CallLocalFunction("OnPlayerEnterGangZone", "ii", i, g);
                    break;
                }
            }
            else if(bInZone[i][g])
            {
                printf("%s left gangzone %d", GetNick(i), g);
                bInZone[i][g] = false;
                CallLocalFunction("OnPlayerLeaveGangZone", "ii", i, g);
                break;
            }
        }
    }
}
forward CheckTankMode(playerid, giveid, carid, Float:vhealth);
public CheckTankMode(playerid, giveid, carid, Float:vhealth)
{
	new result, string[144], Float:newvhealth;
	GetVehicleHealth(carid, newvhealth);
	result = (vhealth == newvhealth ? true : false);
    format(string, sizeof(string), "Admin %s [%d] sprawdzi³ %s [%d]. Wynik: %s", GetNickEx(playerid), playerid, GetNick(giveid), giveid, (result ? "{fad052}prawdopodobny tankmode (zalecany /spec)" : "{fa5252}negatywny (brak tankmode)"));
    SendCommandLogMessage(string);
	if(vhealth != newvhealth) SetVehicleHealth(carid, newvhealth+15);
	return 1;
}
forward GangZone_ShowInfoToParticipants();
public GangZone_ShowInfoToParticipants() {
    new string[60];
    foreach(new i : Player) {
        new frac = GetPlayerFraction(i);
        if(frac == 0) frac = GetPlayerOrg(i);
        new pzone = GetPVarInt(i, "zoneid");
        if(pzone == -1) return 1;
        if(ZoneAttack[pzone])
        {
            new svar_data[30];
            format(svar_data, 128, "ZONEDEFTIME_%d", pzone);
            if(GetSVarInt(svar_data) < 0)
                format(string, 128, "~n~~n~~n~~n~~n~ATAK NA STREFE~n~~y~PRAWIE KONIEC");
            else {
                format(string, 128, "~n~~n~~n~~n~~n~ATAK NA STREFE~n~~y~%d", GetSVarInt(svar_data));
            }
            GameTextForPlayer(i, string, 2500, 3);
            if(ZoneAttackData[pzone][2] > 100)
            {
                //GameTextForAll(string, 3000, 3);
                GameTextForPlayer(i, string, 1000, 3);
            }
            else
            {
                GameTextForPlayer(i, string, 1000, 3);   
            }
            SetSVarInt(svar_data, GetSVarInt(svar_data)-2);
        }
    }
    return 1;
}
public VehicleUpdate()
{
    new Float:lHP = 0.0,
        engine, lights, alarm, doors, bonnect, boot, objective;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(!GetVehicleHealth(i, lHP)) continue;

        if(lHP < 250.0)
        {
            if(Car_GetOwner(i) == JOB_TRUCKER && Car_GetOwnerType(i) == CAR_OWNER_JOB && GetVehicleModel(i) == 530)
            {
                SetVehicleHealth(i, 1000.0);
                Gas[i] = 100;
            }
            else
            {
                SetVehicleHealth(i, 250.0);
                if(VehicleUID[i][vUID] != 0)
                    CarData[VehicleUID[i][vUID]][c_HP] = 250.0;
                GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnect, boot, objective);
                SetVehicleParamsEx(i, 0, lights, alarm, doors, bonnect, boot, objective);
                new hour,minute,second;
				gettime(hour,minute,second);
				FixHour(hour);
				if(shifthour >= 4)
				{
					Oil_GenerateFromVehicle(i);
				}
            }
        }
    }
}


public closeGate(i, j, playerid)
{
    bramki_sasd_state[i] = false;
    SetPVarInt(playerid, "wybramkowany", 0);
    bramy[j][b_flaga] = true;
    MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x2],  bramy[j][b_y2], bramy[j][b_z2], bramy[j][b_speed], bramy[j][b_rx2],  bramy[j][b_ry2], bramy[j][b_rz2]);
    return 1;
}


public SlideRope(playerid)
{
    if(GetPVarInt(playerid,"sliderope") == 1)
    {
		new Float:X;
	    new Float:Y;
	    new Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
  	 	ApplyAnimation(playerid,"ped","abseil",2.0,0,0,0,1,0);
	    SetPlayerPos(playerid, X, Y, Z - 2.00);
		SetPlayerVelocity(playerid,0,0,0);
	    SetTimerEx("SlideRope", 1000, 0, "i", playerid);
 	}
	return 1;
}

public SpecEnd(playerid)
{
	SetSpawnInfo(playerid, 0, 299, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2], 10.0, -1, -1, -1, -1, -1, -1);
	TogglePlayerSpectating(playerid, false);
	SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
	return 1;
}

public DamagedHP(playerid)
{
	RemovePlayerAttachedObject(playerid, 2);
	return 1;
}

forward KissRejectTimer(kissingid, kissedid);
public KissRejectTimer(kissingid, kissedid)
{
	new string[128];

	if(kissPlayerOffer[kissedid] == kissingid)
	{
		if (ProxDetectorS(10.0, kissedid, kissingid))
		{
			format(string, sizeof(string), "* %s spojrza³(a) na %s i stwierdzi³(a), ¿e nie chce siê ca³owaæ!", GetNick(kissedid), GetNick(kissingid));
			ProxDetector(20.0, kissedid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else
		{
			format(string, sizeof(string), "* mimo prób %s, nie mog³o dojœæ do poca³unku miêdzy nim/ni¹ a %s, poniewa¿ s¹ od siebie za daleko!", GetNick(kissingid), GetNick(kissedid));
			ProxDetector(20.0, kissingid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
		}

		kissPlayerOffer[kissedid] = INVALID_PLAYER_ID;
	}

	return 1;
}

//EOF
