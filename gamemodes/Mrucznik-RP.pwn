//-----------------------------------------[Mapa Mrucznik Role Play]-----------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//---------------------------------(Stworzona na podstawie mapy The Godfather)-------------------------------//
//-------------------------------------------------(v2.6)----------------------------------------------------//
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

//-------------------------------------------<[ Biblioteki ]>------------------------------------------------//
//-                                                                                                         -//
#include <a_samp>
#define FIX_ispacked 0 
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
// #include <requests>
// #include <colandreas>

//-------<[ Include ]>-------
#include <a_http>
#include <strlib_fix>
#include <callbacks>
#include <utils>
#define YSI_NO_MASTER
#include <YSI_Data\y_iterate>
#define Y_COMMANDS_USE_CHARS
#define MAX_COMMANDS 1200
#include <YSI\y_commands>
#include <YSI\y_groups>
#include <YSI\y_hooks>
#include <YSI\y_bintree>
#include <YSI\y_master>
#include <YSI\y_timers>
#include <indirection>
#include <amx_assembly\addressof>
//redefinition from y_playerarray.inc
#undef PlayerArray 
#include <sort-inline>
//nex-ac settings
#define AC_MAX_CONNECTS_FROM_IP		3
#define AUTOSAVE_SETTINGS_IN_CONFIG true
#define AC_USE_TUNING_GARAGES false
#define AC_USE_PICKUP_WEAPONS false
#define AC_USE_AMMUNATIONS false
#define AC_USE_RESTAURANTS false
#define AC_USE_CASINOS false
#include <nex-ac>
#include <md5>
#include <progress2>
#include <double-o-files2>
#include <dialogs>
#include <fadescreen>
#include <timestamp>
#include <systempozarow>   //System Po¿arów v0.1 by PECET
#include <true_random>
#include <PreviewModelDialog>
#include <vector>
#include <map>

//--------------------------------------<[ G³ówne ustawienia ]>----------------------------------------------//
//-                                                                                                         -//
#include "VERSION.pwn"
#define DEBUG_MODE 0 //1- DEBUG_MODE ON | 0- DEBUG_MODE OFF
#define RESOURCES_LINK "http://147.135.199.44:8100/"

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

//do implementacji w g³ówny kod (mo¿liwie w modu³y)
#include "system\doimplementacji\vinylscript.pwn"

//-------<[ Niceczlowiek ]>-------
#include "old_modules\niceczlowiek\general.pwn"
#include "old_modules\niceczlowiek\dynamicgui.pwn"
#include "old_modules\niceczlowiek\noysi.pwn"
#include "old_modules\niceczlowiek\wybieralka.pwn"

//-------<[ 3.0 style ]>-------
#include "modules\modules.pwn"

//-------<[ MySQL ]>-------
#include "mysql\mru_mysql.pwn"
#include "mysql\mysql_komendy.pwn"
#include "mysql\mysql_noysi.pwn"
#include "mysql\mysql_OnDialogResponse.pwn"


/*
#include "modules\ActorSystem\actors.pwn"
#include "modules\ActorSystem\actors.hwn"
#include "modules\ActorSystem\actors.def"
*/
//-------<[ Inne ]>-------
#include "old_modules\inne\ibiza.inc"
#include "old_modules\inne\external.pwn"
//-------<[ Funkcje ]>-------
#include "system\funkcje.pwn"

//-------<[ Timery ]>-------
#include "system\timery.pwn"

//-------<[ Obiekty ]>-------
#include "obiekty\stare_obiekty.pwn"
#include "obiekty\nowe_obiekty.pwn"
#include "obiekty\pickupy.pwn"
#include "obiekty\3dtexty.pwn"
#include "obiekty\ikony.pwn"
#include "obiekty\actorsOnWorld.pwn"


//-------<[ Komendy ]>-------
#include "commands\commands.pwn"

//-------<[ Dialogi ]>-------
#include "dialogs\OnDialogResponse.pwn"

//------------------------------------------------------------------------------------------------------
main()
{
	print("\n----------------------------------");
	print("M | --- Mrucznik Role Play --- | M");
	print("R | ---        ****        --- | R");
	print("U | ---        v2.6        --- | U");
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

	//-------<[ commands ]>-------
	InitCommands();

	//-------<[ modules ]>-------
    systempozarow_init();
    FabrykaMats_LoadLogic();
    NowaWybieralka_Init();
	LoadBusiness(); 
	LoadBusinessPickup(); 	
	//-------<[ actors ]>-------
	PushActors(); 
	LoadActors();

	//Config
	LoadConfig();

	//Old Groups - to remove \/
    WczytajRangi();
    WczytajSkiny();

    //Konfiguracja ID skryptu dla rodzin  - daj -1 w bazie aby wy³¹czyæ korzystanie ze skryptu dla slotu
    Config_FamilyScript();
    //
    BARIERKA_Init();

    Stworz_Obiekty();
	obiekty_OnGameModeInit();

    ZaladujDomy();
    orgLoad();
    Zone_Load();

    ZaladujTrasy(); //System wyœcigów
	ZaladujPickupy();
	ZaladujSamochody(); //Auta do kradziezy
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
	SetTimer("AktywujPozar", 10800000, true);//System Po¿arów v0.1
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
        PlayerInfo[i][pDescLabel] = Create3DTextLabel(" ", 0xBBACCFFF, 0.0, 0.0, 0.0, 5.0, 0, 1);
    }

    pusteZgloszenia();
	Log(serverLog, INFO, "Serwer zosta³ pomyœlnie uruchomiony.");
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
    for(new i=0;i<MAX_ORG;i++)
    {
        orgSave(i, ORG_SAVE_TYPE_BASIC);
        orgSave(i, ORG_SAVE_TYPE_DESC);
    }
    for(new i=0;i<MAX_FRAC;i++)
    {
        Sejf_Save(i);
        if(RANG_ApplyChanges[0][i]) EDIT_SaveRangs(0, i);
    }
    for(new i=0;i<MAX_ORG;i++)
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
    for(new i=Zone_Points[0];i<=Zone_Points[1];i++)
    {
        GangZoneDestroy(i);
    }
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
				ClearAnimations(hitid);
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
							return 0;
						}

						amount = amount / 2; //CUSTOMOWE DMG (dopiero po wydrenowaniu armora)

						if(HP <= amount) return 1; //wyœlij nabój (zabij)
						SetPlayerHealth(hitid, HP-amount); //lub zabierz mu customowe dmg
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
			//else
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
        if(GetPVarInt(playerid, "skin-select") == 1) // skin selector
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);
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
    if(GetPVarInt(playerid, "skin-select") == 1) // skin selector
    {
        if(clickedid == SkinSelectionAccept)//zatiwerdz
        {
            if(!GetPVarInt(playerid, "skin-done"))
            {
                GameTextForPlayer(playerid, "~r~Wybierz ubranie", 1000, 5);
                return 1;
            }
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);

            if(GetPVarInt(playerid, "skin-choosen") != 0)
            {
                SetPlayerSkinEx(playerid, GetPVarInt(playerid, "skin-choosen"));
                PlayerInfo[playerid][pUniform] = GetPVarInt(playerid, "skin-choosen");
            }
        }
        else if(clickedid == SkinSelectionDenied)//anuluj
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);
        }
        else if(clickedid == SkinSelectionMy)//moj cywil
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);
            PlayerInfo[playerid][pUniform] = PlayerInfo[playerid][pSkin];
            SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
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

