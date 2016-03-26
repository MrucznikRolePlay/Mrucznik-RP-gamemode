// -----------------------------------------------------------------------------
// Example Filterscript for the new Stunt Island
// ---------------------------------------------
// By Matite and Kye in January 2015
//
// Updated to v1.02 by Matite in February 2015
// * Added code to display the current lap record details when the player
//   types the /si teleport command
//
// This script creates a Modular Island with a stunt set made of the new half tube
// objects. The location is just off the coast in the northern part of the map. It
// also enables a teleport (/si) to get there and AutoFix (/af) for vehicles.
//
// Warning, this script...
// * Uses a total of 467 player objects
// * Adds 6 x Infernuses
// * Has a teleport (/si) command enabled by default
// * Enables AutoFix (/af) for all players by default
// * Enables 10x NOS for all Infernuses by default
// * Enables adding 10x NOS to all Infernuses by using the fire key
// * Disables vehicle collisions for the Infernuses created by this script
//
// Note: you can enable the /flip command by removing the code comment lines
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP Include
#include <a_samp>

// -----------------------------------------------------------------------------
// Defines
// -------

// Used for chat text messages
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA

// Number of map specific vehicles created by this script
#define NUM_SI_VEHICLES             6

// -----------------------------------------------------------------------------
// Forwards
// --------

// Used for the autofix timer (this timer runs all the time)
forward SIAutoFix();
forward IsSIInfernus(vehicleid);

// -----------------------------------------------------------------------------
// Variables
// ---------

// Stores the vehicle number of each Infernus created by this filterscript so
// they can be deleted if the filterscript is unloaded
new SIInfernus[NUM_SI_VEHICLES];

// Tracks whether the player has AutoFix disabled
new SIAutoFixDisabled[MAX_PLAYERS];

// Stores a reference to the AutoFix timer so it can be killed when this
// filterscript is unloaded
new SIAutoFixTimer;

// Stores the race checkpoint locations for the Stunt Island
new Float:StuntIslandCPs[26][3] =
{
    // X Position		Y Position		Z Position
	// -------------------------------------------

	{121.96,		 	3422.62, 		7.49},
	{262.83,		 	3422.62, 		40.86},
	{295.66,		 	3422.62, 		82.13},
	{332.11,		 	3257.69, 		81.25},
	{299.93,		 	3337.11, 		62.03},
	{311.17,		 	3475.42, 		62.03},
	{311.17,		 	3647.12, 		84.18},
	{322.48,		 	3698.05, 		125.61},
	{29.69,		 		3698.05, 		27.91},
	{73.18,		 		3666.20, 		32.08},
	{241.21,		 	3679.01, 		31.72},
	{241.21,		 	3369.28, 		31.72},
	{159.44,		 	3298.87, 		108.01},
	{159.44,		 	3440.01, 		84.34},
	{159.44,		 	3514.15, 		60.68},
	{159.44,		 	3679.18, 		82.83},
	{247.58,		 	3739.98, 		71.60},
	{235.02,		 	3607.64, 		67.86},
	{174.86,		 	3494.73, 		67.86},
	{130.26,		 	3406.86, 		52.24},
	{119.19,		 	3362.98, 		40.44},
	{108.01,		 	3304.27, 		35.76},
	{123.23,            3217.41,        35.76},
	{139.88,		 	3341.60, 		16.22},
	{183.17,		 	3456.39, 		16.22},
	{110.25,		 	3498.03, 		11.18}
};

// Stores the players current race checkpoint
new SIPlayerCP[MAX_PLAYERS];

// Stores the players race start time so it can be subtracted
// from the end race time to get the total race time
new SIPlayerStartTime[MAX_PLAYERS];

// Stores the fastest lap time in seconds
new FastestLapTime = 999;

// Stores the name of the player who has the fastest lap time
new FastestLapName[MAX_PLAYER_NAME + 1];

// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	// Check if the new player state is driver or passenger
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
        // Get the players vehicle ID
        new player_vehicle = GetPlayerVehicleID(playerid);
        
        // Check if the player is driving one of the Infernuses created by this filterscript
        if (IsSIInfernus(player_vehicle))
		{
		    // Disable vehicle collisions and set PVar
            DisableRemoteVehicleCollisions(playerid, true);
            SetPVarInt(playerid, "SIVehicleCols", 1);
		}
	}
	else
	{
	    // Check if the PVar is set (player had vehicle collisions disabled)
	    if (GetPVarInt(playerid, "SIVehicleCols"))
		{
		    // Enable vehicle collisions and set PVar
		    DisableRemoteVehicleCollisions(playerid, false);
		    SetPVarInt(playerid, "SIVehicleCols", 0);
		}
	}
	
	// Exit here (return 1 so this callback is handled in other filterscripts)
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    // Check for FIRE key
	if (newkeys & KEY_FIRE)
	{
	    // Fire Key is usually the Left Mouse Button
		// -----------------------------------------

	    // Check if player is in any vehicle
	    if (!IsPlayerInAnyVehicle(playerid)) return 1;

	    // Do not allow passengers to use this on people driving
		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
		
		// Check if the vehicle model is an Infernus
		if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 411)
		{
		    // Add 10x NOS
		    AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		    
		    // Debug
		    //printf("-->Added 10x NOS to Vehicle Number %d for Player ID %d", GetPlayerVehicleID(playerid), playerid);
		}
	}

	// Exit here (return 1 so this callback is handled in other filterscripts)
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	// Get the player pos
    new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	// Increase current checkpoint
	SIPlayerCP[playerid]++;
	
	// Debug
	//printf("-->Player ID %d Current CP is %d of %d", playerid, SIPlayerCP[playerid], sizeof(StuntIslandCPs));

    // Check if the race checkpoint is the start line
	if (SIPlayerCP[playerid] == 1)
	{
	    // Reset current checkpoint (in case the player drove back to the start CP and did not type /si)
	    SIPlayerCP[playerid] = 1;
	    
	    // Store the players race start time
	    SIPlayerStartTime[playerid] = gettime();
	    
	    // Debug
	    //printf("-->Race start time for Player %d is %d", playerid, SIPlayerStartTime[playerid]);
	    
	    // Send a gametext message to the player
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Race Timer Started!", 3000, 3);
		
		// Format chat text message for all
		new strTempString[64];
		new PlayerName[MAX_PLAYER_NAME + 1];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
        format(strTempString, sizeof(strTempString), "* %s (ID:%d) started their timed lap.", PlayerName, playerid);
        SendClientMessageToAll(COLOR_MESSAGE_YELLOW, strTempString);

	    // Play a sound
	    PlayerPlaySound(playerid, 1139, x, y, z);
	    
	    // Create next checkpoint
		SetPlayerRaceCheckpoint(playerid, 0, StuntIslandCPs[SIPlayerCP[playerid]][0], StuntIslandCPs[SIPlayerCP[playerid]][1], StuntIslandCPs[SIPlayerCP[playerid]][2], StuntIslandCPs[SIPlayerCP[playerid] + 1][0], StuntIslandCPs[SIPlayerCP[playerid] + 1][1], StuntIslandCPs[SIPlayerCP[playerid] + 1][2], 12.0);
	}
	// Check if the race checkpoint is the finish line
	else if (SIPlayerCP[playerid] == sizeof(StuntIslandCPs))
	{
	    // Get the total lap time
	    new TotalLapTime = gettime() - SIPlayerStartTime[playerid];
	    
	    // Get player name and store
	    new PlayerName[MAX_PLAYER_NAME + 1];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		
		// Create variable
		new strTempString[128];
	    
	    // Check if the players total lap time is faster than the current fastest lap time
	    if (TotalLapTime < FastestLapTime)
	    {
	        // Check if no previous fastest lap record exists
	        if (FastestLapTime == 999)
	        {
	            // Format chat text messages for all
	        	format(strTempString, sizeof(strTempString), "** %s (ID:%d) completed their timed lap in %d seconds and set a new record.", PlayerName, playerid, TotalLapTime);
	        	SendClientMessageToAll(COLOR_MESSAGE_YELLOW, strTempString);
		 	}
	        else
	        {
		        // Format chat text messages for all
	        	format(strTempString, sizeof(strTempString), "** %s (ID:%d) completed their timed lap in %d seconds beating the existing record", PlayerName, playerid, TotalLapTime);
	        	SendClientMessageToAll(COLOR_MESSAGE_YELLOW, strTempString);
	        	format(strTempString, sizeof(strTempString), "*  of %d seconds previously set by %s.", FastestLapTime, FastestLapName);
	        	SendClientMessageToAll(COLOR_MESSAGE_YELLOW, strTempString);
        	}
        
	        // Store new fastest lap time
	        FastestLapTime = TotalLapTime;
	        
	        // Store new fastest lap time name
			format(FastestLapName, sizeof(FastestLapName), "%s", PlayerName);
	    }
	    else
	    {
	        // Format chat text message for all
    	    format(strTempString, sizeof(strTempString), "* %s (ID:%d) completed their timed lap in %d seconds.", PlayerName, playerid, TotalLapTime);
	        SendClientMessageToAll(COLOR_MESSAGE_YELLOW, strTempString);
	    }
        
	    // Send a gametext message to the player
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Finished!", 3000, 3);
		
	    // Play a sound
	    PlayerPlaySound(playerid, 1139, x, y, z);
	    
        // Set current checkpoint
		SIPlayerCP[playerid] = 0;

		// Create start checkpoint
		SetPlayerRaceCheckpoint(playerid, 1, StuntIslandCPs[SIPlayerCP[playerid]][0], StuntIslandCPs[SIPlayerCP[playerid]][1], StuntIslandCPs[SIPlayerCP[playerid]][2], StuntIslandCPs[SIPlayerCP[playerid] + 1][0], StuntIslandCPs[SIPlayerCP[playerid] + 1][1], StuntIslandCPs[SIPlayerCP[playerid] + 1][2], 12.0);
	}
	// Check if the race finish line is next
	else if (SIPlayerCP[playerid] == sizeof(StuntIslandCPs) - 1)
	{
	    // Send a gametext message to the player
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Finish Line Is Next!", 3000, 3);
		
	    // Play a sound
	    PlayerPlaySound(playerid, 1138, x, y, z);
	    
		// Create next checkpoint (finish line)
		SetPlayerRaceCheckpoint(playerid, 1, StuntIslandCPs[SIPlayerCP[playerid]][0], StuntIslandCPs[SIPlayerCP[playerid]][1], StuntIslandCPs[SIPlayerCP[playerid]][2], -1, -1, -1, 12.0);
	}
	else
	{
	    // Play a sound
	    PlayerPlaySound(playerid, 1138, x, y, z);
	    
		// Create next checkpoint
		SetPlayerRaceCheckpoint(playerid, 0, StuntIslandCPs[SIPlayerCP[playerid]][0], StuntIslandCPs[SIPlayerCP[playerid]][1], StuntIslandCPs[SIPlayerCP[playerid]][2], StuntIslandCPs[SIPlayerCP[playerid] + 1][0], StuntIslandCPs[SIPlayerCP[playerid] + 1][1], StuntIslandCPs[SIPlayerCP[playerid] + 1][2], 12.0);
	}

	// Exit here
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/si", cmdtext, true, 3) == 0)
	{
	    // Set the player interior
		SetPlayerInterior(playerid, 0);
		
		// Check if the player is in any vehicle
		if (IsPlayerInAnyVehicle(playerid))
		{
		    // In a Vehicle
		    // ------------
		    
		    // Set vehicle position and facing angle
		    SetVehiclePos(GetPlayerVehicleID(playerid), 27.24 + random(2), 3422.45, 6.2);
		    SetVehicleZAngle(GetPlayerVehicleID(playerid), 270);

			// Link vehicle to interior
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
		}
		else
		{
		    // On Foot
		    // -------
		    
			// Set player position and facing angle
			SetPlayerPos(playerid, 27.24 + random(2), 3422.45, 6.2);
			SetPlayerFacingAngle(playerid, 270);
		}

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);
		
		// Display chat text message to the player
		SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* You teleported to the Stunt Island... drive into the checkpoint to start your timed lap.");

		// Check if there is a previous lap record
		if (FastestLapTime != 999)
		{
		    // Create variable
			new strTempString[128];
			
			// Format and display chat text message to the player
			format(strTempString, sizeof(strTempString), "* The current record is %d seconds previously set by %s.", FastestLapTime, FastestLapName);
       		SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, strTempString);
       	}

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Stunt Island!", 3000, 3);
		
		// Set current checkpoint
		SIPlayerCP[playerid] = 0;
		
		// Create start checkpoint
		SetPlayerRaceCheckpoint(playerid, 1, StuntIslandCPs[SIPlayerCP[playerid]][0], StuntIslandCPs[SIPlayerCP[playerid]][1], StuntIslandCPs[SIPlayerCP[playerid]][2], StuntIslandCPs[SIPlayerCP[playerid] + 1][0], StuntIslandCPs[SIPlayerCP[playerid] + 1][1], StuntIslandCPs[SIPlayerCP[playerid] + 1][2], 12.0);

	    // Exit here
	    return 1;
	}
	else if (strcmp("/af", cmdtext, true, 3) == 0)
	{
		// Check if AutoFix is enabled for the player
		if (SIAutoFixDisabled[playerid] == 0)
		{
		    // Set flag
		    SIAutoFixDisabled[playerid] = 1;
		    
		    // Display a chat text message to the player
			SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* You disabled AutoFix for your vehicle.");
		    
		    // Send a gametext message to the player
			GameTextForPlayer(playerid, "~g~~h~AutoFix Disabled!", 3000, 3);
		}
		else
		{
		    // Set flag
		    SIAutoFixDisabled[playerid] = 0;
		    
		    // Display a chat text message to the player
			SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* You enabled AutoFix for your vehicle.");
		    
			// Send a gametext message to the player
			GameTextForPlayer(playerid, "~g~~h~AutoFix Enabled!", 3000, 3);
		}

	    // Exit here
	    return 1;
	}
	/*
	else if (strcmp("/flip", cmdtext, true, 5) == 0)
	{
		// Check to see if the player is not a driver of any vehicle
		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
			// Send chat text message to the player and exit here
		    SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* You must be the driver of a vehicle before using the /flip command.");
		    return 1;
		}

	    // Create variables
		new Float:x;
		new Float:y;
		new Float:z;
		new Float:a;
		new playervid = GetPlayerVehicleID(playerid);

		// Get Vehicle Pos
		GetVehiclePos(playervid, x, y, z);
	    GetVehicleZAngle(playervid, a);

	    // Flip the vehicle
	    SetVehiclePos(playervid, x, y, z + 2);
	    SetVehicleZAngle(playervid, a);

	    // Display a chat text message to the player
		SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Your vehicle has been flipped.");

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~g~~h~Vehicle Flipped!", 3000, 3);

	    // Exit here
	    return 1;
	}*/

	// Exit here (return 0 as the command was not handled in this filterscript)
	return 0;
}

