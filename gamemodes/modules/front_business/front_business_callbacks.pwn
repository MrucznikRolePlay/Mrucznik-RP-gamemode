//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
FB_OnPlayerEnterDynamicArea(playerid, areaid)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!FrontBusiness[i][TakeoverActive])
		{
			return;
		}

		if(GetPlayerOrg(playerid) == 0 && !IsAPolicja(playerid))
		{
			return;
		}

		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			SetPVarInt(playerid, "show-takeover-info", i+1);
			return;
		}

		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			new org = GetPlayerOrg(playerid);
			if(!IsActiveOrg(org))
			{
				return;
			}
			SetPVarInt(playerid, "taking-over", i + 1);
			FrontBusiness[i][TakingOver][org]++;

			if(FrontBusiness[i][TakingOver][org] == TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
			{
				TriggerTakingOver(i, org);
			}

			// message
			new isDefense = FrontBusiness[i][Owner] == org;
			SendEnterTakeoverAreaMessage(playerid, i, org, isDefense);
		}
	}
}

SendEnterTakeoverAreaMessage(playerid, bizId, org, isDefense)
{
	if(isDefense)
	{
		// defense
		if(FrontBusiness[bizId][TakingOver][org] == TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~b~Rozpoczêto obrone biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] > TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Dolaczyles do obrony biznesu", 5000, 1);
		}
		else
		{
			GameTextForPlayer(playerid, "Jestes w strefe przejecia biznesu~n~potrzeba "#TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD" osob z organizacji by obronic biznes", 5000, 1);
		}
	}
	else
	{
		// attack
		if(FrontBusiness[bizId][TakingOver][org] == TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Rozpoczêto przejmowanie biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] > TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Dolaczyles do przejmowania biznesu", 5000, 1);
		}
		else
		{
			GameTextForPlayer(playerid, "Jestes w strefe przejecia biznesu~n~potrzeba "#TAKING_OVER_ATTACK_PLAYERS_THRESHOLD" osob z organizacji by przejac biznes", 5000, 1);
		}
	}
}

FB_OnPlayerLeaveDynamicArea(playerid, areaid)
{
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!FrontBusiness[i][TakeoverActive])
		{
			return;
		}

		new org = GetPVarInt(playerid, "taking-over") - 1;
		if(org < 0)
		{
			return;
		}

		if(areaid == FrontBusiness[i][GangZoneArea])
		{
			DeletePVar(playerid, "show-takeover-info");
			return;
		}
		
		if(areaid == FrontBusiness[i][TakeoverArea])
		{
			DeletePVar(playerid, "taking-over");
			FrontBusiness[i][TakingOver][org]--;

			if(FrontBusiness[i][TakingOver][org] == TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD-1)
			{
				StopTakingOver(i, org);
			}

			// message
			new isDefense = FrontBusiness[i][Owner] == org;
			SendExitTakeoverAreaMessage(playerid, i, org, isDefense);
		}
	}
}

SendExitTakeoverAreaMessage(playerid, bizId, org, isDefense)
{
	if(isDefense)
	{
		// defense
		if(FrontBusiness[bizId][TakingOver][org] >= TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Opusciles strefe obrony biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] < TAKING_OVER_DEFENCE_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Twoja organizacja przestala bronic biznes!", 5000, 1);
		}
	}
	else
	{
		// attack
		if(FrontBusiness[bizId][TakingOver][org] >= TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "Opusciles strefe przejmowanie biznesu", 5000, 1);
		}
		else if(FrontBusiness[bizId][TakingOver][org] < TAKING_OVER_ATTACK_PLAYERS_THRESHOLD)
		{
			GameTextForPlayer(playerid, "~r~Twoja organizacja przestala przejmowac biznes!", 5000, 1);
		}
	}
}

//end