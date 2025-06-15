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
	System konwoj�w.

	Zale�no�ci:
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
	// 	CONVOY_BOX_OBJECT, 
	// 	convoyCar, 
	// 	0, 0, 1.5, 
	// 	0, 0, 0
	// );

	foreach(new i : Player)
	{
		if(IsInAConvoyTeam(i))
		{
			SendClientMessage(i, COLOR_ADD, sprintf("%s rozpocz�� konw�j. Chro� dostaw�, aby dowie�� ca�y �adunek!", GetNick(playerid)));
		}
		else
		{
			SendClientMessage(i, COLOR_ADD, sprintf("%s rozpocz�� przew�z dy� z narkotykami!", GetNick(playerid)));
			SendClientMessage(i, COLOR_ADD, "Jed� do czerwonego markera i ostrzelaj konw�j aby zdoby� �up!");
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
			SendClientMessageToAll(COLOR_ADD, "Konw�j z dyniami zosta� rozbity! Los Santos znowu jest bezpieczne.");
		}
		case CONVOY_STOP_ADMIN:
		{
			SendClientMessageToAll(COLOR_ADD, "Konw�j z dyniami zosta� przerwany przez admina.");
		}
	}
	return 1;
}

//-----------------<[ Boxy: ]>-------------------
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
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid)) return 1;
	return 0;
}

IsAConvoyTeamLeader(playerid)
{
	if(PlayerInfo[playerid][pAdmin] >= 1) return 1;
	return 0;
}

DropConvoyBox(carid)
{
	new driverid = GetVehicleDriverID(carid);
	if(driverid != -1) ChatDo(driverid, "Z pojazdu konwojowego wypada dynia.");

	new bonus = bonus = random(BOX_BONUS)+BOX_BONUS_BASE;
	DropBoxFromCar(CONVOY_BOX_OBJECT, BOX_TYPE_CONVOY, bonus, carid);
}

//end