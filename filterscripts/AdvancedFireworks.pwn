/*
	 // - - - - - - - - - - - - - - //
	//   Advanced Fireworks v1.0   //
   // - - - - - - - - - - - - - - // 

	Description:
	 This script allows the player to place
	 down various different kind of firework
	 instances and build small to large scale
	 firework shows.
	 
	Commands:
	 /firework
	 /fireworks
		 - Open the firework spawn menu.
		 
	End note:
	 Feel free to edit this script as you like. You
	 are also allowed to borrow any code from it,
	 as long as you keep some credits to me.
	 Please do not claim this as your own.
	
	 If you have any problems with or questions
	 about this script, please contact me via the 
	 official SA-MP forums or on GitHub.
	 
	 GitHub URL:
	 https://github.com/Basssiiie/Advanced-Fireworks

	Regards,
	 Basssiiie
	 
*/

// ---------------------------------------------
// --- > --- > --- MAIN SETTINGS --- < --- < ---
// ---------------------------------------------

// This defines whether the script will assume you have the Streamer Plugin installed.
// Default: true
#define USE_STREAMER true

// This setting defines whether fireworks can be spawned by only admins (true) or everyone (false).
// Default: false
#define RCON_ONLY false

// The color of warning messages in the chat.
// Default: 0xFF0000FF
#define MSG_WARNING 0xFF0000FF

// The maximum amount of firework instances that players can place, per server.
// Default: 20
#define MAX_FIREWORK 20

// The maximum amount of particle objects that can be spawned per firework instance.
// Default: 75
#define MAX_FWOBJECT 75

// This defines how long the fireworks will stay around before it gets destroyed, after it's finished firing all its rounds.
// Default: 10000 (10 seconds)
#define DEF_STAY_TIME 10000



// -----------------------------------------------
// --- > --- > --- THE SOURCE CODE --- < --- < ---
// -----------------------------------------------

// Includes
#define FILTERSCRIPT
#include <a_samp>

#if USE_STREAMER == true
	#include <streamer>
#else
	CreateDynamicObject(model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, i = -1, vw = -1, p = -1, Float: draw = 300.0)
	{
		#pragma unused i
		#pragma unused vw
		#pragma unused p
		return CreateObject(model,x, y, z, rx, ry, rz, draw);
	}
	#define DestroyDynamicObject DestroyObject
	#define MoveDynamicObject MoveObject
	#define IsValidDynamicObject IsValidObject
	#define GetDynamicObjectPos GetObjectPos
	#define GetDynamicObjectRot GetObjectRot
	#define OnDynamicObjectMoved OnObjectMoved
	#define AttachDynamicObjectToVehicle AttachObjectToVehicle
	#define DynamicObject Object
#endif

// Firework types
#define FW_UNKNOWN 0
#define FW_FOUNTAIN 1
#define FW_ROCKET 2
#define FW_SPLITTER 3
#define FW_UMBRELLA 4
#define FW_CAKE 5

#define DEF_ANIM_TIME 2500
#define DEF_DELAY_FIRE 250

// Fountain defines
#define FOUNTAIN_LIFE 10000
#define FOUNTAIN_DELAY 200

// Rocket defines
#define ROCKET_DUPLICATES 25
#define ROCKET_DELAY 1000

// Splitter defines
#define SPLITTER_DUPLICATE_1 7
#define SPLITTER_DUPLICATE_2 10
#define SPLITTER_DELAY 1000

// Umbrella defines
#define UMBRELLA_DUPLICATES 30
#define UMBRELLA_DELAY 1000

// Cake defines
#define CAKE_DUPLICATES 10
#define CAKE_DELAY 500
#define CAKE_SINGLE_DELAY 500
#define CAKE_BIG_DELAY 2500

new FW_Owner[MAX_FIREWORK] = {-1, ...};
new FW_Type[MAX_FIREWORK];
new FW_AttachedVehicle[MAX_FIREWORK] = {-1, ...};
new FW_Lifetime[MAX_FIREWORK];
new FW_Stage[MAX_FIREWORK];
new FW_Colors[MAX_FIREWORK][2];
new FW_Object[MAX_FIREWORK][MAX_FWOBJECT][2];

new Menu: MenuFireworkLighting;
new Menu: FWColor;
new Menu: FWSize;

