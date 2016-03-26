// -----------------------------------------------------------------------------
// Example Filterscript for the new Modular Island Objects
// -------------------------------------------------------
// By Matite in January 2015
//
// This script creates a Modular Island just off the coast in SF (next to the
// docks near the hospital).
//
// Warning...
// This script uses a total of 87 player objects
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP Include
#include <a_samp>

// -----------------------------------------------------------------------------
// Callbacks
// ---------

// Un-comment the OnPlayerCommandText callback below (remove the "/*" and the "*/")
// to enable a simple teleport command (/mi) which teleports the player to
// the modular island in SF.

/*
public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/mi", cmdtext, true, 3) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle
		SetPlayerPos(playerid, -3343.57 + random(2), 194.34 + random(2), 6.2);
		SetPlayerFacingAngle(playerid, 315);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Modular Island!", 3000, 3);

	    // Exit here
	    return 1;
	}

	// Exit here (return 0 as the command was not handled in this filterscript)
	return 0;
}
*/

public OnFilterScriptInit()
{
    // Display information in the Server Console
	print("\n");
	print("  |---------------------------------------------------");
	print("  |--- Modular Island Filterscript by Matite");
    print("  |--  Script v1.01");
    print("  |--  12th January 2015");
	print("  |---------------------------------------------------");
	
	// Loop
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
	    	// Create modular island objects for the player
	    	// (so any player currently ingame does not have to rejoin for them
			//  to appear when this filterscript is loaded)
			CreateMIObjects(i);
		}
	}

    // Exit here
	return 1;
}

public OnFilterScriptExit()
{
	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Modular Island Filterscript Unloaded");
	print("  |---------------------------------------------------");

	// Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
	// Create modular island objects for the player
	CreateMIObjects(playerid);

	// Exit here
	return 1;
}

CreateMIObjects(playerid)
{
    // Create modular island player objects (with draw distance of 599m)
    CreatePlayerObject(playerid,19529,-3130.000000,0.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19530,-3130.000000,140.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19531,-3130.000000,280.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3130.000000,70.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3130.000000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19533,-3238.750000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19534,-3200.000000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3200.000000,280.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19534,-3200.000000,70.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3200.000000,140.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19534,-3200.000000,70.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3200.000000,0.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3277.500000,210.000000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3277.500000,140.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3277.500000,280.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3277.500000,0.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3277.500000,70.000000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19533,-3238.750000,70.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19536,-3238.750000,0.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19537,-3238.750000,140.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19538,-3238.750000,280.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3052.500000,0.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3052.500000,70.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3060.000000,70.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3060.000000,0.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3060.000000,140.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3060.000000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3060.000000,280.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3052.500000,140.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3052.500000,210.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3052.500000,280.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3052.500000,-62.500000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3060.000000,-62.500000,4.000000,0.000000,0.000000,-90.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3130.000000,-62.500000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3200.000000,-62.500000,4.000000,0.000000,0.000000,-90.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3238.750000,-62.500000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3277.500000,-62.500000,4.000000,0.000000,0.000000,-90.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3285.000000,-62.500000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3410.000488,0.000000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3285.000000,70.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3316.250000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19546,-3285.000000,202.500000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3472.500000,342.500000,4.000000,0.000000,0.000000,450.000000, 599.0);
	CreatePlayerObject(playerid,19546,-3285.000000,0.000000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19546,-3285.000000,0.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3410.000000,0.000000,4.000000,0.000000,0.000000,450.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3472.500000,0.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3472.500000,0.000000,4.000000,0.000000,0.000000,450.000000, 599.0);
	CreatePlayerObject(playerid,19547,-3347.500000,280.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3285.000000,108.750000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3410.000000,202.500000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3378.750000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3441.250000,210.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19536,-3441.250000,280.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3472.500000,202.500000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3472.500000,265.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3472.500000,335.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3410.000000,342.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3277.500000,350.000000,4.000000,0.000000,0.000000,270.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3200.000000,350.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19535,-3060.000000,350.000000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19532,-3130.000000,350.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19533,-3238.750000,350.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19546,-3285.000000,342.500000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3285.000000,482.500000,4.000000,0.000000,0.000000,450.000000, 599.0);
	CreatePlayerObject(playerid,19542,-3222.500000,482.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19536,-3238.750000,420.000000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3285.000000,412.500000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3052.500000,350.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19540,-3052.500000,482.500000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3052.500000,388.750000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3083.750000,482.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3122.500000,482.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3137.500000,482.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19541,-3152.500000,482.500000,4.000000,0.000000,0.000000,90.000000, 599.0);
	CreatePlayerObject(playerid,19529,-3130.000000,420.000000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3277.500000,388.750000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3277.500000,451.250000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3200.000000,388.750000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3200.000000,451.250000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3060.000000,388.750000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19543,-3060.000000,451.250000,4.000000,0.000000,0.000000,0.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3285.000000,451.250000,4.000000,0.000000,0.000000,180.000000, 599.0);
	CreatePlayerObject(playerid,19539,-3052.500000,451.250000,4.000000,0.000000,0.000000,0.000000, 599.0);
	
	// Exit here
	return 1;
}

