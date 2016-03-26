// -----------------------------------------------------------------------------
// Example Filterscript for the new SA-MP Animations
// -------------------------------------------------
// By Matite in January 2015
//
// This script tests the new SA-MP animation/pose inside the SAMP.ifp file.
//
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP include
#include <a_samp>

// ------------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/fish", cmdtext, true, 5) == 0)
	{
		// Apply animation
		ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 1, 1, 1, 1);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Fishing Animation Pose!", 3000, 3);

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
	print("  |--- SA-MP Animations Filterscript by Matite");
    print("  |--  Script v1.01");
    print("  |--  12th January 2015");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnFilterScriptExit()
{
	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  SA-MP Animations Filterscript Unloaded");
	print("  |---------------------------------------------------");

	// Exit here
	return 1;
}

