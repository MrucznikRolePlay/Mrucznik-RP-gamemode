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
//---------FUNKCJE DOTYCZ¥CE ZARZ¥DZANIA KIEDY SKRYPT EVENTOWY JEST MO¯LIWY DO U¯YCIA
Events_IsEnabledInTime()
{
	return 1;
}
Events_ISEnabledByAdmin()
{
	return 1;
}
Events_IsEnabled()
{
	if(Events_IsEnabledInTime()) return 1;
	else if(Events_ISEnabledByAdmin()) return 1;
	else return 0;
}
Events_IsStaticEvent(event_id)
{
	return 0;
}
//---------FUNKCJE DOTYCZ¥CE DYNAMICZNYM WERYFIKACJOM
Events_IsCommandArgAvailable(playerid, event_id, param[])
{
	return 0;
}
Events_IsEventParamEqual(playerid, event_id, param_id, param[])
{
	return 1;
}
//---------FUNKCJE DOTYCZ¥CE DYNAMICZNYM TWORZENIOM EVENTÓW
Events_AddNewEvent(playerid, event_id)
{
	return 1;
}
Events_AddNewEventParam(playerid, event_id, param_id, param[])
{
	return 1;
}
//---------FUNKCJE DOTYCZ¥CE OBIEKTÓW
Events_CreatePickableObject(playerid)
{
	return 1; // ma zwracaæ id stworzonego obiektu
}

Events_PickupObject(playerid, objectid)
{
	return 1;
}
Events_PutdownObject(objectid)
{
	return 1;
}
//end