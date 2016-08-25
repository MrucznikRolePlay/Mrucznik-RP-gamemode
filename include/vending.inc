//------------------------------------------------------------------------------

/*
	SA-MP Vending Machine include

	Description:
		This include provide code to create server-side vending machines in SA-MP.

	License:
		The MIT License (MIT)
		Copyright (c) 2014 Larceny
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.

	Author:
		Larceny

	Contributors:
		Y_Less
		Abagail
		J'Zargo

	Version:
		1.9.1
*/

//------------------------------------------------------------------------------

#if defined _vendingm_included
	#endinput
#endif
#define _vendingm_included

//------------------------------------------------------------------------------

#if !defined MAX_MACHINES
	#define MAX_MACHINES 			128
#endif

#define OBJECT_TYPE_NORMAL			0
#define OBJECT_TYPE_DYNAMIC			1
#define MACHINE_SNACK 				956
#define MACHINE_SPRUNK 				955
#define MACHINE_SODA				1302

#define SODA_RADIUS					1.2
#define SPRUNK_RADIUS				1.05
#define SNACK_RADIUS				1.05

#define INVALID_MACHINE_ID			-1

//------------------------------------------------------------------------------

/*Natives
native CreateVendingMachine(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
native GetVendingMachineRot(machineid, &Float:rx, &Float:ry, &Float:rz);
native SetVendingMachineRot(machineid, Float:rx, Float:ry, Float:rz);
native GetVendingMachinePos(machineid, &Float:x, &Float:y, &Float:z);
native SetVendingMachinePos(machineid, Float:x, Float:y, Float:z);
native SetVendingMachineColor(machineid, color);
native OnPlayerUseVendinMachine(playerid, machineid);
native GetVendingMachineColor(machineid);
native DestroyVendingMachine(machineid);
native GetVendingMachineType(machineid);
native IsValidVendingMachine(machineid);*/

//------------------------------------------------------------------------------

// Temporary:

#define CreateMachine 		CreateVendingMachine
#define DestroyMachine 		DestroyVendingMachine

#define GetMachineRot 		GetVendingMachineRot
#define SetMachineRot 		SetVendingMachineRot

#define GetMachinePos 		GetVendingMachinePos
#define SetMachinePos 		SetVendingMachinePos

#define GetMachineType 		GetVendingMachineType
#define IsValidMachine 		IsValidVendingMachine

//------------------------------------------------------------------------------

enum E_VENDING_DATA
{
	Float:E_VENDING_X,
	Float:E_VENDING_Y,
	Float:E_VENDING_Z,
	Float:E_VENDING_RX,
	Float:E_VENDING_RY,
	Float:E_VENDING_RZ,
	Float:E_VENDING_RADIUS,
	E_VENDING_COLOR,
	E_VENDING_TYPE,
	E_VENDING_ID
}
static g_eVendingData[MAX_MACHINES][E_VENDING_DATA];

//------------------------------------------------------------------------------

