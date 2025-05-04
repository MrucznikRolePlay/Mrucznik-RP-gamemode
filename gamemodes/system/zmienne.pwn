//zmienne.pwn
new DEVELOPMENT = false;

new RequestClassSpamProtection[MAX_PLAYERS];

new SentMessagesIndex[MAX_PLAYERS] = 0;
new SentMessages[MAX_PLAYERS][MAX_SENT_MESSAGES][144];
new MessageType:SentMessagesType[MAX_PLAYERS][MAX_SENT_MESSAGES];

new ServerSecret[MAX_SERVER_SECRET_LENGTH];

new prawoJazdyLosowanie[9];

new PozwolenieBot = 1;

new LastVehicleID[MAX_PLAYERS];
new VehicleIDChanges[MAX_PLAYERS];
new VehicleIDChangeTime[MAX_PLAYERS];

new acstr[128];

new Float:czitX;
new Float:czitY;
new Float:czitZ;

new timerAC[MAX_PLAYERS];
new timeAC[MAX_PLAYERS];

new timeFakeVehRespawn[MAX_PLAYERS] = {0, ...}; // czas (tick) kiedy gracz ostatnio utopi³ pojazd (albo udawa³, ¿e go utopi³, by je zrespawnowaæ)
new countFakeVehRespawn[MAX_PLAYERS] = {0, ...}; // ile razy w ci¹gu ostatnich 20 minut gracz utopi³ pojazd (albo udawa³, ¿e go utopi³, by je zrespawnowaæ)
new unoccupiedVehToCheckAC[MAX_VEHICLES] = {false, ...}; // true je¿eli w przeci¹gu ostatnich 3 sekund pozycja danego pojazdu zosta³a zmieniona przez synchronizacjê pojazdu bez kierowcy (UnoccupiedSync)
new unoccupiedVehToCheckPlayersAC[MAX_VEHICLES][MAX_PLAYERS] = {{false, ...}, ...}; // true dla danego pojazdu v i dla danego gracza p, jezeli to gracz p dokona³ synchronizacji pojazdu v (UnoccupiedSync)
new unoccupiedVehBlockAC[MAX_PLAYERS] = {false, ...}; // true je¿eli na gracza zosta³a za³o¿ona blokada synchronizacji pojazdów bez kierowcy
new performUnoccupiedVehCheckAC = false; // true je¿eli pozycja któregokolwiek pojazdu zosta³a zmieniona w przeci¹gu ostatnich 3 sekund przez synchronizacjê typu UnoccupiedSync

//doors
new noAccessCome[MAX_PLAYERS]; 

new saveMyAccountTimer[MAX_PLAYERS];//respawn
new nickRP[MAX_PLAYERS][MAX_PLAYER_NAME];

new timerTime[MAX_PLAYERS]; 

new CzasInformacyjnego[MAX_PLAYERS];
new bramki_sasd[18];
new bool:bramki_sasd_state[18];
//vinyl club
new vinylCenaNorm = 50000;
new vinylCenaVIP = 80000;

//sn
new SN_ACCESS[MAX_PLAYERS];
//Sad
new SadWinda[6] = {1,0,0,1,1,0};

new LSMCWindap0 = 0;//Winda LSMC
new LSMCWindap2 = 0;//Winda LSMC
new LSMCWindap8 = 0;//Winda LSMC

new ServerTime = 14;//Czas
new ServerWeather = 3;//Pogoda

new glosowanie_admina_status = 0;
new glosowanie_admina_tak = 0;
new glosowanie_admina_nie = 0;

//Prawnik - oferta
new LawyerOffer[MAX_PLAYERS];
new OfferPlayer[MAX_PLAYERS];
new OfferPrice[MAX_PLAYERS];

new vinylStatus; 
//Caluj - oferta
new kissPlayerOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
//ALARM DMV:
new DMV_ALARM = 0;
new bramaAlarmu[4];

//Basen Tsunami
new poolStatus = 1;// 0 = zamkniêty; 1 = otwarty;
new onePoolPrice = 50000;
new twoPoolPrice = 75000;
new threePoolPrice = 100000;
new fourPoolPrice = 150000;
new poolCashStats =0;
new poolCreditStatus=0;
new poolSaunaStats=0;
new poolStats=0;
new poolTrampolineStats=0;

//Spamowanie /dmv /lspd etc
new komunikatTime[MAX_PLAYERS];
new komunikatMinuty[MAX_PLAYERS];
new komunikatTimeZerowanie[MAX_PLAYERS];
new komunikatMinutyZerowanie[MAX_PLAYERS];


//Admin Adds
new TimerOddaniaZycia[MAX_PLAYERS];
new dajHPSekunda[MAX_PLAYERS];


//legal
new DB:db_handle;
enum eLegalWpns {
    weaponLegal1,
    weaponLegal2,
    weaponLegal3,
    weaponLegal4,
    weaponLegal5,
    weaponLegal6,
    weaponLegal7,
    weaponLegal8,
    weaponLegal9,
    weaponLegal10,
    weaponLegal11,
    weaponLegal12,
    weaponLegal13
}
new playerWeapons[MAX_PLAYERS][eLegalWpns];

new PlayerSlapperWarning[MAX_PLAYERS] = 0;

new Zgloszenie[OSTATNIE_ZGLOSZENIA][hqZgloszenia];
new ilosczgloszen = 0;
new ilosczgloszenSasp = 0;
new ZgloszenieSasp[OSTATNIE_ZGLOSZENIASASP][hqZgloszeniaSasp];

new pFindZone[MAX_PLAYERS];

new odczekajTimer[MAX_PLAYERS];

new lastMsg[MAX_PLAYERS];

//Actor
new PaniJanina;

//Podglad
new TogPodglad[MAX_PLAYERS];

//dodatkiPD
new DodatkiPD[MAX_PLAYERS];
//AFK timer
new afk_timer[MAX_PLAYERS];
//tazer
new MaTazer[MAX_PLAYERS];
new TazerAktywny[MAX_PLAYERS];
///
new ParachuteHit[MAX_PLAYERS];
//13.11.2019
//17.01.2015
new TICKS_MySQLRefresh=0;
new bool:TICKS_Second=false;
new TICKS_3Sec=0;
new TICKS_HalfMin=0;
new TICKS_1Min=0;
new TICKS_5Min=0;
new TICKS_15Min=0;
new TICKS_30Min=0;
//23.12
new TICKET[MAX_TICKETS][eSupportData];
//12.12
new bramafd[6];
new bool:bramyfd[6]={false, ...};
new GATE_ORGSAD[2];
new bool:GATE_ORGSAD_S[2]={false, false};
//04.12
new PlayerDesc[MAX_PLAYERS][128 char];
new CarDesc[MAX_VEHICLES][128];
//03.12
//8.12 2016
new bool:RANG_ApplyChanges[2][MAX_ORG];
//
new AUDIO_LoginFormat[8];
new PlayerMC[MAX_PLAYERS];
new bool:GLOBAL_EXIT=false;
new bool:GLOBAL_DISABLETRUCKER=false;
//14.11
new CarData[MAX_CARS][eMySQLCar];
new gCars = 1;
new KomunikacjaMiejsca[MAX_VEHICLES] = {-1, -1, ...};
new gKMCounter=0;
//30.10
new BoomBoxData[MAX_BOOMBOX][eBoomBoxData];

new TJD_Materials = 1000;
new Text3D:TJD_Label;
new Text:TXD_TJDBg;
new Text:TXD_TJDImg;
new PlayerText:TXD_TJDCounter[MAX_PLAYERS];
new TransObjects[MAX_PLAYERS][12];