public OnFilterScriptInit()
{
	// Create the fireworks menus
	MenuFireworkLighting = CreateMenu("Fajerwerki", 1, 150, 300,1000,35);
	AddMenuItem(MenuFireworkLighting, 0, "Mega Wulkan");
	AddMenuItem(MenuFireworkLighting, 0, "Rakieta");
	AddMenuItem(MenuFireworkLighting, 0, "Kaskada");
	AddMenuItem(MenuFireworkLighting, 0, "Okrag");
	AddMenuItem(MenuFireworkLighting, 0, "Rzymskie ognie");
	FWSize = CreateMenu("Efekty fajerwerkow", 1, 150, 300, 500, 0);
	SetMenuColumnHeader(FWSize, 0, "Wybierz rozmiar efektow");
	AddMenuItem(FWSize, 0, "Male");
	AddMenuItem(FWSize, 0, "Duze");
	FWColor = CreateMenu("Kolory fajerwerkow", 1, 150, 300, 500, 0);
	AddMenuItem(FWColor, 0, "Biale");
	AddMenuItem(FWColor, 0, "Czerwone");
	AddMenuItem(FWColor, 0, "Zielone");
	AddMenuItem(FWColor, 0, "Niebieskie");
	
	// Load the animation library for all online player
	for (new p = 0, mp = GetPlayerPoolSize(); p <= mp; p++)
	{
		ApplyAnimation(p, "BOMBER", "null", 0.0, 0, 0 , 0, 0, 0);
	}
	
	print("\n");
	print("Advanced Fireworks v1.0 loaded succesfully.\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	// Load the animation library for new connecting players
	ApplyAnimation(playerid, "BOMBER", "null", 0.0, 0, 0 , 0, 0, 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if (GetPVarInt(playerid, "FireworkPlaced"))
	{
		for (new fw; fw != MAX_FIREWORK; fw++)
		{
			if (FW_Owner[fw] == playerid && FW_Stage[fw] <= 1)
			{
				FW_MainDestroy(fw);
			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	#if RCON_ONLY == true
	if (!IsPlayerAdmin(playerid)) return 0;
	#endif
	
	if (!strcmp(cmdtext, "/swiatelkodlamosp"))
	{
		ShowMenuForPlayer(MenuFireworkLighting, playerid);
		TogglePlayerControllable(playerid, 0);
		return 1;
	}
	return 0;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu: Current = GetPlayerMenu(playerid);
	if (Current == MenuFireworkLighting)
	{
		switch (row)
		{
			case 0:
			{
				SetPVarInt(playerid, "FW_ColorsNumber", 2);
				SetPVarInt(playerid, "FW_MenuItem", FW_FOUNTAIN);
				ShowMenuForPlayer(FWSize, playerid);
			}
			case 1:
			{
				SetPVarInt(playerid, "FW_ColorsNumber", 2);
				SetPVarInt(playerid, "FW_MenuItem", FW_ROCKET);
				ShowMenuForPlayer(FWSize, playerid);
			}
			case 2:
			{
				SetPVarInt(playerid, "FW_ColorsNumber", 2);
				SetPVarInt(playerid, "FW_MenuItem", FW_SPLITTER);
				ShowMenuForPlayer(FWSize, playerid);
			}
			case 3:
			{
				SetPVarInt(playerid, "FW_ColorsNumber", 2);
				SetPVarInt(playerid, "FW_MenuItem", FW_UMBRELLA);
				ShowMenuForPlayer(FWSize, playerid);
			}
			case 4:
			{
				SetPVarInt(playerid, "FW_ColorsNumber", 2);
				SetPVarInt(playerid, "FW_MenuItem", FW_CAKE);
				ShowMenuForPlayer(FWSize, playerid);
			}
			default: ShowMenuForPlayer(Current, playerid);
		}
		return 1;
	}
	if (Current == FWSize)
	{
		switch (row)
		{
			case 0: {SetPVarInt(playerid, "FW_Big", 0);}
			case 1: {SetPVarInt(playerid, "FW_Big", 1);}
		}
		SetMenuColumnHeader(FWColor, 0, "Wybierz pierwszy kolor...");
		ShowMenuForPlayer(FWColor, playerid);
		return 1;
	}
	if (Current == FWColor)
	{
		if (!GetPVarInt(playerid, "FW_Color1") && !GetPVarInt(playerid, "FW_Color2"))
		{
			switch (row)
			{
				case 0: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color1", 19295);} else {SetPVarInt(playerid, "FW_Color1", 19281);}} // Wit
				case 1: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color1", 19296);} else {SetPVarInt(playerid, "FW_Color1", 19282);}} // Rood
				case 2: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color1", 19297);} else {SetPVarInt(playerid, "FW_Color1", 19283);}} // Groen
				case 3: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color1", 19298);} else {SetPVarInt(playerid, "FW_Color1", 19284);}} // Blauw
			}
			if (GetPVarInt(playerid, "FW_ColorsNumber") == 1)
			{
				DeletePVar(playerid, "FW_Big");
				TogglePlayerControllable(playerid, 1);
				FW_MainCreate(playerid, GetPVarInt(playerid, "FW_MenuItem"));
				return 1;
			}
			SetMenuColumnHeader(FWColor, 0, "Wybierz drugi kolor...");
			ShowMenuForPlayer(FWColor, playerid);
			return 1;
		}
		if (GetPVarInt(playerid, "FW_Color1") > 1 && !GetPVarInt(playerid, "FW_Color2"))
		{
			switch (row)
			{
				case 0: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color2", 19295);} else {SetPVarInt(playerid, "FW_Color2", 19281);}} 
				case 1: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color2", 19296);} else {SetPVarInt(playerid, "FW_Color2", 19282);}} 
				case 2: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color2", 19297);} else {SetPVarInt(playerid, "FW_Color2", 19283);}} 
				case 3: {if (GetPVarInt(playerid, "FW_Big") == 1) {SetPVarInt(playerid, "FW_Color2", 19298);} else {SetPVarInt(playerid, "FW_Color2", 19284);}} 
			}
			TogglePlayerControllable(playerid, 1);
			FW_MainCreate(playerid, GetPVarInt(playerid, "FW_MenuItem"));
			DeletePVar(playerid, "FW_MenuItem");
			DeletePVar(playerid, "FW_ColorsNumber");
			DeletePVar(playerid, "FW_Big");
			return 1;
		}
		return 1;
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	if (Current == MenuFireworkLighting)
	{ 
		TogglePlayerControllable(playerid, 1);
		return 1;
	}
	if (Current == FWColor)
	{
		TogglePlayerControllable(playerid, 1);
		DeletePVar(playerid, "FW_Color1");
		DeletePVar(playerid, "FW_Color2");
		DeletePVar(playerid, "FW_MenuItem");
		DeletePVar(playerid, "FW_ColorsNumber");
		DeletePVar(playerid, "FW_Big");
		return 1;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_FIRE && !(oldkeys & KEY_FIRE))
	{
		if(GetPlayerWeapon(playerid) == 40 || GetPVarInt(playerid, "Detonator") == 1)
		{
			if (GetPVarInt(playerid, "FireworkPlaced") == 1)
			{
				RemoveWeaponFromSlot(playerid, 12);
				DeletePVar(playerid, "FireworkPlaced");
				SetPVarInt(playerid, "TimerMainFire", SetTimerEx("FW_MainFire", DEF_DELAY_FIRE, true, "i", playerid));
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if (GetPlayerWeapon(playerid) == 40)
	{
		if (GetPVarInt(playerid, "Detonator") != 1)
		{
			SetPVarInt(playerid, "Detonator", 1);
		}
	}
	else if (GetPVarInt(playerid, "Detonator") == 1)
	{
		DeletePVar(playerid, "Detonator");
	}
	return 1;
}

// GetAngleToPos made by MegaDreams
stock Float: GetAngleToPos(Float: PX, Float: PY, Float: X, Float: Y)
{
	new Float:Angle = floatabs(atan((Y-PY)/(X-PX)));
	Angle = (X<=PX && Y>=PY) ? floatsub(180,Angle) : (X<PX && Y<PY) ? floatadd(Angle,180) : (X>=PX && Y<=PY) ? floatsub(360.0,Angle) : Angle;
	Angle = floatsub(Angle, 90.0);
	Angle = (Angle>=360.0) ? floatsub(Angle, 360.0) : Angle;
	return Angle;
}

public OnDynamicObjectMoved(objectid)
{
	for (new fw; fw != MAX_FIREWORK; fw++)
	{
		if (FW_Type[fw] != FW_UNKNOWN)
		{
			for (new fo; fo != MAX_FWOBJECT; fo++)
			{
				if (FW_Object[fw][fo][0] == objectid)
				{
					switch(FW_Type[fw])
					{
						case FW_FOUNTAIN:
						{
							switch (FW_Object[fw][fo][1]) 
							{
								case 1:
								{
									new Float: fwX, Float: fwY, Float: fwZ;
									GetDynamicObjectPos(FW_Object[fw][fo][0], fwX, fwY, fwZ);
									MoveDynamicObject(FW_Object[fw][fo][0], fwX, fwY, fwZ-10.0, 2.0+float(random(3)));
									FW_Object[fw][fo][1] = 2;
								}
								case 2: {DestroyDynamicObject(FW_Object[fw][fo][0]); FW_Object[fw][fo][0] = 0; FW_Object[fw][fo][1] = 0;}
							}
							return 1;
						}
						case FW_ROCKET:
						{
							switch (FW_Object[fw][fo][1])
							{
								case 1:
								{
									new Float: fwX, Float: fwY, Float: fwZ, stage;
									for (new prt; prt != ROCKET_DUPLICATES; prt++)
									{
										for (new fo2; fo2 != MAX_FWOBJECT; fo2++)
										{
											if (FW_Object[fw][fo2][0] == 0)
											{
												new model;
												switch (stage)
												{
													case 0: {model = FW_Colors[fw][0]; stage = 1;}
													case 1: {model = FW_Colors[fw][1]; stage = 0;}
												}
												GetDynamicObjectPos(objectid, fwX, fwY, fwZ);
												FW_Object[fw][fo2][0] = CreateDynamicObject(model, fwX, fwY, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
												Get3DRandomDistanceAway(fwX, fwY, fwZ, 15, 30);
												MoveDynamicObject(FW_Object[fw][fo2][0], fwX, fwY, fwZ, 10.0+(float(random(20))/10.0));
												FW_Object[fw][fo2][1] = 2;
												break;
											}
										}
									}
									
									for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
									{
										if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
										{
											PlayerPlaySound(i, 1009, 0, 0, 0);
										}
									}
									
									DestroyDynamicObject(FW_Object[fw][fo][0]);
									FW_Object[fw][fo][0] = 0;
									FW_Object[fw][fo][1] = 0;
									UpdateStreamerForAll();
									return 1;
								}
								case 2: 
								{
									DestroyDynamicObject(FW_Object[fw][fo][0]); 
									FW_Object[fw][fo][0] = 0; 
									FW_Object[fw][fo][1] = 0;
								}
							}
							return 1;
						}
						case FW_SPLITTER:
						{
							switch (FW_Object[fw][fo][1])
							{
								case 1:
								{
									new Float: fwX, Float: fwY, Float: fwZ;
									for (new prt; prt != SPLITTER_DUPLICATE_1; prt++)
									{
										for (new fo2; fo2 != MAX_FWOBJECT; fo2++)
										{
											if (FW_Object[fw][fo2][0] == 0)
											{
												GetDynamicObjectPos(objectid, fwX, fwY, fwZ);
												FW_Object[fw][fo2][0] = CreateDynamicObject(FW_Colors[fw][0], fwX, fwY, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
												Get3DRandomDistanceAway(fwX, fwY, fwZ, 20, 40);
												MoveDynamicObject(FW_Object[fw][fo2][0], fwX, fwY, fwZ, 10.0+(float(random(20))/10.0));
												FW_Object[fw][fo2][1] = 2;
												break;
											}
										}
									}
									
									for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
									{
										if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
										{
											PlayerPlaySound(i, 1009, 0, 0, 0);
										}
									}
									
									DestroyDynamicObject(FW_Object[fw][fo][0]);
									FW_Object[fw][fo][0] = 0;
									FW_Object[fw][fo][1] = 0;
									UpdateStreamerForAll();
									return 1;
								}
								case 2:
								{
									new Float: fwX, Float: fwY, Float: fwZ;
									for (new prt; prt != SPLITTER_DUPLICATE_2; prt++)
									{
										for (new fo2; fo2 != MAX_FWOBJECT; fo2++)
										{
											if (FW_Object[fw][fo2][0] == 0)
											{
												GetDynamicObjectPos(objectid, fwX, fwY, fwZ);
												FW_Object[fw][fo2][0] = CreateDynamicObject(FW_Colors[fw][1], fwX, fwY, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
												Get3DRandomDistanceAway(fwX, fwY, fwZ, 15, 30);
												MoveDynamicObject(FW_Object[fw][fo2][0], (fwX+(float(random(200))/10.0))-10.0, (fwY+(float(random(200))/10.0))-10.0, (fwZ+(float(random(200))/10.0))-10.0, 7.0+(float(random(20))/10.0));
												FW_Object[fw][fo2][1] = 3;
												break;
											}
										}
									}
									
									for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
									{
										if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
										{
											PlayerPlaySound(i, 1009, 0, 0, 0);
										}
									}
									
									DestroyDynamicObject(FW_Object[fw][fo][0]);
									FW_Object[fw][fo][0] = 0;
									FW_Object[fw][fo][1] = 0;
									UpdateStreamerForAll();
									return 1;
								}
								case 3: {DestroyDynamicObject(FW_Object[fw][fo][0]); FW_Object[fw][fo][0] = 0; FW_Object[fw][fo][1] = 0;}
							}
							return 1;
						}
						case FW_UMBRELLA:
						{
							switch (FW_Object[fw][fo][1])
							{
								case 1:
								{
									new Float: fwX, Float: fwY, Float: fwZ, stage;
									for (new prt; prt != UMBRELLA_DUPLICATES; prt++)
									{
										for (new fo2; fo2 != MAX_FWOBJECT; fo2++)
										{
											if (FW_Object[fw][fo2][0] == 0)
											{
												new model;
												switch (stage)
												{
													case 0: {model = FW_Colors[fw][0]; stage = 1;}
													case 1: {model = FW_Colors[fw][1]; stage = 0;}
												}

												GetDynamicObjectPos(objectid, fwX, fwY, fwZ);
												FW_Object[fw][fo2][0] = CreateDynamicObject(model, fwX, fwY, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
												Get2DRandomDistanceAway(fwX, fwY, 25, 40);
												MoveDynamicObject(FW_Object[fw][fo2][0], fwX, fwY, fwZ, 8.0+(float(random(20))/10.0));
												FW_Object[fw][fo2][1] = 2;
												break;
											}
										}
									}
									
									for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
									{
										if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
										{
											PlayerPlaySound(i, 1009, 0, 0, 0);
										}
									}
									
									DestroyDynamicObject(FW_Object[fw][fo][0]);
									FW_Object[fw][fo][0] = 0;
									FW_Object[fw][fo][1] = 0;
									UpdateStreamerForAll();
									return 1;
								}
								case 2: {DestroyDynamicObject(FW_Object[fw][fo][0]); FW_Object[fw][fo][0] = 0; FW_Object[fw][fo][1] = 0;}
							}
							return 1;
						}
						case FW_CAKE: 
						{
							switch (FW_Object[fw][fo][1]) 
							{
								case 1:
								{
									new Float: fwX, Float: fwY, Float: fwZ;
									for (new prt; prt != CAKE_DUPLICATES; prt++)
									{
										for (new fo2; fo2 != MAX_FWOBJECT; fo2++)
										{
											if (FW_Object[fw][fo2][0] == 0)
											{
												GetDynamicObjectPos(objectid, fwX, fwY, fwZ);
												FW_Object[fw][fo2][0] = CreateDynamicObject(FW_Colors[fw][1], fwX, fwY, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
												Get3DRandomDistanceAway(fwX, fwY, fwZ, 25, 40);
												MoveDynamicObject(FW_Object[fw][fo2][0], fwX, fwY, fwZ, 15.0+(float(random(20))/10.0));
												FW_Object[fw][fo2][1] = 2;
												break;
											}
										}
									}
									
									for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
									{
										if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
										{
											PlayerPlaySound(i, 1009, 0, 0, 0);
										}
									}
									
									DestroyDynamicObject(FW_Object[fw][fo][0]);
									FW_Object[fw][fo][0] = 0;
									FW_Object[fw][fo][1] = 0;
									UpdateStreamerForAll();
									return 1;
								}
								case 2: {DestroyDynamicObject(FW_Object[fw][fo][0]); FW_Object[fw][fo][0] = 0; FW_Object[fw][fo][1] = 0;}
							}
							return 1;
						}
					}
					return 0;
				}
			}
		}
	}
	return 1;
}

stock FW_MainCreate(playerid, firework)
{
	if (IsPlayerNPC(playerid) || !IsPlayerConnected(playerid)) return 0;
	
	if (GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
	{
		SendClientMessage(playerid, MSG_WARNING, "Przepisy po¿arowe zabraniaj¹ odpalania fajerwerków w pomieszczeniach.");
		return 0;
	}
	
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		switch(firework)
		{
			case FW_UNKNOWN:
			{
				SendClientMessage(playerid, MSG_WARNING, "Nie mo¿na odpaliæ petardy!");
				return 0;
			}
			case FW_FOUNTAIN, FW_ROCKET, FW_SPLITTER, FW_UMBRELLA, FW_CAKE:
			{
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 1.0, 0, 0, 0, 1, 0, 1);
				SetTimerEx("FW_MainCreateEnd", DEF_ANIM_TIME, false, "ii", playerid, firework);
				return 1;
			}
		}
	}
	else SendClientMessage(playerid, MSG_WARNING, "Przepisy po¿arowe zabraniaj¹ odpalania fajerwerków w pojeŸdzie.");
	return 0;
}

forward FW_MainCreateEnd(playerid, firework);
public FW_MainCreateEnd(playerid, firework)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	for(new fw; fw != MAX_FIREWORK; fw++)
	{
		if (FW_Owner[fw] == -1)
		{
			new pName[MAX_PLAYER_NAME];
			SetPVarInt(playerid, "FireworkPlaced", 1);
			GetPlayerName(playerid, pName, sizeof(pName));
			TogglePlayerControllable(playerid, 1);
			ClearAnimations(playerid);
			new Float: plX, Float: plY, Float: fwX, Float: fwY, Float: Z;
			GetPlayerPos(playerid, plX, plY, Z);
			GetXYInFrontOfPlayer(playerid, fwX, fwY, 1.0);
			GivePlayerWeapon(playerid, 40, 1);
			new Float: R = GetAngleToPos(plX, plY, fwX, fwY);
			switch(firework)
			{
				case FW_UNKNOWN:
				{
					SendClientMessage(playerid, MSG_WARNING, "Nie mo¿na odpaliæ petardy!");
					return 0;
				}
				case FW_FOUNTAIN:
				{
					FW_FountainCreate(playerid, fw, fwX, fwY, Z, R, GetPVarInt(playerid, "FW_Color1"), GetPVarInt(playerid, "FW_Color2"));
					DeletePVar(playerid, "FW_Color1");
					DeletePVar(playerid, "FW_Color2");
					return 1;
				}
				case FW_ROCKET: 
				{
					FW_RocketCreate(playerid, fw, fwX, fwY, Z, R, GetPVarInt(playerid, "FW_Color1"), GetPVarInt(playerid, "FW_Color2"));
					DeletePVar(playerid, "FW_Color1");
					DeletePVar(playerid, "FW_Color2");
					return 1;
				}
				case FW_SPLITTER:
				{
					FW_SplitterCreate(playerid, fw, fwX, fwY, Z, R, GetPVarInt(playerid, "FW_Color1"), GetPVarInt(playerid, "FW_Color2"));
					DeletePVar(playerid, "FW_Color1");
					DeletePVar(playerid, "FW_Color2");
					return 1;
				}
				case FW_UMBRELLA:
				{
					FW_UmbrelllaCreate(playerid, fw, fwX, fwY, Z, R, GetPVarInt(playerid, "FW_Color1"), GetPVarInt(playerid, "FW_Color2"));
					DeletePVar(playerid, "FW_Color1");
					DeletePVar(playerid, "FW_Color2");
					return 1;
				}
				case FW_CAKE: 
				{
					FW_CakeCreate(playerid, fw, fwX, fwY, Z, R, GetPVarInt(playerid, "FW_Color1"), GetPVarInt(playerid, "FW_Color2"));
					DeletePVar(playerid, "FW_Color1");
					DeletePVar(playerid, "FW_Color2");
					return 1;
				}
				default:
				{
					SendClientMessage(playerid, MSG_WARNING, "Nie mo¿na odpaliæ petardy!");
					return 0;
				}
			}
		}
	}
	SendClientMessage(playerid, MSG_WARNING, "Zbyt du¿o petard na serwerze, nie mo¿na odpaliæ kolejnej!");
	return 0;
}

forward FW_MainFire(playerid);
public FW_MainFire(playerid)
{
	for (new fw; fw != MAX_FIREWORK; fw++)
	{
		if (FW_Owner[fw] == playerid && FW_Stage[fw] == 1)
		{
			switch (FW_Type[fw])
			{
				case FW_UNKNOWN:
				{
					FW_Owner[fw] = -1;
					//SendClientMessage(playerid, MSG_WARNING, "Fireworks couldn't be lighted!");
					return 0;
				}
				case FW_FOUNTAIN: 
				{
					FW_Lifetime[fw] = FOUNTAIN_LIFE;
					FW_Stage[fw] = 2;
					new Float: fwX, Float: fwY, Float: fwZ;
					GetDynamicObjectPos(FW_Object[fw][0][0], fwX, fwY, fwZ);
					
					for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
					{
						if(IsPlayerInRangeOfPoint(i,50, fwX, fwY, fwZ))
						{
							PlayerPlaySound(i, 1134, 0, 0, 0);
						}
					}
					
					SetTimerEx("FW_FountainFire", FOUNTAIN_DELAY, false, "ii", fw, 0);
					return 1;
				}
				case FW_ROCKET: 
				{
					FW_Stage[fw] = 2;
					new Float: XYZ[3];
					GetDynamicObjectPos(FW_Object[fw][0][0], XYZ[0], XYZ[1], XYZ[2]);
					FW_Object[fw][3][0] = CreateDynamicObject(18727, XYZ[0], XYZ[1], XYZ[2], 0.0, 0.0, 0.0, 150);
					SetTimerEx("FW_RocketFire", ROCKET_DELAY, false, "i", fw);
					return 1;
				}
				case FW_SPLITTER:
				{
					FW_Stage[fw] = 2;
					new Float: XYZ[3];
					GetDynamicObjectPos(FW_Object[fw][0][0], XYZ[0], XYZ[1], XYZ[2]);
					FW_Object[fw][3][0] = CreateDynamicObject(18727, XYZ[0], XYZ[1], XYZ[2], 0.0, 0.0, 0.0, 150);
					SetTimerEx("FW_SplitterFire", SPLITTER_DELAY, false, "i", fw);
					return 1;
				}
				case FW_UMBRELLA:
				{
					FW_Stage[fw] = 2;
					new Float: XYZ[3];
					GetDynamicObjectPos(FW_Object[fw][0][0], XYZ[0], XYZ[1], XYZ[2]);
					FW_Object[fw][3][0] = CreateDynamicObject(18727, XYZ[0], XYZ[1], XYZ[2], 0.0, 0.0, 0.0, 150);
					SetTimerEx("FW_UmbrelllaFire", UMBRELLA_DELAY, false, "i", fw);
					return 1;
				}
				case FW_CAKE:
				{
					FW_Stage[fw] = 2;
					SetTimerEx("FW_CakeFire", CAKE_DELAY, false, "ii", fw, 1);
					return 1;
				}
			}
			return 1;
		}
	}
	KillTimer(GetPVarInt(playerid, "TimerMainFire"));
	DeletePVar(playerid, "TimerMainFire");
	return 0;
}

forward FW_MainDestroy(fw);
public FW_MainDestroy(fw)
{
	FW_Owner[fw] = -1;
	FW_Type[fw] = FW_UNKNOWN;
	FW_AttachedVehicle[fw] = -1;
	FW_Lifetime[fw] = 0;
	FW_Stage[fw] = 0;
	FW_Colors[fw][0] = 0;
	FW_Colors[fw][1] = 0;
	for (new fo; fo != MAX_FWOBJECT; fo++)
	{
		if (FW_Object[fw][fo][0] != 0)
		{
			if (IsValidDynamicObject(FW_Object[fw][fo][0])) {DestroyDynamicObject(FW_Object[fw][fo][0]);}
			FW_Object[fw][fo][0] = 0;
			FW_Object[fw][fo][1] = 0;
		}
	}
	return 1;
}

// FOUNTAIN
stock FW_FountainCreate(playerid, fw, Float: X, Float: Y, Float: Z, Float: R, model1, model2)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	FW_Owner[fw] = playerid;
	FW_Stage[fw] = 1;
	FW_Type[fw] = FW_FOUNTAIN;
	FW_Colors[fw][0] = model1;
	FW_Colors[fw][1] = model2;
	if (FW_Colors[fw][0] == 0) {FW_Colors[fw][0] = 19284;}
	if (FW_Colors[fw][1] == 0) {FW_Colors[fw][1] = 19281;}
	FW_Object[fw][0][0] = CreateDynamicObject(1271, X, Y, Z-0.65, 0.0, 0.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][1][0] = CreateDynamicObject(2203, X, Y, Z-0.4, 0.0, 0.0, R, -1, 0, -1, 100.0);

	new surf = GetPlayerSurfingVehicleID(playerid);
	if (surf != INVALID_VEHICLE_ID)
	{
		FW_AttachedVehicle[fw] = surf;
		new Float: vehPos[3];
		GetVehiclePos(surf, vehPos[0], vehPos[1], vehPos[2]);
		X -= vehPos[0];
		Y -= vehPos[1];
		Z -= vehPos[2];
		AttachDynamicObjectToVehicle(FW_Object[fw][0][0], surf, X, Y, Z-0.65, 0.0, 0.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][1][0], surf, X, Y, Z-0.4, 0.0, 0.0, R);
	}
	UpdateStreamerForAll();
	return 1;
}

forward FW_FountainFire(fw, stage);
public FW_FountainFire(fw, stage)
{
	for (new fo; fo != MAX_FWOBJECT; fo++)
	{
		if (FW_Object[fw][fo][0] == 0)
		{
			new Float: fwX, Float: fwY, Float: fwZ, model;
			if (FW_AttachedVehicle[fw] == -1) {GetDynamicObjectPos(FW_Object[fw][0][0], fwX, fwY, fwZ);}
			#if USE_STREAMER == true
			else
			{
				GetVehiclePos(FW_AttachedVehicle[fw], fwX, fwY, fwZ);
				new Float: AttachOffset[3];
				Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_X, AttachOffset[0]);
				Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Y, AttachOffset[1]);
				Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Z, AttachOffset[2]);
				fwX += AttachOffset[0];
				fwY += AttachOffset[1];
				fwZ += AttachOffset[2];
			}
			#endif
			switch(stage)
			{
				case 0: {model = FW_Colors[fw][0]; stage = 1;} 
				case 1: {model = FW_Colors[fw][1]; stage = 0;} 
			}
			FW_Object[fw][fo][0] = CreateDynamicObject(model, (fwX+(float(random(5))/10.0))-0.25, (fwY+(float(random(5))/10.0))-0.25, fwZ, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
			MoveDynamicObject(FW_Object[fw][fo][0], (fwX+(float(random(80))/10.0))-4.0, (fwY+(float(random(80))/10.0))-4.0, fwZ+(20.0+float(random(15))), 15.0+(float(random(20))/10.0));
			FW_Object[fw][fo][1] = 1;
			UpdateStreamerForAll(); 
			break;
		}
		if (fo == (MAX_FWOBJECT-1)) 
		{
			//SendClientMessageToAll(MSG_WARNING, "ERROR: FIREWORK ENTITIES LIMIT REACHED"); 
			return 0;
		}
	}
	FW_Lifetime[fw] -= FOUNTAIN_DELAY;
	if (FW_Lifetime[fw] > 0) {SetTimerEx("FW_FountainFire", FOUNTAIN_DELAY, false, "ii", fw, stage); return 1;}
	FW_Stage[fw] = 3;
	SetTimerEx("FW_MainDestroy", DEF_STAY_TIME, false, "i", fw);
	return 0;
}

// ROCKET
stock FW_RocketCreate(playerid, fw, Float: X, Float: Y, Float: Z, Float: R, model1, model2)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	FW_Owner[fw] = playerid;
	FW_Stage[fw] = 1;
	FW_Type[fw] = FW_ROCKET;
	FW_Colors[fw][0] = model1;
	FW_Colors[fw][1] = model2;
	if (FW_Colors[fw][0] == 0) {FW_Colors[fw][0] = 19282;}
	if (FW_Colors[fw][1] == 0) {FW_Colors[fw][1] = 19281;}
	FW_Object[fw][0][0] = CreateDynamicObject(1271, X, Y, Z-0.65, 0.0, 0.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][1][0] = CreateDynamicObject(3790, X, Y, Z+0.95, 0.0, 90.0, R, -1, 0, -1, 100.0);

	new surf = GetPlayerSurfingVehicleID(playerid);
	if (surf != INVALID_VEHICLE_ID)
	{
		FW_AttachedVehicle[fw] = surf;
		new Float: vehPos[3];
		GetVehiclePos(surf, vehPos[0], vehPos[1], vehPos[2]);
		X -= vehPos[0];
		Y -= vehPos[1];
		Z -= vehPos[2];
		AttachDynamicObjectToVehicle(FW_Object[fw][0][0], surf, X, Y, Z-0.65, 0.0, 0.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][1][0], surf, X, Y, Z+0.95, 0.0, 90.0, R);
	}

	UpdateStreamerForAll();
	return 1;
}

forward FW_RocketFire(fw);
public FW_RocketFire(fw)
{
	DestroyDynamicObject(FW_Object[fw][3][0]);
	new Float: fwX, Float: fwY, Float: fwZ, Float: R;
	if (FW_AttachedVehicle[fw] == -1) {GetDynamicObjectPos(FW_Object[fw][1][0], fwX, fwY, fwZ);}
	#if USE_STREAMER == true
	else
	{
		GetVehiclePos(FW_AttachedVehicle[fw], fwX, fwY, fwZ);
		new Float: AttachOffset[3];
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_X, AttachOffset[0]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Y, AttachOffset[1]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Z, AttachOffset[2]);
		fwX += AttachOffset[0];
		fwY += AttachOffset[1];
		fwZ += AttachOffset[2];
	}
	#endif

	for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
	{
		if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
		{
			PlayerPlaySound(i, 1095, 0, 0, 0);
		}
	}
	DestroyDynamicObject(FW_Object[fw][1][0]);
	#if USE_STREAMER == true
	Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_R_Z, R);
	#else
	GetObjectRot(FW_Object[fw][0][0], R, R, R);	
	#endif
	FW_Object[fw][1][0] = CreateDynamicObject(3790, fwX, fwY, fwZ+0.95, 0.0, 90.0, R, -1, 0, -1, 300.0);
	FW_Object[fw][2][0] = CreateDynamicObject(345, fwX, fwY, fwZ-1.2, 90.0, 0.0, 0.0, -1, 0, -1, 300.0);
	fwX += (float(random(30))/10);
	fwY += (float(random(30))/10);
	fwZ = fwZ + 40 + float(random(5));
	MoveDynamicObject(FW_Object[fw][1][0], fwX, fwY, fwZ, 18.0);
	MoveDynamicObject(FW_Object[fw][2][0], fwX, fwY, fwZ-1.2, 18.0);
	FW_Object[fw][1][1] = 1;
	FW_Object[fw][2][1] = 2;
	UpdateStreamerForAll();
	SetTimerEx("FW_MainDestroy", DEF_STAY_TIME, false, "i", fw);
	return 0;
}

// SPLITTER
stock FW_SplitterCreate(playerid, fw, Float: X, Float: Y, Float: Z, Float: R, model1, model2)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	FW_Owner[fw] = playerid;
	FW_Stage[fw] = 1;
	FW_Type[fw] = FW_SPLITTER;
	FW_Colors[fw][0] = model1;
	FW_Colors[fw][1] = model2;
	if (FW_Colors[fw][0] == 0) {FW_Colors[fw][0] = 19282;}
	FW_Object[fw][0][0] = CreateDynamicObject(1271, X, Y, Z-0.65, 0.0, 0.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][1][0] = CreateDynamicObject(3786, X, Y, Z+0.95, 0.0, 90.0, R, -1, 0, -1, 100.0);

	new surf = GetPlayerSurfingVehicleID(playerid);
	if (surf != INVALID_VEHICLE_ID)
	{
		FW_AttachedVehicle[fw] = surf;
		new Float: vehPos[3];
		GetVehiclePos(surf, vehPos[0], vehPos[1], vehPos[2]);
		X -= vehPos[0];
		Y -= vehPos[1];
		Z -= vehPos[2];
		AttachDynamicObjectToVehicle(FW_Object[fw][0][0], surf, X, Y, Z-0.65, 0.0, 0.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][1][0], surf, X, Y, Z+0.95, 0.0, 90.0, R);
	}

	UpdateStreamerForAll();
	return 1;
}

forward FW_SplitterFire(fw);
public FW_SplitterFire(fw)
{
	DestroyDynamicObject(FW_Object[fw][3][0]);
	new Float: fwX, Float: fwY, Float: fwZ, Float: R;
	if (FW_AttachedVehicle[fw] == -1) {GetDynamicObjectPos(FW_Object[fw][1][0], fwX, fwY, fwZ);}
	
	#if USE_STREAMER == true
	else
	{
		GetVehiclePos(FW_AttachedVehicle[fw], fwX, fwY, fwZ);
		new Float: AttachOffset[3];
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_X, AttachOffset[0]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Y, AttachOffset[1]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Z, AttachOffset[2]);
		fwX += AttachOffset[0];
		fwY += AttachOffset[1];
		fwZ += AttachOffset[2];
	}
	#endif
	
	for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
	{
		if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
		{
			PlayerPlaySound(i, 1095, 0, 0, 0);
		}
	}
	
	DestroyDynamicObject(FW_Object[fw][1][0]);
	
	#if USE_STREAMER == true
	Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_R_Z, R);
	#else
	GetObjectRot(FW_Object[fw][0][0], R, R, R);
	#endif
	
	FW_Object[fw][1][0] = CreateDynamicObject(3786, fwX, fwY, fwZ+0.95, 0.0, 90.0, R, -1, 0, -1, 300.0);
	FW_Object[fw][2][0] = CreateDynamicObject(345, fwX, fwY, fwZ-1.2, 90.0, 0.0, 0.0, -1, 0, -1, 300.0);
	fwX += (float(random(30))/10);
	fwY += (float(random(30))/10);
	fwZ = fwZ + 40.0 + float(random(5));
	MoveDynamicObject(FW_Object[fw][1][0], fwX, fwY, fwZ, 18.0);
	MoveDynamicObject(FW_Object[fw][2][0], fwX, fwY, fwZ-1.2, 18.0);
	FW_Object[fw][1][1] = 1;
	FW_Object[fw][2][1] = 3;
	UpdateStreamerForAll();
	SetTimerEx("FW_MainDestroy", DEF_STAY_TIME, false, "i", fw);
	return 0;
}

