// -----------------------------------------------------------------------------
// Example Filterscript for the LS Prison Walls and Gate Objects
// -------------------------------------------------------------
// By Matite in February 2015
//
//
// This script creates the new LS Prison Walls object, removes the existing
// GTASA object and creates 2 sets of opening gates.
//
// Warning...
// This script uses a total of:
// * 5 objects = 1 for the replacement walls and 4 for the replacement gates
// * 2 3D Text Labels = 1 on each set of gates
// * Enables the /lsp command to teleport the player to the eastern prison gates
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

// Used for the eastern and southern prison gates status flags
#define GATES_CLOSED  	0
#define GATES_CLOSING  	1
#define GATES_OPEN    	2
#define GATES_OPENING   3

// Used for messages sent to the player
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA


// -----------------------------------------------------------------------------
// Constants
// ---------

// Gate names for the 3D text labels
static GateNames[2][] =
{
	"Eastern Gates",
	"Southern Gates"
};


// -----------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object number of the replacement prison walls so it can
// be destroyed when the filterscript is unloaded
new LSPrisonWallsObject;

// Stores the created object numbers of the prison walls gates so they can be
// opened or closed and destroyed when the filterscript is unloaded
new LSPrisonGatesObject[4];

// Stores a reference to the 3D text labels used on each set of gates so they
// can be destroyed when the filterscript is unloaded
new Text3D:LabelGates[2];

// Stores the current status of the eastern prison gates
new EasternGatesStatus = GATES_CLOSED;

