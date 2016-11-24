#if !defined RUN_TESTS
	#endinput
#endif

#undef _inc_ut_mock_players

#include <a_samp>

#include <YSI\y_testing>
#include <YSI\y_utils>

#if !defined DELETE_MODE
enum E_MOCK_PLAYER {
	mu_username[MAX_PLAYER_NAME + 1],
	Float:mu_pos[3],
	mu_virtual_world,
	mu_interior,
	mu_skin,
	mu_special_action,
	mu_score,
	mu_money,
	mu_state,
	mu_vehicle_id,
	mu_spectating_player,

	mu_current_weapon,
	mu_ammo[13],
	mu_weapon[13],
	mu_weapon_state[13],
	mu_animation_index,
	Float:mu_armour,
	Float:mu_camera_aspect_ratio,
	Float:mu_camera_front_vector[3],
	mu_camera_mode,
	Float:mu_camera_pos[3],
	Float:mu_camera_up_vector[3],
	Float:mu_camera_zoom,
	mu_color,
	Float:mu_distance_from_point,
	mu_drunk_level,
	Float:mu_facing_angle,
	Float:mu_fighting_style,
	Float:mu_health,
	mu_keys,
	Float:mu_last_shot_vectors[6],
	mu_menu,
	mu_network_stats,
	Float:mu_object_pos[3],
	Float:mu_object_rot,
	mu_surfing_object_id,
	mu_surfing_vehicle_id,
	mu_team,
	mu_time,
	mu_vehicle_seat,
	Float:mu_velocity[3],
	mu_wanted_level,
	mu_rcon_admin
}

//Should use static with getter, but meh
new 
	MockPlayer[MAX_PLAYERS][E_MOCK_PLAYER];
#endif


//In case you have a reason to revert mocking process, simply include this file again
#if defined DELETE_MODE
	#undef SetPlayerName
	#undef GetPlayerName
	#undef SetPlayerPos
	#undef GetPlayerPos
	#undef GetPlayerVirtualWorld
	#undef SetPlayerVirtualWorld
	#undef GetPlayerInterior
	#undef SetPlayerInterior
	#undef GetPlayerSkin
	#undef SetPlayerSkin
	#undef GetPlayerSpecialAction
	#undef SetPlayerSpecialAction
	#undef GetPlayerScore
	#undef SetPlayerScore
	#undef GetPlayerMoney
	#undef SetPlayerMoney
	#undef GetPlayerState
	#undef GetPlayerAmmo
	#undef SetPlayerAmmo

	#undef GetPlayerIp
	#undef GetPlayerVersion
	#undef GetPlayerPing

	#undef IsPlayerConnected
	#undef IsPlayerAdmin
	#undef IsPlayerInVehicle
	#undef IsPlayerInAnyVehicle

	//@TODO: Clear MockPlayer here somehow
	#pragma unused MockPlayer

	#endinput
#endif

#define DELETE_MODE

#if defined _ALS_SetPlayerName
    #undef SetPlayerName
#else
    #define _ALS_SetPlayerName
#endif
 
#define SetPlayerName(%0,%1) strcpy(MockPlayer[%0][mu_username],%1, MAX_PLAYER_NAME)

#if defined _ALS_GetPlayerName
    #undef GetPlayerName
#else
    #define _ALS_GetPlayerName
#endif

#define GetPlayerName(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_username],%2)

#if defined _ALS_SetPlayerPos
    #undef SetPlayerPos
#else
    #define _ALS_SetPlayerPos
#endif
 
#define SetPlayerPos(%0,%1,%2,%3) (MockPlayer[%0][mu_pos][0] = %1, MockPlayer[%0][mu_pos][1] = %2, MockPlayer[%0][mu_pos][2] = %3, true)

#if defined _ALS_GetPlayerPos
    #undef GetPlayerPos
#else
    #define _ALS_GetPlayerPos
#endif
 