public OnPlayerEnterDynamicArea(playerid, areaid)
{
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
            return;
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
            return;
        }
    }
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
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
    if(SkinSelection[playerid][0] <= _:playertextid < SkinSelection[playerid][MAX_SKIN_SELECT])
    {
        new idx = _:playertextid-_:SkinSelection[playerid][0];
        if(0 <= idx <= MAX_SKIN_SELECT)
        {
            new typ = GetPVarInt(playerid, "skin-typ");
            new frac = GetPlayerFraction(playerid);
            if(frac == 0) frac = GetPlayerOrg(playerid);
            switch(typ) //switch na tablice ze skinami
            {
                case 1: PlayerTextDrawSetPreviewModel(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT], FRAC_SKINS[frac][idx]), SetPVarInt(playerid, "skin-choosen", FRAC_SKINS[frac][idx]);
                case 2: PlayerTextDrawSetPreviewModel(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT], FAM_SKINS[frac][idx]), SetPVarInt(playerid, "skin-choosen", FAM_SKINS[frac][idx]);
            }
            PlayerTextDrawShow(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT]);
            SetPVarInt(playerid, "skin-index", idx);
            SetPVarInt(playerid, "skin-done", 1);
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
	if(!Kajdanki_JestemSkuty[playerid] && (PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)) //inna animacja dla bw
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
	// -- customowe parametry dla poszczególnych pojazdów
	if(IsARower(vehicleid))
	{
		SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		engine = 1;
	}
	else if (GetVehicleModel(vehicleid) == 525) sendTipMessageEx(playerid, COLOR_BROWN, "Wsiad³eœ do holownika, naciœnij CTRL alby podholowaæ wóz.");
    if(!ispassenger && !engine)
	{
		if(GetPlayerVehicleID(playerid) >= CAR_End) //do kradziezy
		{
			MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
		}
		else
		{
			MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
		}
		
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
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
    Usun_Obiekty(playerid); //stare obiekty
    obiekty_OnPlayerConnect(playerid);//nowe obiekty
	
	LoadTextDraws(playerid);
	
	Command_SetPlayerDisabled(playerid, true);
	 
	//Poprawny nick:
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
   	/*if(!NickCensoreCorrect(nick))
    {
        SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick jest niepoprawny! Nick musi posiadaæ formê: Imiê_Nazwisko!");
		KickEx(playerid);
		return 1;
    }*/
	if(regex_match(nick, "^[A-Z]{1}[a-z]{1,}(_[A-Z]{1}[a-z]{1,}([A-HJ-Z]{1}[a-z]{1,})?){1,2}$") <= 0)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick jest niepoprawny! Nick musi posiadaæ formê: Imiê_Nazwisko!");
		KickEx(playerid);
		return 1;
	}
	//Nick bez wulgaryzmów
	if(CheckVulgarityString(nick) == 1)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SERWER: Twój nick zawiera wulgaryzmy/niedozwolone s³owa - zmieñ go!"); 
		KickEx(playerid);
		return 1;
	}
	SetRPName(playerid);
	
	//bany
	if(MruMySQL_SprawdzBany(playerid)) return KickEx(playerid);

	timeSecWjedz[playerid] = 0;


	//Pocz¹tkowe ustawienia:
    saveMyAccountTimer[playerid] = SetTimerEx("SaveMyAccountTimer", 15*60*1000, 1, "i", playerid);

    //Ikony
    SetPlayerMapIcon(playerid, 1, 1172.0771, -1323.3496, 15.4030, 22, 0); //Szpital
    SetPlayerMapIcon(playerid, 2, 1024.7610, -1025.5515, 38.2944, 63, 0); //Paint & Spray (Temple)
    SetPlayerMapIcon(playerid, 3, 544.3761, -1276.2046, 17.2482, 55, 0); //Grotti (wypo¿yczalnia aut)
    SetPlayerMapIcon(playerid, 4, 501.9365, -1358.5668, 16.1252, 45, 0); //Prolaps (za San News)
    SetPlayerMapIcon(playerid, 5, 328.9384, -1512.9458, 36.0391, 56, 0); //Mrucznik Tower
    SetPlayerMapIcon(playerid, 6, 459.0327, -1502.2711, 31.0314, 45, 0); //Victim (Rodeo)
    SetPlayerMapIcon(playerid, 7, 487.6090, -1739.3744, 10.8613, 63, 0); //Paint & Spray (Idlewood)
    SetPlayerMapIcon(playerid, 8, 606.5818, -1458.5319, 14.3820, 30, 0); //FBI
    SetPlayerMapIcon(playerid, 9, 648.0233, -1357.3239, 13.5716, 60, 0); //San News
    SetPlayerMapIcon(playerid, 10, 725.6099, -1439.8906, 13.5318, 50, 0); //Jetty Lounge
    SetPlayerMapIcon(playerid, 11, 816.2141, -1386.5956, 13.6068, 48, 0); //Vinyl Club
    SetPlayerMapIcon(playerid, 12, 815.2556, -1616.2010, 13.7077, 10, 0); //Burger Marina
    SetPlayerMapIcon(playerid, 13, 925.6270, -1353.1003, 13.3768, 14, 0); //Kurczak Market
    SetPlayerMapIcon(playerid, 14, 1038.1844, -1339.7595, 13.7266, 17, 0); //P¹czkarnia Allen
    SetPlayerMapIcon(playerid, 15, 1100.9039, -1235.4445, 15.5474, 27, 0); //FDU
    SetPlayerMapIcon(playerid, 16, 1022.4534, -1122.0057, 23.8715, 25, 0); //Kasyno
    SetPlayerMapIcon(playerid, 17, 1459.2233, -1140.6903, 24.0593, 45, 0); //ZIP
    SetPlayerMapIcon(playerid, 18, 1462.3813, -1012.1696, 26.8438, 52, 0); //Bank
    SetPlayerMapIcon(playerid, 19, 1763.3892, -1130.4873, 24.0859, 20, 0); //Remiza
    SetPlayerMapIcon(playerid, 20, 2130.8472, -1144.4091, 24.5245, 55, 0); //Salon Aut
    SetPlayerMapIcon(playerid, 21, 2255.2629, -1333.2920, 23.9816, 12, 0); //Koœció³
    SetPlayerMapIcon(playerid, 22, 2245.2217, -1662.6310, 15.4690, 45, 0); //Binco
    SetPlayerMapIcon(playerid, 23, 2068.5596, -1831.6167, 13.2740, 63, 0); //Paint & Spray Idlewood
    SetPlayerMapIcon(playerid, 24, 2102.2976, -1806.5530, 13.5547, 29, 0); //Pizzeria Idlewood
    SetPlayerMapIcon(playerid, 25, 53.2336, -1531.4541, 5.2757, 57, 0); //Granica LS - SF
    SetPlayerMapIcon(playerid, 26, 630.3970, -571.7601, 16.3359, 30, 0); //Komisariat w Dillimore
    SetPlayerMapIcon(playerid, 27, 655.9221, -564.6913, 16.0630, 42, 0); //Stacja Benzynowa w Dillimore
    SetPlayerMapIcon(playerid, 28, 720.0000, -459.2647, 16.0630, 63, 0); //Paint & Spray Dillimore
    SetPlayerMapIcon(playerid, 29, 713.9889, -498.1104, 16.0630, 18, 0); //AmmuNation Dillimore
    SetPlayerMapIcon(playerid, 30, 1006.5273, -936.9426, 41.8934, 42, 0); //Stacja Benzynowa na Temple
    SetPlayerMapIcon(playerid, 31, 997.5923, -921.3640, 41.9068, 36, 0); //24/7 na Temple
    SetPlayerMapIcon(playerid, 32, 997.2347, -917.5255, 41.9068, 52, 0); //Bankomat na Temple
    SetPlayerMapIcon(playerid, 33, 1199.9893, -923.6624, 42.7465, 10, 0); //Burger Temple
    SetPlayerMapIcon(playerid, 34, 1315.3838, -904.4830, 38.6174, 36, 0); //24/7 na Temple (2)
    SetPlayerMapIcon(playerid, 35, 1310.2568, -1370.4567, 13.3031, 34, 0); //S¹d
    SetPlayerMapIcon(playerid, 36, 1481.2053, -1768.3350, 18.5228, 34, 0); //Urz¹d
    SetPlayerMapIcon(playerid, 37, 1551.8835, -1676.2306, 15.5495, 30, 0); //Komisariat G³ówny
    SetPlayerMapIcon(playerid, 38, 1939.0436, -1773.6844, 13.1137, 42, 0); //Stacja Benzynowa na Idlewood
    SetPlayerMapIcon(playerid, 39, 2073.7549, -1827.9742, 13.2739, 52, 0); //Bankomat (1)
    SetPlayerMapIcon(playerid, 40, 2227.1052, -1723.2871, 13.2840, 54, 0); //Si³ownia
    SetPlayerMapIcon(playerid, 41, 2844.5139, -1562.8854, 10.8208, 52, 0); //Bankomat (2)
    SetPlayerMapIcon(playerid, 42, 1699.7645, 411.4212, 30.6384, 57, 0); //Granica LS - LV
    SetPlayerMapIcon(playerid, 43, 2269.7112, -74.8501, 26.7724, 34, 0); //Urz¹d w PC
    SetPlayerMapIcon(playerid, 44, 2302.0964, -16.2240, 26.4844, 52, 0); //Bank w PC
    SetPlayerMapIcon(playerid, 45, 2112.7124, -1213.1012, 23.6923, 45, 0); //Suburban obok Salonu Aut
    SetPlayerMapIcon(playerid, 46, 2421.2805, -1223.2761, 24.9988, 21, 0); //Pig Pen
    SetPlayerMapIcon(playerid, 47, 2770.6140, -1610.7180, 10.6489, 56, 0); //Mechanik (Praca)
    SetPlayerMapIcon(playerid, 48, 1961.5001, -2194.4309, 13.2740, 5, 0); //Lotnisko
    SetPlayerMapIcon(playerid, 49, 1941.3965, -2116.1799, 13.3525, 21, 0); //Dziki Tygrys
    SetPlayerMapIcon(playerid, 50, 1765.1974, -2063.2681, 13.3357, 56, 0); //Praca na Las Colinas (nie pamiêtam nazwy)
    SetPlayerMapIcon(playerid, 51, 1352.4242, -1758.4613, 13.5078, 36, 0); //24/7 obok Urzêdu
    SetPlayerMapIcon(playerid, 52, 1109.1722, -1796.2472, 16.5938, 56, 0); //Z³odziej Aut
    SetPlayerMapIcon(playerid, 53, 1154.2104, -1770.6967, 16.5938, 56, 0); //Busiarz
    SetPlayerMapIcon(playerid, 54, 900.8502, -1101.3074, 23.5000, 12, 0); //Cmentarz
    SetPlayerMapIcon(playerid, 55, 1365.9257, -1275.1326, 13.5469, 56, 0); //Diler Broni
    SetPlayerMapIcon(playerid, 56, 1790.5382,-1164.7021,23.8281, 18, 0); //GunShop obok Remizy
    SetPlayerMapIcon(playerid, 57, 2166.2034, -1675.3135, 15.0859, 56, 0); //Diler Dragów
    SetPlayerMapIcon(playerid, 58, 1787.4432, -1866.6737, 13.5711, 52, 0); //Bankomat obok Dworca G³ównego
    SetPlayerMapIcon(playerid, 59, 1833.0537, -1842.6494, 13.5781, 36, 0); //24/7 na Idlewood
    SetPlayerMapIcon(playerid, 60, 2226.0696, -1718.3290, 13.5182, 56, 0); //Ochroniarz (Praca)
    SetPlayerMapIcon(playerid, 61, 2103.4141, -1798.7494, 13.6504, 56, 0); //Pizzerman (Praca)
    SetPlayerMapIcon(playerid, 62, 382.8541, -2079.4890, 7.5630, 9, 0); //Miejsce do wêdkowania
    SetPlayerMapIcon(playerid, 63, 342.0005, -1518.7524, 33.2482, 52, 0); //Bankomat obok Mrucznik Tower
    SetPlayerMapIcon(playerid, 64, 660.0374, -575.8544, 16.3359, 52, 0); //Bankomat obok stacji w Dillimore
    SetPlayerMapIcon(playerid, 65, 2273.1931, -77.6219, 26.5704, 52, 0); //Bankomat obok Urzêdu w PC
    SetPlayerMapIcon(playerid, 66, 2115.5796, 920.2349, 10.5474, 42, 0); //Stacja benzynowa w LV
    SetPlayerMapIcon(playerid, 67, 1973.2526, 2162.1948, 10.8001, 63, 0); //Paint & Spray w LV
    SetPlayerMapIcon(playerid, 68, -1675.5817, 414.0347, 6.9068, 42, 0); //Stacja benzynowa w SF
    SetPlayerMapIcon(playerid, 69, -1904.4862, 281.9908, 40.774, 63, 0); //Paint & Spray w SF
    SetPlayerMapIcon(playerid, 70, -1932.1078, 274.0641, 40.7720, 56, 0); //Mechanik SF (Praca)
    SetPlayerMapIcon(playerid, 71, -2029.1031, 157.1051, 28.5630, 42, 0); //Stacja benzynowa w SF V2
    SetPlayerMapIcon(playerid, 72, -2405.7351, 975.3979, 45.0239, 42, 0); //Stacja benzynowa w SF V3
    SetPlayerMapIcon(playerid, 73, -2425.5703, 1023.0456, 50.1247, 63, 0); //Paint & Spray w SF V2 (Juniper Hollow)
    SetPlayerMapIcon(playerid, 74, -100.5483, 1114.7805, 19.4688, 63, 0); //Paint & Spray w Fort Carson
    SetPlayerMapIcon(playerid, 75, 70.4944, 1219.0317, 18.5391, 42, 0); //Stacja benzynowa w Fort Carson
    SetPlayerMapIcon(playerid, 76, 611.6107, 1694.4340, 6.7193, 42, 0); //Stacja benzynowa w Bone County
    SetPlayerMapIcon(playerid, 77, 2582.2329, 61.6251, 26.2817, 42, 0); //Stacja benzynowa w PC
    SetPlayerMapIcon(playerid, 78, 1383.4578, 461.5694, 19.8450, 42, 0); //Stacja benzynowa w Montgomery
    SetPlayerMapIcon(playerid, 79, 2202.3503, 2474.2419, 10.5474, 42, 0); //Stacja w LV V2
	
	//biz
	ResetBizOffer(playerid);
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