// Umbrella
stock FW_UmbrelllaCreate(playerid, fw, Float: X, Float: Y, Float: Z, Float: R, model1, model2)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	FW_Owner[fw] = playerid;
	FW_Stage[fw] = 1;
	FW_Type[fw] = FW_UMBRELLA;
	FW_Colors[fw][0] = model1;
	FW_Colors[fw][1] = model2;
	if (FW_Colors[fw][0] == 0) {FW_Colors[fw][0] = 19282;}
	if (FW_Colors[fw][1] == 0) {FW_Colors[fw][1] = 19281;}
	FW_Object[fw][0][0] = CreateDynamicObject(1271, X, Y, Z-0.65, 0.0, 0.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][1][0] = CreateDynamicObject(3790, X, Y, Z+0.95, 0.0, 90.0, R, -1, 0, -1, 100.0);

	new surf = GetPlayerSurfingVehicleID(playerid);
	if (surf != INVALID_VEHICLE_ID)
	{
		FW_AttachedVehicle[fw] = surf;
		new Float: vehPos[3];
		GetVehiclePos(surf, vehPos[0], vehPos[1], vehPos[2]);
		X -= vehPos[0];
		Y -= vehPos[1];
		Z -= vehPos[2];
		AttachDynamicObjectToVehicle(FW_Object[fw][0][0], surf, X, Y, Z-0.65, 0.0, 0.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][1][0], surf, X, Y, Z+0.95, 0.0, 90.0, R);
	}
	UpdateStreamerForAll();
	return 1;
}

