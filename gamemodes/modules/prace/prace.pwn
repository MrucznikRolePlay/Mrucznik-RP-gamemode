//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   prace                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 15.05.2019
//Opis:
/*
	System prac.
*/

//

#include "command_akceptuj_praca.pwn"

//-----------------<[ Inicjalizacja: ]>-----------------
InitializeJobs()
{
	for(new i = 1; i < sizeof(JobInfo); i++)
	{
		InitializeJob(i);
	}
}

InitializeJob(Jobs:jobid)
{
	for(new i; i < MAX_JOB_JOINS; i++)
	{
		if(isnull(JobJoinPositions[jobid][i][JOB_JOIN_NAME]))
		{
			break;
		}

		CreateDynamic3DTextLabel(JobJoinPositions[jobid][i][JOB_JOIN_NAME], COLOR_NEWS, 
			JobJoinPositions[jobid][i][JOB_JOIN_X], JobJoinPositions[jobid][i][JOB_JOIN_Y], JobJoinPositions[jobid][i][JOB_JOIN_Z],
			JobJoinPositions[jobid][i][JOB_JOIN_DRAW_DISTANCE], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);
	}
}

InitializeJobIcons(playerid)
{
	new icons = 0;
	for(new jobid = 1; jobid < sizeof(JobInfo); jobid++)
	{
		for(new i; i < MAX_JOB_JOINS; i++)
		{
			new x = JobIconPositions[jobid][i][JOB_ICON_X];
			new y = JobIconPositions[jobid][i][JOB_ICON_Y];
			new z = JobIconPositions[jobid][i][JOB_ICON_Z];

			if(x != 0.0 && y != 0.0 && z != 0.0)
			{
				SetPlayerMapIcon(playerid, 61, x, y, z, 56, 0);
				icons++;
			}
		}
	}
	return icons;
}

//-----------------<[ Funkcje: ]>-------------------
stock GetJobName(Jobs:jobid)
{
	new jobName[MAX_JOB_NAME];
	strcat(jobName, JobInfo[jobid][JOB_NAME]);
	return jobName;
}

Jobs:GetPlayerJob(playerid)
{
	return PlayerInfo[playerid][pJob];
}

GetPlayerJobSkill(playerid, Jobs:jobid)
{
	new skill = GetPlayerJobSkillPoints(playerid, jobid);
	
	if(skill < 50) { return 1; }
	if(skill < 100) { return 2; }
	if(skill < 200) { return 3; }
	if(skill < 400) { return 4; }
	return 5;
}

GetPlayerJobSkillPoints(playerid, Jobs:jobid)
{
	new skill;
	switch(jobid)
	{
		case JOB_LOWCA:
		{
			skill = PlayerInfo[playerid][pDetSkill];
		}
		case JOB_LAWYER:
		{
			skill = PlayerInfo[playerid][pLawSkill];
		}
		case JOB_PROSTITUTE:
		{
			skill = PlayerInfo[playerid][pSexSkill];
		}
		case JOB_DRUG_DEALER:
		{
			skill = PlayerInfo[playerid][pDrugsSkill];
		}
		case JOB_CARTHIEF:
		{
			skill = PlayerInfo[playerid][pJackSkill];
		}
		case JOB_REPORTER:
		{
			skill = PlayerInfo[playerid][pNewsSkill];
		}
		case JOB_MECHANIC:
		{
			skill = PlayerInfo[playerid][pMechSkill];
		}
		case JOB_SMUGGLER:
		{
			return 1; // no skill
		}
		case JOB_GUNDEALER:
		{
			skill = PlayerInfo[playerid][pGunSkill];
		}
		case JOB_DRIVER:
		{
			skill = PlayerInfo[playerid][pCarSkill];
		}
		case JOB_MEDIC:
		{
			return 1; // no skill
		}
		case JOB_BOXER:
		{
			skill = PlayerInfo[playerid][pBoxSkill];
		}
		case JOB_RESERVED_1:
		{
			return 1; // no skill
		}
		case JOB_RESERVED_2:
		{
			return 1; // no skill
		}
		case JOB_RESERVED_3:
		{
			return 1; // no skill
		}
		case JOB_TRUCKER:
		{
			skill = PlayerInfo[playerid][pTruckSkill];
		}
	}
	return skill;
}

