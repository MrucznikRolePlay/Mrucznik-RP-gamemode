// -----------------------------------------------------------------------------
// Example Filterscript for the Area 51 (69) Base Objects
// ------------------------------------------------------
// By Matite in March 2015
//
//
// This script removes the existing GTASA Area 51 (69) land section, fence and
// buildings. It then replaces the land section and buildings with the new
// enterable versions. It also replaces the perimeter fence and adds two
// gates that can be opened or closed.
//
// Warning...
// This script uses a total of:
// * 11 objects = 1 for the replacement land object, 7 for the replacement
//   building objects, 1 for the outer fence and 2 for the gates
// * Enables the /a51 command to teleport the player to the Area 51 (69) Base
// * 2 3D Text Labels = 1 on each gate
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP include
#include <a_samp>

// For PlaySoundForPlayersInRange()
#include "../include/gl_common.inc"


// -----------------------------------------------------------------------------
// Defines
// -------

// Used for messages sent to the player
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA

// Used for the northern and eastern A51 (69) gates status flags
#define GATES_CLOSED  	0
#define GATES_CLOSING  	1
#define GATES_OPEN    	2
#define GATES_OPENING   3


// -----------------------------------------------------------------------------
// Constants
// ---------

// Gate names for the 3D text labels
static GateNames[2][] =
{
	"Northern Gate",
	"Eastern Gate"
};

// -----------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object numbers of the replacement Area 51 (69) land object,
// buildings and fence so they can be destroyed when the filterscript is unloaded
new A51LandObject; 		// Land object
new A51Buildings[7]; 	// Building object
new A51Fence;           // Fence
new A51NorthernGate;    // Northern Gate
new A51EasternGate;     // Eastern Gate

// Stores a reference to the 3D text labels used on each set of gates so they
// can be destroyed when the filterscript is unloaded
new Text3D:LabelGates[2];

// Stores the current status of the northern gate
new NorthernGateStatus = GATES_CLOSED;