new TransportJobData[][eTransportJobData] = {
    {"Centrum za³adunku", 1769.1692, -2022.8007, 13.1291, 0.0, 0.0, 0.0, 0, 0, 0, 0},
    {"Kostka brukowa", 653.1826, 809.6608, -42.7370, 1900.0842,-1302.5868,14.1575, 6000, 1685, 8, 0},
    {"Beczki z olejem", 251.1756, 1420.7592, 10.2012, 2501.0537, -2211.7014, 12.5464, 5000, 1217, 10, 0},
    {"Odpady komunalne", 2149.8274, -1987.9075, 12.5455, -134.0966, 2243.4724, 32.0858, 5000, 3035, 8, 0},
    {"Odpady biotoksyczne", 1144.9740, -1372.1549, 12.7650, 2149.8274, -1987.9075, 12.5455, 3500, 1271, 12, 0},
    {"Wrak pojazdu", 2149.8274, -1987.9075, 12.5455, -1589.3971, 78.3077, 2.5491, 5000, 3594, 1, 0},
    {"Puste skrzynie", 0.0, 0.0, 0.0, 1194.2673, -887.1570, 42.0945, 2000, 944, 4, 25},
    {"Puste skrzynie", 0.0, 0.0, 0.0, 1900.0842,-1302.5868,14.1575, 2000, 944, 4, 25},
    {"Artyku³y papiernicze", 0.0, 0.0, 0.0, 1480.9487, -1838.1323, 12.5413, 2000, 944, 4, 25},
    {"Artyku³y papiernicze", 0.0, 0.0, 0.0, 1279.8621, -1297.9243, 12.3369, 2000, 944, 4, 25},
    {"Alkohol", 0.0, 0.0, 0.0, 2449.9604, -1764.1433, 12.5697, 2500, 944, 4, 50},
    {"Czêsci samochodowe", 0.0, 0.0, 0.0, 2780.9678, -1618.3486, 9.9151, 2500, 944, 2, 75},
    {"Jedzenie dla zwierz¹t", 0.0, 0.0, 0.0, 2567.8562, -972.7701, 81.1139, 3000, 1454, 10, 100},
    {"Kawa³ki stali", 0.0, 0.0, 0.0, 595.9616, -1296.7166, 13.8559, 2500, 944, 4, 75},
    {"Broñ", 0.0, 0.0, 0.0, 2153.3264, -2289.0762, 12.3670, 1500, 944, 5, 50}
};

new TJDBoxes[7] = {0, ...};
new bool:TJDBoxUsed[7] = {false, ...};
new TJDVehBox[MAX_VEHICLES] = {0, ...};
new TJDTransporter[MAX_VEHICLES] = {0, ...};
new TJDBoxOwner[7];

new Float:TJD_BoxPos[7][3] = {
    {1732.11047, -2062.05151, 13.09370},
    {1733.61047, -2062.05151, 13.09370},
    {1734.61047, -2060.55151, 13.09370},
    {1734.61047, -2059.05151, 13.09370},
    {1734.61047, -2057.55151, 13.09370},
    {1734.61047, -2056.05151, 13.11368},
    {1734.61047, -2054.55151, 13.11370}
};

//03.10
new bool:SafeLoaded=false;
//01.10 server info
new ServerInfo[2048];
//30.09 vopis
new Text3D:Car3dTextDesc[MAX_VEHICLES] = {Text3D:INVALID_3DTEXT_ID, ...};
new CarOpisCaller[MAX_VEHICLES][MAX_PLAYER_NAME];
//20.09
new STANOWE_GATE_KEY = 5231;
new Brama_FDU[3];
new Brama_FDU_Move[3];
//16.09 system plam olejowych LSFD
new OilData[MAX_OILS][eOilData];
new bool:bOilOccur[MAX_VEHICLES] = {false, ...};
new PlayerOilKeys[MAX_PLAYERS][5];
//
new bool:gSNLockedLine[51] = {true, ...};
//24.08
new PatrolInfo[MAX_PATROLS][ePat];
new PatrolSq[64]; //Nazwy
new Patrolujacych[5];
new PatrolZones[9];
//23.08 poprawki LSPD oraz kolczatki
new KolID[MAX_KOLCZATEK] = {-1, ...},
    KolTime[MAX_KOLCZATEK],
    KolArea[MAX_KOLCZATEK],
    bool:KolDelay[MAX_VEHICLES] = {false, ...},
    KolVehicle[MAX_KOLCZATEK];
//18.08 poprawki crashy, obiektów, rebuild, admin island, kolejka, loading screen
new AUDIO_LoginTotal;
new AUDIO_LoginData[20][16];
new AI_SIGN[3],
    AI_NAPIS[2],
    AI_MOVABLE[2],
    AI_PROTECT[11];
new bool:VAR_Kolejka=false;
//13.08  s¹d int, drobne zmiany errorów, fly mode dla 1000+ @

new Brama_HA;
new Brama_HA1;
new Brama_HA2;
new Brama_Move_HA = 0;
new Brama_Move_HA1 = 0;
new GATE_SAD[42] = {0, ...};
new bool:GATE_SAD_ALARM = false;
//01.08 speedometer
new bool:ToggleSpeedo[MAX_PLAYERS],
    bool:ToggleSpeedoGPS[MAX_PLAYERS];
new ERS_mundur[MAX_PLAYERS] = 0;
//21.07 PayDay fix
new Blink[MAX_VEHICLES][4];
new BlinkSide[MAX_VEHICLES];
new Float:BlinkR[MAX_VEHICLES];
new BlinkTrailer[MAX_VEHICLES];
new TrailerVehicle[MAX_VEHICLES];

new GLOB_LastHour;
//18.07 barierki fix - limit samp
new bool:BarierState[MAX_FRAC][10];

//15.07   urodzinki :D

//13.07  system skinow frakcyjnych mysql
new FRAC_SKINS[MAX_FRAC][MAX_SKIN_SELECT];

//frac
new LeadersValue[LEADERS_TYPES][MAX_FRAC]; //a

//12.07
new TRAIN_HornTimer=0;
//10.07 AirTraffic
new PlayerText3D:TOWER_PlayerHologram[MAX_PLAYERS];
new PlayerText3D:TOWER_TrafficHologram[MAX_PLAYERS][MAX_VEHICLES];
new TOWET_LoopTimer[MAX_PLAYERS]={0,...};
new TOWER_ActivePlayers=0;

new Float:RADIO_CHANNEL[MAX_PLAYERS] = {0.0, ...};
new Float:TOWER_CHANNEL = 120.0;
new TOWER_CONTACT;
new bool:TOWER_Blocked[MAX_PLAYERS] = {false, ...};
//02.07 sejfy wprowadzenie
new Sejf_Frakcji[MAX_FRAC];
new Sejf_Rodziny[MAX_ORG];
new Frakcja_Mats[MAX_FRAC];
new Rodzina_Mats[MAX_ORG];
new Rodzina_Contraband[MAX_ORG];
//23.06 fina³
new KTAir_Start, KTAir_End, Float:KTAir_Offsets[3]; //Dla At400 nie ruszaæ.
new bool:VAR_MySQLREGISTER=true; //W³¹czyæ rejestracje?
new GATE_VINYL, bool:GATE_VINYL_S=false,
    GATE_VINYL_IN[4], bool:GATE_VINYL_IN_S[4] = {false, ...};
new Float:VinylAudioPos[5] = {798.357666, -1413.888061, -22.609298,800.0,71.0};  //pos[3] dist, vw
new VINYL_Stream[128];
//22.06  system rang mysql
new FracRang[MAX_FRAC][MAX_RANG][MAX_RANG_LEN]; //4kB
//18.06 uprawnienia
new ACCESS[MAX_PLAYERS], OLD_ACCESS[MAX_PLAYERS];
//15.06 system aut kradziezy
new CAR_End = 0;

//13.06
//lsmc exterior
new lsmcex1;
new lsmcex2;
new lsmcex3;
new lsmcex4;
new lsmcex5;
new lsmcex6;
new lsmcex1move = 0;
new lsmcex2move = 0;
new lsmcex3move = 0;
new lsmcex4move = 0;
new lsmcex5move = 0;
new lsmcex6move = 0;

