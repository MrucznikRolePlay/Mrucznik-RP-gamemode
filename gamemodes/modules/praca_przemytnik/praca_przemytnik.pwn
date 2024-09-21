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
		if(SmugglingAction[i][s_actionID] == redisActionID)
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

	// reset special action
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	// set info about smuggling for action initiator
	RedisStartSmuggling(PlayerInfo[playerid][pUID], redisActionID, SMUGGLING_ROLE_INITIATOR);
	MruMessageGoodInfo(playerid, "Rozpocz¹³eœ akcjê przemytnicz¹.");
	MruMessageGoodInfo(playerid, "Udaj siê do czerwonego markera a nastêpnie wpisz komendê /przemyt, gdy bêdziesz znajdowa³ siê w wyznaczonym miejscu.");
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
			MruMessageBadInfo(i, "Akcja przemytnicza nie uda³a siê. Kontrabanda przepada!");
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

CreateSmugglingGatherCheckpoint(playerid, actionID)
{
	SetPlayerCheckpoint(playerid, 
		SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ], 
		5);
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

	for(new i; i < MAX_SMUGGLING_CHECKPOINTS; i++)
	{
		SmugglingAction[actionID][s_flyCheckpoints][i] = random(sizeof(SkimmerDroppingCheckpoints));
	}

	new cp = SmugglingAction[actionID][s_flyCheckpoints][0];
	new type = 4; // CP_TYPE_AIR_FINISH
	SetPlayerRaceCheckpoint(playerid, type, 5014.9385, 154.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);
	SetPlayerRaceCheckpoint(driverid, type, 5014.9385, 154.7287, 71.5396, 
		SkimmerDroppingCheckpoints[cp][0], SkimmerDroppingCheckpoints[cp][1], SkimmerDroppingCheckpoints[cp][2], 
		CHECKPOINT_RADIUS);

	CreateDropPointContainer(actionID);
	
	// set marker of initiator for players in crew
	SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Akcja przemytnicza rozpoczê³a siê! Zbieraj paczki zrzucone z wodolotu i dostarczaj je do miejsca zboru.");
	foreach(new i : GroupMember(SmugglingAction[actionID][s_crewGroup]))
	{
		SetPlayerMarkerForPlayer(i, playerid, TEAM_AZTECAS_COLOR); // TODO: disable when smuggling ends
		CreateSmugglingGatherCheckpoint(i, actionID);
	}
	DisablePlayerCheckpoint(playerid);
	DisablePlayerCheckpoint(driverid);
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

	SmugglingAction[actionID][s_flareObjects][index] = CreateDynamicObject(18728, x, y, z - 0.5, 0.0, 0.0, 0.0, 0, 0, 300.0, 300.0);
	new boxid = CreateBox(1580, BOX_TYPE_CONTRABAND_ACTION, BIG_PACKAGE_CONTRABAND_AMMOUNT, x, y, z);
	SmugglingAction[actionID][s_dropBoxes][index] = boxid;
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
	for(new i; i<SMUGGLING_ACTIONS_PER_DAY; i++)
	{
		for(new j; j<PACKAGES_TO_DROP; j++)
		{
			if(boxid == SmugglingAction[i][s_dropBoxes][j])
			{
				return i;
			}
		}
	}
	return -1;
}

DestroySmugglingBoxFlare(boxid)
{
	new actionID = GetSmugglingActionByBoxID(boxid);
	if(SmugglingAction[actionID][s_flareObjects] != -1) {
		DestroyDynamicObject(SmugglingAction[actionID][s_flareObjects]);
		SmugglingAction[actionID][s_flareObjects] = -1;
	}
}

GatherPackage(actionID, boxid, contraband)
{
	DestroyBox(boxid);

	SmugglingAction[actionID][s_packagesDropped]++;
	SmugglingAction[actionID][s_contrabandGathered] += contraband;
	if(SmugglingAction[actionID][s_packagesDropped] >= PACKAGES_TO_DROP)
	{
		SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Wszystkie paczki zosta³y dostaczone lub znisczone. Teraz organizator mo¿e zebraæ kontrabandê z punktu zbioru (/przemyt).");
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
		Redis_Delete(sprintf("player:%d:smuggling", PlayerInfo[i][pUID]));
		Redis_Delete(sprintf("player:%d:smuggling:role", PlayerInfo[i][pUID]));
	}

	Group_Destroy(SmugglingAction[actionID][s_crewGroup]);
    for(new i = 0; i < PACKAGES_TO_DROP; i++)
    {
		DestroyBox(SmugglingAction[actionID][s_dropBoxes][i]);
    }

    if(SmugglingAction[actionID][s_flareObjects] != -1)
    {
        DestroyDynamicObject(SmugglingAction[actionID][s_flareObjects]);
        SmugglingAction[actionID][s_flareObjects] = -1;
    }

	DestroyDynamicObject(SmugglingAction[actionID][s_gatherContainer]);
	DestroyDynamicObject(SmugglingAction[actionID][s_gatherFlare]);
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
	new redisKey[128];
	format(redisKey, sizeof(redisKey), "player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]);
	Redis_IncrBy(redisKey, 1);
}

TakeSmugglingItem(playerid, item)
{
	new redisKey[128];
	format(redisKey, sizeof(redisKey), "player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]);
	Redis_IncrBy(redisKey, -1);
}

IsOwnerOfSmugglingItem(playerid, item)
{
	new value = 0;
	new redisKey[128];
	format(redisKey, sizeof(redisKey), "player:%d:%s", PlayerInfo[playerid][pUID], SmugglingItemsData[item][ShortName]);
	Redis_GetInt(RedisClient, redisKey, value);
	if(value > 0)
	{
		return 1;
	}
	return 0;
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