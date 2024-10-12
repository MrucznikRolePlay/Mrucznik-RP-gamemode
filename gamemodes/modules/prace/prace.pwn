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

		new Float:x = JobJoinPositions[jobid][i][JOB_JOIN_X];
		new Float:y = JobJoinPositions[jobid][i][JOB_JOIN_Y];
		new Float:z = JobJoinPositions[jobid][i][JOB_JOIN_Z];

		CreateDynamic3DTextLabel(JobJoinPositions[jobid][i][JOB_JOIN_NAME], COLOR_NEWS, 
			x, y, z + 0.5,
			JobJoinPositions[jobid][i][JOB_JOIN_DRAW_DISTANCE], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);

		CreateDynamicPickup(1210, 1, x, y, z);
	}
}

InitializeJobIcons()
{
	for(new jobid = 1; jobid < sizeof(JobInfo); jobid++)
	{
		for(new i; i < MAX_JOB_JOINS; i++)
		{
			new Float:x = JobIconPositions[jobid][i][0];
			new Float:y = JobIconPositions[jobid][i][1];
			new Float:z = JobIconPositions[jobid][i][2];

			if(x != 0.0 && y != 0.0 && z != 0.0)
			{
				if(jobid == JOB_MEDIC && i == 1)
				{
					x = -4313.8228; y = 1274.1133; z = 4.9235; // fix overlapping icons
				}
				if(jobid == JOB_PROSTITUTE && i == 1)
				{
					x = -4126.5010; y = 821.9366; z = 19.4500; // fix overlapping icons
				}

				MruCreateDynamicMapIcon(x, y, z, 
					56, // type https://www.open.mp/docs/scripting/resources/mapicons
					-1, // color, This should only be used with the square icon (ID: 0)
					0, // worldid
					0, // interiorid
					-1, // playerid
					2000.0, // streamdistance -1 = inifnite
					MAPICON_GLOBAL // style https://www.open.mp/docs/scripting/resources/mapiconstyles
				);
			}
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
		case JOB_GUN_DEALER:
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
		case JOB_GUN_DEALER:
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
	if(IsAJobForAll(job))
	{
		return 1;
	}

	if(IsAPrzestepca(playerid) && !IsACrimeJob(playerid, job))
	{
		return 0;
	}

	if(GetPlayerFraction(playerid) > 0)
	{
		return 0;
	}
	return 1;
}

IsAJobForAll(job)
{
	return job == JOB_DRIVER || job == JOB_PROSTITUTE;
}

IsACrimeJob(playerid, job)
{
	if(job == JOB_DRUG_DEALER || job == JOB_CARTHIEF || job == JOB_GUN_DEALER || job == JOB_SMUGGLER)
	{
		return 1;
	}
	if(job == JOB_MECHANIC && (IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE) || IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY)))
	{
		return 1;
	}
	return 0;
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