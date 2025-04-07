//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              praca_przemytnik                                             //
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
// Data utworzenia: 31.03.2024
//Opis:
/*
	Praca przemytnika.
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock GiveContraband(playerid, value)
{
	PlayerInfo[playerid][pContraband] += value;
}

stock TakeContraband(playerid, value)
{
	PlayerInfo[playerid][pContraband] -= value;
}

stock GetContraband(playerid)
{
	return PlayerInfo[playerid][pContraband];
}

stock IsPlayerSmuggling(playerid)
{
	return Redis_Exists(RedisClient, sprintf("player:%d:smuggling", PlayerInfo[playerid][pUID]));
}

stock GetPlayerSmugglingActionID(playerid)
{
	if(!IsPlayerSmuggling(playerid))
	{
		return -1;
	}

	new redisActionID = RedisGetInt(sprintf("player:%d:smuggling", PlayerInfo[playerid][pUID]));
	for(new i; i<SMUGGLING_ACTIONS_PER_DAY; i++)
	{
		if(SmugglingAction[i][s_actionID] == redisActionID)
		{
			return i;
		}
	}
	return -1;
}

stock GetPlayerSmugglingRole(playerid)
{
	return RedisGetInt(sprintf("player:%d:smuggling:role", PlayerInfo[playerid][pUID]));
}

stock GetSmugglingItemFromString(str[])
{
	for(new i; i<sizeof(SmugglingItemsData); i++)
	{
		if(strcmp(str, SmugglingItemsData[i][ShortName], true) == 0)
		{
			return i;
		}
	}
	return SMUGGLING_ITEM_UNKNOWN;
}

RedisStartSmuggling(UID, redisActionID, role)
{
	new redisKey[64];
	format(redisKey, sizeof(redisKey), "player:%d:smuggling", UID);
	Redis_SetInt(RedisClient, redisKey, redisActionID);
	RedisExpire(redisKey, SMUGGLING_MAX_TIME/1000);

	format(redisKey, sizeof(redisKey), "player:%d:smuggling:role", UID);
	Redis_SetInt(RedisClient, redisKey, role);
	RedisExpire(redisKey, SMUGGLING_MAX_TIME/1000);
}

StartSmuggling(playerid)
{
	new driverID = GetPVarInt(playerid, "smuggling-driver-id");
	new driverUID = GetPVarInt(playerid, "smuggling-driver-uid");

	new actionID = SmugglingActionsCount;
	new Float:x, Float:y, Float:z;
	x = GetPVarFloat(playerid, "smuggling-x");
	y = GetPVarFloat(playerid, "smuggling-y");
	z = GetPVarFloat(playerid, "smuggling-z");
	
	new redisActionID = RedisGetInt("smuggling:index");
	Redis_SetInt(RedisClient, "smuggling:index", redisActionID+1);
	Redis_SetInt(RedisClient, sprintf("smuggling:%d:stage", redisActionID), SMUGGLING_STAGE_PICKUP);
	RedisExpire(sprintf("smuggling:%d:stage", redisActionID), 3600); // 1 hour
	
	// fill up smuggling action data
	SmugglingAction[actionID][s_actionID] = redisActionID;
	SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_PICKUP;
	SmugglingAction[actionID][s_packagesToDrop] = PACKAGES_TO_DROP;

	SmugglingAction[actionID][s_gatherPointX] = x;
	SmugglingAction[actionID][s_gatherPointY] = y;
	SmugglingAction[actionID][s_gatherPointZ] = z;

	new rand = random(sizeof(ContrabandPickupPoints));
	SmugglingAction[actionID][s_pickupPointX] = ContrabandPickupPoints[rand][0];
	SmugglingAction[actionID][s_pickupPointY] = ContrabandPickupPoints[rand][1];
	SmugglingAction[actionID][s_pickupPointZ] = ContrabandPickupPoints[rand][2];

	SmugglingAction[actionID][s_driverUID] = GetPVarInt(playerid, "smuggling-driver-uid");

	// create object & checkpoint
	CreateDropPointFlare(actionID);
	CreateSmugglingPickupCheckpoint(playerid, actionID);
	CreateSmugglingPickupCheckpoint(driverID, actionID);

	// reset special action
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	// set info about smuggling for action initiator
	RedisStartSmuggling(PlayerInfo[playerid][pUID], redisActionID, SMUGGLING_ROLE_INITIATOR);
	MruMessageGoodInfo(playerid, "Rozpocz��e� akcj� przemytnicz�.");
	MruMessageGoodInfo(playerid, "Udaj si� do czerwonego markera a nast�pnie wpisz komend� /przemyt, gdy b�dziesz znajdowa� si� w wyznaczonym miejscu.");
	MruMessageGoodInfo(playerid, "Je�li nie uda Ci si� odebra� przemytu w 1 godzin�, przepadnie on.");

	// set info about smuggling for all drivers
	if(IsPlayerConnected(driverID) && PlayerInfo[driverID][pUID] == driverUID)
	{
		MruMessageGoodInfoF(driverID, "%s rozpocz�� z Tob� akcj� przemytnicz� - mianowa� Ci� pilotem wodolotu.", GetNick(playerid));
		MruMessageGoodInfo(driverID, "Je�li nie chcesz w niej uczestniczy�, wpisz /anuluj akcjaprzemyt");
	}
	RedisStartSmuggling(driverUID, redisActionID, SMUGGLING_ROLE_DRIVER);

	// set info about smuggling for all partners
	for(new i; i<GetPVarInt(playerid, "smuggling-partner-index"); i++)
	{
		new partnerID = GetPVarInt(playerid, sprintf("smugging-partner-%d-id", i));
		new partnerUID = GetPVarInt(playerid, sprintf("smugging-partner-%d-uid", i));
		if(IsPlayerConnected(partnerID) && PlayerInfo[partnerID][pUID] == partnerUID)
		{
			MruMessageGoodInfoF(partnerID, "%s rozpocz�� z Tob� akcj� przemytnicz�.", GetNick(playerid));
			MruMessageGoodInfo(partnerID, "Je�li nie chcesz w niej uczestniczy�, wpisz /anuluj akcjaprzemyt");
			Group_SetPlayer(SmugglingAction[actionID][s_crewGroup], partnerID, true);
		}
		RedisStartSmuggling(partnerUID, redisActionID, SMUGGLING_ROLE_PARTNER);
	}

	SmugglingActionsCount++;
}

timer DeactivateSmuggling[SMUGGLING_MAX_TIME](actionID)
{
	foreach(new i : Player)
	{
		new playerActionID = GetPlayerSmugglingActionID(i);
		if(playerActionID == actionID)
		{
			MruMessageBadInfo(i, "Akcja przemytnicza nie uda�a si�. Kontrabanda przepada!");
		}
	}

	EndSmuggling(actionID);
}

CreateSmugglingPickupCheckpoint(playerid, actionID)
{
	SetPlayerCheckpoint(playerid, 
		SmugglingAction[actionID][s_pickupPointX], SmugglingAction[actionID][s_pickupPointY], SmugglingAction[actionID][s_pickupPointZ], 
		10);
}

CreateSmugglingGatherCheckpoint(playerid, actionID, bool:hole=false)
{
	if(hole)
	{
		SetPlayerCheckpoint(playerid,
			SmugglersHole[0], SmugglersHole[1], SmugglersHole[2],
			5.0);
	}
	else
	{
		SetPlayerCheckpoint(playerid, 
			SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ] - 1.0, 
			5.0);
	}
}

CreateDropPointFlare(actionID)
{
	SmugglingAction[actionID][s_gatherFlare] = CreateDynamicObject(18728, 
		SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ] - 1.5,
		0.0, 0.0, 0.0,
		0, 0);
}

CreateDropPointContainer(actionID)
{
	SmugglingAction[actionID][s_gatherFlare] = CreateDynamicObject(1334, 
		SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ], 
		0.0, 0.0, 0.0,
		0, 0);
}

StartSmugglingDrop(playerid, driverid, actionID)
{
    SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_FLY;
	SmugglingAction[actionID][s_SkimmerID] = GetPlayerVehicleID(driverid);

	for(new i; i < MAX_SMUGGLING_CHECKPOINTS; i++)
	{
		SmugglingAction[actionID][s_flyCheckpoints][i] = random(sizeof(SkimmerDroppingCheckpoints));
	}

	new cp = SmugglingAction[actionID][s_flyCheckpoints][0];
	new type = 4; // CP_TYPE_AIR_FINISH
	// first checkpoint at prawn island Vice City
	SetPlayerRaceCheckpoint(playerid, type, -4185.0615, 3354.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);
	SetPlayerRaceCheckpoint(driverid, type, -4185.0615, 3354.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);

	CreateDropPointContainer(actionID);
	
	// set marker of initiator for players in crew
	SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Akcja przemytnicza rozpocz�a si�! Zbieraj paczki zrzucone z wodolotu i dostarczaj je do miejsca zboru.");
	foreach(new i : GroupMember(SmugglingAction[actionID][s_crewGroup]))
	{
		CreateSmugglingGatherCheckpoint(i, actionID);
	}
	DisablePlayerCheckpoint(playerid);
	DisablePlayerCheckpoint(driverid);

	// Komunikaty dla �owc�w
	SendJobMessage(JOB_LOWCA, COLOR_WHITE, "|___________ KOMUNIKAT �OWC�W NAGR�D ___________|");
	SendJobMessage(JOB_LOWCA, COLOR_RED, "UWAGA! Kr��� pog�oski, �e kto� pr�buje przemyci� kontraband� do Vice City!");
	SendJobMessage(JOB_LOWCA, COLOR_WHITE, "|_______________________________________________|");
	// Komunikaty dla przemytnik�w
	SendJobMessage(JOB_SMUGGLER, COLOR_WHITE, "|___________________ POG�OSKI __________________|");
	SendJobMessage(JOB_SMUGGLER, COLOR_RED, "Kr��� pog�oski, �e kto� pr�buje przemyci� kontraband� do Vice City!");
	SendJobMessage(JOB_SMUGGLER, COLOR_WHITE, "|_______________________________________________|");
	// Komunikat dla porz�dkowych
	for(new i=FRAC_LSPD; i<=FRAC_NG; i++)
	{
		SendFamilyMessage(i, COLOR_WHITE, "|___________ DO WSZYSTKICH JEDNOSTEK ___________|");
		SendFamilyMessage(i, COLOR_RED, "UWAGA! Kr��� pog�oski, �e kto� pr�buje przemyci� kontraband� do Vice City!");
		SendFamilyMessage(i, COLOR_WHITE, "|__________________________________________________|");
	}
}

ShowSmugglingCheckpoint(playerid, actionID)
{
	new cp = SmugglingAction[actionID][s_capturedCheckpoints];
	if(cp >= MAX_SMUGGLING_CHECKPOINTS)
	{
		return;
	}

	new type = 3; // CP_TYPE_AIR_NORMAL
	new Float:fx, Float:fy, Float:fz;
	new cpIdx = SmugglingAction[actionID][s_flyCheckpoints][cp];
	if(cp == MAX_SMUGGLING_CHECKPOINTS-1)
	{
		type = 4; // CP_TYPE_AIR_FINISH
		fx = SkimmerDroppingCheckpoints[cpIdx][0];
		fy = SkimmerDroppingCheckpoints[cpIdx][1];
		fz = SkimmerDroppingCheckpoints[cpIdx][2];
	}
	else
	{
		new cpIdxNext = SmugglingAction[actionID][s_flyCheckpoints][cp+1];
		fx = SkimmerDroppingCheckpoints[cpIdxNext][0];
		fy = SkimmerDroppingCheckpoints[cpIdxNext][1];
		fz = SkimmerDroppingCheckpoints[cpIdxNext][2];
	}

	SetPlayerRaceCheckpoint(playerid, type, 
		SkimmerDroppingCheckpoints[cpIdx][0], SkimmerDroppingCheckpoints[cpIdx][1], SkimmerDroppingCheckpoints[cpIdx][2],
		fx, fy, fz,
		CHECKPOINT_RADIUS);
}

CreateContrabandDrop(actionID, Float:x, Float:y, Float:z, index, damaged=false)
{
	// create parachute package object
	new obj = CreateDynamicObject(18849, x, y, z, 0.0, 0.0, 0.0, 0, 0);

	// get ground position
	new Float:groundZ;
	CA_FindZ_For2DCoord(x, y, groundZ);
	if(groundZ < 0.0) 
	{
		groundZ = 0.0;
	}

	// calculate speed of falling down, 5m/s is falling speed on parachute
	new Float:speed = 5.0;
	new fallTime = floatround((z - groundZ) / speed * 1000) + 500;

	// start moving object
	MoveDynamicObject(obj, x, y, groundZ, speed);

	// timer to activate on fall ends
	defer CreateContrabandPackage[fallTime](actionID, obj, index, damaged);
}

timer CreateContrabandPackage[0](actionID, parachuteObject, index, damaged)
{
	new Float:x, Float:y, Float:z;
	GetDynamicObjectPos(parachuteObject, x, y, z);
	DestroyDynamicObject(parachuteObject);

	new contraband = BIG_PACKAGE_CONTRABAND_AMMOUNT;
	if(damaged) contraband /= 2;
	new boxid = CreateBox(1580, BOX_TYPE_CONTRABAND_ACTION, contraband, x, y, z, 0, 0);
	SmugglingAction[actionID][s_dropBoxes][index] = boxid;
	MAP_insert_val_val(BoxesToAction, boxid, actionID);
}

MarcepanPhone(playerid, color, string[], forceDelay=0)
{
	SendClientMessage(playerid, color, string);
}

SendSmugglingCrewMessage(actionID, color, string[])
{
	foreach(new i : GroupMember(SmugglingAction[actionID][s_crewGroup]))
	{
		SendClientMessage(i, color, string);
	}
}
// ------- ostatni etap
GetSmugglingActionByBoxID(boxid)
{
	if(!MAP_contains_val(BoxesToAction, boxid))
	{
		printf("Error, brak boxa id: %d", boxid);
		return -1;
	}

	return MAP_get_val_val(BoxesToAction, boxid);
}

GatherPackage(actionID, boxid, contraband)
{
	DestroyBox(boxid);

	SmugglingAction[actionID][s_packagesDropped]++;
	SmugglingAction[actionID][s_contrabandGathered] += contraband;
	if(SmugglingAction[actionID][s_packagesDropped] >= PACKAGES_TO_DROP)
	{
		SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Wszystkie paczki zosta�y dostaczone lub znisczone. Teraz organizator mo�e zebra� kontraband� z punktu zbioru (/przemyt).");
		SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_END;
	}
}

EndSmuggling(actionID)
{
    // Reset SmugglingAction table to default values
	SmugglingAction[actionID][s_actionID] = -1;
    SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_NONE;
    SmugglingAction[actionID][s_driverUID] = 0;
    SmugglingAction[actionID][s_pickupPointX] = 0.0;
    SmugglingAction[actionID][s_pickupPointY] = 0.0;
    SmugglingAction[actionID][s_pickupPointZ] = 0.0;
    SmugglingAction[actionID][s_gatherPointX] = 0.0;
    SmugglingAction[actionID][s_gatherPointY] = 0.0;
    SmugglingAction[actionID][s_gatherPointZ] = 0.0;
    SmugglingAction[actionID][s_packagesDropped] = 0;
    SmugglingAction[actionID][s_contrabandGathered] = 0;
    SmugglingAction[actionID][s_enableContrabandDrop] = 0;

	foreach(new i : GroupMember(SmugglingAction[actionID][s_crewGroup]))
	{
		RedisDelete(sprintf("player:%d:smuggling", PlayerInfo[i][pUID]));
		RedisDelete(sprintf("player:%d:smuggling:role", PlayerInfo[i][pUID]));
		DisablePlayerCheckpoint(i);
	}

	Group_Destroy(SmugglingAction[actionID][s_crewGroup]);
    for(new i = 0; i < PACKAGES_TO_DROP; i++)
    {
		DestroyBox(SmugglingAction[actionID][s_dropBoxes][i]);
    }


	DestroyDynamicObject(SmugglingAction[actionID][s_gatherContainer]);
	DestroyDynamicObject(SmugglingAction[actionID][s_gatherFlare]);
}



CreateRandomContrabandBoxes()
{
	new Float:x, Float:y, Float:z;
	// Create random boxes with contraband around the map
	for(new i = 0; i < 50;) // Create 50 random boxes
	{
		// Vice City
		x = -6040.4917 + float(random(3173));
		y = 489.1467 + float(random(3374));
		CA_FindZ_For2DCoord(x, y, z);
		
		if(z > 0.0) // Only create if above water level
		{
			CreateBox(1579, BOX_TYPE_CONTRABAND, random(5) + 1, x, y, z + 0.05, 0, 0, random(360));
			i++;
		}
	}
	return 1;
}

// ------------- przedmioty przemytnicze --------------------
CreateAndGiveSmugglingItem(playerid, smugglerid, item)
{
    new itemCost = SmugglingItemsData[item][Cost];
    TakeContraband(smugglerid, itemCost);

    GiveSmugglingItem(playerid, item);
	switch(item)
	{
		case SMUGGLING_ITEM_ARMOR:
		{
			MruMessageGoodInfo(playerid, "Masz teraz pancerz! Aby go u�y�, wpisz /pancerz");
		}
		case SMUGGLING_ITEM_JETPACK:
		{
			GiveSmugglingItem(playerid, SMUGGLING_ITEM_JETPACK_GAS, 600);
			MruMessageGoodInfo(playerid, "Masz teraz plecak odrzutowy! Aby go u�y�, wpisz /jetpack");
		}
		case SMUGGLING_ITEM_JETPACK_GAS:
		{
			GiveSmugglingItem(playerid, item, 600);
			MruMessageGoodInfo(playerid, "Masz teraz paliwo do plecaka odrzutowego! Powinno starczy� na 10 minut lotu.");
		}
	}
}

GiveSmugglingItem(playerid, item, ammount=1)
{
	RedisIncrBy(sprintf("player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]), ammount);
}

TakeSmugglingItem(playerid, item, ammount=1)
{
	RedisIncrBy(sprintf("player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]), -ammount);
}

SetSmugglingItem(playerid, item, ammount)
{
	Redis_SetInt(RedisClient, sprintf("player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]), ammount);
}

GetPlayerSmugglingItem(playerid, item)
{
	new value = RedisGetInt(sprintf("player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]));
	if(value > 0)
	{
		return value;
	}
	return 0;
}

UseJetpack(playerid)
{
	JetpackEnabled[playerid] = true;
	JetpackGas[playerid] = GetPlayerSmugglingItem(playerid, SMUGGLING_ITEM_JETPACK_GAS);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
}

DisableJetpack(playerid)
{
	JetpackEnabled[playerid] = false;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}

LegalJetpack(playerid)
{
	return JetpackEnabled[playerid];
}

SmugglersSquallo(vehicleid)
{
	AttachDynamicObjectToVehicle(CreateDynamicObject(BOX_OBJECT, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
		vehicleid, 0.5, -2.5, 1.5, 0.0, 0.0, 0.0);
	AttachDynamicObjectToVehicle(CreateDynamicObject(BOX_OBJECT, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
		vehicleid, -0.5, -2.5, 1.5, 0.0, 0.0, 0.0);
}

//end