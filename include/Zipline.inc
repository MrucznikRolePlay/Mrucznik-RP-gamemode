/*==============================================================================


	Southclaw's Ziplines Script

		Create fun and useful ziplines players can use to speed across large
		areas quickly. Warning: does not work well with laggy players.

		Dependencies:
			YSI/y_iterate - Y_Less
			YSI/y_timers - Y_Less
			Streamer Plugin - Incognito
			Line - Southclaw

		Do what you want with it, but keep my name on it :)


==============================================================================*/


#include <YSI\y_hooks>


#define MAX_ZIPLINE (32)


enum E_ZIPLINE_DATA
{
			zip_startArea,
			zip_endArea,
			zip_lineID,

Float:		zip_startPosX,
Float:		zip_startPosY,
Float:		zip_startPosZ,

Float:		zip_endPosX,
Float:		zip_endPosY,
Float:		zip_endPosZ,
	
Float:		zip_vecX,
Float:		zip_vecY,
Float:		zip_vecZ,

			zip_world,
			zip_interior
}


static
			zip_Data[MAX_ZIPLINE][E_ZIPLINE_DATA],
Iterator:	zip_Index<MAX_ZIPLINE>;

static
			zip_currentZipline[MAX_PLAYERS],
Timer:		zip_UpdateTimer[MAX_PLAYERS],
Float:		zip_PlayerSpeedMult[MAX_PLAYERS];


/*==============================================================================

	Zeroing

==============================================================================*/


#if defined FILTERSCRIPT
hook OnFilterScriptInit()
#else
hook OnGameModeInit()
#endif
{
	for(new i;i<MAX_PLAYERS;i++)
	{
		zip_currentZipline[i] = -1;
	}
	return CallLocalFunction("zip_OnFilterScriptInit", "");
}


/*==============================================================================

	Core

==============================================================================*/


stock CreateZipline(
	Float:x1, Float:y1, Float:z1,
	Float:x2, Float:y2, Float:z2,
	worldid = 0, interiorid = 0)
{
	new id = Iter_Free(zip_Index);

	if(id == -1)
	{
		print("ERROR: MAX_ZIPLINE limit reached.");
		return -1;
	}

	zip_Data[id][zip_startArea] = CreateDynamicSphere(x1, y1, z1 - 1.0, 2.0, worldid, interiorid);
	zip_Data[id][zip_endArea] = CreateDynamicSphere(x2, y2, z2 - 1.0, 6.0, worldid, interiorid);

	zip_Data[id][zip_lineID] = CreateLineSegment(19087, 2.46,
		x1, y1, z1,
		x2, y2, z2,
		.RotX = 90.0, .objlengthoffset = -(2.46/2), .worldid = worldid, .interiorid = interiorid, .maxlength = 1000.0);

	SetLineSegmentDest(zip_Data[id][zip_lineID], x2, y2, z2);

	zip_Data[id][zip_startPosX] = x1;
	zip_Data[id][zip_startPosY] = y1;
	zip_Data[id][zip_startPosZ] = z1;

	zip_Data[id][zip_endPosX] = x2;
	zip_Data[id][zip_endPosY] = y2;
	zip_Data[id][zip_endPosZ] = z2;

	zip_Data[id][zip_world] = worldid;
	zip_Data[id][zip_interior] = interiorid;

	GetLineSegmentVector(zip_Data[id][zip_lineID],
		zip_Data[id][zip_vecX], zip_Data[id][zip_vecY], zip_Data[id][zip_vecZ]);

	Iter_Add(zip_Index, id);

	return id;
}


/*==============================================================================

	Internal

==============================================================================*/


