// -----------------------------------------------------------------------------
// Example Filterscript for the new Safe with Door
// -----------------------------------------------
// By Matite in January 2015
//
// v1.0.1
// * Inital release in RC1
//
// v1.0.2
// * Changed the Z offset in the MoveObject parameters to fix an issue with
//   movement caused by rounding on some PCs
//
// This script removes the existing safe in Madd Dogg's Mansion then creates the
// new safe and door object in its place. You can then use commands to open and
// close the safe door.
//
// You can use the following commands:
// * /safe = Teleports the player to the safe in Madd Dogg's Mansion
// * /openopen = Makes the safe door open
// * /closesafe = Makes the safe door close
//
// Warning...
// This script uses a total of 2 objects
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP include
#include <a_samp>


// ------------------------------------------------------------------------------
// Defines
// -------

// Safe door status
#define SAFE_DOOR_OPEN      (1)
#define SAFE_DOOR_CLOSED    (0)


// ------------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object number of the safe
new SafeObject;

// Stores the created object number of the safe door
new SafeDoorObject;

// Tracks the status of the safe door (ie whether it is open or closed)
new SafeDoorStatus = SAFE_DOOR_CLOSED;


// ------------------------------------------------------------------------------
// Callbacks
// ---------


public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/safe", cmdtext, true, 5) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 5);

		// Set player position and facing angle
		SetPlayerPos(playerid, 1230.61, -808.15, 1084.1);
		SetPlayerFacingAngle(playerid, 0);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Safe And Door!", 3000, 3);

	    // Exit here
	    return 1;
	}
	else if (strcmp("/opensafe", cmdtext, true, 9) == 0)
	{
	    // Check if the safe door is already open
	    if (SafeDoorStatus == SAFE_DOOR_OPEN)
	    {
	        // Send a gametext message to the player and exit here
			GameTextForPlayer(playerid, "~r~~h~Safe Door~n~~r~~h~Already Open!", 3000, 3);
	        return 1;
	    }
	
	    // Animate the safe door opening (the small Z offset is required)
	    MoveObject(SafeDoorObject, 1230.225708, -806.648803, 1083.5 + 0.01, 0.005, 0, 0, 280);
	
	    // Set the safe door status
	    SafeDoorStatus = SAFE_DOOR_OPEN;
	    
	    // Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Safe Door Opened!", 3000, 3);

	    // Exit here
	    return 1;
	}
	else if (strcmp("/closesafe", cmdtext, true, 10) == 0)
	{
	    // Check if the safe door is already open
	    if (SafeDoorStatus == SAFE_DOOR_CLOSED)
	    {
	        // Send a gametext message to the player and exit here
			GameTextForPlayer(playerid, "~r~~h~Safe Door~n~~r~~h~Already Closed!", 3000, 3);
	        return 1;
	    }

	    // Animate the safe door closing (the small Z offset is required)
	    MoveObject(SafeDoorObject, 1230.225708, -806.648803, 1083.5 - 0.01, 0.005, 0, 0, 0);

	    // Set the safe door status
	    SafeDoorStatus = SAFE_DOOR_CLOSED;

	    // Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Safe Door Closed!", 3000, 3);

	    // Exit here
	    return 1;
	}

	// Exit here (return 0 as the command was not handled in this filterscript)
	return 0;
}

public OnFilterScriptInit()
{
    // Display information in the Server Console
	print("\n");
	print("  |---------------------------------------------------");
	print("  |--- Safe and Door Filterscript by Matite");
    print("  |--  Script v1.02");
    print("  |--  13th February 2015");
	print("  |---------------------------------------------------");

	// Create the safe object
    SafeObject = CreateObject(19618, 1230.646118, -806.418823, 1083.5, 0, 0, 0);
    
    // Display information in the Server Console
    print("  |--  Safe object created");
    
    // Create the safe door object
    SafeDoorObject = CreateObject(19619, 1230.225708, -806.648803, 1083.5 - 0.01, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  Safe door object created");
    print("  |---------------------------------------------------");
    
    // Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and is not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA safe object in Madd Dogg's Mansion office
            // (we do this now incase the filterscipt was loaded after the player joined)
			RemoveBuildingForPlayer(i, 2332, 1230.646118, -806.418823, 1083.5, 10.0);
        }
    }

    // Exit here
	return 1;
}

public OnFilterScriptExit()
{
	// Check for valid object
	if (IsValidObject(SafeObject))
	{
		// Destroy the safe object
		DestroyObject(SafeObject);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  Safe object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(SafeDoorObject))
	{
		// Destroy the safe door object
		DestroyObject(SafeDoorObject);

		// Display information in the Server Console
    	print("  |--  Safe door object destroyed");
    }

    // Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Safe and Door Filterscript Unloaded");
	print("  |---------------------------------------------------");

	// Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA safe object in Madd Dogg's Mansion office
	RemoveBuildingForPlayer(playerid, 2332, 1230.646118, -806.418823, 1083.5, 10.0);

	// Exit here
	return 1;
}

