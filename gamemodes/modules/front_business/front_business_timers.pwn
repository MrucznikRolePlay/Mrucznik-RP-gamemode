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
			if(FrontBusiness[i][TakeoverHour] == hour && FrontBusiness[i][TakeoverMinute]  == minute)
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
		new playersThreshold, pointsIncr, pointsDecr;
		if(OrgInfo[i][o_UID] == FrontBusiness[bizId][Owner])
		{
			// defence
			playersThreshold = TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD;
			pointsIncr = TAKING_OVER_DEFENCE_SCORE_INCREASE;
			pointsDecr = TAKING_OVER_DEFENCE_SCORE_DECREASE;
		}
		else
		{
			// attack
			playersThreshold = TAKING_OVER_ATTACK_PLAYERS_THRESHOLD;
			pointsIncr = TAKING_OVER_ATTACK_SCORE_INCREASE;
			pointsDecr = TAKING_OVER_ATTACK_SCORE_DECREASE;
		}

		// modify points
		if(FrontBusiness[bizId][TakingOver][i] >= playersThreshold)
		{
			FrontBusiness[bizId][TakingOverScore][i] += pointsIncr;
		}
		else if(FrontBusiness[bizId][TakingOver][i] == 0)
		{
			FrontBusiness[bizId][TakingOverScore][i] -= pointsDecr;
		}
	}
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
			if(FrontBusiness[bizId][TakingOverScore][i] > 0)
			{
				format(string, sizeof(string), "%s~n~%s: %d", OrgInfo[i][o_Name], FrontBusiness[bizId][TakingOverScore][i]);
				anyPoints++;
			}
		}
		if(FrontBusiness[bizId][CopTakingOverScore] > 0)
		{
			format(string, sizeof(string), "%s~n~Gliniarze: %d", FrontBusiness[bizId][CopTakingOverScore]);
			anyPoints++;
		}
		if(anyPoints > 0)
		{
			GameTextForPlayer(playerid, string, 1100, 15);
		}
	}
}

//end