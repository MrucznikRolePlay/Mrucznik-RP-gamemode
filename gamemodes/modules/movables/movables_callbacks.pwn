//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  movables                                                 //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: mrucznik
// Data utworzenia: 18.09.2024
//Opis:
/*
	System przedmiotów, które mo¿na przenosiæ i upuszczaæ.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Own Callbacks: ]>-----------------
OnPlayerDropMovableObject(playerid, boxid, boxType, Float:x, Float:y, Float:z, Float:angle)
{
	if(Convoy_OnPlayerDropMovable(playerid, boxid, boxType, x, y, z, angle)) return;
	if(Przemyt_OnPlayerDropMovable(playerid, boxid, boxType, x, y, z, angle)) return;
	return;
}

OnPlayerPickupMovableObject(playerid, boxid, boxType)
{
	if(Convoy_OnPlayerPickupMovable(playerid, boxid, boxType)) return;
	if(Przemyt_OnPlayerPickupMovable(playerid, boxid, boxType)) return;
	return;
}

OnPlayerShootMovableObject(playerid, weaponid, boxid, boxType)
{
	if(Przemyt_OnPlayerShootMovable(playerid, weaponid, boxid, boxType)) return 1;
	return 0;
}

//-----------------<[ Hooki: ]>-----------------
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_CROUCH))
	{
		new boxid = GetNearestBox(playerid);
		if(boxid != -1)
		{
			PickupBox(playerid, boxid);
		}
	}
	else if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		if(IsPlayerCarryingBox(playerid) && !IsPlayerInAnyVehicle(playerid))
		{
			DropBox(playerid);
		}
	}
	return 1;
}

Movable_OnPlayerShootObject(playerid, weaponid, STREAMER_TAG_OBJECT:objectid)
{
	for(new i; i<MAX_MOVABLES; i++)
	{
		if(Boxes[i][box_used] && Boxes[i][box_object] == objectid)
		{
			return OnPlayerShootMovableObject(playerid, weaponid, i, Boxes[i][box_type]);
		}
	}
	return 0;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused killerid, reason
	if(IsPlayerCarryingBox(playerid)) 
	{
		DropBox(playerid);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerCarryingBox(playerid)) 
	{
		DropBox(playerid);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	carryingBox[playerid] = -1;
	return 1;
}

//end