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
	if(z - setZ < 0.1 && z < groundZ)
	{
		Mru_SetPlayerPos(playerid, setX, setY, setZ, 0);
	}
}

// ----[ Pickups fix ]----
new Map:MruDynamicPickupTimers;
stock Mru_CreateDynamicPickup(modelid, type, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_PICKUP_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority=0)
{
    if(x >= 4096.0 || x <= -4096.0 || y >= 4096.0 || y <= -4096.0)
    {
        new obj = CreateDynamicObject(modelid, x, y, z, 0.0, 0.0, 0.0, worldid, interiorid, playerid, streamdistance, streamdistance, areaid, priority);
        MAP_insert_val_val(MruDynamicPickupTimers, obj, 1);
        defer AnimateObjectPickup(obj, x, y, z, 0);
        return obj;
    }
    else
    {
        return CreateDynamicPickup(modelid, type, x, y, z, worldid, interiorid, playerid, streamdistance, areaid, priority);
    }
}
#if defined _ALS_CreateDynamicPickup
    #undef CreateDynamicPickup
#else
    #define _ALS_CreateDynamicPickup
#endif
// Reroute future calls to our function.
#define CreateDynamicPickup Mru_CreateDynamicPickup

timer AnimateObjectPickup[475](obj, Float:x, Float:y, Float:z, step)
{
    if(MAP_get_val_val(MruDynamicPickupTimers, obj) == 0)
    {
        return;
    }

    new Float:animationSpeed = 0.2;
    new Float:newZ;
    if(step % 4 == 0)
    {
        newZ = z + 0.1;
        MoveDynamicObject(obj, x, y, newZ, animationSpeed, 0.0, 0.0, 0.0);
    }
    else if(step % 4 == 1)
    {
        newZ = z - 0.1;
        MoveDynamicObject(obj, x, y, newZ, animationSpeed, 0.0, 0.0, 90.0);
    }
    else if(step % 4 == 2)
    {
        newZ = z + 0.1;
        MoveDynamicObject(obj, x, y, newZ, animationSpeed, 0.0, 0.0, 180.0);
    }
    else if(step % 4 == 3)
    {
        newZ = z - 0.1;
        MoveDynamicObject(obj, x, y, newZ, animationSpeed, 0.0, 0.0, 270.0);
    }

    defer AnimateObjectPickup(obj, x, y, newZ, step+1);
}


stock Mru_DestroyDynamicPickup(pickupid)
{
    if(IsValidDynamicPickup(pickupid))
    {
        DestroyDynamicPickup(pickupid);
        return 1;
    }
    if(IsValidDynamicObject(pickupid))
    {
        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(pickupid, x, y, z);
        if(x >= 4096.0 || x <= -4096.0 || y >= 4096.0 || y <= -4096.0)
        {
            DestroyDynamicObject(pickupid);
            MAP_remove_val(MruDynamicPickupTimers, pickupid);
        }
    }
    return 1;
}
#if defined _ALS_DestroyDynamicPickup
    #undef DestroyDynamicPickup
#else
    #define _ALS_DestroyDynamicPickup
#endif
// Reroute future calls to our function.
#define DestroyDynamicPickup Mru_DestroyDynamicPickup