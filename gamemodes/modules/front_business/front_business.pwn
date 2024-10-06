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
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "takeoverTime"), 3600); // 60 minutes

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "color"), COLOR_BROWN);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "owner"), 0);

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "profit"), 0);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "leaderProfit"), 0);

			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "initialized"), 1);
		}
		FrontBusiness[i][TakeoverHour] = RedisGetInt(RedisFrontBizKey(i, "takeoverHour"));
		FrontBusiness[i][TakeoverMinute] = RedisGetInt(RedisFrontBizKey(i, "takeoverMinute"));
		FrontBusiness[i][TakeoverTime] = RedisGetInt(RedisFrontBizKey(i, "takeoverTime"));
		FrontBusiness[i][BizColor] = RedisGetInt(RedisFrontBizKey(i, "color"));
		FrontBusiness[i][Owner] = RedisGetInt(RedisFrontBizKey(i, "owner"));
		FrontBusiness[i][TakeoverArea] = -1;

		MruCreateDynamicMapIcon(FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], 
			GetFrontBusinessIcon(FrontBusiness[i][Type]),
			-1, // color, This should only be used with the square icon (ID: 0)
			FrontBusiness[i][OutVw], // worldid
			FrontBusiness[i][OutInt], // interiorid
			-1, // playerid
			2000.0, // streamdistance -1 = inifnite
			MAPICON_GLOBAL // style https://www.open.mp/docs/scripting/resources/mapiconstyles
		);

		new Float:areaMinX = FrontBusiness[i][OutX] - FRONT_BUSINESS_GANGZONE_SIZE;
		new Float:areaMinY = FrontBusiness[i][OutY] - FRONT_BUSINESS_GANGZONE_SIZE;
		new Float:areaMaxX = FrontBusiness[i][OutX] + FRONT_BUSINESS_GANGZONE_SIZE;
		new Float:areaMaxY = FrontBusiness[i][OutY] + FRONT_BUSINESS_GANGZONE_SIZE;
		FrontBusiness[i][BizGangZone] = GangZoneCreate(areaMinX, areaMinY, areaMaxX, areaMaxY);
		GangZoneShowForAll(FrontBusiness[i][BizGangZone], FrontBusiness[i][BizColor] & 0xFFFFFF66);

		FrontBusiness[i][GangZoneArea] = CreateDynamicRectangle(areaMinX, areaMinY, areaMaxX, areaMaxY, 
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		CreateDynamicPickup(GetFrontBusinessPickup(FrontBusiness[i][Type]), 1, 
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ],
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);

		FrontBusiness[i][Out3DText] = CreateDynamic3DTextLabel(FrontBusiness[i][Name], FrontBusiness[i][BizColor], 
			FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ] + 0.2, 
			EXTERIOR_3DTEXT_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1,
			FrontBusiness[i][OutVw], FrontBusiness[i][OutInt]);
	
		FrontBusiness[i][TakeoverArea] = CreateDynamicCylinder(FrontBusiness[i][TakeoverX], FrontBusiness[i][TakeoverY], 
			FrontBusiness[i][TakeoverZ], FrontBusiness[i][TakeoverZ] + 10, 
			TAKEOVER_ZONE_SIZE, FrontBusiness[i][TakeoverVw], FrontBusiness[i][TakeoverInt]);

		if(FrontBusiness[i][InX] != 0.0) 
		{
			FrontBusiness[i][In3DText] = CreateDynamic3DTextLabel("Wyjœcie", FrontBusiness[i][BizColor], 
				FrontBusiness[i][InX], FrontBusiness[i][InY], FrontBusiness[i][InZ] + 0.2, 
				INTERIOR_3DTEXT_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1,
				FrontBusiness[i][InVw], FrontBusiness[i][InInt]);
				
			DodajWejscieNoPickup(
				FrontBusiness[i][OutX], FrontBusiness[i][OutY], FrontBusiness[i][OutZ], FrontBusiness[i][OutVw], FrontBusiness[i][OutInt],
				FrontBusiness[i][InX], FrontBusiness[i][InY], FrontBusiness[i][InZ], FrontBusiness[i][InVw], FrontBusiness[i][InInt],
				0, 1000+i
			);
		}

		if(FrontBusiness[i][Type] == FRONT_BIZ_TYPE_SPRAY)
		{
			new idx = FrontBizPayNSprayID;
			StworzWjedz(FakePayNSpray[idx][0], FakePayNSpray[idx][1], FakePayNSpray[idx][2], 
				FrontBusiness[i][InX], FrontBusiness[i][InY], FrontBusiness[i][InZ], 
				25.0, FrontBusiness[i][InVw], FrontBusiness[i][InInt], " ", " ", 0, 0, LOCAL_PAY_N_SPRAY);
			FrontBizPayNSprayID++;
		}
	}
}

