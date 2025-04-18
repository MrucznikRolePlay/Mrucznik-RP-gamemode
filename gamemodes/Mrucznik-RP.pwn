//-----------------------------------------[Mapa Mrucznik Role Play]-----------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//---------------------------------(Stworzona na podstawie mapy The Godfather)-------------------------------//
//-------------------------------------------------(v2.8)----------------------------------------------------//
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
/*

Mrucznik® Role Play ----> stworzy³ Mrucznik
	Inni developerzy:
		Kubi - zwyk³y skurwysyn
		Akil - chyba nic nie zrobi³ koniec koñców
		Veroon - porobi³ porobi³ i uciek³ :(
		Niceczlowiek - okry³ siê hañb¹ publikuj¹c mapê
		PECET - dobry skrypter
		LukeSqly - Niby coœ zacz¹³, ale wysz³o jak zwykle
		Simeone - Kox przez x
		Creative - mo¿liwe ¿e coœ potrafi
		Sanda³ - skleci³ modu³ animacji
*/
//----------------------------------------------------*------------------------------------------------------//

#pragma compress 0

//const correctness off - how to fix: https://github.com/pawn-lang/YSI-Includes/commit/ab75ea38987e6a7935aa3100eba5284cb3d706e1
#pragma warning disable 239
#pragma warning disable 214
#pragma warning disable 213 // disable required bool: prefix for booleans

// more dynamic memory, default 65536
#define DYNAMIC_MEMORY (1048576)

//-------------------------------------------<[ Biblioteki ]>------------------------------------------------//
//-                                                                                                         -//
#include <a_samp>
#define FIX_ispacked 0 
#define FIX_OnClientCheckResponse 0
#define FIXES_OneRandomVehicleColour 1
#include <fixes>

//-------<[ Pluginy ]>-------
#include <crashdetect>
#include <log-plugin>
#include <sscanf2>
#include <libRegEx>
#include <streamer>
#include <mysql_R5>
//#include <a_mysql> TODO: replace R5 plugin
#include <whirlpool>
#include <timestamptodate>
#include <discord-connector>
#include <memory>
#include <profiler_plugin>
//TODO: add plugins
// actors https://github.com/Dayrion/actor_plus
// #include <PawnPlus>
#include <requests>
#include <redis>

//-------<[ Include ]>-------
#include <a_http>
#include <strlib_fix>
#include <callbacks>
#include <utils>
#define YSI_NO_MASTER
#include <YSI_Data\y_iterate>
#define Y_COMMANDS_USE_CHARS
#define MAX_COMMANDS 1500
#include <YSI\y_commands>
#include <YSI\y_groups>
#include <YSI\y_hooks>
#include <YSI\y_bintree>
#include <YSI\y_master>
#include <YSI\y_timers>
#include <amx_assembly\addressof>
//redefinition from y_playerarray.inc
#undef PlayerArray

#define MAX_CA_OBJECTS 100000
#include <colandreas>
#define MAX_DYNAMIC_OBJECTS 100000
#include <colandreas_streamer_integrate>

#include <sort-inline>
//nex-ac settings
#define AC_MAX_CONNECTS_FROM_IP		3
#define AUTOSAVE_SETTINGS_IN_CONFIG true
#define AC_USE_TUNING_GARAGES false
#define AC_USE_PICKUP_WEAPONS false
#define AC_USE_AMMUNATIONS false
#define AC_USE_RESTAURANTS false
#define AC_USE_CASINOS false
#include <progress2>
#include <Pawn.RakNet>
#include <nex-ac>
#include <md5>
#include <double-o-files2>
#include <dialogs>
#include <fadescreen>
#include <timestamp>
#include <true_random>
#include <PreviewModelDialog>
#include <vector>
#include <map>
#include <list>
#include <mapfix>
#include <getvehiclerotationquat_fix>
#include <ndialog-pages>
#include <modelsizes>
#include <weapon-data>
#define CAMSEQ_DEBUG true
#include <camera-sequencer>

//--------------------------------------<[ G³ówne ustawienia ]>----------------------------------------------//
//-                                                                                                         -//
#include "VERSION.pwn"
#define DEBUG_MODE 0 //1- DEBUG_MODE ON | 0- DEBUG_MODE OFF
#define RESOURCES_LINK "http://146.59.108.84:8100/"

#if !defined gpci
native gpci (playerid, serial [], len);
#endif

//-----------------------------------------<[ Modu³y mapy ]>-------------------------------------------------//
//-                                                                                                         -//
// #include "26modules\modules.pwn"

//-------<[ System ]>-------
#include "system\definicje.pwn"
#include "system\kolory.pwn"
#include "system\forward.pwn"
#include "system\textdraw.pwn"
#include "system\enum.pwn"
#include "system\zmienne.pwn"
#include "system\hooks.pwn"

//do implementacji w g³ówny kod (mo¿liwie w modu³y)
#include "system\doimplementacji\vinylscript.pwn"

//-------<[ Niceczlowiek ]>-------
#include "old_modules\niceczlowiek\general.pwn"
#include "old_modules\niceczlowiek\dynamicgui.pwn"
#include "old_modules\niceczlowiek\noysi.pwn"
#include "old_modules\niceczlowiek\script_wybieralka.pwn"

//-------<[ 3.0 style ]>-------
#include "modules\modules.pwn"

//-------<[ MySQL ]>-------
#include "mysql\mru_mysql.pwn"
#include "mysql\mysql_komendy.pwn"
#include "mysql\mysql_noysi.pwn"
#include "mysql\mysql_OnDialogResponse.pwn"

//-------<[ Funkcje ]>-------
#include "system\funkcje.pwn"

//-------<[ Timery ]>-------
#include "system\timery.pwn"

//-------<[ NPC ]>-------
#include "system\npc.pwn"

//-------<[ Obiekty ]>-------
#include "obiekty\obiekty.pwn"
#include "obiekty\pickupy.pwn"
#include "obiekty\3dtexty.pwn"
#include "obiekty\ikony.pwn"
#include "obiekty\actorsOnWorld.pwn"
#include "obiekty\colandreas_removebuildings.pwn"

//-------<[ Dialogi ]>-------
#include "dialogs\OnDialogResponse.pwn"

//------------------------------------------------------------------------------------------------------
main()
{
	print("\n----------------------------------");
	print("M | --- Mrucznik Role Play --- | M");
	print("R | ---        ****        --- | R");
	print("U | ---        v2.8        --- | U");
	print("C | ---        ****        --- | C");
	print("Z | ---    by Mrucznik     --- | Z");
	print("N | ---                    --- | N");
	print("I | ---       /\\_/\\      --- | I");
	print("K | ---   ===( *.* )===    --- | K");
	print("  | ---       \\_^_/       --- |  ");
	print("R | ---         |          --- | R");
	print("P | ---         O          --- | P");
	print("----------------------------------\n");
	
	AntiDeAMX(); // Can't touch this
}
//------------------------------------------------------------------------------------------------------

//---------------------------<[  Callbacks   ]>--------------------------------------------------

public OnGameModeInit()
{
	//-------<[ Debug check ]>-------
	if(IsAProductionServer())
	{
		strcat(ServerSecret, dini_Get("production.info", "secret"));
		if(isnull(ServerSecret)) {
			strcat(ServerSecret, "0vw954jtw598t9d");
		}
		#if DEBUG_MODE == 1
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		print("Wersja debug na produkcji!! Wylaczam serwer.");
		SendRconCommand("exit");
		return 0;
		#endif
	}
	else
	{
		DEVELOPMENT = true;
		strcat(ServerSecret, "0tw954jtw598t9d");
	}

	//-------<[ Anty DeAMX ]>-------
	AntiDeAMX(); // Hammer time

	//-------<[ SAMP config ]>-------
	SetGameModeText("Mrucznik-RP "VERSION);

	//-------<[ Gameplay config ]>-------
    SetWeatherEx(3);
	AllowInteriorWeapons(1); //broñ w intkach
	ShowPlayerMarkers(0); //wy³¹czenie markerów graczy
	DisableInteriorEnterExits(); //wy³¹czenie wejœæ do intków z GTA
	EnableStuntBonusForAll(0); //brak hajsu za stunty
	ManualVehicleEngineAndLights(); //brak automatycznego w³¹czania silnika i œwiate³
	ShowNameTags(1); //Pokazywanie nicków graczy
	SetNameTagDrawDistance(70.0); //Wyœwietlanie nicków od 70 metrów
	//UsePlayerPedAnims(); // Animacja CJ 
		// - off (broñ trzymana w obu rêkach jest trzymana jedn¹, skiny chodz¹ swoim chodem)
		// - on  (broñ trzymana jest normalnie, wszystkie skiny chodz¹ jak CJ)

	//-------<[ libRegEx ]>-------
	regex_syntax(SYNTAX_PERL);
	
	//-------<[ sscanf ]>-------
	SSCANF_Option(OLD_DEFAULT_NAME, 1);

	//-------<[ streamer ]>-------
    Streamer_SetVisibleItems(0, 999);
    Streamer_SetTickRate(50);

	//-------<[ MySQL ]>-------
	MruMySQL_Connect();//mysql
	MruMySQL_IloscLiderowLoad();
	
	
	DefaultItems_LicenseCost();

	//-------<[ Redis ]>-------
	ConnectToRedis();

	// -------<[ ColAndreas ]>-------
	printf("ColAndreas - usuwanie budynkow i inicjalizacja mapy.");
	ColAndreas_UsunBudynki();
	ViceCity_AddCollisions();
	CA_Init();

	//-------<[ modules ]>-------
    systempozarow_init();
    NowaWybieralka_Init();
	LoadBusiness(); 
	LoadBusinessPickup(); 	
    LoadOrganisations();
	LoadFrontBusinesses(); // must be after LoadOrganisations
	InitializeJobs();
	CreateRandomContrabandBoxes();
	LoadBusRoutes();

	//-------<[ actors ]>-------
	PushActors(); 
	LoadActors();

	//Config
	LoadConfig();

	//Old Groups - to remove \/
    WczytajRangi();
    WczytajSkiny();

    BARIERKA_Init();

	obiekty_OnGameModeInit();

    ZaladujDomy();
    Zone_Load();

    ZaladujTrasy(); //System wyœcigów
	ZaladujPickupy();
	CreateFakePayNSprayPickups();
	InitializeFoodPlaces();
	InitializeDrugsPickup();
	CreateShopPickups();
	CreateShippingPlacePickups();
	ZaladujSamochodyDoKradziezy(); //Auta do kradziezy
	LoadDeluxeCarsForStealing(); //Auta deluxe do kradziezy
	Zaladuj3DTexty();
	ZaladujIkony();

	//GF:
	LoadBoxer();
	LoadStuff();
	LoadIRC();

	LadujInteriory();

    //Sejfy mysql
    Sejf_Load();

    //Ibiza
    IBIZA_Reszta();

    //Patrol Data
    Patrol_Init();
    LoadServerInfo(); //Informacja dla graczy np. o wylaczeniu czegos

    //13.06
    LoadTXD();
    //30.10
    TJD_Load();
    Car_Load(); //Wszystkie pojazdy MySQL

    //noYsi
    LoadPrzewinienia();
	
	graffiti_LoadMySQL();
	//discordconnect
	DiscordConnectInit();

	LoadGsPanelPrices();


	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		afk_timer[i] = -1;
	}

	for(new c=0;c<CAR_AMOUNT;c++)
	{
		Gas[c] = GasMax;
        SetVehicleParamsEx(c, 0, 0, 0, 0, 0, 0, 0);
	}
	IRCInfo[0][iPlayers] = 0; IRCInfo[1][iPlayers] = 0; IRCInfo[2][iPlayers] = 0;
	IRCInfo[3][iPlayers] = 0; IRCInfo[4][iPlayers] = 0; IRCInfo[5][iPlayers] = 0;
	IRCInfo[6][iPlayers] = 0; IRCInfo[7][iPlayers] = 0; IRCInfo[8][iPlayers] = 0;
	IRCInfo[9][iPlayers] = 0;
	News[hTaken1] = 0; News[hTaken2] = 0; News[hTaken3] = 0; News[hTaken4] = 0; News[hTaken5] = 0;

    new string[MAX_PLAYER_NAME];
    new string1[MAX_PLAYER_NAME];
	format(string, sizeof(string), "Nothing");
	strmid(News[hAdd1], string, 0, strlen(string), 255);
	strmid(News[hAdd2], string, 0, strlen(string), 255);
	strmid(News[hAdd3], string, 0, strlen(string), 255);
	strmid(News[hAdd4], string, 0, strlen(string), 255);
	strmid(News[hAdd5], string, 0, strlen(string), 255);
	format(string1, sizeof(string1), "Nie Ma");
	strmid(News[hContact1], string1, 0, strlen(string1), 255);
	strmid(News[hContact2], string1, 0, strlen(string1), 255);
	strmid(News[hContact3], string1, 0, strlen(string1), 255);
	strmid(News[hContact4], string1, 0, strlen(string1), 255);
	strmid(News[hContact5], string1, 0, strlen(string1), 255);
	PlayerHaul[78][pCapasity] = 100;
	PlayerHaul[79][pCapasity] = 100;
	PlayerHaul[80][pCapasity] = 50;
	PlayerHaul[81][pCapasity] = 50;
	PlayerHaul[128][pCapasity] = 300;
	PlayerHaul[129][pCapasity] = 300;
	PlayerHaul[130][pCapasity] = 300;

	format(motd, sizeof(motd), "Witaj na serwerze Mrucznik Role Play - %s.", VERSION);
	gettime(ghour, gminute, gsecond);
    GLOB_LastHour=ghour;
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime)
	{
		SetWorldTime(wtime);
		ServerTime = wtime;
	}
	// CreatedCars check
	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
	    CreatedCars[i] = 0;
	}

	// Skiny graczy (wybieralka)
/*	for(new i = 0; i <= sizeof(Peds)-1; i++)
	{
		AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	}*/

	if (realtime)
	{
		new tmphour, tmpminute, tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		SetWorldTime(tmphour);
		ServerTime = tmphour;
	}
	TimeUpdater();
	//timery
	SetTimer("AktywujPozar", 3600_000 * 1, true);//System Po¿arów v0.1 - po¿ar co godzinê
    SetTimer("MainTimer", 1000, true);
	SetTimer("CheckChangeWeapon", 450, true);
    SetTimer("RPGTimer", 100, true);
	//Ustalanie wartoœci wind
	levelLock[FRAC_SN][5]=1;//Zamkniête
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        Blink[i][0] = -1;
        Blink[i][1] = -1;
        Blink[i][2] = -1;
        Blink[i][3] = -1;
    }
    SetTimer("B_TrailerCheck", 1000, 1);

    for(new v = 0; v < CAR_End+1; v++)
	{
		VehicleUID[v][vDist] = 500.000;
		VehicleUID[v][vUID] = 0;
		SetVehicleNumberPlate(v, "{1F9F06}M-RP");
	}

    if((db_handle = db_open("mru.db")) == DB:0)
    {
        // Error
        print("Failed to open a connection to \"mru.db\".");
        print("Wylaczam serwer.... Powod: brak mru.db");
        SendRconCommand("exit");
    }
    else
    {
        // Success
        print("Successfully created a connection to \"mru.db\".");
    }

    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_legal (pID integer,weapon1 integer not null,weapon2 integer not null,weapon3 integer not null,weapon4 integer not null,weapon5 integer not null,weapon6 integer not null,weapon7 integer not null,weapon8 integer not null,weapon9 integer not null,weapon10 integer not null,weapon11 integer not null,weapon12 integer not null,weapon13 integer not null,unique (pID));"));
    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_opisy(uid INTEGER PRIMARY KEY AUTOINCREMENT, text VARCHAR, owner INT, last_used INT);"));
    db_free_result(db_query(db_handle, "CREATE TABLE IF NOT EXISTS mru_kevlar(pID integer, offsetX FLOAT, offsetY FLOAT, offsetZ FLOAT, rotX FLOAT, rotY FLOAT, rotZ FLOAT, scaleX FLOAT, scaleY FLOAT, scaleZ FLOAT);"));

    for(new i;i<MAX_PLAYERS;i++)
    {
        PlayerInfo[i][pDescLabel] = CreateDynamic3DTextLabel(" ", 0xBBACCFFF, 0.0, 0.0, -0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 10.0);
    }

    pusteZgloszenia();
	CreateActorsInDMV(INVALID_PLAYER_ID);

	Log(serverLog, INFO, "Serwer zosta³ pomyœlnie uruchomiony.");
	SendDiscordServerOnInfo();
    print("----- OnGameModeInit done.");
	return 1;
}

