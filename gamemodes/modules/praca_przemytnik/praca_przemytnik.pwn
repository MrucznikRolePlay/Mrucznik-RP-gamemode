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

	new redisActionID;
	Redis_GetInt(RedisClient, sprintf("player:%d:smuggling", PlayerInfo[playerid][pUID]), redisActionID);

	for(new i; i<SMUGGLING_ACTIONS_PER_DAY; i++)
	{
		if(SmugglingAction[i][SmugglingActionID] == redisActionID)
		{
			return i;
		}
	}
	return -1;
}

stock GetPlayerSmugglingRole(playerid)
{
	new role;
	Redis_GetInt(RedisClient, sprintf("player:%d:smuggling:role", PlayerInfo[playerid][pUID]), role);
	return role;
}

stock GetSmugglingItemFromString(str[])
{
	for(new i; i<sizeof(SmugglingItemsData); i++)
	{
		if(strcmp(str, SmugglingItemsData[i][Name], true) == 0)
		{
			return i;
		}
	}
	return -1;
}

RedisStartSmuggling(UID, redisActionID, role)
{
	new redisKey[64];
	format(redisKey, sizeof(redisKey), "player:%d:smuggling", UID);
	Redis_SetInt(RedisClient, redisKey, redisActionID);
	Redis_Expire(redisKey, SMUGGLING_MAX_TIME/1000);

	format(redisKey, sizeof(redisKey), "player:%d:smuggling:role", UID);
	Redis_SetInt(RedisClient, redisKey, role);
	Redis_Expire(redisKey, SMUGGLING_MAX_TIME/1000);
}

StartSmuggling(playerid)
{
	new actionID = SmugglingActionsCount;
	new Float:x, Float:y, Float:z;
	x = GetPVarFloat(playerid, "smuggling-x");
	y = GetPVarFloat(playerid, "smuggling-y");
	z = GetPVarFloat(playerid, "smuggling-z");
	
	new redisActionID;
	Redis_GetInt(RedisClient, "smuggling:index", redisActionID);
	Redis_SetInt(RedisClient, "smuggling:index", redisActionID+1);
	Redis_SetInt(RedisClient, sprintf("smuggling:%d:stage", redisActionID), SMUGGLING_STAGE_PICKUP);
	Redis_Expire(sprintf("smuggling:%d:stage", redisActionID), 3600); // 1 hour

	// fill up smuggling action data
	SmugglingAction[actionID][SmugglingActionID] = redisActionID;
	SmugglingAction[actionID][SmugglingStage] = SMUGGLING_STAGE_PICKUP;
	SmugglingAction[actionID][ContrabandPackagesToDrop] = PACKAGES_TO_DROP;

	SmugglingAction[actionID][GatherPointX] = x;
	SmugglingAction[actionID][GatherPointY] = y;
	SmugglingAction[actionID][GatherPointZ] = z;

	new rand = random(sizeof(ContrabandPickupPoints));
	SmugglingAction[actionID][PickupPointX] = ContrabandPickupPoints[rand][0];
	SmugglingAction[actionID][PickupPointY] = ContrabandPickupPoints[rand][1];
	SmugglingAction[actionID][PickupPointZ] = ContrabandPickupPoints[rand][2];

	SmugglingAction[actionID][SmugglingDriverUID] = GetPVarInt(playerid, "smuggling-driver-uid");

	// create object & checkpoint
	CreateDropPointFlare(actionID);
	CreateSmugglingPickupCheckpoint(playerid, actionID);

	// reset special action
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	// set info about smuggling for action initiator
	RedisStartSmuggling(PlayerInfo[playerid][pUID], redisActionID, SMUGGLING_ROLE_INITIATOR);
	MruMessageGoodInfo(playerid, "Rozpocz¹³eœ akcjê przemytnicz¹.");
	MruMessageGoodInfo(playerid, "Udaj siê do czerwonego markera a nastêpnie wpisz komendê /przemyt, gdy bêdziesz znajdowa³ siê w wyznaczonym miejscu w wodolocie wraz ze swoim kierowc¹.");
	MruMessageGoodInfo(playerid, "Jeœli nie uda Ci siê odebraæ przemytu w godziny, przepadnie on.");

	// set info about smuggling for all drivers
	new driverID = GetPVarInt(playerid, "smuggling-driver-id");
	new driverUID = GetPVarInt(playerid, "smuggling-driver-uid");
	if(IsPlayerConnected(driverID) && PlayerInfo[driverID][pUID] == driverUID)
	{
		MruMessageGoodInfoF(driverID, "%s rozpocz¹³ z Tob¹ akcjê przemytnicz¹ - mianowa³ Ciê pilotem wodolotu.", GetNick(playerid));
		MruMessageGoodInfo(driverID, "Jeœli nie chcesz w niej uczestniczyæ, wpisz /anuluj przemyt");
	}
	RedisStartSmuggling(driverUID, redisActionID, SMUGGLING_ROLE_DRIVER);

	// set info about smuggling for all partners
	for(new i; i<GetPVarInt(playerid, "smuggling-partner-index"); i++)
	{
		new partnerID = GetPVarInt(playerid, sprintf("smugging-partner-%d-id", i));
		new partnerUID = GetPVarInt(playerid, sprintf("smugging-partner-%d-uid", i));
		if(IsPlayerConnected(partnerID) && PlayerInfo[partnerID][pUID] == partnerUID)
		{
			MruMessageGoodInfoF(partnerID, "%s rozpocz¹³ z Tob¹ akcjê przemytnicz¹.", GetNick(playerid));
			MruMessageGoodInfo(partnerID, "Jeœli nie chcesz w niej uczestniczyæ, wpisz /anuluj przemyt");
		}
		RedisStartSmuggling(partnerUID, redisActionID, SMUGGLING_ROLE_PARTNER);
	}

	SmugglingActionsCount++;
}

