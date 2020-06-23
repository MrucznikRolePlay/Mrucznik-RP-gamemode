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
// Data utworzenia: 22.06.2020
//Opis:
/*
	Skrypty eventowe
*/

//

//-----------------<[ Funkcje: ]>-------------------
//FUNKCJE DOTYCZ¥CE KOMEND
Events_CanUseManageCommand(playerid)
{
	if(DEVELOPMENT || PlayerInfo[playerid][pAdmin] >= 1000) return 1;
	else return 0;
}

Events_CanUseCommand()
{
	if(Events_Enabled()) return 1;
	else return 0;
}
//---------FUNKCJE DOTYCZ¥CE ZARZ¥DZANIA KIEDY SKRYPT EVENTOWY JEST MO¯LIWY DO U¯YCIA
Events_Enabled()
{
	if(EVENTS_enabled > 0)	return 1;
	else return 0;
}
Events_IsEnabled(event_id)
{
	return 1;
}
//---------FUNKCJE DOTYCZ¥CE DYNAMICZNYM TWORZENIOM EVENTÓW
Events_IsStaticEvent(event_id)
{
	if(event_id == 1) return 1; // na razie tylko 1 statyczny event
	else return 0;
}
Events_DynamicEventExist(event_id)
{
	if(event_id > 10) return 1; // plus dodac funkcje czy np. Event[event_id][createdBy] != 0
	else return 0;
}
Events_EventExist(event_id)
{
	if(Events_IsStaticEvent(event_id)) return 1;
	else return 0;
}
Events_AddNewEvent(event_id, playerid)
{
	if(Events_EventExist(event_id)) return 0;
	else return 1;
}
Events_LoadStaticEvent(playerid, event_id)
{
	if(Events_EventExist(event_id) && Events_IsStaticEvent(event_id))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(Events_LoadStaticEventObjects(event_id)) SendClientMessage(playerid, COLOR_YELLOW, "[Event Manager] Za³adowano obiekty.");
		if(Events_CreateActor(playerid, event_id, x, y, z, 180.0, 0, 0) != -1) SendClientMessage(playerid, COLOR_YELLOW, "[Event Manager] Stworzono aktora.");
		EVENTS_enabled = event_id;
	}
	else return 0;
}

Events_IsNearActor(playerid, actor_id)
{
	return 1;
}
Events_ActorExist(actor_id)
{
	if(EVENTS_Actors[actor_id][actor_x] != 0.0) return 1;
	else return 0;
}
Events_GetFreeActorID()
{
	for(new i=0; i<10; i++)
	{
		if(Events_ActorExist(i)) continue;
		else return i;
	}
	return -1;
}
Events_CreateActor(playerid, event_id, float:x, float:y, float:z, float:rotation, vw, int)
{
	new id = Events_GetFreeActorID();
	if(id != -1)
	{
		EVENTS_Actors[id][actor_id] = CreateActor(269, x,y,z,rotation);
		EVENTS_Actors[id][actor_x] = x;
		EVENTS_Actors[id][actor_y] = y;
		EVENTS_Actors[id][actor_z] = z;
		EVENTS_Actors[id][actor_vw] = vw;
		EVENTS_Actors[id][actor_int] = int;
		return id;
	}
	return -1;
}
Events_DestroyActor(actor_id)
{
	SetActorPos(EVENTS_Actors[actor_id][actor_id], 0.0, 0.0, 0.0);
	DestroyActor(EVENTS_Actors[actor_id][actor_id]);
	EVENTS_Actors[actor_id][actor_x] = 0.0;
	EVENTS_Actors[actor_id[actor_vw] = 999;
	return 1;
}

Events_DestroyActors()
{
	if(Events_GetFreeActorID() != 0)
	{
		for(new i=0; i<10; i++)
		{
			SetActorPos(EVENTS_Actors[i][actor_id], 0.0, 0.0, 0.0);
			DestroyActor(EVENTS_Actors[i][actor_id]);
			EVENTS_Actors[i][actor_x] = 0.0;
			EVENTS_Actors[i][actor_vw] = 999;
		}
		return 1;
	}
	return 0;
}

Events_UnloadStaticEvent(playerid, event_id)
{
	if(EVENTS_enabled > 0)
	{
		if(Events_UnloadStaticEventObjects(event_id)) SendClientMessage(playerid, COLOR_YELLOW, "[Event Manager] Zniszczono obiekty.");
		if(Events_DestroyActors()) SendClientMessage(playerid, COLOR_YELLOW, "[Event Manager] Usuniêto aktorów.");
		EVENTS_enabled = 0;
	}
	else return 0;
}

Events_UnloadObjectsForAll(event_id)
{
	if(event_id == 1)
	{
		foreach(new i : Player)
		{
			rahim1_Connect(i);
		}
	}
}

Events_UnloadStaticEventObjects(event_id)
{
	if(event_id == 1)
	{
		EVENTS_connect_object = 0;
		rahim1_Unload();
		return 1;
	}
	return 0;
}

Events_LoadStaticEventObjects(event_id)
{
	if(event_id == 1)
	{
		Events_UnloadObjectsForAll(event_id);
		EVENTS_connect_object = event_id;
		rahim1_Init();
		return 1;
	}
	return 0;
}
//---------FUNKCJE DOTYCZ¥CE OBIEKTÓW

//tworzenie, modyfikowanie, usuwanie obiektu
Events_CreatePickableObject(event_id, playerid)
{
	return 1; // ma zwracaæ id stworzonego obiektu
}
Events_DeletePickableObject(event_id, playerid, objectid)
{
	return 1;
}

//powi¹zanie obiekty + gracz
Events_Hasobject(event_id, playerid, objectid)
{
	return 1;
}
Events_PickupObject(event_id, playerid, objectid)
{
	return 1;
}
Events_PutdownObject(event_id, objectid)
{
	return 1;
}
//end