public OnGameModeExit()
{
	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(afk_timer[i] != -1)
			KillTimer(afk_timer[i]);
	}
    for(new i=1;i<MAX_ORG;i++)
    {
        SaveOrg(i);
    }
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
	for(new i=1; i<=BusinessLoaded; i++)
	{
		SaveBusiness(i); 
	}
    UnloadTXD();
    Patrol_Unload();
    TJD_Exit();
    
	DestroyGangzones();

    for(new i=0;i<MAX_VEHICLES;i++) DisableCarBlinking(i);
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerTextDrawDestroy(i, gCurrentPageTextDrawId[i]);
        PlayerTextDrawDestroy(i, gHeaderTextDrawId[i]);
        PlayerTextDrawDestroy(i, gBackgroundTextDrawId[i]);
        PlayerTextDrawDestroy(i, gNextButtonTextDrawId[i]);
        PlayerTextDrawDestroy(i, gPrevButtonTextDrawId[i]);

        INT_AirTowerLS_Exit(i, true, true);
    }
    foreach(new i : Player)
    {
        if(noclipdata[i][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(i);
        MruMySQL_SaveAccount(i, true, true);
    }

	DOF2_Exit();
    GLOBAL_EXIT = true;
	SendDiscordServerOffInfo();
	Log(serverLog, INFO, "Serwer zosta³ wy³¹czony.");
    print("----- OnGameModeExit done.");
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new Float:shotX, Float:shotY, Float:shotZ, Float:unused;
	GetPlayerLastShotVectors(playerid, unused, unused, unused, shotX, shotY, shotZ);
	if(GetPVarInt(playerid, "debug-objects") == 1)
	{
		SendClientMessage(playerid, -1, sprintf("Shot at: %.4f, %.4f, %.4f", shotX, shotY, shotZ));
	}
	if(GetPVarInt(playerid, "shooting-object") != 0)
	{
		new Float:rotZ;
		GetPlayerFacingAngle(playerid, rotZ);
		new model = GetPVarInt(playerid, "shooting-object");
		new obj = CreateDynamicObject(model, shotX, shotY, shotZ, 0.0, 0.0, rotZ, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		AppendToPlayerObjectFiles(playerid, obj);
		SendClientMessage(playerid, -1, sprintf("Object id %d created at: %.4f, %.4f, %.4f.", obj, shotX, shotY, shotZ));
		Streamer_Update(playerid);
	}
	if(Driver_OnPlayerShoot(playerid, shotX, shotY, shotZ)) return 1;

	switch (hittype)
	{
		case BULLET_HIT_TYPE_NONE:
		{
			//else
		}
		case BULLET_HIT_TYPE_PLAYER:
		{
			if(!IsPlayerConnected(hitid)) return 0;

			if(MaTazer[playerid] == 1 && (GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24) && TazerAktywny[hitid] == 0 && GetDistanceBetweenPlayers(playerid,hitid) < 11)
			{
				new giveplayer[MAX_PLAYER_NAME];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(hitid, sendername, sizeof(sendername));
				TazerAktywny[hitid] = 1;
				SetTimerEx("DostalTazerem", 30000, false, "i", hitid);
				new string[128];
				GameTextForPlayer(hitid, "DOSTALES TAZEREM! ODCZEKAJ CHWILE!", 3000, 5);
				GameTextForPlayer(playerid, "~g~TRAFILES W GRACZA!~n~~w~TAZER DEZAKTYWOWANY! PRZELADUJ TAZER!", 3000, 5);
				SetPVarInt(playerid, "wytazerowany", 15);
				format(string, sizeof(string), "* %s strzela tazerem w %s.", giveplayer, sendername);
				ProxDetector(30.0, hitid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				MaTazer[playerid] = 0;
				PlayerPlaySound(playerid, 6300, 0.0, 0.0, 0.0);
				PlayerPlaySound(hitid, 6300, 0.0, 0.0, 0.0);
				ApplyAnimation(hitid, "CRACK","crckdeth2",4.1,0,1,1,1,1,1);
				TogglePlayerControllable(hitid, 0);
				return 0;
			}
			else
			{
				if(GetPlayerAdminDutyStatus(hitid) == 1) //zakaz strzelania do admina
				{
					return 0;
				}
				else
				{
					new Float:HP, Float:AP, Float:amount;
					GetPlayerHealth(hitid, HP);
					GetPlayerArmour(hitid, AP);
					if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26 || 
					weaponid == 27 || weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31 || 
					weaponid == 32 || weaponid == 33 || weaponid == 34 || weaponid == 38)
					{
						/* \/ \/ \/ DO NOT TOUCH - sampowe DMG \/ \/ \/ */
						switch(weaponid)
						{
							case 22: //colt
							{
								amount = 8.25;
							}
							case 23: //silenced
							{
								amount = 13.2;
							}
							case 24: //DE
							{
								amount = 46.2;
							}
							case 25, 26, 27: //shotguny
							{
								amount = 30.0;
							}
							case 28, 32: //uzi i tec
							{
								amount = 6.59;
							}
							case 29: //mp5
							{
								amount = 8.25;
							}
							case 30, 31: //ak,m4
							{
								amount = 9.9;
							}
							case 33: //rifle
							{
								amount = 24.8;
							}
							case 34: //sniper
							{
								amount = 41.3;
							}
							case 38: //minigun
							{
								amount = 46.2;
							}
						}
						/* /\ /\ /\ DO NOT TOUCH - sampowe DMG /\ /\ /\ */
						
						if(AP > 0)
						{
							if(AP < amount) SetPlayerArmour(hitid, 0); // tutaj ma zostaæ 0, bo wartosc armora poni¿ej 0 daje 100 armora (samp bug)
							else SetPlayerArmour(hitid, AP-amount); //zabierz sampowe dmg kamizelce
							OnPlayerTakeDamage(hitid, playerid, amount, weaponid, 3);
							return 0;
						}
						
						amount = amount / 2; //CUSTOMOWE DMG (dopiero po wydrenowaniu armora)

						if(HP <= amount) return 1; //wyœlij nabój (zabij)
						SetPlayerHealth(hitid, HP-amount); //lub zabierz mu customowe dmg
						OnPlayerTakeDamage(hitid, playerid, amount, weaponid, 3);
						return 0;
					}
					else
					{
						//others weapons
						return 1;
					}
				}
			}
		}
		case BULLET_HIT_TYPE_VEHICLE:
		{
			if(hitid != INVALID_VEHICLE_ID)
			{
				if(Car_GetOwnerType(hitid) == CAR_OWNER_SPECIAL && Car_GetOwner(hitid) == CAR_SMUGGLING)
				{
					OnPlayerShootSmugglingBoat(playerid, hitid);
				}
			}
		}
		case BULLET_HIT_TYPE_OBJECT:
		{
			//else
		}
		case BULLET_HIT_TYPE_PLAYER_OBJECT:
		{
			//else
		}
	}

    return 1;
}


public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z) 
{
	if(GetPVarInt(playerid, "debug-objects") == 1)
	{
		new str[MAX_MESSAGE_LENGTH], Float:px, Float:py, Float:pz, Float:rx, Float:ry, Float:rz;
		GetDynamicObjectPos(objectid, px, py, pz);
		GetDynamicObjectRot(objectid, rx, ry, rz);
		format(str, sizeof str, "ID: %d | Model: %d | Pos: %.4f, %.4f, %.4f, %.4f, %.4f, %.4f", 
			objectid, GetDynamicObjectModel(objectid), px, py, pz, rx, ry, rz, px + x, py + y, pz + z);
		SendClientMessage(playerid, COLOR_WHITE, str);
	}

	if(Movable_OnPlayerShootObject(playerid, weaponid, objectid)) return 1;
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    NowaWybieralka_ClickedTxd(playerid, clickedid);

    new str[128];
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(GetPVarInt(playerid, "gatechose_active") == 1)  //Barierki
        {
            DestroySelectionMenu(playerid);
			SetPVarInt(playerid, "gatechose_active", 0);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        if(GetPVarInt(playerid, "ng-gatekey") == 1) //NG keypad
        {
            SetPVarInt(playerid, "ng-gatekey", 0);
            TextDrawHideForPlayer(playerid,NG_GateTD[0]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[1]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[2]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[3]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[4]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[5]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[6]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[7]);
            VAR_NGKeypad = false;
        }
    }
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        new ngkey[6];

        GetPVarString(playerid, "ng-key", ngkey, 6);
        if(strlen(ngkey) < 4)
        {
            new num[2];
            format(num, 2, "%d", _:clickedid - _:NG_GateTD[1] + 1);
            strcat(ngkey, num);
            TextDrawSetString(NG_GateTD[7], ngkey);
            SetPVarString(playerid, "ng-key", ngkey);

            if(strlen(ngkey) == 4) NG_OpenGateWithKey(playerid); //apply key
        }
        return 1;
    }
    //IBIZA
    if(clickedid==Text:INVALID_TEXT_DRAW && GetPVarInt(playerid, "IbizaKamery")) //ESC
	{
		for(new i=0; i<3; i++)
			TextDrawHideForPlayer(playerid, TDIbiza[i]);
		PlayerTextDrawHide(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		new Float:x, Float:y, Float:z;
		x = GetPVarFloat(playerid, "IbizaKameraX");
		y = GetPVarFloat(playerid, "IbizaKameraY");
		z = GetPVarFloat(playerid, "IbizaKameraZ");
		SetPlayerPos(playerid, x, y, z);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
        Wchodzenie(playerid);
		DeletePVar(playerid, "IbizaKamery");
		PlayerTextDrawDestroy(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		DeletePVar(playerid, "IbizaCam");
		return 1;
	}
	else
	{
		new kam = GetPVarInt(playerid, "IbizaKamery");
		if(clickedid==TDIbiza[1]) //w prawo
		{
			kam = (kam==12 ? 1 : kam+1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}
		if(clickedid==TDIbiza[2]) //w lewo
		{
			kam = (kam==1 ? 12 : kam-1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}

	}
    //Strefy
    if(clickedid == ZoneTXD[3])
    {
        RunCommand(playerid, "/atakuj",  "");
    }

    if(GetPVarInt(playerid, "patrol-map") == 1 && GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            SendClientMessage(playerid, COLOR_PAPAYAWHIP, "Wybierz region.");
            SelectTextDraw(playerid, 0xD2691E55);
            return 1;
        }
        else
        {
            new pat = GetPVarInt(playerid, "patrol-id"), fnick[2][MAX_PLAYER_NAME+1];
            if((clickedid == PatrolAlfa[0] || clickedid == PatrolAlfa[1]) && Patrolujacych[0] < 4)
            {
                PatrolInfo[pat][patstrefa] = 1;
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[0]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Alfa, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolBeta[0] || clickedid == PatrolBeta[1]) && Patrolujacych[1] < 4)
            {
                PatrolInfo[pat][patstrefa] = 2;
                SendClientMessage(playerid, COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[1]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Beta, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolGamma[0] || clickedid == PatrolGamma[1]) && Patrolujacych[2] < 6)
            {
                PatrolInfo[pat][patstrefa] = 3;
                SendClientMessage(playerid, COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[2]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefê Gamma, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolDelta[0] || clickedid == PatrolDelta[1]) && Patrolujacych[3] < 6)
            {
                PatrolInfo[pat][patstrefa] = 4;
                SendClientMessage(playerid, COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siê w to miejsce i pamiêtaj o kodach radiowych!");
                Patrolujacych[3]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} 10-30 na strefê Delta, sk³ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else SendClientMessage(playerid, COLOR_YELLOW, "Brak wolnego miejsca w tej strefie, spróbuj inn¹.");
            if(PatrolInfo[pat][patstrefa] != 0)
            {
                PatrolInfo[pat][pataktywny] = 1;
                Patrol_HideMap(playerid);
                CancelSelectTextDraw(playerid);
                SetPVarInt(playerid, "patrol-map", 0);
                SendTeamMessage(1, COLOR_ALLDEPT, str);

                Patrol_DisplayZones(playerid);
                if(GetPVarInt(playerid, "patrol-duo") == 1) Patrol_DisplayZones(PatrolInfo[pat][patroluje][1]);
            }
        }
    }
    else if(GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            CancelSelectTextDraw(playerid);
            Patrol_HideMap(playerid);
            return 1;
        }
        new stanp[32], pnick1[24], pnick2[MAX_PLAYER_NAME+1];
        for(new i=0;i<MAX_PATROLS;i++)
        {
            if(clickedid == PatrolMarker[i] && PatrolInfo[i][pataktywny] == 1)
            {
                GetPlayerName(PatrolInfo[i][patroluje][0], pnick1, MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[i][patroluje][1], pnick2, MAX_PLAYER_NAME);
                switch(PatrolInfo[i][patstan])
                {
                    case 1: stanp="Sytuacja pod kontrol¹";
                    case 2: stanp="Potrzebne wsparcie";
                    case 3: stanp="Poœcig za podejrzanym";
                    case 4: stanp="Ranny funkcjonariusz";
                }
                format(str, 128, "Patrol %s - Funkcjonariusze: %s %s. Stan: %s", PatrolInfo[i][patname], pnick1, pnick2, stanp);
                SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
                break;
            }
        }
    }
    if(clickedid == TXD_Info) //Display server info
    {
        if(strlen(ServerInfo) > 1) ShowPlayerDialogEx(playerid, D_SERVERINFO, DIALOG_STYLE_MSGBOX, "Mrucznik-RP » Informacja", ServerInfo, "Schowaj", "Zamknij");
    }
   	return 1;
}

public OnDynamicActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPVarInt(playerid, "debug-objects"))
	{
		SendClientMessage(playerid, COLOR_PINK, sprintf("OnPlayerEnterDynamicArea: %d", areaid));
	}

	ZA_OnPlayerEnterDynamicArea(playerid, areaid); // z³odziej aut
	FB_OnPlayerEnterDynamicArea(playerid, areaid); // front business

    if(IsPlayerInAnyVehicle(playerid))
    {
        new kolid=-1;
        for(new i=0;i<MAX_OILS;i++)
        {
            if(OilData[i][oilArea] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1 && OilData[kolid][oilHP] > 0)
        {
            OnPlayerEnterOilSpot(playerid);
            return 1;
        }
        kolid = -1;
        for(new i=0;i<MAX_KOLCZATEK;i++)
        {
            if(KolArea[i] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1)
        {
            OnPlayerEnterSpikes(playerid);
            return 1;
        }
    }
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPVarInt(playerid, "debug-objects"))
	{
		SendClientMessage(playerid, COLOR_PINK, sprintf("OnPlayerLeaveDynamicArea: %d", areaid));
	}
	FB_OnPlayerLeaveDynamicArea(playerid, areaid);
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	camera_OnPlayerClickPTD(playerid, playertextid);

	if(GetPVarInt(playerid, "gatechose_active") == 1)   //Barierki
    {
    	new curpage = GetPVarInt(playerid, "gatechose_page");

    	if(playertextid == gNextButtonTextDrawId[playerid]) {
    	    if(curpage < (GetNumberOfPages() - 1)) {
    	        SetPVarInt(playerid, "gatechose_page", curpage + 1);
    	        ShowPlayerModelPreviews(playerid);
             	UpdatePageTextDraw(playerid);
             	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
    		return 1;
    	}
    	if(playertextid == gPrevButtonTextDrawId[playerid]) {
    	    if(curpage > 0) {
    	    	SetPVarInt(playerid, "gatechose_page", curpage - 1);
    	    	ShowPlayerModelPreviews(playerid);
    	    	UpdatePageTextDraw(playerid);
    	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
    		return 1;
    	}
    	new x=0;
    	while(x != SELECTION_ITEMS) {
    	    if(playertextid == gSelectionItems[playerid][x]) {
    	        HandlePlayerItemSelection(playerid, x);
    	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    	        DestroySelectionMenu(playerid);
    	        CancelSelectTextDraw(playerid);
            	SetPVarInt(playerid, "gatechose_active", 0);
            	return 1;
    		}
    		x++;
    	}
    }
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(enterexit == 0)
    {
        if(GetPlayerVehicleID(playerid) != 0)
            CarData[VehicleUID[GetPlayerVehicleID(playerid)][vUID]][c_HP] = 1000.0;
    }
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	SetPVarInt(playerid, "IsAGetInTheCar", 1);
	new Float:pX,Float:pY,Float:pZ;
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
        return 0;
    }
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
        return 0;
    }
    if(gPlayerLogged[playerid] == 0)
	{
        if(!IsPlayerNPC(playerid)) // znow tylko funkcja dla botow
		{
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "** Musisz siê zalogowaæ zanim wybierzesz skin (Zosta³eœ wyrzucony) **");
	        SetTimerEx("KickTimer",500,0,"d",playerid);
	    }
        return 0;
 	}		
	if(PlayerInfo[playerid][pJailed] == 2)
	{
		Player_RemoveFromVeh(playerid);
		SendClientMessage(playerid, COLOR_GRAD2, "Stra¿nik zauwa¿y³, ¿e coœ kombinujesz. Wracasz do celi.");
		return JailDeMorgan(playerid);
	}
	// Zapobieganie wsiadania do pojazdu podczas BW:							
	if(!isPlayerCuffed[playerid] && (PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0))
	{
		PlayerEnterVehOnInjury(playerid);
		return FreezePlayerOnInjury(playerid);
	}
	//Sila
	if(GetPVarInt(playerid, "RozpoczalBieg") == 1)//Zabezpieczenie, jeœli jest podczas biegu
	{
		sendTipMessage(playerid, "Nie mo¿esz wejœæ do pojazdu podczas biegu!"); 
		GetPlayerPos(playerid, pX,pY,pZ);
		SetPlayerPos(playerid, pX,pY,pZ+2);
	}
	if(GetPlayerPing(playerid) >= 180 && !ispassenger)//Zabezpieczenie, jeœli ma za du¿y ping
	{
		sendTipMessage(playerid, "Twój ping jest stanowczo za wysoki! Odczekaj chwilê, zanim wsi¹dziesz do pojazdu"); 
		GetPlayerPos(playerid, pX,pY,pZ);
		SetPlayerPos(playerid, pX,pY,pZ+2);
	}

    new engine, lights, alarm, doors, bonnet, boot, objective;
 	GetVehicleParamsEx(vehicleid, engine, lights ,alarm, doors, bonnet, boot, objective);
    if(!ispassenger)
	{
        if(!Player_CanUseCar(playerid, vehicleid))
        	return Player_RemoveFromVeh(playerid);
    }
	if(CarData[VehicleUID[vehicleid][vUID]][c_Owner] == JOB_DRIVER && !ispassenger) 
	{
		if(IsABus(vehicleid) || IsAMiniBus(vehicleid))
		{
			MruMessageInfo(playerid, "Wpisz /trasa aby rozpocz¹æ trasê autobusow¹.");
		}
	}
	// -- customowe parametry dla poszczególnych pojazdów
	if(IsARower(vehicleid) || IsAWodolot(vehicleid))
	{
		if(IsAWodolot(vehicleid))
		{
			SendClientMessage(playerid, COLOR_PANICRED, "By wystartowaæ wodolotem, ustaw /fpslimit 30 i upewnij siê, ¿e masz w³¹czony frame limiter w ustawieniach GTA SA.");
		}
		SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		engine = 1;
	}
	else if (GetVehicleModel(vehicleid) == 525 && !ispassenger) sendTipMessageEx(playerid, COLOR_BROWN, "Wsiad³eœ do holownika, naciœnij CTRL alby podholowaæ wóz.");
    if(!ispassenger && !engine)
	{
		MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		if(strcmp(GetIp(playerid), "127.0.0.1") == 0)
		{
			printf("Bot %s joined server (ip: %s)", GetNick(playerid), GetIp(playerid));
		}
		else
		{
			printf("ERROR: unauthorized NPC: %s (ip: %s)", GetNick(playerid), GetIp(playerid));
			//Kick(playerid);
		}
		return 1;
	}
	else
	{
		if(strcmp(GetNick(playerid), "Bot_Przemytnik", true) == 0 || strcmp(GetNick(playerid), "Bot_Przemytniczy", true) == 0)
		{
			KickEx(playerid, "nieautoryzowany bot");
		}
	}

	BottomBar(playerid, 0);
	LoadingShow(playerid);

	new GPCI[41];
	gpci(playerid, GPCI, sizeof(GPCI));
	Log(connectLog, INFO, "Gracz %s[id: %d, ip: %s, gpci: %s] po³¹czy³ siê z serwerem", GetNickEx(playerid), playerid, GetIp(playerid), GPCI);

	SetPlayerVirtualWorld(playerid, 1488);//AC przed omijaniem logowania

	ZerujZmienne(playerid);
	ClearVariableConnect(playerid);
	ZerujKontakty(playerid);
	dialAccess[playerid] = 0; 
	dialTimer[playerid] = 0; 
    ClearChat(playerid);

    // Wy³¹czone na testy
    obiekty_OnPlayerConnect(playerid);//nowe obiekty
	
	LoadTextDraws(playerid);
	
	Command_SetPlayerDisabled(playerid, true);
	 
	//Poprawny nick:
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
	if(regex_match(nick, NICK_REGEX) <= 0)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick jest niepoprawny! Nick musi posiadaæ formê: Imiê_Nazwisko!");
		KickEx(playerid, "z³y nick");
		return 1;
	}
	SetRPName(playerid);
	
	//bany
	if(MruMySQL_SprawdzBany(playerid)) return KickEx(playerid, "ban");

	timeSecWjedz[playerid] = 0;


	//Pocz¹tkowe ustawienia:
    saveMyAccountTimer[playerid] = SetTimerEx("SaveMyAccountTimer", 60*1000, 1, "i", playerid);
	
	//biz
	ResetBizOffer(playerid);
	PreloadAnimLibs(playerid);
	//system barierek by Kubi
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

    for(new x=0; x < SELECTION_ITEMS; x++) {
        gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}
	gItemAt[playerid] = 0;

	pSessionStart[playerid] = GetTickCount();
	RequestClassSpamProtection[playerid] = 0;
	return 1;
}
public OnPlayerPause(playerid)
{
	if(afk_timer[playerid] == -1)
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, 1, 0);
	}
	return 1;
}

public OnPlayerResume(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(playerid == INVALID_PLAYER_ID || playerid > MAX_PLAYERS)
		return 0;

	if(IsPlayerNPC(playerid))
	{
		printf("NPC %s disconnected", GetNick(playerid));
		return 1;
	}
	kicking[playerid] = 0;

	//Pobieranie starej pozycji:
	Log(connectLog, INFO, "Gracz %s[id: %d] roz³¹czy³ siê, powód: %d", GetNickEx(playerid), playerid, reason);
	if(reason == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		printf("Gracz %s dostal crasha, pozycja: %f,%f,%f | stara: %f,%f,%f", 
			GetNick(playerid), 
			x,y,z, 
			PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);

		// Dump player crash info
		DumpPlayerStreamInfo(playerid);		
	}

	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid);

	if(IsPlayerAtViceCity(playerid) && PlayerInfo[playerid][pSpawn] == 0)
	{
		PlayerInfo[playerid][pSpawn] = 3;
	}
	else if(!IsPlayerAtViceCity(playerid) && PlayerInfo[playerid][pSpawn] == 3)
	{
		PlayerInfo[playerid][pSpawn] = 0;
	}

	// modules:
	DrugDealer_OnPlayerDiconnect(playerid);

	new reString[128];
    new DisconnectReason[4][] =
    {
        "Timeout/Crash",
        "/q",
        "Kick/Ban",
		"/login"
    };
	SendDiscordDisconnectInfo(playerid, DisconnectReason[reason]);
    if(Spectate[playerid] == INVALID_PLAYER_ID)
    {
    	format(reString, sizeof(reString), "SERWER: Gracz znajduj¹cy siê w pobli¿u wyszed³ z serwera (%s, powód: %s).", GetNick(playerid), DisconnectReason[reason]);
		ProxDetector(25.0, playerid, reString, COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
	}
	if(GetPVarInt(playerid, "OKupMats") == 1)
    {
        new giveplayerid = GetPVarInt(playerid, "Mats-id");
        SetPVarInt(playerid, "OKupMats", 0);
		SetPVarInt(giveplayerid, "OSprzedajMats", 0);
        SetPVarInt(playerid, "Mats-id", 0);
        SetPVarInt(playerid, "Mats-kasa", 0);
        SetPVarInt(playerid, "Mats-mats", 0);
        sendErrorMessage(giveplayerid, "Sprzeda¿ zosta³a anulowana!");
    }
	if(PlayerInfo[playerid][pLider] > 0)
	{
		Save_MySQL_Leader(playerid); 
	}
	if(GetPVarInt(playerid, "ZjadlDragi") == 1)
	{
		new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
		KillTimer(TimerEfektNarkotyku[playerid]);
		SetStrong(playerid, FirstValue);
	}
	if(GetPVarInt(playerid, "DostalDM2") == 1)
	{
		new string[128];
		format(string, sizeof(string), "[Marcepan Marks] Zabra³em graczowi %s broñ [da³ /q podczas AJ DM2]", GetNickEx(playerid));
		SendAdminMessage(COLOR_PANICRED, string);
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
	}
    if(GetPVarInt(playerid, "kolejka") == 1)
    {
        PlayerInfo[playerid][pPos_x] = GetPVarFloat(playerid, "kolejka-x");
        PlayerInfo[playerid][pPos_y] = GetPVarFloat(playerid, "kolejka-y");
        PlayerInfo[playerid][pPos_z] = GetPVarFloat(playerid, "kolejka-z");
        PlayerInfo[playerid][pInt] = GetPVarInt(playerid, "kolejka-int");
    }

    UpdateDynamic3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, " ");

	//AFK timer
	if(afk_timer[playerid] != -1)
	{
		KillTimer(afk_timer[playerid]);
		afk_timer[playerid] = -1;
	}
    if(GetPVarInt(playerid, "finding") == 1) {
        GangZoneDestroy(pFindZone[playerid]);
    }
	if(saveMyAccountTimer[playerid] != -1)
	{
		KillTimer(saveMyAccountTimer[playerid]);
	}

    //budki telefoniczne
    if(GetPVarInt(playerid, "budka-Mobile") != 999) {
        new caller = GetPVarInt(playerid, "budka-Mobile");
        if(GetPVarInt(caller, "budka-Mobile") == playerid) {
            sendTipMessage(caller, "**biiip biiip** po³¹czenie zosta³o przerwane ((Wyjœcie z gry))", COLOR_PAPAYAWHIP);
            budki[GetPVarInt(playerid, "budka-used")][isCurrentlyUsed] = 0;
            budki[GetPVarInt(caller, "budka-used")][isCurrentlyUsed] = 0;
            SetPVarInt(caller, "budka-Mobile", 999);
            SetPVarInt(caller, "budka-used", 999);
        }
    }
	//lawyer
	OfferPrice[playerid] = 0;
	LawyerOffer[playerid] = 0;
	ClearVariableDisconnect(playerid); 
	//komunikaty frakcyjne
	komunikatMinutyZerowanie[playerid]=0;

    if(TalkingLive[playerid] != INVALID_PLAYER_ID)
    {
		SendPlayerMessageToAll(COLOR_NEWS, "(( Wywiad zakoñczony - gracz wyszed³ z gry ))");
        new talker = TalkingLive[playerid];
        TalkingLive[playerid] = INVALID_PLAYER_ID;
        TalkingLive[talker] = INVALID_PLAYER_ID;
    }
	//koniec rozmowy telefonicznej
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		if(Mobile[playerid] >= 0)
		{
			SendClientMessage(Mobile[playerid], COLOR_YELLOW, "Gracz, z którym prowadzi³eœ rozmowê telefoniczn¹, wyszed³ z gry.");
		}
		StopACall(playerid);
	}