timer DeactivateSmuggling[SMUGGLING_MAX_TIME](actionID)
{
	if(SmugglingAction[actionID][SmugglingStage] >= SMUGGLING_STAGE_DOCUMENTS)
	{
		return;
	}

	foreach(new i : Player)
	{
		new playerActionID = GetPlayerSmugglingActionID(i);
		if(playerActionID == actionID)
		{
			MruMessageBadInfo(i, "Akcja przemytnicza nie uda³a siê. Kontrabanda przepada!");
		}
	}


	switch(SmugglingAction[actionID][SmugglingStage])
	{
		case SMUGGLING_STAGE_PICKUP, SMUGGLING_STAGE_FLY:
		{
			DestroyDynamicObject(SmugglingAction[actionID][DropPointFlareObject]);
		}
		case SMUGGLING_STAGE_DROP:
		{
			DestroyDynamicObject(SmugglingAction[actionID][DropPointFlareObject]);
			DestroyDynamicObject(SmugglingAction[actionID][DropPointContainerObject]);
		}
	}
	SmugglingAction[actionID][SmugglingStage] = SMUGGLING_STAGE_NONE;
}

CreateSmugglingPickupCheckpoint(playerid, actionID)
{
	SetPlayerCheckpoint(playerid, 
		SmugglingAction[actionID][PickupPointX], SmugglingAction[actionID][PickupPointY], SmugglingAction[actionID][PickupPointZ], 
		10);
}

CreateSmugglingGatherCheckpoint(playerid, actionID)
{
	SetPlayerCheckpoint(playerid, 
		SmugglingAction[actionID][GatherPointX], SmugglingAction[actionID][GatherPointY], SmugglingAction[actionID][GatherPointZ], 
		5);
}

CreateDropPointFlare(actionID)
{
	SmugglingAction[actionID][DropPointFlareObject] = CreateDynamicObject(18728, 
		SmugglingAction[actionID][GatherPointX], SmugglingAction[actionID][GatherPointY], SmugglingAction[actionID][GatherPointZ] - 0.5,
		0.0, 0.0, 0.0,
		0, 0);
}

CreateDropPointContainer(actionID)
{
	SmugglingAction[actionID][DropPointFlareObject] = CreateDynamicObject(1334, 
		SmugglingAction[actionID][GatherPointX], SmugglingAction[actionID][GatherPointY], SmugglingAction[actionID][GatherPointZ], 
		0.0, 0.0, 0.0,
		0, 0);
}


