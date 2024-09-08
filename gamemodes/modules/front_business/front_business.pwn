//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               front_business                                              //
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
// Data utworzenia: 05.09.2024
//Opis:
/*
	System bzinesów-przykrywek dla organizacji przestêpczych
*/

//

//-----------------<[ Funkcje: ]>-------------------
LoadFrontBusinesses()
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!Redis_Exists(RedisClient,  RedisFrontBizKey(i, "initialized")))
		{
			// default values
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "takeoverHour"), 16 + random(7));
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "takeoverMinute"), 30 * random(2));
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "takeoverTime"), 3600); // 30 minutes

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "color"), COLOR_BROWN);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "owner"), 0);

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "profit"), 0);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "leaderProfit"), 0);

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "initialized"), 1);
		}
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverHour"), FrontBusiness[i][TakeoverHour]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverMinute"), FrontBusiness[i][TakeoverMinute]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverTime"),  FrontBusiness[i][TakeoverTime]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "color"), FrontBusiness[i][BizColor]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "owner"), FrontBusiness[i][Owner]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "leaderStake"), FrontBusiness[i][Owner]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "owner"), FrontBusiness[i][Owner]);


		MruCreateDynamicMapIcon(FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], 
			GetFrontBusinessIcon(FrontBusiness[i][Type]),
			-1, // color, This should only be used with the square icon (ID: 0)
			FrontBusiness[i][OutInt], // worldid
			FrontBusiness[i][OutVw], // interiorid
			-1, // playerid
			-1, // streamdistance -1 = inifnite
			MAPICON_LOCAL // style https://www.open.mp/docs/scripting/resources/mapiconstyles
		);

		new areaMinX = FrontBusiness[i][OutX] - FRONT_BUSINESS_GANGZONE_SIZE;
		new areaMinY = FrontBusiness[i][OutY] - FRONT_BUSINESS_GANGZONE_SIZE;
		new areaMaxX = FrontBusiness[i][OutX] + FRONT_BUSINESS_GANGZONE_SIZE;
		new areaMaxY = FrontBusiness[i][OutY] + FRONT_BUSINESS_GANGZONE_SIZE;
		FrontBusiness[i][BizGangZone] = GangZoneCreate(areaMinX, areaMinY, areaMaxX, areaMaxY);
		GangZoneShowForAll(FrontBusiness[i][BizGangZone], FrontBusiness[i][BizColor]);

		FrontBusiness[i][GangZoneArea] = CreateDynamicRectangle(areaMinX, areaMinY, areaMaxX, areaMaxY, 
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);
		FrontBusiness[i][TakeoverArea] = CreateDynamicCylinder(FrontBusiness[i][OutX], FrontBusiness[i][OutY], 
			FrontBusiness[i][OutZ], FrontBusiness[i][OutZ] + 10, 
			TAKEOVER_ZONE_SIZE, FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		CreateDynamicPickup(GetFrontBusinessPickup(FrontBusiness[i][Type]), 1, 
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ],
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		CreateDynamic3DTextLabel(FrontBusiness[i][Name], FrontBusiness[i][BizColor], 
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], 
			EXTERIOR_3DTEXT_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1,
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);
		if(FrontBusiness[i][InX] != 0.0) 
		{
			CreateDynamic3DTextLabel("Wyjœcie", FrontBusiness[i][BizColor], FrontBusiness[i][InX], FrontBusiness[i][InY], FrontBusiness[i][InZ], 
				INTERIOR_3DTEXT_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1,
				FrontBusiness[i][InVw], FrontBusiness[i][InInt]);
		}

		DodajWejscieNoPickup(
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], FrontBusiness[i][OutInt], FrontBusiness[i][OutVw],
			FrontBusiness[i][InX], FrontBusiness[i][InY], FrontBusiness[i][InZ], FrontBusiness[i][InInt], FrontBusiness[i][InVw]
		);
	}
}

StartFrontBizTakeover(bizId)
{
	FrontBusiness[bizId][TakeoverActive] = true;
	FrontBusiness[bizId][TakeoverStartTime] = gettime();

	FrontBusiness[bizId][TakeoverCheckpoint] = CreateDynamicObject(19945, 
		FrontBusiness[bizId][TakeoverX], FrontBusiness[bizId][TakeoverY], FrontBusiness[bizId][TakeoverZ] - 0.5, 
		0.0, 0.0, 0.0, 
		FrontBusiness[bizId][TakeoverVw], FrontBusiness[bizId][TakeoverInt],
		INVALID_PLAYER_ID, STREAMER_CP_SD, STREAMER_OBJECT_DD, FrontBusiness[bizId][GangZoneArea]);
}

