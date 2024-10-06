//-----------------------------------------------<< Timers >>------------------------------------------------//
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

//-----------------<[ Timery: ]>-------------------
task BusinessTakeoverTimer[100]()
{
	new hour, minute;
	gettime(hour, minute);
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(FrontBusiness[i][TakeoverActive])
		{
			UpdateTakeoverPoints(i);

			if(FrontBusiness[i][TakeoverStartTime] + FrontBusiness[i][TakeoverTime] < gettime())
			{
				StopFrontBizTakeover(i);
			}
		}
		else
		{
			if(FrontBusiness[i][TakeoverHour] == hour && FrontBusiness[i][TakeoverMinute] == minute)
			{
				StartFrontBizTakeover(i);
			}
		}
	}
}

UpdateTakeoverPoints(bizId)
{
	for(new i=0; i<MAX_ORG; i++)
	{
		new playersThreshold, pointsIncr, pointsDecr, defend;
		if(i == FrontBusiness[bizId][Owner])
		{
			// defence
			defend = true;
			playersThreshold = TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD;
			pointsIncr = TAKING_OVER_DEFENCE_SCORE_INCREASE;
			pointsDecr = TAKING_OVER_DEFENCE_SCORE_DECREASE;
		}
		else
		{
			// attack
			defend = false;
			playersThreshold = TAKING_OVER_ATTACK_PLAYERS_THRESHOLD;
			pointsIncr = TAKING_OVER_ATTACK_SCORE_INCREASE;
			pointsDecr = TAKING_OVER_ATTACK_SCORE_DECREASE;
		}

		// modify points
		if(FrontBusiness[bizId][TakingOver][i] >= playersThreshold)
		{
			if(defend)
			{ // active defending
				new battlingAttackers = DecreaseAllAttackerPoints(bizId, pointsIncr);
				if(!battlingAttackers)
				{
					FrontBusiness[bizId][TakingOverScore][i] += pointsIncr;
				}
			}
			else
			{ // active attacking
				new battlingDefenders = DecreaseDefenderPoints(bizId, pointsIncr);
				if(!battlingDefenders)
				{
					FrontBusiness[bizId][TakingOverScore][i] += pointsIncr;
				}
			}
			IncrTakeoverPointsStat(i);
		}
		else if(FrontBusiness[bizId][TakingOver][i] == 0 && FrontBusiness[bizId][TakingOverScore][i] > 0)
		{
			// decreasing points - no one in takeover area
			FrontBusiness[bizId][TakingOverScore][i] -= pointsDecr;
		}
	}
}

DecreaseAllAttackerPoints(bizId, points)
{
	new decreased = false;
	for(new i=0; i<MAX_ORG; i++)
	{
		if(FrontBusiness[bizId][Owner] == i)
		{
			continue;
		}

		if(FrontBusiness[bizId][TakingOverScore][i])
		{
			FrontBusiness[bizId][TakingOverScore][i] -= points;
			decreased = true;
		}
	}
	return decreased;
}

DecreaseDefenderPoints(bizId, points)
{
	new owner = FrontBusiness[bizId][Owner];
	if(!IsActiveOrg(owner))
	{
		return false;
	}
	if(FrontBusiness[bizId][TakingOverScore][owner])
	{
		FrontBusiness[bizId][TakingOverScore][owner] -= points;
		return true;
	}
	return false;
}

ptask TakeoverScoreboard[100](playerid)
{
	if(GetPlayerOrg(playerid) == 0 && !IsAPolicja(playerid))
	{
		return;
	}

	new bizId = GetPVarInt(playerid, "in-business-gangzone") - 1;
	if(bizId >= 0 && FrontBusiness[bizId][TakeoverActive])
	{	
		if(GetPlayerVisibleDynamicCP(playerid) != FrontBusiness[bizId][TakeoverCheckpoint])
		{
			TogglePlayerDynamicCP(playerid, FrontBusiness[bizId][TakeoverCheckpoint], true);
		}

		new string[512];
		strcat(string, "Punkty przejecia:~n~");
		new anyPoints;

		new maxScore;
		for(new i=0; i<MAX_ORG; i++)
		{
			new score = FrontBusiness[bizId][TakingOverScore][i];
			if(maxScore < score)
			{
				maxScore = score;
			}
		}

		for(new i=0; i<MAX_ORG; i++)
		{
			new score = FrontBusiness[bizId][TakingOverScore][i];
			if(score > 0)
			{
				new orgName[64];
				if(i == 0)
				{
					format(orgName, sizeof(orgName), "~b~LSPD");
				}
				else if(i == FrontBusiness[bizId][Owner])
				{
					format(orgName, sizeof(orgName), "~g~%s", OrgInfo[i][o_Name]);
				}
				else
				{
					format(orgName, sizeof(orgName), "~r~%s", OrgInfo[i][o_Name]);
				}

				new points[32];
				if(score == maxScore)
				{
					format(points, sizeof(points), "~p~%d", FrontBusiness[bizId][TakingOverScore][i]);
				}
				else
				{
					format(points, sizeof(points), "~w~%d", FrontBusiness[bizId][TakingOverScore][i]);
				}
				
				if(score > TAKE_OVER_POINT_THRESHOLD)
				{
					strcat(points, " (przekroczony prog!)");
				}

				format(string, sizeof(string), "%s%s: %s~n~", string, orgName, points);
				anyPoints++;
			}
		}
		if(anyPoints > 0)
		{
			GameTextForPlayer(playerid, string, 1000, 13);
		}
	}
}

ptask BusinessInfoTimer[1000](playerid)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(IsPlayerInDynamicArea(playerid, FrontBusiness[i][TakeoverArea]) || GetPlayerFrontBusinessProximity(playerid, i) < 3.0)
		{
			ShowFrontBusinessInfo(playerid, i);
			return;
		}
	}

	if(GetPVarInt(playerid, "business-info") == 1)
	{
		ZoneTXD_Hide(playerid);
		DeletePVar(playerid, "business-info");
	}
}

//end