//-----------------------------------------------<< Timers >>------------------------------------------------//
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

//-----------------<[ Timery: ]>-------------------

public FinishLSPDCarThiefTracking(playerid)
{
	EnableCarThiefCheckpoint(playerid);
	DestroyCarThiefLSPDMapIcon(playerid);
}

public UpdateCarThiefLSPDMapIcon(playerid)
{
	new icon_id = stole_a_car_lspd_map_icon[playerid];

	if(IsValidDynamicMapIcon(icon_id))
	{
		if(IsPlayerConnected(playerid) && stole_a_car[playerid])
		{
			new Float:thief_pos_x, Float:thief_pos_y, Float:thief_pos_z;
			GetPlayerPos(playerid, thief_pos_x, thief_pos_y, thief_pos_z);
			Streamer_SetItemPos(STREAMER_TYPE_MAP_ICON, icon_id, thief_pos_x, thief_pos_y, thief_pos_z);
		}
		else
		{
			DestroyCarThiefLSPDMapIcon(playerid);
		}
	} 

	return 1;
}

public AntiTeleportCarThief(playerid)
{
	stole_a_car_anti_tp[playerid] = 0;
}

public CarThiefMissionGoalTimer(playerid)
{
	if(stole_a_car_checkpoint[playerid][1] != -1 && IsPlayerInDynamicArea(playerid, stole_a_car_checkpoint[playerid][1], 0))
	{
		CarThiefMissionGoal(playerid);
	}
}

//end