StopFrontBizTakeover(bizId)
{
	FrontBusiness[bizId][TakeoverActive] = false;
	DestroyDynamicObject(FrontBusiness[bizId][TakeoverCheckpoint]);

	new winner = -1, maxScore;
	for(new i; i<MAX_ORG; i++)
	{
		new score = FrontBusiness[bizId][TakingOverScore][i];
		if(score > maxScore)
		{
			maxScore = score;
			winner = i;
		}

		// cleanup
		FrontBusiness[bizId][TakingOver][i] = 0;
		FrontBusiness[bizId][TakingOverScore][i] = 0;
	}

	// Check the winner
	if(winner != -1)
	{
		if(winner == FrontBusiness[bizId][Owner] || maxScore < TAKE_OVER_POINT_THRESHOLD)
		{
			// successful defence
			SuccessfulDefenceMessage(bizId, winner);
		}
		else
		{
			// successful attack
			new oldOwner = FrontBusiness[bizId][Owner];
			TakeOverFrontBusiness(bizId, winner);
			SuccessfulAttackMessage(bizId, winner, oldOwner);
		}
	}
}

TriggerTakingOver(bizId, org)
{
	new color = FrontBusiness[bizId][BizColor];
	new invertedColor = (color & 0xFF000000) | (~color & 0x00FFFFFF);
	GangZoneFlashForAll(FrontBusiness[bizId][BizGangZone], invertedColor);

	if(FrontBusiness[bizId][TakingOverScore][org] == 0)
	{
		SendOrgMessage(org, COLOR_PANICRED, "UWAGA! AGRESJA!");
		SendOrgMessage(org, COLOR_PANICRED, sprintf("Ktoœ atakuje nale¿¹cy do waszej organizacji biznes %s!", FrontBusiness[bizId][Name]));
	}
}

StopTakingOver(bizId, org)
{
	GangZoneStopFlashForAll(FrontBusiness[bizId][BizGangZone]);

	SendOrgMessage(org, COLOR_LIGHTGREEN, sprintf("Uda³o siê odeprzeæ atak na biznes %s!", FrontBusiness[bizId][Name]));
}

IncrTakeoverPointsStat(org)
{
	foreach(new i : Player)
	{
		new playerTakeoverOrg = GetPVarInt(i, "taking-over") - 1;
		if(playerTakeoverOrg != org || playerTakeoverOrg == 0)
		{
			continue;
		}

		IncrPlayerTakeoverPoints(i, org, 1); // TODO: optimize
	}
}

TakeOverFrontBusiness(bizId, org)
{
	new color = OrgInfo[org][o_Color];
	FrontBusiness[bizId][Owner] = org;
	FrontBusiness[bizId][BizColor] = color;
	Redis_GetInt(RedisClient, RedisFrontBizKey(bizId, "color"), color);
	Redis_GetInt(RedisClient, RedisFrontBizKey(bizId, "owner"), org);
}

SuccessfulDefenceMessage(bizId, org)
{
	SendOrgMessage(org, COLOR_LIGHTGREEN, sprintf("Twoja organizacja z sukcesem obroni³a biznes %s", FrontBusiness[bizId][Name]));
}

SuccessfulAttackMessage(bizId, org, oldOwner)
{
	SendOrgMessage(org, COLOR_LIGHTGREEN, "UDA£O SIÊ!");
	SendOrgMessage(org, COLOR_LIGHTGREEN, sprintf("Twoja organizacja przejê³a biznes %s", FrontBusiness[bizId][Name]));

	if(IsActiveOrg(oldOwner))
	{
		SendOrgMessage(oldOwner, COLOR_PANICRED, "TRAGEDIA!");
		SendOrgMessage(oldOwner, COLOR_PANICRED, sprintf("Twoja organizacja straci³a kontrolê nad biznesem %s", FrontBusiness[bizId][Name]));
	}
}

