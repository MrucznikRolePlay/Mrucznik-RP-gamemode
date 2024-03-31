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

//-----------------<[ Callbacki: ]>-----------------
//-----------------<[ Funkcje: ]>-------------------
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
		case JOB_DRAGDEALER:
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
		case JOB_BODYGUARD:
		{
			return 1; // no skill
		}
		case JOB_GUNDEALER:
		{
			skill = PlayerInfo[playerid][pGunSkill];
		}
		case JOB_BUSDRIVER:
		{
			skill = PlayerInfo[playerid][pCarSkill];
		}
		case JOB_PIZZA:
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
		case JOB_DRAGDEALER:
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
		case JOB_BODYGUARD:
		{
			return 1; // no skill
		}
		case JOB_GUNDEALER:
		{
			PlayerInfo[playerid][pGunSkill] += value;
		}
		case JOB_BUSDRIVER:
		{
			PlayerInfo[playerid][pCarSkill] += value;
		}
		case JOB_PIZZA:
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
	return 1;
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end