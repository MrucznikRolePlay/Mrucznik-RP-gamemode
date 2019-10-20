//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   convoy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019
//Opis:
/*
	System konwojów.

	Zale¿noœci:
		player_attachments
		- GetFreeAttachedObjectSlot(playerid)
*/

//

//-----------------<[ Funkcje: ]>-------------------
StartConvoy(playerid, vehicleid)
{
	ConvoyStarted = true;

	convoyCar = vehicleid;
	SetVehicleHealth(vehicleid, CONVOY_CAR_HP);
	convoyCarHP = CONVOY_CAR_HP;
}

StopConvoy()
{
	ConvoyStarted = false;

	DestroyBoxes();
}

CreateBox(Float:x, Float:y, Float:z, Float:rx=0.0, Float:ry=0.0, Float:rz=0.0)
{
	new id = GetFreeBoxId();
	if(id == -1) return -1;

	Boxes[id][box_free] = false;
	Boxes[id][box_object] = CreateDynamicObject(BOX_OBJECT, x, y, z, rx, ry, rz, 0, 0);
	Boxes[id][box_player] = -1;
	Boxes[id][box_x] = x;
	Boxes[id][box_x] = y;
	Boxes[id][box_x] = z;
	Boxes[id][box_bonus] = random(BOX_BONUS)+BOX_BONUS_BASE;
	return id;
}

DestroyBox(boxid)
{
	Boxes[boxid][box_free] = true;
	if(Boxes[boxid][box_object] != -1) 
	{
		DestroyDynamicObject(Boxes[boxid][box_object]);
	}
	if(Boxes[boxid][box_player] != -1)
	{
		RemovePlayerAttachedObject(Boxes[boxid][box_player], Boxes[boxid][box_attachedSlot]);
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
    SetPlayerAttachedObject(playerid, itemSlot, BOX_OBJECT, 5, 0.110999, 0.287000, 0.178999, 5.699999, 18.999992, 5.999998);
    ApplyAnimation(playerid,"CARRY","liftup", 4.0, 0, 0, 0, 0, 0); 

    carryingBox[playerid] = boxid;
	Boxes[boxid][box_object] = -1;
	Boxes[boxid][box_player] = playerid;
	Boxes[boxid][box_attachedSlot] = itemSlot;
    return 1;
}

DropBox(playerid)
{
	new boxid = carryingBox[playerid];
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	Boxes[boxid][box_object] = CreateDynamicObject(BOX_OBJECT, x, y, z-0.9, angle, 0.0, 0.0, 0, 0);

	carryingBox[playerid] = -1;
	Boxes[boxid][box_player] = -1;
	return 1;
}

IsPlayerCarryingBox(playerid)
{
	return carryingBox[playerid] != -1;
}

IsPlayerInSecuriCar(playerid)
{
	return IsPlayerInAnyVehicle(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == CONVOY_CAR;
}

IsPlayerInConvoyCar(playerid)
{
	return IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleID(playerid) == convoyCar;
}

GetFreeBoxId()
{
	for(new i; i<MAX_BOXES; i++)
	{
		if(Boxes[i][box_free]) return i;
	}
	return -1;
}

GetNearestBox(playerid)
{
	for(new i; i<MAX_BOXES; i++)
	{
		if(Boxes[i][box_free] == false && IsPlayerInRangeOfPoint(playerid, 5.0, Boxes[i][box_x], Boxes[i][box_y], Boxes[i][box_z]))
		{
			return i;
		}
	}
	return -1;
}

DropBoxFromCar(carid)
{
	new Float:x, Float:y, Float:z;
	GetPosBehindVehicle(carid, x, y, z);
	
	new driverid = GetVehicleDriverID(carid);
	if(driverid != -1) ChatDo(driverid, "Z pojazdu konwojowego wypada skrzynka z amunicj¹.");

	return CreateBox(x, y, z);
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