//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  ukradnij                                                 //
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


//

//------------------<[ Implementacja: ]>-------------------
command_ukradnij_Impl(playerid)
{
    if(!IsPlayerConnected(playerid))
   	{
		return 1;
	}

	new veh_id = GetPlayerVehicleID(playerid);

	if(!UkradnijVerify(playerid, veh_id))
	{
		return 1;
	}

	new lspd_members[MAX_PLAYERS];
	new lspd_members_count = 0, lspd_members_counted = false;
	new deluxe_car = false;

	for(new i = 0; i < sizeof(deluxe_cars_for_stealing_ids); i++)
	{
		if(veh_id == deluxe_cars_for_stealing_ids[i])
		{
			CountLSPDMembersOnDuty(lspd_members, lspd_members_count, lspd_members_counted);
			if(lspd_members_count < 3)
			{
				sendTipMessageEx(playerid, COLOR_GREY,  "¯adna dziupla nie chce obecnie przyj¹æ tego pojazdu! Spróbuj ponownie póŸniej.");
				return 1;
			}

			deluxe_car = true;
			break;
		}
	}

	new lspd_detect_random_roll = true_random(100) + 1;
	new lspd_detect_short_threshold, lspd_detect_long_threshold;
	GetLspdDetectThresholds(veh_id, lspd_detect_short_threshold, lspd_detect_long_threshold);

	if(deluxe_car || lspd_detect_random_roll <= lspd_detect_short_threshold)
	{
		new Float:thief_pos_x, Float:thief_pos_y, Float:thief_pos_z;
		new komunikat[128];
		new map_icon_color = 0x1111FFFF;

		CountLSPDMembersOnDuty(lspd_members, lspd_members_count, lspd_members_counted);

		if(lspd_members_count > 0)
		{
			if(deluxe_car)
			{
				format(komunikat, sizeof(komunikat), "HQ: Systemy lokalizacji namierzy³y z³odzieja aut, UWAGA - porusza siê %s - pozycja zosta³a zaznaczona na mapie w MDT.", VehicleNames[GetVehicleModel(veh_id)-400]);
				SendFamilyMessage(FRAC_LSPD, COLOR_RED, komunikat, true);
				
				stole_a_car_timers_ids[playerid][1] = SetTimerEx("FinishLSPDCarThiefTracking", ZA_LSPD_GPS_DURATION_DELUXE_MS, false, "i", playerid);

				SendClientMessage(playerid, COLOR_LIGHTRED, "NIEZWYKLE gor¹cy towar - dosta³eœ cynk, ¿e swoj¹ kradzie¿¹ wzbudzi³eœ ogromne zainteresowanie policji!");
				format(komunikat, sizeof(komunikat), "Twój kontakt da ci namiary na dziuplê za ok. %d minut. Mo¿esz liczyæ na bardzo du¿¹ premiê!", ZA_LSPD_GPS_DURATION_DELUXE_MS / 60000);
				SendClientMessage(playerid, COLOR_LIGHTRED, komunikat);
			
				stole_a_car_seconds_to_find_cp[playerid] = ZA_LSPD_GPS_DURATION_DELUXE_MS / 1000;
				stole_a_car_lspd_bonus[playerid] = 3;
				map_icon_color = 0xFF00FFFF;
			}
			else if(lspd_detect_random_roll <= lspd_detect_long_threshold)
			{
				format(komunikat, sizeof(komunikat), "HQ: Systemy lokalizacji namierzy³y z³odzieja aut, porusza siê %s - pozycja zosta³a zaznaczona na mapie w MDT.", VehicleNames[GetVehicleModel(veh_id)-400]);
				SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTRED, komunikat, true);
				
				stole_a_car_timers_ids[playerid][1] = SetTimerEx("FinishLSPDCarThiefTracking", ZA_LSPD_GPS_DURATION_LONG_MS, false, "i", playerid);

				SendClientMessage(playerid, COLOR_LIGHTRED, "BARDZO gor¹cy towar - dosta³eœ cynk, ¿e swoj¹ kradzie¿¹ wzbudzi³eœ du¿e zainteresowanie policji!");
				format(komunikat, sizeof(komunikat), "Twój kontakt da ci namiary na dziuplê za ok. %d minut. Mo¿esz liczyæ na du¿¹ premiê!", ZA_LSPD_GPS_DURATION_LONG_MS / 60000);
				SendClientMessage(playerid, COLOR_LIGHTRED, komunikat);

				stole_a_car_seconds_to_find_cp[playerid] = ZA_LSPD_GPS_DURATION_LONG_MS / 1000;
				stole_a_car_lspd_bonus[playerid] = 2;
			}
			else
			{
				format(komunikat, sizeof(komunikat), "HQ: Kamery namierzy³y z³odzieja aut, porusza siê %s - pozycja zosta³a zaznaczona na mapie w MDT.", VehicleNames[GetVehicleModel(veh_id)-400]);
				SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTRED, komunikat, true);

				stole_a_car_timers_ids[playerid][1] = SetTimerEx("FinishLSPDCarThiefTracking", ZA_LSPD_GPS_DURATION_SHORT_MS, false, "i", playerid);

				SendClientMessage(playerid, COLOR_LIGHTRED, "Gor¹cy towar - dosta³eœ cynk, ¿e swoj¹ kradzie¿¹ wzbudzi³eœ zainteresowanie policji!");
				format(komunikat, sizeof(komunikat), "Twój kontakt da ci namiary na dziuplê za ok. %d sekund. Mo¿esz liczyæ na premiê!", ZA_LSPD_GPS_DURATION_SHORT_MS / 1000);
				SendClientMessage(playerid, COLOR_LIGHTRED, komunikat);
			
				stole_a_car_seconds_to_find_cp[playerid] = ZA_LSPD_GPS_DURATION_SHORT_MS / 1000;
				stole_a_car_lspd_bonus[playerid] = 1;
			}

			GetPlayerPos(playerid, thief_pos_x, thief_pos_y, thief_pos_z);
			stole_a_car_lspd_map_icon[playerid] = CreateDynamicMapIconEx(thief_pos_x, thief_pos_y, thief_pos_z, 0, map_icon_color, MAPICON_GLOBAL_CHECKPOINT, 12000.00, 
																		{-1}, {-1}, lspd_members, {STREAMER_TAG_AREA:-1}, 0, 1, 1, lspd_members_count, 1);
			stole_a_car_timers_ids[playerid][0] = SetTimerEx("UpdateCarThiefLSPDMapIcon", ZA_LSPD_UPDATE_PERIOD_MS, true, "i", playerid);

			if(PoziomPoszukiwania[playerid] < 2)
			{
				PoziomPoszukiwania[playerid] = 2;
				SetPlayerCriminal(playerid, INVALID_PLAYER_ID, "Kradzie¿ pojazdu mechanicznego.");
			}
		}
	}

	stole_a_car[playerid] = 1;
	SetTimerEx("AntiTeleportCarThief", 30000, false, "d", playerid);
	stole_a_car_anti_tp[playerid] = 1;

	if(stole_a_car_lspd_bonus[playerid] == 0) // W przeciwnym wypadku ma to miejsce dopiero bo wy³¹czeniu policyjnego GPSa - patrz: FinishLSPDCarThiefTracking
	{
		EnableCarThiefCheckpoint(playerid);
	}

	return 1;
}

//end