StartFrontBizTakeover(bizId)
{
	FrontBusiness[bizId][TakeoverActive] = true;
	FrontBusiness[bizId][TakeoverStartTime] = gettime();

	FrontBusiness[bizId][TakeoverCheckpoint] = CreateDynamicCP(FrontBusiness[bizId][TakeoverX], FrontBusiness[bizId][TakeoverY], FrontBusiness[bizId][TakeoverZ] - 0.5,
		TAKEOVER_ZONE_SIZE, FrontBusiness[bizId][TakeoverVw], FrontBusiness[bizId][TakeoverInt],
		INVALID_PLAYER_ID, FRONT_BUSINESS_GANGZONE_SIZE, FrontBusiness[bizId][GangZoneArea]);

	FrontBusiness[bizId][TakeoverPickup] = CreateDynamicPickup(1313, 1, 
		FrontBusiness[bizId][TakeoverX], FrontBusiness[bizId][TakeoverY], FrontBusiness[bizId][TakeoverZ], 
		FrontBusiness[bizId][TakeoverVw], FrontBusiness[bizId][TakeoverInt]); 

	foreach(new i : Player)
	{
		if(IsPlayerInDynamicArea(i, FrontBusiness[bizId][GangZoneArea]))
		{
			TogglePlayerDynamicCP(i, FrontBusiness[bizId][TakeoverCheckpoint], true);
		}
	}
}

StopFrontBizTakeover(bizId)
{
	FrontBusiness[bizId][TakeoverActive] = false;
	DestroyDynamicCP(FrontBusiness[bizId][TakeoverCheckpoint]);
	DestroyDynamicPickup(FrontBusiness[bizId][TakeoverPickup]);
	FrontBusiness[bizId][TakeoverArea] = -1;

	new winner = -1, maxScore;
	for(new i=0; i<MAX_ORG; i++)
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
		if(winner == FrontBusiness[bizId][Owner])
		{
			// successful defence
			SuccessfulDefenceMessage(bizId, winner);
		}
		else if(maxScore < TAKE_OVER_POINT_THRESHOLD)
		{
			SuccessfulDefenceMessage(bizId, FrontBusiness[bizId][Owner]);
			if(winner != 0)
			{
				SendOrgMessage(winner, COLOR_RED, "Koniec przejmowania!");
				SendOrgMessage(winner, COLOR_RED, sprintf(
					"Niestety, Twojej organizacji nie uda³o siê prekroczyæ progu %d punktów wymaganego do przejêcia biznesu",
					TAKE_OVER_POINT_THRESHOLD));
			}
			else
			{
				new string[MAX_MESSAGE_LENGTH];
				format(string, sizeof(string), "Niestety - nie uda³o siê przekroczyæ progu %d punktów i przej¹æ biznesu z r¹k przestêpców.", TAKE_OVER_POINT_THRESHOLD);
				SendFamilyMessage(FRAC_LSPD, COLOR_RED, "Koniec przejmowania!");
				SendFamilyMessage(FRAC_FBI, COLOR_RED, "Koniec przejmowania!");
				SendFamilyMessage(FRAC_NG, COLOR_RED, "Koniec przejmowania!");
				SendFamilyMessage(FRAC_LSPD, COLOR_RED, string);
				SendFamilyMessage(FRAC_FBI, COLOR_RED, string);
				SendFamilyMessage(FRAC_NG, COLOR_RED, string);
			}
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
	GangZoneFlashForAll(FrontBusiness[bizId][BizGangZone], 0xFF000066);

	if(FrontBusiness[bizId][TakingOverScore][org] == 0)
	{
		new ownerOrg = FrontBusiness[bizId][Owner];
		if(IsActiveOrg(ownerOrg))
		{
			SendOrgMessage(ownerOrg, COLOR_PANICRED, "UWAGA! AGRESJA!");
			SendOrgMessage(ownerOrg, COLOR_PANICRED, sprintf("Ktoœ atakuje nale¿¹cy do waszej organizacji biznes %s!", FrontBusiness[bizId][Name]));
		}
		else if(ownerOrg == 0)
		{
			for(new i=FRAC_LSPD; i<=FRAC_NG; i++)
			{
				SendFamilyMessage(i, COLOR_WHITE, sprintf("{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000} Ktoœ próbuje przej¹æ biznes %s!", FrontBusiness[bizId][Name]));
			}
		}
	}
}

StopTakingOver(bizId)
{
	new ownerOrg = FrontBusiness[bizId][Owner];
	GangZoneStopFlashForAll(FrontBusiness[bizId][BizGangZone]);

	if(IsActiveOrg(ownerOrg))
	{
		SendOrgMessage(ownerOrg, COLOR_LIGHTGREEN, sprintf("Atakuj¹cy przestali przejmowaæ biznes %s!", FrontBusiness[bizId][Name]));
	}
	else if(ownerOrg == 0)
	{
		for(new i=FRAC_LSPD; i<=FRAC_NG; i++)
		{
			SendFamilyMessage(i, COLOR_WHITE, sprintf("{FFFFFF}»»{6A5ACD} CENTRALA: "INCOLOR_LIGHTGREEN" Sytuacja opanowana, agresorzy przestali atakowaæ biznes %s!", FrontBusiness[bizId][Name]));
		}
	}
}

IncrTakeoverPointsStat(org)
{
	foreach(new i : Player)
	{
		new playerTakeoverOrg = GetPlayerOrg(i);
		if(playerTakeoverOrg != org || playerTakeoverOrg == 0)
		{
			continue;
		}

		new bizId = GetPVarInt(i, "in-takeover-zone") - 1;
		if(bizId < 0)
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
	Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "color"), color);
	Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "owner"), org);
	Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "profit"), 0);
	Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "leaderProfit"), 0);

	GangZoneStopFlashForAll(FrontBusiness[bizId][BizGangZone]);
	GangZoneShowForAll(FrontBusiness[bizId][BizGangZone], color & 0xFFFFFF66);
	UpdateDynamic3DTextLabelText(FrontBusiness[bizId][Out3DText], color, FrontBusiness[bizId][Name]);
	if(FrontBusiness[bizId][InX] != 0.0)
	{
		UpdateDynamic3DTextLabelText(FrontBusiness[bizId][In3DText], color, "Wyjœcie");
	}
}

