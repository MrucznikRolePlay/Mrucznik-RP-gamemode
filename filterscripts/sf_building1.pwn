// -----------------------------------------------------------------------------
// Example Filterscript for the new SF Building 1
// ----------------------------------------------
// By Matite in February 2015
//
//
// This script creates the new SF Building 1 object and removes the existing
// GTASA building object.
//
// Warning...
// This script uses a total of:
// * 3 objects = 1 for the replacement land object, 1 for the outside object
//   and 1 for the inside object
// * Enables the /sfb command to teleport the player to the SF Building 1
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
new SFBuilding1Object1; // Land object
new SFBuilding1Object2; // Outside object
new SFBuilding1Object3; // Inside object


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/sfb", cmdtext, true, 4) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle
		SetPlayerPos(playerid, -2706.56, 870.91 + random(2), 71.86);
		SetPlayerFacingAngle(playerid, 180);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~SF Building!", 3000, 3);

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
	print("  |--- SF Building 1 Filterscript");
    print("  |--  Script v1.01");
    print("  |--  10th February 2015");
	print("  |---------------------------------------------------");

	// Create the SF Building 1 Land object
    SFBuilding1Object1 = CreateObject(19600, -2719.02, 861.211, 72.1562, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  SF Building 1 Land object created");

    // Create the SF Building 1 Outside object
    SFBuilding1Object2 = CreateObject(19598, -2719.02, 861.211, 72.1562, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  SF Building 1 Outside object created");
    
    // Create the SF Building 1 Inside object
    SFBuilding1Object3 = CreateObject(19599, -2719.02, 861.211, 72.1562, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  SF Building 1 Inside object created");
	print("  |---------------------------------------------------");

	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA SF Building and LOD map objects for the player
            // (so any player currently ingame does not have to rejoin for them
			//  to be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 9510, -2719.02, 861.211, 72.1562, 250.0); // Building
			RemoveBuildingForPlayer(i, 9671, -2719.02, 861.211, 72.1562, 250.0); // LOD
			RemoveBuildingForPlayer(i, 715, -2693.24, 852.60, 71.74, 8.0); // Tree (casts a shadow inside)
        }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(SFBuilding1Object1))
	{
		// Destroy the SF Building 1 Land object
		DestroyObject(SFBuilding1Object1);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  SF Building 1 Land object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(SFBuilding1Object2))
	{
		// Destroy the SF Building 1 Outside object
		DestroyObject(SFBuilding1Object2);

		// Display information in the Server Console
    	print("  |--  SF Building 1 Outside object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(SFBuilding1Object3))
	{
		// Destroy the SF Building 1 Inside object
		DestroyObject(SFBuilding1Object3);

		// Display information in the Server Console
    	print("  |--  SF Building 1 Inside object destroyed");
    }

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  SF Building 1 Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA SF Building and LOD map objects for the player
	RemoveBuildingForPlayer(playerid, 9510, -2719.02, 861.211, 72.1562, 250.0); // Building
	RemoveBuildingForPlayer(playerid, 9671, -2719.02, 861.211, 72.1562, 250.0); // LOD
	RemoveBuildingForPlayer(playerid, 715, -2693.24, 852.60, 71.74, 8.0); // Tree (casts a shadow inside)

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