static Float:ve_ma_locations[][] = 
{
	// MODELID, X, Y, Z, RX, RY, RZ, INT

	// Snack machines
	{956.0, 2480.8594, -1959.2734, 12.9609, 0.000000, 0.0000, 180.00, 0.0}, // GTH Street Plaza			- Los Santos
	{956.0, 1634.1094, -2237.5313, 12.8906, 0.000000, 0.0000, 0.0000, 0.0}, // International Airport	- Los Santos
	{956.0, 2139.5156, -1161.4844, 23.3594, 0.000000, 0.0173, 90.000, 0.0}, // Coutt and Schutz			- Los Santos
	{956.0, 2153.2344, -1016.1484, 62.2344, 0.000000, -0.0165, 130.0, 0.0}, // Carniceria El Pueblo		- Los Santos
	{956.0, -1350.1172, 493.85940, 10.5859, 0.000000, 0.0000, 90.000, 0.0}, // Militar Ship 			- San Fierro
	{956.0, -2229.1875, 286.41410, 34.7031, 0.000000, 0.0000, 180.00, 0.0}, // Near construction		- San Fierro
	{956.0, 1659.46090, 1722.8594, 10.2188, 0.000000, 0.0000, 0.0000, 0.0}, // Binco 					- Las Venturas
	{956.0, 2647.69530, 1129.6641, 10.2188, 0.000000, 0.0000, 0.0000, 0.0}, // Gas Station 				- Las Venturas
	{956.0, 2845.72660, 1295.0469, 10.7891, 0.000000, 0.0000, 0.0000, 0.0}, // Linden Station 			- Las Venturas
	{956.0, 1398.84380, 2222.6094, 10.4219, 0.000000, 0.0000, 180.00, 0.0}, // Bandits Stadium			- Las Venturas
	{956.0, -1455.1172, 2591.6641, 55.2344, 0.000000, 0.0000, 180.00, 0.0}, // Barbers 					- El Quebrados
	{956.0, -76.031300, 1227.9922, 19.1250, 0.000000, 0.0000, 90.0000, 0.0}, // Motel					- ?
	{956.0, 662.429700, -552.1641, 15.7109, 0.000000, 0.0000, 180.00, 0.0}, // Gas station 				- Dillimore
	{956.0, -253.74220, 2599.7578, 62.2422, 0.000000, 0.0000, 90.0000, 0.0}, // Near the big pecker		- Las Payasadas
	{956.0, 2271.72660, -76.46090, 25.9609, 0.000000, 0.0000, 0.0000, 0.0}, // Library					- ?
	{956.0, -33.875000, -186.7656, 1003.6328, 0.0000, 0.0000, 0.0000, 17.0}, // 24-7 1 					- 24-7
	{956.0, -17.546900, -91.71090, 1003.6328, 0.0000, 0.0000, 0.0000, 18.0}, // 24-7 3 					- 24-7
	{956.0, -16.531300, -140.2969, 1003.6328, 0.0000, 0.0000, 0.0000, 16.0}, // 24-7 4 					- 24-7
	{956.0, -36.148400, -57.87500, 1003.6328, 0.0000, 0.0000, 0.0000, 6.0}, // 24-7 6 					- 24-7

	// Sprunk machines
	{955.0, 2225.2031, -1153.4219, 1025.9063, 0.000000, 0.0000, 270.0000, 15.0}, // Jefferson Motel 	- Interior
	{955.0, 1789.2109, -1369.2656, 15.164100, 0.000000, 0.0000, 270.000, 0.0}, // Near skate park 		- Los Santos
	{955.0, 1729.7891, -1943.0469, 12.945300, 0.000000, 0.0000, 0.00000, 0.0}, // Unity Station 		- Los Santos
	{955.0, 2060.1172, -1897.6406, 12.929700, 0.000000, 0.0000, 0.00000, 0.0}, // Near pizza stack 		- Los Santos
	{955.0, 1928.7344, -1772.4453, 12.945300, 0.000000, 0.0000, 90.0000, 0.0}, // Gas station 			- Los Santos
	{955.0, 2325.9766, -1645.1328, 14.210900, 0.000000, 0.0000, 0.00000, 0.0}, // Ten green bottles 	- Los Santos
	{955.0, 2352.1797, -1357.1563, 23.773400, 0.000000, 0.0000, 90.0000, 0.0}, // Near the pig pen 		- Los Santos
	{955.0, 1154.7266, -1460.8906, 15.156300, 0.000000, 0.0000, 270.000, 0.0}, // The mall 				- Los Santos
	{955.0, -1350.117, 492.289100, 10.585900, 0.000000, 0.0000, 90.0000, 0.0}, // Militar Ship 			- San Fierro
	{955.0, -2118.617, -422.41410, 34.726600, 0.000000, 0.0000, 250.000, 0.0}, // Corvin Stadium (left)	- San Fierro
	{955.0, -2118.968, -423.64840, 34.726600, 0.000000, 0.0000, 250.000, 0.0}, // Corvin Stadium (right)- San Fierro
	{955.0, -2097.273, -398.33590, 34.726600, 0.000000, 0.0000, 180.000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2092.085, -490.05470, 34.726600, 0.000000, 0.0000, 0.00000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2063.273, -490.05470, 34.726600, 0.000000, 0.0000, 0.00000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2005.648, -490.05470, 34.726600, 0.000000, 0.0000, 0.00000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2034.460, -490.05470, 34.726600, 0.000000, 0.0000, 0.00000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2068.562, -398.33590, 34.726600, 0.000000, 0.0000, 180.000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2039.851, -398.33590, 34.726600, 0.000000, 0.0000, 180.000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -2011.140, -398.33590, 34.726600, 0.000000, 0.0000, 180.000, 0.0}, // Corvin Stadium		- San Fierro
	{955.0, -1980.789, 142.664100, 27.070300, 0.000000, 0.0000, 270.0000, 0.0}, // Train Station 		- San Fierro
	{955.0, 2319.9922, 2532.85160, 10.218800, 0.000000, 0.0000, 0.00000, 0.0}, // Near LVPD				- Las Venturas
	{955.0, 1520.1484, 1055.26560, 10.000000, 0.000000, 0.0000, 270.0000, 0.0}, // LV Hospital 			- Las Venturas
	{955.0, 2503.1406, 1243.69530, 10.218800, 0.000000, 0.0000, 180.000, 0.0}, // Near pyramid			- Las Venturas
	{955.0, 2085.7734, 2071.35940, 10.453100, 0.000000, 0.0000, 90.0000, 0.0}, // Sex Shop 				- Las Venturas
	{955.0, -862.8281, 1536.60940, 21.984400, 0.000000, 0.0000, 180.000, 0.0}, // Near big cow			- ?
	{955.0, -14.70310, 1175.35940, 18.953100, 0.000000, 0.0000, 180.000, 0.0}, // Below small cow 		- ?
	{955.0, -253.7422, 2597.95310, 62.242200, 0.000000, 0.0000, 90.00000, 0.0}, // Near the big pecker	- Las Payasadas
	{955.0, 201.01560, -107.61720, 0.8984000, 0.000000, 0.0000, 270.0000, 0.0}, // Near last drop		- ?
	{955.0, 1277.8359, 372.515600, 18.953100, 0.000000, 0.0000, 70.00000, 0.0}, // Papercuts 			- ?
	{955.0, -32.44530, -186.69530, 1003.6328, 0.000000, 0.0000, 0.0000, 17.0}, // 24-7 1 				- 24-7
	{955.0, -16.11720, -91.640600, 1003.6328, 0.000000, 0.0000, 0.0000, 18.0}, // 24-7 3 				- 24-7
	{955.0, -15.10160, -140.22660, 1003.6328, 0.000000, 0.0000, 0.0000, 16.0}, // 24-7 4 				- 24-7
	{955.0, -19.03910, -57.835900, 1003.6328, 0.000000, 0.0000, 0.0000, 6.00}, // 24-7 6 				- 24-7

	// Soda machines
	{1302.0, -2420.2188, 984.5781, 44.2969, 3.1416, 0.0000, 90.0000, 0.0}, // Gas Station (left)		- San Fierro
	{1302.0, -2420.1797, 985.9453, 44.2969, 3.1416, 0.0000, 90.0000, 0.0} // Gas Station (right)		- San Fierro
};

