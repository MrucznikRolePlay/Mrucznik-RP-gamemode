// -----------------------------------------------------------------------------
// Example Filterscript for the new Modular House Objects
// ------------------------------------------------------
// By Matite in February 2015
//
// This script creates a Modular Island with Modular Houses just off the coast
// in SF (near Jizzy's Nightclub).
//
// Warning...
// This script uses a total of 205 player objects and enables the /mh teleport
// command by default.
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

// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{
	// Check command text
	if (strcmp("/mh", cmdtext, true, 3) == 0)
	{
	    // Set the player interior
		SetPlayerInterior(playerid, 0);
		
		// Check if the player is in any vehicle
		if (IsPlayerInAnyVehicle(playerid))
		{
		    // In a Vehicle
		    // ------------
		    
		    // Set vehicle position and facing angle
		    SetVehiclePos(GetPlayerVehicleID(playerid), -3305.72 + random(2), 1602.27 + random(2), 6.2);
		    SetVehicleZAngle(GetPlayerVehicleID(playerid), 233);

			// Link vehicle to interior
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
		}
		else
		{
		    // On Foot
		    // -------
		    
			// Set player position and facing angle
			SetPlayerPos(playerid, -3305.72 + random(2), 1602.27 + random(2), 6.2);
			SetPlayerFacingAngle(playerid, 233);
		}

		// Fix camera position after teleporting
		SetCameraBehindPlayer(playerid);

		// Send a gametext message to the player
		GameTextForPlayer(playerid, "~b~~h~Modular Houses!", 3000, 3);

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
	print("  |--- Modular Houses Filterscript by Matite");
    print("  |--  Script v1.01");
    print("  |--  28th February 2015");
	print("  |---------------------------------------------------");
	
	// Loop
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
	    	// Create modular houses and island objects for the player
	    	// (so any player currently ingame does not have to rejoin for them
			//  to appear when this filterscript is loaded)
			CreateMHObjects(i);
		}
	}

    // Exit here
	return 1;
}

public OnFilterScriptExit()
{
	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Modular Houses Filterscript Unloaded");
	print("  |---------------------------------------------------");

	// Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
	// Create modular houses and island objects for the player
	CreateMHObjects(playerid);

	// Exit here
	return 1;
}

