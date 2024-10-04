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