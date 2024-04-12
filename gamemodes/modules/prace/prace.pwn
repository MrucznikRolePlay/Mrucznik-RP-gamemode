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
	for(new jobid = 1; jobid < sizeof(JobInfo); jobid++)
	{
		for(new i; i < MAX_JOB_JOINS; i++)
		{
			SetPlayerMapIcon(playerid, 61, 
				JobJoinPositions[jobid][i][JOB_JOIN_X], JobJoinPositions[jobid][i][JOB_JOIN_Y], JobJoinPositions[jobid][i][JOB_JOIN_Z], 
				56, 0);
		}
	}
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
	new oldSkill = GetPlayerJobSkill(playerid, jobid);
	if(oldSkill != newSkill)
	{
		MruMessageGoodInfoF(playerid, "Twoje umiejêtnoœci pracy %s wynosz¹ teraz %d! Masz teraz dostêp do nowych funkcjonalnoœci swojej pracy.", GetJobName(jobid), newSkill);
	}
	return 1;
}

//-----------------<[ Timery: ]>-------------------

ShowPlayerJobMessage(playerid, playerState)
{
	if(playerState != 1)
	{
		return 0; // wyswietlaj komunikaty tylko gdy gracz jest pieszo
	}

	for(new jobid = 1; jobid < sizeof(JobInfo); jobid++)
	{
		for(new i; i < MAX_JOB_JOINS; i++)
		{
			if(isnull(JobJoinPositions[jobid][i][JOB_JOIN_NAME]))
			{
				break;
			}

			if(IsPlayerInRangeOfPoint(playerid, 2.0, 
				JobJoinPositions[jobid][i][JOB_JOIN_X], JobJoinPositions[jobid][i][JOB_JOIN_Y], JobJoinPositions[jobid][i][JOB_JOIN_Z]))
			{
				GameTextForPlayer(playerid, sprintf("~g~Witaj,~n~~y~mozesz tu dolaczyc do pracy: ~r~%s~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 
					GetJobName(i)), 5000, 3); 
				return 1;
			}
		}
	}
	return 0;
}

//------------------<[ MySQL: ]>--------------------

//end