public OnPlayerDisconnect(playerid, reason)
{
	if(playerid == INVALID_PLAYER_ID || playerid > MAX_PLAYERS)
		return 0;

	//Pobieranie starej pozycji:
	Log(connectLog, INFO, "Gracz %s[id: %d] roz³¹czy³ siê, powód: %d", GetNickEx(playerid), playerid, reason);

	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); //l

	new reString[128];
    new DisconnectReason[4][] =
    {
        "Timeout/Crash",
        "/q",
        "Kick/Ban",
		"/login"
    };
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

    Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, " ");

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
	//caluj
	kissPlayerOffer[playerid] = 0;
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
	//kajdanki
	if(Kajdanki_JestemSkuty[playerid] != 0) // gdy skuty da /q
	{
		OdkujKajdanki(playerid);
	}
	else if(Kajdanki_Uzyte[playerid] != 0) //gdy skuwaj¹cy da /q
	{
		new aresztant = Kajdanki_SkutyGracz[playerid];
		OdkujKajdanki(aresztant);
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
    //if(PlayerTied[playerid] >= 1 || PlayerCuffed[playerid] >= 1 || Kajdanki_JestemSkuty[playerid] >= 1 || poscig[playerid] == 1)
    if(PlayerTied[playerid] >= 1 || (PlayerCuffed[playerid] >= 1 && pobity[playerid] == 0 && PlayerCuffed[playerid] < 3) || Kajdanki_JestemSkuty[playerid] >= 1 || poscig[playerid] == 1)
	{
        PlayerInfo[playerid][pJailed] = 10;
        new string[130];
        new powod[36];
        if(PlayerTied[playerid] >= 1)
        {
            strcat(powod, "bycie zwiazanym, ");
        }
        if(PlayerCuffed[playerid] >= 1)
        {
            strcat(powod, "kajdanki w aucie, ");
        }
        if(Kajdanki_JestemSkuty[playerid] >= 1)
        {
            strcat(powod, "kajdanki pieszo, ");
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

	if(PoziomPoszukiwania[playerid] >= 1)
	{
		new wl = PoziomPoszukiwania[playerid];
		PlayerInfo[playerid][pWL] = wl;
		SetPlayerWantedLevel(playerid, 0);
	}

    if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999)
	{
        Taxi_Pay(playerid);
	}

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

    if(GetPVarInt(playerid, "skin-select") != 0)
        DestroySkinSelection(playerid);

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
			if(IsAPolicja(i) || IsAMedyk(i) || GetPlayerFraction(i) == FRAC_BOR || GetPlayerFraction(i) == FRAC_ERS || (PlayerInfo[i][pMember] == 9 && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1) || GetPVarInt(playerid, "RozpoczalBieg") == 0)
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

	//Komunikaty dla graczy na serwerze:
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
	if(PlayerPaintballing[playerid] != 0)
	{
	    PaintballPlayers --;
	}
	if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
	{
	    KartingPlayers --;
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
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
    else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
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
    MRP_PremiumHours[playerid] = 0;
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(Kajdanki_JestemSkuty[playerid] > 0)
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
		if(Kajdanki_JestemSkuty[issuerid] > 0)
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
	new string[144];

	if((!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) || (IsPlayerConnected(killerid) && !gPlayerLogged[killerid])) return 1;

	Log(damageLog, INFO, "%s zosta³ zabity przez %s, powód: %d", 
		GetPlayerLogName(playerid),
		IsPlayerConnected(killerid) ? GetPlayerLogName(killerid) : sprintf("%d", killerid),
		reason
	);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);

	new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }
    if(ZoneAttacker[playerid] || ZoneDefender[playerid])
    {
        OnPlayerLeaveGangZone(playerid, GetPVarInt(playerid, "zoneid"));
    }
    if(GetPVarInt(playerid, "IbizaWejdz") || GetPVarInt(playerid, "IbizaBilet") )
	{
		DeletePVar(playerid, "IbizaWejdz");
		DeletePVar(playerid, "IbizaBilet");
		StopAudioStreamForPlayer(playerid); //POWTÓRKA
	}

	if(GetPlayerAdminDutyStatus(playerid) == 1 || GetPlayerAdminDutyStatus(killerid) == 1)
	{
		SetPVarInt(playerid, "skip_bw", 1);
	}

	DeathAdminWarning(playerid, killerid, reason);

	if(IsPlayerConnected(playerid))
	{
		//-------<[    Zmienne    ]>---------
		StopAudioStreamForPlayer(playerid);
		gPlayerSpawned[playerid] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pDeaths] ++;
		
		if(GetPVarInt(playerid, "skip_bw") == 0)
		{
			if(PlayerInfo[playerid][pInjury] > 0) //TRYB BW (GDY ZGINIE JAK MA RANNEGO)
			{
				if (gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
				{
					DisablePlayerCheckpoint(playerid);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				}
				if(TalkingLive[playerid] != INVALID_PLAYER_ID)
				{
					SendPlayerMessageToAll(COLOR_NEWS, "NEWS: Wywiad zakoñczony - nasz rozmówca przerwa³ wywiad.");
					new talker = TalkingLive[playerid];
					TalkingLive[playerid] = INVALID_PLAYER_ID;
					TalkingLive[talker] = INVALID_PLAYER_ID;
				}
				//koniec rozmowy telefonicznej
				if(Mobile[playerid] != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Jesteœ ranny - po³¹czenie zakoñczone.");
					if(Mobile[playerid] >= 0)
					{
						SendClientMessage(Mobile[playerid], COLOR_YELLOW, "S³ychaæ nag³y trzask i po³¹czenie zostaje zakoñczone.");
					}
					StopACall(playerid);
				}

				if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
				{
					format(string, sizeof(string), "Wyœcig: {FFFFFF}%s zgin¹³ jak prawdziwy œcigant [*]", GetNickEx(playerid));
					WyscigMessage(COLOR_YELLOW, string);
					IloscZawodnikow --;
					if(IloscZawodnikow <= Ukonczyl)
					{
						KoniecWyscigu(-1);
					}
				}
				if(lowcaz[playerid] == killerid)
				{
					lowcaz[playerid] = 501;
					SendClientMessage(playerid, COLOR_YELLOW, "Zlecenie zosta³o anulowane - nie mo¿esz wzi¹æ teraz zlecenia na tego samego gracza!");
				}
				if(GetPVarInt(playerid, "ZjadlDragi") == 1)
				{
					new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
					SetPVarInt(playerid, "ZjadlDragi", 0);
					sendTipMessage(playerid, "Z powodu œmierci twój boost (dragów) zosta³ wy³¹czony, za¿yj kolejn¹ dawkê!"); 
					KillTimer(TimerEfektNarkotyku[playerid]);
					SetStrong(playerid, FirstValue);
				}

				if(Worek_MamWorek[playerid] != 0) // gdy osoba z workiem trafi do szpitala
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

				if(IsPlayerConnected(killerid))
				{
					PlayerInfo[killerid][pKills] ++;
					if(giveWL)
					{
						if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid )
						{
							NadajWLBW(killerid, playerid, true);
						}
					}
					if(PlayerInfo[playerid][pHeadValue] > 0) //hitmani musz¹ dobiæ, ¿eby zaliczy³o kontrakt
					{
						if(PlayerInfo[killerid][pMember] == 8 || PlayerInfo[killerid][pLider] == 8)
						{
							if(GoChase[killerid] == playerid)
							{
								//jeœli zabity mia³ kajdanki
								if(Kajdanki_JestemSkuty[playerid] != 0) // gdy skuty da /q
								{
									format(string, sizeof(string), "* Wiêzieñ %s zosta³ zastrzelony przez Hitmana (MK). Nastêpnym razem zadbaj o bezpieczeñstwo swojego wiêŸnia *", GetNick(playerid));
									SendClientMessage(Kajdanki_PDkuje[playerid], COLOR_LIGHTRED, string);
									OdkujKajdanki(playerid);
								}

								SetPVarInt(playerid, "bw-hitmankiller",  1);
								SetPVarInt(playerid, "bw-hitmankillerid",  killerid);
								return NadajBW(playerid, BW_TIME_CRIMINAL);
							}
						}
					}
					if(PoziomPoszukiwania[playerid] >= 1)
					{
						new price2 = PoziomPoszukiwania[playerid] * 1000;
						new count, i = killerid;
						if(IsAPolicja(playerid) && OnDuty[playerid] == 1)
						{
							PoziomPoszukiwania[playerid] = 0;
						}
						else if(PlayerInfo[killerid][pJob] == 1)
						{
							if(lowcaz[i] == playerid)
							{
								if(PlayerInfo[i][pDetSkill] <= 50)
								{
									if(PoziomPoszukiwania[playerid] == 2 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 11;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 51 && PlayerInfo[i][pDetSkill] < 100)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 3 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 22;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 101 && PlayerInfo[i][pDetSkill] < 200)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 4 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 33;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 201 && PlayerInfo[i][pDetSkill] < 400)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 5 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 44;
										lowcaz[i] = 501;
									}
								}
								else if(PlayerInfo[i][pDetSkill] >= 400)
								{
									if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 7 || PoziomPoszukiwania[playerid] == 10)
									{
										count = 55;
										lowcaz[i] = 501;
									}
								}

								format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
								GameTextForPlayer(i, string, 5000, 1);
								PoziomPoszukiwania[i] = 0;
								ClearCrime(i);
								DajKase(i, price2);//moneycheat
								PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
								PlayerInfo[i][pDetSkill] += 2;
								SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
							}
						}
						if(poscig[playerid] == 1)
						{
							if(PoziomPoszukiwania[playerid] >= 6)
							{
								count = 2;
							}
							else
							{
								count = 1;
							}
						}
						if(count == 1 || count == 11 || count == 22 || count == 33 || count == 44 || count == 55 || count == 2)
						{
							if(!(IsAPolicja(playerid) && OnDuty[playerid] == 1))
							{
								new CenaZabicia = (4000)*(PoziomPoszukiwania[playerid]);
								ZabierzKase(playerid, CenaZabicia);//moneycheat
								PlayerInfo[playerid][pWantedDeaths] += 1;
								PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(400);
								PoziomPoszukiwania[playerid] = 0;
								SetPlayerWantedLevel(playerid, 0);
								poscig[playerid] = 0;
								UsunBron(playerid);
								if(count == 1 || count == 11 || count == 22 || count == 33 || count == 44 || count == 55)
								{
									PlayerInfo[playerid][pJailed] = 1;
									format(string, sizeof(string), "* Jesteœ w wiêzieniu na %d Sekund i straci³eœ $%d gdy¿ ucieka³eœ lub strzela³eœ do funkcjonariusza policji.", PlayerInfo[playerid][pJailTime], CenaZabicia);
									SendClientMessage(playerid, COLOR_LIGHTRED, string);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, "Je¿eli nie chcesz aby taka sytuacja powtórzy³a siê w przysz³oœci, skorzystaj z us³ug prawnika który zbije twój WL.");
									WantLawyer[playerid] = 1;
								}
								else if(count == 2)
								{
									PlayerInfo[playerid][pJailed] = 2;
									format(string, sizeof(string), "* Jesteœ w DeMorgan na %d Sekund i straci³eœ $%d gdy¿ ucieka³eœ lub strzela³eœ do funkcjonariusza policji", PlayerInfo[playerid][pJailTime], CenaZabicia);
									SendClientMessage(playerid, COLOR_LIGHTRED, string);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, "Je¿eli nie chcesz aby taka sytuacja powtórzy³a siê w przysz³oœci, skorzystaj z us³ug prawnika który zbije twój WL.");
								}
								return 1; //zrespawnuj gracza w wiêzieniu
							}
						}
					}
					if(IsAPrzestepca(killerid)) return NadajBW(playerid, BW_TIME_CRIMINAL);
					if(PlayerInfo[killerid][pLevel] >= 3 || (IsAPolicja(killerid) && OnDuty[killerid] == 1)) return NadajBW(playerid);
				}
				return 1;
			}
			else //TRYB RANNEGO
			{
				if(PlayerInfo[playerid][pBW] > 0)
				{
					return NadajBW(playerid, PlayerInfo[playerid][pBW], false);
				}
				else
				{
					//kajdanki
					if(Kajdanki_Uzyte[playerid] != 0) //gdy skuwaj¹cy dostanie rannego
					{
						OdkujKajdanki(Kajdanki_SkutyGracz[playerid]);
					}

					if(IsPlayerConnected(killerid))
					{
						if(giveWL)
						{
							if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid )
							{
								NadajWLBW(killerid, playerid, false);
							}
						}

						if(PlayerInfo[playerid][pHeadValue] > 0) //hitmani musz¹ dobiæ, ¿eby zaliczy³o kontrakt
						{
							if(PlayerInfo[killerid][pMember] == 8 || PlayerInfo[killerid][pLider] == 8)
							{
								if(GoChase[killerid] == playerid)
								{
									format(string, sizeof(string), "* Dobij %s, ¿eby wype³niæ kontrakt *", GetNick(playerid));
									SendClientMessage(killerid, COLOR_LIGHTRED, string);
								}
							}
						}

						SetPVarInt(playerid, "bw-reason", reason);
						if(PlayerInfo[killerid][pLevel] >= 3 || IsAPrzestepca(killerid) || (IsAPolicja(killerid) && OnDuty[killerid] == 1))
						{
							return NadajRanny(playerid, 0, true);
						}
						else
						{
							return NadajRanny(playerid, INJURY_TIME_EXCEPTION, true);
						}
					}
				}
			}
		}
		else
		{
			DeletePVar(playerid, "skip_bw");		
		}
		SetPlayerColor(playerid,COLOR_GRAD2);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);
	//Czyszczenie zmiennych
	if(gPlayerLogged[playerid] != 1)
	{
		sendErrorMessage(playerid, "Zespawnowa³eœ siê, a nie jesteœ zalogowany! Zosta³eœ wyrzucony z serwera.");
		KickEx(playerid);
		return 0;
	}
	else
	{
		SetPlayerVirtualWorld(playerid, 0);
	}
	DeletePVar(playerid, "Vinyl-bilet");
    DeletePVar(playerid, "Vinyl-VIP");
    PlayerInfo[playerid][pMuted] = 0;
	WnetrzeWozu[playerid] = 0;
	spamwl[playerid] = 0;
	if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0)
	{
    	SetPlayerWeatherEx(playerid, ServerWeather);//Pogoda
	}
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
	{
    	SetPlayerWeatherEx(playerid, 3);//Pogoda
	}
	//Diler Broni
	if(PlayerInfo[playerid][pJob] == 9 && !IsADilerBroni(playerid))
	{
	    PlayerInfo[playerid][pJob] = 0;
	    SendClientMessage(playerid, COLOR_WHITE, "Zosta³eœ wyrzucony z pracy!");
	}
    // usuwanie
    if(PlayerInfo[playerid][pRank] == 99 && PlayerInfo[playerid][pMember] == 99) {
        PlayerInfo[playerid][pRank] = 0;
        PlayerInfo[playerid][pMember] = 0;
        gTeam[playerid] = 3;
        PlayerInfo[playerid][pTeam] = 3;
        PlayerInfo[playerid][pMember] = 0;
        PlayerInfo[playerid][pRank] = 0;
        PlayerInfo[playerid][pUniform] = 0;
        PlayerInfo[playerid][pTajniak] = 0;
        MruMySQL_SetAccInt("Rank", GetNick(playerid), 0);
        MruMySQL_SetAccInt("Member", GetNick(playerid), 0);
        UsunBron(playerid);
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zosta³eœ wyrzucony z pracy przez lidera, gdy by³eœ offline!");
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
	/*if(newsTypePlayer[playerid] != 0 && !gNews[playerid] && PlayerPersonalization[playerid][PERS_AD] == 0)
	{
		PlayerTextDrawSetString(playerid, SN_MESS[playerid], "~y~NR Marcepan Marks: ~w~Zapraszamy na nasza strone www.sannews.com");
		PlayerTextDrawShow(playerid, SN_MESS[playerid]); 
	}*/
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
		SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 1);
	    new losuj= random(sizeof(Cela));
		SetPlayerPos(playerid, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
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
			SetPVarInt(playerid, "DostalAJkomunikat", 1);
		}
		if(strfind(PlayerInfo[playerid][pAJreason], "DM2", true) != -1 || 
		strfind(PlayerInfo[playerid][pAJreason], "Death Match 2", true) != -1) SetPVarInt(playerid, "DostalDM2", 1);
		SendClientMessage(playerid, COLOR_PANICRED, string);
	}
	else if(PlayerInfo[playerid][pJailed] == 10)//Marcepan Admin Jail
	{
	    new string[256];
	    new kaseczka = (kaska[playerid] > 0) ? (kaska[playerid]/2) : 1;
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* Zosta³eœ uwieziony w Admin Jailu przez Admina Marcepan_Marks. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
		PlayerInfo[playerid][pJailed] = 3;
		PlayerInfo[playerid][pJailTime] = 15*60;
		format(PlayerInfo[playerid][pAJreason], MAX_AJ_REASON, "/q podczas akcji (Marcepan)");
        SetPlayerVirtualWorld(playerid, 1000+playerid);
		PlayerInfo[playerid][pMuted] = 1;
		SetPlayerPos(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
		format(string, sizeof(string), "Zosta³eœ ukarany na 15 minut. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina Marcepan_Marks. Powod: /q podczas akcji + zabieram po³owê kasy i broñ", sendername);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		format(string, sizeof(string), "Dodatkowo zabrano z twojego portfela %d$ i wyzerowano twoje bronie oraz zabrano po³owê matsów", kaseczka);
        SendClientMessage(playerid, COLOR_LIGHTRED, string);
        Log(punishmentLog, INFO, "%s da³ /q podczas akcji wiêc zabrano mu %d$, %d materia³ów oraz broñ.", GetPlayerLogName(playerid), kaseczka, PlayerInfo[playerid][pMats]/2);
        ZabierzKase(playerid, kaseczka);
        PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats]/2;
	}
	//Paintball
    else if(PlayerPaintballing[playerid] != 0)
	{
	    ResetPlayerWeapons(playerid);
  		GivePlayerWeapon(playerid, 29, 999);
	    new rand = random(sizeof(PaintballSpawns));
		SetPlayerPos(playerid, PaintballSpawns[rand][0], PaintballSpawns[rand][1], PaintballSpawns[rand][2]);
		SetCameraBehindPlayer(playerid);
	}
	//BW:
	else if(PlayerInfo[playerid][pBW] > 0)
	{
		if(PlayerRequestMedic[playerid] == 1)
		{
			ZespawnujGraczaBW(playerid);
		}
		else
		{
			ZespawnujGraczaSzpitalBW(playerid);
		}
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
			SetPlayerInterior(playerid, PlayerInfo[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
			if(GetPLocal(playerid) == PLOCAL_INNE_BANK || GetPLocal(playerid) == PLOCAL_FRAC_DMV)
	        {
				sendTipMessage(playerid, "W banku nie wolno mieæ broni! Zostanie Ci ona przywrócona po œmierci.");
				SetPVarInt(playerid, "mozeUsunacBronie", 1);
                ResetPlayerWeapons(playerid);
				return 1;
			}

		}
		else
		{
		    if(PlayerInfo[playerid][pSpawn] == 0) //Normalny spawn
		    {
		        SetPlayerInteriorEx(playerid, 0);
		        PlayerInfo[playerid][pLocal] = 255;
				SetPlayerVirtualWorld(playerid, 0); 
				if(GetPlayerFraction(playerid) > 0) //Spawn Frakcji
				{
				    switch(GetPlayerFraction(playerid))
				    {
						case FRAC_LSPD: //1
						{
						    new rand = random(sizeof(gCopPlayerSpawns));
							SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]);
							SetPlayerFacingAngle(playerid, 90.0);
						}
						case FRAC_FBI: //2
						{
						    if(PlayerInfo[playerid][pTajniak] == 0)
						    {
                                SetPlayerPos(playerid, 598.2130,-1491.1135,15.1351);
								SetPlayerFacingAngle(playerid, 270.0);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 1)
		  					{
		  					    SetPlayerPos(playerid, 2495.2163,-1687.2322,13.5150);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 2)
		  					{
		  					    SetPlayerPos(playerid, 1939.1940,-1116.3353,27.0151);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 3)
		  					{
                                SetPlayerPos(playerid, 738.8827,-1429.9484,13.5234);
		  					}
         					else if(PlayerInfo[playerid][pTajniak] == 4)
		  					{
                                SetPlayerPos(playerid, 2801.0273,-1089.4576,30.7188);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 5)
		  					{
		  					    SetPlayerPos(playerid, 2467.5117,-1278.2054,29.9264);
							}
		  					else if(PlayerInfo[playerid][pTajniak] == 6)
		  					{
								new rand = random(sizeof(gTajniakSpawn));
								SetPlayerPos(playerid, gTajniakSpawn[rand][0], gTajniakSpawn[rand][1], gTajniakSpawn[rand][2]); // Warp the player
								SetPlayerFacingAngle(playerid, 270.0);
		  					}
		  					else
		  					{
                                SetPlayerPos(playerid, 2467.5117,-1278.2054,29.9264);
		  					}

						}
						case FRAC_NG: //3
						{
						    SetPlayerPos(playerid, 261.8342, 71.2429, 1003.2422);// stara: 2515.0200, -2459.5896, 13.8187
							SetPlayerInterior(playerid, 6);
							SetPlayerVirtualWorld(playerid, 88);
							Wchodzenie(playerid);
						}
						case FRAC_ERS:  //4
						{
						    SetPlayerPos(playerid, 1148.4323,-1315.4225,13.9841);
		    				SetPlayerFacingAngle(playerid,358.0);
						}
						case FRAC_LCN: //5
						{
						    SetPlayerPos(playerid, 738.8827,-1429.9484,13.5234);
						}
						case FRAC_YKZ: //6
						{
                            SetPlayerPos(playerid, 2794.8042,-1087.1310,30.7188);
						}
						case FRAC_BOR: //7
						{
						    SetPlayerPos(playerid, 1519.0970,-1449.6099,13.5391);
						}
						case FRAC_HA: //8
						{
						    SetPlayerPos(playerid, -50.400001525879,-279.20001220703,6.0999999046326);
						}
						case FRAC_SN: //9
						{
							if(PlayerInfo[playerid][pRank] <= 1)
							{
								SetPlayerPos(playerid, 297.7128,-1612.1783,114.4219);//Dach SN
								Wchodzenie(playerid);
								sendTipMessage(playerid, "Zrespi³eœ siê na dachu San News"); 
							}
							else if(PlayerInfo[playerid][pRank] >= 2 && PlayerInfo[playerid][pRank] < 7) 
							{
								SetPlayerPos(playerid, 288.0914,-1609.7465,17.9994); 
								Wchodzenie(playerid);
							}
							else if(PlayerInfo[playerid][pRank] >= 8)
							{
								SetPlayerPos(playerid, 288.0914,-1609.7465,17.9994); 
								Wchodzenie(playerid);
							}
						   // SetPlayerPos(playerid, 735.2266,-1336.5826,13.5358);
						}
						case FRAC_KT: //10
						{
							SetPlayerPos(playerid,2468.3796,-2082.9690,13.5580);
                            SetPlayerFacingAngle(playerid, 89.1901);
						}
						case FRAC_GOV: //11
						{
							if(PlayerInfo[playerid][pLider] == 11)
							{
							    SetPlayerPos(playerid, 1460.4297,-1853.9827,81.9475);
							    SetPlayerVirtualWorld(playerid, 50);
							    SetPlayerInterior(playerid, 0);
								PlayerInfo[playerid][pLocal] = 108;
			                    Wchodzenie(playerid);
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
						case FRAC_GROOVE: //12
						{
          					SetPlayerPos(playerid,2496.8523,-1685.3225,13.4172);
                            SetPlayerFacingAngle(playerid, 345.4405);
						}
						case FRAC_BALLAS: //13
						{
						    SetPlayerPos(playerid,173.6043,-150.9147,1.5781);
                            SetPlayerFacingAngle(playerid, 319.2664);
						}
						case FRAC_VAGOS: //14
						{
						    SetPlayerPos(playerid, 2177.1636,-984.1085,64.4688);
							SetPlayerFacingAngle(playerid, 316.333);
						}
						case FRAC_NOA: //15
						{
						    SetPlayerPos(playerid, 1104.4066,-1224.0862,15.8435);
		    				SetPlayerFacingAngle(playerid, 181.0);
						}
						case FRAC_WPS: //16
						{
						    SetPlayerPos(playerid, 2508.0671,-2019.8987,13.9482);
						}
				    }
				}
				else if(GetPlayerOrg(playerid) > 0) //Spawn Organizacji
				{
                    new org = gPlayerOrg[playerid];
		            if(OrgInfo[org][o_Spawn][0] != 0.0)
		            {
		                SetPlayerVirtualWorld(playerid, OrgInfo[org][o_VW]);
		    		    SetPlayerInteriorEx(playerid, OrgInfo[org][o_Int]);
		    		    SetPlayerPos(playerid, OrgInfo[org][o_Spawn][0], OrgInfo[org][o_Spawn][1], OrgInfo[org][o_Spawn][2]);
		    		    SetPlayerFacingAngle(playerid, OrgInfo[org][o_Spawn][3]);
		            }
		            else
		            {
						SendClientMessage(playerid, COLOR_YELLOW, "Twoja rodzina nie ma jeszcza spawnu - spawnujesz siê jako cywil");
                        new rand = random(sizeof(gRandomPlayerSpawns));
			    		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
			    		SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[rand][3]);
					}
				}
				else if(PlayerInfo[playerid][pJob] > 0) //Spawn Prac
				{
				    switch(PlayerInfo[playerid][pJob])
				    {
						case JOB_MECHANIC:
						{
						    SetPlayerPos(playerid,2794.5515,-1619.3689,10.9219);
		    				SetPlayerFacingAngle(playerid, 80.0);
						}
						case JOB_LAWYER:
						{
							Wchodzenie(playerid);
						    SetPlayerPos(playerid,319.72470092773, -1548.3374023438, 14.555289230347);
		    				SetPlayerFacingAngle(playerid, 230.0);
						}
						case JOB_LOWCA:
						{
						    SetPlayerPos(playerid,322.0553894043, 303.41961669922, 999.1484375);
		    				SetPlayerInterior(playerid,5);
						}
						case JOB_BOXER:
						{
						    SetPlayerPos(playerid,766.0804,14.5133,1000.7004);
		    				SetPlayerInterior(playerid, 5);
						}
						case JOB_TRUCKER:
						{
						    SetPlayerPos(playerid, 1751.4445, -2054.9761, 13.0593);
		    				SetPlayerFacingAngle(playerid, 180.0);
						}
						case JOB_BUSDRIVER:
						{
						    SetPlayerPos(playerid, 1143.0999755859,-1754.0999755859,13.60000038147);
						}
						case JOB_BODYGUARD:
						{
						    SetPlayerPos(playerid, 2207.4038,-1725.1147,13.4060);
						}
						default: //Spawn cywila
						{
							if(PlayerCanSpawnWihoutTutorial(playerid))
							{
								SetPlayerPos(playerid, 1742.9498, -1860.8604, 13.5782);
								SetPlayerFacingAngle(playerid, 0.94);
							}
						}
				    }
				}
				else //Spawn cywila
				{
					if(PlayerCanSpawnWihoutTutorial(playerid))
					{
						SetPlayerPos(playerid, 1742.9498, -1860.8604, 13.5782);
						SetPlayerFacingAngle(playerid, 0.94);
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
                SetPlayerInteriorEx(playerid, Dom[i][hInterior]);
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
		DajBronieOganizacji(playerid);
	if(PlayerInfo[playerid][pJob])
	    DajBroniePracy(playerid);
    if(MaZapisanaBron(playerid))
		PrzywrocBron(playerid);

    //HP:
	if(PlayerInfo[playerid][pInjury] == 0 && PlayerInfo[playerid][pBW] == 0)
	{
		if(IsAPolicja(playerid) && OnDuty[playerid] == 1 && PlayerInfo[playerid][pTajniak] != 6)
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
	new name[MAX_PLAYER_NAME];
    DisablePlayerCheckpoint(playerid);

	if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
	{
		if(GetPVarInt(playerid, "WybralBieg") == 1)
		{
			if(OszukujewBiegu[playerid] == 0)
			{
				if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
				{
					CreateNewRunCheckPoint(playerid, 1709.3523,-1461.3938,13.5469, 3, "Zaliczy³eœ pierwszy przystanek, kolejny jest ju¿ oznaczony!", 0, true);
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
				{
					CreateNewRunCheckPoint(playerid, 1707.8762,-1584.3118,13.5453, 3, "Zaliczy³eœ drugi przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
				{
					CreateNewRunCheckPoint(playerid, 1625.7415,-1608.9004,13.7188, 3, "Zaliczy³eœ trzeci przystanek, kolejny jest ju¿ oznaczony!", 5,true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
				{
					CreateNewRunCheckPoint(playerid, 1538.9513,-1724.1267,13.5469, 3, "Zaliczy³eœ czwarty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
				{
					CreateNewRunCheckPoint(playerid, 1322.6306,-1724.9469,13.5469, 3, "Zaliczy³eœ pi¹ty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
				{
					CreateNewRunCheckPoint(playerid, 1318.4052,-1841.7726,13.5469, 3, "Zaliczy³eœ szósty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
				{
					CreateNewRunCheckPoint(playerid,  1382.2340,-1811.7761,13.5469, 3, "Zaliczy³eœ siódmy (przedostatni) przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
				{
					EndRunPlayer(playerid, 10);
				}
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_RED, "WYKRYTO OSZUSTWO! TWÓJ BIEG ZOSTAJE PRZERWANY"); 
				DisablePlayerCheckpoint(playerid);
				SetPVarInt(playerid, "ZaliczylBaze", 0);
				SetPVarInt(playerid, "WybralBieg", 0);
				SetPVarInt(playerid, "RozpoczalBieg", 0);
			}
		}
		else if(GetPVarInt(playerid, "WybralBieg") == 2)
		{
			if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
			{
				CreateNewRunCheckPoint(playerid,  535.0668,-1364.9790,15.8432, 2, "Zaliczy³eœ pierwszy checkpoint! Nastêpny zosta³ ju¿ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
			{
				CreateNewRunCheckPoint(playerid,  339.2540,-1526.9476,33.3757, 2, "Zaliczy³eœ drugi checkpoint! Nastêpny zosta³ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
			{
				CreateNewRunCheckPoint(playerid,  317.4830,-1632.8326,33.3125, 2, "Zaliczy³eœ trzeci checkpoint! Nastêpny zosta³ oznaczony, a ty siê nie poddajesz!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
			{
				CreateNewRunCheckPoint(playerid,  364.1078,-1805.8809,7.8380, 2, "Zaliczy³eœ czwarty checkpoint! Pi¹ty jest ju¿ oznaczony!", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
			{
				CreateNewRunCheckPoint(playerid,  664.4612,-1859.3246,5.4609, 2, "Zaliczy³eœ Pi¹ty checkpoint! Zosta³y jeszcze dwa!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
			{
				CreateNewRunCheckPoint(playerid,  966.9481,-1834.9043,12.6000, 2, "Szósty przystanek zaliczony! Biegnij do kolejnego", 0, true); 

			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
			{
				CreateNewRunCheckPoint(playerid,  1000.8669,-1857.4419,12.8146, 2, "Zaliczy³eœ siódmy checkpoint! Ju¿ widaæ ostatni", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
			{
				EndRunPlayer(playerid, 5);
			}
		}
		else//Jeœli wybra³ dialog do pokazania punktu startowego trasy
		{
			DisablePlayerCheckpoint(playerid);
			sendTipMessageEx(playerid, COLOR_P@, "Aby rozpocz¹æ bieg wpisz w tym miejscu [/biegnij]"); 
			SetPVarInt(playerid, "RozpoczalBieg", 0);
		}
	}
	if(PizzaJob[playerid] != 0)
	{
	    SetTimerEx("PizzaJobTimer01", 4000, false, "i", playerid);
	    GameTextForPlayer(playerid, "KLIENT ZABIERA PIZZE", 4000, 3);
	    TogglePlayerControllable(playerid,0);
	}

    TJD_CallCheckpoint(playerid, GetPlayerVehicleID(playerid));

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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
			CP[playerid]=555;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: El Corona - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Unity Station");
		}
		else if(CP[playerid]==555)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4); //Przystanek Komisariat
			CP[playerid]=556;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta");
		}
		else if(CP[playerid]==556)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
			CP[playerid]=557;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Verte Bank ");
		}
		else if(CP[playerid]==557)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1008.5986,-1140.0272,23.2408, 4);
			CP[playerid]=558;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Bymber Casino ");
		}
		else if(CP[playerid]==558)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market – Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 708.8574,-1391.8915,13.0002, 4);
			CP[playerid]=560;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Centrala SAN");
		}
		else if(CP[playerid]==560)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4);
			CP[playerid]=1008;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: G³ówna siedziba FBI (N/¯)");
		}
		else if(CP[playerid]==1008)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 354.7779,-1643.9617,32.4429, 4);
			CP[playerid]=562;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Molo Wêdkarskie ");
		}
		else if(CP[playerid]==562)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – Molo Wêdkarskie", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
			CP[playerid]=1007;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: G³ówna siedziba FBI (N/¯) ");
		}
		else if(CP[playerid]==1007)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 723.2538,-1407.2189,12.9320, 4);
			CP[playerid]=566;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Rodeo - Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Centrala SAN ");
		}
		else if(CP[playerid]==566)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 830.8025,-1330.0034,13.5437, 4);
			CP[playerid]=567;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==567)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1034.3179,-1150.8452,23.2292, 4); //Bymber Kasyno
			CP[playerid]=568;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Bymber Casino ");
		}
		else if(CP[playerid]==568)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market – Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4); //Bank
			CP[playerid]=569;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Downtown - Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Verte Bank ");
		}
		else if(CP[playerid]==569)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4); //Komisariat LS
			CP[playerid]=570;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Urz¹d Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta ");
		}
		else if(CP[playerid]==570)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4);
			CP[playerid]=571;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: El Corona - Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Unity Station ");
		}
		else if(CP[playerid]==571)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1853.2744,-1393.1622,12.9655, 4);
			CP[playerid]=572;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Idlewood - Glen Park - Jefferson\n{808080}Nastêpny przystanek: Skate Park ");
		}
		else if(CP[playerid]==572)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Idlewood – Skate Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
			CP[playerid]=573;
			Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: Koœció³\n{778899}Trasa: Glen Park - Jefferson\n{808080}Nastêpny przystanek: Glen Park ");
		}
		else if(CP[playerid]==573)
		{
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+230$");
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
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 5980$ premii za dwukrotne przejechanie trasy! (26 przystanków)");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +2");
				PlayerInfo[playerid][pCarSkill] += 2;
				if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 5980);
				else DajKase(playerid, 5980);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia55] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
				Przystanek(playerid, COLOR_BLUE, "Linia ZAJ\nLinia 55 do zajezdni Ocean Docks\n{778899}Trasa: Idlewood - Willowfield\n{808080}Zatrzymuje siê na przystankach");
				SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
				CP[playerid]=1200;
				}
				else if(PlayerInfo[playerid][pJob] == 10)
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
			SendClientMessage(playerid, COLOR_GREEN, "+100$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Ganton - Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Bar Ten Green Bottles (N/¯)");
		}
		else if(CP[playerid]==1009)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2182.5671,-1708.4637,13.4766, 4); //
			CP[playerid]=722;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton – Bar Ten Green Bottles (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+50$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Si³ownia");
		}
		else if(CP[playerid]==722)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid,  1890.3834,-1749.6218,12.9520, 4);//
			CP[playerid]=723;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Si³ownia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Stacja Benzynowa");
		}
		else if(CP[playerid]==723)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4);
			CP[playerid]=724;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urz¹d Miasta - Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Komisariat / Urz¹d Miasta ");
		}
		else if(CP[playerid]==724)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
			CP[playerid]=725;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Verte Bank (jedn.) ");
		}
		else if(CP[playerid]==725)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1340.7183,-1346.4941,12.9510, 4); //stacja benz prawa
			CP[playerid]=726;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown – Bank (jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}Nastêpny przystanek: Ammu-Nation (jedn.)");
		}
		else if(CP[playerid]==726)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1208.1235,-1314.7834,12.9645, 4);
			CP[playerid]=727;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown - Ammu-Nation(jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Szpital");
		}
		else if(CP[playerid]==727)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 836.6970,-1318.8370,12.9458, 4);
			CP[playerid]=728;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market – Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==728)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4); //mrucznik tower
			CP[playerid]=729;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Market - Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Market Station ");
		}
		else if(CP[playerid]==730)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
			CP[playerid]=731;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa:  Market - Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Szpital ");

		}
		else if(CP[playerid]==731)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4);//komi LS
			CP[playerid]=734;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market - Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Downtown - Urz¹d Miasta - Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Urz¹d Miasta/Komisariat ");
		}
		else if(CP[playerid]==734)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1924.6978,-1754.4702,12.9486, 4);
			CP[playerid]=735;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square – Komisariat / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Stacja Benzynowa ");
		}
		else if(CP[playerid]==735)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2162.4690,-1754.0964,12.9439, 4);
			CP[playerid]=736;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood – Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}Nastêpny przystanek: Si³ownia");
		}
		else if(CP[playerid]==736)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2314.7969,-1661.7714,13.8587  , 4);
			CP[playerid]=1010;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood - Szamboa Gym", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+200$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Ganton - East Los Santos\n{808080}Nastêpny przystanek: Bar Ten Green Bottles (N/¯) ");
		}
		else if(CP[playerid]==1010)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2489.3118,-1735.8690,13.3172 , 4);
			CP[playerid]=742;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Bar Ten Green Bottles (N/¯)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+50$");
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza Mechaników\n{778899}Trasa: Ganton - East Los Santos\n{808080}Nastêpny przystanek: Grove Street ");
		}
		else if(CP[playerid]==742)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2818.4243,-1576.9399,10.9287, 4);
			CP[playerid]=737;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Grove Street", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+100$");
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
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 3300$ premii za dwukrotne przejechanie trasy! (19 przystanków)");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Chc¹c powtórzyæ t¹ trasê zawróæ wykorzystuj¹c parking znajduj¹cy siê na skrzy¿owaniu w w lewo.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +1");
				PlayerInfo[playerid][pCarSkill] ++;
				if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 3300);
				else DajKase(playerid, 3300);
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
				else if(PlayerInfo[playerid][pJob] == 10)
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Baza Mechaników ");

		}
		else if(CP[playerid]==823)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4);
			CP[playerid]=824;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Dillimore - Bluberry - Las Venturas\n{808080}Nastêpny przystanek: Hilltop Farm ");
		}
		else if(CP[playerid]==826)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 661.4372,-597.9591,15.7536, 4);
			CP[playerid]=827;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore – Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Bluberry - Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Bluberry");
		}
		else if(CP[playerid]==830)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 684.2634,-569.5635,16.3208, 4);
			CP[playerid]=831;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Bluberry", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek:Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Dillimore");
		}
		else if(CP[playerid]==831)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1014.1871,-466.1351,50.5591, 4);
			CP[playerid]=832;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: Hilltop Farm");
		}
		else if(CP[playerid]==832)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2577.4602,39.4546,26.3359, 4); //PC prawa
			CP[playerid]=833;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore – Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Palomino Creek - East Los Santos - Commerce\n{808080}Nastêpny przystanek: miasteczko Palomino Creek");
		}
		else if(CP[playerid]==833)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4); //nakijima prawa
			CP[playerid]=834;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Palomino Creek", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: East Los Santos - Commerce\n{808080}Nastêpny przystanek: Agencja Ochrony");
		}
		else if(CP[playerid]==834)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
			CP[playerid]=835;
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+510$");
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
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 8670$ premii za dwukrotne przejechanie trasy! (17 przystanków)");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +3");
				PlayerInfo[playerid][pCarSkill] += 3;
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
				else if(PlayerInfo[playerid][pJob] == 10)
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
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==962)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1992.8591,-2163.2961,13.3828, 4);//uszkodzony
			CP[playerid]=963;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocean Docks – Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==963)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=964;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko – Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==964)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
			CP[playerid]=965;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==965)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1463.1995,-1868.8994,13.3999, 4); //Przystanek commerce VB prawa
			CP[playerid]=966;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Verdant Bluffs / Urz¹d Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==966)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1181.8771,-1748.0386,12.9679, 4);
			CP[playerid]=967;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Verdant Bluffs / Urz¹d Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==967)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1084.2205,-1569.8024,12.9443, 4);
			CP[playerid]=968;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Market - Marina - Rodeo\n{808080}Nastêpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Basen „Tsunami” / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==968)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 824.0928,-1624.2281,12.9477, 4);
			CP[playerid]=969;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Marina - Rodeo\n{808080}Nastêpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market – Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==969)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
			CP[playerid]=970;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: G³ówna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina – Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==970)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 535.0409,-1243.6492,16.0884, 4);// wypozyczalnia prawa
			CP[playerid]=971;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: Wypo¿yczalnia Aut");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==971)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4);
			CP[playerid]=972;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}Nastêpny przystanek: MRUCZNIK TOWER");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – Wypo¿yczalnia Pojazdów", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==973)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4); //Druga strona ulicy CP
			CP[playerid]=974;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: G³ówna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – Wypo¿yczalnia Pojazdów", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==974)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 840.9546,-1614.0339,12.9483, 4);
			CP[playerid]=975;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo – G³ówna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==975)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1105.6156,-1574.0813,12.9401, 4);
			CP[playerid]=976;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina – Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==976)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1173.1520,-1825.2843,13.1789, 4);
			CP[playerid]=977;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market – Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==977)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1492,-1875.8005,13.9999, 4);
			CP[playerid]=978;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Verdant Bluffs / Urz¹d Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Basen „Tsunami” / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==978)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4); //wiadukt lewy
			CP[playerid]=979;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce – Verdant Bluffs", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==979)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=980;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==980)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1977.1256,-2168.7412,12.9419, 4);
			CP[playerid]=981;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Lotnisko - Ocean Docks\n{808080}Nastêpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona – Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==981)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2228.8030,-2198.2109,12.9153, 4);
			CP[playerid]=982;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Fabryka");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko – Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==982)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2335.9858,-2355.0427,13.3828, 4);
			CP[playerid]=1202;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==982)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2495.6113,-2408.0415,13.5445, 4);
			CP[playerid]=983;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==983)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2687.6597,-2406.9775,13.6017, 4);
			CP[playerid]=984;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Wiêzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}Nastêpny przystanek: WIÊZIENIE STANOWE");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks – Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==984)
		{
		    if(BusCzit[playerid] == 1)
			{
			    KickEx(playerid);
			}
			else
			{
			    ProxDetector(10.0, playerid, "Przystanek koñcowy: {EE82EE}Ocean Docks – Wiêzienie Stanowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 96 zakoñczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 7440$ premii za dwukrotne przejechanie trasy! (24 przystanki)");
				SendClientMessage(playerid, COLOR_GREEN, "Mo¿esz znów rozpocz¹æ t¹ lub inn¹ trasê lub zrezygnowaæ poprzez zamkniêcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Je¿eli jednak chcesz zakoñczyæ pracê kieruj siê do zajezdni LSBD (wskazanej przez sygan³ GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +1");
				PlayerInfo[playerid][pCarSkill] ++;
                if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 7440);
                else DajKase(playerid, 7440);
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
				else if(PlayerInfo[playerid][pJob] == 10)
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
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==503)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
			CP[playerid]=504;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Baza Mechaników");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Myjnia Samochodowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==504)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4);
			CP[playerid]=505;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==505)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2541.5476,-1050.6461,68.9680, 4); //Przystanek commerce VB prawa
			CP[playerid]=506;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==506)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2202.1843,-1011.6302,61.2425, 4);
			CP[playerid]=507;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Las Colinas 32");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==507)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2248.4707,-1139.6617,25.7001, 4);
			CP[playerid]=508;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Jefferson - Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==508)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1967.2327,-1198.9353,25.2217, 4);
			CP[playerid]=509;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Glen Park - Downtown - Market\n{808080}Nastêpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==509)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1810.9371,-1181.5383,23.2077, 4);
			CP[playerid]=510;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}Nastêpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==510)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4);// wypozyczalnia prawa
			CP[playerid]=511;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}Nastêpny przystanek: Verte Bank");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==511)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
			CP[playerid]=512;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Market\n{808080}Nastêpny przystanek: SZPITAL");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
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
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==513)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1781.2218,-1167.9779,23.2261, 4); //Druga strona ulicy CP
			CP[playerid]=514;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Nastêpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==514)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
			CP[playerid]=515;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Nastêpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown – Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==515)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2255.2795,-1145.6331,26.0940, 4);
			CP[playerid]=516;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Jefferson - Las Colinas - East Los Santos - Willowfield\n{808080}Nastêpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==516)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2193.2642,-1012.3875,61.8830, 4);
			CP[playerid]=517;
		    Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Las Colinas 34");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson – Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==517)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2520.0220,-1044.3973,68.9851, 4);
			CP[playerid]=518;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==518)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4); //wiadukt lewy
			CP[playerid]=519;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==519)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2864.6250,-1539.0991,10.4947, 4);
			CP[playerid]=520;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}Nastêpny przystanek: Baza Mechaników");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==520)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2514.7009,-1501.5859,23.8281, 4);
			CP[playerid]=521;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: Myjnia Samochodowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos – Baza Mechaników", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==521)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2411.1692,-1908.5591,12.9485, 4);
			CP[playerid]=522;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: Cluckin Bell");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Myjnia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==522)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2118.5024,-1891.6978,12.9058, 4);
			CP[playerid]=523;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}Nastêpny przystanek: WYSYPISKO");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield – Clukin Bell", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
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
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +2");
				PlayerInfo[playerid][pCarSkill] += 2;
                if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 6480);
                else DajKase(playerid, 6480);
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
				else if(PlayerInfo[playerid][pJob] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Commerce\n{778899}Trasa: Willowfield - Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siê na przystankach");
					SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
					CP[playerid]=1201;
    			}
			}
		}
	}