public OnVehicleSpawn(vehicleid)
{
	// Check if the vehicle is an Infernus
	if (GetVehicleModel(vehicleid) == 411)
	{
	    // Add 10x NOS to the vehicle
	    AddVehicleComponent(vehicleid, 1010);
	}
	
	// Return 0 so this callback is processed by other filterscripts and the gamemode
	return 0;
}

public OnFilterScriptInit()
{
    // Display information in the Server Console
	print("\n");
	print("  |---------------------------------------------------");
	print("  |--- Stunt Island Filterscript by Matite and Kye");
    print("  |--  Script v1.02");
    print("  |--  13th February 2015");
	print("  |---------------------------------------------------");
	
	// Loop
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
	    	// Create stunt island objects for the player
	    	// (so any player currently ingame does not have to rejoin for them
			//  to appear when this filterscript is loaded)
			CreateSIObjects(i);
		}
	}
	
	// Create NUM_SI_VEHICLES Infernuses
	for (new i = 0; i < NUM_SI_VEHICLES; i++)
	{
	    // Create an Infernus and remember the vehicle number so it can be
	    // deleted when this filterscript is unloaded
	    SIInfernus[i] = CreateVehicle(411, 89.45, 3445.0 + (i * 6.0), 5.05, 90.0, -1, -1, 30);
	    
	    // Check that the vehicle was created ok
	    if(SIInfernus[i] != INVALID_VEHICLE_ID)
		{
		    // Add 10x NOS to the Infernus
        	AddVehicleComponent(SIInfernus[i], 1010);
		}
	}
	
	// Start the AutoFix timer (every 1.803 seconds the timer is triggered)
	SIAutoFixTimer = SetTimer("SIAutoFix", 1803, 1);

    // Exit here
	return 1;
}