// Stores the current status of the southern prison gates
new SouthernGatesStatus = GATES_CLOSED;


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/lsp", cmdtext, true, 4) == 0)
	{
	    // Set the interior
		SetPlayerInterior(playerid, 0);

		// Set player position and facing angle
		SetPlayerPos(playerid, 1830.66 + random(2), -1538.46, 14.5);
		SetPlayerFacingAngle(playerid, 85);

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~LS Prison!", 3000, 3);

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
	print("  |--- LS Prison Walls Filterscript");
    print("  |--  Script v1.01");
    print("  |--  13th February 2015");
	print("  |---------------------------------------------------");

	// Create the LS Prison Walls object
    LSPrisonWallsObject = CreateObject(19794, 1787.13, -1565.68, 11.9688, 0, 0, 0);

    // Display information in the Server Console
    print("  |--  LS Prison Walls object created");
    
    // Create the LS Prison Walls Eastern Gates objects
    LSPrisonGatesObject[0] = CreateObject(19795, 1824.318481, -1534.731201, 14.296878 - 0.01, 0, 0, 343.0);
    LSPrisonGatesObject[1] = CreateObject(19795, 1822.407592, -1540.949951, 14.296878 - 0.01, 0, 0, 163.0);
    
    // Create the LS Prison Walls Southern Gates objects
    LSPrisonGatesObject[2] = CreateObject(19796, 1752.004150, -1591.186523, 14.267195 - 0.01, 0, 0, 77.0);
    LSPrisonGatesObject[3] = CreateObject(19796, 1756.914062, -1592.316284, 14.267195 - 0.01, 0, 0, 257.0);
    
    // Display information in the Server Console
    print("  |--  LS Prison Walls Gates objects created");

	// Create variable
	new string[192];

    // Create 3D Text Label at the prisons eastern gates
    format(string, sizeof(string), "{CCCCCC}[%s]\n{CCCCCC}Press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}' to open or close the gates", GateNames[0]);
    LabelGates[0] = Create3DTextLabel(string, 0xCCCCCCAA, 1823.78, -1537.98, 13.54, 10.5, 0, 1);
    
    // Create 3D Text Label at the prisons eastern gates
    format(string, sizeof(string), "{CCCCCC}[%s]\n{CCCCCC}Press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}' to open or close the gates", GateNames[1]);
    LabelGates[1] = Create3DTextLabel(string, 0xCCCCCCAA, 1754.27, -1592.18, 13.54, 10.5, 0, 1);
    
    // Display information in the Server Console
	print("  |--  LS Prison Wall Gates 3D Text Labels created");
	print("  |---------------------------------------------------");
	
	
	// Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA LS Prison Walls and LOD map objects for the player
            // (so any player currently ingame does not have to rejoin for them
			//  to be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 4000, 1787.13, -1565.68, 11.9688, 250.0); // Walls
			RemoveBuildingForPlayer(i, 4080, 1787.13, -1565.68, 11.9688, 250.0); // LOD
        }
    }

	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(LSPrisonWallsObject))
	{
		// Destroy the LS Prison Walls object
		DestroyObject(LSPrisonWallsObject);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  LS Prison Walls object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(LSPrisonGatesObject[0]))
	{
		// Destroy the LS Prison Walls Eastern Gates object 1
		DestroyObject(LSPrisonGatesObject[0]);

		// Display information in the Server Console
    	print("  |--  LS Prison Walls Eastern Gates object 1 destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(LSPrisonGatesObject[1]))
	{
		// Destroy the LS Prison Walls Eastern Gates object 2
		DestroyObject(LSPrisonGatesObject[1]);

		// Display information in the Server Console
    	print("  |--  LS Prison Walls Eastern Gates object 2 destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(LSPrisonGatesObject[2]))
	{
		// Destroy the LS Prison Walls Southern Gates object 1
		DestroyObject(LSPrisonGatesObject[2]);

		// Display information in the Server Console
    	print("  |--  LS Prison Walls Southern Gates object 1 destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(LSPrisonGatesObject[3]))
	{
		// Destroy the LS Prison Walls Southern Gates object 2
		DestroyObject(LSPrisonGatesObject[3]);

		// Display information in the Server Console
    	print("  |--  LS Prison Walls Southern Gates object 2 destroyed");
    }

    // Destroy 3D Text Labels on the eastern and southern gates
    Delete3DTextLabel(LabelGates[0]);
    Delete3DTextLabel(LabelGates[1]);
    
    // Display information in the Server Console
   	print("  |--  Deleted the 3D Text Labels on the Prison Gates");

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  LS Prison Walls Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA LS Prison Walls and LOD map objects for the player
	RemoveBuildingForPlayer(playerid, 4000, 1787.13, -1565.68, 11.9688, 250.0); // Walls
	RemoveBuildingForPlayer(playerid, 4080, 1787.13, -1565.68, 11.9688, 250.0); // LOD

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

public OnObjectMoved(objectid)
{
	// Check if the object that moved was one of the eastern gates
	if (objectid == LSPrisonGatesObject[0])
	{
	    // Check if the eastern gates were closing
	    if (EasternGatesStatus == GATES_CLOSING)
	    {
	        // Set status flag for eastern gates
		    EasternGatesStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for eastern gates
		    EasternGatesStatus = GATES_OPEN;
	    }
	}
	// Check if the object that moved was one of the southern gates
	else if (objectid == LSPrisonGatesObject[2])
	{
	    // Check if the southern gates were closing
	    if (SouthernGatesStatus == GATES_CLOSING)
	    {
	        // Set status flag for southern gates
		    SouthernGatesStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for southern gates
		    SouthernGatesStatus = GATES_OPEN;
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
		// Check if the player is outside the eastern prison gates
	    if (IsPlayerInRangeOfPoint(playerid, 10.0, 1823.78, -1537.98, 13.54))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Eastern Prison Gates", playerid);
	        
	        // Check if the eastern gates are not currently opening (ie moving)
	        if (EasternGatesStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gates to fully open first.");
	            return 1;
	        }
	        // Check if the eastern gates are not currently closing (ie moving)
	        else if (EasternGatesStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gates to fully close first.");
	            return 1;
	        }

	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 1823.78, -1537.98, 13.54);

	        // Check if the eastern gates are currently open or closed
	        if (EasternGatesStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Prison~n~~b~~h~Gates Opening!", 3000, 3);
		
		        // Animate the eastern gates opening (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[0], 1824.318481, -1534.731201, 14.296878 + 0.01, 0.002, 0, 0, 258);

				// Animate the eastern gates opening (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[1], 1822.407592, -1540.949951, 14.296878 + 0.01, 0.002, 0, 0, 253);

				// Set status flag for eastern gates
		    	EasternGatesStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Prison~n~~b~~h~Gates Closing!", 3000, 3);
				
		        // Animate the eastern gates closing (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[0], 1824.318481, -1534.731201, 14.296878 - 0.01, 0.002, 0, 0, 343);

				// Animate the eastern gates closing (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[1], 1822.407592, -1540.949951, 14.296878 - 0.01, 0.002, 0, 0, 163);

				// Set status flag for eastern gates
		    	EasternGatesStatus = GATES_CLOSING;
	    	}
	    }
	    // Check if the player is outside the southern prison gates
	    else if (IsPlayerInRangeOfPoint(playerid, 10.0, 1754.27, -1592.18, 13.54))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Southern Prison Gates", playerid);
	        
	        // Check if the southern gates are not currently opening (ie moving)
	        if (SouthernGatesStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the southern gates to fully open first.");
	            return 1;
	        }
	        // Check if the southern gates are not currently closing (ie moving)
	        else if (SouthernGatesStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the southern gates to fully close first.");
	            return 1;
	        }
	        
	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 1754.27, -1592.18, 13.54);
	        
	        // Check if the southern gates are currently open or closed
	        if (SouthernGatesStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Southern Prison~n~~b~~h~Gates Opening!", 3000, 3);

		        // Animate the southern gates opening (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[2], 1752.004150, -1591.186523, 14.267195 + 0.01, 0.002, 0, 0, 172);

		    	// Animate the southern gates opening (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[3], 1756.914062, -1592.316284, 14.267195 + 0.01, 0.002, 0, 0, 187);

		    	// Set status flag for southern gates
		    	SouthernGatesStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Southern Prison~n~~b~~h~Gates Closing!", 3000, 3);

		        // Animate the southern gates closing (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[2], 1752.004150, -1591.186523, 14.267195 - 0.01, 0.002, 0, 0, 77);

		    	// Animate the southern gates closing (the small Z offset is required)
		    	MoveObject(LSPrisonGatesObject[3], 1756.914062, -1592.316284, 14.267195 - 0.01, 0.002, 0, 0, 257);

		    	// Set status flag for southern gates
		    	SouthernGatesStatus = GATES_CLOSING;
	    	}
	    }
	}

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