forward FW_UmbrelllaFire(fw);
public FW_UmbrelllaFire(fw)
{
	DestroyDynamicObject(FW_Object[fw][3][0]);
	new Float: fwX, Float: fwY, Float: fwZ, Float: R;
	if (FW_AttachedVehicle[fw] == -1) {GetDynamicObjectPos(FW_Object[fw][1][0], fwX, fwY, fwZ);}
	
	#if USE_STREAMER == true
	else
	{
		GetVehiclePos(FW_AttachedVehicle[fw], fwX, fwY, fwZ);
		new Float: AttachOffset[3];
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_X, AttachOffset[0]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Y, AttachOffset[1]);
		Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Z, AttachOffset[2]);
		fwX += AttachOffset[0];
		fwY += AttachOffset[1];
		fwZ += AttachOffset[2];
	}
	#endif

	for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
	{
		if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
		{
			PlayerPlaySound(i, 1095, 0, 0, 0);
		}
	}
	
	DestroyDynamicObject(FW_Object[fw][1][0]);
	
	#if USE_STREAMER == true
	Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_R_Z, R);
	#else
	GetObjectRot(FW_Object[fw][0][0], R, R, R);
	#endif
	
	FW_Object[fw][1][0] = CreateDynamicObject(3790, fwX, fwY, fwZ+0.95, 0.0, 90.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][2][0] = CreateDynamicObject(345, fwX, fwY, fwZ-1.2, 90.0, 0.0, 0.0, -1, 0, -1, 300.0);
	fwX += (float(random(30))/10);
	fwY += (float(random(30))/10);
	fwZ = fwZ + 40.0 + float(random(5));
	MoveDynamicObject(FW_Object[fw][1][0], fwX, fwY, fwZ, 18.0);
	MoveDynamicObject(FW_Object[fw][2][0], fwX, fwY, fwZ-1.2, 18.0);
	FW_Object[fw][1][1] = 1;
	FW_Object[fw][2][1] = 2;
	UpdateStreamerForAll();
	SetTimerEx("FW_MainDestroy", DEF_STAY_TIME, false, "i", fw);
	return 0;
}