//	if(GetPlayerAdminDutyStatus(playerid) == 1)
	if(firstDutyAdmin[playerid] == 1 && PlayerInfo[playerid][pAdmin] > 0
	|| firstDutyAdmin[playerid] == 1 && PlayerInfo[playerid][pNewAP] > 0
	|| firstDutyAdmin[playerid] == 1 && IsAScripter(playerid))//Je¿eli admin by³ na duty, wykonuje zapis w logi 
	{
		new exitReason[16];//String do logu
		//LOG
		if(!IsPlayerPaused(playerid))
		{
			format(exitReason, sizeof(exitReason), "DISCONNECT");
		}
		else 
		{
			format(exitReason, sizeof(exitReason), "AFK");
		}
		
		//Log dla 0Verte [Nick][UID] [HH:mm] [Bany] [Warny] [AJ] [Kicki] [Inne] [Reporty+zapytania] [/w] [/w2] [powod zakoñczenia s³u¿by]
		Log(admindutyLog, INFO, "Admin %s zakonczyl sluzbe - wykonal w czasie %d:%d [B%d/W%d/K%d/I%d/OA%d/Z%d/WI%d/WO%d] - Wyszedl poprzez %s", 
			GetPlayerLogName(playerid), 
			AdminDutyGodziny[playerid], 
			AdminDutyMinuty[playerid],
			iloscBan[playerid],
			iloscWarn[playerid],
			iloscKick[playerid],
			iloscInne[playerid], 
			iloscPozaDuty[playerid],
			iloscZapytaj[playerid], 
			iloscInWiadomosci[playerid], 
			iloscOutWiadomosci[playerid],
			exitReason
		); //Create LOG
		
		//Zerowanie zmiennych 
		iloscKick[playerid] = 0;
		iloscWarn[playerid] = 0;
		iloscBan[playerid] = 0;
		iloscInne[playerid] = 0;
		iloscAJ[playerid] = 0;
		iloscInWiadomosci[playerid] = 0;
		iloscOutWiadomosci[playerid] = 0;
		iloscZapytaj[playerid] = 0;	
		iloscPozaDuty[playerid] = 0; 
		//Kill timer 
		KillTimer(AdminDutyTimer[playerid]);
		AdminDutyGodziny[playerid] = 0;
		AdminDutyMinuty[playerid] = 0;
		firstDutyAdmin[playerid] = 0; 
	}
	if((PlayerInfo[playerid][pAdmin] >= 1 && iloscPozaDuty[playerid] >= 1)
	|| (PlayerInfo[playerid][pNewAP] >= 1 && iloscPozaDuty[playerid] >= 1)
	|| (IsAScripter(playerid) && iloscPozaDuty[playerid] >= 1))//Gdy nie by³ na admin duty, ale wykonywa³ akcje
	{
		if(firstDutyAdmin[playerid] == 0)
		{
			new exitReason[16];//String do logu
			if(!IsPlayerPaused(playerid))
			{
				format(exitReason, sizeof(exitReason), "DISCONNECT");
			}
			else 
			{
				format(exitReason, sizeof(exitReason), "AFK");
			}
			Log(admindutyLog, INFO, "Admin %s zakonczyl sluzbe - wykonal w czasie %d:%d [B%d/W%d/K%d/I%d/OA%d/Z%d/WI%d/WO%d] - Wyszedl poprzez %s", 
				GetPlayerLogName(playerid), 
				AdminDutyGodziny[playerid], 
				AdminDutyMinuty[playerid],
				iloscBan[playerid],
				iloscWarn[playerid],
				iloscKick[playerid],
				iloscInne[playerid], 
				iloscPozaDuty[playerid],
				iloscZapytaj[playerid], 
				iloscInWiadomosci[playerid], 
				iloscOutWiadomosci[playerid],
				exitReason
			); //Create LOG
			iloscPozaDuty[playerid] = 0; 
		}
	}
	if(GetPlayerAdminDutyStatus(playerid)) {
		SetPVarInt(playerid, "dutyadmin", 0);
		EnableZGIfNoAdmins();
	}
	if(Worek_MamWorek[playerid] != 0) // gdy osoba z workiem da /q
	{
		Worek_MamWorek[playerid] = 0;
		Worek_KomuZalozylem[Worek_KtoZalozyl[playerid]] = INVALID_PLAYER_ID;
		Worek_Uzyty[Worek_KtoZalozyl[playerid]] = 0;
		Worek_KtoZalozyl[playerid] = INVALID_PLAYER_ID;
		UnHave_Worek(playerid);
	}
	else if(Worek_Uzyty[playerid] != 0) // gdy osoba nadajaca worek trafi do szpitala
	{
		Worek_MamWorek[Worek_KomuZalozylem[playerid]] = 0;
		Worek_KtoZalozyl[Worek_KomuZalozylem[playerid]] = INVALID_PLAYER_ID;
		UnHave_Worek(Worek_KomuZalozylem[playerid]);
		Worek_Uzyty[playerid] = 0;
		Worek_KomuZalozylem[playerid] = INVALID_PLAYER_ID;
	}

    if(GetPVarInt(playerid, "kostka"))
    {
        new id = GetPVarInt(playerid, "kostka-player");
        Kostka_Wygrana(id, playerid, GetPVarInt(id, "kostka-cash"), true);
        SendClientMessage(id, COLOR_RED, "Wspó³zawodnik opuœci³ serwer, otrzymujesz zwrot wp³aconej kwoty wraz z podatkiem.");
        SetPVarInt(playerid, "kostka",0);
        SetPVarInt(playerid, "kostka-throw", 0);
        SetPVarInt(playerid, "kostka-suma", 0);
        SetPVarInt(playerid, "kostka-cash", 0);
        SetPVarInt(playerid, "kostka-first", 0);
        SetPVarInt(playerid, "kostka-rzut", 0);
        SetPVarInt(playerid, "kostka-wait", 0);
        SetPVarInt(playerid, "kostka-player", 0);
    }

	if(PlayerInfo[playerid][pJailed] == 10) // uniknal marcepana bo wbil przed uplywem 3 minut
	{
		if(gettime() - PlayerInfo[playerid][pJailTime] > 600)
		{
			// nie marcepanuj po 10 minutach od poprzedniego marcepana
			PlayerInfo[playerid][pJailed] = 0;
			PlayerInfo[playerid][pJailTime] = 0;
		}
		else
		{
			// kolejne /q, 1 minuta na powrót
			PlayerInfo[playerid][pJailTime] = gettime() + 120;
		}
	}

    if(PlayerTied[playerid] || isPlayerCuffed[playerid] || poscig[playerid] == 1)
	{
		PlayerInfo[playerid][pJailed] = 10;
		PlayerInfo[playerid][pJailTime] = gettime();
		new string[130];
		new powod[36];
		if(PlayerTied[playerid])
		{
			strcat(powod, "bycie zwiazanym, ");
		}
		if(isPlayerCuffed[playerid])
		{
			strcat(powod, "kajdanki, ");
		}
		if(poscig[playerid] >= 1)
		{
			strcat(powod, "poœcig, ");
		}
		new codal[16];
		switch(reason)
		{
			case 0: codal = "timeout";
			case 1: codal = "/q";
			case 2: codal = "kick/ban";
		}
		format(string, 130, "%s dostanie Marcepana za mo¿liwe: %s (%s)", GetNickEx(playerid), powod, codal);
		SendAdminMessage(COLOR_P@, string);
	}

	// -----------
	// Kajdanki:
	// -----------
	if(isPlayerCuffed[playerid]) // gdy skuty da /q
	{
		UncuffPlayer(playerid);
	}
	else if(isPlayerUsingCuffs[playerid]) //gdy skuwaj¹cy da /q
	{
		UncuffPlayerCuffedBy(playerid);
	}
	// -----------

	if(PoziomPoszukiwania[playerid] >= 1)
	{
		new wl = PoziomPoszukiwania[playerid];
		PlayerInfo[playerid][pWL] = wl;
		SetPlayerWantedLevel(playerid, 0);
	}

	Driver_OnPlayerDisconnect(playerid);

    //System aut
    Car_UnloadForPlayer(playerid);
    // zapisanie PK
    new karne = GetPVarInt(playerid, "mandat_punkty");
    if(karne>0) {
        PlayerInfo[playerid][pPK] += karne;
    }
    //
	//Zapis statystyk:
	MruMySQL_SaveAccount(playerid, false, true);

    if(GetPVarInt(playerid, "active_ticket") != 0)
        Support_ClearTicket(GetPVarInt(playerid, "active_ticket")-1);

    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        Oil_UnloadPTXD(playerid);
        TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
        TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    }

    if(GetPVarInt(playerid, "patrol") != 0) {
        new patrol = GetPVarInt(playerid, "patrol-id");
		if(PatrolInfo[patrol][patroluje][0] != INVALID_PLAYER_ID)
        {
        	sendTipMessageEx(PatrolInfo[patrol][patroluje][0], COLOR_PAPAYAWHIP, "Partner opuœci³ patrol. 10-33!");
			RunCommand(PatrolInfo[patrol][patroluje][0], "/patrol", "stop");
		}
		if(PatrolInfo[patrol][patroluje][1] != INVALID_PLAYER_ID)
		{
        	sendTipMessageEx(PatrolInfo[patrol][patroluje][1], COLOR_PAPAYAWHIP, "Partner opuœci³ patrol. 10-33!");
        	RunCommand(PatrolInfo[patrol][patroluje][1], "/patrol", "stop");
		}
    }
    if(GetPVarInt(playerid, "rentTimer") != 0)
    {
        UnhireRentCar(playerid, GetPVarInt(playerid, "rentCar"));
        KillTimer(GetPVarInt(playerid, "rentTimer"));
    }

    //12.06.2014  opis
    //Opis_Usun(playerid);

    if(noclipdata[playerid][fireobject] != 0)
    {
        DestroyDynamicObject(noclipdata[playerid][fireobject]);
        noclipdata[playerid][fireobject] = 0;
    }

    //strefy
    if(ZonePlayerTimer[playerid] != 0) KillTimer(ZonePlayerTimer[playerid]);

	UnLoadTextDraws(playerid);

    INT_AirTowerLS_Exit(playerid, true, true);

    //09.06.2014 wylaczenie ng pad
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        SetPVarInt(playerid, "ng-gatekey", 0);
        VAR_NGKeypad = false;
    }

	if(PDGPS == playerid)
	{
		foreach(new i : Player)
		{
			if(IsAPolicja(i) || GetPlayerFraction(i) == FRAC_ERS || GetPlayerFraction(i) == FRAC_BOR || GetPlayerFraction(i) == FRAC_ERS || (PlayerInfo[i][pMember] == 9 && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1))
				DisablePlayerCheckpoint(i);
		}
	}

    if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
	{
	    new string[64];
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    format(string, sizeof(string), "Wyœcig: {FFFFFF}%s wyszed³ z gry", sendername);
    	foreach(new i : Player)
    	{
	    	if(ScigaSie[i] == Scigamy)
 	    	{
    			SendClientMessage(i, COLOR_YELLOW, string);
   			}
	    }
	    IloscZawodnikow --;
	    if(IloscZawodnikow <= Ukonczyl)
	    {
	        KoniecWyscigu(-1);
	    }
    }

    if(HireCar[playerid] != 0)
    {
        CarData[VehicleUID[HireCar[playerid]][vUID]][c_Rang] = 0;
    }

    new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }

    TextDrawHideForPlayer(playerid, TXD_Info);

	if(GotHit[playerid] > 0)
	{
	    if(GetChased[playerid] < 500)
	    {
	        if(IsPlayerConnected(GetChased[playerid]))
	        {
	        	SendClientMessage(GetChased[playerid], COLOR_YELLOW, "Twój cel opuœci³ serwer.");
	            GoChase[GetChased[playerid]] = 999;
			}
	    }
	}
	
	if(PlayersChannel[playerid] < 500)
	{
		IRCInfo[PlayersChannel[playerid]][iPlayers] --;
	}
	if(PlayerBoxing[playerid] > 0)
	{
	    if(Boxer1 == playerid)
	    {
	        if(IsPlayerConnected(Boxer2))
	        {
	        	PlayerBoxing[Boxer2] = 0;
	        	SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer2, 5);
	        	GameTextForPlayer(Boxer2, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    else if(Boxer2 == playerid)
	    {
	        if(IsPlayerConnected(Boxer1))
	        {
	        	PlayerBoxing[Boxer1] = 0;
	        	SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer1, 5);
	        	GameTextForPlayer(Boxer1, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    InRing = 0;
     	RoundStarted = 0;
		Boxer1 = 255;
		Boxer2 = 255;
		TBoxer = 255;
	}
	if(PlayerInfo[playerid][pJob] == 11)
	{
	    if(JobDuty[playerid] == 1) { Medics -= 1; }
	}
	else if(PlayerInfo[playerid][pJob] == 7)
	{
	    if(JobDuty[playerid] == 1) { Mechanics -= 1; }
	}
	

	TransportDuty[playerid] = 0;
	JobDuty[playerid] = 0;
    gPlayerLogged[playerid] = 0; //wylogowany
	PlayerInfo[playerid][pUID] = 0;
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(isPlayerCuffed[playerid])
	{
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~r~Nie atakuj", 3500, 1);
		SetTimerEx("FreezePlayer", 3500, false, "i", playerid);
	}

	Log(damageLog, INFO, "%s zg³asza zranienie gracza %s o %fhp broni¹ %d", 
		GetPlayerLogName(playerid),
		IsPlayerConnected(damagedid) ? GetPlayerLogName(damagedid) : sprintf("%d", damagedid),
		amount,
		weaponid);
	SavePlayerDamaged(damagedid, playerid, amount, weaponid);
	SavePlayerDamage(playerid, damagedid, amount, weaponid);

	if(IsAPolicja(playerid) && OnDuty[playerid] == 1)
	{
		SetPVarInt(damagedid, "damaged_by_cop", gettime());
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid < 0 || issuerid > MAX_PLAYERS)
	{
		return 1;
	}

	if(issuerid != INVALID_PLAYER_ID) // PvP
    {
		if(isPlayerCuffed[issuerid])
		{
			new Float:hp, Float:armor;
			GetPlayerHealth(playerid, hp);
			GetPlayerArmour(playerid, armor);
			SetPlayerHealth(playerid, hp);
			SetPlayerArmour(playerid, armor);
			return 1;
		}
    }
	else //self
	{
		if(PlayerInfo[playerid][pBW] > 0 || (issuerid < 0 || issuerid > MAX_PLAYERS) || GetPVarInt(playerid, "enter-check") || gPlayerLogged[issuerid] != 1)
		{
			new Float:hp, Float:armor;
			GetPlayerHealth(playerid, hp);
			GetPlayerArmour(playerid, armor);
			SetPlayerHealth(playerid, hp);
			SetPlayerArmour(playerid, armor);
			return 1;
		}
	}
	
	SetPVarInt(playerid, "lastDamage", gettime());
	Log(damageLog, INFO, "%s zosta³ zraniony przez %s o %fhp broni¹ %d", 
		GetPlayerLogName(playerid),
		IsPlayerConnected(issuerid) ? GetPlayerLogName(issuerid) : sprintf("%d", issuerid),
		amount,
		weaponid
	);

    SetTimerEx("OnPlayerTakeDamageWeaponHack", 500, false, "iii", issuerid, weaponid, playerid);

    if(weaponid == WEAPON_GRENADE || weaponid == 51)
	{
		new Float:health;
		GetPlayerHealth(playerid,health);
		SetPlayerHealth(playerid, (health)-5);
	    ShowPlayerFadeScreenToBlank(playerid, 20, 255, 255, 255, 255);
		SetPlayerDrunkLevel(playerid, 3000);
	}
	else
	{
		// check: onplayerweaponshot
	}

	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if(armour <= 40.0)
	{
		switch(bodypart)
		{
			case BODY_PART_LEFT_LEG:
			{
				if(random(100) < 30) ApplyAnimation(playerid, "ped", "DAM_LegL_frmLT", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_RIGHT_LEG:
			{
				if(random(100) < 30) ApplyAnimation(playerid, "ped", "DAM_LegR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_LEFT_ARM:
			{
				if(random(100) < 10) ApplyAnimation(playerid, "ped", "DAM_armL_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_RIGHT_ARM:
			{
				if(random(100) < 10) ApplyAnimation(playerid, "ped", "DAM_armR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
			}
			case BODY_PART_HEAD:
			{
				if(random(100) < 60) ApplyAnimation(playerid,"PED","SHOT_partial", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}

	return 0;
}

public StandUp(playerid)
{
    SetPVarInt(playerid, "optd-hs", 0);
    ApplyAnimation(playerid, "ped", "getup", 4.1, 0, 0, 0, 0, 0, 1);
}

public OnPlayerDeath(playerid, killerid, reason)
{
	// do nothing if player is not logged in / connected
	if((!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) || (IsPlayerConnected(killerid) && !gPlayerLogged[killerid])) 
	{
		return 1;
	}

	if(AC_AntyFakeKill(playerid, killerid, reason)) 
	{
		return 1;
	}

	if(IsPlayerAtViceCity(playerid) && PlayerInfo[playerid][pSpawn] == 0)
	{
		PlayerInfo[playerid][pSpawn] = 3;
	} 
	else if(!IsPlayerAtViceCity(playerid) && PlayerInfo[playerid][pSpawn] == 3)
	{
		PlayerInfo[playerid][pSpawn] = 0;
	}

	Log(damageLog, INFO, "%s zosta³ zabity przez %s, powód: %d", 
		GetPlayerLogName(playerid),
		IsPlayerConnected(killerid) ? GetPlayerLogName(killerid) : sprintf("%d", killerid),
		reason
	);
	DeathAdminWarning(playerid, killerid, reason);

	// save player death pos
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); 

	// bomboox
	new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }

	// gangzone system
    if(ZoneAttacker[playerid] || ZoneDefender[playerid])
    {
        OnPlayerLeaveGangZone(playerid, GetPVarInt(playerid, "zoneid"));
    }

	// ibiza
    if(GetPVarInt(playerid, "IbizaWejdz") || GetPVarInt(playerid, "IbizaBilet") )
	{
		DeletePVar(playerid, "IbizaWejdz");
		DeletePVar(playerid, "IbizaBilet");
	}

	// ---- code that should run always, no matter if player gets the BW or not ----
	StopAudioStreamForPlayer(playerid);
	gPlayerSpawned[playerid] = 0;
	PlayerInfo[playerid][pLocal] = 255;
	SetPlayerColor(playerid,COLOR_GRAD2); // color indicating that the player is respawning

	// don't give bw to admins on adminduty & admin on adminduty dont give bw to players
	if(GetPlayerAdminDutyStatus(playerid) == 1 || GetPlayerAdminDutyStatus(killerid) == 1)
	{
		return 1;
	}

	// skip bw for various reasons
	if(GetPVarInt(playerid, "skip_bw") != 0) 
	{
		DeletePVar(playerid, "skip_bw");
		return 1;
	}

	// ---- code that should run only, if player gets the BW ----
	PlayerInfo[playerid][pDeaths] ++;
	
	// bw system
	if(PlayerInfo[playerid][pInjury] > 0)
	{
		BW_OnPlayerDeath(playerid, killerid, reason);
	}
	else
	{
		BW_OnPlayerInjured(playerid, killerid, reason);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}
	//Czyszczenie zmiennych
	if(gPlayerLogged[playerid] != 1)
	{
		sendErrorMessage(playerid, "Zespawnowa³eœ siê, a nie jesteœ zalogowany! Zosta³eœ wyrzucony z serwera.");
		KickEx(playerid, "omijanie spawnu");
		return 0;
	}
	else
	{
		if(GetPVarInt(playerid, "Lockdown-izolacja") != 0)
		{
			ALockdown_SetLockdownVW(playerid);
		}
		else
			SetPlayerVirtualWorld(playerid, 0);
	}
	DeletePVar(playerid, "Vinyl-bilet");
    DeletePVar(playerid, "Vinyl-VIP");
    PlayerInfo[playerid][pMuted] = 0;
	WnetrzeWozu[playerid] = 0;
	spamwl[playerid] = 0;
	if(PlayerInfo[playerid][pFixKit] < 0) PlayerInfo[playerid][pFixKit] = 0;
	if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0)
	{
    	SetPlayerWeatherEx(playerid, ServerWeather);//Pogoda
	}
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
	{
    	SetPlayerWeatherEx(playerid, 3);//Pogoda
	}
    // usuwanie
    if(PlayerInfo[playerid][pRank] == 99 && PlayerInfo[playerid][pMember] == 99) {
        PlayerInfo[playerid][pRank] = 0;
        PlayerInfo[playerid][pMember] = 0;
        PlayerInfo[playerid][pOrg] = 0;
        PlayerInfo[playerid][pRank] = 0;
        PlayerInfo[playerid][pUniform] = 0;
        SecretAgent[playerid] = 0;
        MruMySQL_SetAccInt("Rank", GetNick(playerid), 0);
        MruMySQL_SetAccInt("Member", GetNick(playerid), 0);
        UsunBron(playerid);
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zosta³eœ wyrzucony z organizacji/frakcji przez lidera, gdy by³eœ offline!");
    }
    SetPVarInt(playerid, "mozeUsunacBronie", 0);
    // zabieranie prawka //
    new string[128];
    if(PlayerInfo[playerid][pPK] > 24) {
        format(string, sizeof(string), "* Przekroczy³eœ limit 24 PK. Tracisz prawo jazdy na 1 DZIEÑ");
        SendClientMessage(playerid, COLOR_RED, string);
                                        //86400
        PlayerInfo[playerid][pPK] = 0;
        PlayerInfo[playerid][pCarLic] = gettime()+86400;
    }
	
	new dom = PlayerInfo[playerid][pWynajem];
	if(dom != 0)
	{
		new Nick[MAX_PLAYER_NAME];
		Nick = GetNick(playerid);
		if(
			strcmp(Dom[dom][hL1], Nick, true) != 0 &&
			strcmp(Dom[dom][hL2], Nick, true) != 0 &&
			strcmp(Dom[dom][hL3], Nick, true) != 0 &&
			strcmp(Dom[dom][hL4], Nick, true) != 0 &&
			strcmp(Dom[dom][hL5], Nick, true) != 0 &&
			strcmp(Dom[dom][hL6], Nick, true) != 0 &&
			strcmp(Dom[dom][hL7], Nick, true) != 0 &&
			strcmp(Dom[dom][hL8], Nick, true) != 0 &&
			strcmp(Dom[dom][hL9], Nick, true) != 0 &&
			strcmp(Dom[dom][hL10], Nick, true) != 0
		)
		{
			format(string, sizeof(string), "* Zosta³eœ wykopany z wynajmowanego domu.");
			SendClientMessage(playerid, COLOR_RED, string);
			PlayerInfo[playerid][pWynajem] = 0;
			PlayerInfo[playerid][pSpawn] = 0;
		}
	}
	//Skills'y broni
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);
    //Style walki
    if(PlayerInfo[playerid][pStylWalki] == 1) SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	else if(PlayerInfo[playerid][pStylWalki] == 2) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	else if(PlayerInfo[playerid][pStylWalki] == 3) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
	//WL
	SetPlayerWantedLevel(playerid, (PoziomPoszukiwania[playerid] > 6 ? 6 : PoziomPoszukiwania[playerid]));

	//DŸwiêki
	StopAudioStreamForPlayer(playerid);
	PlayerFixRadio(playerid);

	//Kubi
	INT_AirTowerLS_Exit(playerid, false, true);

	//Inne
	if(PlayerInfo[playerid][pDom] != 0)
	{
		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0; //Zerowanie dni do usuniêcia domu
	}
	SetPlayerToTeamColor(playerid);
	//AdminDuty
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		SetPlayerColor(playerid, 0xFF0000FF);
	}
    if(PlayerInfo[playerid][pLider] == FRAC_SN)
    {
        SetPVarInt(playerid, "scena-allow", 1);
    }
	//SetPlayerSpawn:
	SetPlayerSpawn(playerid);

    //Spawn Pos
	SetTimerEx("SpawnPosInfo", 1000, false, "i", playerid);
	return 1;
}

SetPlayerSpawn(playerid)
{
	SetPlayerSpawnPos(playerid);
	SetPlayerSpawnSkin(playerid);
	SetPlayerSpawnWeapon(playerid);
	return 1;
}

SetPlayerSpawnPos(playerid)
{
	//Po /spec off
    if(Unspec[playerid][Coords][0] != 0.0 && Unspec[playerid][Coords][1] != 0.0 && Unspec[playerid][Coords][2] != 0.0)
    {
		if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
		{
			SetPlayerInterior(playerid, Unspec[playerid][sPint]);
			SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
			SetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
			Unspec[playerid][Coords][0] = 0.0, Unspec[playerid][Coords][1] = 0.0, Unspec[playerid][Coords][2] = 0.0;
			Spectate[playerid] = INVALID_PLAYER_ID;
			PhoneOnline[playerid] = 0;
		}
    }
    //Wiêzienie:
	else if(PlayerInfo[playerid][pJailed] == 1)
	{
		if(PlayerInfo[playerid][pInjury] > 0) ZdejmijBW(playerid, 3000);

		SetPlayerArrestPos(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Twój wyrok nie dobieg³ koñca, wracasz do wiêzienia.");
		TogglePlayerControllable(playerid, 0);
		Wchodzenie(playerid);
	}
	else if(PlayerInfo[playerid][pJailed] == 2)//Stanowe
	{
		if(PlayerInfo[playerid][pInjury] > 0) ZdejmijBW(playerid, 3000);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Twój wyrok nie dobieg³ koñca, wracasz do wiêzienia stanowego");
		JailDeMorgan(playerid);
		return 1;
	}
	else if(PlayerInfo[playerid][pJailed] == 3)//AdminJail
	{
		new string[128];
	    SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 1000+playerid);
		SetPlayerPos(playerid,1481.1666259766,-1790.2204589844,156.7875213623);
		PlayerInfo[playerid][pMuted] = 1;
		PlayerPlaySound(playerid, 141, 0.0, 0.0, 0.0);

		if(GetPVarInt(playerid, "DostalAJkomunikat") == 0) 
		{
			format(string, sizeof(string), "Wracasz do Admin Jaila. {FFFFFF}Powód: %s", PlayerInfo[playerid][pAJreason]);
			SendClientMessage(playerid, COLOR_PANICRED, string);
			SetPVarInt(playerid, "DostalAJkomunikat", 1);
		}
		if(strfind(PlayerInfo[playerid][pAJreason], "DM2", true) != -1 || 
		strfind(PlayerInfo[playerid][pAJreason], "Death Match 2", true) != -1) SetPVarInt(playerid, "DostalDM2", 1);
	}
	else if(PlayerInfo[playerid][pJailed] == 10)//Marcepan Admin Jail
	{
		new currTime = gettime();
		new quitTime = PlayerInfo[playerid][pJailTime];
		if(currTime - quitTime > 600) // gracz wbi³ po 10 minutach
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			SetPlayerInterior(playerid, PlayerInfo[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Da³eœ /q podczas akcji, ale wróci³eœ w ci¹gu 3 minut. Odgrywaj dalej - mo¿esz daæ /q dopiero po 10 minutach.");
		}
		else
		{
			new string[256];
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* Zosta³eœ uwieziony w Admin Jailu przez Admina Marcepan_Marks. Powod: /q podczas akcji");
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			PlayerInfo[playerid][pJailed] = 3;
			PlayerInfo[playerid][pJailTime] = 15*60;
			format(PlayerInfo[playerid][pAJreason], MAX_AJ_REASON, "/q podczas akcji (Marcepan)");
			SetPlayerVirtualWorld(playerid, 1000+playerid);
			PlayerInfo[playerid][pMuted] = 1;
			SetPlayerPos(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
			format(string, sizeof(string), "Zosta³eœ ukarany na 15 minut. Powod: /q podczas akcji");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina Marcepan_Marks. Powod: /q podczas akcji", sendername);
			SendClientMessageToAll(COLOR_LIGHTRED, string);
			Log(punishmentLog, INFO, "%s da³ /q podczas akcji wiêc wrzucono go do AJ.", GetPlayerLogName(playerid));
		}
	}
	//BW:
	else if(PlayerInfo[playerid][pBW] > 0 || GetPVarInt(playerid, "kill-bw") == 1)
	{
		new spawnViceCity = PlayerInfo[playerid][pSpawn] >= 3 || IsPlayerAtViceCity(playerid);
		ZespawnujGraczaSzpitalBW(playerid, spawnViceCity);
	}
	else if(PlayerInfo[playerid][pInjury] > 0)
	{
		ZespawnujGraczaBW(playerid);
	}
    else
    {
	    //-----------------------------------[ Normalny spawn ]-----------------------------------
	    //Przywracanie do poprzedniego spawnu
		if(GetPVarInt(playerid, "spawn") == 2)
		{
			Wchodzenie(playerid);
			SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			SetPlayerInterior(playerid, GetPVarInt(playerid, "last-pos-int"));
			if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) ALockdown_SetLockdownVW(playerid);
			else SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "last-pos-vw"));
			if(IsAtBank(playerid) || GetPlayerLocal(playerid) == PLOCAL_FRAC_DMV)
	        {
				sendTipMessage(playerid, "W banku nie wolno mieæ broni! Zostanie Ci ona przywrócona po œmierci.");
				SetPVarInt(playerid, "mozeUsunacBronie", 1);
                ResetPlayerWeapons(playerid);
				return 1;
			}
		}
		else
		{
			new spawnType = PlayerInfo[playerid][pSpawn];
		    if(spawnType == 0 || spawnType >= 3) //Normalny spawn
		    {
		        PlayerInfo[playerid][pLocal] = 255;
				if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) ALockdown_SetLockdownVW(playerid);
				else SetPlayerVirtualWorld(playerid, 0);
				if(GetPlayerFraction(playerid) > 0) //Spawn Frakcji
				{
				    switch(GetPlayerFraction(playerid))
				    {
						case FRAC_LSPD: //1
						{
							if(spawnType == 0)
							{ // Los Santos
								new rand = random(sizeof(gCopPlayerSpawns));
								SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]);
								SetPlayerFacingAngle(playerid, 90.0);
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -3802.7534, 1777.8750,6.5215);
								SetPlayerFacingAngle(playerid, 316.0);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_FBI: //2
						{
							if(spawnType == 0)
							{ // Los Santos
								SetPlayerPos(playerid, 598.2130,-1491.1135,15.1351);
								SetPlayerFacingAngle(playerid, 270.0);
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -4857.0322, 3012.5569, 6.0599);
								SetPlayerFacingAngle(playerid, 136.0);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_NG: //3
						{
							if(spawnType == 0)
							{ // Los Santos
								SetPlayerPos(playerid, 261.8342, 71.2429, 1003.2422);// stara: 2515.0200, -2459.5896, 13.8187
								SetPlayerInterior(playerid, 6);
								SetPlayerVirtualWorld(playerid, 88);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -5921.1716, 2093.6060, 9.3275);
								SetPlayerFacingAngle(playerid, 265.0);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_ERS:  //4
						{
							if(spawnType == 0)
							{ // Los Santos
								SetPlayerPos(playerid, 1148.4323,-1315.4225,13.9841);
								SetPlayerFacingAngle(playerid,358.0);
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -5087.2378, 1779.6316, 7.5683);
								SetPlayerFacingAngle(playerid, 266.7065);
								SetPlayerInterior(playerid, 0);
							}
						} // 5,6 empty
						case FRAC_BOR: //7
						{
						    SetPlayerPos(playerid, 1519.0970,-1449.6099,13.5391);
							SetPlayerInterior(playerid, 0);
						}
						case FRAC_HA: //8
						{
							if(spawnType == 0)
							{ // Los Santos
						    	SetPlayerPos(playerid, -50.400001525879,-279.20001220703,6.0999999046326);
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -4125.0571, 3340.3920, 13.2164);
								SetPlayerFacingAngle(playerid, 180.7065);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_SN: //9
						{
							if(spawnType == 0)
							{ // Los Santos
								if(PlayerInfo[playerid][pRank] <= 1)
								{
									SetPlayerPos(playerid, 297.7128,-1612.1783,114.4219);//Dach SN
									sendTipMessage(playerid, "Zrespi³eœ siê na dachu San News"); 
								}
								else if(PlayerInfo[playerid][pRank] >= 2 && PlayerInfo[playerid][pRank] < 7) 
								{
									SetPlayerPos(playerid, 288.0914,-1609.7465,17.9994);
								}
								else if(PlayerInfo[playerid][pRank] >= 8)
								{
									SetPlayerPos(playerid, 288.0914,-1609.7465,17.9994);
								}
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -4638.0244, 3358.1313, 5.5328);
								SetPlayerFacingAngle(playerid, 180.7065);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_KT: //10
						{
							if(spawnType == 0)
							{ // Los Santos
								SetPlayerPos(playerid,2468.3796,-2082.9690,13.5580);
								SetPlayerFacingAngle(playerid, 89.1901);
								SetPlayerInterior(playerid, 0);
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -5194.8025, 2436.7863, 6.8840);
								SetPlayerFacingAngle(playerid, 353.7065);
								SetPlayerInterior(playerid, 0);
							}
						}
						case FRAC_GOV: //11
						{
							if(spawnType == 0)
							{ // Los Santos
								if(PlayerInfo[playerid][pLider] == 11)
								{
									SetPlayerPos(playerid, 1460.4297,-1853.9827,81.9475);
									SetPlayerVirtualWorld(playerid, 50);
									SetPlayerInterior(playerid, 0);
									PlayerInfo[playerid][pLocal] = 108;
									SetTimerEx("Wchodzenie", 1000, false, "i", playerid);
								}
								else
								{
									if(PlayerInfo[playerid][pRank] >= 1)
									{
										SetPlayerPos(playerid, 1445.3516,-1827.1736,81.4602);
										SetPlayerFacingAngle(playerid, 0.0);
										SetPlayerVirtualWorld(playerid, 50);
										SetPlayerInterior(playerid, 0);
										PlayerInfo[playerid][pLocal] = 108;
									}
									else
									{
										SetPlayerPos(playerid, 1471.8883,-1811.8147,77.9612);
										SetPlayerFacingAngle(playerid, 4.6505);
										SetPlayerVirtualWorld(playerid, 50);
										SetPlayerInterior(playerid, 0);
										PlayerInfo[playerid][pLocal] = 108;
									}
								}
							}
							else
							{ // Vice City
								SetPlayerPos(playerid, -4897.7461, 2953.5726, 6.5759);
								SetPlayerFacingAngle(playerid, 269.8782);
								SetPlayerInterior(playerid, 0);
							}
						}
						default:
						{ // Vice City
							SetPlayerPos(playerid, -3970.3354, 972.6067, 7.0385);
							SetPlayerFacingAngle(playerid, 252.7065);
							SetPlayerInterior(playerid, 0);
						}
				    }
				}
				else if(GetPlayerOrg(playerid) > 0) //Spawn Organizacji
				{
                    new org = GetPlayerOrg(playerid);
		            if(OrgInfo[org][o_Spawn][0] != 0.0)
		            {
		                SetPlayerVirtualWorld(playerid, OrgInfo[org][o_VW]);
		    		    SetPlayerInterior(playerid, OrgInfo[org][o_Int]);
		    		    SetPlayerPos(playerid, OrgInfo[org][o_Spawn][0], OrgInfo[org][o_Spawn][1], OrgInfo[org][o_Spawn][2]);
		    		    SetPlayerFacingAngle(playerid, OrgInfo[org][o_Spawn][3]);
		            }
		            else
		            {
						SendClientMessage(playerid, COLOR_YELLOW, "Twoja organizacja nie ma jeszcza spawnu - spawnujesz siê jako cywil");
						SetPlayerPos(playerid, -3970.3354, 972.6067, 7.0385); // Vice City motel
					}
				}
				else if(PlayerInfo[playerid][pJob] > 0) //Spawn Prac
				{
					new job = PlayerInfo[playerid][pJob];
					new i;
					if(spawnType == 0)
					{ // Los Santos
						i = 0;
					}
					else
					{ // Vice City
						i = spawnType - 2;
						if(i > MAX_JOB_SPAWNS)
						{
							MruMessageError(playerid, "B£¥D! Z£Y SPAWN");
							return 1;
						}
					}

					if(job <= 0 || job >= sizeof(JobInfo) || isnull(JobSpawns[job][i][JOB_SPAWN_NAME]))
					{
						if(PlayerCanSpawnWihoutTutorial(playerid))
						{
							//Spawn cywila
							SetPlayerPos(playerid, 1742.9498, -1860.8604, 13.5782);
							SetPlayerFacingAngle(playerid, 0.94);
							SetPlayerInterior(playerid, 0);
							MruMessageError(playerid, "B£¥D! Masz niepoprawn¹ pracê, zg³oœ siê do admina.");
						}
					}
					else
					{
						SetPlayerPos(playerid, 
							JobSpawns[job][i][JOB_SPAWN_X], 
							JobSpawns[job][i][JOB_SPAWN_Y], 
							JobSpawns[job][i][JOB_SPAWN_Z]);
						SetPlayerFacingAngle(playerid,
							JobSpawns[job][i][JOB_SPAWN_A]);
						SetPlayerInterior(playerid,
							JobSpawns[job][i][JOB_SPAWN_INT]);
						SetPlayerVirtualWorld(playerid,
							JobSpawns[job][i][JOB_SPAWN_VW]);

						if(JobSpawns[job][i][JOB_SPAWN_ANTI_FALL])
						{
							Wchodzenie(playerid);
						}
					}
				}
				else //Spawn cywila
				{
					if(PlayerCanSpawnWihoutTutorial(playerid))
					{
						if(spawnType == 0)
						{ // Los Santos
							SetPlayerPos(playerid, 1742.9498, -1860.8604, 13.5782);
							SetPlayerFacingAngle(playerid, 0.94);
							SetPlayerInterior(playerid, 0);
						}
						else
						{ // Vice City
							SetPlayerPos(playerid, -3970.3354, 972.6067, 7.0385); // Vice City motel
							SetPlayerFacingAngle(playerid, 252.4531);
							SetPlayerInterior(playerid, 0);
						}
					}
				}
		    }
		    else if(PlayerInfo[playerid][pSpawn] == 1) //Spawn przed domem
		    {
		        new i;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
				Wchodzenie(playerid);
                SetPlayerPos(playerid, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]);
	  		}
	  		else if(PlayerInfo[playerid][pSpawn] == 2) //Spawn w œrodku domu
	  		{
	  		    new i, h, m;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
				GetPlayerTime(playerid, h, m);
   				SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
     			PlayerInfo[playerid][pDomT] = h;
                PlayerInfo[playerid][pDomWKJ] = PlayerInfo[playerid][pDom];
                SetPlayerPos(playerid, Dom[i][hInt_X], Dom[i][hInt_Y], Dom[i][hInt_Z]);
                SetPlayerInterior(playerid, Dom[i][hInterior]);
                SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
                GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
	  		}
		}
	}

    //Ustawienie kamery:
    if(GetPVarInt(playerid, "spawn"))
		DeletePVar(playerid, "spawn");
    SetCameraBehindPlayer(playerid);
	return 1;
}

SetPlayerSpawnWeapon(playerid)
{
	//Resetowanie broni
    ResetPlayerWeapons(playerid);

    //Dawanie spawnowych broni
	if(GetPlayerFraction(playerid))
    	DajBronieFrakcyjne(playerid);
	if(GetPlayerOrg(playerid))
		GivePlayerOrgGun(playerid);
	if(PlayerInfo[playerid][pJob])
	    DajBroniePracy(playerid);
    if(MaZapisanaBron(playerid))
		PrzywrocBron(playerid);

    //HP:
	if(PlayerInfo[playerid][pInjury] == 0 && PlayerInfo[playerid][pBW] == 0)
	{
		if(IsAPolicja(playerid) && OnDuty[playerid] == 1)
		{
			SetPlayerHealth(playerid, PlayerInfo[playerid][pSHealth]+50.0);
			//f(PlayerInfo[playerid][pMember] != 1 || PlayerInfo[playerid][pLider] != 1)
			//SetPlayerArmour(playerid, 15);
		}
		else if(IsAPrzestepca(playerid))
		{
			SetPlayerHealth(playerid, PlayerInfo[playerid][pSHealth]+50.0);
			//SetPlayerArmour(playerid, 15);
		}
		else
		{
			SetPlayerHealth(playerid, PlayerInfo[playerid][pSHealth]+50.0);
		}
	}
	return 1;
}

SetPlayerSpawnSkin(playerid)
{
	if((PlayerInfo[playerid][pSkin] > 20000 && PlayerInfo[playerid][pSkin] < 20099) && PlayerInfo[playerid][pSkin] != 20004)
	{
		sendTipMessage(playerid, "MRP-SKINS: Wykryto u Ciebie skin eventowy - zostaje Ci ustalona domyœlna wartoœæ");
		PlayerInfo[playerid][pSkin] = 299;
	}

	if((JobDuty[playerid] == 1 || OnDuty[playerid] == 1) && PlayerInfo[playerid][pUniform] > 0) {
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
	}
	else
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
	}
	
	if(isNaked[playerid] == 1)
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
		isNaked[playerid] = 0;
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	new string[128];

	if(Sila_OnPlayerEnterCheckpoint(playerid))
	{
		return 1;
	}

	if(Driver_OnPlayerEnterCheckpoint(playerid))
	{
		return 1;
	}

    TJD_CallCheckpoint(playerid, GetPlayerVehicleID(playerid));

	// medic checkpoints
	if(MedicCallTime[playerid] > 0)
	{
		MedicCallTime[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
		return 1;
	}

	// mechanic checkpoints
	if(MechanicCallTime[playerid] > 0)
	{
		MechanicCallTime[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
		return 1;
	}

	// Wyœcigi ¿uŸlowe
	if(zawodnik[playerid] == 1)
	{
		if(okregi[playerid] == 5)
		{
		    if(iloscwygranych == 0)
		    {
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Wygra³ %s - ukoñczy³ wyœcig zajmuj¹c 1 miejsce !!!.", sendername);
				ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
			}
			else if(iloscwygranych == 1)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 2 miejsce !!.", sendername);
				ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
			}
			else if(iloscwygranych == 2)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 3 miejsce !.", sendername);
				ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
			}
			else
			{
			    iloscwygranych ++;
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c %d miejsce !.", sendername, iloscwygranych);
				ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
			}
	   	}
  		else if(okrazenia[playerid] == 0)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1057.6370,-994.5727,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 1)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.9596,-975.8777,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 2)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1114.9780,-985.8290,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 3)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1115.5585,-987.0826,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 4)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.2609,-1006.3092,128.9274, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] = 0;
	        okregi[playerid] ++;
	    }
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(Przemytnik_OnPlayerEnterRaceCP(playerid))
	{
		return 1;
	}

	if(Driver_OnPlayerEnterRaceCP(playerid))
	{
		return 1;
	}

    TJD_CallRaceCheckpoint(playerid);
	if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0 && Scigamy != 666)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
		{
			return 1;
	    }
	    //
	    if(IloscCH[playerid] == (Wyscig[Scigamy][wCheckpointy]-1))
	    {
            PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        if(Wyscig[Scigamy][wTypCH] == 0)
	        {
	       	 	SetPlayerRaceCheckpoint(playerid,1,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
			else
			{
				SetPlayerRaceCheckpoint(playerid,4,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
	    }
	    else if(IloscCH[playerid] == Wyscig[Scigamy][wCheckpointy])
	    {
	        DisablePlayerRaceCheckpoint(playerid);
	        PlayerPlaySound(playerid, 1139, 0, 0, 0);
	        new string[128];
	        //
	        if(Ukonczyl == 1)
	        {
	            SendClientMessage(playerid, COLOR_YELLOW, "|_________ GRATULACJE!!!! _________|");
        		SendClientMessage(playerid, COLOR_LIGHTGREEN, "| Ukoñczy³eœ wyœcig jako pierwszy! |");
				format(string, sizeof(string), "|   Otrzymujesz %d$ nagrody!   |", Wyscig[Scigamy][wNagroda]); SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
	        	SendClientMessage(playerid, COLOR_LIGHTGREEN, "|__________________________________|");
	        	DajKase(playerid, Wyscig[Scigamy][wNagroda]);
	        	if(Ukonczyl >= IloscZawodnikow)
		        {
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		        	format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s wygra³ wyœcig %s", GetNickEx(playerid), Wyscig[Scigamy][wNazwa]);
		        	foreach(new i : Player)
		        	{
		        	    if(ScigaSie[i] == Scigamy && i != playerid)
		        	    {
							SendClientMessage(i, COLOR_YELLOW, "|_________ UWAGA!!!! _________|");
		        			SendClientMessage(i, COLOR_YELLOW, string);
		        		}
				    }
				    Ukonczyl++;
				}
	        }
	        else
	        {
	            if(Ukonczyl >= IloscZawodnikow)
		        {
		            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Ukoñczy³eœ wyœcig jako ostatni - cienias!");
					format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s ukoñczy³ wyœcig jako ostatni !", GetNickEx(playerid));
					WyscigMessage(COLOR_YELLOW, string);
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		            format(string, sizeof(string), "Ukoñczy³eœ wyœcig jako %d !", Ukonczyl);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
					format(string, sizeof(string), "Komunikat wyœcigu: {FFFFFF}%s ukoñczy³ wyœcig jako %d !", GetNickEx(playerid), Ukonczyl);
					WyscigMessage(COLOR_YELLOW, string);
	            	Ukonczyl++;
		        }
	        }
	        IloscCH[playerid] = 0;
	    }
	    else
	    {
			PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        SetPlayerRaceCheckpoint(playerid,Wyscig[Scigamy][wTypCH],wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],wCheckpoint[Scigamy][ch+1][0], wCheckpoint[Scigamy][ch+1][1], wCheckpoint[Scigamy][ch+1][2], Wyscig[Scigamy][wRozmiarCH]);
	    }
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Driver_OnPlayerEditObject(playerid, objectid, response, x, y, z, rx, ry, rz)) return 1;

	if(IsValidDynamicObject(objectid))
	{
		if(GetPVarInt(playerid, "Allow-edit") && response == EDIT_RESPONSE_FINAL)
		{
			new year, month, day;
			getdate(year, month, day);
			MoveDynamicObject(objectid, x, y, z, 10.0, rx, ry, rz);
			SendClientMessage(playerid, COLOR_WHITE, sprintf(
				"Object moved to: X: %.4f, Y: %.4f, Z: %.4f, RX: %.4f, RY: %.4f, RZ: %.4f and saved to file objects/%s_%d_%d_%d_%d.txt", 
				x, y, z, rx, ry, rz, GetNick(playerid), year, month, day, AdminObjectsVer[playerid]));
			AppendToPlayerObjectFiles(playerid, objectid);
		}

        if(response < EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new str[128];
            new frac = GetPlayerFraction(playerid);
            format(str, 128, "[%d]\n%s\n%s", GetPVarInt(playerid, "Barier-id")-1, FractionNames[frac],GetNickEx(playerid));

            if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
            {
                new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
                GetDynamicObjectRot(objectid, rox, roy, roz);
                GetDynamicObjectPos(objectid, X, Y, Z);
                SendClientMessage(playerid, -1, "Jesteœ za daleko.");
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, 0x1E90FFFF, X, Y, Z+0.3, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid));
                SetDynamicObjectPos(objectid, X, Y, Z);
                SetDynamicObjectRot(objectid, rox, roy, roz);
            }
            else
            {
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, 0x1E90FFFF, x, y, z+0.3, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid));
                GetDynamicObjectPos(objectid, x, y, z);
                GetDynamicObjectRot(objectid, rx, ry, rz);
            }
            SetPVarInt(playerid, "Barier-id", 0);
        }
        else if(response == EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
            GetDynamicObjectRot(objectid, rox, roy, roz);
            GetDynamicObjectPos(objectid, X, Y, Z);
            for(new i=0;i<MAX_PLAYERS;i++)
            {
                if(GetPlayerSurfingObjectID(i) == objectid)
                {
                    SendClientMessage(i, 0xFF0000FF, "Zejdz z obiektu!!");
                    GetPlayerPos(i, rox, roy, roz);
                    SetPlayerPos(i, rox+0.3,roy+0.3,roz+0.2);
                    SetPlayerVelocity(i, 0.15, 0.12, 0.1);
                }
            }
            if(!IsPlayerInRangeOfPoint(playerid, 5.0, x,y,z))
            {
                SendClientMessage(playerid, 0xFF0000FF, "Podejdz do obiektu!");
                SetDynamicObjectPos(objectid, X, Y, Z);
            }
            else
            {
                new Float:speed = VectorSize(X-x, Y-y, Z-z);
                MoveDynamicObject(objectid, x, y, z, speed, rx, ry, rz);
            }
        }
		else if(response == EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
			new frac = GetPlayerFraction(playerid);
            GetDynamicObjectRot(objectid, rox, roy, roz);
            GetDynamicObjectPos(objectid, X, Y, Z);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, x,y,z))
            {
                SendClientMessage(playerid, 0xFF0000FF, "Podejdz do graffiti!");
                SetDynamicObjectPos(objectid, X, Y, Z);
            }
            else
            {
                new Float:speed = VectorSize(X-x, Y-y, Z-z);
                MoveDynamicObject(objectid, x, y, z, speed, rx, ry, rz);
            }
			if( GetPVarInt(playerid, "zoneid") == -1 || (ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) ) 
        	{
				SendClientMessage(playerid, 0xFF0000FF, "Musisz byæ na swojej strefie!");
                SetDynamicObjectPos(objectid, X, Y, Z);
			}
		}
		else if( response == EDIT_RESPONSE_FINAL && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new f = GetPVarInt(playerid, "GraffitiID");
			new frac = GetPlayerFraction(playerid);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, x,y,z))
            {
                GameTextForPlayer(playerid, "~r~Byles za daleko.",2000, 5);
                graffiti_DeleteMySQL(f);
				graffiti_ZerujZmienne(playerid);
				graffiti_Zeruj(f);
				return 1;
			}
			if( GetPVarInt(playerid, "zoneid") == -1 || (ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) )
        	{
				SendClientMessage(playerid, 0xFF0000FF, "Nie by³eœ na swojej strefie!");
                graffiti_DeleteMySQL(f);
				graffiti_ZerujZmienne(playerid);
				graffiti_Zeruj(f);
				return 1;
			}
			GraffitiInfo[f][grafXpos] = x;
			GraffitiInfo[f][grafYpos] = y;
			GraffitiInfo[f][grafZpos] = z;
			GraffitiInfo[f][grafXYpos] = rx;
			GraffitiInfo[f][grafYYpos] = ry;
			GraffitiInfo[f][grafZYpos] = rz;
			GameTextForPlayer(playerid, "~g~Stworzono.",2000, 5);
			graffiti_UpdateMySQL(f);
			graffiti_ReloadForPlayers(f);
			graffiti_ZerujZmienne(playerid);
			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			new akcja[150];
			format(akcja,sizeof(akcja),"* %s wyci¹ga spray i tworzy nim napis.",GetNick(playerid));
            ProxDetector(40.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(akcja, sizeof(akcja), "%s [%d] stworzy³ nowe graffiti [ID: %d], lokalizacja: %s", GetNick(playerid), playerid, f, pZone);
			SendAdminMessage(COLOR_PANICRED, akcja);
			Log(serverLog, INFO, "%s stworzy³ nowe graffiti %s, lokalizacja: %s", GetPlayerLogName(playerid), GetGraffitiLogText(f), pZone);
		}
		else if( response == EDIT_RESPONSE_CANCEL && GetPVarInt(playerid, "CreatingGraff") == 1)
		{
			new f = GetPVarInt(playerid, "GraffitiID");
			graffiti_DeleteMySQL(f);
			GameTextForPlayer(playerid, "~r~Usunieto!",2000, 5);
			graffiti_ZerujZmienne(playerid);
		}
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new player=-1;
    new pip[16];
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        GetPlayerIp(i, pip, sizeof(pip));
        if(strcmp(ip, pip, true)==0)
        {
            player=i;
            break;
        }
    }
    if(!success)
    {
        if(player != -1)
        {
            SendClientMessage(player, COLOR_PANICRED, "Otrzymujesz kicka z powodu nieautoryzowanej próby logowania przez RCON!");
            KickEx(player, "nieautoryzowany rcon login");
        }
    }
    else
    {
        if(player != -1)
        {
			new name[32]; format(name, sizeof(name), "rcon/%s", GetNick(player));
			if(!dini_Exists(name))
			{
				new str[128];
				format(str, 128, "RCON: U¿ytkownik %s (%d) próbowa³ siê zalogowaæ na rcona bez wymaganych uprawnieñ!", GetNickEx(player), player);
				SendAdminMessage(COLOR_PANICRED, str);
				KickEx(player, "nieautoryzowany rcon login");
				print(str);
				return 0;
			}
			else
			{
				SendClientMessage(player, COLOR_LIGHTBLUE, "Witaj, Rkornisto");
			}
        }
    }
    return 1;
}