//09.06
new muzykaON[MAX_FRAC]=0;
//nowe stanowe
new bool:VAR_NGKeypad = false;
//Barierki kubi
new gTotalItems = TOTAL_ITEMS;
new PlayerText:gCurrentPageTextDrawId[MAX_PLAYERS];
new PlayerText:gHeaderTextDrawId[MAX_PLAYERS];
new PlayerText:gBackgroundTextDrawId[MAX_PLAYERS];
new PlayerText:gNextButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gSelectionItems[MAX_PLAYERS][SELECTION_ITEMS];
new gSelectionItemsTag[MAX_PLAYERS][SELECTION_ITEMS];
new gItemAt[MAX_PLAYERS];

// KOORDYNATY IBIZY DLA AUDIO STREAM
new Float:IbizaAudioPos[4] = {417.3976, -1858.9402, -65.3905, 1000.0};  //pos[3] dist, vw
new IBIZA_Stream[128];

new Barier[MAX_FRAC][10];
new Text3D:BarText[MAX_FRAC][10];

new gItemList[TOTAL_ITEMS] = {
1424,3091,1238,3578,997,1427 ,1422,1434,981,7933,1237,19834
};
//LSMC
new Float:ElevatorDoors[8][5] = { //18756 - lewe | 18757 - prawe
	{-2805.166503, 2600.131591, -97.273040,90.00000, 90.0}, //Pkostnica
    {1138.354125, -1320.493530, 69.180976,0.00000, 90.0}, //P1
    {1182.949340, -1333.508178, 88.932754,0.00000, 90.0}, //P2
    {1167.979980, -1340.695556, 101.147979,0.00000, 90.0}, //P3
    {1158.328491, -1339.429199, 121.063812,0.00000, 90.0}, //P4
    {1167.583007, -1332.331176, 135.575759,0.00000, 90.0}, //P5
    {1177.126708, -1320.746459, 178.873077,0.00000, 90.0}, //P6
    {1177.757812, -1330.786621, 192.331710,0.00000, 90.0} //P7
};
new bool:ElevatorDoorsState[8], ElevatorObject[8], bool:LSMCElevatorQueue;
new bool:ElevatorVar;
new VAR_LSMCTopic;
new lsmc1;
new lsmc2;
new lsmc3;
new lsmc4;
new lsmc5;
new lsmc6;
new lsmc7;
new lsmc8;
new lsmc9;
new lsmc10;
new lsmc11;
new lsmc12;
new lsmc13;
new lsmc14;
new lsmc15;
new lsmc16;
new lsmc17;
new lsmc18;
new lsmc19;
new lsmc20;
new lsmc21;
new rezonans;
new lsmc1move = 0;
new lsmc2move = 0;
new lsmc3move = 0;
new lsmc4move = 0;
new lsmc5move = 0;
new lsmc6move = 0;
new lsmc7move = 0;
new lsmc8move = 0;
new lsmc9move = 0;
new lsmc10i11move = 0;
new lsmc12move = 0;
new lsmc13move = 0;
new lsmc14move = 0;
new lsmc15move = 0;
new lsmc16move = 0;
new lsmc17move = 0;
new lsmc18move = 0;
new lsmc19move = 0;
new lsmc20move = 0;
new lsmc21move = 0;
new rezonansmove = 0;
//dialogs

new dialTimer[MAX_PLAYERS]; 
new dialAccess[MAX_PLAYERS]; 
new dialTime[MAX_PLAYERS]; 
//SAN NEWS
new posDrzwiSN[MAX_PLAYERS]; 
new SanDrzwi1;
new SanDrzwi2;
new SanDrzwi3;
new SanDrzwi4;
new SanDrzwi5;
new SanMove1 = 0;
new SanMove2 = 0;
new SanMove3 = 0;
new SanMove4 = 0;
new Teleturniejstart = 0;
new grajacy[MAX_PLAYERS];
new levelLock[MAX_FRAC][MAX_LEVELINT];

//wl
new giveWL=true;

new bool:moveZaluzja1 = false;
new bool:moveZaluzja2 = false;
new zaluzja1;
new zaluzja2;
new bool:lightsVinyl = false;
new neonVinyl = 0;
new bool:sphereVinyl = false;
new bool:podestVinyl = false;
new bool:neonsVinyl = false;
new bool:jacuzziVinyl = false;
new bool:dymVinyl = false;
new bool:eqVinyl = false;
new podest1, podest2, dym1, dym2, dym3, dym4, dym5, led1, led2, led3,  kula;
new neon1, neon2, neon3, neon4, neon5, neon6, neon7, neon8, neon9, neon10, neon11, neon12, neon13, neon14;
new neon15, neon16, neon17, neon18, neon19, neon20, neon21, neon22, neon23;
new eq_1_1, eq_1_2, eq_2_1, eq_2_2, eq_3_1, eq_3_2, eq_4_1, eq_4_2, eq_5_1, eq_5_2, eq_6_1, eq_6_2, eq_7_1, eq_7_2, eq_8_1, eq_8_2;
new sphereTimer, sphereTimer_second, NeonsTimer;
new eqTimer_First, eqTimer_Second, eqTimer_Third, eqTimer_Fourth;
new textVinyl_Timer;
new text_Vinyl;
new bool:textVinyl;

new SetTAWForPlayer[MAX_PLAYERS];
new vinylDrinkNames[4][32] = {
	"Red Tart",
	"Cuda Libre",
	"Tom Collins",
	"Twoja Stara"
};
new vinylDrinkCosts[4] = {
	10000,
	15000,
	18000,
	20000
};
//---------------------------------------------//

//abram01
new bor;
new bor1;
new bormove;
new bormove1;
//verona mall
new roleta1;
new roleta2;
new roleta3;
new roleta4;
new roleta5;
new roleta6;
new roleta7;
new roleta8;
new roleta9;
new roleta10;
new roleta11;
new roleta12;
new roleta13;
new roleta14;
new roleta15;
new roleta16;
new roleta17;
new roleta18;
new roleta19;
new roleta20;
new roleta21;
new roleta22;
new roleta23_b;
new roleta24_b;
new roleta25_b;
new roleta26_b;
new roleta27_b;
new roleta28_b;
new roleta29_b;
new roleta30_b;
new roleta31_b;
new roleta32_b;
new roleta33_b;
new roleta34_b;
new roleta35_b;
new roleta36_b;
new open = 0;

new ZestawNaprawczy_Timer[MAX_PLAYERS];
new ZestawNaprawczy_Warning[MAX_PLAYERS];

//Zmienne ZOPTYMALIZOWANE: xD
new StaryCzas[MAX_PLAYERS];
new SafeTime[MAX_PLAYERS];

//Frakcja NoA:
new bool:openwarsztat = false;//Warsztat owarty/nie
new tworzenietrasy[MAX_PLAYERS] = 666;//Ustawia ID trasy podczas tworzenia
new owyscig[MAX_PLAYERS] = 666;//Ustawia ID trasy podczas organizowania
new ScigaSie[MAX_PLAYERS] = 666;//Czy gracz siê œciga i na jakiej trasie
new IloscCH[MAX_PLAYERS];//Iloœæ czekpointów
new Float:wCheckpoint[20][MAX_CHECKPOINTS+1][3];//Pozycje Checkpointów
new Scigamy = 666;//Jaki wyœcig jest w³¹czony
new IloscZawodnikow;//Iloœæ zawodników w wyœcigu
new Ukonczyl = 1;

new dajeKontrakt[MAX_PLAYERS];
new haHajs[MAX_PLAYERS];