// CAKE (is a lie! ^_^)
stock FW_CakeCreate(playerid, fw, Float: X, Float: Y, Float: Z, Float: R, model1, model2)
{
	if (!IsPlayerConnected(playerid)) {return 0;}
	FW_Owner[fw] = playerid;
	FW_Stage[fw] = 1;
	FW_Type[fw] = FW_CAKE;
	FW_Colors[fw][0] = model1;
	FW_Colors[fw][1] = model2;
	if (FW_Colors[fw][0] == 0) {FW_Colors[fw][0] = 19282;}
	if (FW_Colors[fw][1] == 0) {FW_Colors[fw][1] = 19281;}
	FW_Object[fw][0][0] = CreateDynamicObject(1271, X, Y, Z-0.65, 0.0, 0.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][1][0] = CreateDynamicObject(2902, X, Y, Z-0.55, 0.0, -45.0-90.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][2][0] = CreateDynamicObject(2902, X, Y, Z-0.5, 0.0, -22.5-90.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][3][0] = CreateDynamicObject(2902, X, Y, Z-0.45, 0.0, 0.0-90.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][4][0] = CreateDynamicObject(2902, X, Y, Z-0.5, 0.0, 22.5-90.0, R, -1, 0, -1, 100.0);
	FW_Object[fw][5][0] = CreateDynamicObject(2902, X, Y, Z-0.55, 0.0, 45.0-90.0, R, -1, 0, -1, 100.0);

	new surf = GetPlayerSurfingVehicleID(playerid);
	if (surf != INVALID_VEHICLE_ID)
	{
		FW_AttachedVehicle[fw] = surf;
		new Float: vehPos[3];
		GetVehiclePos(surf, vehPos[0], vehPos[1], vehPos[2]);
		X -= vehPos[0];
		Y -= vehPos[1];
		Z -= vehPos[2];
		AttachDynamicObjectToVehicle(FW_Object[fw][0][0], surf, X, Y, Z-0.65, 0.0, 0.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][1][0], surf, X, Y, Z-0.55, 0.0, -45.0-90.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][2][0], surf, X, Y, Z-0.5, 0.0, -22.5-90.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][3][0], surf, X, Y, Z-0.45, 0.0, 0.0-90.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][4][0], surf, X, Y, Z-0.5, 0.0, 22.5-90.0, R);
		AttachDynamicObjectToVehicle(FW_Object[fw][5][0], surf, X, Y, Z-0.55, 0.0, 45.0-90.0, R);
	}
	UpdateStreamerForAll();
	return 1;
}