public OnRconCommand(cmd[])
{
    print(cmd);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	for(new i; i<sizeof(ShopPickups); i++)
	{
		if(ShopPickups[i] == pickupid)
		{
			if(gettime() - GetPVarInt(playerid, "picked-up") < 60)
			{
				return 1;	
			}
			SetPVarInt(playerid, "picked-up", gettime());
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"|_______________Wybór skina - dostêpne komendy_______________|");
			SendClientMessage(playerid,COLOR_WHITE,"{3CB371}/ubranie{FFFFFF}- zabija i przenosi do zwyk³ego menu wyboru skinów (wybiera³ka). Tylko dla cywili.");
			SendClientMessage(playerid,COLOR_WHITE,"{CD5C5C}/wybierzskin{FFFFFF} - pozwala wybraæ skin przydzielany po s³u¿bie. Tylko dla frakcji z dzia³aj¹cym /duty.");
			SendClientMessage(playerid,COLOR_WHITE,"{ADFF2F}/uniform{FFFFFF}- pozwala na zmianê uniformu s³u¿bowego. Tylko dla cz³onków frakcji i organizacji.");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"|___________________________________________________________|");
			return 1;
		}
	}

	CollectMoneyPickup(playerid, pickupid);
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	new string[256];

	// Zapobieganie wsiadania do pojazdu podczas BW:	
	if(!isPlayerCuffed[playerid] && (PlayerInfo[playerid][pInjury] > 0 && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)))
	{
		return PlayerEnterVehOnInjury(playerid);
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(GetPVarInt(playerid, "Timer_OnChangingWeapon"))
		{
			AntySpam[playerid] = 0;
			//KillTimer(GetPVarInt(playerid, "Timer_OnChangingWeapon"));
			DeletePVar(playerid, "Timer_OnChangingWeapon");
		}
		if(newstate == PLAYER_STATE_DRIVER)
        {
			SetPlayerArmedWeapon(playerid, PlayerInfo[playerid][pGun0]); //anty driveby
			new vehicleid = GetPlayerVehicleID(playerid);
        	new lcarid = VehicleUID[vehicleid][vUID];
        	if(CarData[lcarid][c_OwnerType] == CAR_OWNER_SPECIAL)
        	{
 				if(CarData[lcarid][c_Owner] == RENT_CAR)
    			{
					if (CarData[lcarid][c_Rang]-1 != playerid)
					{
						new stringDialog[128];
						new cost = GetVehicleHireCost(vehicleid);
						format(stringDialog, sizeof(stringDialog), "Mo¿esz wypo¿yczyæ ten pojazd\nCena: %d$ za 60 minut", cost);
		    			TogglePlayerControllable(playerid, 0);
						HireCar[playerid] = vehicleid;
						ShowPlayerDialogEx(playerid, 7079, DIALOG_STYLE_MSGBOX, "Wypo¿yczalnia pojazdów", stringDialog, "Wynajmij", "WyjdŸ");
					}
				}
			}
			SetPVarInt(playerid, "IsAGetInTheCar", 0); 
			ACv2_DrivingWithoutPremissions(playerid, vehicleid);
		}
        if(!ToggleSpeedo[playerid])
        {
            //Speedo
            //Licznik 2.5
            new Float:carhp;
            new vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleHealth(vehicleid, carhp);
            new Float:vel[3];
            GetVehicleVelocity(vehicleid, vel[0], vel[1], vel[2]);
            new Float:vSpeed = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
            new pZone[MAX_ZONE_NAME];
            GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);//Dzielnica
			if(floatround(vSpeed) > pCruiseSpeed[playerid]) vSpeed = pCruiseSpeed[playerid];
            format(string, 128,"Speed: %dkm/h~n~Paliwo: %d~n~Stan: %d~n~GPS: %s~n~%s" ,floatround(vSpeed), floatround(Gas[vehicleid]), floatround(carhp/10), pZone, VehicleNames[GetVehicleModel(vehicleid)-400]);
            PlayerTextDrawSetString(playerid, Licznik[playerid], string);
            PlayerTextDrawShow(playerid, Licznik[playerid]);
        }
        //AT400
        if(Car_GetOwnerType(GetPlayerVehicleID(playerid)) == CAR_OWNER_FRACTION && GetVehicleModel(GetPlayerVehicleID(playerid)) == 577 && !IsPlayerInFraction(playerid, FRAC_KT, 5000))
        {
            new Float:slx, Float:sly, Float:slz;
    		GetPlayerPos(playerid, slx, sly, slz);
    		SetPlayerPos(playerid, slx, sly, slz+0.2);
    		ClearAnimations(playerid);
        }
		if(IsACopCar(GetPlayerVehicleID(playerid)) && IsAPolicja(playerid)) sendTipMessageEx(playerid, COLOR_BLUE, "Po³¹czy³eœ siê z komputerem policyjnym, wpisz /mdc aby zobaczyæ kartotekê policyjn¹");
        if(newstate == PLAYER_STATE_DRIVER) TJD_CallEnterVeh(playerid, GetPlayerVehicleID(playerid));
    }
    else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_EXIT_VEHICLE)
    {
		DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        new vehicleid = GetPVarInt(playerid, "car-id");
        if(VehicleUID[vehicleid][vSiren] != 0)
    	{
    	    new sendername[MAX_PLAYER_NAME], komunikat[128];
    	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
     		VehicleUID[vehicleid][vSiren] = 0;
      		GetPlayerName(playerid, sendername, sizeof(sendername));
    		format(komunikat, sizeof(komunikat), "* %s zdejmuje kogut z dachu i chowa.", sendername);
    		ProxDetector(30.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	}
        if(TransportDuty[playerid] > 0) //Taxi duty
		{
            Taxi_FareEnd(playerid);
		}

		DrugDealer_OnPlayerExitVehicle(playerid);

        TJD_CallExitVeh(playerid);

        if(NieSpamujKradnij[playerid] == 1 || HireCar[playerid] != 0)
        {
            TogglePlayerControllable(playerid, 1);
        }
        //Speedo
        PlayerTextDrawHide(playerid, Licznik[playerid]);
        //

        #if BLINK_DISABLE_ON_EXIT_VEHICLE == 0
        #else
        if(BlinkSide[GetPVarInt(playerid, "blink-car")] != 2) DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        #endif
    }
    if(oldstate == PLAYER_STATE_PASSENGER)
    {
		Driver_OnPassengerExitVehicle(playerid);
		PlayerTextDrawHide(playerid, Licznik[playerid]);
    }
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(playerid, "IsAGetInTheCar", 0); 
		SetPlayerArmedWeapon(playerid, MyWeapon[playerid]); //back weapon antydriveby
	}
	if(newstate == PLAYER_STATE_PASSENGER) // TAXI & BUSSES
	{
		SetPVarInt(playerid, "IsAGetInTheCar", 0);
	    if(GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 27 || GetPlayerWeapon(playerid) == 23)
	    {
	        SetPlayerArmedWeapon(playerid,0);
	    }
	    if(GetPVarInt(playerid, "sanlisten") == 1)
        {
            if(RadioSANUno[0] != EOF)
 				PlayAudioStreamForPlayer(playerid, RadioSANUno);
        }
        else if(GetPVarInt(playerid, "sanlisten") == 2)
        {
            if(RadioSANDos[0] != EOF)
				PlayAudioStreamForPlayer(playerid, RadioSANDos);
        }

	    new vehicleid = GetPlayerVehicleID(playerid);
	    foreach(new i : Player)
		{
			if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2)
			{
				Driver_OnPassengerEnterVeh(i, playerid);
				break;
			}
		}
	}
	if(newstate == PLAYER_STATE_WASTED)
	{
		//przeniesiono do onplayerdeath
	}
	if(newstate == PLAYER_STATE_DRIVER) //buggy dont finnish
	{// 38 / 49 / 56 = SS
		new newcar = GetPlayerVehicleID(playerid);
        //NOWY SYSTEM AUT FRAKCYJNYCH I PUBLICZNYCH
        if(Car_IsStealable(newcar)) //do kradziezy
        {
			new is_veh_deluxe = false, steal_impossible = false;

			for(new i = 0; i < sizeof(deluxe_cars_for_stealing_ids); i++)
			{
				if(deluxe_cars_for_stealing_ids[i] == newcar)
				{
					is_veh_deluxe = true;
					break;
				}
			}

			if(is_veh_deluxe)
			{
				if(PlayerInfo[playerid][pJob] != JOB_CARTHIEF || PlayerInfo[playerid][pJackSkill] < 400)
				{
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Potrzebujesz pracy z³odzieja aut i 5 skilla, by ukraœæ ten wóz.");
					RemovePlayerFromVehicleEx(playerid);
					steal_impossible = true;
				}
				else
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Kradzie¿ tego wozu bardzo ci siê op³aci, jednak czujesz, ¿e coœ z nim jest nie tak...");
				}
			}

            if(KradniecieWozu[playerid] != newcar && !steal_impossible)
		    {
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Mo¿esz ukraœæ ten wóz, wpisz /kradnij aby spróbowaæ to zrobiæ.");
				new engine, lights, alarm, doors, bonnet, boot, objective;
				GetVehicleParamsEx(newcar, engine, lights, alarm, doors, bonnet, boot, objective);
				if(engine) SetVehicleParamsEx(newcar, 0, lights, alarm, doors, bonnet, boot, objective);
			}
        }
		if(newcar != INVALID_VEHICLE_ID) 
		{
			gLastCar[playerid] = newcar;
		}
	}
	if(newstate == PLAYER_STATE_SPAWNED)
	{
		if(IsPlayerPremiumOld(playerid)) 
		{ 
			SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]); 
		}
		else 
		{ 
			SetPlayerHealth(playerid, 50.0+PlayerInfo[playerid][pSHealth]); 
		}
		MedicBill[playerid] = 1;
		gPlayerSpawned[playerid] = 1;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
	{
		SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
		return 1;
	}
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
        return 0;
    }
	/*if(IsVehicleInCarPark(vehicleid))
	{
		new float:vPosX, float:vPosY, float:vPosZ; 
		GetVehiclePos(vehicleid, vPosX, vPosY, vPosZ);
		TempCarPark[vehicleid][0] = vPosX; 
		TempCarPark[vehicleid][1] = vPosY; 
		TempCarPark[vehicleid][2] = vPosZ; 
	}*/
    //AT400
    if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && GetVehicleModel(vehicleid) == 577 && IsPlayerInFraction(playerid, FRAC_KT, 5000))
    {
        GameTextForPlayer(playerid, "Wracaj szybko!", 5000, 5);
        SetPlayerPos(playerid, 0.1389+KTAir_Offsets[0],33.2975+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]);
        SetPlayerVirtualWorld(playerid, 2);
        Wchodzenie(playerid);
        SetCameraBehindPlayer(playerid);
    }

    if(GetPVarInt(playerid, "sanlisten") != 0)
    {
        StopAudioStreamForPlayer(playerid);
    }
	if (GetPlayerState(playerid) == 1)
	{
		return 1;
	}
	if(gGas[playerid] == 1)
	{
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Opuscil pojazd", 500, 3);
	}
	if(naprawiony[playerid] == 1)
	{
	    naprawiony[playerid] = 0;
	}
	if(IDWymienianegoAuta[playerid] != 0)
	{
	    IDWymienianegoAuta[playerid] = 0;
	}
	if(KradniecieWozu[playerid] == 1)
	{
		KradniecieWozu[playerid] = 0;
		NieSpamujKradnij[playerid] = 0;
		KillTimer(GetPVarInt(playerid, "timerKradnij"));
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

    //Zwrócenie 0 uniemo¿liwi spawn.
	if(gPlayerLogged[playerid] != 1)
	{

	}
	else
	{

	}
    return 0;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 0.0, -1, -1, -1, -1, -1, -1);

	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	if(gPlayerLogged[playerid] != 1 && RequestClassSpamProtection[playerid] == 0)
	{
		RequestClassSpamProtection[playerid] = 1;
		TogglePlayerSpectating(playerid, true);
		SetTimerEx("OPCLogin", 100, 0, "i", playerid);

		//Dla graczy którzy nie maj¹ najnowszej wersji samp'a
		PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);

		new rand = random(5);
		switch(rand)
		{
			case 0:
			{
				PlayerPlaySound(playerid, 171, 0.0, 0.0, 0.0);
			}
			case 1:
			{
				PlayerPlaySound(playerid, 176, 0.0, 0.0, 0.0);
			}
			case 2:
			{
				PlayerPlaySound(playerid, 1076, 0.0, 0.0, 0.0);
			}
			case 3:
			{
				PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
			}
			case 4:
			{
				new rand2 = random(8);
				switch(rand2)
				{
					case 0:
					{
						PlayerPlaySound(playerid, 157, 0.0, 0.0, 0.0);
					}
					case 1:
					{
						PlayerPlaySound(playerid, 162, 0.0, 0.0, 0.0);
					}
					case 2:
					{
						PlayerPlaySound(playerid, 169, 0.0, 0.0, 0.0);
					}
					case 3:
					{
						PlayerPlaySound(playerid, 178, 0.0, 0.0, 0.0);
					}
					case 4:
					{
						PlayerPlaySound(playerid, 180, 0.0, 0.0, 0.0);
					}
					case 5:
					{
						PlayerPlaySound(playerid, 181, 0.0, 0.0, 0.0);
					}
					case 6:
					{
						PlayerPlaySound(playerid, 147, 0.0, 0.0, 0.0);
					}
					case 7:
					{
						PlayerPlaySound(playerid, 140, 0.0, 0.0, 0.0);
					}
				}
			}
		}
	}
	else
	{
		TogglePlayerSpectating(playerid, true);
		TogglePlayerSpectating(playerid, false);
	}
	return 0;
}