StartSmugglingDrop(playerid, driverid, actionID)
{
    SmugglingAction[actionID][SmugglingStage] = SMUGGLING_STAGE_FLY;

	for(new i; i < MAX_SMUGGLING_CHECKPOINTS; i++)
	{
		SmugglingAction[actionID][SmugglingCheckpoints][i] = random(sizeof(SkimmerDroppingCheckpoints));
	}

	new cp = SmugglingAction[actionID][SmugglingCheckpoints][0];
	new type = 4; // CP_TYPE_AIR_FINISH
	SetPlayerRaceCheckpoint(playerid, type, 5014.9385, 154.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);
	SetPlayerRaceCheckpoint(driverid, type, 5014.9385, 154.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);

	CreateDropPointContainer(actionID);
	
	// set marker of initiator for players in crew
	foreach(new i : Player)
	{
		new playerActionID = GetPlayerSmugglingActionID(i);
		if(playerActionID == actionID)
		{
			SetPlayerMarkerForPlayer(i, playerid, COLOR_PANICRED);
			MruMessageGoodInfo(i, "Akcja przemytnicza rozpoczê³a siê! Zbieraj paczki zrzucone z wodolotu i dostarczaj je do miejsca zboru.");
			CreateSmugglingGatherCheckpoint(i, actionID);
		}
	}
}

NextSmugglingCheckpoint(playerid, actionID)
{
	new cp = SmugglingAction[actionID][CapturedCheckpoints];
	if(cp >= MAX_SMUGGLING_CHECKPOINTS)
	{
		return;
	}

	new type = 3; // CP_TYPE_AIR_NORMAL
	new Float:fx, Float:fy, Float:fz;
	new cpIdx = SmugglingAction[actionID][SmugglingCheckpoints][cp];
	if(cp == MAX_SMUGGLING_CHECKPOINTS-1)
	{
		type = 4; // CP_TYPE_AIR_FINISH
		fx = SkimmerDroppingCheckpoints[cpIdx][0];
		fy = SkimmerDroppingCheckpoints[cpIdx][1];
		fz = SkimmerDroppingCheckpoints[cpIdx][2];
	}
	else
	{
		new cpIdxNext = SmugglingAction[actionID][SmugglingCheckpoints][cp+1];
		fx = SkimmerDroppingCheckpoints[cpIdxNext][0];
		fy = SkimmerDroppingCheckpoints[cpIdxNext][1];
		fz = SkimmerDroppingCheckpoints[cpIdxNext][2];
	}

	SetPlayerRaceCheckpoint(playerid, type, 
		SkimmerDroppingCheckpoints[cpIdx][0], SkimmerDroppingCheckpoints[cpIdx][1], SkimmerDroppingCheckpoints[cpIdx][2],
		fx, fy, fz,
		CHECKPOINT_RADIUS);
}

CreateContrabandDrop(actionID, Float:x, Float:y, Float:z, index)
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
	defer CreateContrabandPackage[fallTime](actionID, obj, index);
}

timer CreateContrabandPackage[0](actionID, parachuteObject, index)
{
	new Float:x, Float:y, Float:z;
	GetDynamicObjectPos(parachuteObject, x, y, z);
	DestroyDynamicObject(parachuteObject);

	SmugglingAction[actionID][ContrabandFlareObjects][index] = CreateDynamicObject(18728, x, y, z, 0.0, 0.0, 0.0, 0, 0);
	SmugglingAction[actionID][ContrabandDropObjects][index] = CreateDynamicObject(1575, x, y, z, 0.0, 0.0, 0.0, 0, 0);
}

MarcepanPhone(playerid, color, string[])
{
	new delay = 500 + random(2000);
	defer MarcepanPhoneTimer[delay](playerid, color, string);
}

timer MarcepanPhoneTimer[1000](playerid, color, string:string[])
{
	SendClientMessage(playerid, color, string);
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
			MruMessageGoodInfo(playerid, "Masz teraz pancerz! Aby go u¿yæ, wpisz /pancerz");
		}
		case SMUGGLING_ITEM_JETPACK:
		{
			MruMessageGoodInfo(playerid, "Masz teraz plecak odrzutowy! Aby go u¿yæ, wpisz /jetpack");
		}
	}
}

GiveSmugglingItem(playerid, item)
{
	Redis_IncrBy(RedisSmugglingItemKey(playerid, item), 1);
}

TakeSmugglingItem(playerid, item)
{
	Redis_IncrBy(RedisSmugglingItemKey(playerid, item), -1);
}

IsOwnerOfSmugglingItem(playerid, item)
{
	new value;
	Redis_GetInt(RedisClient, RedisSmugglingItemKey(playerid, item), value);
	return value > 0;
}

RedisSmugglingItemKey(playerid, item)
{
	new redisKey[128];
	format(redisKey, sizeof(redisKey), "player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]);
	return redisKey;
}

UseJetpack(playerid)
{
	JetpackEnabled[playerid] = true;
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

//end