stock Mru_SetPlayerPos(playerid, Float:x, Float:y, Float:z, checkfall = 1)
{
    if(checkfall)
    {
        defer Mru_CheckPosAfterSet(playerid, z);
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

timer Mru_CheckPosAfterSet[300](playerid, Float:setZ)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, setZ);

    new Float:groundZ;
    CA_FindZ_For2DCoord(x, y, groundZ);

    // player fall and is below ground
	if(z - setZ < 0.5 && z < groundZ + 0.2)
	{
		Mru_SetPlayerPos(playerid, x, y, setZ, 0);
	}
}