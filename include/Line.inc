/*==============================================================================


	Southclaw's Line Segment Generation Script

		Generates a line of objects between start point and destination. Useful
		for ziplines, tunnels, police tape, funky infinite neon strips, etc.

		Dependencies:
			y_iterate
			streamer plugin

		Do what you want with it, but keep my name on it :)


==============================================================================*/


#define MAX_LINE				(1024)
#define LIN_MAX_OBJ				(512)
#define INVALID_LINE_SEGMENT_ID	(-1)


enum E_LINE_DATA
{
			lin_model,
			lin_objCount,
Float:  	lin_objLength,
Float:		lin_objLengthOffset,
Float:		lin_maxLength,

Float:		lin_posX,
Float:		lin_posY,
Float:		lin_posZ,

Float:		lin_dstX,
Float:		lin_dstY,
Float:		lin_dstZ,

Float:		lin_rotX,
Float:		lin_rotY,
Float:		lin_rotZ,

			lin_world,
			lin_interior
}


static
			lin_Data[MAX_LINE][E_LINE_DATA],
			lin_Objects[MAX_LINE][LIN_MAX_OBJ],
Iterator:	lin_Index<MAX_LINE>;


/*==============================================================================

	Core

==============================================================================*/


stock CreateLineSegment(modelid, Float:objlength,
	Float:PointX, Float:PointY, Float:PointZ,
	Float:DestX, Float:DestY, Float:DestZ,
	Float:RotX = 0.0, Float:RotY = 0.0, Float:RotZ = 0.0,
	Float:objlengthoffset = 0.0, worldid = 0, interiorid = 0, Float:maxlength = 100.0)
{
	new id = Iter_Free(lin_Index);

	if(id == -1)
	{
		print("ERROR: MAX_LINE limit reached.");
		return 0;
	}
	
	lin_Data[id][lin_maxLength]			= maxlength;
	lin_Data[id][lin_model]				= modelid;
	lin_Data[id][lin_objLength]			= objlength;
	lin_Data[id][lin_objLengthOffset]	= objlengthoffset;

	lin_Data[id][lin_posX]				= PointX;
	lin_Data[id][lin_posY]				= PointY;
	lin_Data[id][lin_posZ]				= PointZ;

	lin_Data[id][lin_dstX]				= DestX;
	lin_Data[id][lin_dstY]				= DestY;
	lin_Data[id][lin_dstZ]				= DestZ;

	lin_Data[id][lin_rotX]				= RotX;
	lin_Data[id][lin_rotY]				= RotY;
	lin_Data[id][lin_rotZ]				= RotZ;

	lin_Data[id][lin_world]				= worldid;
	lin_Data[id][lin_interior]			= interiorid;

	Iter_Add(lin_Index, id);

	UpdateLineSegment(id);

	return id;
}

stock DestroyLineSegment(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	for(new i; i < lin_Data[lineid][lin_objCount]; i++)
	{
		if(IsValidDynamicObject(lin_Objects[lineid][i]))
		{
			DestroyDynamicObject(lin_Objects[lineid][i]);
			lin_Objects[lineid][i] = INVALID_OBJECT_ID;
		}
	}

	Iter_Remove(lin_Index, lineid);

	return 1;
}


/*==============================================================================

	Internal

==============================================================================*/


