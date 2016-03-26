// -----------------------------------------------------------------------------
// Example Filterscript for the LS Wells Fargo Building Object
// -----------------------------------------------------------
// By Matite in March 2015
//
//
// This script creates the edited LS Wells Fargo Building object and
// removes the existing GTASA building object.
//
// Warning...
// This script uses a total of:
// * 1 object = 1 for the replacement building object
// * Enables the /lswf command to teleport the player to the LS Wells Fargo Building
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

// Stores the created object number of the replacement building object so
// it can be destroyed when the filterscript is unloaded
new LSWellsFargoObject1; // Building object


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/lswf", cmdtext, true, 5) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle
		SetPlayerPos(playerid, 1448.43, -1468.28, 13.82);
		SetPlayerFacingAngle(playerid, 92);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~LS Wells Fargo!", 3000, 3);

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
	print("  |--- LS Wells Fargo Building Filterscript");
    print("  |--  Script v1.01");
    print("  |--  6th March 2015");
	print("  |---------------------------------------------------");

	// Create the LS Wells Fargo Building object
    LSWellsFargoObject1 = CreateObject(19879, 1421.38, -1477.6, 42.2031, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  LS Wells Fargo Building object created");
	print("  |---------------------------------------------------");

	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA Wells Fargo Building and LOD map objects for the player
            // (so any player currently ingame does not have to rejoin for them
			//  to be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 4007, 1421.38, -1477.6, 42.2031, 250.0); 	// Building
			RemoveBuildingForPlayer(i, 4009, 1421.38, -1477.6, 42.2031, 250.0); 	// LOD
        }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(LSWellsFargoObject1))
	{
		// Destroy the Wells Fargo Building object
		DestroyObject(LSWellsFargoObject1);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  LS Wells Fargo Building object destroyed");
    }

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  LS Wells Fargo Building Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA Wells Fargo Building and LOD map objects for the player
	RemoveBuildingForPlayer(playerid, 4007, 1421.38, -1477.6, 42.2031, 250.0); 	// Building
	RemoveBuildingForPlayer(playerid, 4009, 1421.38, -1477.6, 42.2031, 250.0); 	// LOD

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