public OnFilterScriptExit()
{
	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Stunt Island Filterscript Unloaded");
	print("  |---------------------------------------------------");
	
	// Delete 6 Infernuses
	for (new i = 0; i < NUM_SI_VEHICLES; i++)
	{
	    // Delete the Infernus vehicles created by this filterscript
	    DestroyVehicle(SIInfernus[i]);
	}
	
	// Kill the AutoFix timer
	KillTimer(SIAutoFixTimer);

	// Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
	// Create stunt island objects for the player
	CreateSIObjects(playerid);

	// Exit here
	return 1;
}

CreateSIObjects(playerid)
{
	// Create variable
	new TempObjectNumber;
	
    // Create stunt island player objects (with draw distance of 999m)
    CreatePlayerObject(playerid,19672,331.9166,3396.5845,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19532,77.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,335.0000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,335.0000,3757.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19535,77.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,-62.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,335.0000,3663.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,77.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,77.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,7.5000,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19533,-62.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19531,-132.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19534,-62.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19534,-62.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-62.4998,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,84.9997,3827.5000,4.3078,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19533,-62.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,7.5000,3422.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,-132.5000,3422.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19538,-132.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,-55.0000,3227.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19545,-62.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,-202.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19541,15.0001,3352.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,77.5000,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-62.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-132.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,-202.5000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3383.7500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3422.5000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3461.2500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3499.9998,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19532,-202.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19533,-202.5000,3678.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,-210.0000,3570.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-210.0000,3640.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3678.7500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19541,-202.4998,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19540,335.0000,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19546,85.0000,3352.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19547,-132.5000,3290.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19546,-54.9999,3352.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3321.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3258.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,-132.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-62.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-55.0000,3165.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-210.0000,3290.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3321.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3258.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-202.5000,3196.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,-210.0000,3196.2500,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19546,84.9999,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19532,77.5000,3772.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,178.7500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19540,85.0000,3835.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-69.9998,3835.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19546,-69.9998,3710.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19532,-62.4999,3772.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,-163.7498,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,-69.9998,3803.7500,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19539,335.0000,3726.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19529,7.5000,3570.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,241.2500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,303.7500,3757.5000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19539,241.2500,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19539,303.7500,3257.5000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,-62.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3422.5000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3500.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,-202.5000,3640.0000,4.3077,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19535,77.5000,3640.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,149.4099,3422.5000,-40.2988,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,300.0856,3261.5845,83.4814,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19642,124.1813,3422.5000,8.8521,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19647,134.1813,3422.5000,8.8520,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19650,96.9146,3422.5000,6.1717,0.0000,-10.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19643,114.1813,3422.5000,8.8521,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19659,-15.6602,3682.0776,29.3538,0.0000,0.0000,0.0000,999.0);

	TempObjectNumber = CreatePlayerObject(playerid,19665,311.1857,3531.0288,86.7789,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19667,305.6357,3426.5845,95.3124,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	CreatePlayerObject(playerid,19664,70.0058,3666.1621,31.6038,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3381.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,326.6671,3417.2505,83.4814,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19662,337.7673,3671.4116,87.1412,0.0000,0.0000,90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19651,284.1701,3276.5845,73.4814,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,266.0011,3406.5845,53.4814,0.0000,0.0000,180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	CreatePlayerObject(playerid,19660,316.0011,3245.9185,83.4814,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,188.5509,3422.5000,25.7300,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,203.5318,3422.5000,26.3325,0.0000,20.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19674,200.6326,3498.2903,17.2481,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19676,140.8339,3498.2903,12.0060,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19673,231.6195,3422.5000,36.5668,0.0000,15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19675,144.5353,3422.5000,9.2890,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19678,120.0057,3697.9932,51.5540,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19675,154.9452,3422.5000,10.6383,0.0000,5.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19675,165.1978,3422.5000,12.8897,0.0000,10.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19675,175.2152,3422.5000,16.0262,0.0000,15.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,255.9339,3422.5000,-7.4172,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19673,241.1739,3422.5000,39.5792,0.0000,10.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19673,250.9545,3422.5000,41.7474,0.0000,5.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19673,260.8867,3422.5000,43.0549,0.0000,0.0000,180.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,266.0011,3406.5845,73.4814,0.0000,0.0000,180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	CreatePlayerObject(playerid,19649,291.0011,3422.5000,83.4814,0.0000,-0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,291.0011,3422.5000,33.4567,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19684,314.6369,3697.9932,126.3243,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19682,213.1957,3717.7407,29.3538,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19681,157.1870,3668.5852,29.3538,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19686,260.6396,3739.9441,70.3298,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19685,181.5493,3697.9929,58.8229,0.0000,-30.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3331.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,331.9167,3356.5845,33.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,331.9166,3281.5845,81.2314,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,300.0856,3271.5845,83.4814,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,331.9166,3306.5845,33.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3301.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3351.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,300.0856,3401.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,300.0855,3356.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,300.0856,3306.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3451.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3501.5845,63.4814,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3466.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1858,3516.5845,13.4567,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,311.1857,3575.2466,87.1413,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19663,311.1858,3625.2466,84.8912,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3560.2466,37.1166,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,316.4353,3660.9126,87.1412,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,311.1857,3625.2466,32.6165,0.0000,0.0000,90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,358.9323,3682.0776,97.1412,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,358.9323,3682.0776,117.1413,0.0000,0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19667,95.0057,3729.8225,46.0054,-90.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	CreatePlayerObject(playerid,19662,337.7672,3692.7434,127.1412,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19684,290.5576,3697.9929,119.8723,0.0000,15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19649,257.7041,3697.9929,101.8476,0.0000,-30.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,214.4028,3697.9929,76.8476,0.0000,-30.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19685,157.4701,3697.9929,52.3709,0.0000,-15.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,149.8595,3697.9929,1.6564,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,343.0168,3682.0776,37.1165,0.0000,0.0000,90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19667,95.0057,3729.8225,34.9053,-90.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19668,124.6504,3397.5898,84.0644,0.0000,15.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3413.4658,108.9914,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	CreatePlayerObject(playerid,19680,70.0058,3697.9932,29.3538,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,25.0058,3697.9932,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,20.0058,3697.9932,29.3539,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19659,-15.6602,3682.0776,34.8538,180.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19649,20.0058,3666.1621,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19649,120.0058,3666.1621,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,25.0058,3666.1621,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3679.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,185.1914,3693.1628,29.3538,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19661,236.0429,3714.9141,29.3538,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19670,125.0058,3666.1621,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19648,241.2924,3599.2480,29.3538,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19644,110.4799,3498.2903,11.5691,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3679.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19647,241.2924,3569.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3489.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3489.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,241.2924,3419.2480,27.1038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,241.2924,3459.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19646,241.2924,3449.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19664,241.2924,3369.2480,31.6038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3369.2480,-16.1709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19663,241.2924,3319.2480,27.1038,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,236.0429,3283.5820,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,235.9641,3283.5449,34.8538,-180.0000,0.0000,179.0000,999.0);
	CreatePlayerObject(playerid,19649,200.3770,3278.3325,29.3538,0.0000,-0.0000,-0.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,39.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,59.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,79.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,44.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,99.3538,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	CreatePlayerObject(playerid,19670,185.3770,3278.3325,-20.6709,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7110,3283.5820,109.3538,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3319.2480,109.3538,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3369.2480,109.3538,0.0000,-0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3364.2480,59.3291,0.0000,0.0000,90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3487.1279,85.3316,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19666,159.4614,3560.7900,61.6717,0.0000,0.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	CreatePlayerObject(playerid,19670,119.1004,3385.7981,-1.9767,0.0000,0.0000,90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19649,159.4614,3442.9102,85.6940,0.0000,-0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	CreatePlayerObject(playerid,19684,159.4614,3667.4851,81.6925,0.0000,-30.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,159.4614,3634.6316,63.6678,0.0000,30.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19684,159.4614,3691.5645,88.1445,0.0000,-15.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7109,3734.6946,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3714.0286,38.9367,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,283.7699,3734.6946,69.5128,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19684,187.8412,3739.9441,88.1445,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19649,224.2404,3739.9441,79.2371,0.0000,-15.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19670,273.1040,3739.9441,19.4881,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,289.0194,3719.0288,69.5128,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,283.7699,3734.6946,75.0128,180.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19682,286.5965,3701.8474,69.5128,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19681,237.4409,3645.8386,69.5129,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,262.0187,3673.8430,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19649,235.0180,3608.6575,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,235.0180,3558.6575,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19682,232.5950,3521.4763,69.5129,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,130.2005,3429.9766,59.7885,0.0000,-15.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19682,208.2971,3497.1785,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19649,171.1159,3494.7554,69.5129,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19646,222.1594,3507.6140,69.5129,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19662,135.4500,3489.5059,69.5129,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19684,130.2004,3466.3757,68.6959,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,258.4832,3670.3076,19.4881,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19686,108.0004,3345.2810,37.9402,0.0000,0.0000,-90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19649,119.1004,3381.6802,46.8476,0.0000,-15.0000,90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19668,113.5504,3349.2935,71.1235,0.0000,15.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "BlueDirt1", 0);
	
	CreatePlayerObject(playerid,19663,108.0004,3257.8167,34.8733,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,130.2004,3473.6985,19.3535,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,108.0003,3332.8167,-12.9014,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,216.7155,3422.5000,35.9592,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,275.3560,3419.4604,50.1579,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,281.1376,3401.6663,54.0688,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,266.0011,3390.6689,58.0268,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,250.8645,3401.6663,61.8254,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,256.6462,3419.4604,65.9731,0.0000,0.0000,-144.0000,999.0);
	CreatePlayerObject(playerid,19672,256.6462,3419.4604,85.7634,0.0000,0.0000,-144.0000,999.0);
	CreatePlayerObject(playerid,19672,275.3560,3419.4604,69.9482,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,281.1376,3401.6663,73.8591,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,266.0011,3390.6689,77.8171,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,250.8645,3401.6663,81.6157,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,276.0011,3422.5000,88.0673,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,305.9753,3422.5000,88.0673,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,327.3069,3417.8904,87.9516,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19550,7.5000,3710.0000,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3366.5771,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3316.5845,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3346.5918,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3266.5923,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,331.9166,3296.5999,85.9599,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,327.3070,3245.2786,88.2336,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19672,304.6953,3245.2788,88.1757,0.0000,0.0000,135.0000,999.0);
	CreatePlayerObject(playerid,19672,297.0461,3285.9395,86.1250,0.0000,0.0000,126.0000,999.0);
	CreatePlayerObject(playerid,19672,279.2520,3291.7209,82.0771,0.0000,0.0000,16.0000,999.0);
	CreatePlayerObject(playerid,19672,268.2546,3276.5845,78.2285,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,279.2520,3261.4480,73.9912,0.0000,0.0000,-20.0000,999.0);
	CreatePlayerObject(playerid,19672,297.0460,3267.2297,70.2106,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0856,3286.5845,68.0976,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0856,3316.5479,68.0976,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3336.5508,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3366.5588,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3386.5305,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,300.0001,3416.5354,68.3325,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3436.5845,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3466.5889,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3486.5654,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3516.5720,68.1464,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3531.8862,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3560.2422,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1857,3590.2336,91.8754,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1858,3610.2466,89.8444,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,311.1858,3640.2439,89.8444,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,315.7955,3661.5525,91.7584,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19540,85.0000,3257.5000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19540,-210.0000,3165.0000,4.3077,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19540,-210.0000,3710.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,338.4071,3670.7717,91.8683,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3691.4324,93.9506,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8504,3697.2141,97.8625,0.0000,0.0000,-18.0000,999.0);
	CreatePlayerObject(playerid,19672,374.8478,3682.0776,101.8288,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8505,3666.9409,105.8737,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3672.7227,109.8370,0.0000,0.0000,-54.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3672.7227,129.7860,0.0000,0.0000,-54.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8505,3666.9409,125.8226,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,374.8478,3682.0776,121.7777,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,363.8504,3697.2141,117.8115,0.0000,0.0000,-18.0000,999.0);
	CreatePlayerObject(playerid,19672,346.0564,3691.4324,113.8996,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,19672,338.4071,3693.3833,131.7450,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,311.7588,3697.9929,130.6222,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,287.1232,3697.9929,123.3002,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,269.3201,3697.9929,113.6222,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,243.3627,3697.9929,98.6212,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,226.0258,3697.9929,88.6012,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,200.0598,3697.9929,73.6839,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,178.2511,3697.9929,62.4286,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,154.6358,3697.9929,56.6647,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,35.0058,3697.9932,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,5.0128,3697.9932,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,5.0128,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,35.0058,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,55.0236,3666.1621,36.0365,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,85.0416,3666.1621,36.0365,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,105.0083,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,134.9800,3666.1621,34.0287,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4567,3669.6313,34.0726,0.0000,0.0000,27.0000,999.0);
	CreatePlayerObject(playerid,19672,174.5848,3682.5562,34.1170,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,195.7980,3703.7695,34.1170,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,215.5406,3718.6057,33.9744,0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,234.7318,3717.1240,34.0809,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3694.2480,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3664.2678,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3504.2703,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3474.2324,36.0042,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3434.2769,32.0711,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3404.2515,32.0711,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3384.2493,36.0140,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3354.2383,36.0140,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3334.2317,32.0321,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3304.2390,31.9984,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,215.3770,3278.3325,33.8870,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,185.3680,3278.3325,33.8870,0.0000,0.0000,-0.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3770,3294.2480,64.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19652,175.3769,3294.2480,84.8538,180.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "GreenDirt1", 0);
	
	CreatePlayerObject(playerid,19672,159.4614,3304.2480,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,164.0711,3282.9424,113.9617,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,184.7318,3281.3721,112.0262,0.0000,0.0000,36.0000,999.0);
	CreatePlayerObject(playerid,19672,190.5135,3299.1663,107.8524,0.0000,0.0000,-72.0000,999.0);
	CreatePlayerObject(playerid,19672,175.3769,3310.1636,103.8580,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,160.2404,3299.1663,100.0933,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,166.0220,3281.3721,95.9705,0.0000,0.0000,-36.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3334.2378,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3354.2266,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3384.2668,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3412.5928,114.0335,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3486.2449,90.4535,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3559.9297,66.7921,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4614,3579.7673,44.2265,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3427.9221,90.4296,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3457.8840,90.4296,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3620.2524,60.4987,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3646.2703,75.5153,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3668.8413,87.1338,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4613,3693.7808,93.1308,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,190.6684,3739.9441,92.3369,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,210.4541,3739.9441,87.6401,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,239.4345,3739.9441,79.8874,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,263.4093,3739.9441,74.7607,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19672,285.5501,3699.5776,74.1313,-0.0000,0.0000,63.0000,999.0);
	CreatePlayerObject(playerid,19672,272.6253,3684.4497,74.1723,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,251.4121,3663.2366,74.1261,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,236.5759,3643.4939,74.1149,-0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3623.6575,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3593.5452,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3573.5925,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,235.0180,3543.6985,74.2145,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,231.5486,3519.2065,74.1295,-0.0000,0.0000,63.0000,999.0);
	CreatePlayerObject(playerid,19672,205.9522,3496.3135,74.1754,-0.0000,0.0000,18.0000,999.0);
	CreatePlayerObject(playerid,19672,186.1409,3494.8167,74.1754,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,156.0972,3494.8167,74.1754,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,134.8101,3490.1458,74.2067,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3463.4688,72.9750,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3443.7839,68.1349,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,130.2005,3414.7671,60.4308,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,129.9005,3396.0225,56.9608,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,119.1004,3395.4226,55.3437,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,119.1004,3366.4854,47.5958,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,118.8004,3347.7910,44.0340,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3342.5022,42.2326,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3272.8323,39.8413,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3242.8140,39.7832,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,241.2924,3629.2480,29.3538,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,241.2925,3539.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19642,241.2924,3589.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19642,241.2924,3579.2480,29.3539,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.7848,3542.6001,-22.0166,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,241.2924,3624.2480,-20.6709,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3524.2693,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3554.2651,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3614.2158,34.0474,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,241.2924,3644.2666,34.0474,0.0000,0.0000,-90.0000,999.0);
	
	TempObjectNumber = CreatePlayerObject(playerid,19649,159.4614,3516.5723,62.0340,0.0000,-0.0000,-90.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 19659, "MatTubes", "YellowDirt1", 0);
	
	CreatePlayerObject(playerid,19672,159.4615,3501.5842,66.7697,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19672,159.4615,3531.5461,66.7697,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19685,159.4614,3577.6987,39.1911,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19685,159.4614,3601.7781,45.6431,0.0000,15.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,159.4614,3709.0286,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,159.4614,3719.0286,88.9614,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19670,235.0180,3533.6575,19.4881,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,235.0180,3613.6575,19.4881,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3447.9102,35.6692,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3521.5723,12.0093,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,159.4614,3570.0881,-11.5234,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,164.7110,3734.6946,94.4614,-180.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19670,316.0011,3240.6689,33.4567,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3570.0000,4.3080,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3570.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3445.0000,4.3080,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3320.0000,4.3080,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19549,85.0002,3273.7500,4.3077,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19542,334.9997,3445.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,334.9997,3320.0000,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3445.0000,4.3080,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3320.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,762,159.2296,3364.1545,8.0631,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,621,172.3828,3530.9956,4.1185,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,621,210.9594,3632.0981,4.1185,0.0000,0.0000,-81.0000,999.0);
	CreatePlayerObject(playerid,621,216.5798,3372.2180,4.1185,0.0000,0.0000,-55.0000,999.0);
	CreatePlayerObject(playerid,621,169.0373,3244.0442,4.1185,0.0000,0.0000,21.0000,999.0);
	CreatePlayerObject(playerid,621,348.5469,3253.4072,4.1185,0.0000,0.0000,71.0000,999.0);
	CreatePlayerObject(playerid,762,159.7794,3569.8127,8.0631,0.0000,0.0000,40.0000,999.0);
	CreatePlayerObject(playerid,762,311.5156,3624.8386,8.0631,0.0000,0.0000,78.0000,999.0);
	CreatePlayerObject(playerid,762,298.8590,3306.5583,8.0631,0.0000,0.0000,126.0000,999.0);
	CreatePlayerObject(playerid,762,24.2674,3664.7112,8.0631,0.0000,0.0000,169.0000,999.0);
	CreatePlayerObject(playerid,762,159.5200,3713.7891,8.0631,0.0000,0.0000,-140.0000,999.0);
	CreatePlayerObject(playerid,762,290.4150,3422.7559,8.0631,0.0000,0.0000,-175.0000,999.0);
	CreatePlayerObject(playerid,762,240.0694,3678.5208,8.0631,0.0000,0.0000,122.0000,999.0);
	CreatePlayerObject(playerid,762,107.5217,3293.8779,9.0631,0.0000,0.0000,50.0000,999.0);
	CreatePlayerObject(playerid,621,60.2490,3681.9932,4.1185,0.0000,0.0000,36.0000,999.0);
	CreatePlayerObject(playerid,621,313.2220,3679.3630,4.1185,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,621,267.0584,3501.8621,4.1185,0.0000,0.0000,27.0000,999.0);
	CreatePlayerObject(playerid,621,263.6267,3280.8892,4.1185,0.0000,0.0000,-52.0000,999.0);
	CreatePlayerObject(playerid,621,318.7102,3387.3503,4.1185,0.0000,0.0000,42.0000,999.0);
	CreatePlayerObject(playerid,621,131.9952,3640.5090,4.1185,0.0000,0.0000,121.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3438.1350,4.1266,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3407.0583,4.1266,0.0000,0.0000,62.0000,999.0);
	CreatePlayerObject(playerid,19649,108.0004,3307.8167,37.1233,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19684,139.8314,3245.2810,36.3063,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3281.6802,27.3989,0.0000,-15.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19686,139.8315,3318.0793,18.4916,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19661,145.0810,3451.2097,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3355.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,139.8315,3405.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19646,139.8315,3435.5437,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,180.7469,3456.4592,17.6746,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19662,216.4129,3461.7087,17.6746,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19662,216.4129,3493.0408,17.6746,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19646,221.6624,3477.3748,17.6746,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19649,170.8531,3498.2903,14.6323,0.0000,-5.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19648,130.4799,3498.2903,11.5691,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19642,120.4800,3498.2903,11.5691,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19650,93.7424,3498.2903,6.9995,0.0000,-19.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19534,77.5000,3500.0000,4.3077,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3513.5872,4.1266,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,3509,87.8005,3482.5103,4.1266,0.0000,0.0000,62.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3322.8167,41.8230,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,108.0004,3292.8167,41.8230,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,112.6100,3221.5107,41.8151,0.0000,0.0000,135.0000,999.0);
	CreatePlayerObject(playerid,19672,135.2216,3221.5107,41.8151,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3244.9832,40.9682,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3267.9055,35.9077,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3296.8618,28.1914,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3317.8293,23.2563,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3340.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3370.5759,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3390.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,139.8314,3420.5437,22.4207,-0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19672,144.4411,3451.8496,22.4207,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,165.7469,3456.4592,22.4207,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,195.7418,3456.4592,22.4207,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,217.0527,3461.0688,22.4207,-0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,19672,217.0528,3493.6804,22.4207,-0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,19672,185.5585,3498.2903,20.4852,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19672,155.6512,3498.2903,17.9867,-0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,108.0004,3257.8167,-17.4014,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8314,3232.8167,-12.9015,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8315,3330.5437,-32.3501,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,139.8315,3410.5437,-32.3501,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19670,185.7469,3456.4592,-32.3501,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19670,175.5944,3498.2903,-34.9671,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19659,123.9158,3222.1506,37.1233,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19542,147.4997,3257.5000,4.3080,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19543,77.5002,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3461.2500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3803.7500,4.3077,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19550,147.4997,3695.0000,4.3080,0.0000,0.0000,-0.0000,999.0);
	CreatePlayerObject(playerid,19550,272.4998,3695.0000,4.3080,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,621,236.0952,3742.8730,4.1185,0.0000,0.0000,125.0000,999.0);
	CreatePlayerObject(playerid,19536,7.5000,3383.7500,4.3077,0.0000,0.0000,0.0000,999.0);

	// Exit here
	return 1;
}

public SIAutoFix()
{
	// AutoFix Timer
	// -------------

	// Loop
	for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
	    // Check if the player is connected, is not a NPC and has AutoFix enabled
	    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid) && SIAutoFixDisabled[playerid] == 0)
	    {
	        // Check if player is the driver of the vehicle
            if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
				// Get vehicle health
				new Float:CurVehicleHealth;
				new playervid = GetPlayerVehicleID(playerid);
				GetVehicleHealth(playervid, CurVehicleHealth);

				// Check if the vehicles health is less than 990... if so repair the vehicle
				// (repairs bodywork and sets vehicle health to 1000)
				if (CurVehicleHealth < 990) RepairVehicle(playervid);
			}
	    }
	}

	// Exit here
	return 1;
}

// return true if provide vehicleid is an infernus created by this script
IsSIInfernus(vehicleid)
{
	for (new i = 0; i < NUM_SI_VEHICLES; i++)
	{
	    if(SIInfernus[i] == vehicleid) return true;
	}
	return false;
}

