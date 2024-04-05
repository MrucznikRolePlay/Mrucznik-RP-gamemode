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

#include "command_akceptuj_job.pwn"

//-----------------<[ Callbacki: ]>-----------------
//-----------------<[ Funkcje: ]>-------------------
stock GetJobName(Jobs:jobid)
{
	new jobName[32];
	switch(jobid)
	{
		case JOB_LOWCA: { strcat(jobName, "£owca nagród"); }
		case JOB_LAWYER: { strcat(jobName, "Prawnik"); }
		case JOB_PROSTITUTE: { strcat(jobName, "Prostytutka"); }
		case JOB_DRUG_DEALER: { strcat(jobName, "Diler narkotyków"); }
		case JOB_CARTHIEF: { strcat(jobName, "Z³odziej aut"); }
		case JOB_REPORTER: { strcat(jobName, "Reporter"); }
		case JOB_MECHANIC: { strcat(jobName, "Mechanik"); }
		case JOB_SMUGGLER: { strcat(jobName, "Przemytnik"); }
		case JOB_GUNDEALER: { strcat(jobName, "Diler broni"); }
		case JOB_DRIVER: { strcat(jobName, "Kierowca autobusu"); }
		// case JOB_RESERVED_4: { strcat(jobName, ""); }
		case JOB_BOXER: { strcat(jobName, "Bokser"); }
		// case JOB_RESERVED_1: { strcat(jobName, ""); }
		// case JOB_RESERVED_2: { strcat(jobName, ""); }
		// case JOB_RESERVED_3: { strcat(jobName, ""); }
		case JOB_TRUCKER: { strcat(jobName, "Trucker"); }
		default: { strcat(jobName, "Brak"); }
	}
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
		case JOB_RESERVED_4:
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
	
	if(skill < 50) { return 1; }
	if(skill < 100) { return 2; }
	if(skill < 200) { return 3; }
	if(skill < 400) { return 4; }
	return 5;
}

IncreasePlayerJobSkill(playerid, Jobs:jobid, value)
{
	new oldSkill = GetPlayerJobSkillPoints(playerid, jobid);
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
		case JOB_RESERVED_4:
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
	new newSkill = GetPlayerJobSkillPoints(playerid, jobid);
	MruMessageSkillInfoF(playerid, "Skill +%d", value);

	if(oldSkill != newSkill)
	{
		MruMessageGoodInfoF(playerid, "Twoje umiejêtnoœci pracy %s wynosz¹ teraz %d! Masz teraz dostêp do nowych funkcjonalnoœci swojej pracy.", GetJobName(jobid), newSkill);
	}
	return 1;
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end