public OnPlayerEnterDynamicArea(playerid, areaid)
{
	foreach(new i : zip_Index)
	{
		if(areaid == zip_Data[i][zip_startArea])
		{
			ShowActionText(playerid, "Press F to use zipline", 0, 140);
		}

		if(areaid == zip_Data[i][zip_endArea] && zip_currentZipline[playerid] != -1)
		{
			ExitZipline(playerid);
		}
	}

	return CallLocalFunction("zip_OnPlayerEnterDynamicArea", "dd", playerid, areaid);
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea zip_OnPlayerEnterDynamicArea
forward zip_OnPlayerEnterDynamicArea(playerid, areaid);


public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	HideActionText(playerid);

	return CallLocalFunction("zip_OnPlayerLeaveDynamicArea", "dd", playerid, areaid);
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea zip_OnPlayerLeaveDynamicArea
forward zip_OnPlayerLeaveDynamicArea(playerid, areaid);


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & 16)
	{
		if(zip_currentZipline[playerid] == -1)
		{
			foreach(new i : zip_Index)
			{
				if(IsPlayerInDynamicArea(playerid, zip_Data[i][zip_startArea]))
				{
					EnterZipline(playerid, i);
					return 1;
				}
				else if(IsPlayerInDynamicArea(playerid, zip_Data[i][zip_endArea]))
				{
					return 1;
				}
				else
				{
					new
						Float:x,
						Float:y,
						Float:z,
						Float:angleto,
						Float:angleof,
						Float:anglesum;
				
					GetPlayerPos(playerid, x, y, z);

					angleto = zip_GetAngleToPoint(zip_Data[i][zip_startPosX], zip_Data[i][zip_startPosY], x, y);
					angleof = zip_absoluteangle(-(90-(atan2(zip_Data[i][zip_vecY], zip_Data[i][zip_vecX]))));
					anglesum = zip_absoluteangle(angleto - angleof);

					if(anglesum > 270.0 || anglesum < 90.0)
					{
						angleto = zip_GetAngleToPoint(zip_Data[i][zip_endPosX], zip_Data[i][zip_endPosY], x, y);
						angleof = zip_absoluteangle((-(90-(atan2(zip_Data[i][zip_vecY], zip_Data[i][zip_vecX])))) - 180.0);
						anglesum = zip_absoluteangle(angleto - angleof);

						if(anglesum > 270.0 || anglesum < 90.0)
						{
							new Float:dist = zip_GetDistancePointLine(
								zip_Data[i][zip_startPosX], zip_Data[i][zip_startPosY], zip_Data[i][zip_startPosZ]-1.0,
								zip_Data[i][zip_vecX], zip_Data[i][zip_vecY], zip_Data[i][zip_vecZ],
								x, y, z);

							if(dist < 2.0)
							{
								EnterZipline(playerid, i);
								return 1;
							}
						}
					}
				}
			}
		}
		else
		{
			ExitZipline(playerid);
		}
	}

	return 1;
}

EnterZipline(playerid, id)
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:dist;

	GetPlayerPos(playerid, x, y, z);
	dist = GetDistanceToLineSegmentPoint(id, x, y, z);

	SetPlayerPos(playerid,
		zip_Data[id][zip_startPosX] + (zip_Data[id][zip_vecX] * dist),
		zip_Data[id][zip_startPosY] + (zip_Data[id][zip_vecY] * dist),
		zip_Data[id][zip_startPosZ] + (zip_Data[id][zip_vecZ] * dist) - 1.0);

	SetPlayerFacingAngle(playerid, -(atan2(zip_Data[id][zip_vecX], zip_Data[id][zip_vecY])));

	zip_PlayerSpeedMult[playerid] = 0.2;

	ApplyAnimation(playerid, "PED", "CLIMB_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
	zip_currentZipline[playerid] = id;

	zip_UpdateTimer[playerid] = repeat ZiplineUpdate(playerid);

	return 1;
}