UpdateLineSegment(lineid)
{
	new
		Float:rx,
		Float:ry,
		Float:rz,
		Float:vx = lin_Data[lineid][lin_dstX] - lin_Data[lineid][lin_posX],
		Float:vy = lin_Data[lineid][lin_dstY] - lin_Data[lineid][lin_posY],
		Float:vz = lin_Data[lineid][lin_dstZ] - lin_Data[lineid][lin_posZ],
		Float:tmpdist,
		Float:distToDest,
		count;

	rz = -(atan2(vy, vx)-90.0);
	rx = -(floatabs(atan2(floatsqroot(floatpower(vx, 2.0) + floatpower(vy, 2.0)), vz))-90.0);

	distToDest = floatsqroot( (vx*vx) + (vy*vy) + (vz*vz) );
	count = floatround(distToDest / lin_Data[lineid][lin_objLength], floatround_ceil) + 1;

	for(new i; i < count; i++)
	{
		if(i == 0)
			tmpdist = (lin_Data[lineid][lin_objLength] / 2.0) + lin_Data[lineid][lin_objLengthOffset];

		else if(i == count - 1)
			tmpdist = (distToDest - (lin_Data[lineid][lin_objLength] / 2.0)) + lin_Data[lineid][lin_objLengthOffset];

		else
			tmpdist = (lin_Data[lineid][lin_objLength] * (i - 1)) + (lin_Data[lineid][lin_objLength] / 2.0) + lin_Data[lineid][lin_objLengthOffset];


		if(tmpdist > distToDest)
			break;

		if(!IsValidDynamicObject(lin_Objects[lineid][i]))
		{
			lin_Objects[lineid][i] = CreateDynamicObject(lin_Data[lineid][lin_model],
				lin_Data[lineid][lin_posX] + ( tmpdist * floatsin(rz, degrees) * floatcos(rx, degrees) ),
				lin_Data[lineid][lin_posY] + ( tmpdist * floatcos(rz, degrees) * floatcos(rx, degrees) ),
				lin_Data[lineid][lin_posZ] + ( tmpdist * floatsin(rx, degrees) ),
				rx + lin_Data[lineid][lin_rotX],
				ry + lin_Data[lineid][lin_rotY],
				-rz + lin_Data[lineid][lin_rotZ],
				lin_Data[lineid][lin_world], lin_Data[lineid][lin_interior]);
		}
		else
		{
			SetDynamicObjectPos(lin_Objects[lineid][i],
				lin_Data[lineid][lin_posX] + ( tmpdist * floatsin(rz, degrees) * floatcos(rx, degrees) ),
				lin_Data[lineid][lin_posY] + ( tmpdist * floatcos(rz, degrees) * floatcos(rx, degrees) ),
				lin_Data[lineid][lin_posZ] + ( tmpdist * floatsin(rx, degrees) ) );

			SetDynamicObjectRot(lin_Objects[lineid][i],
				rx + lin_Data[lineid][lin_rotX],
				ry + lin_Data[lineid][lin_rotY],
				-rz + lin_Data[lineid][lin_rotZ]);
		}

		if(tmpdist > lin_Data[lineid][lin_maxLength])
		{
			break;
		}
	}
	if(count < lin_Data[lineid][lin_objCount])
	{
		for(new i = count; i < LIN_MAX_OBJ; i++)
		{
		    if(IsValidDynamicObject(lin_Objects[lineid][i]))
		    {
		    	DestroyDynamicObject(lin_Objects[lineid][i]);
		    	lin_Objects[lineid][i] = INVALID_OBJECT_ID;
		    }
		}
	}

	lin_Data[lineid][lin_objCount] = count;

	return 1;
}


/*==============================================================================

	Interface

==============================================================================*/


stock IsValidLineSegment(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	return 1;
}


// lin_model
stock GetLineSegmentModel(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	return lin_Data[lineid][lin_model];
}

stock SetLineSegmentModel(lineid, modelid, Float:objlength, Float:objlengthoffset)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_model] = modelid;
    lin_Data[lineid][lin_objLength] = objlength;
    lin_Data[lineid][lin_objLengthOffset] = objlengthoffset;

	for(new i; i < lin_Data[lineid][lin_objCount]; i++)
	{
		if(IsValidDynamicObject(lin_Objects[lineid][i]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, lin_Objects[lineid][i], E_STREAMER_MODEL_ID, modelid);
	}

	UpdateLineSegment(lineid);

	return 1;
}

// lin_objCount
stock GetLineSegmentObjectCount(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	return lin_Data[lineid][lin_objCount];
}

// lin_objLength
stock Float:GetLineSegmentObjectLength(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	return lin_Data[lineid][lin_objLength];
}

stock SetLineSegmentObjectLength(lineid, Float:objlength)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_objLength] = objlength;

	return 1;
}

// lin_objLengthOffset
stock Float:GetLineSegmentObjectOffset(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	return lin_Data[lineid][lin_objLengthOffset];
}

stock SetLineSegmentObjectOffset(lineid, Float:objlengthoffset)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_objLengthOffset] = objlengthoffset;

	return 1;
}

// lin_maxLength
stock Float:GetLineSegmentMaxLength(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	return lin_Data[lineid][lin_maxLength];
}

stock SetLineSegmentMaxLength(lineid, Float:maxlength)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_maxLength] = maxlength;

	UpdateLineSegment(lineid);

	return 1;
}

// lin_posX
// lin_posY
// lin_posZ
stock GetLineSegmentPoint(lineid, &Float:PointX, &Float:PointY, &Float:PointZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	PointX = lin_Data[lineid][lin_posX];
	PointY = lin_Data[lineid][lin_posY];
	PointZ = lin_Data[lineid][lin_posZ];

	UpdateLineSegment(lineid);

	return 1;
}

stock SetLineSegmentPoint(lineid, Float:PointX, Float:PointY, Float:PointZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_posX] = PointX;
	lin_Data[lineid][lin_posY] = PointY;
	lin_Data[lineid][lin_posZ] = PointZ;

	UpdateLineSegment(lineid);

	return 1;
}