CalculateInterest(playerid) 
{
	new money = PlayerInfo[playerid][pAccount];
	if(money <= 1000 || money > 100000000) {
		// 0.1% odsetek przy d³ugach
		return floatround(float(money) * 0.001, floatround_ceil);
	}

	new Float:interest = (float(money) * (1.3 - 0.067 * floatlog(float(money))) / 1000);
	new Float:interestMultiplier = 1;
	if (PlayerInfo[playerid][pDom] != 0) {
		interestMultiplier = 2;
	}
	if (IsPlayerPremiumOld(playerid) || IsPlayerPremium(playerid)) {
		interestMultiplier *= 2;
	}

	return floatround(interest * interestMultiplier, floatround_ceil);
}

PayDay()
{
	new string[128], account,playername2[MAX_PLAYER_NAME], checks, ebill;
	new hour,minuite,second;
	gettime(hour,minuite,second);

	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLevel] > 0)
		    {
			    if(MoneyMessage[i]==1)
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "Nie sp³aci³eœ d³ugu, wierzyciele nas³ali na ciebie Policjê!");
					PoziomPoszukiwania[i] += 2;
					SetPlayerCriminal(i,INVALID_PLAYER_ID, "Niesp³acanie d³ugu");
				}
				GetPlayerName(i, playername2, sizeof(playername2));
				account = PlayerInfo[i][pAccount];

				if(PlayerInfo[i][pPayDay] >= 5)
				{
				    if(PlayerInfo[i][pAdmin] >= 1)
				    {
				        format(string, sizeof(string), "Admini/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
				    else if (PlayerInfo[i][pZG] >= 1)
				    {
				        format(string, sizeof(string), "Zaufani/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
				    Tax += TaxValue;//Should work for every player online
				    PlayerInfo[i][pAccount] -= TaxValue;
					checks = PlayerInfo[i][pPayCheck];
				    ebill = (PlayerInfo[i][pAccount]/10000)*(PlayerInfo[i][pLevel]);
				    DajKase(i, checks);
				    if(PlayerInfo[i][pAccount] > 0)
				    {
				    	PlayerInfo[i][pAccount] -= ebill;
					}
					else
					{
					    ebill = 0;
					}
					new interest = CalculateInterest(i);
					new Float:interestRate;
					if(PlayerInfo[i][pAccount] != 0) {
						interestRate = (float(interest)/float(PlayerInfo[i][pAccount])) * 100.0;
					}
					if(IsPlayerAtViceCity(i) && hour >= 18 && hour <= 24)
					{
						interestRate *= 1.25;
					}

					PlayerInfo[i][pExp]++;
					PlayerPlayMusic(i);
					if(PlayerInfo[i][pAccount] <= 100000000)
					{
						PlayerInfo[i][pAccount] = account + interest;
					}
					SendClientMessage(i, COLOR_WHITE, "|___ STAN KONTA ___|");
					format(string, sizeof(string), "  Wyp³ata: $%d   Podatek: -$%d", checks, TaxValue);
					SendClientMessage(i, COLOR_GRAD1, string);
					if(PlayerInfo[i][pDom] != 0 || PlayerInfo[i][pPbiskey] != 255)
					{
					    format(string, sizeof(string), "  Rachunek za pr¹d: -$%d", ebill);
						SendClientMessage(i, COLOR_GRAD1, string);
					}
					format(string, sizeof(string), "  Stan konta: $%d", account);
					SendClientMessage(i, COLOR_GRAD1, string);
					if(PlayerInfo[i][pAccount] <= 100000000)
					{
						format(string, sizeof(string), "  Odsetki: %.3f procent", interestRate);
						SendClientMessage(i, COLOR_GRAD2, string);
						format(string, sizeof(string), "  Zysk z odsetek $%d", interest);
						SendClientMessage(i, COLOR_GRAD3, string);
					}
					else
					{
					    format(string, sizeof(string), "  Podatek dochodowy: 0.0 procent");
						SendClientMessage(i, COLOR_GRAD2, string);
						format(string, sizeof(string), "  Strata z podatku $0");
						SendClientMessage(i, COLOR_GRAD3, string);
					}

					FrontBiz_OnPayDay(i);

					SendClientMessage(i, COLOR_GRAD4, "|--------------------------------------|");
					format(string, sizeof(string), "  Nowy Stan Konta: $%d", PlayerInfo[i][pAccount]);
					SendClientMessage(i, COLOR_GRAD5, string);
					format(string, sizeof(string), "  Wynajem: -$%d", Dom[PlayerInfo[i][pWynajem]][hCenaWynajmu]);
					SendClientMessage(i, COLOR_GRAD5, string);
					BusinessPayDay(i);  
					format(string, sizeof(string), "~y~Wyplata");
					GameTextForPlayer(i, string, 5000, 1);
					PlayerInfo[i][pPayDay] = 0;
					PlayerInfo[i][pPayCheck] = 0;
					PlayerInfo[i][pConnectTime] += 1;
					Redis_SetInt(RedisClient, sprintf("player:%d:zdrapka", PlayerInfo[i][pUID]), 0);
					if(PlayerInfo[i][pBP] >= 1)
					{
					    PlayerInfo[i][pBP]--;
					}
					if(IsPlayerPremiumOld(i))
					{
					    PlayerInfo[i][pPayDayHad] += 1;
					    if(PlayerInfo[i][pPayDayHad] >= 5)
					    {
					        PlayerInfo[i][pExp]++;
					        PlayerInfo[i][pPayDayHad] = 0;
					    }
					}
					SetWeatherEx(2+random(19));//Pogoda dla ka¿dego
					if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)//Zerowanie pogody dla graczy w intkach
					{
						SetInteriorTimeAndWeather(i);
					}
     				if(PoziomPoszukiwania[i] >= 10)
					{
						PoziomPoszukiwania[i] = 9;
					}
					else if(PoziomPoszukiwania[i] == 0)
					{
                    	PoziomPoszukiwania[i] = 0;
                    }
                    else
					{
						PoziomPoszukiwania[i] -= 1;
						format(string, sizeof(string), "  Aktualny poziom poszukiwania to %d", PoziomPoszukiwania[i]);
						SendClientMessage(i, COLOR_WHITE, string);
					}

				}
				else
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "* Nie grasz wystarczaj¹co d³ugo, aby dostaæ wyp³atê.");
				}
				SetPlayerWantedLevel(i, PoziomPoszukiwania[i]);
			}
		}
	}
    printf("-> Updating GangZones");
    Zone_GangUpdate(true);

	new rand = random(80);
    FixHour(hour);
	if(10 <= shifthour <= 24)
	{
	 	if(rand == 0) rand = 1;
        printf("-> Starting lotto");
	  	Lotto(rand);
	}
  	SendClientMessageToAll(COLOR_YELLOW, "Odliczanie do respawnu rozpoczête");
	BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
    printf("-> Doing respawn");
	CountDownVehsRespawn();
	SendRconCommand("reloadlog");
	SendRconCommand("reloadbans");
	
	if(!DmvActorStatus)
	{
		CreateActorsInDMV(INVALID_PLAYER_ID);
	}

	if(shifthour == 3)
	{
	    SendClientMessageToAll(COLOR_YELLOW, "Trwa aktualizacja systemu domów, czas na laga");
	    for(new h; h <= dini_Int("Domy/NRD.ini", "NrDomow"); h++)
	    {
			if(Dom[h][hKupiony])
			{
				Dom[h][hData_DD] ++;
				// if(Dom[h][hData_DD] >= 30)
				// {
				// 	ZlomowanieDomu(9999, h);
				// 	Log(serverLog, INFO, "Dom %s zosta³ zez³omowany z powodu up³ywu czasu.", GetHouseLogName(h));
				// }
			}
	    }
		ZapiszDomy();

		AccountOrgsCosts();
	}
	else if(shifthour == 4)
	{
	    foreach(new i : Player)
		{
			Kick(i);
		}
	    ZapiszDomy();
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST¥PI RESTART SERWERA!!!!");
        SendClientMessageToAll(COLOR_YELLOW, "RESET");
        SendRconCommand("gmx");
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{			
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	if((PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) && IsPlayerAimingEx(playerid))
	{
		return FreezePlayerOnInjury(playerid);
	}

    systempozarow_OnPlayerUpdate(playerid);//System Po¿arów v0.1

	//Anty BH
	if(GetPVarInt(playerid, "Jumping") == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerVelocity(playerid, x, y, z);
		if(z > 0.05)
		{
			SetPlayerVelocity(playerid, x*0.4, y*0.4, z);
			SetPVarInt(playerid, "Jumping", -1);
		}
	}

    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        new model = GetVehicleModel(veh);
        if(model == 425 || model == 432)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_FIRE))
			{
				return 0; //desycn missile
			}
        }
        else if(model == 520)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_ACTION))
			{
				return 0; //desycn hydra missile
			}
        }
    }
    new vid = GetPlayerVehicleID(playerid);
    if(vid > 0)
    {
        if(vid != LastVehicleID[playerid])
        {
            if(GetTickDiff(GetTickCount(), VehicleIDChangeTime[playerid]) < 2000)
            {
                VehicleIDChanges[playerid]++;
                if(VehicleIDChanges[playerid] > MAX_VEHICLE_ID_CHANGES)
                {
                    GetPlayerPos(playerid, czitX, czitY, czitZ);
                    if(GetPVarInt(playerid, "ACmessaged") == 0)
                    {
                        format(acstr, 128, "%s mo¿e lagowaæ autami i dosta³ kicka U¿yj /gotoczit aby to sprawdziæ!", GetNickEx(playerid));
                        SendAdminMessage(COLOR_P@, acstr);
                        SetPVarInt(playerid, "ACmessaged", 1);
                    }
                    Kick(playerid);
                    return 0;
                }
            }
            else VehicleIDChanges[playerid] = 1;
        }
        LastVehicleID[playerid] = vid;
        VehicleIDChangeTime[playerid] = GetTickCount();
    }
    //
    if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickDiff(GetTickCount(), noclipdata[playerid][lastmove]) > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
                if(noclipdata[playerid][fireobject] != 0) StopDynamicObject(noclipdata[playerid][fireobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        new keys, ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(ud == KEY_DOWN) Oil_OnPlayerPress(playerid, KEY_DOWN);
        else if(ud == KEY_UP) Oil_OnPlayerPress(playerid, KEY_UP);
        if(lr == KEY_RIGHT) Oil_OnPlayerPress(playerid, KEY_RIGHT*2);
        else if(lr == KEY_LEFT) Oil_OnPlayerPress(playerid, KEY_LEFT*2);
    }
	if(GetPVarInt(playerid, "timer_CruiseControl") && pCruiseCanChange[playerid] == 1)
    {
        new keys, ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(ud == KEY_DOWN) CruiseControl_SetSpeed(playerid, 10, false);
        else if(ud == KEY_UP) CruiseControl_SetSpeed(playerid, 10, true);
    }
	if(Spectate[playerid] != INVALID_PLAYER_ID && !GetPVarInt(playerid, "OnSpecChanging"))
    {
		new keys, ud,lr, actualid = INVALID_PLAYER_ID;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(lr == KEY_RIGHT) //NEXT
		{
			foreach(new i : Player)
			{
				if(i == playerid || PlayerInfo[i][pAdmin] >= 1) continue;
				if(actualid != INVALID_PLAYER_ID) //if is set
				{
					new str[6];
                	valstr(str, i);
                    RunCommand(playerid, "/spec",  str);
					break;
				}
                else if(i == Spectate[playerid]) //if not set and expect
				{
					actualid = i;
				}
            }
		}
		return 1;
    }
	return 1;
}

OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "IsDownloadingContent") == 1) DeletePVar(playerid, "IsDownloadingContent");
		MruMySQL_CreateAccount(playerid, password);
		OnPlayerLogin(playerid, password);
	}
	return 1;
}

DialogChangePasswordRequired(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Wymagana jest zmiana has³a do konta.\n{FF00FF}Istnieje ryzyko, ¿e Twoje has³o wyciek³o w postaci zaszyfrowanej.\nJe¿eli u¿ywa³eœ takiego samego has³a do innych kont/us³ug - radzimy je zmieniæ..");
	ShowPlayerDialogEx(playerid, D_HASLO_INFO, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", "{FF00FF}Witaj!\n{FF1010}Wymagana jest zmiana has³a do konta.\n{FF00FF}Istnieje ryzyko, ¿e Twoje has³o wyciek³o w postaci zaszyfrowanej.\nJe¿eli u¿ywa³eœ takiego samego has³a do innych kont/us³ug - radzimy je zmieniæ.", "Dalej", "Wyjdz"); 
}

VerifyPlayerIp(playerid)
{
	new ip[16], query[256];
	GetPlayerIp(playerid, ip, sizeof(ip));

	format(query, sizeof(query), "SELECT DISTINCT t.ip FROM ( SELECT ip, time FROM mru_konta k JOIN mru_logowania l ON k.UID=l.PID WHERE Nick='%s' ORDER BY l.time DESC) t LIMIT 25 ", GetNick(playerid));
	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(query, "|"))
        {
            new lastIp[MAX_PLAYER_NAME];
            sscanf(query, "p<|>s[16]", lastIp);

			if(strcmp(ip, MD5_Hash(lastIp), true ) == 0)
			{
    			mysql_free_result();
				Log(serverLog, INFO, "Ip %s matched for %s", ip, GetNick(playerid));
				return true;
			}
			else
			{
				new host1, host2, lastHost1, lastHost2;
				sscanf(ip, "p<.>dd", host1, host2);
				sscanf(lastIp, "p<.>dd", lastHost1, lastHost2);
				if(host1 == lastHost1 && host2 == lastHost2)
				{
					mysql_free_result();
					Log(serverLog, INFO, "Host %s matched for %s", ip, GetNick(playerid));
					return true;
				}
			}
        }
    }
    mysql_free_result();
	return false;
}

VeryfiLastLogin(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `Nick` FROM mru_last_logons WHERE `Nick`='%s' LIMIT 1", GetNick(playerid));
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows()) //ostatnie logowanie po 15
	{
		mysql_free_result();
		Log(serverLog, INFO, "Logon matched for %s", GetNick(playerid));
		return true;
	}
	else
	{
		mysql_free_result();
		Log(serverLog, INFO, "Logon mismatched for %s", GetNick(playerid));
		return false;
	}
}

PasswordConversion(playerid, accountPass[], password[])
{
	new hashedPassword[WHIRLPOOL_LEN];
	WP_Hash(hashedPassword, sizeof(hashedPassword), password);
	new isMD5 = (strlen(accountPass) == 32);

	if( (isMD5 && strcmp(accountPass, MD5_Hash(password), true ) == 0) //konwersja hase³ MD5 na Whirlpool + salt
		|| strcmp(accountPass, hashedPassword, true ) == 0) //konwersja hase³ Whirlpool na Whirlpool + salt
	{
		Log(serverLog, INFO, "Converting account to new hash, previous: %s", (isMD5 == 32 ? "MD5" : "Whirlpool"));
		VerifyPlayerIp(playerid);
		VeryfiLastLogin(playerid);
		MruMySQL_ChangePassword(GetNick(playerid), password);
		DialogChangePasswordRequired(playerid);
		SetPVarInt(playerid, "ChangingPassword", 1);
		return true;
	}
	return false;
}

PasswordVerify(playerid, password[])
{
	new accountPass[WHIRLPOOL_LEN], salt[SALT_LENGTH];
	new hashedPassword[WHIRLPOOL_LEN];
	MruMySQL_ReturnPassword(GetNick(playerid), accountPass, salt);

	if(strlen(salt) < 2) //not converted account - do conversion
	{
		Log(serverLog, DEBUG, "Converting password for %s", GetNick(playerid));
		if(PasswordConversion(playerid, accountPass, password))
		{
			Log(serverLog, DEBUG, "Conversion password for %s done.", GetNick(playerid));
			MruMySQL_ReturnPassword(GetNick(playerid), accountPass, salt);
		}
		else //wrong password
		{
			Log(serverLog, DEBUG, "Conversion password for %s canceled - wrong password.", GetNick(playerid));
			return false;
		}
	}
	
	//hash password
	WP_Hash(hashedPassword, sizeof(hashedPassword), sprintf("%s%s%s", ServerSecret, password, salt));

	// veryfi password
	if(!isnull(accountPass) && strcmp(accountPass, hashedPassword, true ) == 0)
	{
		return true;
	}
	return false;
}

