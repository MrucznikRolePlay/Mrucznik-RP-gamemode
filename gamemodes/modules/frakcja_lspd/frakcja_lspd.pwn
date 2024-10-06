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