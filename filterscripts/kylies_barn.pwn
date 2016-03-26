// -----------------------------------------------------------------------------
// Example Filterscript for Kylie's Barn Object
// --------------------------------------------
// By Matite in March 2015
//
//
// This script creates the repaired Kylie's Barn Building object and removes
// the existing GTASA barn object (normally this object has some collision
// bugs that prevent the player from moving about inside it).
//
// Warning...
// This script uses a total of:
// * 1 object = 1 for the replacement barn object
// * Enables the /kb command to teleport the player to Kylie's Barn
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP include
#include <a_samp>


// -----------------------------------------------------------------------------
// Defines
// -------

// Used for messages sent to the player
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA


// -----------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object number of the replacement barn object so
// it can be destroyed when the filterscript is unloaded
new KyliesBarnObject1; // Barn object


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/kb", cmdtext, true, 3) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 3);

		// Set player position and facing angle
		SetPlayerPos(playerid, 292.03, 309.82, 999.55);
		SetPlayerFacingAngle(playerid, 88);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Kylie's Barn!", 3000, 3);

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
	print("  |--- Kylie's Barn Filterscript");
    print("  |--  Script v1.01");
    print("  |--  6th March 2015");
	print("  |---------------------------------------------------");

	// Create Kylie's Barn repaired object
    KyliesBarnObject1 = CreateObject(19881, 286.188, 307.609, 1002.01, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  Kylie's Barn object created");
	print("  |---------------------------------------------------");

	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA Kylie's Barn object for the player (so any
            // player currently ingame does not have to rejoin for them to be
			// removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 14871, 286.188, 307.609, 1002.01, 250.0); 	// Barn
	    }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(KyliesBarnObject1))
	{
		// Destroy the Kylie's Barn object
		DestroyObject(KyliesBarnObject1);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  Kylie's Barn object destroyed");
    }

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Kylie's Barn Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA Kylie's Barn object for the player
	RemoveBuildingForPlayer(playerid, 14871, 286.188, 307.609, 1002.01, 250.0); 	// Barn

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