// lin_dstX
// lin_dstY
// lin_dstZ
stock GetLineSegmentDest(lineid, &Float:DestX, &Float:DestY, &Float:DestZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	DestX = lin_Data[lineid][lin_dstX];
	DestY = lin_Data[lineid][lin_dstY];
	DestZ = lin_Data[lineid][lin_dstZ];

	UpdateLineSegment(lineid);

	return 1;
}

stock SetLineSegmentDest(lineid, Float:DestX, Float:DestY, Float:DestZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_dstX] = DestX;
	lin_Data[lineid][lin_dstY] = DestY;
	lin_Data[lineid][lin_dstZ] = DestZ;

	UpdateLineSegment(lineid);

	return 1;
}

// lin_rotX
// lin_rotY
// lin_rotZ
stock GetLineSegmentModelAngles(lineid, &Float:RotX, &Float:RotY, &Float:RotZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	RotX = lin_Data[lineid][lin_rotX];
	RotY = lin_Data[lineid][lin_rotY];
	RotZ = lin_Data[lineid][lin_rotZ];

	UpdateLineSegment(lineid);

	return 1;
}

stock SetLineSegmentModelAngles(lineid, Float:RotX, Float:RotY, Float:RotZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_rotX] = RotX;
	lin_Data[lineid][lin_rotY] = RotY;
	lin_Data[lineid][lin_rotZ] = RotZ;

	UpdateLineSegment(lineid);

	return 1;
}

// lin_world
stock GetLineSegmentWorld(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	return lin_Data[lineid][lin_world];
}

stock SetLineSegmentWorld(lineid, world)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_world] = world;

	for(new i; i < lin_Data[lineid][lin_objCount]; i++)
	{
		if(IsValidDynamicObject(lin_Objects[lineid][i]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, lin_Objects[lineid][i], E_STREAMER_WORLD_ID, world);
	}

	UpdateLineSegment(lineid);

	return 1;
}

// lin_interior
stock GetLineSegmentInterior(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	return lin_Data[lineid][lin_interior];
}
stock SetLineSegmentInterior(lineid, interior)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	lin_Data[lineid][lin_interior] = interior;

	for(new i; i < lin_Data[lineid][lin_objCount]; i++)
	{
		if(IsValidDynamicObject(lin_Objects[lineid][i]))
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, lin_Objects[lineid][i], E_STREAMER_INTERIOR_ID, interior);
	}

	UpdateLineSegment(lineid);

	return 1;
}


/*==============================================================================

	Utility

==============================================================================*/


stock GetLineSegmentVector(lineid, &Float:x, &Float:y, &Float:z)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0;

	new
		Float:vx = lin_Data[lineid][lin_dstX] - lin_Data[lineid][lin_posX],
		Float:vy = lin_Data[lineid][lin_dstY] - lin_Data[lineid][lin_posY],
		Float:vz = lin_Data[lineid][lin_dstZ] - lin_Data[lineid][lin_posZ],
		Float:rx,
		Float:rz;

	rx = -(floatabs(atan2(floatsqroot(floatpower(vx, 2.0) + floatpower(vy, 2.0)), vz))-90.0);
	rz = -(atan2(vy, vx)-90.0);

	x = floatsin(rz, degrees) * floatcos(rx, degrees);
	y = floatcos(rz, degrees) * floatcos(rx, degrees);
	z = floatsin(rx, degrees);

	return 1;
}

stock Float:GetDistanceToLineSegmentPoint(lineid, Float:FromX, Float:FromY, Float:FromZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	new
		Float:vx = FromX - lin_Data[lineid][lin_posX],
		Float:vy = FromY - lin_Data[lineid][lin_posY],
		Float:vz = FromZ - lin_Data[lineid][lin_posZ];

	return floatsqroot( (vx * vx) + (vy * vy) + (vz * vz) );
}

stock Float:GetDistanceToLineSegmentDest(lineid, Float:FromX, Float:FromY, Float:FromZ)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	new
		Float:vx = FromX - lin_Data[lineid][lin_dstX],
		Float:vy = FromY - lin_Data[lineid][lin_dstY],
		Float:vz = FromZ - lin_Data[lineid][lin_dstZ];

	return floatsqroot( (vx * vx) + (vy * vy) + (vz * vz) );
}

stock Float:GetLineSegmentLength(lineid)
{
	if(!Iter_Contains(lin_Index, lineid))
		return 0.0;

	new
		Float:vx = lin_Data[lineid][lin_dstX] - lin_Data[lineid][lin_posX],
		Float:vy = lin_Data[lineid][lin_dstY] - lin_Data[lineid][lin_posY],
		Float:vz = lin_Data[lineid][lin_dstZ] - lin_Data[lineid][lin_posZ];

	return floatsqroot( (vx * vx) + (vy * vy) + (vz * vz) );
}