//koniec linii 85 i system autobusów
	else if(CP[playerid]==1)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    PlayerInfo[playerid][pJackSkill] ++;
			if(PlayerInfo[playerid][pJackSkill] == 50)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 2, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 100)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 3, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 200)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 4, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 400)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 5, bêdziesz najwiêcej zarabiaæ oraz najszybciej kraœæ auta."); }
			new level = PlayerInfo[playerid][pJackSkill];
			if(level >= 0 && level <= 50)
			{
			    new rand = random(sizeof(SELLCAR1));
			    format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 20 minut.", SELLCAR1[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR1[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 600;
			}
			else if(level >= 51 && level <= 100)
			{
			    new rand = random(sizeof(SELLCAR2));
			    format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 18 minut.", SELLCAR2[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR2[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 540;
			}
			else if(level >= 101 && level <= 200)
			{
			    new rand = random(sizeof(SELLCAR3));
			    format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 16 minut.", SELLCAR3[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR3[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 480;
			}
			else if(level >= 201 && level <= 400)
			{
			    new rand = random(sizeof(SELLCAR4));
			    format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 14 minut.", SELLCAR4[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR4[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 420;
			}
			else if(level >= 401)
			{
			    new money = 6000;
			    format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d, nastêpny pojazd mo¿esz ukraœæ za 12 minut.", money);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, money);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 360;
			}
			GameTextForPlayer(playerid, "~y~Sprzedales pojazd", 2500, 1);
			CP[playerid] = 0;
		    DisablePlayerCheckpoint(playerid);
		    RespawnVehicleEx(GetPlayerVehicleID(playerid));
		}
		else
		{
		    GameTextForPlayer(playerid, "Nie jestes w wozie", 5000, 1);
		}
	}
	else if(CP[playerid] == 5)
	{
	    GameTextForPlayer(playerid, "~y~W punkcie misji", 2500, 1);
		CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 9)//Karting
	{
		GameTextForPlayer(playerid, "~r~Czekaj tutaj na wiecej gokardow", 4000, 3);
		DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 10) { CP[playerid] = 11; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2258.7874,-2402.9712,12.7035,8.0); }
	else if(CP[playerid] == 11) { CP[playerid] = 12; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2225.8755,-2461.3875,12.7190,8.0); }
	else if(CP[playerid] == 12) { CP[playerid] = 13; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2276.9983,-2662.8328,12.8580,8.0); }
	else if(CP[playerid] == 13) { CP[playerid] = 14; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2449.1399,-2663.0562,12.8138,8.0); }
	else if(CP[playerid] == 14) { CP[playerid] = 15; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2566.9814,-2504.5686,12.7692,8.0); }
	else if(CP[playerid] == 15) { CP[playerid] = 16; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2719.0520,-2503.5962,12.7706,8.0); }
	else if(CP[playerid] == 16) { CP[playerid] = 17; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2720.7881,-2405.6589,12.7441,8.0); }
	else if(CP[playerid] == 17) { CP[playerid] = 18; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2571.5195,-2401.1531,12.7528,8.0); }
	else if(CP[playerid] == 18) { CP[playerid] = 19; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2406.6995,-2423.1182,12.6641,8.0); }
	else if(CP[playerid] == 19) { CP[playerid] = 20; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2322.9194,-2341.5715,12.6664,8.0); }
	else if(CP[playerid] == 20)//End of Karting
	{
	    CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	    GetPlayerName(playerid, name, sizeof(name));
	    if(FirstKartWinner == 999)
	    {
	        FirstKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako pierwszy !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(SecondKartWinner == 999)
	    {
	        SecondKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako drugi !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(ThirdKartWinner == 999)
	    {
	        ThirdKartWinner = playerid;
	        foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoñczy³eœ wyœcig jako trzeci.",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		                SendClientMessage(i, COLOR_WHITE, "** Koniec wyœcigu **");
		                CP[i] = 0;
		                DisablePlayerCheckpoint(i);
		            }
				}
	        }
	    }
	}
	else if(MissionCheckpoint[playerid] > 0 && PlayMission[kToggle] == 1)//Missions + Checkpoint on toggle
	{
		    switch(MissionCheckpoint[playerid])
		    {
	        	case 1:
		        {
					format(string, sizeof(string), "%s", PlayMission[kGText1]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText4]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText5]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText6]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP2][0], PlayMission[kCP2][1], PlayMission[kCP2][2], 8);
					MissionCheckpoint[playerid] = 2;
		        }
		        case 2:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText2]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText7]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText8]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText9]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP3][0], PlayMission[kCP3][1], PlayMission[kCP3][2], 8);
					MissionCheckpoint[playerid] = 3;
		        }
		        case 3:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText3]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText10]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText11]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText12]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP4][0], PlayMission[kCP4][1], PlayMission[kCP4][2], 8);
					MissionCheckpoint[playerid] = 4;
		        }
		        case 4:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText4]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText13]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText14]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText15]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP5][0], PlayMission[kCP5][1], PlayMission[kCP5][2], 8);
					MissionCheckpoint[playerid] = 5;
		        }
		        case 5:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText5]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText16]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText17]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText18]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP6][0], PlayMission[kCP6][1], PlayMission[kCP6][2], 8);
					MissionCheckpoint[playerid] = 6;
		        }
		        case 6:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText6]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "..:: Ukoñczona Misje: %s | Zap³ata: $%d ::..", PlayMission[kTitle], PlayMission[kReward]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					DisablePlayerCheckpoint(playerid);
		  			DajKase(playerid, PlayMission[kReward]);//moneycheat
					PlayerInfo[playerid][pMissionNr] = PlayerOnMission[playerid];
					MissionCheckpoint[playerid] = 0;
					PlayerOnMission[playerid] = 0;
		        }
		    }
	}
	else if(zawodnik[playerid] == 1)
	{
		if(okregi[playerid] == 5)
		{
		    if(iloscwygranych == 0)
		    {
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Wygra³ %s - ukoñczy³ wyœcig zajmuj¹c 1 miejsce !!!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 1)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 2 miejsce !!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 2)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c 3 miejsce !.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else
			{
			    iloscwygranych ++;
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoñczy³ wyœcig zajmuj¹c %d miejsce !.", sendername, iloscwygranych);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
	   			SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
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
	else
	{
		switch (gPlayerCheckpointStatus[playerid])
		{
			case CHECKPOINT_HOME:
		    {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "~w~Tu jest twoj~n~~y~Dom", 5000, 1);
		    }
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
	if(IsValidDynamicObject(objectid))
	{
		if(GetPVarInt(playerid, "Allow-edit"))
		{
			MoveDynamicObject(objectid, x, y, z, 10.0, rx, ry, rz);
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
            KickEx(player);
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
				KickEx(player);
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
    if(pickupid == PickupSklep01)
    {
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"|_______________Wybór skina - dostêpne komendy_______________|");
        SendClientMessage(playerid,COLOR_WHITE,"{3CB371}/ubranie{FFFFFF}- zabija i przenosi do zwyk³ego menu wyboru skinów (wybiera³ka). Tylko dla cywili.");
        SendClientMessage(playerid,COLOR_WHITE,"{CD5C5C}/wybierzskin{FFFFFF}- pozwala wybraæ skin przydzielany po s³u¿bie. Tylko dla frakcji z dzia³aj¹cym /duty.");
        SendClientMessage(playerid,COLOR_WHITE,"{ADFF2F}/uniform{FFFFFF}- pozwala na zmianê uniformu s³u¿bowego. Tylko dla cz³onków frakcji z pominiêciem liderów.");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"|___________________________________________________________|");
    }
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
	new string[256];

	if(!Kajdanki_JestemSkuty[playerid] && (PlayerInfo[playerid][pInjury] > 0 && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)))
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
						new costBike = BIKE_COST;
						format(stringDialog, sizeof(stringDialog), "Mo¿esz wypo¿yczyæ ten pojazd\nCena: %d$ za 15 minut", costBike);
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
    else if(oldstate == PLAYER_STATE_DRIVER)
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
		if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999) //Taxi client pay
		{
            Taxi_Pay(playerid);
		}
		PlayerTextDrawHide(playerid, Licznik[playerid]);
    }
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
		{
		    PlayerInKart[playerid] = 0;
		    KartingPlayers --;
		}
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
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    new vehicleid = GetPlayerVehicleID(playerid);
	    foreach(new i : Player)
	    {
			if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2 && TransportDuty[i] > 0)
			{
				if(kaska[playerid] < TransportValue[i])
				{
					format(string, sizeof(string), "* Potrzebujesz $%d aby wejœæ.", TransportValue[i]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					RemovePlayerFromVehicleEx(playerid);
				}
				else
				{
					if(TransportDuty[i] == 1)
					{
						format(string, sizeof(string), "* Stawka wynosi $%d za kilometr.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed³ do Twojej taryfy.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        if(PlayerInfo[playerid][pLevel] < 3)
                        {
                            ZabierzKase(playerid, floatround(TransportValue[i]/4));//moneycheat
                            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Jesteœ nowym graczem, obowi¹zuje Cie rabat 75 procent na taksówkê.");
                        }
                        else
                        {
                            ZabierzKase(playerid, floatround(TransportValue[i]));//moneycheat
                        }
                        TransportMoney[i] += TransportValue[i];
                        SetPVarInt(playerid, "taxi-slot", GetPlayerVehicleSeat(playerid)-1);
						TransportDist[i] = 0.0;
						TransportDist[playerid] = 0.0;
						TransportDriver[playerid] = i;
                        TransportClient[i][GetPVarInt(playerid, "taxi-slot")] = playerid;
                        Taxi_ShowHUD(playerid);
                        Taxi_ShowHUD(i);
					}
					else if(TransportDuty[i] == 2)
					{
						format(string, sizeof(string), "* Zap³aci³eœ $%d Za bilet.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed³ do autobusu i skasowa³ bilet.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        ZabierzKase(playerid, TransportValue[i]);//moneycheat
					    TransportMoney[i] += TransportValue[i];
					}
				}
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
        if(newcar <= CAR_End) //do kradziezy
        {
            if(KradniecieWozu[playerid] != newcar)
		    {
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Mo¿esz ukraœæ ten wóz, wpisz /kradnij aby spróbowaæ to zrobiæ.");
				new engine, lights, alarm, doors, bonnet, boot, objective;
				GetVehicleParamsEx(newcar, engine, lights, alarm, doors, bonnet, boot, objective);
				if(engine) SetVehicleParamsEx(newcar, 0, lights, alarm, doors, bonnet, boot, objective);
			}
        }
		gLastCar[playerid] = newcar;

		

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
	SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 0.0, -1, -1, -1, -1, -1, -1);

	if(gPlayerLogged[playerid] != 1)
	{
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

PayDay()
{
	new string[128], account,interest,playername2[MAX_PLAYER_NAME],
        tmpintrate, checks, ebill;

	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLevel] > 0)
		    {
			    if(MoneyMessage[i]==1)
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "Nie sp³aci³eœ d³ugu, wierzyciele nas³ali na ciebie Policjê !");
					PoziomPoszukiwania[i] += 2;
					SetPlayerCriminal(i,INVALID_PLAYER_ID, "Niesp³acanie d³ugu");
				}
				GetPlayerName(i, playername2, sizeof(playername2));
				account = PlayerInfo[i][pAccount];

				if (PlayerInfo[i][pDom] != 0)
				{
				    if(IsPlayerPremiumOld(i)) { tmpintrate = intrate+4; }
					else { tmpintrate = intrate+2; }//HouseInfo[key][hLevel]
				}
				else
				{
				    if(IsPlayerPremiumOld(i)) { tmpintrate = 3; }
					else { tmpintrate = 1; }
				}
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
					interest = (PlayerInfo[i][pAccount]/1000)*(tmpintrate);
					PlayerInfo[i][pExp]++;
					PlayerPlayMusic(i);
					if(PlayerInfo[i][pAccount] <= 100000000)
					{
						PlayerInfo[i][pAccount] = account+interest;
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
						format(string, sizeof(string), "  Odsetki: 0.%d procent",tmpintrate);
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
					PlayerGames[i] = 0;
                    MRP_PremiumHours[i]++;
					if(PlayerInfo[i][pBP] >= 1)
					{
					    PlayerInfo[i][pBP]--;
					}
					if(((kaska[i] >= 10000000 || PlayerInfo[i][pAccount] >= 10000000) && PlayerInfo[i][pLevel] <= 2) && !DEVELOPMENT)
					{
						MruMySQL_Banuj(i, "10MLN i 1 lvl");
						Log(punishmentLog, INFO, "%s dosta³ bana za 10MLN i 1 lvl (Portfel: %d$, Bank: %d$)", GetPlayerLogName(i), kaska[i], PlayerInfo[i][pAccount]);
						KickEx(i);
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
    printf("-> Removing Houses MapIcons");

	for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
	{
		DestroyDynamicMapIcon(Dom[i][hIkonka]);
	}
	new hour,minuite,second;
	new rand = random(80);
	gettime(hour,minuite,second);
    FixHour(hour);
	if(10 <= shifthour <= 22)
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
	
	if(DmvActorStatus && (shifthour < 9 || shifthour > 23))
	{
		DestroyActorsInDMV(INVALID_PLAYER_ID); 
	}
	else
	{
		CreateActorsInDMV(INVALID_PLAYER_ID);
	}

	if(shifthour == 3)
	{
	    SendClientMessageToAll(COLOR_YELLOW, "Trwa aktualizacja systemu domów, czas na laga");
	    for(new h; h <= dini_Int("Domy/NRD.ini", "NrDomow"); h++)
	    {
			Dom[h][hData_DD] ++;
			if(Dom[h][hData_DD] >= 30)
			{
			    ZlomowanieDomu(9999, h);
			    Log(serverLog, INFO, "Dom %s zosta³ zez³omowany z powodu up³ywu czasu.", GetHouseLogName(h));
			}
	    }
		ZapiszDomy();
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
		return 1;
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
			KickEx(playerid);
			return 1;
		}

		//Sprawdzanie blocków:
		if(PlayerInfo[playerid][pBlock] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest zablokowane, nie mo¿esz na nim graæ.");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeœli uwa¿asz, ¿e konto zosta³o zablokowane nies³usznie napisz apelacje na: {33CCFF}www.Mrucznik-RP.pl");
			KickEx(playerid);
			return 1;
		}
        else if(PlayerInfo[playerid][pBlock] == 2 || PlayerInfo[playerid][pCK] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Ta postaæ jest uœmiercona, nie mo¿esz na niej graæ.");
			KickEx(playerid);
			return 1;
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

		//Powitanie:
		format(string, sizeof(string), "Witaj na serwerze Mrucznik Role Play, %s!",nick);
		SendClientMessage(playerid, COLOR_WHITE,string);
		printf("%s has logged in.",nick);
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
			KickEx(playerid);
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
		PlayerInfo[playerid][pJobSkin] = 0; 
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

	//Filtry na konto:
	/*if(dini_Exists("Filtry.ini"))
	{
		new filtr;
		new filtr_ip[64];
		new filtr_nick[64];
		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		for(new i = 0; i < dini_Int("Filtry.ini", "Liczba"); i++)
		{
			format(filtr_ip, sizeof(filtr_ip), "IP_%d", i);
			if(strcmp(ip, dini_Get("Filtry.ini", filtr_ip), true) == 0)
			{
				format(filtr_nick, sizeof(filtr_nick), "Nick_%d", i);
				if(strcmp(nick, dini_Get("Filtry.ini", filtr_nick), true) == 0)
				{
					SendClientMessage(playerid, COLOR_WHITE,"SERVER: Jesteœ posiadaczem filtru na konto.");
					filtr = 0;
					break;
				}
				else
				{
					filtr++;
				}
			}
		}
		if(filtr != 0)
		{
			SendClientMessage(playerid, COLOR_WHITE,"SERVER: Zosta³eœ zkickowany, powód: Filtr na konto.");
			SendClientMessage(playerid, COLOR_WHITE,"SERVER: Aby go zdj¹æ napisz na forum www.Mrucznik-RP.pl");
			KickEx(playerid);
			return 1;
		}
	}
	else
	{
		dini_Create("Filtry.ini");
		dini_IntSet("Filtry.ini", "Liczba", 0);
	}*/

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
        KickEx(playerid);
        return 1;
    }
    else if(PlayerInfo[playerid][pWarns] < 0) PlayerInfo[playerid][pWarns] = 0;

	premium_loadForPlayer(playerid);
	choroby_OnPlayerLogin(playerid);

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

    //Sync org
    if(GetPlayerOrg(playerid) == 255) PlayerInfo[playerid][pOrg] = 0;

    //Info o rodzinie:
	if(GetPlayerOrg(playerid) != 0)
	{
        gPlayerOrg[playerid] = orgID(PlayerInfo[playerid][pOrg]);
        if(PlayerInfo[playerid][pRank] >= 1000) gPlayerOrgLeader[playerid] = true, PlayerInfo[playerid][pRank]-=1000;

        if(gPlayerOrg[playerid] == 0xFFFF) SendClientMessage(playerid, COLOR_PANICRED, "B£¥D PRZYPISANIA TWOJEJ RODZINY!!!");
        else if(strlen(OrgInfo[gPlayerOrg[playerid]][o_Motd]) > 3)
        {
    		format(string, sizeof(string), "Rodzina MOTD: %s.", OrgInfo[gPlayerOrg[playerid]][o_Motd]);
    		SendClientMessage(playerid, OrgInfo[gPlayerOrg[playerid]][o_Color], string);
        }
        if(PlayerInfo[playerid][pRank] < 0 || PlayerInfo[playerid][pRank] > 9) PlayerInfo[playerid][pRank] = 9;
	}

    //Konwersja pojazdów:
    //CONVERT_PlayerCar(playerid);

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
        else if(PlayerInfo[playerid][pJailed] == 0)
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
            SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
            SetPlayerSpawn(playerid);
			TogglePlayerSpectating(playerid, false);
        }
	}
    else
    {
        SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
		gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
		PlayerInfo[playerid][pMuted] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na Mrucznik Role Play!");
		SendClientMessage(playerid, COLOR_WHITE, "Aby zacz¹æ grê musisz przejœæ procedury rejestracji.");
		ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Witaj na Mrucznik Role Play", "Witaj na serwerze Mrucznik Role Play\nJeœli jesteœ tu nowy, to przygotowaliœmy dla ciebie poradnik\nZa chwilê bêdziesz móg³ go obejrzeæ, lecz najpierw bêdziesz musia³ opisaæ postaæ któr¹ bêdziesz sterowa³\nAby przejœæ dalej wciœnij przycisk 'dalej'", "Dalej", "");
    }
	return 1;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
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
    if(newkeys & KEY_YES && (GetPlayerState(playerid)==PLAYER_STATE_ONFOOT))
    {
        FabrykaMats_ActorTalk(playerid);
    }
	if((newkeys & KEY_HANDBRAKE) && (newkeys & KEY_CROUCH) && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if(GetPVarInt(playerid, "JestPodczasWjezdzania") == 1)
		{
			sendTipMessage(playerid, "Jesteœ podczas wje¿d¿ania!"); 
			return 1;
		}
		if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
		{
			sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile.");
			return 1;
		}	
		if(SprawdzWjazdy(playerid))
		{
		
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ w obszarze, w którym mo¿na wjechaæ"); 
		}
	}
	if((newkeys & KEY_SPRINT) && newkeys & KEY_WALK)
	{
		if(SprawdzBramy(playerid))
		{
		
		}
		else if(SprawdzWejscia(playerid))
		{
		
		}
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
		    tmp = strtok(text, idx);
		    if ((strcmp("1", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("1")))
			{
			    //if(PlayerInfo[playerid][pRank] < 0) { SendClientMessage(playerid, COLOR_GREY, "Masz zbyt nisk¹ rangê aby zamówiæ tê paczke !"); return 0; }
			    if(kaska[playerid] > 2499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczkê numer 1 ($2500), zostanie dostarczona do drzwi Agencji.");
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
			    if(kaska[playerid] > 4999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczkê numer 2 ($5000), zostanie dostarczona do drzwi Agencji.");
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
			    if(kaska[playerid] > 5999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 3 ($6000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 5999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 4 ($6000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 7999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 5 ($8000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 7999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 6 ($8000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 8499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 7 ($8500), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 8499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 8 ($8500), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 9999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 9 ($10000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(kaska[playerid] > 9999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zamówi³eœ paczke numer 10 ($10000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
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
			    if(PlayerInfo[playerid][pRank] >= 0) { SendClientMessage(playerid, COLOR_GREY, "|(1) ($2500) Ranga 0: Nó¿, Desert Eagle, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 1) { SendClientMessage(playerid, COLOR_GREY, "|(2) ($5000) Ranga 1: Nó¿, Desert Eagle, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(3) ($6000) Ranga 2: Nó¿, Desert Eagle, M4, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(4) ($6000) Ranga 2: Nó¿, Desert Eagle, AK47, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(5) ($8000) Ranga 3: Nó¿, Desert Eagle, M4, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(6) ($8000) Ranga 3: Nó¿, Desert Eagle, AK47, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(7) ($8500) Ranga 4: Nó¿, Desert Eagle, M4, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(8) ($8500) Ranga 4: Nó¿, Desert Eagle, AK47, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(9) ($10000) Ranga 5-9: Nó¿, Desert Eagle, M4, UZI, Spas12, Snajperka, Pancerz"); }
                if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(10) ($10000) Ranga 5-9: Nó¿, Desert Eagle, AK47, UZI, Spas12, Snajperka, Pancerz"); }
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
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, "* Kiedy bêdziesz juz na komisariacie, spytaj siê policjanta o /akceptuj prawnik.");
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
		{//todo
			if(strlen(text) < 78)
			{
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
			if(org == 4 && (PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0)) PlayerRequestMedic[playerid] = 1;

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
        if(FRAC_GROOVE <= frac <= FRAC_VAGOS || frac == FRAC_WPS || GetPlayerOrgType(playerid) == ORG_TYPE_GANG)
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
	// if(IsVehicleInCarPark(vehicleid))
	// {
	// 	return 0;//Testowe dzia³anie
	// }
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