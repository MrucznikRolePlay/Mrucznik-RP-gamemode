// ----[ Falling when objects loading fix ]----
stock Mru_SetPlayerPos(playerid, Float:x, Float:y, Float:z, checkfall = 1)
{
    if(checkfall)
    {
        defer Mru_CheckPosAfterSet(playerid, x, y, z);
    }
    SetPlayerPos(playerid, x, y, z);
    return 1;
}
#if defined _ALS_SetPlayerPos
    #undef SetPlayerPos
#else
    #define _ALS_SetPlayerPos
#endif
// Reroute future calls to our function.
#define SetPlayerPos Mru_SetPlayerPos

timer Mru_CheckPosAfterSet[500](playerid, Float:setX, Float:setY, Float:setZ)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

    if(floatround(x) != floatround(setX) || floatround(y) != floatround(setY))
    {
        return; // position not updated yet, don't change position
    }

    new Float:groundZ;
    CA_FindZ_For2DCoord(setX, setY, groundZ);

    // player fall and is below ground
	if(z - setZ < 0.5 && z < groundZ)
	{
		Mru_SetPlayerPos(playerid, setX, setY, setZ, 0);
	}
}

// ----[ Pickups fix ]----
stock Mru_CreateDynamicPickup(modelid, type, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_PICKUP_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority=0)
{
    if(x >= 4096.0 || x <= -4096.0 || y >= 4096.0 || y <= -4096.0)
    {
        new obj = CreateDynamicObject(modelid, x, y, z, 0.0, 0.0, 0.0, worldid, interiorid, playerid, streamdistance, streamdistance, areaid, priority);
        defer AnimateObjectPickup(obj, x, y, z, 0);
    }
    else
    {
        CreateDynamicPickup(modelid, type, x, y, z, worldid, interiorid, playerid, streamdistance, areaid, priority);
    }
    return 1;
}
#if defined _ALS_CreateDynamicPickup
    #undef CreateDynamicPickup
#else
    #define _ALS_CreateDynamicPickup
#endif
// Reroute future calls to our function.
#define CreateDynamicPickup Mru_CreateDynamicPickup

timer AnimateObjectPickup[950](obj, Float:x, Float:y, Float:z, step)
{
    new Float:newZ;
    if(step % 4 == 0)
    {
        newZ = z + 0.1;
        MoveDynamicObject(obj, x, y, newZ, 0.1, 0.0, 0.0, 0.0);
    }
    else if(step % 4 == 1)
    {
        newZ = z - 0.1;
        MoveDynamicObject(obj, x, y, newZ, 0.1, 0.0, 0.0, 90.0);
    }
    else if(step % 4 == 2)
    {
        newZ = z + 0.1;
        MoveDynamicObject(obj, x, y, newZ, 0.1, 0.0, 0.0, 180.0);
    }
    else if(step % 4 == 3)
    {
        newZ = z - 0.1;
        MoveDynamicObject(obj, x, y, newZ, 0.1, 0.0, 0.0, 270.0);
    }

    defer AnimateObjectPickup(obj, x, y, newZ, step+1);
}