ExitZipline(playerid)
{
	new tmpid = zip_currentZipline[playerid];

	ClearAnimations(playerid, 1);
	zip_currentZipline[playerid] = -1;

	SetPlayerVelocity(playerid,
		zip_Data[tmpid][zip_vecX] * zip_PlayerSpeedMult[playerid],
		zip_Data[tmpid][zip_vecY] * zip_PlayerSpeedMult[playerid],
		(zip_Data[tmpid][zip_vecZ] + (GetPlayerPing(playerid) * 0.0009)) * zip_PlayerSpeedMult[playerid]);

	stop zip_UpdateTimer[playerid];

	return 1;
}


//hook OnPlayerUpdate(playerid)
timer ZiplineUpdate[50](playerid)
{
	if(zip_currentZipline[playerid] != -1)
	{
		new
			Float:x,
			Float:y,
			Float:z,
			Float:dist;

		GetPlayerPos(playerid, x, y, z);

		dist = zip_GetDistancePointLine(
			zip_Data[zip_currentZipline[playerid]][zip_startPosX],
			zip_Data[zip_currentZipline[playerid]][zip_startPosY],
			zip_Data[zip_currentZipline[playerid]][zip_startPosZ]-1.2,
			zip_Data[zip_currentZipline[playerid]][zip_vecX],
			zip_Data[zip_currentZipline[playerid]][zip_vecY],
			zip_Data[zip_currentZipline[playerid]][zip_vecZ],
			x, y, z);

		if(dist > 5.0)
		{
			ExitZipline(playerid);
			return 1;
		}

		SetPlayerVelocity(playerid,
			zip_Data[zip_currentZipline[playerid]][zip_vecX] * zip_PlayerSpeedMult[playerid],
			zip_Data[zip_currentZipline[playerid]][zip_vecY] * zip_PlayerSpeedMult[playerid],
			(zip_Data[zip_currentZipline[playerid]][zip_vecZ] + (GetPlayerPing(playerid) * 0.0009)) * zip_PlayerSpeedMult[playerid]);

		if(zip_PlayerSpeedMult[playerid] < 0.5)
			zip_PlayerSpeedMult[playerid] += 0.01;
	}

	return 1;
}


forward Float:zip_GetDistancePointLine(Float:line_x,Float:line_y,Float:line_z,Float:vector_x,Float:vector_y,Float:vector_z,Float:point_x,Float:point_y,Float:point_z);
stock Float:zip_GetDistancePointLine(Float:line_x,Float:line_y,Float:line_z,Float:vector_x,Float:vector_y,Float:vector_z,Float:point_x,Float:point_y,Float:point_z)
	return floatsqroot(floatpower((vector_y) * ((point_z) - (line_z)) - (vector_z) * ((point_y) - (line_y)), 2.0)+floatpower((vector_z) * ((point_x) - (line_x)) - (vector_x) * ((point_z) - (line_z)), 2.0)+floatpower((vector_x) * ((point_y) - (line_y)) - (vector_y) * ((point_x) - (line_x)), 2.0))/floatsqroot((vector_x) * (vector_x) + (vector_y) * (vector_y) + (vector_z) * (vector_z));

forward Float:zip_GetAngleToPoint(Float:fPointX, Float:fPointY, Float:fDestX, Float:fDestY);
stock Float:zip_GetAngleToPoint(Float:fPointX, Float:fPointY, Float:fDestX, Float:fDestY)
	return zip_absoluteangle(-(90-(atan2((fDestY - fPointY), (fDestX - fPointX)))));

forward Float:zip_absoluteangle(Float:angle);
stock Float:zip_absoluteangle(Float:angle)
{
	while(angle < 0.0)
		angle += 360.0;

	while(angle > 360.0)
		angle -= 360.0;

	return angle;
}


/*==============================================================================

	Interface

==============================================================================*/


stock IsValidZipline(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return 1;
}

// zip_startArea
stock GetZiplineStartAreaID(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return zip_Data[ziplineid][zip_startArea];
}

// zip_endArea
stock GetZiplineEndAreaID(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return zip_Data[ziplineid][zip_endArea];
}

// zip_lineID
stock GetZiplineLineID(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return zip_Data[ziplineid][zip_lineID];
}