forward FW_CakeFire(fw, stage);
public FW_CakeFire(fw, stage)
{
	new fwTime;
	if (stage != 11)
	{
		for (new fo; fo != MAX_FWOBJECT; fo++)
		{
			if (FW_Object[fw][fo][0] == 0)
			{
				new Float: fwX, Float: fwY, Float: fwZ, Float: fwU, Float: fwR;
				if (FW_AttachedVehicle[fw] == -1) {GetDynamicObjectPos(FW_Object[fw][1][0], fwX, fwY, fwZ);}
				
				#if USE_STREAMER == true
				else
				{
					GetVehiclePos(FW_AttachedVehicle[fw], fwX, fwY, fwZ);
					new Float: AttachOffset[3];
					Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_X, AttachOffset[0]);
					Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Y, AttachOffset[1]);
					Streamer_GetFloatData(0, FW_Object[fw][0][0], E_STREAMER_ATTACH_OFFSET_Z, AttachOffset[2]);
					fwX += AttachOffset[0];
					fwY += AttachOffset[1];
					fwZ += AttachOffset[2];
				}
				#endif
				
				GetDynamicObjectRot(FW_Object[fw][0][0], fwU, fwU, fwR);
				
				for (new i = 0, mp = GetPlayerPoolSize(); i <= mp; i++)
				{
					if(IsPlayerInRangeOfPoint(i,50,fwX, fwY, fwZ))
					{
						PlayerPlaySound(i, 1095, 0, 0, 0);
					}
				}
				
				FW_Object[fw][fo][0] = CreateDynamicObject(FW_Colors[fw][0], fwX, fwY, fwZ-0.5, 0.0, 0.0, 0.0, -1, 0, -1, 300.0);
				switch (stage)
				{
					case 1, 10, 12:{GetOffsetPos(fwX, fwY, 30.0, fwR+90); fwZ += 25.0;}
					case 2, 9, 13: {GetOffsetPos(fwX, fwY, 20.0, fwR+90); fwZ += 35.0;}
					case 3, 8, 14: {									  fwZ += 40.0;}
					case 4, 7, 15: {GetOffsetPos(fwX, fwY, 20.0, fwR-90); fwZ += 35.0;}
					case 5, 6, 16: {GetOffsetPos(fwX, fwY, 30.0, fwR-90); fwZ += 25.0;}
				}
				MoveDynamicObject(FW_Object[fw][fo][0], fwX, fwY, fwZ, 25.0);
				FW_Object[fw][fo][1] = 1;
				break;
			}
			if (fo == (MAX_FWOBJECT-1)) 
			{
				//SendClientMessageToAll(MSG_WARNING, "B£¥D: LIMIT PETARD OSI¥GNIÊTY!");
				return 0;
			}
		}
		if (FW_Stage[fw] != 2) {return 1;}
		switch (stage)
		{
			case 1..4, 6..9: {fwTime = CAKE_SINGLE_DELAY;}
			case 5, 10: {fwTime = CAKE_BIG_DELAY;}
		}
		UpdateStreamerForAll();
		stage++;
		SetTimerEx("FW_CakeFire", fwTime, false, "ii", fw, stage);
		return 1;
	}
	else
	{
		FW_Stage[fw] = 3;
		FW_CakeFire(fw, 12);
		FW_CakeFire(fw, 13);
		FW_CakeFire(fw, 14);
		FW_CakeFire(fw, 15);
		FW_CakeFire(fw, 16);
		UpdateStreamerForAll();
		SetTimerEx("FW_MainDestroy", DEF_STAY_TIME, false, "i", fw);
		return 0;
	}
}

