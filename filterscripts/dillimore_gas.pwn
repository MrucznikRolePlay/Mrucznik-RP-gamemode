// -----------------------------------------------------------------------------
// Example Filterscript for the Dillimore Gas Station Objects
// ----------------------------------------------------------
// By Matite in March 2015
//
//
// This script creates the edited Dillimore Gas Station Building objects and
// removes the existing GTASA building objects.
//
// Warning...
// This script uses a total of:
// * 2 objects = 1 for the replacement building exterior object and 1 for the
//   the replacement building interior object
// * Enables the /dgs command to teleport the player to the Dillimore Gas Station
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

// Stores the created object numbers of the replacement building objects so
// they can be destroyed when the filterscript is unloaded
new DillimoreGasObject1; // Building exterior object
new DillimoreGasObject2; // Building interior object


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/dgs", cmdtext, true, 4) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle
		SetPlayerPos(playerid, 658.37, -573.90, 16.8);
		SetPlayerFacingAngle(playerid, 280);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Dillimore Gas Station!", 3000, 3);

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
	print("  |--- Dillimore Gas Station Filterscript");
    print("  |--  Script v1.01");
    print("  |--  3rd March 2015");
	print("  |---------------------------------------------------");

	// Create the Dillimore Gas Station exterior object
    DillimoreGasObject1 = CreateObject(19876, 666.711, -565.133, 17.3359, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  Dillimore Gas Station exterior object created");

    // Create the Dillimore Gas Station interior object
    DillimoreGasObject2 = CreateObject(19877, 666.492, -571.18, 17.3125, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  Dillimore Gas Station interior object created");
	print("  |---------------------------------------------------");

	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA Dillimore Gas Station Building exterior, interior
			// and LOD map objects for the player
            // (so any player currently ingame does not have to rejoin for them
			//  to be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 12853, 666.711, -565.133, 17.3359, 250.0); 	// Building exterior
			RemoveBuildingForPlayer(i, 12854, 666.492, -571.18, 17.3125, 250.0); 	// Building interior
			RemoveBuildingForPlayer(i, 13245, 666.711, -565.133, 17.3359, 250.0); 	// LOD
        }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(DillimoreGasObject1))
	{
		// Destroy the Dillimore Gas Station exterior object
		DestroyObject(DillimoreGasObject1);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  Dillimore Gas Station exterior object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(DillimoreGasObject2))
	{
		// Destroy the Dillimore Gas Station interior object
		DestroyObject(DillimoreGasObject2);

		// Display information in the Server Console
    	print("  |--  Dillimore Gas Station interior object destroyed");
    }

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Dillimore Gas Station Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA Dillimore Gas Station Building exterior, interior
	// and LOD map objects for the player
	RemoveBuildingForPlayer(playerid, 12853, 666.711, -565.133, 17.3359, 250.0); 	// Building exterior
	RemoveBuildingForPlayer(playerid, 12854, 666.492, -571.18, 17.3125, 250.0); 	// Building interior
	RemoveBuildingForPlayer(playerid, 13245, 666.711, -565.133, 17.3359, 250.0); 	// LOD

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

