//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                   money                                                   //
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
// Data utworzenia: 01.07.2019
//Opis:
/*
	Modu³ odpowiadaj¹cy za operacje na pieni¹dzach gracza.
*/

//

//-----------------<[ Timery: ]>-------------------
forward AntyCheatSystemByMrucznik(); //repeated every second
public AntyCheatSystemByMrucznik()
{
    for(new i = 0, p = GetMaxPlayers(); i < p; i++)
    {
		if(GetPlayerMoney(i) != kaska[i])
		{
			if(IsPlayerConnected(i))
			{
				ResetPlayerMoney(i);
				GivePlayerMoney(i,kaska[i]);
			}
		}
	}
	return 1;
}

ptask CollectMoneyTimer[250](playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	{
		return;
	}

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(x >= 4096.0 || x <= -4096.0 || y >= 4096.0 || y <= -4096.0)
	{
		new Pointer:key_ptr;
		new Pointer:value_ptr;
		for(new Map:temp_map = MAP_iter_get(MruDynamicPickupTimers, key_ptr, value_ptr); temp_map != MAP_NULL; temp_map = MAP_iter_next(temp_map, MAP_NULL, key_ptr, value_ptr))
		{
			new objectid = MEM_get_val(key_ptr);
			if(IsValidDynamicObject(objectid) && Streamer_IsItemVisible(playerid, STREAMER_TYPE_OBJECT, objectid))
			{
				new Float:dist;
				Streamer_GetDistanceToItem(x, y, z, STREAMER_TYPE_OBJECT, objectid, dist);
				if(dist < 2.0)
				{
					CollectMoneyPickup(playerid, objectid);
					return;
				}
			}
		}
	}
}

//end