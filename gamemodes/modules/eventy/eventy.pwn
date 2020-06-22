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

Events_CanUseCommand(playerid)
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
	if(event_id >= 1 && event_id <= 10) return 1;
	else return 0;
}
Events_DynamicEventExist(event_id)
{
	if(event_id > 10) return 1; // plus dodac funkcje czy np. Event[event_id][createdBy] != 0
	else return 0;
}
Events_EventExist(event_id)
{
	if(Events_IsStaticEvent(event_id) || Events_DynamicEventExist(event_id)) return 1;
	else return 0;
}
Events_AddNewEvent(event_id, playerid)
{
	if(Events_EventExist(event_id)) return 0;
	else return 1;
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