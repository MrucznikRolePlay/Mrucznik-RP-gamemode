/*
	*
	*	Thanks to iggy1 for the blank base.
	*
	*	Anti-Vehicle Sync Teleportation!
	*
	*
*/

/* ** Useful Functions ** */
native SetVehicleSyncDebug( toggle = 1 );
native IsVehicleOccupied( vehicleid );

/* ** Functions being hooked ** */
native vs_SetVehiclePos( vehicleid, Float: X, Float: Y, Float: Z );
native vs_CreateVehicle( vehicle_type, Float: spawn_x, Float: spawn_y, Float: spawn_z, Float: z_angle, color1, color2, respawn_delay );
native vs_AddStaticVehicle( modelid, Float: spawn_x, Float: spawn_y, Float: spawn_z, Float: z_angle, color1, color2 );
native vs_AddStaticVehicleEx( modelid, Float: spawn_x, Float: spawn_y, Float: spawn_z, Float: z_angle, color1, color2, respawn_delay );

#define SetVehiclePos 			vs_SetVehiclePos
#define AddStaticVehicleEx 		vs_AddStaticVehicleEx
#define AddStaticVehicle 		vs_AddStaticVehicle
#define CreateVehicle 			vs_CreateVehicle