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
GetPlayerSkill(playerid, Jobs:jobid)
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

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end