//N!ree
new cbradijo[MAX_PLAYERS];
new adminpodgladcb[MAX_PLAYERS];
new matogczas[MAX_PLAYERS];
//---
new Security = 0;
new CreatedCars[100];
new CreatedCar = 0;
new Tax = 0;
new TaxValue = 0;
new Jackpot = 0;
new InRing = 0;
new RoundStarted = 0;
new BoxDelay = 0;
new Boxer1 = 255;
new Boxer2 = 255;
new TBoxer = 255;
new PlayerBoxing[MAX_PLAYERS];
new WnetrzeWozu[MAX_PLAYERS];
new hitfound = 0;
new hitmanid = 999;
new Medics = 0;
new MedicCall = 999;
new MedicCallTime[MAX_PLAYERS];
new Mechanics = 0;
new MechanicCall = 999;
new MechanicCallTime[MAX_PLAYERS];
new JobDuty[MAX_PLAYERS];
new SanDuty[MAX_PLAYERS];
new sanwyjdz[MAX_PLAYERS];
new WarningDuty[MAX_PLAYERS];
new NJDuty[MAX_PLAYERS];
new MapIconsShown[MAX_PLAYERS];
new OnCK[MAX_PLAYERS];
new GettingCK[MAX_PLAYERS];
new SchoolSpawn[MAX_PLAYERS];
new TakingLesson[MAX_PLAYERS];
new UsedFind[MAX_PLAYERS];
new PlayersChannel[MAX_PLAYERS];
new MatsHolding[MAX_PLAYERS];
new DivorceOffer[MAX_PLAYERS];
new MarriageCeremoney[MAX_PLAYERS];
new ProposeOffer[MAX_PLAYERS];
new ProposedTo[MAX_PLAYERS];
new GotProposedBy[MAX_PLAYERS];
new MarryWitness[MAX_PLAYERS];
new MarryWitnessOffer[MAX_PLAYERS];
new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];
new AntySpawnBroni[MAX_PLAYERS];
new AntyWlamSejf[MAX_PLAYERS];
new FishCount[MAX_PLAYERS];
new TutTime[MAX_PLAYERS];
new PlayerDrunk[MAX_PLAYERS];
new PlayerDrunkTime[MAX_PLAYERS];
new PlayerTazeTime[MAX_PLAYERS];
new FindTimePoints[MAX_PLAYERS];
new FindTime[MAX_PLAYERS];
new BoxWaitTime[MAX_PLAYERS];
new BoxOffer[MAX_PLAYERS];
new CarOffer[MAX_PLAYERS];
new CarID[MAX_PLAYERS];
new CarCalls[MAX_PLAYERS];
new GotHit[MAX_PLAYERS];
new GoChase[MAX_PLAYERS];
new GetChased[MAX_PLAYERS];
new OrderReady[MAX_PLAYERS];
new ConnectedToPC[MAX_PLAYERS];
new MedicTime[MAX_PLAYERS];
new NeedMedicTime[MAX_PLAYERS];
new MedicBill[MAX_PLAYERS];
new PlayerTied[MAX_PLAYERS];
new PlayerTiedTime[MAX_PLAYERS];
new LiveOffer[MAX_PLAYERS];
new TalkingLive[MAX_PLAYERS];
new SelectChar[MAX_PLAYERS];
new SelectCharID[MAX_PLAYERS];
new SelectCharPlace[MAX_PLAYERS];
new ChosenSkin[MAX_PLAYERS];
new GettingJob[MAX_PLAYERS];
new ApprovedLawyer[MAX_PLAYERS];
new CallLawyer[MAX_PLAYERS];
new WantLawyer[MAX_PLAYERS];
new MoneyMessage[MAX_PLAYERS];
new Condom[MAX_PLAYERS];
new SexOffer[MAX_PLAYERS];
new SexPrice[MAX_PLAYERS];
new pSessionStart[MAX_PLAYERS] = {0, ...}; // czas wbicia gracza na serwer

