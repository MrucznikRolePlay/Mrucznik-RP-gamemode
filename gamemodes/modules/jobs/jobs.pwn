//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    jobs                                                   //
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
// Autor: Simeone
// Data utworzenia: 07.10.2019
//Opis:
/*
	Modu³, który odpowiada za wszelkie prace dorywcze na serwerze. 
*/

//

//-----------------<[ Funkcje: ]>-------------------
GetPlayerJobID(playerid)
{
	new jobID = PlayerInfo[playerid][pJob];
	return jobID;
}
SetPlayerJob(playerid, jobID)
{
	PlayerInfo[playerid][pJob] = jobID;
	return 1;
}
CheckPlayerJob(playerid, jobID)
{
	if(GetPlayerJobID(playerid) == jobID)
	{
		return true;
	}
	return false;
}
CheckArgForJob(playerid, jobID)
{
	if(jobID == JOB_HUNTER)
	{
		if(PlayerInfo[playerid][pGunLic] == 1)
		{
			return true;
		}
	}
	else if(jobID == JOB_LAWYER)
	{
		return true;
	}
	else if(jobID == JOB_MECHAZORD)
	{
		return true;
	}
	else if(jobID == JOB_TRASHER)
	{
		return true;
	}
	else if(jobID == JOB_FIGHTER)
	{
		return true;
	}
	else 
	{
		return true;
	}
	return false;
}
ShowArgForJob(playerid, jobID)
{
	if(jobID == 1)
	{
		SendClientMessage(playerid, COLOR_BLUE, "=============<[Praca ³owcy g³ów]>=============");
		SendClientMessage(playerid, COLOR_WHITE, "Praca ta polega na chwytaniu ludzi z wysokim poziomem Wanted Level"); 
		SendClientMessage(playerid, COLOR_WHITE, "Warunki posiadania tej pracy to: Posiadanie licencji na broñ"); 
		SendClientMessage(playerid, COLOR_RED, "Stopieñ op³acalnoœci: ŒREDNIA"); 
	}
	else if(jobID == 2)
	{
		SendClientMessage(playerid, COLOR_BLUE, "=============<[Praca prawnika]>=============");
	}
	else if(jobID == 3)
	{
		SendClientMessage(playerid, COLOR_BLUE, "=============<[Praca Mechanika]>=============");
	}
	else if(jobID == 4)
	{
		SendClientMessage(playerid, COLOR_BLUE, "=============<[Praca Œmieciarza]>=============");
	}
	else
	{
		SendClientMessage(playerid, COLOR_BLUE, "=============<[Praca boksera]>=============");
	}
	return 1;
}
stock IsPlayerInJobPoint(playerid, Float:rangeJobPoint)
{
	for(new i; i<MAX_JOBS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, rangeJobPoint, jobPoints[i][0], jobPoints[i][1], jobPoints[i][2]))
		{
			return true;
		}
	}
	return false; 
}
stock GetJobPointFromPlayerPos(playerid)
{
	new valueJob = JOB_DEFAULT;
	for(new i; i<MAX_JOBS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, jobPoints[i][0], jobPoints[i][1], jobPoints[i][2]))
		{
			valueJob=i;
			break;
		}
	}
	return valueJob; 
}

//end