IsPlayerNearOwnFrontBusiness(playerid, Float:proximity=5.0)
{
	new bizId = IsPlayerAtFrontBusinnesZone(playerid);
	if(bizId <= 0)
	{
		return 0;
	}

	if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, bizId))
	{
		return 0;
	}

	if(GetPlayerFrontBusinessProximity(playerid, bizId) > proximity)
	{
		return 0;
	}
	return 1;
}

IsPlayerAtFrontBusinnesZone(playerid)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(IsPlayerInDynamicArea(playerid, FrontBusiness[i][GangZoneArea]))
		{
			return i;
		}
	}
	return 0;
}

Float:GetPlayerFrontBusinessProximity(playerid, bizId)
{
	return GetPlayerDistanceFromPoint(playerid, FrontBusiness[bizId][OutX], FrontBusiness[bizId][OutY], FrontBusiness[bizId][OutZ]);
}

IsFrontBusinnesOwnedByPlayerOrg(playerid, bizId)
{
	return FrontBusiness[bizId][Owner] == GetPlayerOrg(playerid);
}

IsFrontBusinnesOwnedByOrg(bizId, org)
{
	return FrontBusiness[bizId][Owner] == org;
}

ShowFrontBusinessInfo(playerid, bizId)
{
	new string[256], owner[32];
	if(FrontBusiness[bizId][Owner] == 0)
		strcat(owner, "Brak");
	else
		strcat(owner, OrgInfo[FrontBusiness[bizId][Owner]][o_Name]);

	format(string, sizeof(string), "Biznes: %s~n~~w~Wlasciciel: ~b~%s~n~~w~Godzina przejecia: ~b~%02d:%02d~n~~w~Czas przejêcia: %d minut~n~~w~Bazowy zysk: ~b~%d$~n~~w~Bonus za gracza online: ~b~%d",
		FrontBusiness[bizId][Name], owner,
		FrontBusiness[bizId][TakeoverHour], FrontBusiness[bizId][TakeoverMinute], FrontBusiness[bizId][TakeoverTime] / 60,
		FrontBusiness[bizId][BaseIncome], FrontBusiness[bizId][IncomePerPlayer]);
	GameTextForPlayer(playerid, string, 1100, 15);
}

GetFrontBusinessIcon(type)
{
	switch(type)
	{
    	case FRONT_BIZ_TYPE_GUNSHOP: { return 2044; }
		case FRONT_BIZ_TYPE_RACE: { return 53; }
		case FRONT_BIZ_TYPE_RESTAURANT: { return 49; }
		case FRONT_BIZ_TYPE_CLUB: { return 48; }
		case FRONT_BIZ_TYPE_PIZZA: { return 29; }
		case FRONT_BIZ_TYPE_BURGER: { return 10; }
		case FRONT_BIZ_TYPE_CHICKEN: { return 14; }
    	case FRONT_BIZ_TYPE_CASINO: { return 25; }
		case FRONT_BIZ_TYPE_GYM: { return 54; }
		case FRONT_BIZ_TYPE_CLOTH: { return 45; }
		case FRONT_BIZ_TYPE_BARBER: { return 7; }
		case FRONT_BIZ_TYPE_BOAT: { return 9; }
		case FRONT_BIZ_TYPE_SPRAY: { return 63; }
	}
	return 0;
}

GetFrontBusinessPickup(type)
{
	switch(type)
	{
    	case FRONT_BIZ_TYPE_GUNSHOP: { return 6; }
    	case FRONT_BIZ_TYPE_CASINO: { return 1851; }
		case FRONT_BIZ_TYPE_RACE: { return 19306; }
		case FRONT_BIZ_TYPE_RESTAURANT: { return 19819; }
		case FRONT_BIZ_TYPE_CLUB: { return 19143; }
		case FRONT_BIZ_TYPE_PIZZA: { return 19580; }
		case FRONT_BIZ_TYPE_BURGER: { return 19811; }
		case FRONT_BIZ_TYPE_GYM: { return 3071; }
		case FRONT_BIZ_TYPE_CHICKEN: { return 2770; }
		case FRONT_BIZ_TYPE_CLOTH: { return 1275; }
		case FRONT_BIZ_TYPE_BARBER: { return 2750; }
		case FRONT_BIZ_TYPE_BOAT: { return 19630; }
		case FRONT_BIZ_TYPE_SPRAY: { return 19627; }
	}
	return 19523;
}

//end