#define GetPlayerPos(%0,%1,%2,%3) (%1 = MockPlayer[%0][mu_pos][0], %2 = MockPlayer[%0][mu_pos][1], %3 = MockPlayer[%0][mu_pos][2], true)

#if defined _ALS_GetPlayerVirtualWorld
    #undef GetPlayerVirtualWorld
#else
    #define _ALS_GetPlayerVirtualWorld
#endif
 
#define GetPlayerVirtualWorld(%0) MockPlayer[%0][mu_virtual_world]

#if defined _ALS_SetPlayerVirtualWorld
    #undef SetPlayerVirtualWorld
#else
    #define _ALS_SetPlayerVirtualWorld
#endif
 
#define SetPlayerVirtualWorld(%0,%1) (MockPlayer[%0][mu_virtual_world] =%1)

#if defined _ALS_GetPlayerInterior
    #undef GetPlayerInterior
#else
    #define _ALS_GetPlayerInterior
#endif
 
#define GetPlayerInterior(%0) MockPlayer[%0][mu_interior]

#if defined _ALS_SetPlayerInterior
    #undef SetPlayerInterior
#else
    #define _ALS_SetPlayerInterior
#endif
 
#define SetPlayerInterior(%0,%1) (MockPlayer[%0][mu_interior] =%1)

#if defined _ALS_GetPlayerSkin
    #undef GetPlayerSkin
#else
    #define _ALS_GetPlayerSkin
#endif
 
#define GetPlayerSkin(%0) MockPlayer[%0][mu_skin]

#if defined _ALS_SetPlayerSkin
    #undef SetPlayerSkin
#else
    #define _ALS_SetPlayerSkin
#endif
 
#define SetPlayerSkin(%0,%1) (MockPlayer[%0][mu_skin] =%1)

#if defined _ALS_GetPlayerSpecialAction
    #undef GetPlayerSpecialAction
#else
    #define _ALS_GetPlayerSpecialAction
#endif
 
#define GetPlayerSpecialAction(%0) MockPlayer[%0][mu_special_action]

#if defined _ALS_SetPlayerSpecialAction
    #undef SetPlayerSpecialAction
#else
    #define _ALS_SetPlayerSpecialAction
#endif
 
#define SetPlayerSpecialAction(%0,%1) (MockPlayer[%0][mu_special_action] =%1)

#if defined _ALS_GetPlayerScore
    #undef GetPlayerScore
#else
    #define _ALS_GetPlayerScore
#endif
 
#define GetPlayerScore(%0) MockPlayer[%0][mu_score]

#if defined _ALS_SetPlayerScore
    #undef SetPlayerScore
#else
    #define _ALS_SetPlayerScore
#endif
 
#define SetPlayerScore(%0,%1) (MockPlayer[%0][mu_score] =%1)

#if defined _ALS_GetPlayerMoney
    #undef GetPlayerMoney
#else
    #define _ALS_GetPlayerMoney
#endif
 
#define GetPlayerMoney(%0) MockPlayer[%0][mu_money]

#if defined _ALS_SetPlayerMoney
    #undef SetPlayerMoney
#else
    #define _ALS_SetPlayerMoney
#endif
 
#define SetPlayerMoney(%0,%1) (MockPlayer[%0][mu_money] =%1)

#if defined _ALS_GetPlayerState
    #undef GetPlayerState
#else
    #define _ALS_GetPlayerState
#endif
 
#define GetPlayerState(%0) MockPlayer[%0][mu_state]

#if defined _ALS_GetPlayerIp
    #undef GetPlayerIp
#else
    #define _ALS_GetPlayerIp
#endif
 
#define GetPlayerIp(%0,%1,%2) strcpy(%1, "127.0.0.1",%2)

#if defined _ALS_GetPlayerPing
    #undef GetPlayerPing
#else
    #define _ALS_GetPlayerPing
#endif
 
#define GetPlayerPing(%0) 0

