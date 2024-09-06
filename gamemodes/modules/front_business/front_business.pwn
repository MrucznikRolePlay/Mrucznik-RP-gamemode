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
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "color"), COLOR_GREY);
		}
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverHour"), FrontBusiness[i][TakeoverHour]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverMinute"), FrontBusiness[i][TakeoverMinute]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "takeoverTime"),  FrontBusiness[i][TakeoverTime]);
		Redis_GetInt(RedisClient, RedisFrontBizKey(i, "color"), FrontBusiness[i][BizColor]);
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
		FrontBusiness[i][TakeoverArea] = CreateDynamicCircle(FrontBusiness[i][OutX], FrontBusiness[i][OutY], 
			TAKEOVER_ZONE_SIZE, FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		CreateDynamicPickup(GetFrontBusinessPickup(FrontBusiness[i][Type]), 1, 
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ],
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		CreateDynamic3DTextLabel(FrontBusiness[i][Name], FrontBusiness[i][BizColor], FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], 
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
}

StopFrontBizTakeover(bizId)
{
	FrontBusiness[bizId][TakeoverActive] = false;

	new winner = -1, maxScore;
	for(new i; i<MAX_ORG; i++)
	{
		FrontBusiness[bizId][TakingOver][i] = 0;

		new score = FrontBusiness[bizId][TakingOverScore][i];
		if(score > maxScore)
		{
			maxScore = score;
			winner = i;
		}
	}

	// Check the winner
	if(winner != -1)
	{
		if(winner == FrontBusiness[bizId][Owner] && maxScore > 0)
		{
			// successful defence
			SuccessfulDefenceMessage(bizId, winner);
		}
		else if(maxScore > TAKE_OVER_POINT_THRESHOLD)
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
		new orgUid = OrgInfo[org][o_UID];
		SendNewFamilyMessage(orgUid, COLOR_PANICRED, "UWAGA! AGRESJA!");
		SendNewFamilyMessage(orgUid, COLOR_PANICRED, sprintf("Ktoœ atakuje nale¿¹cy do waszej organizacji biznes %s!", FrontBusiness[bizId][Name]));
	}
}

StopTakingOver(bizId, org)
{
	GangZoneStopFlashForAll(FrontBusiness[bizId][BizGangZone]);

	new orgUid = OrgInfo[org][o_UID];
	SendNewFamilyMessage(orgUid, COLOR_LIGHTGREEN, sprintf("Uda³o siê odeprzeæ atak na biznes %s!", FrontBusiness[bizId][Name]));
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
	new orgUid = OrgInfo[org][o_UID];
	SendNewFamilyMessage(orgUid, COLOR_LIGHTGREEN, sprintf("Twoja organizacja z sukcesem obroni³a biznes %s", FrontBusiness[bizId][Name]));
}

SuccessfulAttackMessage(bizId, org, oldOwner)
{
	new orgUid = OrgInfo[org][o_UID];
	SendNewFamilyMessage(orgUid, COLOR_LIGHTGREEN, "UDA£O SIÊ!");
	SendNewFamilyMessage(orgUid, COLOR_LIGHTGREEN, sprintf("Twoja organizacja przejê³a biznes %s", FrontBusiness[bizId][Name]));

	if(orgIsValid(oldOwner))
	{
		new oldOrgOwner = OrgInfo[oldOwner][o_UID];
		SendNewFamilyMessage(oldOrgOwner, COLOR_PANICRED, "TRAGEDIA!");
		SendNewFamilyMessage(oldOrgOwner, COLOR_PANICRED, sprintf("Twoja organizacja straci³a kontrolê nad biznesem %s", FrontBusiness[bizId][Name]));
	}
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