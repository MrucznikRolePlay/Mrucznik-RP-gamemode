//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   eventy                                                  //
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
// Autor: Sanda³
// Data utworzenia: 25.04.2020
//Opis:
/*
	Skrypty eventów
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock EventManager_CanUse(playerid)
{
	if(IsAHeadAdmin(playerid)) return 1;
	if(IsAMCGiver(playerid)) return 1;
	for(new i=0; i<3; i++) if(PlayerInfo[playerid][pUID] == EventManagerUID[i]) return 1;
	return 0;
}

Event_PickObject_Exist(id)
{
	if(Event_pickobject[id][object_x_pos] != 0.0) return true;
	else return false;
}

Event_PickObject_IsUID(object_id, uid)
{
	if(VECTOR_find_val(Event_pickobject[object_id][VZebrali], uid) != INVALID_VECTOR_INDEX) return true;
	else return false;
}

Event_PickObject_AddBlock(object_id, uid)
{
	VECTOR_push_back_val(Event_pickobject[object_id][VZebrali], uid);
}

stock Event_PickObject_GetFreeID()
{
	for(new i=0; i<EVENT_PICKOBJECT_MAX; i++)
	{
		if(!Event_PickObject_Exist(i))
		{
			return i;
		}
	}
	return INVALID_EVENT_PICKOBJECT_ID;
}

stock Event_PickObject_FindNearest(playerid)
{
	for(new i; i < EVENT_PICKOBJECT_MAX; i++)
	{
		if(Event_PickObject_Exist(i))
		{
			new Float:ox, Float:oy, Float:oz;
			new vw = GetPlayerVirtualWorld(playerid);
			new int = GetPlayerInterior(playerid);
			GetDynamicObjectPos(Event_pickobject[i][objectID], ox, oy, oz);
			if(IsPlayerInRangeOfPoint(playerid, 1.5, ox, oy, oz) && (vw == Event_pickobject[i][objectVW] && int == Event_pickobject[i][objectINT]))
			{
				return i;
			}
		}
	}
	return INVALID_object_id;
}
Event_Delete(playerid, object_id)
{
	if(Event_PickObject_Exist(object_id))
	{
		Event_pickobject[object_id][object_x_pos] = 0.0;
		DestroyDynamicObject(Event_pickobject[object_id][objectID]);
		Log(adminLog, INFO, "%s usun¹³ obiekt o id %d.", GetPlayerLogName(playerid), object_id);
		VECTOR_clear(Event_pickobject[object_id][VZebrali]);
	}
	else
	{
		SendClientMessage(playerid, -1, "Obiekt nie istnieje.");
	}
}
stock Event_PickObject_Create(playerid, Float:x, Float:y, Float:z, type)
{
	new object_id;
	object_id = Event_PickObject_GetFreeID();
	if(object_id == INVALID_object_id) SendClientMessage(playerid, COLOR_PANICRED, "Osi¹gniêto maksymaln¹ liczbê obiektów na mapie!");
	else
	{
		new vw, int;
		vw = GetPlayerVirtualWorld(playerid);
		int = GetPlayerInterior(playerid);
		SetPVarInt(playerid, "objectID", object_id);
		SetPVarInt(playerid, "Creatingobject", 1);
		Event_pickobject[object_id][object_x_pos] = x;
		Event_pickobject[object_id][object_y_pos] = y;
		Event_pickobject[object_id][object_z_pos] = z;
		Event_pickobject[object_id][objectVW] = vw;
		Event_pickobject[object_id][objectINT] = int;
		Event_pickobject[object_id][objectTYPE] = type;
		Event_pickobject[object_id][objectID] = CreateDynamicObject(Event_pickobject[object_id][objectMODEL], x, y, z, 0.0, 0.0, 0.0, vw, int, -1, 80);
		EditDynamicObject(playerid, Event_pickobject[object_id][objectID]);
		VECTOR_clear(Event_pickobject[object_id][VZebrali]);
	}
	return object_id;
}
stock Event_PickObject_CanPickup(playerid, object_id)
{
	new uid = PlayerInfo[playerid][pUID];
	if(Event_PickObject_IsUID(object_id, uid)) return false;
	else return true;
}
stock Event_PickObject_Pickup(playerid, object_id)
{
	if(Event_pickobject_Setting[CANPICKUP] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "Event jest wy³¹czony!");
		return 0;
	}
	if(Event_PickObject_CanPickup(playerid, object_id))
	{
		new string[120], type[5], quantity;
		if(Event_pickobject[object_id][objectTYPE] == 1)
		{
			format(type, sizeof(type), "$");
			quantity = Event_pickobject_Setting[CASH];
			DajKase(playerid, quantity);
		}
		else if(Event_pickobject[object_id][objectTYPE] == 2)
		{
			quantity = Event_pickobject_Setting[MCOINS];
			format(type, sizeof(type), "MC");
			PremiumInfo[playerid][pMC] += quantity;
			MruMySQL_SaveMc(playerid);
		}
		format(string, sizeof(string), "Twoja nagroda to %d%s!", quantity, type);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
		Log(payLog, INFO, "[Event_Pickup]Gracz %s podniós³ obiekt z %d%s.", GetPlayerLogName(playerid), quantity, type);
		Event_PickObject_AddBlock(object_id, PlayerInfo[playerid][pUID]);
		return 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "Ju¿ to podnios³eœ!");
		return 0;
	}
}
//end