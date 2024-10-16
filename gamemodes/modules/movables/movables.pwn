//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------
CreateBox(model, type, value, Float:x, Float:y, Float:z, int=0, vw=0, Float:angle=-1.0)
{
	new id = GetFreeBoxId();
	if(id == -1) return -1;

	Boxes[id][box_used] = true;
	Boxes[id][box_type] = type;
	Boxes[id][box_model] = model;
	Boxes[id][box_object] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, angle, vw, int);
	if(type == BOX_TYPE_CONTRABAND_ACTION)
	{
		Boxes[id][box_flare] = CreateDynamicObject(18728, x, y, z - 1.0, 0.0, 0.0, angle, vw, int);
	}
	Boxes[id][box_player] = -1;
	Boxes[id][box_x] = x;
	Boxes[id][box_y] = y;
	Boxes[id][box_z] = z;
	if(angle == -1.0) Boxes[id][box_angle] = float(random(360));
	else Boxes[id][box_angle] = angle;
	Boxes[id][box_int] = int;
	Boxes[id][box_vw] = vw;
	Boxes[id][box_initialBonus] = value;
	Boxes[id][box_bonus] = value;
	return id;
}

DestroyBox(boxid)
{
	if(!Boxes[boxid][box_used]) return 0;
	
	Boxes[boxid][box_used] = false;
	if(Boxes[boxid][box_object] != -1) 
	{
		DestroyDynamicObject(Boxes[boxid][box_object]);
	}
	if(Boxes[boxid][box_flare] != -1)
	{
		DestroyDynamicObject(Boxes[boxid][box_flare]);
	}
	new playerid = Boxes[boxid][box_player];
	if(playerid != -1)
	{
		RemovePlayerAttachedObject(Boxes[boxid][box_player], Boxes[boxid][box_attachedSlot]);
		carryingBox[playerid] = -1;
	}
	return 1;
}

DestroyBoxes()
{
	for(new i; i<MAX_BOXES; i++)
	{
		DestroyBox(i);
	}
}

PickupBox(playerid, boxid)
{
	new itemSlot = GetFreeAttachedObjectSlot(playerid);
	new type = Boxes[boxid][box_type];

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, itemSlot, Boxes[boxid][box_model], 5, 
		ObjectHoldingPos[type][0], ObjectHoldingPos[type][1], ObjectHoldingPos[type][2], 
		ObjectHoldingPos[type][3], ObjectHoldingPos[type][4], ObjectHoldingPos[type][5]);
	if(Boxes[boxid][box_object] != -1) 
	{
		DestroyDynamicObject(Boxes[boxid][box_object]);
	}
	if(Boxes[boxid][box_flare] != -1)
	{
		DestroyDynamicObject(Boxes[boxid][box_flare]);
	}
    ApplyAnimation(playerid,"CARRY","liftup", 4.0, 0, 0, 0, 0, 0);

    carryingBox[playerid] = boxid;
	Boxes[boxid][box_object] = -1;
	Boxes[boxid][box_flare] = -1;
	Boxes[boxid][box_player] = playerid;
	Boxes[boxid][box_attachedSlot] = itemSlot;

	OnPlayerPickupMovableObject(playerid, boxid, type);
    return 1;
}

DropBox(playerid)
{
	new boxid = carryingBox[playerid];
	if(boxid == -1) return -1;

	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 0.5);	
	GetPlayerFacingAngle(playerid, angle);
	new int = GetPlayerInterior(playerid);
	new vw = GetPlayerVirtualWorld(playerid);
	CA_RayCastLine(x, y, z + 1.0, x, y, -1000.0, x, y, z);
	z += GetColSphereRadius(Boxes[boxid][box_model]) * 2.0 - 0.8;

	ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 113); 
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	carryingBox[playerid] = -1;
	Boxes[boxid][box_player] = -1;

	Boxes[boxid][box_x] = x;
	Boxes[boxid][box_y] = y;
	Boxes[boxid][box_z] = z;
	Boxes[boxid][box_angle] = angle;
	Boxes[boxid][box_int] = int;
	Boxes[boxid][box_vw] = vw;

	OnPlayerDropMovableObject(playerid, boxid, Boxes[boxid][box_type], x, y, z, angle);

	defer AfterDropBox(playerid, boxid, x, y, z, angle, int, vw);
	return boxid;
}

timer AfterDropBox[113](playerid, boxid, Float:x, Float:y, Float:z, Float:angle, int, vw)
{
	if(Boxes[boxid][box_used])
	{
		Boxes[boxid][box_object] = CreateDynamicObject(Boxes[boxid][box_model], x, y, z, 0.0, 0.0, angle, vw, int);
		Streamer_Update(playerid);
	}

	if(IsPlayerConnected(playerid))
	{
		RemovePlayerAttachedObject(playerid, Boxes[boxid][box_attachedSlot]);
	}
	return 1;
}

IsPlayerCarryingBox(playerid)
{
	return carryingBox[playerid] != -1;
}

GetFreeBoxId()
{
	for(new i; i<MAX_BOXES; i++)
	{
		if(!Boxes[i][box_used]) return i;
	}
	return -1;
}

GetNearestBox(playerid)
{
	for(new i; i<MAX_BOXES; i++)
	{
		if(Boxes[i][box_used] && Boxes[i][box_player] == -1 && 
			GetPlayerVirtualWorld(playerid) == Boxes[i][box_vw] && 
			GetPlayerInterior(playerid) == Boxes[i][box_int] &&
			IsPlayerInRangeOfPoint(playerid, PICKUP_BOX_RANGE, Boxes[i][box_x], Boxes[i][box_y], Boxes[i][box_z]))
		{
			return i;
		}
	}
	return -1;
}

DropBoxFromCar(model, type, value, carid)
{
	new Float:x, Float:y, Float:z, Float:angle;
	GetPosBehindVehicle(carid, x, y, z);
	GetVehicleZAngle(carid, angle);

	CA_FindZ_For2DCoord(x, y, z);
	z += GetColSphereRadius(model) * 2.0 - 0.8;

	return CreateBox(model, type, value, x, y, z, 0, 0, angle);
}

//-----------------<[ 3rd party: ]>-------------------
stock GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5) //Credits go to MP2
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
} 

stock GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)//Credits go to MP2
{
    new Float:a;
    GetVehiclePos(vehicleid, q, w, a);
    GetVehicleZAngle(vehicleid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
}  


//end