// zip_startPosX
// zip_startPosY
// zip_startPosZ
stock GetZiplineStartPos(ziplineid, &Float:x, &Float:y, &Float:z)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	x = zip_Data[ziplineid][zip_startPosX];
	y = zip_Data[ziplineid][zip_startPosY];
	z = zip_Data[ziplineid][zip_startPosZ];

	return 1;
}

stock SetZiplineStartPos(ziplineid, Float:x, Float:y, Float:z)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	zip_Data[ziplineid][zip_startPosX] = x;
	zip_Data[ziplineid][zip_startPosY] = y;
	zip_Data[ziplineid][zip_startPosZ] = z;

	SetLineSegmentPoint(zip_Data[ziplineid][zip_lineID], x, y, z);
	GetLineSegmentVector(zip_Data[ziplineid][zip_lineID], zip_Data[ziplineid][zip_vecX], zip_Data[ziplineid][zip_vecY], zip_Data[ziplineid][zip_vecZ]);

	return 1;
}

// zip_endPosX
// zip_endPosY
// zip_endPosZ
stock GetZiplineEndPos(ziplineid, &Float:x, &Float:y, &Float:z)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	x = zip_Data[ziplineid][zip_endPosX];
	y = zip_Data[ziplineid][zip_endPosY];
	z = zip_Data[ziplineid][zip_endPosZ];

	return 1;
}

stock SetZiplineEndPos(ziplineid, Float:x, Float:y, Float:z)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	zip_Data[ziplineid][zip_endPosX] = x;
	zip_Data[ziplineid][zip_endPosY] = y;
	zip_Data[ziplineid][zip_endPosZ] = z;

	SetLineSegmentDest(zip_Data[ziplineid][zip_lineID], x, y, z);
	GetLineSegmentVector(zip_Data[ziplineid][zip_lineID], zip_Data[ziplineid][zip_vecX], zip_Data[ziplineid][zip_vecY], zip_Data[ziplineid][zip_vecZ]);

	return 1;
}

// zip_vecX
// zip_vecY
// zip_vecZ
stock GetZiplineVector(ziplineid, &Float:x, &Float:y, &Float:z)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	x = zip_Data[ziplineid][zip_vecX];
	y = zip_Data[ziplineid][zip_vecY];
	z = zip_Data[ziplineid][zip_vecZ];

	return 1;
}

// zip_world
stock GetZiplineWorld(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return zip_Data[ziplineid][zip_world];
}

stock SetZiplineWorld(ziplineid, worldid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	zip_Data[ziplineid][zip_world] = worldid;

	Streamer_SetIntData(STREAMER_TYPE_AREA, zip_Data[ziplineid][zip_startArea], E_STREAMER_WORLD_ID, worldid);
	Streamer_SetIntData(STREAMER_TYPE_AREA, zip_Data[ziplineid][zip_endArea], E_STREAMER_WORLD_ID, worldid);

	SetLineSegmentWorld(zip_Data[ziplineid][zip_lineID], worldid);

	return 1;
}

// zip_interior
stock GetZiplineInterior(ziplineid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	return zip_Data[ziplineid][zip_interior];
}

stock SetZiplineInterior(ziplineid, interiorid)
{
	if(!Iter_Contains(zip_Index, ziplineid))
		return 0;

	zip_Data[ziplineid][zip_interior] = interiorid;

	Streamer_SetIntData(STREAMER_TYPE_AREA, zip_Data[ziplineid][zip_startArea], E_STREAMER_INTERIOR_ID, interiorid);
	Streamer_SetIntData(STREAMER_TYPE_AREA, zip_Data[ziplineid][zip_endArea], E_STREAMER_INTERIOR_ID, interiorid);

	SetLineSegmentInterior(zip_Data[ziplineid][zip_lineID], interiorid);

	return 1;
}

stock IsPlayerOnZipline(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(zip_currentZipline[playerid] == -1)
		return 0;

	return 1;
}
