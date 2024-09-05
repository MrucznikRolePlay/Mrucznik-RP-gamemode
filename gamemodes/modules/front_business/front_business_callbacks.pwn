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
			new org = gPlayerOrg[playerid];
			if(IsAPolicja(playerid))
			{
				FrontBusiness[i][CopTakingOver] ++;
				if(FrontBusiness[i][CopTakingOver] >= 3)
				{
					GameTextForPlayer(playerid, "~b~Rozpoczales obrone biznesu przed bandytami", 5000, 1);
				}
				else if(FrontBusiness[i][CopTakingOver] < 3)
				{
					GameTextForPlayer(playerid, "Jestes w strefe obrony biznesu~n~potrzeba 3 strozow prawa by skutecznie~n~zapobiec przejeciu biznesu!", 5000, 1);
				}
			}
			else if(FrontBusiness[i][Owner] == org)
			{
				// defense
				FrontBusiness[i][TakingOver][org]++;

				if(FrontBusiness[i][TakingOver][org] == 1)
				{
					GameTextForPlayer(playerid, "~b~Rozpoczêto obrone biznesu", 5000, 1);
				}
				else if(FrontBusiness[i][TakingOver][org] == 3)
				{
					GameTextForPlayer(playerid, "~b~Rozpoczales ~g~skuteczna ~b~obrone biznesu", 5000, 1);
				}
				else
				{
					GameTextForPlayer(playerid, "Dolaczyles do obrony biznesu", 5000, 1);
				}
			}
			else
			{
				// attack
				FrontBusiness[i][TakingOver][org]++;

				if(FrontBusiness[i][TakingOver][org] == 3)
				{
					GameTextForPlayer(playerid, "~r~Rozpoczêto przejmowanie biznesu", 5000, 1);
				}
				else if(FrontBusiness[i][TakingOver][org] > 3)
				{
					GameTextForPlayer(playerid, "~r~Dolaczyles do przejmowania biznesu", 5000, 1);
				}
				else
				{
					GameTextForPlayer(playerid, "Jestes w strefe przejecia biznesu~n~potrzeba 3 osob z organizacji by przejac biznes", 5000, 1);
				}
			}
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

		if(GetPlayerOrg(playerid) == 0 && !IsAPolicja(playerid))
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
			new org = gPlayerOrg[playerid];
			if(IsAPolicja(playerid))
			{
				FrontBusiness[i][CopTakingOver]--;

				if(FrontBusiness[i][CopTakingOver] >= 3)
				{
					GameTextForPlayer(playerid, "Opusciles strefe obrony biznesu", 5000, 1);
				}
				else if(FrontBusiness[i][CopTakingOver] < 3)
				{
					GameTextForPlayer(playerid, "~r~Przestales bronic biznesu przed przestepcami!", 5000, 1);
				}
			}
			else if(FrontBusiness[i][Owner] == org)
			{
				// defense
				FrontBusiness[i][TakingOver][org]--;

				if(FrontBusiness[i][TakingOver][org] >= 3)
				{
					GameTextForPlayer(playerid, "Opusciles strefe obrony biznesu", 5000, 1);
				}
				else if(FrontBusiness[i][TakingOver][org] < 3)
				{
					GameTextForPlayer(playerid, "~r~Twoja organizacja przestala bronic biznes!", 5000, 1);
				}
			}
			else
			{
				// attack
				FrontBusiness[i][TakingOver][org]--;

				if(FrontBusiness[i][TakingOver][org] >= 3)
				{
					GameTextForPlayer(playerid, "Opusciles strefe przejmowanie biznesu", 5000, 1);
				}
				else if(FrontBusiness[i][TakingOver][org] < 3)
				{
					GameTextForPlayer(playerid, "~r~Twoja organizacja przestala przejmowac biznes!", 5000, 1);
				}
			}
		}
	}
}

//end