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
task BusinessTakeoverTimer[1000]()
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
	for(new i; i<MAX_ORG; i++)
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
			{
				new battlingAttackers = DecreaseAllAttackerPoints(bizId, pointsIncr);
				if(!battlingAttackers)
				{
					FrontBusiness[bizId][TakingOverScore][i] += pointsIncr;
				}
			}
			else
			{
				new battlingDefenders = DecreaseDefenderPoints(bizId, pointsIncr);
				if(!battlingDefenders)
				{
					FrontBusiness[bizId][TakingOverScore][i] += pointsIncr;
				}
			}
		}
		else if(FrontBusiness[bizId][TakingOver][i] == 0 && FrontBusiness[bizId][TakingOverScore][i] > 0)
		{
			FrontBusiness[bizId][TakingOverScore][i] -= pointsDecr;
		}
	}
}

DecreaseAllAttackerPoints(bizId, points)
{
	new decreased = false;
	for(new i; i<MAX_ORG; i++)
	{
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

ptask TakeoverCheck[1000](playerid)
{
	new bizId = GetPVarInt(playerid, "show-takeover-info") - 1;
	if(bizId >= 0)
	{	
		new string[512];
		strcat(string, "Punkty przejecia:");
		new anyPoints;
		for(new i; i<MAX_ORG; i++)
		{
			new score = FrontBusiness[bizId][TakingOverScore][i];
			if(score > 0)
			{
				if(score > TAKE_OVER_POINT_THRESHOLD)
				{
					format(string, sizeof(string), "%s~n~~y~%s~w~: ~r~%d~w~", OrgInfo[i][o_Name], FrontBusiness[bizId][TakingOverScore][i]);
				}
				else
				{
					format(string, sizeof(string), "%s~n~~y~%s~w~: %d", OrgInfo[i][o_Name], FrontBusiness[bizId][TakingOverScore][i]);
				}
				anyPoints++;
			}
		}
		if(anyPoints > 0)
		{
			GameTextForPlayer(playerid, string, 1100, 15);
		}
	}
}

//end