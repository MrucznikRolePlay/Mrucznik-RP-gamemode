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
			return 1;
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

RedisStartSmuggling(UID, redisActionID, role)
{
	new redisKey[64];
	format(redisKey, sizeof(redisKey), "player:%d:smuggling", UID);
	Redis_SetInt(RedisClient, redisKey, redisActionID);
	Redis_Expire(redisKey, 3600);

	format(redisKey, sizeof(redisKey), "player:%d:smuggling:role", UID);
	Redis_SetInt(RedisClient, redisKey, role);
	Redis_Expire(redisKey, 3600);
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
		MruMessageGoodInfoF(driverID, "%s rozpocz¹³ z Tob¹ akcjê przemytnicz¹ - mainowa³ Ciê pilotem wodolotu. Jeœli nie chcesz w niej uczestniczyæ, wpisz /anuluj przemyt", GetNick(playerid));
	}
	RedisStartSmuggling(driverUID, redisActionID, SMUGGLING_ROLE_DRIVER);

	// set info about smuggling for all partners
	for(new i; i<GetPVarInt(playerid, "smuggling-partner-index"); i++)
	{
		new partnerID = GetPVarInt(playerid, sprintf("smugging-partner-%d-id", i));
		new partnerUID = GetPVarInt(playerid, sprintf("smugging-partner-%d-uid", i));
		if(IsPlayerConnected(partnerID) && PlayerInfo[partnerID][pUID] == partnerUID)
		{
			MruMessageGoodInfoF(partnerID, "%s rozpocz¹³ z Tob¹ akcjê przemytnicz¹. Jeœli nie chcesz w niej uczestniczyæ, wpisz /anuluj przemyt", GetNick(playerid));
		}
		RedisStartSmuggling(partnerUID, redisActionID, SMUGGLING_ROLE_PARTNER);
	}

	SmugglingActionsCount++;
}

timer DeactivateSmuggling[3600000](actionID)
{
	switch(SmugglingAction[actionID][SmugglingStage])
	{
		case SMUGGLING_STAGE_PICKUP:
		{
			DestroyDynamicObject(SmugglingAction[actionID][DropPointFlareObject]);
		}
		case SMUGGLING_STAGE_DROP:
		{
			DestroyDynamicObject(SmugglingAction[actionID][DropPointFlareObject]);
			DestroyDynamicObject(SmugglingAction[actionID][DropPointContainerObject]);
		}
	}
}

CreateSmugglingPickupCheckpoint(playerid, actionID)
{
	SetPlayerCheckpoint(playerid, 
		SmugglingAction[actionID][PickupPointX], SmugglingAction[actionID][PickupPointY], SmugglingAction[actionID][PickupPointZ], 
		10);
}

CreateDropPointFlare(actionID)
{
	SmugglingAction[actionID][DropPointFlareObject] = CreateDynamicObject(18728, 
		SmugglingAction[actionID][GatherPointX], SmugglingAction[actionID][GatherPointY], SmugglingAction[actionID][GatherPointZ] - 0.5, 
		0, 0, 0.0, 150.0);
}

CreateDropPointContainer(actionID)
{
	SmugglingAction[actionID][DropPointFlareObject] = CreateDynamicObject(1334, 
		SmugglingAction[actionID][GatherPointX], SmugglingAction[actionID][GatherPointY], SmugglingAction[actionID][GatherPointZ], 
		0, 0, 0.0, 150.0);
}



//end