//------------------------------------------------------------------------------

forward OnPlayerUseVendingMachine(playerid, machineid);
#if !defined NO_SPRUNK_ACTION
forward OnPlayerDrinkSprunk(playerid);
forward ven_SetPlayerAnimation(playerid);
#endif

//------------------------------------------------------------------------------

stock CreateVendingMachine(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new machineid = GetFreeMachineID();

	if(machineid == INVALID_MACHINE_ID)
	{
		print("ERROR: Limit of vending machines exceeded! Increase the limit or reduce the created machines.");
		return 0;
	}

	switch(modelid)
	{
		case MACHINE_SPRUNK:
			g_eVendingData[machineid][E_VENDING_RADIUS] = SPRUNK_RADIUS;
		case MACHINE_SNACK:
			g_eVendingData[machineid][E_VENDING_RADIUS] = SNACK_RADIUS;
		case MACHINE_SODA:
			g_eVendingData[machineid][E_VENDING_RADIUS] = SODA_RADIUS;
		default:
		{
			printf("ERROR: Invalid vending object id! (Used ID: %i - Valid IDs: 955, 956 or 1302)", modelid);
			return 0;
		}
	}

	#if defined Streamer_IncludeFileVersion
		g_eVendingData[machineid][E_VENDING_ID]	= CreateDynamicObject(modelid, x, y, z, rx, ry, rz);
	#else
		g_eVendingData[machineid][E_VENDING_ID]	= CreateObject(modelid, x, y, z, rx, ry, rz, 300.0);
	#endif

	g_eVendingData[machineid][E_VENDING_X]	= x;
	g_eVendingData[machineid][E_VENDING_Y]	= y;
	g_eVendingData[machineid][E_VENDING_Z]	= z;

	g_eVendingData[machineid][E_VENDING_RX]	= rx;
	g_eVendingData[machineid][E_VENDING_RY]	= ry;
	g_eVendingData[machineid][E_VENDING_RZ]	= rz;

	g_eVendingData[machineid][E_VENDING_TYPE] = modelid;
	return machineid;
}

