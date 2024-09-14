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
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!FrontBusiness[i][TakeoverActive])
		{
			return;
		}

		if(GetPlayerOrg(playerid) == 0 && !IsAPolicja(playerid))
		{
			return;
		}

		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			TogglePlayerDynamicCP(playerid, FrontBusiness[i][TakeoverCheckpoint], true);
			SetPVarInt(playerid, "show-takeover-info", i+1);
			return;
		}

		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			new org = GetPlayerOrg(playerid);
			if(!IsActiveOrg(org))
			{
				return;
			}
			SetPVarInt(playerid, "taking-over", i + 1);
			FrontBusiness[i][TakingOver][org]++;

			if(FrontBusiness[i][TakingOver][org] == TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
			{
				TriggerTakingOver(i, org);
			}

			// message
			new isDefense = FrontBusiness[i][Owner] == org;
			SendEnterTakeoverAreaMessage(playerid, i, org, isDefense);
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
			GameTextForPlayer(playerid, "~b~Rozpoczêto obrone biznesu", 5000, 1);
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
			GameTextForPlayer(playerid, "~r~Rozpoczêto przejmowanie biznesu", 5000, 1);
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
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!FrontBusiness[i][TakeoverActive])
		{
			DeletePVar(playerid, "taking-over");
			DeletePVar(playerid, "show-takeover-info");
			return;
		}

		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			TogglePlayerDynamicCP(playerid, FrontBusiness[i][TakeoverCheckpoint], false);
			DeletePVar(playerid, "show-takeover-info");
			return;
		}

		new org = GetPlayerOrg(playerid);
		if(org <= 0)
		{
			return;
		}
		
		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			new isDefense = FrontBusiness[i][Owner] == org;
			DeletePVar(playerid, "taking-over");

			new threshold;
			if(isDefense)
				threshold = TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD-1;
			else
				threshold = TAKING_OVER_ATTACK_PLAYERS_THRESHOLD-1;

			if(FrontBusiness[i][TakingOver][org] == threshold)
			{
				StopTakingOver(i, org);
			}

			FrontBusiness[i][TakingOver][org]--;

			// message
			SendExitTakeoverAreaMessage(playerid, i, org, isDefense);
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
	for(new i=1; i<sizeof(FrontBusiness); i++)
	{
		if(IsFrontBusinnesOwnedByOrg(i, org))
		{
			// wzór: podstawowy_dochód + dochód_za_gracza * log2(liczba_graczy)
			new Float:perPlayerIncome = float(IncomePerPlayer) * floatlog(float(Iter_Count(Player)), 2.0);
			new frontBizIncome = floatround(perPlayerIncome) + BaseIncome;

			new singleBizLeaderIncome = (frontBizIncome * OrgInfo[org][o_LeaderStake]) / 100;
			new singleBizMemberIncome = frontBizIncome - singleBizLeaderIncome;

			totalIncome += frontBizIncome;
			memberIncome += singleBizMemberIncome;
			leaderIncome += singleBizLeaderIncome;

			Redis_IncrBy(RedisFrontBizKey(i, "profit"), frontBizIncome);
			Redis_IncrBy(RedisFrontBizKey(i, "leaderProfit"), singleBizLeaderIncome);
		}
	}

	PlayerInfo[playerid][pAccount] += memberIncome;
	SejfR_Add(org, leaderIncome);
	AccountOrgBenefitForPlayerUID(PlayerInfo[playerid][pUID], org, leaderIncome);

	// messages
	SendClientMessage(playerid, COLOR_GREY, sprintf("  Dochód z biznesów organizacji: %d$.", totalIncome));
	SendClientMessage(playerid, COLOR_GREY, sprintf("  Dostajesz z tego: "INCOLOR_GREEN"%d$"INCOLOR_GREY" a "INCOLOR_RED"%d$"INCOLOR_GREY" idzie dla lidera.", memberIncome, leaderIncome));
}

//end