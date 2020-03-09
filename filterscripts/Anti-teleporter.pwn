#include <a_samp>

native IsValidVehicle(vehicleid);

#define FILTERSCRIPT

#define MAX_VEHICLE_DISTANCE_TO_TRAILER 15
#define MAX_VEHICLE_DISTANCE_CHANGE	50      //Might even be lesser, but just to be sure. Note that it wouldn't work even if the vehicel is teleported as long as it was teleported from a lesser distance than 50


new Float:RealVehiclePositions[MAX_VEHICLES][3];
new LastPullingVehicle[MAX_VEHICLES];

stock AC_AttachTrailerToVehicle(trailerid,vehicleid)
{
	LastPullingVehicle[trailerid] = vehicleid;
	return AttachTrailerToVehicle(trailerid, vehicleid);
}
#if defined _ALS_AttachTrailerToVehicle
	#undef AttachTrailerToVehicle
#else
	#define _ALS_AttachTrailerToVehicle
#endif
#define AttachTrailerToVehicle AC_AttachTrailerToVehicle

stock AC_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	return SetVehiclePos(vehicleid, x, y, z);
}
#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else
	#define _ALS_SetVehiclePos
#endif
#define SetVehiclePos AC_SetVehiclePos

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Anti unoccupied vehicle teleport by Bebras");
	print("--------------------------------------\n");
	return 1;
}



public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat)
{
	new Float:x,Float:y,Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	if(RealVehiclePositions[vehicleid][0] == 0.0 && RealVehiclePositions[vehicleid][1] == 0.0 && RealVehiclePositions[vehicleid][2] == 0.0)//Perhaps the gamemode is just started and there are no last positions
	{
		RealVehiclePositions[vehicleid][0] = x;
		RealVehiclePositions[vehicleid][1] = y;
		RealVehiclePositions[vehicleid][2] = z;
		return;
	}
	if(IsTrailer(vehicleid)) // If the vehicle is a trailer.
	{
		if(IsValidVehicle(LastPullingVehicle[vehicleid])) //If the pulling vehicle(truck) is still a valid vehicle(it exists)
		{
			new Float:distance = GetVehicleDistanceFromPoint(LastPullingVehicle[vehicleid], x,y,z);
			if(distance <= MAX_VEHICLE_DISTANCE_TO_TRAILER) //If the distance is smallen then defined, we assume that the trailer was lost and someone might still be trying to re-attach it
			{
				RealVehiclePositions[vehicleid][0] = x;
				RealVehiclePositions[vehicleid][1] = y;
				RealVehiclePositions[vehicleid][2] = z;
				return;
			}
		}
	}
	new Float:distance = GetVehicleDistanceFromPoint(vehicleid,RealVehiclePositions[vehicleid][0],RealVehiclePositions[vehicleid][1],RealVehiclePositions[vehicleid][2]);
	if(distance > MAX_VEHICLE_DISTANCE_CHANGE) //If the vehicle is further from its' last set position than 50, we set it back.
	{
		SetVehiclePos(vehicleid,RealVehiclePositions[vehicleid][0],RealVehiclePositions[vehicleid][1],RealVehiclePositions[vehicleid][2]);
	}
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	return;
}

public OnPlayerExitVehicle(playerid,vehicleid)
{
	// For accuracy we set the real position when a vehicle becomes unoncucupied
	new Float:x,Float:y,Float:z;
	GetVehiclePos(vehicleid,x,y,z);
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    //For accuracy aswell
        new Float:x,Float:y,Float:z,vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid,x,y,z);
		RealVehiclePositions[vehicleid][0] = x;
		RealVehiclePositions[vehicleid][1] = y;
		RealVehiclePositions[vehicleid][2] = z;
	}
	return 1;
}

stock IsTrailer(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 435,450,584,591,611,610: return true;
		default: return false;
	}
	return false;

}