//------------------------------------------------------------------------------

stock DestroyVendingMachine(machineid)
{
	if(!IsValidVendingMachine(machineid))
		return 0;

	#if defined Streamer_IncludeFileVersion
	DestroyDynamicObject(g_eVendingData[machineid][E_VENDING_ID]);
	#else
	DestroyObject(g_eVendingData[machineid][E_VENDING_ID]);
	#endif

	g_eVendingData[machineid][E_VENDING_ID] = INVALID_MACHINE_ID;

	g_eVendingData[machineid][E_VENDING_X] = 0.0;
	g_eVendingData[machineid][E_VENDING_Y] = 0.0;
	g_eVendingData[machineid][E_VENDING_Z] = 0.0;

	g_eVendingData[machineid][E_VENDING_RX] = 0.0;
	g_eVendingData[machineid][E_VENDING_RY] = 0.0;
	g_eVendingData[machineid][E_VENDING_RZ] = 0.0;

	g_eVendingData[machineid][E_VENDING_TYPE] = 0;
	return 1;
}

//------------------------------------------------------------------------------

stock SetVendingMachineColor(machineid, color)
{
	if(!IsValidVendingMachine(machineid) || GetVendingMachineType(machineid) == MACHINE_SNACK)
		return 0;

	#if defined Streamer_IncludeFileVersion
	if(GetVendingMachineType(machineid) == MACHINE_SODA) {
		SetDynamicObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 0, -1, "none", "none", color);
		SetDynamicObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 1, -1, "none", "none", color);
	}
	else {
		SetDynamicObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 0, -1, "none", "none", color);
	}
	#else
	if(GetVendingMachineType(machineid) == MACHINE_SODA) {
		SetObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 0, -1, "none", "none", color);
		SetObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 1, -1, "none", "none", color);
	}
	else {
		SetObjectMaterial(g_eVendingData[machineid][E_VENDING_ID], 0, -1, "none", "none", color);
	}
	#endif

	g_eVendingData[machineid][E_VENDING_COLOR] = color;
	return 1;
}

//------------------------------------------------------------------------------

stock GetVendingMachineColor(machineid)
	return g_eVendingData[machineid][E_VENDING_COLOR];

//------------------------------------------------------------------------------

stock GetVendingMachineObjectType(machineid)
{
       #if defined Streamer_IncludeFileVersion
		return OBJECT_TYPE_DYNAMIC;
	#else
	        return OBJECT_TYPE_NORMAL;
	#endif
}

//------------------------------------------------------------------------------
stock IsValidVendingMachine(machineid)
	return !(g_eVendingData[machineid][E_VENDING_X] == 0.0 && g_eVendingData[machineid][E_VENDING_Y] == 0.0);

//------------------------------------------------------------------------------