OnPlayerLogin(playerid, password[])
{
    new nick[MAX_PLAYER_NAME], string[256];
	GetPlayerName(playerid, nick, sizeof(nick));
    
	if(!isnull(password) && PasswordVerify(playerid, password))
	{//poprawne has³o

		//----------------------------
		//£adowanie konta i zmiennych:
		//----------------------------

		if( !MruMySQL_LoadAccount(playerid) )
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Krytyczny b³¹d konta. Zg³oœ zaistnia³¹ sytuacjê na forum.");
			Log(serverLog, ERROR, "Krytyczny b³¹d konta %s (pusty rekord?)", nick);
			KickEx(playerid, "krytyczny b³¹d konta");
			return 1;
		}

		//Sprawdzanie blocków:
		if(PlayerInfo[playerid][pBlock] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest zablokowane, nie mo¿esz na nim graæ.");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeœli uwa¿asz, ¿e konto zosta³o zablokowane nies³usznie napisz apelacje na: {33CCFF}www.Mrucznik-RP.pl");
			KickEx(playerid, "blokada konta");
			return 1;
		}
        else if(PlayerInfo[playerid][pBlock] == 2 || PlayerInfo[playerid][pCK] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Ta postaæ jest uœmiercona, nie mo¿esz na niej graæ.");
			KickEx(playerid, "œmieræ postaci (CK)");
			return 1;
		}

		//fix bug maska
		foreach(new i : Player){
			if(IsPlayerConnected(i) && playerid != INVALID_PLAYER_ID && i != playerid && !IsPlayerNPC(playerid)) {
				if(PlayerInfo[i][pUID] == PlayerInfo[playerid][pUID] && PlayerInfo[playerid][pUID] != 0) {
					SendClientMessage(playerid, COLOR_PANICRED, "Konto jest juz zalogowane!");
					KickEx(playerid, "podwójne logowanie");
					return 1;
				}
			}
		}
		
		//Nadawanie pieniêdzy:
		ResetujKase(playerid);
		if(PlayerInfo[playerid][pCash] < 0)
		{
			if(PlayerInfo[playerid][pWL] < 9)
			{
				PlayerInfo[playerid][pWL]++; 
				sendTipMessage(playerid, "Masz d³ugi pieniê¿ne wobec pañstwa, twój poziom poszukiwania roœnie."); 
			}
			if(PlayerInfo[playerid][pWL] >= 9)
			{
				PlayerInfo[playerid][pWL] = 10; 
				sendTipMessage(playerid, "Masz ju¿ 10 poziom poszukiwania! Czêœæ jest spowodowana d³ugami! Zrób coœ z tym!"); 
			}
			ZabierzKase(playerid, -PlayerInfo[playerid][pCash]);
		}
		else if(PlayerInfo[playerid][pCash] >= 0)
		{
			DajKase(playerid, PlayerInfo[playerid][pCash]); 
		}
		//Ustawianie na zalogowany:
		gPlayerLogged[playerid] = 1;
		new GPCI[41];
		gpci(playerid, GPCI, sizeof(GPCI));
		Log(connectLog, INFO, "Gracz %s[id: %d, ip: %s, gpci: %s] zalogowa³ siê na konto", GetPlayerLogName(playerid), playerid, GetIp(playerid), GPCI);
        Car_LoadForPlayer(playerid); //System aut
		MruMySQL_LoadPhoneContacts(playerid); //Kontakty telefonu
		Command_SetPlayerDisabled(playerid, false); //W³¹czenie komend
		CorrectPlayerBusiness(playerid);
		CheckPlayerBusiness(playerid);
		
		//Lider
		Load_MySQL_Leader(playerid); 

		AC_OnPlayerLogin(playerid);
		Przemytnik_OnPlayerLogin(playerid);

		// Pozycja:
		SetPVarInt(playerid, "last-pos-int", PlayerInfo[playerid][pInt]);
		SetPVarInt(playerid, "last-pos-vw", PlayerInfo[playerid][pVW]);

		//Powitanie:
		format(string, sizeof(string), "Witaj na serwerze Mrucznik Role Play, %s!",nick);
		SendClientMessage(playerid, COLOR_WHITE,string);
		printf("%s has logged in.",nick);
		SendDiscordConnectInfo(playerid);
		if (IsPlayerPremiumOld(playerid))
		{
			SendClientMessage(playerid, COLOR_WHITE,"Jesteœ posiadaczem {E2BA1B}Konta Premium.");
		}
		if(Uprawnienia(playerid, ACCESS_PANEL))
		{
			format(string, sizeof(string), "Liderów frakcji w bazie danych: %d.", AllLeaders);
			sendTipMessage(playerid, string); 
		}
	}
	else
	{//z³e has³o
		SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z³e has³o.");

		format(string, sizeof(string), "Nick %s jest zarejestrowany.\nZaloguj siê wpisuj¹c w okienko poni¿ej has³o.\nJe¿li nie znasz has³a do tego konta, wejdŸ pod innym nickiem", nick);
		ShowPlayerDialogEx(playerid, 230, DIALOG_STYLE_PASSWORD, "Logowanie", string, "Zaloguj", "WyjdŸ");
		gPlayerLogTries[playerid] += 1;
		if(gPlayerLogTries[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z³e has³o. Zostajesz zkickowany.");
			ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "{FF0000}Dosta³eœ kicka za wpisanie z³ego has³a 3 razy pod rz¹d!", "WyjdŸ", "");
			KickEx(playerid, "z³e has³o");
		}
		return 1;
	}

	//Nadawanie pocz¹tkowych itemów po rejestracji:
	if(PlayerInfo[playerid][pReg] == 0)
	{
		PlayerInfo[playerid][pLevel] = 1;
		PlayerInfo[playerid][pSHealth] = 0.0;
		PlayerInfo[playerid][pHealth] = 50.0;
		PlayerInfo[playerid][pPos_x] = 2246.6;
		PlayerInfo[playerid][pPos_y] = -1161.9;
		PlayerInfo[playerid][pPos_z] = 1029.7;
		PlayerInfo[playerid][pInt] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pTeam] = 3;
		PlayerInfo[playerid][pSkin] = 136;
		PlayerInfo[playerid][pUniform] = 0;
		PlayerInfo[playerid][pPnumber] = 0;
		PlayerInfo[playerid][pDom] = 0;
		PlayerInfo[playerid][pPbiskey] = 255;
		PlayerInfo[playerid][pAccount] = 5000;
		PlayerInfo[playerid][pReg] = 1;
		PlayerInfo[playerid][pDowod] = 0;
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		PlayerInfo[playerid][pBusinessMember] = INVALID_BIZ_ID; 
		DajKase(playerid, 5000);
	}

	//Przywracanie Poziomu Poszukiwania
        //Punkty karne
    if (PlayerInfo[playerid][pWL] >= 10000)
    {
        string="\0";
        new lPunkty[8];
        PlayerInfo[playerid][pWL]-=10000;
        valstr(string, PlayerInfo[playerid][pWL]);
        if(strlen(string) == 3) strmid(lPunkty, string, 0, 1);
        else if(strlen(string) == 4) strmid(lPunkty, string, 0, 2);
        PlayerInfo[playerid][pPK] = strval(lPunkty);
        if(strlen(string) == 3) strmid(lPunkty, string, 1, 3);
        else if(strlen(string) == 4) strmid(lPunkty, string, 2, 4);
        PlayerInfo[playerid][pWL] = strval(lPunkty);
    }

	if (PlayerInfo[playerid][pWL] >= 1)
	{
        if(PlayerInfo[playerid][pWL] > 100) PlayerInfo[playerid][pWL] = 0;
        else
        {
    		PoziomPoszukiwania[playerid] = clamp(PlayerInfo[playerid][pWL], 0, 10);
    		format(string, sizeof(string), "Twój poziom poszukiwania zosta³ przywrócony do %d.",PlayerInfo[playerid][pWL]);
    		SendClientMessage(playerid, COLOR_WHITE,string);
        }
	}

    if(PlayerInfo[playerid][pWarns] >= 3)
    {
        MruMySQL_Banuj(playerid, "Limit warnów (3)");
        KickEx(playerid, "limit warnów (3)");
        return 1;
    }
    else if(PlayerInfo[playerid][pWarns] < 0) PlayerInfo[playerid][pWarns] = 0;

	premium_loadForPlayer(playerid);
	choroby_OnPlayerLogin(playerid);
	admini_OnPlayerLogin(playerid);

	//obiekty
	PlayerAttachments_LoadItems(playerid);

	//Odbugowywanie domów:
    if(PlayerInfo[playerid][pDom] != 0)
    {
    	NaprawSpojnoscWlascicielaDomu(playerid);
		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0;
    	if(Dom[PlayerInfo[playerid][pDom]][hPDW] < 0) Dom[PlayerInfo[playerid][pDom]][hPDW] = 0;//naprawa wynajmu
    	if(Dom[PlayerInfo[playerid][pDom]][hPW] < 0) Dom[PlayerInfo[playerid][pDom]][hPW] = 0;
		ZapiszDom(PlayerInfo[playerid][pDom]);
	}

	//Spawnowanie gracza
	SetTimerEx("AntySB", 5000, 0, "d", playerid); //by nie kickowa³o timer broni
	AntySpawnBroni[playerid] = 5;
	GUIExit[playerid] = 0;
	SetPlayerVirtualWorld(playerid, 0);

    Zone_Sync(playerid);
    if(strlen(ServerInfo) > 1) TextDrawShowForPlayer(playerid, TXD_Info); //Show info

    //Info o organizacji:
	new org = GetPlayerOrg(playerid);
	if(org != 0)
	{
		if(isnull(OrgInfo[org][o_Motto])) SendClientMessage(playerid, COLOR_YELLOW, "Twoja organizacja nie ma jeszcze ustawionego Motto.");
		else SendClientMessage(playerid, OrgInfo[org][o_Color], sprintf("Motto organizacji: %s.", OrgInfo[org][o_Motto]));
	}

	//Teleportacja do poprzedniej pozycji:
	if (PlayerInfo[playerid][pTut] == 1)
	{
        if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0 || IsAScripter(playerid))
        {
            if(PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] > 0)
            {
                SetPVarInt(playerid, "support_duty", 1);
                SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Stawiasz siê na s³u¿bie nowym graczom. Aby sprawdziæ zg³oszenia wpisz {00FF00}/tickets");
            }
			else if(PlayerInfo[playerid][pAdmin] > 0)
			{
				SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Aby widzieæ zg³oszenia z /tickets wpisz {FF0000}/adminduty");
			}

			if(GetPVarInt(playerid, "ChangingPassword") != 1)
				ShowPlayerDialogEx(playerid, 235, DIALOG_STYLE_INPUT, "Weryfikacja", "Logujesz siê jako cz³onek administracji. Zostajesz poproszony o wpisanie w\nponi¿sze pole has³a weryfikacyjnego. Pamiêtaj, aby nie podawaæ go nikomu!", "Weryfikuj", "WyjdŸ");
        }
        else if(PlayerInfo[playerid][pJailed] == 0 && ALockdown_Check(playerid) == false)
        {
    		lowcap[playerid] = 1;
			if(GetPVarInt(playerid, "ChangingPassword") != 1){
				SetPVarInt(playerid, "spawn", 1);
				SetPlayerSpawn(playerid);
				TogglePlayerSpectating(playerid, false);
				ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_MSGBOX, "Serwer", "Czy chcesz siê teleportowaæ do poprzedniej pozycji?", "TAK", "NIE");
			}
        }
        else
        {
            SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
            SetPlayerSpawn(playerid);
			TogglePlayerSpectating(playerid, false);
        }
	}
    else
    {
        SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
		gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
		PlayerInfo[playerid][pMuted] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na Mrucznik Role Play!");
		SendClientMessage(playerid, COLOR_WHITE, "Aby zacz¹æ grê musisz przejœæ procedury rejestracji.");
		ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Witaj na Mrucznik Role Play", "Witaj na serwerze Mrucznik Role Play\nJeœli jesteœ tu nowy, to przygotowaliœmy dla ciebie poradnik\nZa chwilê bêdziesz móg³ go obejrzeæ, lecz najpierw bêdziesz musia³ opisaæ postaæ któr¹ bêdziesz sterowa³\nAby przejœæ dalej wciœnij przycisk 'dalej'", "Dalej", "");
    }
	ALockdown_OnPlayerLogin(playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	camera_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

	if(BusDoors[playerid] == 1 && IsPlayerInAnyVehicle(playerid))
	{
		if(PRESSED(KEY_CROUCH)) // horn
		{
			RunCommand(playerid, "/zd", "");
			return 1;
		}
	}

    //09.06.2014
    if(Teleturniejstart == 1)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2,679.1998, -1336.1652, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,679.9750, -1339.5018, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,678.9643, -1342.8322, 30.3864))
	    {
		    if(!IsPlayerInAnyVehicle(playerid))
		    {
		        if(GetPlayerVirtualWorld(playerid) == 21)
		        {
		            if(newkeys & KEY_SPRINT)
		            {
						if(grajacy[playerid] == 1)
						{
			                new ImieGracza[MAX_PLAYER_NAME],string[64];
							GetPlayerName(playerid, ImieGracza, sizeof(ImieGracza));
							format(string, sizeof(string), "* %s naciska przycisk na stoliku",ImieGracza);
							ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Teleturniejstart = 0;
							grajacy[playerid] = 0;
                            return 0;
						}
		            }
		        }
		    }
		}
	}
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid, "obezwladniony")-15 > gettime())
    {
        if(HOLDING(KEY_SPRINT))
        {
			ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 1, 1, 1, -1);
        }
    }

   	if(PRESSED(KEY_JUMP) && Spectate[playerid] != INVALID_PLAYER_ID)
    {
		PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
		PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
		SetPlayerToTeamColor(playerid);
		MedicBill[playerid] = 0;
		Spectate[playerid] = INVALID_PLAYER_ID;
		//TogglePlayerSpectating(playerid, 0);
		GameTextForPlayer(playerid, "L O A D I N G", 1000, 3);
        SetTimerEx("SpecEnd", 500, false, "d", playerid);
		return 0;
    }
    //30.10
    if(HOLDING(KEY_ANALOG_UP))
    {
        new veh = GetPlayerVehicleID(playerid);
        if(veh != 0)
        {
            if(CarData[VehicleUID[veh][vUID]][c_Owner] == JOB_TRUCKER && CarData[VehicleUID[veh][vUID]][c_OwnerType] == CAR_OWNER_JOB)
            {
                if(GetVehicleModel(veh) == 530) TJD_TryPickup(playerid, veh);
            }
        }
    }
    //12.07 TRAIN HORN
    if(PRESSED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 0)
        {
            new veh;
            if((veh = GetPlayerVehicleID(playerid)) != 0)
            {
                if(GetVehicleModel(veh) == 538 || GetVehicleModel(veh) == 537)
                {
                    if(GetPlayerVehicleSeat(playerid) == 0)
                    {
                        SetPVarInt(playerid, "horn", 1);
                        if(TRAIN_HornTimer == 0)
                        {
                            TRAIN_HornTimer = SetTimerEx("TRAIN_DoHorn", 500, 1, "i", veh);
                            TRAIN_DoHorn(veh);
                            return 0;
                        }
                    }
                }
            }
        }
    }
    else if(RELEASED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 1)
        {
            if(TRAIN_HornTimer != 0) KillTimer(TRAIN_HornTimer);
            TRAIN_HornTimer=0;
            SetPVarInt(playerid, "horn", 0);

			foreach(new i : Player)
            {
                if(GetPVarInt(i, "train-horn") == 1)
                {
                    PlayerPlaySound(i, 8199, 0.0, 0.0, 0.0);
                    SetPVarInt(i, "train-horn", 0);
                }
            }
            return 0;
        }
    }
    //BLINK
    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        if(GetPlayerVehicleSeat(playerid) == 0)
        {
        	if(PRESSED(KEY_LOOK_LEFT))
            {
    			if(!IsCarBlinking(veh)) SetCarBlinking(veh, 0), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}
        	else if(PRESSED(KEY_LOOK_RIGHT))
            {
    		    if(!IsCarBlinking(veh)) SetCarBlinking(veh, 1), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}

            if(IsCarBlinking(veh))
            {
                new Float:a, Float:b = BlinkR[veh];
                GetVehicleZAngle(veh, a);

                if(BlinkSide[veh] == 0)
                {
                    b+=BLINK_TURN_ANGLE;
                    if(b > 360.0) b -=360.0;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a > b) DisableCarBlinking(veh);
                }
                else if(BlinkSide[veh] == 1)
                {
                    b-=BLINK_TURN_ANGLE;
                    if(b < 0.0) b = 360.0 + b;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a < b) DisableCarBlinking(veh);
                }
            }
        }
    }
    //Kolczatki
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(IsAPolicja(playerid) && !KolDelay[veh])
        {
            if(IsACopCar(veh) && !IsABike(veh) && !IsAPlane(veh) && !IsABoat(veh))
            {
                if(PRESSED(KEY_ANALOG_DOWN)) //2
                {
                    new id = Kolczatka_GetID();
                    if(id != -1)
                    {
                        new Float:h, Float:a, Float:b, Float:x, Float:y, Float:z, vehid = GetPlayerVehicleID(playerid), Float:rot;
                        GetVehiclePos(vehid, x, y, z);
                        GetVehicleZAngle(vehid, rot);
                        x-=2.0*floatsin(-rot, degrees);
                        y-=2.0*floatcos(-rot, degrees);
                        GetVehicleRotation(vehid, h, a, b);
                        if(floatabs(b) > 15.0)
						{
							return 1;
						}
                        //z -= 0.5;
                        z = (b > 0) ? (z - floatcos(b, degrees)) : (z + floatsin(b, degrees));
                        if(-10.0 <= b <= 10.0) z = (b>0) ? (z+ floatabs((b-10)/20)) : (z- ((b+10)/20));
                        KolID[id] = CreateDynamicObject(2899, x, y, z, a, b, rot-90);
                        KolTime[id] = gettime()+KOLCZATKA_CZAS;
                        KolArea[id] = CreateDynamicCylinder(x, y, z-10, z+10, 4.0);
                        KolDelay[veh] = true;
                        KolVehicle[id] = veh;
                        return 0;
                    }
                }
            }
        }
    }

    //
	if((GetPVarInt(playerid, "podglada-stats") == 1) && newkeys==KEY_ACTION)
	{
		SetPVarInt(playerid, "podglada-stats", 0); 
		HideStats2(playerid);
	}
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
		{
			SendClientMessage(playerid,0x00FFFFFF, "Próbujesz podczepiæ pojazd");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!found))
			{
				vid++;
				GetVehiclePos(vid,vX,vY,vZ);
                if(vid == 1) continue;
				if ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
				{
					found=1;
					if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
						SendClientMessage(playerid,COLOR_BROWN, "Pojazd odczepiony");
                        break;
					}
					AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
					SendClientMessage(playerid,COLOR_BROWN, "Pojazd podczepiony");
				}
			}
			if (!found)
			{
				SendClientMessage(playerid,COLOR_BROWN, "Nie ma w pobli¿u ¿adnych samochodów.");
			}
            return 0;
		}
	}
	if(newkeys & KEY_YES && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))//id 131072
	{
		if(GetPlayerVehicleID(playerid) <= CAR_End) //do kradziezy
        {
            if(KradniecieWozu[playerid] != GetPlayerVehicleID(playerid))
		    {
				sendErrorMessage(playerid, "Nie mo¿esz odpaliæ wozu podczas kradniêcia");
				return 1;
			}
		}
		new engine, unused;
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine , unused , unused, unused, unused, unused, unused);
		if(engine == 1)
			RunCommand(playerid, "/zgas",  "");
		else
			RunCommand(playerid, "/odpal",  "");
	}
	if((newkeys & KEY_HANDBRAKE) && (newkeys & KEY_CROUCH) && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
		{
			sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile.");
			return 1;
		}	
		SprawdzWjazdy(playerid);
	}
	if((newkeys & KEY_SPRINT) && newkeys & KEY_WALK)
	{
		SprawdzBramy(playerid) || SprawdzWejscia(playerid);
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			new Float:health;
			if(IsAtPlaceGetHP(playerid))
			{
				if(GetPlayerHealth(playerid, health) <= PlayerInfo[playerid][pHealth])
				{
					if(TimerJedzenie[playerid] == 0)
					{
						SetPlayerHealth(playerid, health+10);
						ZabierzKase(playerid, 1000);
						sendTipMessageEx(playerid, COLOR_RED, "Kupi³eœ jedzenie"); 
						ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);
						GameTextForPlayer(playerid, "Om nom om", 5000, 1);
						//SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
						TimerJedzenie[playerid] = 1;
						ZarcieCooldown[playerid] = SetTimerEx("JedzenieCooldown", 2500, true, "i", playerid);
					}
					else
					{
						sendTipMessage(playerid, "Odczekaj chwilê!"); 
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo¿esz wzi¹æ wiêcej HP!");
					sendTipMessage(playerid, "Aby móc braæ wiêcej HP ulepsz HP w /ulepszenia!"); 
					return 1;
				}
			}
		}
	}
	if(PRESSED(KEY_JUMP))//AntyBH
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
		    if(AntyBH == 1)
		    {
				SetPVarInt(playerid, "Jumping", 1);
			}
		}
	}
	if(newkeys - oldkeys == 40)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
		    if(WnetrzeWozu[playerid] != 0)
		    {
		        Z_WnetrzaWozu(playerid, WnetrzeWozu[playerid]);
		    }
		    else
		    {
			    for(new v; v < MAX_VEHICLES; v++)
			    {
					new model = GetVehicleModel(v);
					if(IsAInteriorVehicle(playerid))
					{
		   				new Float:vehx, Float:vehy, Float:vehz;
		          		GetVehiclePos(v, vehx, vehy, vehz);
		          		if(IsVehicleStreamedIn(v, playerid) && IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
		          		{
							if(VehicleUID[v][vIntLock] == 1)
			          	    {
								Do_WnetrzaWozu(playerid, v, model);
								return 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "Interior jest zamkniêty!");
							    return 0;
							}
		          		}
					}
			    }
		   	}
		}
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		    if (newkeys & KEY_ACTION || newkeys & KEY_FIRE)
			{
			    new Vehid = GetPlayerVehicleID(playerid);
			    new ModelID[MAX_VEHICLES];
			    ModelID[Vehid] = GetVehicleModel(Vehid);
			    if( ModelID[Vehid] == 520 || ModelID[Vehid] == 432 || ModelID[Vehid] == 425)
			    {
	    			ApplyAnimation(playerid,"PED","car_hookertalk ",4.1,1,1,1,1,1,1);
	    			TogglePlayerControllable(playerid,0);
					TogglePlayerControllable(playerid,1);
				}
			}
		}
	}
	else
	{
		if(PRESSED(KEY_FIRE))
		{
			if(GetPlayerWeapon(playerid) == 46)
			{
				new vehicleid = GetClosestCar(playerid, 3.0);
				if(vehicleid != -1)
				{
					ParachuteHit[playerid]++;
					if(ParachuteHit[playerid] >= 5)
					{
						ParachuteHit[playerid] = 0;
						SetPlayerArmedWeapon(playerid, 0); //chowanie spadochronu
						RemoveWeaponFromSlot(playerid, 11);
						GameTextForPlayer(playerid, "~y~Spadochron wyrzucony", 5000, 1);
					}
					else
					{
						SetPlayerArmedWeapon(playerid, 0); //chowanie spadochronu
        				return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Schowaj spadochron zanim w coœ uderzysz."); 
					}
				}
			}
		}

		if(GetPlayerWeapon(playerid) == 34 || GetPlayerWeapon(playerid) == 43)  //usuwanie obiektu maski podczas celowania snajperk¹/aparatem i przywracanie
		{
			new nick[32];
			if(GetPVarString(playerid, "maska_nick", nick, 24))
			{
				if(HOLDING(KEY_HANDBRAKE))
				{
					if(!IsAPolicja(playerid)) RemovePlayerAttachedObject(playerid, 1);
				}
				else if(RELEASED(KEY_HANDBRAKE))
				{
					if(!IsAPolicja(playerid)) SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
				}
			}
		}
	}
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
        if(GetPlayerAnimationIndex(playerid)!=1660) SetTimerEx("VendCheck", 500, false, "d", playerid);
        return 0;
    }
	if(newkeys & 4 && GetPVarInt(playerid, "anim_do") == 1) //animacje
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerSpecialAction(playerid) != 0)
			{
				SetPlayerSpecialAction(playerid, 0);
			}
		}
		ClearAnimations(playerid, 0);
		SetPVarInt(playerid, "anim_do", 0);
		return 0;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == 577)
	{
        foreach(new i : Player)
		{
			if(PlayerInfo[i][pWsamolocieLS]==1)
			{
				SendClientMessage(i, COLOR_GREY, " Samolot rozbi³ siê!");
				SetPlayerHealth(i, 0);
				PlayerInfo[i][pWsamolocieLS]=0;
				PlayerInfo[i][pWlociej]=0;
				PlayerInfo[i][pMozeskakacAT]=0;
			}
		}
		if(osoby>1)
		{
            new str[64];
            format(str, 64, "Szok! Samolot KT rozbi³ siê i zginê³o %d osób!", osoby);
			OOCNews(COLOR_LIGHTGREEN, str);
		}
	}

    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);

    TJD_CheckForUsedBox(vehicleid);

	if(VehicleUID[vehicleid][vUID] != 0)
	{
        Car_AddTune(vehicleid);
    	SetVehicleHealth(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_HP]);
    	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, CarData[VehicleUID[vehicleid][vUID]][c_Tires]);
	}
    if(VehicleUID[vehicleid][vSiren] != 0)
	{
	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
	    VehicleUID[vehicleid][vSiren] = 0;
	}
    if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION || Car_GetOwnerType(vehicleid) == CAR_OWNER_FAMILY || Car_GetOwnerType(vehicleid) == CAR_OWNER_JOB) {
        RepairVehicle(vehicleid); //

    }
	/*if(IsVehicleInCarPark(vehicleid))
	{
		new float:vPosX, float:vPosY, float:vPosZ; 
		GetVehiclePos(vehicleid, vPosX, vPosY, vPosZ);
		TempCarPark[vehicleid][0] = vPosX; 
		TempCarPark[vehicleid][1] = vPosY; 
		TempCarPark[vehicleid][2] = vPosZ; 
	}*/
    return 1;
}