#if defined _ALS_GetPlayerVersion
    #undef GetPlayerVersion
#else
    #define _ALS_GetPlayerVersion
#endif
 
#define GetPlayerVersion(%0,%1,%2) strcpy(%1, "0.3z-RC4",%2)

#if defined _ALS_GetPlayerAmmo
    #undef GetPlayerAmmo
#else
    #define _ALS_GetPlayerAmmo
#endif

#define GetPlayerAmmo(%0) MockPlayer[%0][mu_ammo][MockPlayer[%0][mu_current_weapon]] 

#if defined _ALS_SetPlayerAmmo
    #undef SetPlayerAmmo
#else
    #define _ALS_SetPlayerAmmo
#endif

#define SetPlayerAmmo(%0,%1,%2) ((0 <= %1 <= 12) ? (MockPlayer[%0][mu_ammo][%1] = %2) : 1)

/*
#if defined _ALS_GetPlayerAnimationIndex
    #undef GetPlayerAnimationIndex
#else
    #define _ALS_GetPlayerAnimationIndex
#endif

#define GetPlayerAnimationIndex(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_animation_index],%2)

#if defined _ALS_GetPlayerArmour
    #undef GetPlayerArmour
#else
    #define _ALS_GetPlayerArmour
#endif

#define GetPlayerArmour(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_armour],%2)

#if defined _ALS_GetPlayerCameraAspectRatio
    #undef GetPlayerCameraAspectRatio
#else
    #define _ALS_GetPlayerCameraAspectRatio
#endif

#define GetPlayerCameraAspectRatio(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_aspect_ratio],%2)

#if defined _ALS_GetPlayerCameraFrontVector
    #undef GetPlayerCameraFrontVector
#else
    #define _ALS_GetPlayerCameraFrontVector
#endif

#define GetPlayerCameraFrontVector(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_front_vector],%2)

#if defined _ALS_GetPlayerCameraMode
    #undef GetPlayerCameraMode
#else
    #define _ALS_GetPlayerCameraMode
#endif

#define GetPlayerCameraMode(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_mode],%2)

#if defined _ALS_GetPlayerCameraPos
    #undef GetPlayerCameraPos
#else
    #define _ALS_GetPlayerCameraPos
#endif

#define GetPlayerCameraPos(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_pos],%2)

#if defined _ALS_GetPlayerCameraUpVector
    #undef GetPlayerCameraUpVector
#else
    #define _ALS_GetPlayerCameraUpVector
#endif

#define GetPlayerCameraUpVector(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_up_vector],%2)

#if defined _ALS_GetPlayerCameraZoom
    #undef GetPlayerCameraZoom
#else
    #define _ALS_GetPlayerCameraZoom
#endif

#define GetPlayerCameraZoom(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_camera_zoom],%2)

#if defined _ALS_GetPlayerColor
    #undef GetPlayerColor
#else
    #define _ALS_GetPlayerColor
#endif

#define GetPlayerColor(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_color],%2)

#if defined _ALS_GetPlayerDistanceFromPoint
    #undef GetPlayerDistanceFromPoint
#else
    #define _ALS_GetPlayerDistanceFromPoint
#endif

#define GetPlayerDistanceFromPoint(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_distance_from_point],%2)

#if defined _ALS_GetPlayerDrunkLevel
    #undef GetPlayerDrunkLevel
#else
    #define _ALS_GetPlayerDrunkLevel
#endif

#define GetPlayerDrunkLevel(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_drunk_level],%2)

#if defined _ALS_GetPlayerFacingAngle
    #undef GetPlayerFacingAngle
#else
    #define _ALS_GetPlayerFacingAngle
#endif

#define GetPlayerFacingAngle(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_facing_angle],%2)

#if defined _ALS_GetPlayerFightingStyle
    #undef GetPlayerFightingStyle
#else
    #define _ALS_GetPlayerFightingStyle
#endif

#define GetPlayerFightingStyle(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_fighting_style],%2)

#if defined _ALS_GetPlayerHealth
    #undef GetPlayerHealth
#else
    #define _ALS_GetPlayerHealth
#endif

#define GetPlayerHealth(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_health],%2)

#if defined _ALS_GetPlayerIp
    #undef GetPlayerIp
#else
    #define _ALS_GetPlayerIp
#endif

#define GetPlayerIp(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_ip],%2)

#if defined _ALS_GetPlayerKeys
    #undef GetPlayerKeys
#else
    #define _ALS_GetPlayerKeys
#endif

#define GetPlayerKeys(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_keys],%2)

#if defined _ALS_GetPlayerLastShotVectors
    #undef GetPlayerLastShotVectors
#else
    #define _ALS_GetPlayerLastShotVectors
#endif

#define GetPlayerLastShotVectors(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_last_shot_vectors],%2)

#if defined _ALS_GetPlayerMenu
    #undef GetPlayerMenu
#else
    #define _ALS_GetPlayerMenu
#endif

#define GetPlayerMenu(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_menu],%2)

#if defined _ALS_GetPlayerMoney
    #undef GetPlayerMoney
#else
    #define _ALS_GetPlayerMoney
#endif

#define GetPlayerMoney(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_money],%2)

#if defined _ALS_GetPlayerName
    #undef GetPlayerName
#else
    #define _ALS_GetPlayerName
#endif

#define GetPlayerName(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_name],%2)

#if defined _ALS_GetPlayerNetworkStats
    #undef GetPlayerNetworkStats
#else
    #define _ALS_GetPlayerNetworkStats
#endif

#define GetPlayerNetworkStats(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_network_stats],%2)

#if defined _ALS_GetPlayerObjectPos
    #undef GetPlayerObjectPos
#else
    #define _ALS_GetPlayerObjectPos
#endif

#define GetPlayerObjectPos(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_object_pos],%2)

#if defined _ALS_GetPlayerObjectRot
    #undef GetPlayerObjectRot
#else
    #define _ALS_GetPlayerObjectRot
#endif

#define GetPlayerObjectRot(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_object_rot],%2)

#if defined _ALS_GetPlayerPing
    #undef GetPlayerPing
#else
    #define _ALS_GetPlayerPing
#endif


#define GetPlayerSurfingObjectID(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_surfing_object_id],%2)

#if defined _ALS_GetPlayerSurfingVehicleID
    #undef GetPlayerSurfingVehicleID
#else
    #define _ALS_GetPlayerSurfingVehicleID
#endif

#define GetPlayerSurfingVehicleID(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_surfing_vehicle_id],%2)

#if defined _ALS_GetPlayerTargetPlayer
    #undef GetPlayerTargetPlayer
#else
    #define _ALS_GetPlayerTargetPlayer
#endif

#define GetPlayerTargetPlayer(%0,%1,%2) INVALID_PLAYER_ID

#if defined _ALS_GetPlayerTeam
    #undef GetPlayerTeam
#else
    #define _ALS_GetPlayerTeam
#endif

#define GetPlayerTeam(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_team],%2)

#if defined _ALS_GetPlayerTime
    #undef GetPlayerTime
#else
    #define _ALS_GetPlayerTime
#endif

#define GetPlayerTime(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_time],%2)

#if defined _ALS_GetPlayerVehicleID
    #undef GetPlayerVehicleID
#else
    #define _ALS_GetPlayerVehicleID
#endif

#define GetPlayerVehicleID(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_vehicle_id],%2)

#if defined _ALS_GetPlayerVehicleSeat
    #undef GetPlayerVehicleSeat
#else
    #define _ALS_GetPlayerVehicleSeat
#endif

#define GetPlayerVehicleSeat(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_vehicle_seat],%2)

#if defined _ALS_GetPlayerVelocity
    #undef GetPlayerVelocity
#else
    #define _ALS_GetPlayerVelocity
#endif

#define GetPlayerVelocity(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_velocity],%2)

#if defined _ALS_GetPlayerWantedLevel
    #undef GetPlayerWantedLevel
#else
    #define _ALS_GetPlayerWantedLevel
#endif

#define GetPlayerWantedLevel(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_wanted_level],%2)

#if defined _ALS_GetPlayerWeapon
    #undef GetPlayerWeapon
#else
    #define _ALS_GetPlayerWeapon
#endif

#define GetPlayerWeapon(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_weapon],%2)

#if defined _ALS_GetPlayerWeaponData
    #undef GetPlayerWeaponData
#else
    #define _ALS_GetPlayerWeaponData
#endif

#define GetPlayerWeaponData(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_weapon_data],%2)

#if defined _ALS_GetPlayerWeaponState
    #undef GetPlayerWeaponState
#else
    #define _ALS_GetPlayerWeaponState
#endif

#define GetPlayerWeaponState(%0,%1,%2) strcpy(%1, MockPlayer[%0][mu_weapon_state],%2)
*/