stock GetVendingMachineType(machineid)
	return g_eVendingData[machineid][E_VENDING_TYPE];

//------------------------------------------------------------------------------

stock GetFreeMachineID()
{
	for(new i; i < MAX_MACHINES; i++)
		if(g_eVendingData[i][E_VENDING_X] == 0.0 && g_eVendingData[i][E_VENDING_Y] == 0.0)
			return i;

	return INVALID_MACHINE_ID;
}

//------------------------------------------------------------------------------

stock SetVendingMachinePos(machineid, Float:x, Float:y, Float:z)
{
	if(!IsValidVendingMachine(machineid))
		return 0;

	g_eVendingData[machineid][E_VENDING_X] = x;
	g_eVendingData[machineid][E_VENDING_Y] = y;
	g_eVendingData[machineid][E_VENDING_Z] = z;

	#if defined Streamer_IncludeFileVersion
	SetDynamicObjectPos(g_eVendingData[machineid][E_VENDING_ID], x, y, z);
	#else
	SetObjectPos(g_eVendingData[machineid][E_VENDING_ID], x, y, z);
	#endif
	return 1;
}

//------------------------------------------------------------------------------

stock SetVendingMachineRot(machineid, Float:rx, Float:ry, Float:rz)
{
	if(!IsValidVendingMachine(machineid))
		return 0;

	g_eVendingData[machineid][E_VENDING_RX] = rx;
	g_eVendingData[machineid][E_VENDING_RY] = ry;
	g_eVendingData[machineid][E_VENDING_RZ] = rz;


	#if defined Streamer_IncludeFileVersion
	SetDynamicObjectRot(g_eVendingData[machineid][E_VENDING_ID], rx, ry, rz);
	#else
	SetObjectRot(g_eVendingData[machineid][E_VENDING_ID], rx, ry, rz);
	#endif
	return 1;
}

//------------------------------------------------------------------------------

stock GetVendingMachinePos(machineid, &Float:x, &Float:y, &Float:z)
{
	if(!IsValidVendingMachine(machineid))
		return 0;

	x = g_eVendingData[machineid][E_VENDING_X];
	y = g_eVendingData[machineid][E_VENDING_Y];
	z = g_eVendingData[machineid][E_VENDING_Z];
	return 1;
}

//------------------------------------------------------------------------------

stock GetVendingMachineRot(machineid, &Float:rx, &Float:ry, &Float:rz)
{
	if(!IsValidVendingMachine(machineid))
		return 0;

	rx = g_eVendingData[machineid][E_VENDING_RX];
	ry = g_eVendingData[machineid][E_VENDING_RY];
	rz = g_eVendingData[machineid][E_VENDING_RZ];
	return 1;
}

//------------------------------------------------------------------------------

stock GetVendingMachineObjectID(machineid)
	return g_eVendingData[machineid][E_VENDING_ID];

//------------------------------------------------------------------------------