// Other things
stock UpdateStreamerForAll()
{
	#if USE_STREAMER == true
	for (new p = 0, mp = GetPlayerPoolSize(); p <= mp; p++)
	{
		Streamer_Update(p);
	}
	#endif
	return 1;
}

stock GetOffsetPos(&Float:x, &Float:y, Float:distance, Float: r)
{	// Created by Y_Less
	x += (distance * floatsin(-r, degrees));
	y += (distance * floatcos(-r, degrees));
}

stock Get2DRandomDistanceAway(&Float: fwX, &Float: fwY, min_distance, max_distance = 100)
{
	new Float: tempX = fwX, Float: tempY = fwY;
	new rX = random(max_distance);
	new rY = random(max_distance);
	tempX += float(rX-(max_distance/2));
	tempY += float(rY-(max_distance/2));
	while (GetDistance(tempX, tempY, 10.0, fwX, fwY, 10.0) < min_distance/2)
	{
		tempX = fwX;
		tempY = fwY;
		rX = random(max_distance);
		rY = random(max_distance);
		tempX += float(rX-(max_distance/2));
		tempY += float(rY-(max_distance/2));
	}
	fwX = tempX;
	fwY = tempY;
	return 1;
}

stock Get3DRandomDistanceAway(&Float: fwX, &Float: fwY, &Float: fwZ, min_distance, max_distance = 100)
{
	new Float: tempX = fwX, Float: tempY = fwY, Float: tempZ = fwZ;
	new rX = random(max_distance);
	new rY = random(max_distance);
	new rZ = random(max_distance);
	tempX += float(rX-(max_distance/2));
	tempY += float(rY-(max_distance/2));
	tempZ += float(rZ-(max_distance/2));
	while (GetDistance(tempX, tempY, tempZ, fwX, fwY, fwZ) < min_distance/2)
	{
		tempX = fwX;
		tempY = fwY;
		tempZ = fwZ;
		rX = random(max_distance);
		rY = random(max_distance);
		rZ = random(max_distance);
		tempX += float(rX-(max_distance/2));
		tempY += float(rY-(max_distance/2));
		tempZ += float(rZ-(max_distance/2));
	}
	fwX = tempX;
	fwY = tempY;
	fwZ = tempZ;
	return 1;
}

stock GetDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return floatround(floatsqroot((( x1 - x2 ) * ( x1 - x2 )) + (( y1 - y2 ) * ( y1 - y2 )) + (( z1 - z2 ) * ( z1 - z2 ))));
}
	


stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{	// Created by Y_Less
	new Float:a, vehid = GetPlayerVehicleID(playerid);
	GetPlayerPos(playerid, x, y, a);
	if (!vehid) {GetPlayerFacingAngle(playerid, a);}
	else {GetVehicleZAngle(vehid, a);}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock RemoveWeaponFromSlot(playerid, weaponslot)
{
	new weapons[13][2];
	for(new i = 0; i < 13; i++)
		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
	weapons[weaponslot][0] = 0;
	ResetPlayerWeapons(playerid);

	for(new i = 0; i < 13; i++)
		GivePlayerWeapon(playerid, weapons[i][0], weapons[i][1]);
	return 1;
}
