//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                zlodziej_aut                                               //
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
// Autor: NikodemBanan
// Data utworzenia: 13.02.2024
//Opis:
/*
	Nowa praca z³odzieja aut. TODO: dodaæ szczegó³owy opis
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(stole_a_car_checkpoint[playerid][1] == areaid)
	{
		CarThiefMissionGoal(playerid);
	}
}


hook OnPlayerDisconnect(playerid, reason)
{
	EndCarThiefMission(playerid);
	if((PlayerInfo[playerid][pLider] == 1 || PlayerInfo[playerid][pMember] == 1) && OnDuty[playerid])
	{
		RmvLSPDMemberFromThiefMapIcons(playerid);
	}
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if((stole_a_car[playerid] || stole_a_car_checkpoint[playerid][0] != -1 || stole_a_car_checkpoint[playerid][1] != -1) && oldstate == PLAYER_STATE_DRIVER)
	{
		EndCarThiefMission(playerid);

		PlayerInfo[playerid][pCarTime] = 60;
		sendTipMessageEx(playerid, COLOR_LIGHTRED, "Opuœci³eœ pojazd - próba kradzie¿y zakoñczy³a siê niepowodzeniem.");
	}
}

//end