public OnPlayerText(playerid, text[])
{
	new giver[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new tmp[256];
	new string[256];
	new wywiad_string[256];
	new giveplayerid;
	if(text[0] == '@')
	{
		if(strlen(text) > 31)
		{
			sendTipMessage(playerid, "Nieprawid³owa d³ugoœæ znaków animacji"); 
			return 0;
		}
		if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) return 0;
        new lVal = MRP_DoAnimation(playerid, text);
        if(lVal != 1)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "@_MRP: Nie znaleziono (/anim)acji.");
		} 
		return 0;
	}
	if(PlayerInfo[playerid][pMuted] == 1)
	{
		sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ gdy¿ jesteœ uciszony");
		return 0;
	}
	if(Przemytnik_OnPlayerText(playerid, text))
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s mówi (telefon): %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 0;
	}
	
	if(MarriageCeremoney[playerid] > 0)
	{
	    if (strcmp("tak", text, true) == 0)
		{
		    if(GotProposedBy[playerid] < 999)
		    {
			    if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
				    format(string, sizeof(string), "Ksi¹dz: %s czy chcesz wzi¹æ %s na swoj¹ ¿one? (wpisz 'tak', cokolwiek innego anuluje œlub).", giveplayer,sendername);
					SendClientMessage(GotProposedBy[playerid], COLOR_WHITE, string);
					MarriageCeremoney[GotProposedBy[playerid]] = 1;
					MarriageCeremoney[playerid] = 0;
					GotProposedBy[playerid] = 999;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
			}
			else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
						format(string, sizeof(string), "Ksi¹dz: %s i %s zostaliœcie mê¿em i ¿on¹, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s zostaliœcie mê¿em i ¿on¹, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 1)
					{
					    format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie mê¿em i mê¿em, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie mê¿em i mê¿em, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ gejowsk¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 2 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
					    format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie ¿on¹ i ¿on¹, mo¿ecie siê poca³owaæ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksi¹dz: %s i %s Zostaliœcie ¿on¹ i ¿on¹, mo¿ecie siê poca³owaæ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "Koœció³: Mamy now¹ lesbijsk¹ pare, %s & %s zostali zarêczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					//MarriageCeremoney[ProposedTo[playerid]] = 1;
					MarriageCeremoney[ProposedTo[playerid]] = 0;
					MarriageCeremoney[playerid] = 0;
					format(PlayerInfo[ProposedTo[playerid]][pMarriedTo], 32, "%s", sendername);
                    format(PlayerInfo[playerid][pMarriedTo], 32, "%s", giveplayer);
					ZabierzKase(playerid, 100000);
					PlayerInfo[playerid][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pPbiskey] = PlayerInfo[playerid][pPbiskey];
					ProposedTo[playerid] = 999;
					MarriageCeremoney[playerid] = 0;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
		else
		{
		    if(GotProposedBy[playerid] < 999)
		    {
				if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poœlubiæ %s, nie powiedzia³eœ 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciê poœlubiæ gdy¿ nie powiedzia³ 'tak'.",sendername);
				    SendClientMessage(GotProposedBy[playerid], COLOR_YELLOW, string);

                    MarriageCeremoney[GotProposedBy[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
		    }
		    else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poœlubiæ %s, nie powiedzia³eœ 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciê poœlubiæ gdy¿ nie powiedzia³ 'tak'.",sendername);
				    SendClientMessage(ProposedTo[playerid], COLOR_YELLOW, string);

                    GotProposedBy[ProposedTo[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
	    return 0;
	}

	if(ConnectedToPC[playerid] == 255)
	{
		new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("Contracts", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Contracts")) || (strcmp("Kontrakty", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Kontrakty")))
		{
		    if(PlayerInfo[playerid][pRank] < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Tylko Hitmani z 4 rang¹ mog¹ sprawdzaæ listê kontraktów !");
		        return 0;
		    }
		    SearchingHit(playerid);
			return 0;
		}
		else if ((strcmp("News", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("News")))
		{
		    	new x_nr[128];
				x_nr = strtok(text, idx);

				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "|__________________ Hitman Agency News __________________|");
					SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: News [numer] aby skasowac 'News Delate [numer]' lub 'News delete all'");
					format(string, sizeof(string), "1: %s :: Hitman: %s", News[hAdd1], News[hContact1]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "2: %s :: Hitman: %s", News[hAdd2], News[hContact2]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "3: %s :: Hitman: %s", News[hAdd3], News[hContact3]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "4: %s :: Hitman: %s", News[hAdd4], News[hContact4]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "5: %s :: Hitman: %s", News[hAdd5], News[hContact5]);
					SendClientMessage(playerid, COLOR_GREY, string);
					SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________________|");
					return 0;
				}//lets start
				if(strcmp(x_nr,"1",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz miec 3 rangê aby pisaæ newsy Hitman Agency !"); return 0; }
				    if(News[hTaken1] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "Za krótki tekst newsa !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd1], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact1], string, 0, strlen(string));
						News[hTaken1] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest zajety !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"2",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken2] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd2], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact2], string, 0, strlen(string));
						News[hTaken2] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"3",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken3] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd3], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact3], string, 0, strlen(string));
						News[hTaken3] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"4",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken4] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd4], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact4], string, 0, strlen(string));
						News[hTaken4] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"5",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 3 rangê aby pisaæ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken5] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "News jest za krótki !"); return 0; }
						format(string, sizeof(string), "%s",rightStr(text,strlen(text)-7)); strmid(News[hAdd5], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact5], string, 0, strlen(string));
						News[hTaken5] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieœci³eœ news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten numer jest aktualnie w u¿yciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"delete",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 4)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 4 rangê aby usuwaæ newsy z kana³u Hitman Agency !");
				        return 0;
				    }
				    new string1[MAX_PLAYER_NAME];
				    new x_tel[128];
					x_tel = strtok(text, idx);
					if(!strlen(x_tel)) {
					    SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: News delete [numer] lub News delete all.");
					    return 0;
					}
                    if(strcmp(x_tel,"1",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (1) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"2",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (2) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"3",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (3) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"4",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (4) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"5",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ newsa numer (5) Z kana³u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"all",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa³eœ wszystkie newsy z kana³u Hitman Agency.");
						return 0;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: News delete [numer] lub News delete all.");
					    return 0;
                    }
				}
				else { return 0; }
		}
		else if ((strcmp("Givehit", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Givehit")))
		{
		    if(PlayerInfo[playerid][pRank] < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 4 rangê aby dawaæ kontrakty Hitmanom !");
		        return 0;
		    }
		    if(hitfound == 0)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Nie sprawdzi³eœ jeszcze kontraktów, zrób to w laptopie (wpisz 'kontrakty') !");
		        return 0;
		    }
		    tmp = strtok(text, idx);
		    if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "U¯YJ: Givehit [playerid/CzêœæNicku]");
				return 0;
			}
			//giveplayerid = strval(tmp);
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
				    if(!IsAHA(giveplayerid))
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten gracz nie jest Hitmanem !");
						return 0;
				    }
				    if(GoChase[giveplayerid] < 999)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Ten Hitman wykonuje ju¿ jakieœ zlecenie !");
						return 0;
				    }
				    if(IsPlayerConnected(hitmanid))
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        GetPlayerName(giveplayerid, giver, sizeof(giver));
				        GetPlayerName(hitmanid, giveplayer, sizeof(giveplayer));

		    			format(string, sizeof(string), "* Hitman %s, da³ zlecenie %s na zabicie: %s(ID:%d), nagroda: $%d.", sendername, giver, giveplayer, hitmanid, PlayerInfo[hitmanid][pHeadValue]);
		    			SendFamilyMessage(8, COLOR_YELLOW, string);
		    			GoChase[giveplayerid] = hitmanid;
		    			GetChased[hitmanid] = giveplayerid;
		    			GotHit[hitmanid] = 1;
		    			hitmanid = 0;
		    			hitfound = 0;

						ConnectedToPC[playerid] = 0; //roz³¹czanie z laptopem po akcji
				        return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Osoby, na któr¹ jest zlecenie, nie ma na serwerze. Spróbuj póŸniej !");
				        return 0;
				    }
				}
				return 0;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Tego gracza nie ma na serwerze lub nie jest Hitmanem !");
			    return 0;
			}
		}
		else if ((strcmp("Ranks", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Ranks")) || (strcmp("Rangi", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Rangi")))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ Rangi Hitmanów __________________|");
		    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pMember] == 8||PlayerInfo[i][pLider] == 8)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
				        format(string, sizeof(string), "* %s: Ranga %d", giveplayer,PlayerInfo[i][pRank]);
						SendClientMessage(playerid, COLOR_GREY, string);
					}
				}
			}
		}
		else if ((strcmp("Order", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Order")))
		{
		    if(OrderReady[playerid] > 0)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Zamówi³eœ ju¿ paczki z broni¹, idŸ do swojej bazy aby je odebraæ !");
		        return 0;
		    }

			new contractsDone = RedisGetInt(sprintf("player:%d:contracts-done", PlayerInfo[playerid][pUID]));
			if(contractsDone <= 0)
			{
		        SendClientMessage(playerid, COLOR_GREY, "Nie wykona³eœ ¿adnego kontraktu! Aby dostaæ paczkê z broni¹, musisz zas³u¿yæ siê dla Hitman Agency i wykonaæ kontrakt.");
		        return 0;
			}
			format(string, sizeof(string), "Mo¿esz zamówiæ jeszcze %d paczek, zanim bêdziesz musia³ wykonaæ kontrakt by zwiêkszyæ swój limit.", contractsDone-1);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

		    tmp = strtok(text, idx);
		    if ((strcmp("1", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("1")))
			{
			    //if(PlayerInfo[playerid][pRank] < 0) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] >= 25_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczkê numer 1 ($25 000), zostanie dostarczona do drzwi Agencji.");
			        OrderReady[playerid] = 1;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
		    else if ((strcmp("2", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("2")))
			{
			    if(PlayerInfo[playerid][pRank] < 1) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 40_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczkê numer 2 ($40 000), zostanie dostarczona do drzwi Agencji.");
			        OrderReady[playerid] = 2;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("3", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("3")))
			{
			    if(PlayerInfo[playerid][pRank] < 2) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 60_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 3 ($60 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 3;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("4", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("4")))
			{
			    if(PlayerInfo[playerid][pRank] < 2) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 55_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 4 ($55 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 4;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("5", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("5")))
			{
			    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 80_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 5 ($80 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 5;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("6", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("6")))
			{
			    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 75_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 6 ($75 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 6;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("7", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("7")))
			{
			    if(PlayerInfo[playerid][pRank] < 4) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 85_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 7 ($85 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 7;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("8", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("8")))
			{
			    if(PlayerInfo[playerid][pRank] < 4) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 80_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 8 ($80 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 8;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("9", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("9")))
			{
			    if(PlayerInfo[playerid][pRank] < 5) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 100_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 9 ($100 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 9;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else if ((strcmp("10", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("10")))
			{
			    if(PlayerInfo[playerid][pRank] < 5) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 950_000)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 10 ($95 000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 10;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"Nie staæ ciê na to !");
			        return 0;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_WHITE, "|__________________ Dostêpne paczki __________________|");
			    if(PlayerInfo[playerid][pRank] >= 0) { SendClientMessage(playerid, COLOR_GREY, "|(1) ($25 000) Ranga 0: Nó¿, Desert Eagle, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 1) { SendClientMessage(playerid, COLOR_GREY, "|(2) ($40 000) Ranga 1: Nó¿, Desert Eagle, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(3) ($60 000) Ranga 2: Nó¿, Desert Eagle, M4, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(4) ($55 000) Ranga 2: Nó¿, Desert Eagle, AK47, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(5) ($80 000) Ranga 3: Nó¿, Desert Eagle, M4, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(6) ($75 000) Ranga 3: Nó¿, Desert Eagle, AK47, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(7) ($85 000) Ranga 4: Nó¿, Desert Eagle, M4, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(8) ($80 000) Ranga 4: Nó¿, Desert Eagle, AK47, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(9) ($100 000) Ranga 5-9: Nó¿, Desert Eagle, M4, UZI, Spas12, Snajperka, Pancerz"); }
                if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(10) ($95 000) Ranga 5-9: Nó¿, Desert Eagle, AK47, UZI, Spas12, Snajperka, Pancerz"); }
				SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________________|");
			    return 0;
			}
		}
		else if ((strcmp("Logout", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Logout")) || (strcmp("Wyloguj", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Wyloguj")))
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wy³¹czy³eœ swój laptop i zerwa³eœ po³¹czenie z agencj¹.");
      		ConnectedToPC[playerid] = 0;
		    return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_WHITE, "|___ Hitman Agency ___|");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - News");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Kontrakty");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Givehit");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Backup");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Order");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Rangi");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Wyloguj");
			SendClientMessage(playerid, COLOR_WHITE, "|______________|00:00|");
		    return 0;
		}
	    return 0;
	}
	if(CallLawyer[playerid] == 111)
	{
	    new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("tak", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("tak")))
		{
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "** %s jest w wiêzieniu i potrzebuje prawnika, jedŸ na komisariat.", sendername);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, string);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, "* Kiedy bêdziesz juz na komisariacie, kup pozwolenie komend¹ /kuppozwolenie.");
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "Jeœli policjant siê zgodzi, prawnik bêdzie móg³ uwolniæ ciê za op³at¹.");
	    	WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
	    	return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_LIGHTRED, "Nie ma ¿adnych prawników na serwerze, czas odsiadki rozpoczêty.");
		    WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
		    return 0;
		}
	}
	if(TalkingLive[playerid] != INVALID_PLAYER_ID)
	{
		new SanNews_nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid, SanNews_nick, sizeof(SanNews_nick));
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
			if(strlen(text) < 78)
			{
				if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
				{
					SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
					return 1;
				}
				format(string, sizeof(string), "%s mówi: %s", SanNews_nick, text);
				format(wywiad_string, sizeof(wywiad_string), "Reporter %s: %s", SanNews_nick, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
				OOCNews(COLOR_LIGHTGREEN, wywiad_string);
				SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
					{
						SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
						return 1;
					}
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));
					format(string, sizeof(string), "%s mówi: %s [..]", SanNews_nick, text);
					format(wywiad_string, sizeof(wywiad_string), "Reporter %s: %s [..]", SanNews_nick, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);

					format(string, sizeof(string), "[..] %s", text2);
					format(wywiad_string, sizeof(wywiad_string), "[..] %s", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
				}
			}
		
		}
		else
		{
			if(strlen(text) < 78)
			{
				if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
				{
					SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
					return 1;
				}
				format(string, sizeof(string), "%s mówi: %s", SanNews_nick, text);
				format(wywiad_string, sizeof(wywiad_string), "Goœæ wywiadu %s: %s", SanNews_nick, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
				OOCNews(COLOR_LIGHTGREEN, wywiad_string);
				SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					if(strfind(text, "@here", true) != -1 || strfind(text, "@everyone", true) != -1 || strfind(text, "<@", true) != -1) 
					{
						SendClientMessage(playerid, COLOR_WHITE, "Twój wywiad zawiera niedozwolone znaki! (@)");
						return 1;
					}
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "%s mówi: %s [..]", SanNews_nick, text);
					format(wywiad_string, sizeof(wywiad_string), "Goœæ wywiadu %s: %s [..]", SanNews_nick, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);

					format(string, sizeof(string), "[..] %s", text2);
					format(wywiad_string, sizeof(wywiad_string), "[..] %s", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
					SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
					OOCNews(COLOR_LIGHTGREEN, wywiad_string);
					SendDiscordMessage(DISCORD_SAN_NEWS, wywiad_string);
				}
			}
		}
		Log(chatLog, INFO, "%s wywiad: %s", GetPlayerLogName(playerid), text);
		return 0;
	}
	if(Mobile[playerid] != INVALID_PLAYER_ID && Callin[playerid] != CALL_NONE)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s mówi (telefon): %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		Log(chatLog, INFO, "%s telefon: %s", GetPlayerLogName(playerid), text);

		if(Mobile[playerid] < EMERGENCY_NUMBERS)
		{
			new org = (Mobile[playerid] - EMERGENCY_NUMBERS) * -1; //wzór na wy³uskanie organizacji z numeru
			if(Mobile[playerid] == POLICE_NUMBER || Mobile[playerid] == SHERIFF_NUMBER)
			{
				if(strlen(text) > 82)
				{
					SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: Niestety, nie rozumiem. Proszê powtórzyæ ((max 75 znaków))");
					return 0;
				}
				new id, message[128];
				mysql_real_escape_string(text, message);
				new Hour, Minute;
				gettime(Hour, Minute);
				new datapowod[160];
				format(datapowod, sizeof(datapowod), "%02d:%02d",  Hour, Minute);
				new pZone[MAX_ZONE_NAME];
				GetPlayer2DZone(giveplayerid, pZone, MAX_ZONE_NAME);

				if(Mobile[playerid] == POLICE_NUMBER)
				{
					id = getWolneZgloszenie();
				}
				else //SHERIFF_NUMBER
				{
					id = getWolneZgloszenieSasp();
				}

				strmid(Zgloszenie[id][zgloszenie_kiedy], datapowod, 0, sizeof(datapowod), 36);
				format(Zgloszenie[id][zgloszenie_nadal], MAX_PLAYER_NAME, "%s", GetNick(playerid));
				format(Zgloszenie[id][zgloszenie_lokacja], MAX_ZONE_NAME, "%s", pZone);
				strmid(Zgloszenie[id][zgloszenie_tresc], message, 0, strlen(message) + 9, 128);
				Zgloszenie[id][zgloszenie_status] = 0;
			}

			new turner[MAX_PLAYER_NAME], pZone[MAX_ZONE_NAME];
			new wanted[144];
			GetPlayerName(playerid, turner, sizeof(turner));
			GetPlayer2DZone(playerid, pZone, sizeof(pZone));
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Zg³osimy to wszystkim jednostkom w danym obszarze.");
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dziêkujemy za zg³oszenie");
			format(wanted, sizeof(wanted), "Centrala: Otrzymano zg³oszenie: %s", text);
			SendFamilyMessage(org, COLOR_ALLDEPT, wanted, true);
			format(wanted, sizeof(wanted), "Centrala: Nadawca: %s, lokalizacja zg³oszenia: %s", turner, pZone);
			SendFamilyMessage(org, COLOR_ALLDEPT, wanted, true);

			SendClientMessage(playerid, COLOR_GRAD2, "Rozmowa zakoñczona...");
			StopACall(playerid);
		}
		else
		{
			new reciverid = Mobile[playerid];
			if(RingTone[reciverid] != 0)
			{
				sendErrorMessage(playerid, "Gracz jeszcze nie odebra³ telefonu!");
			}
			else if(IsPlayerConnected(Mobile[playerid]))
			{
				new slotKontaktu = PobierzSlotKontaktuPoNumerze(Mobile[playerid], PlayerInfo[playerid][pPnumber]);
				if(slotKontaktu >= 0)
				{
					format(string, sizeof(string), "%s (nr %d): %s", Kontakty[Mobile[playerid]][slotKontaktu][eNazwa], PlayerInfo[playerid][pPnumber], text);
				}
				else
				{
					format(string, sizeof(string), "Telefon (nr %d): %s", PlayerInfo[playerid][pPnumber], text);
				}
				SendClientMessage(Mobile[playerid], COLOR_YELLOW, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Nikt siê nie odzywa.");
			}
		}
		return 0;
	}
	if (realchat)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        return 0;
      	}

		if(TourettActive[playerid] && GetPlayerAdminDutyStatus(playerid) == 0)
		{
			//insert random tourette word
			new newText[256];
			new Vector:spaces;
			for(new i; text[i] != '\0'; i++) //find spaces
			{
				if(text[i] == ' ') {
					VECTOR_push_back_val(spaces, i);
				}
			}
			new size = VECTOR_size(spaces);
			if(size > 0)
			{
				//insert word
				new index = random(size);
				strcat(newText, text);
				strins(newText, TourettWords[random(sizeof(TourettWords))], VECTOR_get_val(spaces, index));
				PlayerTalkIC(playerid, newText, "mówi", 15.0);
			}
			else
			{
				PlayerTalkIC(playerid, text, "mówi", 15.0);
			}
		}
		else if(OKActive[playerid] && GetPlayerAdminDutyStatus(playerid) == 0)
		{
			//speak l33t
			new newText[256];
			strcat(newText, text);
			strreplace(newText, "a", "4", true);
			strreplace(newText, "o", "0", true);
			strreplace(newText, "e", "3", true);
			strreplace(newText, "g", "6", true);
			strreplace(newText, "l", "1", true);
			strreplace(newText, "s", "5", true);
			strreplace(newText, "t", "7", true);
			strreplace(newText, "z", "2", true);
			PlayerTalkIC(playerid, newText, "mówi", 15.0);
		}
		else
		{
			PlayerTalkIC(playerid, text, "mówi", 15.0);
		}

		Log(chatLog, INFO, "%s chat IC: %s", GetPlayerLogName(playerid), text);
		return 0;
	}
	return 1;
}//OnPlayerText

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
    if(GetPVarInt(playerid, "Allow-edit"))
    {
        EditDynamicObject(playerid, objectid);
        new lStr[32];
        format(lStr, 32, "OBJID: %d", objectid);
        SendClientMessage(playerid, -1, lStr);
    }
    return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
    if(ZONE_DISABLED == 0) {
        new frac=GetPlayerFraction(playerid), org = GetPlayerOrg(playerid);
        if(IsAPrzestepca(playerid))
        {
            ZoneTXD_Show(playerid, zoneid);
            if(ZonePlayerTimer[playerid] == 0) ZonePlayerTimer[playerid] = SetTimerEx("Zone_HideInfo", 30000, 0, "i", playerid);
        }
        //Attack sync
        if(ZoneAttack[zoneid] && PlayerInfo[playerid][pBW] == 0)
        {
            if(frac == ZoneAttackData[zoneid][2] || org == ZoneAttackData[zoneid][2]) // attacker
            {
                if(!ZoneAttacker[playerid])
                {
                    ZoneAttacker[playerid] = true;
                    ZoneAttackData[zoneid][0]++;
                }
            }
            else if(frac == ZoneAttackData[zoneid][3] || org == ZoneAttackData[zoneid][3]) // defender
            {
                if(!ZoneDefender[playerid])
                {
                    ZoneDefender[playerid] = true;
                    ZoneAttackData[zoneid][1]++;
                }
            }
        }
    }
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
    if(zoneid < 0)
    {
        printf("Invalid zoneid (%d) for player %d", zoneid, playerid);
        return;
    }
    if(ZonePlayerTimer[playerid] != 0)
    {
        ZoneTXD_Hide(playerid);
        KillTimer(ZonePlayerTimer[playerid]);
        ZonePlayerTimer[playerid] = 0;
    }
    //Attack sync
    if(ZoneAttack[zoneid])
    {
        if(GetPlayerFraction(playerid) == ZoneAttackData[zoneid][2] || GetPlayerOrg(playerid) == ZoneAttackData[zoneid][2]) // attacker
        {
            if(ZoneAttacker[playerid])
            {
                ZoneAttacker[playerid] = false;
                ZoneAttackData[zoneid][0]--;
            }
        }
        else if(GetPlayerFraction(playerid) == ZoneAttackData[zoneid][3] || GetPlayerOrg(playerid) == ZoneAttackData[zoneid][3]) // defender
        {
            if(ZoneDefender[playerid])
            {
                ZoneDefender[playerid] = false;
                ZoneAttackData[zoneid][1]--;
            }
        }
    }
    SetPVarInt(playerid, "zoneid", -1);
}

public OnTrailerUpdate(playerid, vehicleid)
{
    return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	AC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, new_x, new_y, new_z, vel_x, vel_y, vel_z);
    return 1;
}

public MRP_ChangeVehicleColor(vehicleid, color1, color2)
{
    new bool:save=false;
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1 || CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
        save = true;
    if(color1 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][0] = color1;
    if(color2 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][1] = color2;
    if(save)
        Car_Save(VehicleUID[vehicleid][vUID], CAR_SAVE_TUNE);
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPVarInt(playerid, "debug-objects") == 1)
	{
		new Float:z;
		CA_FindZ_For2DCoord(fX, fY, z);
		SetPlayerPos(playerid, fX, fY, z + 0.5);
		SendClientMessage(playerid, COLOR_WHITE, sprintf("Map position to: X: %.4f, Y: %.4f, Z: %.4f", fX, fY, z));
	}
    return 1;
}

public OnDynamicObjectMoved(objectid)
{
    if(ScenaCreated)
    {
        if(objectid == ScenaScreenObject)
        {
            Scena_ScreenEffect();
            return 1;
        }
        for(new i=0;i<2;i++)
        {
            if(objectid == ScenaNeonData[SCNeonObj][i])
            {
                if(ScenaNeonData[SCNeonTyp] == 2)
                {
                    ScenaNeonData[SCNeonZderzacz]++;
                    if(ScenaNeonData[SCNeonZderzacz] == 2) Scena_NeonEffect();
                }
                else Scena_NeonEffect();
                return 1;
            }
        }
    }
    return 1;
}
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}

	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}
	new fullurl[256+1];
	new dlfilename[64+1];
	new foundfilename=0;
 
	if(!IsPlayerConnected(playerid)) return 0;
 
	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE) {
		foundfilename = FindTextureFileNameFromCRC(crc,dlfilename,sizeof(dlfilename));
	}
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE) {
		foundfilename = FindModelFileNameFromCRC(crc,dlfilename,sizeof(dlfilename));
	}
 
	if(foundfilename) {
		format(fullurl,sizeof(fullurl), RESOURCES_LINK"%s", dlfilename);
		RedirectDownload(playerid,fullurl);
		if(!GetPVarInt(playerid, "IsDownloadingContent")) SetPVarInt(playerid, "IsDownloadingContent", 1);
	}
	return 0;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
    return 1;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
    if(GetPVarInt(forplayerid, "tognick") == 1)
        ShowPlayerNameTagForPlayer(forplayerid, playerid, 0);

    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	// Vice City cars under objects fix
	new Float:unused;
	if(IsPlayerAtViceCity(forplayerid) 
	&& !IsVehicleOccupied(vehicleid)
	&& !CA_IsVehicleInWater(vehicleid, unused, unused))
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetVehiclePos(vehicleid, x, y, z);
		GetVehicleZAngle(vehicleid, a);

		CheckViceCityCar(vehicleid, x, y, z, a);
	}
	return 1;
}

timer CheckViceCityCar[3000](vehicleid, Float:x, Float:y, Float:z, Float:a)
{
	new Float:currX, Float:currY, Float:currZ, Float:unused;
	GetVehiclePos(vehicleid, currX, currY, currZ);
	if(currZ < z && CA_IsVehicleInWater(vehicleid, unused, unused))
	{
		new Float:groundZ;
		CA_FindZ_For2DCoord(currX, currY, groundZ);

		SetVehiclePos(vehicleid, x, y, groundZ);
		SetVehicleZAngle(vehicleid, a);
	}
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 0; //turn off singleplayer workshops
}

AntiDeAMX() //suprise motherfucker
{
    new whack[][] =
    {
        "lol",
        "traktor"
    };
    #pragma unused whack
	
	//Thanks to Y_Less
    new nyan;
    #emit load.pri nyan
    #emit stor.pri nyan
}

//Koniec.