CreateMHObjects(playerid)
{
	// Create variable
	new TempObjectNumber;

	// Create modular houses and island player objects (with draw distance of 999m)
	CreatePlayerObject(playerid,19867,-3233.1538,1472.8060,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19849,-3250.0000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19539,-3343.1260,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19855,-3250.0000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19854,-3250.0000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19856,-3250.0000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19851,-3218.7495,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19850,-3281.2505,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-3234.3757,1461.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19852,-3187.4990,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19853,-3187.4993,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19850,-3218.7498,1562.5000,4.0000,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19850,-3250.0002,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19532,-3304.3760,1531.2500,4.0000,-0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-3164.3757,1531.2500,4.0000,-0.0000,0.0000,0.0000,999.0);

    // Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3218.7500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 5520, "BDupsHouse_LAe", "shingles3", 0);
	
	CreatePlayerObject(playerid,19855,-3218.7500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19856,-3218.7500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19856,-3187.5000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19855,-3187.5000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);

    // Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3187.5000,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 5986, "chateau_lawn", "chatshade02_law", 0);
	
	CreatePlayerObject(playerid,19856,-3281.2500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19855,-3281.2500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);

    // Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3281.2500,1500.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 6284, "bev_law2", "shinglegrey_la", 0);
	
	CreatePlayerObject(playerid,19849,-3281.2507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);

    // Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3281.2507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 6283, "pierb_law2", "rooftiles2", 0);
	
	CreatePlayerObject(playerid,19855,-3281.2507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19856,-3281.2507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19532,-3234.3757,1601.2500,4.0000,0.0000,0.0000,90.0000,999.0);

    // Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3250.0007,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 13721, "mulhousclahills", "sjmlahus26", 0);
	
	CreatePlayerObject(playerid,19855,-3250.0007,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19856,-3250.0007,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19856,-3218.7507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);

	// Create exterior building object and change roof tile texture
	TempObjectNumber = CreatePlayerObject(playerid,19854,-3218.7507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	SetPlayerObjectMaterial(playerid, TempObjectNumber, 0, 3484, "vegashse5", "shingles1", 0);
	
	CreatePlayerObject(playerid,19855,-3218.7507,1562.5000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19542,-3031.8757,1531.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19529,-3094.3757,1531.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19536,-3343.1260,1531.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19542,-3374.3760,1531.2500,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19532,-3094.3757,1461.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19788,-3304.3760,1461.2500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19532,-3094.3757,1601.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19535,-3164.3757,1601.2500,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19788,-3304.3760,1601.2500,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19541,-3031.8757,1461.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19541,-3031.8757,1601.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19541,-3374.3760,1601.2500,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19541,-3374.3760,1461.2500,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19543,-3343.1260,1461.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19543,-3343.1260,1601.2500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19542,-3094.3757,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19542,-3234.3757,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-3304.3760,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19541,-3164.3757,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19540,-3031.8757,1608.7500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-3374.3760,1608.7500,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19529,-3094.3757,1391.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19534,-3164.3757,1461.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19532,-3164.3757,1391.2500,4.0000,-0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19529,-3234.3757,1391.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-3304.3757,1422.5000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19543,-3304.3757,1360.0000,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19542,-3234.3757,1328.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-3094.3757,1328.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19542,-3031.8757,1391.2500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19540,-3031.8757,1328.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,-3164.3757,1328.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19541,-3304.3757,1328.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19546,-3311.8757,1453.7500,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19539,-3311.8757,1360.0000,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19540,-3311.8757,1328.7500,4.0000,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19540,-3374.3760,1453.7500,4.0000,0.0000,0.0000,180.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1471.3014,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1476.3118,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1481.3260,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1486.3364,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1506.3838,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1501.3734,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1491.3488,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1496.3591,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1511.3954,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1516.4058,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1521.4200,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1526.4304,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1531.4427,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1536.4531,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1541.4674,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1546.4778,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1551.4934,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1556.5038,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1561.5181,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1566.5284,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1571.5409,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1576.5511,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1581.5654,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8906,1586.5758,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19865,-3171.8921,1591.2007,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19866,-3265.6252,1479.1422,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19866,-3265.6252,1474.1422,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19866,-3234.3748,1474.1422,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19866,-3234.3748,1479.1422,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19867,-3295.6548,1472.8060,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19867,-3264.4043,1472.8060,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,877,-3217.8623,1518.8107,5.6301,0.0000,0.0000,-46.0000,999.0);
	CreatePlayerObject(playerid,19867,-3201.9033,1472.8060,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19867,-3204.3455,1589.6940,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19867,-3235.5959,1589.6940,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19867,-3266.8464,1589.6940,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19857,-3282.5649,1489.4465,5.9775,0.0000,0.0000,85.0000,999.0);
	CreatePlayerObject(playerid,19858,-3251.3149,1489.4470,5.9780,0.0000,0.0000,85.0000,999.0);
	CreatePlayerObject(playerid,19859,-3220.0649,1489.4470,5.9780,0.0000,0.0000,85.0000,999.0);
	CreatePlayerObject(playerid,19860,-3188.8149,1489.4470,5.9780,0.0000,0.0000,85.0000,999.0);
	CreatePlayerObject(playerid,19857,-3217.4358,1573.0535,5.9775,0.0000,0.0000,-95.0000,999.0);
	CreatePlayerObject(playerid,19859,-3248.6858,1573.0535,5.9780,0.0000,0.0000,-95.0000,999.0);
	CreatePlayerObject(playerid,19860,-3279.9358,1573.0535,5.9780,0.0000,0.0000,-95.0000,999.0);
	CreatePlayerObject(playerid,19861,-3272.7583,1481.9060,6.4885,-85.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19862,-3241.5083,1483.8816,6.4880,-90.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19863,-3210.2583,1483.8196,6.4880,-90.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19864,-3179.0083,1483.8199,6.4880,-90.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19861,-3227.2424,1580.5940,6.4885,-85.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19862,-3258.4924,1578.5750,6.4635,-90.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19863,-3289.7424,1578.5652,6.4880,-90.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19868,-3315.4624,1593.7500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1591.1295,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1585.8579,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1580.5906,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1564.7810,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1570.0482,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3312.8430,1575.3198,4.0000,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3326.0046,1593.7500,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,19868,-3315.4624,1562.1616,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19868,-3326.0046,1562.1616,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1564.7810,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1570.0482,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1575.3198,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1580.5906,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1585.8579,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3328.6240,1591.1295,4.0000,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,19868,-3320.7344,1562.1616,4.0000,0.0000,0.0000,-180.0000,999.0);
	CreatePlayerObject(playerid,1226,-3296.4019,1467.9758,7.8744,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3265.6252,1467.9758,7.8744,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3234.3757,1467.9758,7.8744,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3203.1243,1467.9758,7.8744,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3172.1250,1467.9758,7.8744,0.0000,0.0000,90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3204.2439,1594.5591,7.8744,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3234.3757,1594.5591,7.8744,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3265.6255,1594.5591,7.8744,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3296.7024,1594.5591,7.8744,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3172.4277,1594.5591,7.8744,0.0000,0.0000,-90.0000,999.0);
	CreatePlayerObject(playerid,1226,-3314.0095,1563.0968,7.8744,0.0000,0.0000,-45.0000,999.0);
	CreatePlayerObject(playerid,1226,-3327.6401,1563.3578,7.8744,0.0000,0.0000,-135.0000,999.0);
	CreatePlayerObject(playerid,1226,-3327.4702,1592.8082,7.8744,0.0000,0.0000,135.0000,999.0);
	CreatePlayerObject(playerid,1226,-3313.7534,1592.6093,7.8744,0.0000,0.0000,45.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1460.1271,8.1565,0.0000,0.0000,-136.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1478.6985,8.1565,0.0000,0.0000,-178.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1497.2699,8.1565,0.0000,0.0000,166.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1515.8413,8.1565,0.0000,0.0000,128.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1534.4127,8.1565,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,762,-3321.2837,1552.9843,8.1565,0.0000,0.0000,37.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1484.2739,8.1565,0.0000,0.0000,-136.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1502.8453,8.1565,0.0000,0.0000,-178.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1521.4167,8.1565,0.0000,0.0000,166.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1539.9882,8.1565,0.0000,0.0000,128.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1558.5596,8.1565,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,762,-3141.8879,1577.1311,8.1565,0.0000,0.0000,37.0000,999.0);
	CreatePlayerObject(playerid,759,-3174.4050,1591.4492,4.0000,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,759,-3202.9797,1478.9318,4.0000,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,759,-3293.6179,1528.0867,4.0000,0.0000,0.0000,-142.0000,999.0);
	CreatePlayerObject(playerid,759,-3268.6069,1528.0867,4.0000,0.0000,0.0000,-81.0000,999.0);
	CreatePlayerObject(playerid,759,-3280.7466,1528.0867,4.0000,0.0000,0.0000,-38.0000,999.0);
	CreatePlayerObject(playerid,759,-3287.2175,1528.0867,4.0000,0.0000,0.0000,11.0000,999.0);
	CreatePlayerObject(playerid,759,-3274.6274,1528.0867,4.0000,0.0000,0.0000,63.0000,999.0);
	CreatePlayerObject(playerid,808,-3234.3008,1584.7771,5.5884,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,808,-3206.2786,1528.3306,5.5884,0.0000,0.0000,-122.0000,999.0);
	CreatePlayerObject(playerid,808,-3231.6143,1528.3306,5.5884,0.0000,0.0000,-32.0000,999.0);
	CreatePlayerObject(playerid,885,-3231.0566,1534.4080,3.9827,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,885,-3206.9106,1534.4080,3.9827,0.0000,0.0000,69.0000,999.0);
	CreatePlayerObject(playerid,885,-3218.6855,1534.4080,3.9827,0.0000,0.0000,125.0000,999.0);
	CreatePlayerObject(playerid,628,-3248.2051,1487.5242,5.9592,0.0000,0.0000,-131.0000,999.0);
	CreatePlayerObject(playerid,628,-3226.1389,1523.6616,5.2747,0.0000,0.0000,-120.0000,999.0);
	CreatePlayerObject(playerid,628,-3223.3250,1525.0994,5.2747,0.0000,0.0000,-74.0000,999.0);
	CreatePlayerObject(playerid,628,-3223.4836,1522.1924,5.2747,0.0000,0.0000,-38.0000,999.0);
	CreatePlayerObject(playerid,628,-3220.8762,1574.8800,5.9524,0.0000,0.0000,28.0000,999.0);
	CreatePlayerObject(playerid,759,-3211.6606,1513.9496,4.0000,0.0000,0.0000,107.0000,999.0);
	CreatePlayerObject(playerid,624,-3264.0588,1529.2220,3.2300,0.0000,0.0000,15.0000,999.0);
	CreatePlayerObject(playerid,624,-3236.3870,1529.2220,3.2300,0.0000,0.0000,53.0000,999.0);
	CreatePlayerObject(playerid,817,-3263.4792,1533.7153,4.4050,0.0000,0.0000,0.0000,999.0);
	CreatePlayerObject(playerid,817,-3260.5073,1533.7153,4.4050,0.0000,0.0000,30.0000,999.0);
	CreatePlayerObject(playerid,817,-3257.5352,1533.7153,4.4050,0.0000,0.0000,54.0000,999.0);
	CreatePlayerObject(playerid,817,-3254.5632,1533.7153,4.4050,0.0000,0.0000,72.0000,999.0);
	CreatePlayerObject(playerid,817,-3251.5913,1533.7153,4.4050,0.0000,0.0000,39.0000,999.0);
	CreatePlayerObject(playerid,817,-3248.6191,1533.7153,4.4050,0.0000,0.0000,39.0000,999.0);
	CreatePlayerObject(playerid,817,-3239.8359,1533.7153,4.4050,0.0000,0.0000,105.0000,999.0);
	CreatePlayerObject(playerid,817,-3236.8638,1533.7153,4.4050,0.0000,0.0000,47.0000,999.0);
	CreatePlayerObject(playerid,817,-3242.8079,1533.7153,4.4050,0.0000,0.0000,68.0000,999.0);
	CreatePlayerObject(playerid,817,-3245.7319,1533.7153,4.4050,0.0000,0.0000,28.0000,999.0);
	CreatePlayerObject(playerid,817,-3238.2627,1553.1128,4.4050,0.0000,0.0000,82.0000,999.0);
	CreatePlayerObject(playerid,817,-3241.5566,1553.1128,4.4050,0.0000,0.0000,125.0000,999.0);
	CreatePlayerObject(playerid,817,-3244.4338,1553.1128,4.4050,0.0000,0.0000,153.0000,999.0);
	CreatePlayerObject(playerid,817,-3246.8398,1553.1128,4.4050,0.0000,0.0000,-179.0000,999.0);
	CreatePlayerObject(playerid,817,-3249.6064,1553.1128,4.4050,0.0000,0.0000,-145.0000,999.0);
	CreatePlayerObject(playerid,817,-3252.4700,1553.1128,4.4050,0.0000,0.0000,-96.0000,999.0);
	CreatePlayerObject(playerid,817,-3255.2151,1553.1128,4.4050,0.0000,0.0000,-79.0000,999.0);
	CreatePlayerObject(playerid,817,-3257.8047,1553.1128,4.4050,0.0000,0.0000,-32.0000,999.0);
	CreatePlayerObject(playerid,817,-3265.5815,1582.6428,4.4050,0.0000,0.0000,-14.0000,999.0);

	// Exit here
	return 1;
}