#if defined _ALS_IsPlayerConnected
    #undef IsPlayerConnected
#else
    #define _ALS_IsPlayerConnected
#endif
 
#define IsPlayerConnected(%0) 1

#if defined _ALS_IsPlayerAdmin
    #undef IsPlayerAdmin
#else
    #define _ALS_IsPlayerAdmin
#endif
 
#define IsPlayerAdmin(%0) MockPlayer[%0][mu_rcon_admin]

#if defined _ALS_IsPlayerInAnyVehicle
    #undef IsPlayerInAnyVehicle
#else
    #define _ALS_IsPlayerInAnyVehicle
#endif
 
#define IsPlayerInAnyVehicle(%0) (MockPlayer[%0][mu_vehicle_id] != INVALID_VEHICLE_ID)

#if defined _ALS_IsPlayerInVehicle
    #undef IsPlayerInVehicle
#else
    #define _ALS_IsPlayerInVehicle
#endif
 
#define IsPlayerInVehicle(%0,%1) (MockPlayer[%0][mu_vehicle_id] ==%1)

#define DEFAULT_NAME "Mock_Player_"

TestInit:PopulationComplete()
{
	static const
		stub[] = DEFAULT_NAME;

	new
		tmp[MAX_PLAYER_NAME + 1];

	memset(MockPlayer[0][E_MOCK_PLAYER:0], 0, (MAX_PLAYERS * _:E_MOCK_PLAYER));

	for(new i = 0; i != MAX_PLAYERS; ++i) {
		format(tmp, sizeof tmp, "%s%d", stub, i);
		SetPlayerName(i, tmp);

		if(i == 0) {
			MockPlayer[0][mu_vehicle_id] = INVALID_VEHICLE_ID;
			MockPlayer[0][mu_spectating_player] = INVALID_PLAYER_ID;
			MockPlayer[0][mu_skin] = 1;
			MockPlayer[0][mu_surfing_object_id] = INVALID_OBJECT_ID;
			MockPlayer[0][mu_surfing_vehicle_id] = INVALID_VEHICLE_ID;
		} else {
			//Copy everything, except nick
			new
				offset = _:mu_pos;
			memcpy(MockPlayer[i][E_MOCK_PLAYER:offset], MockPlayer[0][E_MOCK_PLAYER:offset], 0, (_:E_MOCK_PLAYER - offset) * 4, (_:E_MOCK_PLAYER - offset) * 4);
		}
	}
}

Test:PopulationComplete()
{
	print("Make sure that names are generated properly");
	ASSERT(!isnull(MockPlayer[127][mu_username]));
	ASSERT(!strcmp(MockPlayer[127][mu_username], "" DEFAULT_NAME "127", false));

	print("Make sure that vehicles are copied properly");
	ASSERT(MockPlayer[MAX_PLAYERS - 15][mu_vehicle_id] == INVALID_VEHICLE_ID));
}