// Stores the current status of the eastern gate
new EasternGateStatus = GATES_CLOSED;


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/a51", cmdtext, true, 4) == 0)
	{
	    // Set the interior (outside)
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle (outside the northern gate)
		SetPlayerPos(playerid, 135.20, 1948.51, 19.74);
		SetPlayerFacingAngle(playerid, 180);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Area 51 (69) Base!", 3000, 3);

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
	print("  |--- Area 51 (69) Building Objects Filterscript");
    print("  |--  Script v1.01");
    print("  |--  28th March 2015");
	print("  |---------------------------------------------------");

	// Create the A51 Land object
    A51LandObject = CreateObject(11692, 199.344, 1943.79, 18.2031, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  Area 51 (69) Land object created");
    
    // Create the A51 Fence object
    A51Fence = CreateObject(19312, 191.141, 1870.04, 21.4766, 0, 0, 0);
    
    // Display information in the Server Console
    print("  |--  Area 51 (69) Fence object created");
    
    // Create the A51 Building objects
    A51Buildings[0] = CreateObject(19905, 206.798950, 1931.643432, 16.450595, 0, 0, 0);
    A51Buildings[1] = CreateObject(19905, 188.208908, 1835.033569, 16.450595, 0, 0, 0);
    A51Buildings[2] = CreateObject(19905, 230.378875, 1835.033569, 16.450595, 0, 0, 0);
    A51Buildings[3] = CreateObject(19907, 142.013977, 1902.538085, 17.633581, 0, 0, 270.0);
    A51Buildings[4] = CreateObject(19907, 146.854003, 1846.008056, 16.533580, 0, 0, 0);
    A51Buildings[5] = CreateObject(19909, 137.900390, 1875.024291, 16.836734, 0, 0, 270.0);
    A51Buildings[6] = CreateObject(19909, 118.170387, 1875.184326, 16.846735, 0, 0, 0);
    

    // Display information in the Server Console
    print("  |--  Area 51 (69) Building objects created");

    // Create the Northern gate object
    A51NorthernGate = CreateObject(19313, 134.545074, 1941.527709, 21.691408, 0, 0, 180.0);

    // Create the Eastern gate object
    A51EasternGate = CreateObject(19313, 286.008666, 1822.744628, 20.010623, 0, 0, 90.0);

    // Display information in the Server Console
    print("  |--  Area 51 (69) Gate objects created");

	// Create variable
	new string[192];

    // Create 3D Text Label at the prisons eastern gates
    format(string, sizeof(string), "{CCCCCC}[%s]\n{CCCCCC}Press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}' to open or close the gate", GateNames[0]);
    LabelGates[0] = Create3DTextLabel(string, 0xCCCCCCAA, 135.09, 1942.37, 19.82, 10.5, 0, 0);

    // Create 3D Text Label at the prisons eastern gates
    format(string, sizeof(string), "{CCCCCC}[%s]\n{CCCCCC}Press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}' to open or close the gate", GateNames[1]);
    LabelGates[1] = Create3DTextLabel(string, 0xCCCCCCAA, 287.12, 1821.51, 18.14, 10.5, 0, 0);

    // Display information in the Server Console
	print("  |--  Area 51 (69) Gates 3D Text Labels created");
	print("  |---------------------------------------------------");

	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA Area 51 (69) land and buildings for the player
			// (so any player currently ingame does not have to rejoin for them to
			// be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 16203, 199.344, 1943.79, 18.2031, 250.0); 	// Land
			RemoveBuildingForPlayer(i, 16590, 199.344, 1943.79, 18.2031, 250.0); 	// Land LOD
			RemoveBuildingForPlayer(i, 16323, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings
            RemoveBuildingForPlayer(i, 16619, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings LOD
            RemoveBuildingForPlayer(i, 1697, 228.797, 1835.34, 23.2344, 250.0); 	// Solar Panels (they poke through the roof inside)
            RemoveBuildingForPlayer(i, 16094, 191.141, 1870.04, 21.4766, 250.0); 	// Outer Fence
	    }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(A51LandObject))
	{
		// Destroy the A51 land object
		DestroyObject(A51LandObject);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  Area 51 (69) Land object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51Fence))
	{
		// Destroy the A51 fence object
		DestroyObject(A51Fence);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Fence object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51NorthernGate))
	{
		// Destroy the A51 northern gate object
		DestroyObject(A51NorthernGate);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Northern Gate object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51EasternGate))
	{
		// Destroy the A51 eastern gate object
		DestroyObject(A51EasternGate);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Eastern Gate object destroyed");
    }
    
    // Loop
    for (new i = 0; i < sizeof(A51Buildings); i++)
    {
	    // Check for valid object
		if (IsValidObject(A51Buildings[i]))
		{
			// Destroy the A51 building object
			DestroyObject(A51Buildings[i]);

			// Display information in the Server Console
		   	printf("  |--  Area 51 (69) Building object %d destroyed", i + 1);
	    }
    }
    
    // Destroy 3D Text Labels on the northern and eastern gates
    Delete3DTextLabel(LabelGates[0]);
    Delete3DTextLabel(LabelGates[1]);

    // Display information in the Server Console
   	print("  |--  Deleted the 3D Text Labels on the Area 51 (69) Gates");

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Area 51 (69) Base Objects Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA Area 51 (69) land and buildings for the player
	RemoveBuildingForPlayer(playerid, 16203, 199.344, 1943.79, 18.2031, 250.0); 	// Land
	RemoveBuildingForPlayer(playerid, 16590, 199.344, 1943.79, 18.2031, 250.0); 	// Land LOD
	RemoveBuildingForPlayer(playerid, 16323, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings
    RemoveBuildingForPlayer(playerid, 16619, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings LOD
    RemoveBuildingForPlayer(playerid, 1697, 228.797, 1835.34, 23.2344, 250.0); 		// Solar Panels (they poke through the roof inside)
    RemoveBuildingForPlayer(playerid, 16094, 191.141, 1870.04, 21.4766, 250.0); 	// Outer Fence

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

public OnObjectMoved(objectid)
{
    // Check if the object that moved was the northern gate
	if (objectid == A51NorthernGate)
	{
	    // Check if the northern gate was closing
	    if (NorthernGateStatus == GATES_CLOSING)
	    {
	        // Set status flag for northern gates
		    NorthernGateStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for northern gates
		    NorthernGateStatus = GATES_OPEN;
	    }
	}
	// Check if the object that moved was the eastern gate
	else if (objectid == A51EasternGate)
	{
	    // Check if the eastern gate was closing
	    if (EasternGateStatus == GATES_CLOSING)
	    {
	        // Set status flag for eastern gate
		    EasternGateStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for eastern gate
		    EasternGateStatus = GATES_OPEN;
	    }
	}

	// Exit here
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// Check if the player pressed the conversation yes key (normally the Y key)
	if (newkeys & KEY_YES)
	{
		// Check if the player is near the eastern A51 gate
	    if (IsPlayerInRangeOfPoint(playerid, 10.0, 287.12, 1821.51, 18.14))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Eastern A51 Gate", playerid);

	        // Check if the eastern gate is currently opening (ie moving)
	        if (EasternGateStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gate to fully open first.");
	            return 1;
	        }
	        // Check if the eastern gate is currently closing (ie moving)
	        else if (EasternGateStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gate to fully close first.");
	            return 1;
	        }

	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 287.12, 1821.51, 18.14);

	        // Check if the eastern gate is currently closed
	        if (EasternGateStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Gate Opening!", 3000, 3);

		        // Animate the eastern gate opening
		    	MoveObject(A51EasternGate, 286.008666, 1833.744628, 20.010623, 1.1, 0, 0, 90);

				// Set status flag for eastern gate
		    	EasternGateStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Gate Closing!", 3000, 3);

		        // Animate the eastern gates closing
		    	MoveObject(A51EasternGate, 286.008666, 1822.744628, 20.010623, 1.1, 0, 0, 90);

				// Set status flag for eastern gate
		    	EasternGateStatus = GATES_CLOSING;
	    	}
	    }
	    // Check if the player is near the northern A51 gate
	    else if (IsPlayerInRangeOfPoint(playerid, 10.0, 135.09, 1942.37, 19.82))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Northern A51 Gate", playerid);

	        // Check if the northern gate is currently opening (ie moving)
	        if (NorthernGateStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the northern gate to fully open first.");
	            return 1;
	        }
	        // Check if the northern gates is currently closing (ie moving)
	        else if (NorthernGateStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the northern gate to fully close first.");
	            return 1;
	        }

	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 135.09, 1942.37, 19.82);

	        // Check if the northern gate is currently closed
	        if (NorthernGateStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Northern Gate Opening!", 3000, 3);

		        // Animate the northern gates opening
		    	MoveObject(A51NorthernGate, 121.545074, 1941.527709, 21.691408, 1.3, 0, 0, 180);

		    	// Set status flag for northern gates
		    	NorthernGateStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Northern Gate Closing!", 3000, 3);

		        // Animate the northern gates closing
		    	MoveObject(A51NorthernGate, 134.545074, 1941.527709, 21.691408, 1.3, 0, 0, 180);

		    	// Set status flag for northern gates
		    	NorthernGateStatus = GATES_CLOSING;
	    	}
	    }
	}

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