IncreasePlayerJobSkill(playerid, Jobs:jobid, value)
{
	new oldSkill = GetPlayerJobSkill(playerid, jobid);
	switch(jobid)
	{
		case JOB_LOWCA:
		{
			PlayerInfo[playerid][pDetSkill] += value;
		}
		case JOB_LAWYER:
		{
			PlayerInfo[playerid][pLawSkill] += value;
		}
		case JOB_PROSTITUTE:
		{
			PlayerInfo[playerid][pSexSkill] += value;
		}
		case JOB_DRUG_DEALER:
		{
			PlayerInfo[playerid][pDrugsSkill] += value;
		}
		case JOB_CARTHIEF:
		{
			PlayerInfo[playerid][pJackSkill] += value;
		}
		case JOB_REPORTER:
		{
			PlayerInfo[playerid][pNewsSkill] += value;
		}
		case JOB_MECHANIC:
		{
			PlayerInfo[playerid][pMechSkill] += value;
		}
		case JOB_SMUGGLER:
		{
			return 1; // no skill
		}
		case JOB_GUNDEALER:
		{
			PlayerInfo[playerid][pGunSkill] += value;
		}
		case JOB_DRIVER:
		{
			PlayerInfo[playerid][pCarSkill] += value;
		}
		case JOB_MEDIC:
		{
			return 1; // no skill
		}
		case JOB_BOXER:
		{
			PlayerInfo[playerid][pBoxSkill] += value;
		}
		case JOB_RESERVED_1:
		{
			return 1; // no skill
		}
		case JOB_RESERVED_2:
		{
			return 1; // no skill
		}
		case JOB_RESERVED_3:
		{
			return 1; // no skill
		}
		case JOB_TRUCKER:
		{
			PlayerInfo[playerid][pTruckSkill] += value;
		}
	}
	MruMessageSkillInfoF(playerid, "Skill +%d", value);

	new newSkill = GetPlayerJobSkill(playerid, jobid);
	if(oldSkill != newSkill)
	{
		MruMessageGoodInfoF(playerid, "Twoje umiejêtnoœci pracy %s wynosz¹ teraz %d! Masz teraz dostêp do nowych funkcjonalnoœci swojej pracy.", GetJobName(jobid), newSkill);
	}
	return 1;
}

CanPlayerTakeJob(playerid, job)
{
	if(job == JOB_DRIVER || job == JOB_PROSTITUTE)
	{
		return 1;
	}

	if(GetPlayerFraction(playerid) > 0 || GetPlayerOrg(playerid) != 0)
	{
		if(IsAPrzestepca(playerid))
		{
			if(job != JOB_DRUG_DEALER && job != JOB_CARTHIEF && job != JOB_GUNDEALER && job != JOB_SMUGGLER)
			{
				return 0;
			}
		}
	}
	return 1;
}

GetJobIfPlayerCloseEnough(playerid)
{
	for(new jobid = 1; jobid < sizeof(JobInfo); jobid++)
	{
		for(new i; i < MAX_JOB_JOINS; i++)
		{
			if(isnull(JobJoinPositions[jobid][i][JOB_JOIN_NAME]))
			{
				break;
			}

			if(IsPlayerInRangeOfPoint(playerid, JOB_JOIN_MAX_PROXIMITY, 
				JobJoinPositions[jobid][i][JOB_JOIN_X], 
				JobJoinPositions[jobid][i][JOB_JOIN_Y], 
				JobJoinPositions[jobid][i][JOB_JOIN_Z]))
			{
				return jobid;
			}
		}
	}
	return 0;
}

GiveTaxiBonusForUniquePlayer(playerid, clientid)
{
	new bonus = 15_000;
	new playerUID = PlayerInfo[playerid][pUID];
	new clientUID = PlayerInfo[clientid][pUID];

	new redisKey[64];
	format(redisKey, sizeof(redisKey), "player:%d:taxi-client:%d", playerUID, clientUID);
	if(Redis_Exists(RedisClient, redisKey))
	{
		return;
	}

	Redis_SetInt(RedisClient, redisKey, 1);
	Redis_Expire(redisKey, 86_400); // expire after 24h

	MruMessageGoodInfoF(playerid, "Otrzymujesz %d$ bonusu za przewiezienie unikalnego gracza!", bonus);
	DajKase(playerid, bonus);
	Log(payLog, INFO, "%s otrzyma³ %d$ za przewiezienie unikalnego gracza taxówk¹", GetPlayerLogName(playerid), bonus);
}

//-----------------<[ Timery: ]>-------------------

ShowPlayerJobMessage(playerid, playerState)
{
	if(playerState != 1)
	{
		return 0; // wyswietlaj komunikaty tylko gdy gracz jest pieszo
	}

	new job = GetJobIfPlayerCloseEnough(playerid);
	if(job> 0)
	{
		GameTextForPlayer(playerid, sprintf("~g~Witaj,~n~~y~mozesz tu dolaczyc do pracy:\n~r~%s~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 
			Odpolszcz(GetJobName(job))), 5000, 3);
		return 1;
	}
	return 0;
}

//------------------<[ MySQL: ]>--------------------

//end