SuccessfulDefenceMessage(bizId, org)
{
	if(org == 0)
	{
		// LSPD
		new string[MAX_MESSAGE_LENGTH];
		format(string, sizeof(string), "S³u¿y porz¹dkowe z sukcesem obroni³y biznes %s przed infiltracj¹ przez mafiê", FrontBusiness[bizId][Name]);
		for(new i=FRAC_LSPD; i<=FRAC_NG; i++) SendFamilyMessage(i, TEAM_AZTECAS_COLOR, string);
		RedisIncrBy("business_defended_by_lspd", 1);
		return;
	}
	SendOrgMessage(org, COLOR_LIGHTGREEN, sprintf("Twoja organizacja z sukcesem obroni³a biznes %s", FrontBusiness[bizId][Name]));
}

SuccessfulAttackMessage(bizId, org, oldOwner)
{
	if(IsActiveOrg(org))
	{
		SendOrgMessage(org, COLOR_LIGHTGREEN, sprintf("UDA£O SIÊ! Twoja organizacja przejê³a biznes %s", FrontBusiness[bizId][Name]));
	}
	else // LSPD
	{
		new string[MAX_MESSAGE_LENGTH];
		format(string, sizeof(string), "S³u¿y porz¹dkowe z sukcesem rozpracowa³y próby przejêcia biznesu %s pod nielegaln¹ przykrywkê.", FrontBusiness[bizId][Name]);
		for(new i=FRAC_LSPD; i<=FRAC_NG; i++) SendFamilyMessage(i, TEAM_AZTECAS_COLOR, string);
		RedisIncrBy("business_takeover_by_lspd", 1);
	}

	if(IsActiveOrg(oldOwner))
	{
		SendOrgMessage(oldOwner, COLOR_PANICRED, sprintf("TRAGEDIA! Twoja organizacja straci³a kontrolê nad biznesem %s", FrontBusiness[bizId][Name]));
	}
	else if(oldOwner == 0)
	{
		for(new i=FRAC_LSPD; i<=FRAC_NG; i++) SendFamilyMessage(i, COLOR_PANICRED, sprintf("Biznes %s przeszed³ pod wp³ywy mafii.", FrontBusiness[bizId][Name]));
		RedisIncrBy("business_lost_from_lspd", 1);
	}
}

IsPlayerNearOwnFrontBusiness(playerid, Float:proximity=5.0)
{
	new bizId = IsPlayerAtFrontBusinnesZone(playerid);
	if(bizId < 0)
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
	return -1;
}

Float:GetPlayerFrontBusinessProximity(playerid, bizId)
{
	return GetPlayerDistanceFromPoint(playerid, FrontBusiness[bizId][OutX], FrontBusiness[bizId][OutY], FrontBusiness[bizId][OutZ]);
}

IsFrontBusinnesOwnedByPlayerOrg(playerid, bizId)
{
	return FrontBusiness[bizId][Owner] == GetPlayerOrg(playerid);
}