//---------------
new SmugglingOffer[MAX_PLAYERS];
new SmugglingOfferPrice[MAX_PLAYERS];
new SmugglingOfferItem[MAX_PLAYERS];
new RepairOffer[MAX_PLAYERS];
new RepairPrice[MAX_PLAYERS];
new RefillOffer[MAX_PLAYERS];
new RefillPrice[MAX_PLAYERS];
new RepairCar[MAX_PLAYERS];
new DrugOffer[MAX_PLAYERS];
new DrugPrice[MAX_PLAYERS];
new DrugGram[MAX_PLAYERS];
new ContrabandOffer[MAX_PLAYERS];
new ContrabandCount[MAX_PLAYERS];
new ContrabandPrice[MAX_PLAYERS];
new JailPrice[MAX_PLAYERS];
new WynajemOffer[MAX_PLAYERS];
new DomOffer[MAX_PLAYERS];
new DomCena[MAX_PLAYERS];
new wywalzdmv[MAX_PLAYERS];
new poscig[MAX_PLAYERS];
new PoziomPoszukiwania[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new OnDutyCD[MAX_PLAYERS];
new SecretAgent[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new gPlayerLogTries[MAX_PLAYERS];
new gPlayerSpawned[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new gOoc[MAX_PLAYERS];
new gMuteDepo[MAX_PLAYERS];
new gCrime[MAX_PLAYERS];
new gBW[MAX_PLAYERS];
new gNewbie[MAX_PLAYERS];
new gNews[MAX_PLAYERS];
new gFam[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new DeathWarning[MAX_PLAYERS];
new GUIExit[MAX_PLAYERS];
new Spectate[MAX_PLAYERS];
new Float:SpectateTime[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new StartTime[MAX_PLAYERS];
new HireCar[MAX_PLAYERS];
new BiletAlhambra[MAX_PLAYERS];
new HidePM[MAX_PLAYERS];
new PhoneOnline[MAX_PLAYERS];
new LastSMSNumber[MAX_PLAYERS];
new gDice[MAX_PLAYERS];
new gGas[MAX_PLAYERS];
new FirstSpawn[MAX_PLAYERS];
new Fixr[MAX_PLAYERS];
new Locator[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new Callin[MAX_PLAYERS];
new Kredyty[MAX_PLAYERS];
new RingTone[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new gPlayerMission[MAX_PLAYERS];
new vKickEx[MAX_PLAYERS];
new newbie = 1;
new noooc = 1;
new adds = 1;
new dmv;
new doorFBIStatus=1;
new drukarnia;
new studiovic;
new studiog;
new studion;
new biurosan;
new reflektor;
new rexl;
new addtimer = 60000;
new Float:stareVHP[MAX_PLAYERS];//zapis uszkodzen
new SANradio = 0;
new KLUBOWEradio = 0;
new Text3D:KLUBOWE3d;
new Text3D:SAN3d;
new Text3D:NapislotLS1, Text3D:NapislotLS2, Text3D:NapislotLV1, Text3D:NapislotSF1;
new SANrepertuar[128];
new KLUBOWErepertuar[128];
new Float:SANzasieg, Float:SANx, Float:SANy, Float:SANz;
new Float:KLUBOWEzasieg, Float:KLUBOWEx, Float:KLUBOWEy, Float:KLUBOWEz;
//kubi
new RadioSANUno[128];
new RadioSANDos[128];
new kosztbiletu;
new osoby;
new planeisstopped;
new Wodliczanie;
new Float:MatsPoint[3] = {2138.2078,-2290.4888,20.6646};
new Float:MatsPointVC[3] = {-4116.5503,3196.7097,5.2720};

//stary komisariat (old komi)
new DrzwiPDKomi;
new DrzwiPDKomi2;
new DrzwiPDKomi3;
new DrzwiPDKomiS = 1;
new DrzwiPDKomi2S = 1;
new DrzwiPDKomi3S = 1;
new DrzwiPDKomi4;
new DrzwiPDKomi4S = 1;
//nowy komisariat
new stolek[34];
new kosmove;//zmienne bram konfesjona³ów
new kos2move;//zmienne bram konfesjona³ów
new kos;//zmienne bram konfesjona³ów
new kos2;//zmienne bram konfesjona³ów
//koniec nowego komi
new Izba;
new IzbaState = 1;
new BramaCortez;
new BramaCortezS = 1;
new BramaHA;
new BramaHAS = 1;
new BrF[8];
new BrFS[8];
new TimerJedzenie[MAX_PLAYERS];
new ZarcieCooldown[MAX_PLAYERS];

new const AnimLibs[][] = {
  "AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
  "BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
  "BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
  "BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
  "BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
  "CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
  "COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
  "DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
  "DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
  "FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
  "FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
  "GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
  "GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
  "INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
  "KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
  "MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
  "MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
  "PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
  "POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
  "QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
  "ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
  "SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
  "SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
  "STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
  "SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
  "TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
  "WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};


//new BramaWDolS = 1;
//fbi
new FBIdrzwi3;
new FBIdrzwi4;
new FBIdrzwi7;
new FBImove2 = 0;
new FBImove3 = 0;
new FBImove5 = 0;
new Celaki[3];

new timeSecWjedz[MAX_PLAYERS];

//koniecfbi
//brama baysie by micha³
new BramaBaySide;
new BramaBaySideS = 1;
//new BramaAlhambra;
//new BramaAlhambraS = 1;

//dla nowej alhambry
new bramka[7];
new windka;
new movegate[3];

//WPS klu bonehead
new SkinBrama[3];
new SkinBramaMove[3];

//brama ¿u¿el by micha³
new BramaZuz;
new BramaZuzS = 1;
//koniec garazpd
//inne
new MyWeapon[MAX_PLAYERS];
new ZapisSkinu[MAX_PLAYERS];
new PDGPS = -1;//gps
//koniec przedmioty
new Respawn[MAX_PLAYERS];//respawn
//timery
new Text3D:Busnapisn[30]; //Napisy komuniakcji miejskiej
//koniec autobusy
//ruchome obiekty
new BramaLCN;
new BramaLCN2 = 1;
new WindaYKZ;
new WindaYKZ2 = 0;
new WindaYKZKrata;
new WindaYKZKratas = 1;
new STREAMER_TAG_3D_TEXT_LABEL:okienko[17];

new bramadmv[19];
new movedmv[20];
new bramadom1;
new bramadom1State = 1;//brama NoA
//urzad miasta by abram01 - SIMEONE EDIT
new urzad;
new urzad1;
new urzad2;
new urzad3;

new dudmv3;
new dudmv4;

new BramaKomiCela;  //stary komisariat (old komi)
new BramaKomiCelaS = 1;
//koniec ruchome obiekty
new spamwl[MAX_PLAYERS];
new poddaje[MAX_PLAYERS];//poddaje siê
new lowcap[MAX_PLAYERS];//³owca nagród który proponowa³ poddanie siê
new lowcaz[MAX_PLAYERS];//³owca nagród dostaje zlecenie
new okradziony[MAX_PLAYERS];//zabierzportfel
new IDDomu[MAX_PLAYERS];//SYSTEM DOMÓW
new MatsGood[MAX_PLAYERS];
new KradniecieWozu[MAX_PLAYERS];
new AntyBH = 1;//Anty BH
new antyczolg[MAX_PLAYERS];//Anty Czo³g
new NieSpamujKradnij[MAX_PLAYERS];//Anty BH
new pojazdid[MAX_PLAYERS];//SYSTEM AUT
new CenaPojazdu[MAX_PLAYERS];//SYSTEM AUT
new KolorPierwszy[MAX_PLAYERS];//SYSTEM AUT
new CenaDawanegoAuta[MAX_PLAYERS];//SYSTEM AUT
new CenaWymienianegoAuta[MAX_PLAYERS];//SYSTEM AUT
new IDWymienianegoAuta[MAX_PLAYERS];//SYSTEM AUT
new CenaDawanegoLodz[MAX_PLAYERS];//SYSTEM AUT
new CenaDawanegoSamolot[MAX_PLAYERS];//SYSTEM AUT
new GraczDajacy[MAX_PLAYERS];//SYSTEM AUT
new GraczWymieniajacy[MAX_PLAYERS];//SYSTEM AUT
new IDAuta[MAX_PLAYERS];//SYSTEM AUT
new GraczDajacyLodz[MAX_PLAYERS];//SYSTEM AUT
new IDLodzi[MAX_PLAYERS];//SYSTEM AUT
new GraczDajacySamolot[MAX_PLAYERS];//SYSTEM AUT
new IDSamolotu[MAX_PLAYERS];//SYSTEM AUT
new CenaWymiany[MAX_PLAYERS];//SYSTEM AUT
new GraczWymiany[MAX_PLAYERS];//SYSTEM AUT

new IloscAut[MAX_PLAYERS];//SYSTEM AUT
new GraczDajacyNeon[MAX_PLAYERS];//NEONY
new IDBroniZbrojownia[MAX_PLAYERS];//ALL W GUI
new weryfikacja[MAX_PLAYERS];//ANTY HACKED
new iddialog[MAX_PLAYERS];//ANTY HACKED
new antyHider[MAX_PLAYERS];
new taxitest[MAX_PLAYERS];//Taxi Test
new mechanikid[MAX_PLAYERS];//Mechanik w GUI
new naprawiony[MAX_PLAYERS];//Napr


new zawodnik[MAX_PLAYERS];//¯u¿el
new wyscigz;//¿u¿el
new iloscwygranych;//¿u¿el
new komentator[MAX_PLAYERS];//¯u¿el
new okrazenia[MAX_PLAYERS];//¯u¿el
new okregi[MAX_PLAYERS];//¯u¿el
// worek
new Worek_Uzyty[MAX_PLAYERS];
new Worek_MamWorek[MAX_PLAYERS];
new Worek_KtoZalozyl[MAX_PLAYERS];
new Worek_KomuZalozylem[MAX_PLAYERS];
//cmd obrazenia
new ObrazeniaIndex[MAX_PLAYERS];
new ObrazeniaZadaneIndex[MAX_PLAYERS];
new Obrazenia[MAX_PLAYERS][20][eOBRAZENIA];
new ObrazeniaZadane[MAX_PLAYERS][20][eOBRAZENIAZADANE];
new SpamujeMechanik[MAX_PLAYERS];//mechanik
new AntySpam[MAX_PLAYERS];
new OdpalanieSpam[MAX_PLAYERS];//OdpalanieSpam
new DomOgladany[MAX_PLAYERS];//SYSTEM DOMÓW BY MRUCZNIK
new cbjstore[128];
new motd[256];
new ghour = 0;
new gminute = 0;
new gsecond = 0;
new dollah = 1000; // Amount player recieves on spawn.
new realtime = 1;
new wtime = 15;
new levelexp = 4;
new levelcost = 10000;
new callcost = 5; //1 second
new realchat = 1;
new timeshift = -1;
new shifthour;

new Float:PlayerPos[MAX_PLAYERS][6];
new Float:TeleportDest[MAX_PLAYERS][3];

new Float:OldCoordsX[MAX_PLAYERS], Float:OldCoordsY[MAX_PLAYERS];

new Gas[CAR_AMOUNT];
new Refueling[MAX_PLAYERS];
new Naprawiasie[MAX_PLAYERS];

new TiPJTGBKubi[MAX_PLAYERS];
new CenaBiletuPociag = 10000;
// new DCC_Channel:g_SanNewsChannelId, DCC_Channel:g_AdminChannelId[17], DCC_Channel:g_AdminChannelIdDefault, DCC_Channel:g_ReportChannelId; //discordconnect
// new DCC_Channel:g_FracChannel[MAX_FRAC];
// new DCC_Channel:g_OrgChannel[MAX_ORG];
// new DCC_Channel:g_GSLSLOGChannelId, DCC_Channel:g_GSCMLOGChannelId, DCC_Channel:g_GSWFLOGChannelId;
new AllLeaders; 
new playerTargetSpec[MAX_PLAYERS];
new playerSeeSpec[MAX_PLAYERS];
//SANDAL
new gRO[MAX_PLAYERS];
new isNaked[MAX_PLAYERS];
new Vector:VMembersOrg[MAX_PLAYERS]; // /pr members
new areVehicleDescTurnedOn[MAX_PLAYERS] = {true, ...};
new arePlayerDescTurnedOn[MAX_PLAYERS] = {true, ...};
new ZasluzeniON = true;

new Float:ShopPickupsPos[][3] = {
	{207.5669, -100.3860, 1005.2578}, // binco ls
	{161.3583, -83.6028, 1001.8047}, // zip ls
	{206.3739, -8.1625, 1001.2109}, // victim ls
	{206.9117, -129.4907, 1003.5078}, // prolabs
	{203.8627, -43.8014, 1001.8047}, // sub urban
	{204.1287, -159.6113, 1000.5234} // didier sachs
};
new ShopPickups[sizeof(ShopPickupsPos)];
new scm_buf[144];

new kicking[MAX_PLAYERS];
new kickReason[MAX_PLAYERS][128];

//-----------------------------------------------
//------------[Funkcje:]-------------------------
//-----------------------------------------------
ClearVariableConnect(playerid)
{
	OfferPlayer[playerid] = -1;//Prawnik oferuje /uwolnij (Check)
	PlayerInfo[playerid][pBiletpociag] = 0;//Bilet do poci¹gu
	playerTargetSpec[playerid] = INVALID_SPECTATE_ID;
	playerSeeSpec[playerid] = INVALID_SPECTATE_ID; 
	isNaked[playerid] = 0; 
	return 1;
}
ClearVariableDisconnect(playerid)
{
	OfferPlayer[playerid] = -1;//Prawnik oferuje /uwolnij (Check)
	SN_ACCESS[playerid] = 0;//Pozwolenie na scenê (pobór op³at - 2kk)
	return 1;
}
ZerujZmienne(playerid)
{
    SetPVarInt(playerid, "budka-Mobile", 999);
    SetPVarInt(playerid, "budka-used", 999);
    SetPVarInt(playerid, "prawnik-oferuje", 999);
    SetPVarInt(playerid, "wizytowka", -1);
	SetPVarInt(playerid, "zoneid", -1);
	DeletePVar(playerid, "DostalAJkomunikat");
	SetPVarString(playerid, "trescOgloszenia", "null"); 
	SetPVarInt(playerid, "FixKitOffer", -1);
	SetPlayerDrunkLevel(playerid, 0);
	ibiza_clearCache(playerid);
    premium_clearCache(playerid);
	//z disconecta

	timeFakeVehRespawn[playerid] = 0;
	countFakeVehRespawn[playerid] = 0;


	PlayerInfo[playerid][pUID] = 0;
    PlayerInfo[playerid][pDesc][0] = EOS;
	StaryCzas[playerid] = GetTickCount();
	zawodnik[playerid] = 0;//¯u¿el
	komentator[playerid] = 0;//¯u¿el
	okrazenia[playerid] = 0;//¯u¿el
	okregi[playerid] = 0;//¯u¿el
	SpamujeMechanik[playerid] = 0;//mechanik
	AntySpam[playerid] = 0;
	CenaDawanegoAuta[playerid] = 0;
	GraczWymiany[playerid] = 999;
	CenaWymiany[playerid] = 0;
	PlayerInfo[playerid] [pBiletsamolotowy] = 0;
 	PlayerInfo[playerid] [pWsamolocieLS] = 0;
 	PlayerInfo[playerid] [pWlociej] = 0;
 	PlayerInfo[playerid] [pMozeskakacAT] = 0;
 	PlayerInfo[playerid] [pRockHotelLiAc] = 0;
 	PlayerInfo[playerid] [pRockHotelPuAc] = 0;
	PlayerTied[playerid] = false;
	PlayerTiedTime[playerid] = 0;
	
	gRO[playerid] = 0;
	
	
    lastMsg[playerid] = 0;

	PlayerSlapperWarning[playerid] = 0;

	//z conecta
	TogPodglad[playerid] = 0;
	TazerAktywny[playerid] = 0; MaTazer[playerid] = 0; DodatkiPD[playerid] = 0;
	cbradijo[playerid] = 0; adminpodgladcb[playerid] = 0; matogczas[playerid] = 0;
	dajeKontrakt[playerid] = 9999;
	SelectChar[playerid] = 0; HidePM[playerid] = 0; PhoneOnline[playerid] = 0; LastSMSNumber[playerid] = 0; spamwl[playerid] = 0; okradziony[playerid] = false;
	SelectCharID[playerid] = 0; SelectCharPlace[playerid] = 0; ChosenSkin[playerid] = 0;
	GettingJob[playerid] = 0;
    ApprovedLawyer[playerid] = 0; CallLawyer[playerid] = 0; WantLawyer[playerid] = 0; UsedFind[playerid] = 0;
	ScigaSie[playerid] = 666;
	CarOffer[playerid] = 999; CarID[playerid] = 0; CarCalls[playerid] = 0; GraczDajacy[playerid] = 999; GraczDajacyNeon[playerid] = 999;
	MoneyMessage[playerid] = 0; Condom[playerid] = 0; GraczDajacyLodz[playerid] = 999; IDAuta[playerid] = 0; //JaKupuje[playerid] = 0; JaWymieniam[playerid] = 0;
	SexOffer[playerid] = 999; SexPrice[playerid] = 0; GraczDajacySamolot[playerid] = 999; IDLodzi[playerid] = 0; IDSamolotu[playerid] = 0;
	RepairOffer[playerid] = 999; RepairPrice[playerid] = 0; RepairCar[playerid] = 0; WynajemOffer[playerid] = 999; DomOffer[playerid] = 999; DomCena[playerid] = 0;
	TalkingLive[playerid] = INVALID_PLAYER_ID; LiveOffer[playerid] = 999; TakingLesson[playerid] = 0; CenaDawanegoSamolot[playerid] = 999;
	RefillOffer[playerid] = 999; RefillPrice[playerid] = 0; MapIconsShown[playerid] = 0; CenaDawanegoAuta[playerid] = 999; AntySpam[playerid] = 0; poscig[playerid] = 0;
	DrugOffer[playerid] = 999; CenaDawanegoLodz[playerid] = 999;
	SmugglingOffer[playerid] = 999;
	ContrabandOffer[playerid] = 999; ContrabandCount[playerid] = 0; ContrabandPrice[playerid] = 0;
	DrugPrice[playerid] = 0; OnCK[playerid] = 999; GettingCK[playerid] = 999; OdpalanieSpam[playerid] = 0;
	DrugGram[playerid] = 0; ConnectedToPC[playerid] = 0; OrderReady[playerid] = 0;
	JailPrice[playerid] = 0; MedicTime[playerid] = 0; NeedMedicTime[playerid] = 0; MedicBill[playerid] = 0; GotHit[playerid] = 0;
	GoChase[playerid] = 999; GetChased[playerid] = 999;
	OnDuty[playerid] = 0; OnDutyCD[playerid] = 0; SecretAgent[playerid] = 0; PoziomPoszukiwania[playerid] = 0;
	BoxWaitTime[playerid] = 0; SchoolSpawn[playerid] = 0; iddialog[playerid] = -1;
	weryfikacja[playerid] = 0;
	MedicCallTime[playerid] = 0; MechanicCallTime[playerid] = 0;
	FindTimePoints[playerid] = 0; FindTime[playerid] = 0; JobDuty[playerid] = 0; SanDuty[playerid] = 0; WarningDuty[playerid] = 175; NJDuty[playerid] = 0; DeathWarning[playerid] = 1;
	Mobile[playerid] = INVALID_PLAYER_ID; Callin[playerid] = CALL_NONE; CellTime[playerid] = 0; Music[playerid] = 0; BoxOffer[playerid] = 999; PlayerBoxing[playerid] = 0;
	Spectate[playerid] = INVALID_PLAYER_ID; PlayerDrunk[playerid] = 0; PlayerDrunkTime[playerid] = 0; WnetrzeWozu[playerid] = 0;
	Unspec[playerid][sLocal] = 255; FishCount[playerid] = 0; ZapisSkinu[playerid] = 127;
    AntySpawnBroni[playerid] = 0; AntyWlamSejf[playerid] = 0;
    gLastCar[playerid] = 0; FirstSpawn[playerid] = 0; lowcaz[playerid] = 501;
	gOoc[playerid] = 0; gNews[playerid] = 0; BigEar[playerid] = 0; gDice[playerid] = 0; gFam[playerid] = 0; gNewbie[playerid] = 0;
 	gGas[playerid] = 0; GUIExit[playerid] = 0; gMuteDepo[playerid] = 0;
	gPlayerLogged[playerid] = 0; gPlayerLogTries[playerid] = 0; gPlayerAccount[playerid] = 0;
	gPlayerSpawned[playerid] = 0;
	PlayerTazeTime[playerid] = 0;
	StartTime[playerid] = 0; TicketOffer[playerid] = 999; TicketMoney[playerid] = 0;
	MatsHolding[playerid] = 0; TutTime[playerid] = 0; stareVHP[playerid] = 0;
	gPlayerMission[playerid] = 0; vKickEx[playerid] = 0;
	//BusTime[playerid] = 0; BusTime2[playerid] = 0; BusTime3[playerid] = 0; BusTime4[playerid] = 0; BusTime5[playerid] = 0;//bustime
	//BusTime6[playerid] = 0; BusTime7[playerid] = 0; BusTime8[playerid] = 0; BusTime9[playerid] = 0; BusTime10[playerid] = 0; BusTime11[playerid] = 0; BusTime12[playerid] = 0; BusTime13[playerid] = 0;//bustime
	//BusTime14[playerid] = 0; BusTime15[playerid] = 0; BusTime16[playerid] = 0; BusTime17[playerid] = 0; BusTime18[playerid] = 0; BusTime19[playerid] = 0; BusTime20[playerid] = 0;//bustime
	PlayerInfo[playerid][pCash] = dollah; Respawn[playerid] = 0;//Respawn
	HireCar[playerid] = 0; PlayersChannel[playerid] = 999;
	Locator[playerid] = 0;
	ProposeOffer[playerid] = 999; MarryWitness[playerid] = 999; MarryWitnessOffer[playerid] = 999; MarriageCeremoney[playerid] = 0; ProposedTo[playerid] = 999; GotProposedBy[playerid] = 999; DivorceOffer[playerid] = 999; GraczWymiany[playerid] = 999;
	BiletAlhambra[playerid] = 0;
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pNewAP] = 0;
	PlayerInfo[playerid][pZG] = 0;
	PlayerInfo[playerid][pDonateRank] = 0;
	PlayerInfo[playerid][gPupgrade] = 0;
	PlayerInfo[playerid][pConnectTime] = 0;
	PlayerInfo[playerid][pReg] = 0;
	PlayerInfo[playerid][pSex] = 0;
	PlayerInfo[playerid][pAge] = 0;
	PlayerInfo[playerid][pOrigin] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pAccount] = 0;
	PlayerInfo[playerid][pCrimes] = 0;
	PlayerInfo[playerid][pDeaths] = 0;
	PlayerInfo[playerid][pArrested] = 0;
	PlayerInfo[playerid][pWantedDeaths] = 0;
	PlayerInfo[playerid][pPhoneBook] = 0;
	PlayerInfo[playerid][pLottoNr] = 0;
	PlayerInfo[playerid][pFishes] = 0;
	PlayerInfo[playerid][pBiggestFish] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pPayCheck] = 0;
	PlayerInfo[playerid][pHeadValue] = 0;
	PlayerInfo[playerid][pBP] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pMats] = 0;
	PlayerInfo[playerid][pContraband] = 0;
	PlayerInfo[playerid][pDrugs] = 0;
	PlayerInfo[playerid][pLider] = 0;
	PlayerInfo[playerid][pMember] = 0;
	PlayerInfo[playerid][pOrg] = 0;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pChar] = 0;
	PlayerInfo[playerid][pContractTime] = 0;
	PlayerInfo[playerid][pDetSkill] = 0;
	PlayerInfo[playerid][pSexSkill] = 0;
	PlayerInfo[playerid][pBoxSkill] = 0;
	PlayerInfo[playerid][pLawSkill] = 0;
	PlayerInfo[playerid][pMechSkill] = 0;
	PlayerInfo[playerid][pJackSkill] = 0;
	PlayerInfo[playerid][pCarSkill] = 0;
	PlayerInfo[playerid][pNewsSkill] = 0;
	PlayerInfo[playerid][pDrugsSkill] = 0;
	PlayerInfo[playerid][pCookSkill] = 0;
	PlayerInfo[playerid][pFishSkill] = 0;
	PlayerInfo[playerid][pGunSkill] = 0;
	PlayerInfo[playerid][pSHealth] = 0.0;
	PlayerInfo[playerid][pHealth] = 50.0;
	PlayerInfo[playerid][pPos_x] = 2246.6;
	PlayerInfo[playerid][pPos_y] = -1161.9;
	PlayerInfo[playerid][pPos_z] = 1029.7;
	PlayerInfo[playerid][pInt] = 0;
	PlayerInfo[playerid][pLocal] = 255;
	PlayerInfo[playerid][pSkin] = 136;
	//new randphone = 10000 + random(89999);//minimum 1000  max 9999 //giving one at the start
	PlayerInfo[playerid][pPnumber] = 0;
	PlayerInfo[playerid][pDom] = 0;
	PlayerInfo[playerid][pPbiskey] = 255;
	PlayerInfo[playerid][pWynajem] = 0;
	PlayerInfo[playerid][pCarLic] = 0;
	PlayerInfo[playerid][pFlyLic] = 0;
	PlayerInfo[playerid][pBoatLic] = 0;
	PlayerInfo[playerid][pFishLic] = 0;
	PlayerInfo[playerid][pGunLic] = 0;
	PlayerInfo[playerid][pGun0] = 0;//Piêœæ lub kastet
	PlayerInfo[playerid][pGun1] = 0;//Broñ bia³a
	PlayerInfo[playerid][pGun2] = 0;//Pistolety
	PlayerInfo[playerid][pGun3] = 0;//Shotguny
	PlayerInfo[playerid][pGun4] = 0;//Broñ maszynowa
	PlayerInfo[playerid][pGun5] = 0;//Karabiny
	PlayerInfo[playerid][pGun6] = 0;//Snajperki
	PlayerInfo[playerid][pGun7] = 0;//Ciê¿ka broñ
	PlayerInfo[playerid][pGun8] = 0;//Broñ wybuchowa
	PlayerInfo[playerid][pGun9] = 0;//Sprej/Gasnica/Aparat
	PlayerInfo[playerid][pGun10] = 0;//Nietypowa broñ bia³a
	PlayerInfo[playerid][pGun11] = 0;//Spadochron
	PlayerInfo[playerid][pGun12] = 0;//Detonator
	PlayerInfo[playerid][pAmmo0] = 0;
	PlayerInfo[playerid][pAmmo1] = 0;
	PlayerInfo[playerid][pAmmo2] = 0;
	PlayerInfo[playerid][pAmmo3] = 0;
	PlayerInfo[playerid][pAmmo4] = 0;
	PlayerInfo[playerid][pAmmo5] = 0;
	PlayerInfo[playerid][pAmmo6] = 0;
	PlayerInfo[playerid][pAmmo7] = 0;
	PlayerInfo[playerid][pAmmo8] = 0;
	PlayerInfo[playerid][pAmmo9] = 0;
	PlayerInfo[playerid][pAmmo10] = 0;
	PlayerInfo[playerid][pAmmo11] = 0;
	PlayerInfo[playerid][pAmmo12] = 0;
	PlayerInfo[playerid][pCarTime] = 0;
	PlayerInfo[playerid][pPayDay] = 0;
	PlayerInfo[playerid][pPayDayHad] = 0;
	PlayerInfo[playerid][pCDPlayer] = 0;
	PlayerInfo[playerid][pWins] = 0;
	PlayerInfo[playerid][pLoses] = 0;
	PlayerInfo[playerid][pAlcoholPerk] = 0;
	PlayerInfo[playerid][pDrugPerk] = 0;
	PlayerInfo[playerid][pMiserPerk] = 0;
	PlayerInfo[playerid][pPainPerk] = 0;
	PlayerInfo[playerid][pTraderPerk] = 0;
	PlayerInfo[playerid][pTut] = 0;
	PlayerInfo[playerid][pMissionNr] = 0;
	PlayerInfo[playerid][pWarns] = 0;
	PlayerInfo[playerid][pFuel] = 0;
	PlayerInfo[playerid][pBlock] = 0;
	PlayerInfo[playerid][pCB] = 0;
	PlayerInfo[playerid][pWL] = 0;
	PlayerInfo[playerid][pDowod] = 0;
	PlayerInfo[playerid][pTajniak] = 0;
	PlayerInfo[playerid][pZmienilNick] = 2;
	PlayerInfo[playerid][pWino] = 0;
	PlayerInfo[playerid][pPiwo] = 0;
	PlayerInfo[playerid][pCygaro] = 0;
	PlayerInfo[playerid][pSprunk] = 0;
	PlayerInfo[playerid][pStylWalki] = 0;
	PlayerInfo[playerid][pNewAP] = 0;
	PlayerInfo[playerid][pZG] = 0;
	PlayerInfo[playerid][pBW] = 0;
	//Sandal
	format(PlayerInfo[playerid][pAJreason], MAX_AJ_REASON, "Brak");
	PlayerInfo[playerid][pPodPW] = 0;
	PlayerInfo[playerid][pCruiseController] = 0;
	PlayerInfo[playerid][pFixKit] = 0;
	PlayerInfo[playerid][pTurnedOnCarWithoutCarLic] = 0;
	ZestawNaprawczy_Timer[playerid] = 30;
	ZestawNaprawczy_Warning[playerid] = 0;
	
	
	//Creative
	PlayerInfo[playerid][pInjury] = 0;
	PlayerInfo[playerid][pHealthPacks] = 0;
	MyWeapon[playerid] = 0;
	
	PlayerInfo[playerid][pCzystka] = 0;
	//Kubi
    RADIO_CHANNEL[playerid] = 0.0;
    TOWER_Blocked[playerid] = false;
	PlayerInfo[playerid][pPrawojazdypytania] = 0;
	PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
	PlayerInfo[playerid][pPrawojazdyzleodp] = 0;
	PlayerInfo[playerid][pSprawdzczyzdalprawko] = 0;
	PlayerInfo[playerid][pMinalczasnazdpr] = 0;
	PlayerInfo[playerid][pWtrakcietestprawa] = 0;
	PlayerInfo[playerid][pBiletsamolotowy] = 0;
 	PlayerInfo[playerid][pWsamolocieLS] = 0;
  	PlayerInfo[playerid][pWlociej] = 0;
   	PlayerInfo[playerid][pMozeskakacAT] = 0;
    PlayerInfo[playerid][pRockHotelLiAc] = 0;
    PlayerInfo[playerid][pRockHotelPuAc] = 0;
    PlayerInfo[playerid][pPK] = 0;
    //
	PlayerInfo[playerid][pSpawn] = 0;
    PlayerInfo[playerid][pSpawn] = 0;
	PlayerInfo[playerid][pAuto1] = 0;
	PlayerInfo[playerid][pAuto2] = 0;
	PlayerInfo[playerid][pAuto3] = 0;
	PlayerInfo[playerid][pAuto4] = 0;
	PlayerInfo[playerid][pLodz] = 0;
	PlayerInfo[playerid][pSamolot] = 0;
	PlayerInfo[playerid][pGaraz] = 0;
	//Bilet poci¹gu
	timerTime[playerid] = 0; 

	PlayerInfo[playerid][pKluczeAuta] = 0;
	ClearFishes(playerid);
	ClearMarriage(playerid);

	Driver_ZerujZmienne(playerid);


    grajacy[playerid]=0;
	ObrazeniaIndex[playerid] = 0;
	for(new i = 0; i<10; i++) Obrazenia[playerid][i][DAMAGE] = 0.0;
	if(tworzenietrasy[playerid] != 666)
	{
	    format(Wyscig[tworzenietrasy[playerid]][wOpis], 50, "");
     	format(Wyscig[tworzenietrasy[playerid]][wNazwa], 20, "");
		Wyscig[tworzenietrasy[playerid]][wStworzony] = 0;
      	Wyscig[tworzenietrasy[playerid]][wTypCH] = 0;
       	Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 0;
        tworzenietrasy[playerid] = 666;
	}
	owyscig[playerid] = 666;
	ACCESS[playerid]=0b0;
	OLD_ACCESS[playerid]=0b0;

	Zone_ClearVariables(playerid);

    ToggleSpeedo[playerid] = false;
    ToggleSpeedoGPS[playerid] = false;

    Unspec[playerid][Coords][0] = 0.0;
    Unspec[playerid][Coords][1] = 0.0;
    Unspec[playerid][Coords][2] = 0.0;
    Unspec[playerid][sPint] = 0;
    Unspec[playerid][sPvw] = 0;


    noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
    noclipdata[playerid][fireobject]    = 0;

    PlayerInfo[playerid][pCarSlots] = 4;

    PlayerMC[playerid] = 0;

	ParachuteHit[playerid] = 0;
	new nick[32];
	if(GetPVarString(playerid, "maska_nick", nick, 24))
	{
		SetPlayerName(playerid, nick);
		SetRPName(playerid);
		format(PlayerInfo[playerid][pNick], 24, "%s", nick);
		DeletePVar(playerid, "maska_nick");
	}

    for(new i=0;i<MAX_CAR_SLOT;i++) PlayerInfo[playerid][pCars][i] = 0;

    strdel(PlayerDesc[playerid], 0, 128 char);
    strpack(PlayerDesc[playerid], "BRAK");

	foreach(new v : Vehicle) 
	{
		unoccupiedVehToCheckPlayersAC[v][playerid] = false;
	}
	unoccupiedVehBlockAC[playerid] = false;

	foreach(new p : Player)
	{
		Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerInfo[p][pDescLabel], E_STREAMER_PLAYER_ID, playerid);
	}
	foreach(new v : Vehicle)
    {
        if(Car3dTextDesc[v] == Text3D:INVALID_3DTEXT_ID)
        {
            continue;
        }
		Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[v], E_STREAMER_PLAYER_ID, playerid);
    }

	areVehicleDescTurnedOn[playerid] = true;
	arePlayerDescTurnedOn[playerid] = true;

	foreach(new p : Player)
	{
		Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerInfo[p][pDescLabel], E_STREAMER_PLAYER_ID, playerid);
	}
	foreach(new v : Vehicle)
    {
        if(Car3dTextDesc[v] == Text3D:INVALID_3DTEXT_ID)
        {
            continue;
        }
		Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[v], E_STREAMER_PLAYER_ID, playerid);
    }

	areVehicleDescTurnedOn[playerid] = true;

	VECTOR_clear(VMembersOrg[playerid]);

	//caluj
	kissPlayerOffer[playerid] = INVALID_PLAYER_ID;

	pSessionStart[playerid] = 0;
	
	return 1;
}
//EOF
