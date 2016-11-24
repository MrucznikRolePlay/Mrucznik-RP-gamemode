/*  SA:MP Actor Functions
 *
 *  (c) Copyright 2005-2006, SA:MP Team
 *
 */

#if defined _actors_included
	#endinput
#endif
#define _actors_included
#pragma library actors

// Actor
native CreateActor( modelid, Float:X, Float:Y, Float:Z, Float:Rotation, name[] );
native DestroyActor(actorid);
native SpawnActor(actorid);
native ActorMoveTo(actorid, movetype, Float:X, Float:Y, Float:Z );
native ActorEnterVehicle(actorid, vehicleid, passenger);
native ActorExitVehicle(actorid,vehicleid);
native ActorDriveVehicleTo(actorid, vehicleid, Float:X, Float:Y, Float:Z, Float:Speed, drivetype, Float:MinAltitude=0.0, Float:MaxAltitude=0.0);

// Actor info
native SetActorPos(actorid, Float:x, Float:y, Float:z);
native SetActorPosFindZ(actorid, Float:x, Float:y, Float:z);
native GetActorPos(actorid, &Float:x, &Float:y, &Float:z);
native SetActorFacingAngle(actorid,Float:ang);
native GetActorFacingAngle(actorid,&Float:ang);
native SetActorInterior(actorid,interiorid);
native GetActorInterior(actorid);
native SetActorHealth(actorid, Float:health);
native GetActorHealth(actorid, &Float:health);
native SetActorArmour(actorid, Float:armour);
native GetActorArmour(actorid, &Float:armour);
native SetActorTeam(actorid, teamid);
native GetActorTeam(actorid);
native SetActorColor(actorid,color);
native GetActorColor(actorid);
native SetActorSkin(actorid, skinid);
native GetActorSkin(actorid);
native SetActorWeapon(actorid, weaponid);
native ResetActorWeapon(actorid);
native SetActorName(actorid, const name[]);
native GetActorState(actorid);
native GetActorWeapon(actorid);
native GetActorKeys(actorid, &keys, &updown, &leftright);
native GetActorName(actorid, const name[], len);

// Actor controls
native PutActorInVehicle(actorid, vehicleid, seatid);
native GetActorVehicleID(actorid);
native GetActorVehicleSeat(actorid);
native RemoveActorFromVehicle(actorid);
native ActorApplyAnimation(actorid, animlib[], animname[], Float:fS, opt1, opt2, opt3, opt4, opt5);
native ActorClearAnimations(actorid);

// Actor conditionals
native IsActorConnected(actorid);
native IsActorInVehicle(actorid, vehicleid);
native IsActorInAnyVehicle(actorid);

// Virtual Worlds
native SetActorVirtualWorld(actorid, worldid);
native GetActorVirtualWorld(actorid);