IsBusinessTypeOwnedByPlayerOrg(playerid, type)
{
	new org = GetPlayerOrg(playerid);
	if(!IsActiveOrg(org))
	{
		return 0;
	}

	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(FrontBusiness[i][Type] == type && FrontBusiness[i][Owner] == org)
		{
			return 1;
		}
	}
	return 0;
}

IsFrontBusinnesOwnedByOrg(bizId, org)
{
	return FrontBusiness[bizId][Owner] == org;
}

ShowFrontBusinessInfo(playerid, bizId)
{
	new owner[40];
	if(FrontBusiness[bizId][Owner] == 0)
		strcat(owner, "~r~~h~Brak");
	else
		format(owner, sizeof(owner), "~g~~h~%s", OrgInfo[FrontBusiness[bizId][Owner]][o_Name]);

	TextDrawShowForPlayer(playerid, ZoneTXD[0]);
	TextDrawShowForPlayer(playerid, ZoneTXD[4]);
	TextDrawShowForPlayer(playerid, ZoneTXD[2]);

	new hour, minute, endHour, endMinute;
	GetOrgTakeoverTimeWindow(bizId, hour, minute, endHour, endMinute);

	new string[1024];
	format(string, sizeof(string), "Biznes: ~g~~h~%s~n~" \
		"Typ biznesu: ~g~~h~%s~n~" \
		"Wlasciciel: ~n~  %s~n~" \
		"Do przejecia od: ~n~~g~~h~  %02d:%02d - %02d:%02d~n~" \
		"Zysk na godzine: ~g~~h~%d$~n~" \
		"Bonus za gracza online: ~g~~h~%d$~n~" \
		"+ %s", 
		Odpolszcz(FrontBusiness[bizId][Name]), 
		FrontBusinessType[FrontBusiness[bizId][Type]],
		owner,
		hour, minute, endHour, endMinute,
		FrontBusiness[bizId][BaseIncome], 
		FrontBusiness[bizId][IncomePerPlayer],
		FrontBusinessBenefits[FrontBusiness[bizId][Type]]);
    PlayerTextDrawSetString(playerid, ZonePTXD_Name[playerid], string);
    PlayerTextDrawShow(playerid, ZonePTXD_Name[playerid]);

	SetPVarInt(playerid, "business-info", 1);
}

GetOrgTakeoverTimeWindow(bizId, &hour, &minute, &endHour, &endMinute)
{
	hour = FrontBusiness[bizId][TakeoverHour];
	minute = FrontBusiness[bizId][TakeoverMinute];
	new takeoverTimeMinutes = FrontBusiness[bizId][TakeoverTime];
	new increasedMinutes = minute + (takeoverTimeMinutes/60);
	endHour = hour + (increasedMinutes/60);
	endMinute = (minute + (takeoverTimeMinutes/60)) % 60;
}

GenerateFrontBusinessIncome(bizId, profit)
{
	new org = FrontBusiness[bizId][Owner];
	if(IsActiveOrg(org))
	{
		SejfR_Add(org, profit);
	}
	RedisIncrBy(RedisFrontBizKey(bizId, "leaderProfit"), profit);
}

IsAtFrontBusinessInteriorType(playerid, type)
{
	new bizId = PlayerInfo[playerid][pLocal] - 1000;
	if(bizId > 0 && bizId < sizeof(FrontBusiness))
	{
		if(FrontBusiness[bizId][Type] == type)
		{
			return bizId;
		}
	}
	return -1;
}

UpdateColorForOrgBusinesses(org, color)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(FrontBusiness[i][Owner] == org)
		{
			FrontBusiness[i][BizColor] = color;
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "color"), color);
			GangZoneShowForAll(FrontBusiness[i][BizGangZone], color & 0xFFFFFF66);
			UpdateDynamic3DTextLabelText(FrontBusiness[i][Out3DText], color, FrontBusiness[i][Name]);
			if(FrontBusiness[i][InX] != 0.0)
			{
				UpdateDynamic3DTextLabelText(FrontBusiness[i][In3DText], color, "Wyjœcie");
			}
		}
	}
}

ResetOrgBusinessesToDefault(org)
{
	UpdateColorForOrgBusinesses(org, COLOR_BROWN);
    for(new i; i<sizeof(FrontBusiness); i++)
    {
        if(FrontBusiness[i][Owner] == org)
        {
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "owner"), 0);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "profit"), 0);
			Redis_SetInt(RedisClient, RedisFrontBizKey(i, "leaderProfit"), 0);
            FrontBusiness[i][Owner] = 0;

        }
    }
}

IsAtCasino(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969))
	{
		return 1;
	}

	if(IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_CASINO) != -1)
	{
		return 1;
	}
	return 0;
}

//end