GetXYInFrontOfVending(machineid, &Float:x, &Float:y, Float:distance)
{
	new Float:a, Float:z;
	GetVendingMachineRot(machineid, x, y, a);
	GetVendingMachinePos(machineid, x, y, z);

	a += 180.0;
	if(a > 359.0) a -= 359.0;

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

//------------------------------------------------------------------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_SECONDARY_ATTACK) && (GetPlayerAnimationIndex(playerid) != 1660 && GetPlayerAnimationIndex(playerid) != 1224))
	{
		for(new i; i < MAX_MACHINES; i++)
		{
			if(!IsValidVendingMachine(i))
				continue;

			new Float:x, Float:y;
			GetXYInFrontOfVending(i, x, y, 0.5);
			if(!IsPlayerInRangeOfPoint(playerid, g_eVendingData[i][E_VENDING_RADIUS], x, y, g_eVendingData[i][E_VENDING_Z]))
				continue;

			SetPlayerFacingAngle(playerid, g_eVendingData[i][E_VENDING_RZ]);
			if(OnPlayerUseVendingMachine(playerid, i) != 0)
			{
				ApplyAnimation(playerid, "VENDING", "VEND_USE", 10.0, 0, 0, 0, 0, 0, 1);
				if(g_eVendingData[i][E_VENDING_TYPE] == MACHINE_SNACK) PlayerPlaySound(playerid, 42601, 0.0, 0.0, 0.0);
				else PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
			
				#if !defined NO_SPRUNK_ACTION
				if(g_eVendingData[i][E_VENDING_TYPE] == MACHINE_SPRUNK) SetTimerEx("ven_SetPlayerAnimation", 2500, false, "i", playerid);
				#endif
			}
			else ClearAnimations(playerid);
		}
	}
	#if !defined NO_SPRUNK_ACTION
	else if((newkeys & KEY_FIRE) && (GetPVarInt(playerid, "ven_lastDrink") < GetTickCount()) && (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK))
	{
		OnPlayerDrinkSprunk(playerid);
		SetPVarInt(playerid, "ven_lastDrink", GetTickCount() + 2350);
	}
	#endif
	#if defined inc_Ven_OnPlayerKeyStateChange
		return inc_Ven_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange inc_Ven_OnPlayerKeyStateChange
#if defined inc_Ven_OnPlayerKeyStateChange
	forward inc_Ven_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

//------------------------------------------------------------------------------

#if !defined NO_SPRUNK_ACTION
public ven_SetPlayerAnimation(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	return 1;
}
#endif

//------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	for(new i; i < sizeof(ve_ma_locations); i++)
	{
		RemoveBuildingForPlayer(playerid, floatround(ve_ma_locations[i][0]), ve_ma_locations[i][1], ve_ma_locations[i][2], ve_ma_locations[i][3], 0.25);
	}
	#if defined inc_Ven_OnPlayerConnect
		return inc_Ven_OnPlayerConnect(playerid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect inc_Ven_OnPlayerConnect
#if defined inc_Ven_OnPlayerConnect
	forward inc_Ven_OnPlayerConnect(playerid);
#endif

//------------------------------------------------------------------------------

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
	{
		for(new i; i < sizeof(ve_ma_locations); i++)
		{
			CreateVendingMachine(floatround(ve_ma_locations[i][0]), ve_ma_locations[i][1], ve_ma_locations[i][2], ve_ma_locations[i][3], ve_ma_locations[i][4], ve_ma_locations[i][5], ve_ma_locations[i][6]);
		}

		#if defined inc_Ven_OnFilterScriptInit
			return inc_Ven_OnFilterScriptInit();
		#else
			return 0;
		#endif
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif

	#define OnFilterScriptInit inc_Ven_OnFilterScriptInit
	#if defined inc_Ven_OnFilterScriptInit
		forward inc_Ven_OnFilterScriptInit();
	#endif

	public OnFilterScriptExit()
	{
		for(new i; i < sizeof(ve_ma_locations); i++)
		{
			DestroyVendingMachine(i);
		}

		#if defined inc_Ven_OnFilterScriptExit
			return inc_Ven_OnFilterScriptExit();
		#else
			return 0;
		#endif
	}
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif

	#define OnFilterScriptExit inc_Ven_OnFilterScriptExit
	#if defined inc_Ven_OnFilterScriptExit
		forward inc_Ven_OnFilterScriptExit();
	#endif
#else
	public OnGameModeInit()
	{
		for(new i; i < sizeof(ve_ma_locations); i++)
		{
			CreateVendingMachine(floatround(ve_ma_locations[i][0]), ve_ma_locations[i][1], ve_ma_locations[i][2], ve_ma_locations[i][3], ve_ma_locations[i][4], ve_ma_locations[i][5], ve_ma_locations[i][6]);
		}

		#if defined inc_Ven_OnGameModeInit
			return inc_Ven_OnGameModeInit();
		#else
			return 0;
		#endif
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif

	#define OnGameModeInit inc_Ven_OnGameModeInit
	#if defined inc_Ven_OnGameModeInit
		forward inc_Ven_OnGameModeInit();
	#endif
#endif

//------------------------------------------------------------------------------
