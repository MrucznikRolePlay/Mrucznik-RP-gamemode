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

	// AttachDynamicObjectToVehicle(
	// 	BOX_OBJECT, 
	// 	convoyCar, 
	// 	0, 0, 1.5, 
	// 	0, 0, 0
	// );

	foreach(new i : Player)
	{
		if(IsInAConvoyTeam(i))
		{
			SendClientMessage(i, COLOR_ADD, sprintf("%s rozpocz¹³ konwój. Chroñ dostawê, aby dowieœæ ca³y ³adunek!", GetNick(playerid)));
		}
		else
		{
			SendClientMessage(i, COLOR_ADD, sprintf("%s rozpocz¹³ przewóz dyñ z narkotykami!", GetNick(playerid)));
			SendClientMessage(i, COLOR_ADD, "JedŸ do czerwonego markera i ostrzelaj konwój aby zdobyæ ³up!");
		}
	}
}

StopConvoy(CONVOY_STOP_REASONS:reason)
{
	if(!ConvoyStarted) return 0;

	ConvoyStarted = false;
	convoyDelayed = true;
	convoyCar = -1;
	convoyCarHP = 0.0;
	convoyCarHPAcc = 0.0;
	defer ConvoyDelay();

	DestroyBoxes();

	switch(reason)
	{
		case CONVOY_STOP_VEHICLE_DESTROYED:
		{
			SendClientMessageToAll(COLOR_ADD, "Konwój z dyniami zosta³ rozbity! Los Santos znowu jest bezpieczne.");
		}
		case CONVOY_STOP_ADMIN:
		{
			SendClientMessageToAll(COLOR_ADD, "Konwój z dyniami zosta³ przerwany przez admina.");
		}
	}
	return 1;
}

//-----------------<[ Boxy: ]>-------------------
CreateBox(Float:x, Float:y, Float:z, Float:rx=0.0, Float:ry=0.0, Float:rz=0.0)
{
	new id = GetFreeBoxId();
	if(id == -1) return -1;

	Boxes[id][box_used] = true;
	Boxes[id][box_object] = CreateDynamicObject(BOX_OBJECT, x, y, z, rx, ry, rz, 0, 0);
	Boxes[id][box_player] = -1;
	Boxes[id][box_x] = x;
	Boxes[id][box_y] = y;
	Boxes[id][box_z] = z;
	Boxes[id][box_bonus] = random(BOX_BONUS)+BOX_BONUS_BASE;
	return id;
}

DestroyBox(boxid)
{
	Boxes[boxid][box_used] = false;
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
	DestroyDynamicObject(Boxes[boxid][box_object]);
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

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	defer AfterDropBox(playerid, boxid, x, y, z, angle);
	return 1;
}

timer AfterDropBox[500](playerid, boxid, Float:x, Float:y, Float:z, Float:angle)
{
	new Float:vx, Float:vy, Float:vz;
	GetVehiclePos(convoyCar, vx, vy, vz);
	RemovePlayerAttachedObject(playerid, Boxes[boxid][box_attachedSlot]);
	carryingBox[playerid] = -1;
	Boxes[boxid][box_player] = -1;

	if(IsPlayerInRangeOfPoint(playerid, 5.0, vx, vy, vz) && IsInAConvoyTeam(playerid))
	{
		ChatMe(playerid, "wrzuca dyniê spowrotem do konwojowego furgonu.");
		convoyCarHP += CONVOY_HP_PER_PACKAGE;
		SetVehicleHealth(convoyCar, convoyCarHP);
		DestroyBox(boxid);
		return 1;
	}
	new actorid = GetNearestConvoyActor(playerid, CONVOY_ACTOR_DELIVERY_DISTANCE);
	if(actorid != -1 && !IsInAConvoyTeam(playerid))
	{
		new money = Boxes[boxid][box_bonus];
		new mc = Boxes[boxid][box_bonus]/1000;
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Gratulacje, dostarczy³eœ dyniê z konwoju. Otrzymujesz %d$ i %dMC.", money, mc));
		DajKase(playerid, money);
		Log(payLog, INFO, "Gracz %s otrzyma³ %d$ za dynie", 
			GetPlayerLogName(playerid), money
		);
		DajMC(playerid, mc);
		Log(premiumLog, INFO, "Gracz %s otrzyma³ %dMC za dynie", 
			GetPlayerLogName(playerid), mc
		);

		DestroyBox(boxid);
		ActorChat(actorid, CONVOY_ACTOR_NAME, "dziêki, oto twoja dzia³ka.");
		ApplyDynamicActorAnimation(actorid, "CASINO", "manwind", 4.1, 0, 1, 1, 0, 0);
	}
	else
	{
		Boxes[boxid][box_x] = x;
		Boxes[boxid][box_y] = y;
		Boxes[boxid][box_z] = z;
		Boxes[boxid][box_object] = CreateDynamicObject(BOX_OBJECT, x, y, z-BOX_ONFOOT_Z_OFFSET, 0.0, 0.0, angle, 0, 0);
	}
	return 1;
}

CreateConvoyActor(model, Float:x, Float:y, Float:z, Float:a)
{
	new actorid = CreateDynamicActor(model, x, y, z, a);
	if(actorid == INVALID_ACTOR_ID) return -1;

	VECTOR_push_back_val(VConvoyActors, actorid);
	MAP_insert_val_val(MActors3DTexts, 
		actorid, 
		_:CreateDynamic3DTextLabel(CONVOY_ACTOR_NAME, COLOR_WHITE, x, y, z+0.98, 5.0)
	);
	return actorid;
}

DestroyConvoyActor(actorid)
{
	if(actorid < 0) return -1;

	VECTOR_remove_val(VConvoyActors, actorid);
	DestroyDynamicActor(actorid);
	DestroyDynamic3DTextLabel(Text3D:MAP_get_val_val(MActors3DTexts, actorid));
	return 1;
}

GetNearestConvoyActor(playerid, Float:range)
{
	new Float:x, Float:y, Float:z;	
	VECTOR_foreach(v : VConvoyActors)
	{
		new actor = MEM_get_val(v);
		GetDynamicActorPos(actor, x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, range, x, y, z)) 
		{
			return actor;
		}
	}
	return -1;
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

IsInAConvoyTeam(playerid)
{
	if(PlayerInfo[playerid][Admin] >= 1 || PlayerInfo[playerid][HalfAdmin] >= 1 || IsAScripter(playerid)) return 1;
	return 0;
}

IsAConvoyTeamLeader(playerid)
{
	if(PlayerInfo[playerid][Admin] >= 1) return 1;
	return 0;
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

DropBoxFromCar(carid)
{
	new Float:x, Float:y, Float:z;
	GetPosBehindVehicle(carid, x, y, z);
	
	new driverid = GetVehicleDriverID(carid);
	if(driverid != -1) ChatDo(driverid, "Z pojazdu konwojowego wypada dynia.");

	return CreateBox(x, y, z-BOX_VEHICLE_Z_OFFSET);
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