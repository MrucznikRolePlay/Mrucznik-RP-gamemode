//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
FB_OnPlayerEnterDynamicArea(playerid, areaid)
{
	new cop = IsAPolicja(playerid);
	new org = GetPlayerOrg(playerid);
	if(org <= 0 && !cop)
	{
		return;
	}

	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			if(!FrontBusiness[i][TakeoverActive])
			{
				return;
			}
			else
			{
				new redisKey[64];
				format(redisKey, sizeof(redisKey), "player:%d:restricted-area", PlayerInfo[playerid][pUID]);
				if(RedisGetInt(redisKey) == i)
				{
					defer RestrictFromBusinessArea(playerid, i);
				}
			}
			TogglePlayerDynamicCP(playerid, FrontBusiness[i][TakeoverCheckpoint], true);
			return;
		}

		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			if(!FrontBusiness[i][TakeoverActive])
			{
				return;
			}
			new isDefense = FrontBusiness[i][Owner] == org;
			if(!IsActiveOrg(org) && !cop)
			{
				return;
			}
			FrontBusiness[i][TakingOver][org]++;

			if(FrontBusiness[i][TakingOver][org] == TAKING_OVER_ATTACK_PLAYERS_THRESHOLD && !isDefense)
			{
				TriggerTakingOver(i, org);
			}

			// message
			SendEnterTakeoverAreaMessage(playerid, i, org, isDefense);
			return;
		}
	}
}

SendEnterTakeoverAreaMessage(playerid, bizId, org, isDefense)
{
	if(isDefense)
	{
		// defense
		if(FrontBusiness[bizId][TakingOver][org] == TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~b~Rozpoczeto obrone biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] > TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Dolaczyles do obrony biznesu", 5000, 1);
		}
		else
		{
			GameTextForPlayer(playerid, "Jestes w strefe przejecia biznesu~n~potrzeba "#TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD" osob z organizacji by obronic biznes", 5000, 1);
		}
	}
	else
	{
		// attack
		if(FrontBusiness[bizId][TakingOver][org] == TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Rozpoczeto przejmowanie biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] > TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Dolaczyles do przejmowania biznesu", 5000, 1);
		}
		else
		{
			GameTextForPlayer(playerid, "Jestes w strefe przejecia biznesu~n~potrzeba "#TAKING_OVER_ATTACK_PLAYERS_THRESHOLD" osob z organizacji by przejac biznes", 5000, 1);
		}
	}
}

FB_OnPlayerLeaveDynamicArea(playerid, areaid)
{
	new cop = IsAPolicja(playerid);
	new org = GetPlayerOrg(playerid);
	if(org <= 0 && !cop)
	{
		return;
	}

	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			if(!FrontBusiness[i][TakeoverActive])
			{
				return;
			}
			TogglePlayerDynamicCP(playerid, FrontBusiness[i][TakeoverCheckpoint], false);
			return;
		}
		
		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			if(!FrontBusiness[i][TakeoverActive])
			{
				return;
			}

			new isDefense = FrontBusiness[i][Owner] == org;
			if(FrontBusiness[i][TakingOver][org] <= TAKING_OVER_ATTACK_PLAYERS_THRESHOLD && !isDefense)
			{
				StopTakingOver(i);
			}

			FrontBusiness[i][TakingOver][org]--;
			if(FrontBusiness[i][TakingOver][org] < 0)
				FrontBusiness[i][TakingOver][org] = 0;

			// message
			SendExitTakeoverAreaMessage(playerid, i, org, isDefense);
			return;
		}
	}
}

SendExitTakeoverAreaMessage(playerid, bizId, org, isDefense)
{
	if(isDefense)
	{
		// defense
		if(FrontBusiness[bizId][TakingOver][org] >= TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Opusciles strefe obrony biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] < TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Twoja organizacja przestala bronic biznes!", 5000, 1);
		}
	}
	else
	{
		// attack
		if(FrontBusiness[bizId][TakingOver][org] >= TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Opusciles strefe przejmowanie biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] < TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Twoja organizacja przestala przejmowac biznes!", 5000, 1);
		}
	}
}

FrontBiz_OnPayDay(playerid)
{
	new org = GetPlayerOrg(playerid);
	if(org == 0)
	{
		return;
	}

	new totalIncome;
	new memberIncome;
	new leaderIncome;
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(IsFrontBusinnesOwnedByOrg(i, org))
		{
			if(ActiveFire == i)
			{
				SendClientMessage(playerid, COLOR_RED, sprintf("  Biznes Twojej organizacji %s p³onie, wiêc nie generuje zysku!", FrontBusiness[i][Name]));
				continue;
			}
			// wzór: podstawowy_dochód + dochód_za_gracza * log2(liczba_graczy)
			new Float:perPlayerIncome = float(IncomePerPlayer) * floatlog(float(Iter_Count(Player)), 2.0);
			new frontBizIncome = floatround(perPlayerIncome) + BaseIncome;

			new singleBizLeaderIncome = (frontBizIncome * OrgInfo[org][o_LeaderStake]) / 100;
			new singleBizMemberIncome = frontBizIncome - singleBizLeaderIncome;

			totalIncome += frontBizIncome;
			memberIncome += singleBizMemberIncome;
			leaderIncome += singleBizLeaderIncome;

			RedisIncrBy(RedisFrontBizKey(i, "profit"), frontBizIncome);
			RedisIncrBy(RedisFrontBizKey(i, "leaderProfit"), singleBizLeaderIncome);
			RedisIncrBy(RedisFrontBizKey(i, "profit-player"), frontBizIncome);
			RedisIncrBy(RedisFrontBizKey(i, "leaderProfit-player"), singleBizLeaderIncome);
		}
	}

	PlayerInfo[playerid][pAccount] += memberIncome;
	SejfR_Add(org, leaderIncome);
	AccountOrgBenefitForPlayerUID(PlayerInfo[playerid][pUID], org, leaderIncome);

	// messages
	SendClientMessage(playerid, COLOR_GREY, sprintf("  Dochód z biznesów organizacji: %d$.", totalIncome));
	SendClientMessage(playerid, COLOR_GREY, sprintf("  Dostajesz z tego: "INCOLOR_GREEN"%d$"INCOLOR_GREY" a "INCOLOR_RED"%d$"INCOLOR_GREY" idzie dla lidera.", memberIncome, leaderIncome));
}

hook OnPlayerConnect(playerid)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		new color;
		if(IsActiveOrg(FrontBusiness[i][Owner]))
		{
			color = OrgInfo[FrontBusiness[i][Owner]][o_Color];
		}
		else 
		{
			color = COLOR_WHITE;
		}
		GangZoneShowForPlayer(playerid, FrontBusiness[i][BizGangZone], color & 0xFFFFFF66);
	}
}

hook OnPlayerPause(playerid)
{
	new bizId = -1;
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(IsPlayerInDynamicArea(playerid, FrontBusiness[i][TakeoverArea]))
		{
			bizId = i;
			break;
		}
	}
	if(bizId >= 0)
	{
		new areaid = FrontBusiness[bizId][TakeoverArea];
		SetPVarInt(playerid, "takeover-afk", areaid);
		FB_OnPlayerLeaveDynamicArea(playerid, areaid);
	}
}

hook OnPlayerResume(playerid)
{
	new areaid = GetPVarInt(playerid, "takeover-afk");
	if(areaid > 0)
	{
		FB_OnPlayerEnterDynamicArea(playerid, areaid);
		DeletePVar(playerid, "takeover-afk");
	}
}

//end