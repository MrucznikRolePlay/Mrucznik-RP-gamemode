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
CreateBox(objectid, type, value, Float:x, Float:y, Float:z, Float:rx=0.0, Float:ry=0.0, Float:rz=0.0)
{
	new id = GetFreeBoxId();
	if(id == -1) return -1;

	Boxes[id][box_used] = true;
	Boxes[id][box_type] = type;
	Boxes[id][box_object] = CreateDynamicObject(objectid, x, y, z, rx, ry, rz, 0, 0);
	Boxes[id][box_player] = -1;
	Boxes[id][box_x] = x;
	Boxes[id][box_y] = y;
	Boxes[id][box_z] = z;
	Boxes[id][box_bonus] = value;

	if(maxBoxID < id) maxBoxID = id;
	return id;
}

DestroyBox(boxid)
{
	Boxes[boxid][box_used] = false;
	if(Boxes[boxid][box_object] != -1) 
	{
		DestroyDynamicObject(Boxes[boxid][box_object]);
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

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, itemSlot, Boxes[boxid][box_object], 5, 0.110999, 0.287000, 0.178999, 5.699999, 18.999992, 5.999998);
	DestroyDynamicObject(Boxes[boxid][box_object]);
    ApplyAnimation(playerid,"CARRY","liftup", 4.0, 0, 0, 0, 0, 0);

    carryingBox[playerid] = boxid;
	Boxes[boxid][box_object] = -1;
	Boxes[boxid][box_player] = playerid;
	Boxes[boxid][box_attachedSlot] = itemSlot;

	OnPlayerPickupMovableObject(playerid, boxid, Boxes[boxid][box_type]);
    return 1;
}

DropBox(playerid)
{
	new boxid = carryingBox[playerid];
	if(boxid == -1) return -1;

	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 113); 
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	carryingBox[playerid] = -1;
	Boxes[boxid][box_player] = -1;

	Boxes[boxid][box_x] = x;
	Boxes[boxid][box_y] = y;
	Boxes[boxid][box_z] = z;

	OnPlayerDropMovableObject(playerid, boxid, Boxes[boxid][box_type], x, y, z, angle);

	defer AfterDropBox(playerid, boxid, x, y, z, angle);
	return boxid;
}

timer AfterDropBox[113](playerid, boxid, Float:x, Float:y, Float:z, Float:angle)
{
	Boxes[boxid][box_object] = CreateDynamicObject(Boxes[boxid][box_object], x, y, z-BOX_ONFOOT_Z_OFFSET, 0.0, 0.0, angle, 0, 0);
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
		if(Boxes[i][box_used] && Boxes[i][box_player] == -1 && IsPlayerInRangeOfPoint(playerid, PICKUP_BOX_RANGE, Boxes[i][box_x], Boxes[i][box_y], Boxes[i][box_z]))
		{
			return i;
		}
	}
	return -1;
}

DropBoxFromCar(objectid, type, value, carid)
{
	new Float:x, Float:y, Float:z;
	GetPosBehindVehicle(carid, x, y, z);

	return CreateBox(objectid, type, value, x, y, z-BOX_VEHICLE_Z_OFFSET);
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