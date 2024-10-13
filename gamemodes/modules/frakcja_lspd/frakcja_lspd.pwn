//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                frakcja_lspd                                               //
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
// Data utworzenia: 07.04.2024
//Opis:
/*
	Modu³ frakcji LSPD
*/

//

//-----------------<[ Funkcje: ]>-------------------
SetPlayerArrestPos(playerid)
{
	if(PlayerInfo[playerid][pSpawn] == 3 || GetPlayerVirtualWorld(playerid) == 7110)
	{
		SetPlayerInterior(playerid, 10);
		SetPlayerVirtualWorld(playerid, 7110);
		new losuj= random(sizeof(CelaVC));
		SetPlayerPos(playerid, CelaVC[losuj][0], CelaVC[losuj][1], CelaVC[losuj][2]);
		SetPlayerFacingAngle(playerid, CelaVC[losuj][3]);
		PlayerInfo[playerid][pSpawn] = 3;
		TogglePlayerControllable(playerid, true);
	}
	else
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 29);
		new losuj= random(sizeof(Cela));
		SetPlayerPos(playerid, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
		Wchodzenie(playerid);
	}
}

SetPlayerStateArrestPos(playerid)
{
	if(PlayerInfo[playerid][pSpawn] == 3 || GetPlayerVirtualWorld(playerid) == 7110)	
	{
		new losuj= random(sizeof(SpawnStanoweVC));
		SetPlayerInterior(playerid, 3);
		SetPlayerVirtualWorld(playerid, 7110);
		SetPlayerPos(playerid, SpawnStanoweVC[losuj][0], SpawnStanoweVC[losuj][1], SpawnStanoweVC[losuj][2]);
		PlayerInfo[playerid][pSpawn] = 3;
	}
	else
	{
		new losuj= random(sizeof(SpawnStanowe));
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid, SpawnStanowe[losuj][0], SpawnStanowe[losuj][1], SpawnStanowe[losuj][2]);
	}
	TogglePlayerControllable(playerid, true);
}

SetPlayerArrestFreePos(playerid)
{
	if(PlayerInfo[playerid][pSpawn] == 3 || GetPlayerVirtualWorld(playerid) == 7110)
	{
		SetPlayerInterior(playerid, 10);
		SetPlayerVirtualWorld(playerid, 7110);
		SetPlayerPos(playerid, ArrestFreePositionVC[0], ArrestFreePositionVC[1], ArrestFreePositionVC[2]);
		SetPlayerFacingAngle(playerid, ArrestFreePositionVC[3]);
		PlayerInfo[playerid][pSpawn] = 3;
	}
	else
	{
		SetPlayerPos(playerid, ArrestFreePosition[0], ArrestFreePosition[1], ArrestFreePosition[2]);
		SetPlayerFacingAngle(playerid, ArrestFreePosition[3]);
	}
	TogglePlayerControllable(playerid, true);
}

IsAtDutyPlace(playerid)
{
	for(new i; i<sizeof(DutyPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, DutyPositions[i][0], DutyPositions[i][1], DutyPositions[i][2], DutyPositions[i][3]))
		{
			return 1;
		}
	}
	if(GetPlayerVirtualWorld(playerid) == 27) // nowe komi by charlie
	{
		return 1;
	}
	return 0;
}

IsAtArrestPlace(playerid)
{

	for(new i; i<sizeof(ArrestPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, ArrestPositions[i][0], ArrestPositions[i][1], ArrestPositions[i][2], ArrestPositions[i][3]))
		{
			return 1;
		}
	}
	return 0;
}

IsAtStateArrestPlace(playerid)
{
	for(new i; i<sizeof(StateArrestPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, StateArrestPositions[i][0], StateArrestPositions[i][1], StateArrestPositions[i][2], StateArrestPositions[i][3]))
		{
			return 1;
		}
	}
	return 0;
}

IsAtClearCrimesPlace(playerid)
{
	for(new i; i<sizeof(ClearCrimesPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, ClearCrimesPositions[i][0], ClearCrimesPositions[i][1], ClearCrimesPositions[i][2], ClearCrimesPositions[i][3]))
		{
			return 1;
		}
	}
	if(PlayerInfo[playerid][pLocal] == 210)
	{
		return 1;
	}
	if(GetPlayerVirtualWorld(playerid) == 27) // nowe komi by charlie
	{
		return 1;
	}
	return 0;
}

//end