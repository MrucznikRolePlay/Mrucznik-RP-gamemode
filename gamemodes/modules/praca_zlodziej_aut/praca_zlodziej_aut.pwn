//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

ZerujZmienne_Zlodziej_Aut(playerid)
{
	stole_a_car[playerid] = 0;
	stole_a_car_lspd_bonus[playerid] = 0;
	stole_a_car_timers_ids[playerid] = {-1, -1};
	stole_a_car_seconds_to_find_cp[playerid] = 0;
	stole_a_car_lspd_map_icon[playerid] = -1;
	stole_a_car_checkpoint[playerid] = {-1, -1, -1};
	stole_a_car_anti_tp[playerid] = 0;

	return ZerujZmienne(playerid);
}
#if defined _ALS_ZerujZmienne
    #undef ZerujZmienne
#else
    #define _ALS_ZerujZmienne
#endif
#define ZerujZmienne ZerujZmienne_Zlodziej_Aut

//-----------------------Pojazdy Deluxe-----------------

LoadDeluxeCarsForStealing()
{
	new deluxe_models[] = {402, 480, 562}; //Buffalo, Euros, Elegy

	new bool:used[CAR_AMOUNT] = {false, ... };
	foreach(new p : Player)
	{
		if(IsPlayerInAnyVehicle(p))
		{
			new veh = GetPlayerVehicleID(p);
			used[veh] = true;
		}
	}

	for(new i = 0; i < sizeof(deluxe_cars_for_stealing_ids); i++)
	{
		if(deluxe_cars_for_stealing_ids[i] != -1)
		{
			continue;
		}

		new valid_rand = false;
		new deluxe_id;

		while(!valid_rand || used[deluxe_id])
		{
			valid_rand = true;
			deluxe_id = true_random(116) + 50; // tylko pojazdy w LS

			for(new j = 0; j < i; j++)
			{
				if(deluxe_cars_for_stealing_ids[j] == deluxe_id)
				{
					valid_rand = false;
					break;
				}
			}
		}

		deluxe_cars_for_stealing_ids[i] = deluxe_id;
		DestroyVehicle(deluxe_id);
		AddStaticVehicleEx(deluxe_models[i % sizeof(deluxe_models)], CarSpawns[deluxe_id-1][pos_x], CarSpawns[deluxe_id-1][pos_y], CarSpawns[deluxe_id-1][pos_z], CarSpawns[deluxe_id-1][z_angle], random(126), 1, -1);
		SetVehicleNumberPlate(deluxe_id, "{1F9F06}M-RP");
	}
}


RemoveDeluxeCarForStealing(veh_id)
{
	for(new i = 0; i < sizeof(deluxe_cars_for_stealing_ids); i++)
	{
		if(deluxe_cars_for_stealing_ids[i] == veh_id)
		{
			deluxe_cars_for_stealing_ids[i] = -1;
			ReloadCarForStealing(veh_id);
			break;
		}
	}
}


ReloadDeluxeCarsForStealing()
{
	new bool:used[CAR_AMOUNT] = {false, ... };
	foreach(new p : Player)
	{
		if(IsPlayerInAnyVehicle(p))
		{
			new veh = GetPlayerVehicleID(p);
			used[veh] = true;
		}
	}

	for(new i = 0; i < sizeof(deluxe_cars_for_stealing_ids); i++)
	{
		new deluxe_veh_id = deluxe_cars_for_stealing_ids[i];
		if(deluxe_veh_id != -1 && !used[deluxe_veh_id])
		{
			RemoveDeluxeCarForStealing(deluxe_veh_id);
		}
	}
	LoadDeluxeCarsForStealing();
}

//------------------------------------------------------------------------

ReloadCarForStealing(veh_id)
{
	DestroyVehicle(veh_id);
	if(veh_id >= 166) // Faggio dla z³odziejów aut w dziuplach - zawsze ma byæ okreœlony model
	{
		AddCar(veh_id - 1, 462, 3, 3, 180);
	}
	else
	{
		AddCar(veh_id - 1);
	}
	SetVehicleNumberPlate(veh_id, "{1F9F06}M-RP");
	Gas[veh_id] = GasMax;
}

Float:GetStealChanceMultiplier(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 462, 572: // Faggio, Turbowózek
		{
			return 3.0;
		}

		case 549, 542, 404, 478: // Tampa, Clover, Perennial, Walton
		{
			return 1.6;
		}

		case 422, 543: // Bobcat, Sadler
		{
			return 1.5;
		}

		case 401, 436, 518: // Bravura, Previon, Buccaneer
		{
			return 1.4;
		}

		case 498, 585, 492, 466: // Boxville, Emperor, Greenwood, Glendale
		{
			return 1.2;
		}

		case 516, 566: // Nebula, Tahoma
		{
			return 1.1;
		}
	}

	return 1.0; // Elegant
}

GetLspdDetectThresholds(vehicleid, &short, &long)
{
	new model = GetVehicleModel(vehicleid);
	short = ZA_LSPD_GPS_CHANCE;
	long = ZA_LSPD_LONG_GPS_CHANCE;

	switch(model)
	{
		case 549, 542, 404, 478: // Tampa, Clover, Perennial, Walton
		{
			short += 5;
			long += 1;
		}

		case 422, 543: // Bobcat, Sadler
		{
			short += 10;
			long += 2;
		}

		case 401, 436, 518: // Bravura, Previon, Buccaneer
		{
			short += 15;
			long += 3;
		}

		case 498, 585, 492, 466: // Boxville, Emperor, Greenwood, Glendale
		{
			short += 20;
			long += 4;
		}

		case 516, 566: // Nebula, Tahoma
		{
			short += 25;
			long += 7;
		}

		case 507: // Elegant
		{
			short += 35;
			long += 10;
		}

		// Dla Faggio i Turbowózka nic nie dodajemy
	}

	return 1;
}

RmvLSPDMemberFromThiefMapIcons(playerid)
{
	new other_player_map_icon;
	foreach(new i : Player)
	{
		other_player_map_icon = stole_a_car_lspd_map_icon[i];
		if(other_player_map_icon != -1 && 
			Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, other_player_map_icon, E_STREAMER_PLAYER_ID, playerid))
		{
			Streamer_RemoveArrayData(STREAMER_TYPE_MAP_ICON, other_player_map_icon, E_STREAMER_PLAYER_ID, playerid);
		}
	}
}

AddLSPDMemberToThiefMapIcons(playerid)
{
	new other_player_map_icon;
	foreach(new i : Player)
	{
		other_player_map_icon = stole_a_car_lspd_map_icon[i];
		if(other_player_map_icon != -1 && 
			!Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, other_player_map_icon, E_STREAMER_PLAYER_ID, playerid))
		{
			Streamer_AppendArrayData(STREAMER_TYPE_MAP_ICON, other_player_map_icon, E_STREAMER_PLAYER_ID, playerid);
		}
	}
}

EnableCarThiefCheckpoint(playerid)
{
	if(stole_a_car[playerid])
	{
		new Float:chop_shop_pos[3];
		new is_car_deluxe = (stole_a_car_lspd_bonus[playerid] == 3);
		ChooseChopShop(playerid, chop_shop_pos, is_car_deluxe);
		SendClientMessage(playerid, COLOR_YELLOW, "Dostarcz ukradziony pojazd do dziupli - jej lokalizacja zosta³a zaznaczona na mapie.");
		SendClientMessage(playerid, COLOR_YELLOW, "Postaraj siê jechaæ ostro¿nie - im mniej uszkodzisz pojazd, tym wiêcej zarobisz.");

		stole_a_car_checkpoint[playerid][0] = MruCreateDynamicMapIcon(chop_shop_pos[0], chop_shop_pos[1], chop_shop_pos[2], 0, 0xFF1111FF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL_CHECKPOINT);
		stole_a_car_checkpoint[playerid][1] = CreateDynamicCircle(chop_shop_pos[0], chop_shop_pos[1], 16.0, -1, -1, playerid);
		stole_a_car_checkpoint[playerid][2] = SetTimerEx("CarThiefMissionGoalTimer", 750, 1, "d", playerid);
	}
}


DestroyCarThiefLSPDMapIcon(playerid)
{
	new icon_id = stole_a_car_lspd_map_icon[playerid];

	if(IsValidDynamicMapIcon(icon_id))
	{
		DestroyDynamicMapIcon(icon_id);
	}
 
	if(stole_a_car_timers_ids[playerid][0] != -1)
	{
		KillTimer(stole_a_car_timers_ids[playerid][0]);
		stole_a_car_timers_ids[playerid][0] = -1;
	}

	if(stole_a_car_timers_ids[playerid][1] != -1)
	{
		KillTimer(stole_a_car_timers_ids[playerid][1]);
		stole_a_car_timers_ids[playerid][1] = -1;
	}

	stole_a_car_lspd_map_icon[playerid] = -1;

	return 1;
}


// Wybieranie dziupli metod¹ ruletkow¹ https://en.wikipedia.org/wiki/Fitness_proportionate_selection
ChooseChopShop(playerid, chop_shop_pos[], is_car_deluxe)
{
		new Float:chop_shops_positions[3][3];

		if(IsPlayerAtViceCity(playerid))
		{
			chop_shops_positions[0] = {-5507.7612,2380.1775,5.9174};
			chop_shops_positions[1] = {-4136.6187,3123.8940,5.2135};
			chop_shops_positions[2] = {-4285.8408,860.2109,4.9211};
		}
		else if(is_car_deluxe)
		{
			chop_shops_positions[0] = {-1548.3618, 123.6438, 3.2966};
			chop_shops_positions[1] = {577.5023, 1222.4153, 11.7113};
			chop_shops_positions[2] = {2282.3511, -2018.0242, 13.4167};
		}
		else
		{
			chop_shops_positions[0] = {2282.3511, -2018.0242, 13.4167};
			chop_shops_positions[1] = {1410.6040, -135.5417, 22.2146};
			chop_shops_positions[2] = {-419.6872, -1737.5532, 7.9339};
		}

		new Float:cs_distances[sizeof(chop_shops_positions)], Float:cs_distance_sum = 0.0, Float:cs_distance_roulette_sum = 0.0;
		new Float:chop_shop_random = float(true_random(100)) / 100.0, chop_shop_id = 0;

		for(new i = 0; i < sizeof(chop_shops_positions); i++)
		{
			new Float:cs_pos_x = chop_shops_positions[i][0], Float:cs_pos_y = chop_shops_positions[i][1], Float:cs_pos_z = chop_shops_positions[i][2];
			cs_distances[i] = GetPlayerDistanceFromPoint(playerid, cs_pos_x, cs_pos_y, cs_pos_z);
			cs_distance_sum += cs_distances[i];
		}

		chop_shop_random *= cs_distance_sum;
		for(new i = 0; i < sizeof(chop_shops_positions); i++)
		{
			if(cs_distances[i] + cs_distance_roulette_sum >= chop_shop_random)
			{
				chop_shop_id = i;
				break;
			}

			cs_distance_roulette_sum += cs_distances[i];
		}

		chop_shop_pos[0] = chop_shops_positions[chop_shop_id][0];
		chop_shop_pos[1] = chop_shops_positions[chop_shop_id][1];
		chop_shop_pos[2] = chop_shops_positions[chop_shop_id][2];
}


CountLSPDMembersOnDuty(lspd_members[], &lspd_members_count, &lspd_members_counted)
{
	if(!lspd_members_counted)
	{
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && (PlayerInfo[i][pLider] == 1 || PlayerInfo[i][pMember] == 1) && OnDuty[i])
			{
				lspd_members[lspd_members_count++] = i;
				PlayerPlaySound(i, 45400, 0.0, 0.0, 0.0);
			}
		}

		lspd_members_counted = true;
	}
}


UkradnijVerify(playerid, veh_id)
{
	if(PlayerInfo[playerid][pJob] != JOB_CARTHIEF)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z³odziejem aut!");
		return 0;
	}

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie znajdujesz siê w pojeŸdzie jako kierowca!");
		return 0;
	}

	if(!Car_IsStealable(veh_id))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Pojazd, w którym siê znajdujesz ma za dobre zabezpieczenia, by zostaæ przyjêtym w dziupli!");
		return 0;
	}

	if(KradniecieWozu[playerid] != veh_id)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Najpierw uruchom silnik (u¿yj /kradnij)!");
		return 0;		
	}

	if(stole_a_car[playerid])
	{
		sendTipMessageEx(playerid, COLOR_GREY, "U¿y³eœ ju¿ /ukradnij w tym pojeŸdzie!");
		return 0;
	}

	if(PlayerInfo[playerid][pCarTime] != 0)
	{
		new komunikat[128];
		format(komunikat, sizeof(komunikat), "Ukrad³eœ ju¿ wczeœniej wóz, poczekaj %d sekund a¿ policja siê uspokoi!", PlayerInfo[playerid][pCarTime]);
		sendTipMessageEx(playerid, COLOR_GREY, komunikat);
		return 0;
	}

	return 1;
}


CalculateRewardAfterCarDamages(veh_id, reward_no_damages)
{
	new Float:veh_health = 0.0, Float:multiplier = 0.0;
	GetVehicleHealth(veh_id, veh_health);
	veh_health /= 1000.0;

	if(veh_health >= 0.9)
	{
		return reward_no_damages;
	}

	if(veh_health < 0.25001)
	{
		return floatround(float(reward_no_damages) / 5.0, floatround_ceil);
	}

	new Float:veh_damages = 1 - veh_health;
	multiplier = floatpower(ZA_EULER_NUMBER, veh_damages * ZA_DAMAGES_PENALTY_CALC_EXP_CONST);
	multiplier = ZA_DAMAGES_PENALTY_CALC_CONST - multiplier;
	multiplier = floatsqroot(multiplier);
	multiplier += 0.2;

	new Float:reward_f = float(reward_no_damages) * multiplier;
	return floatround(reward_f, floatround_ceil);
}


EndCarThiefMission(playerid)
{
	stole_a_car[playerid] = 0;
	stole_a_car_lspd_bonus[playerid] = 0;

	if(IsValidDynamicMapIcon(stole_a_car_checkpoint[playerid][0]))
	{
		DestroyDynamicMapIcon(stole_a_car_checkpoint[playerid][0]);
		stole_a_car_checkpoint[playerid][0] = -1;
	}

	if(IsValidDynamicArea(stole_a_car_checkpoint[playerid][1]))
	{
		DestroyDynamicArea(stole_a_car_checkpoint[playerid][1]);
		stole_a_car_checkpoint[playerid][1] = -1;
	}

	if(stole_a_car_checkpoint[playerid][2] >= 0)
	{
		KillTimer(stole_a_car_checkpoint[playerid][2]);
	}

	DestroyCarThiefLSPDMapIcon(playerid);
	stole_a_car_seconds_to_find_cp[playerid] = 0;
}


GetBonusRewardFromCarModel(veh_id)
{
	for(new i; i < sizeof(veh_prices); i++)
	{
		if(veh_prices[i][VEH_PRICES_MODEL_ID] == GetVehicleModel(veh_id))
		{
			return veh_prices[i][VEH_PRICES_PRICE] / ZA_REWARD_MODEL_DIVISOR;
		}
	}

	return -1;
}


CarThiefMissionGoal(playerid)
{
	new veh_id = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || !Car_IsStealable(veh_id))
	{
		SendClientMessage(playerid, COLOR_GREY, "Nie jestes w pojeŸdzie nadaj¹cym siê do sprzeda¿y w dziupli!");
		return 1;
	}

	new veh_model_bonus_reward = GetBonusRewardFromCarModel(veh_id);
	if(PlayerInfo[playerid][pJackSkill] >= 200)
	{
		veh_model_bonus_reward *= 2;
	}

	if(veh_model_bonus_reward == -1){
		SendClientMessage(playerid, COLOR_GREY, "Nie jestes w pojeŸdzie nadaj¹cym siê do sprzeda¿y w dziupli!");
		return 1;
	}

	if(stole_a_car_anti_tp[playerid])
	{
		SendPunishMessage(sprintf("AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, powód: teleport (z³odziej aut)", GetNickEx(playerid)), playerid);
		Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: teleport (z³odziej aut)");
		KickEx(playerid, "teleport hack");
		return 1;
	}

	PlayerInfo[playerid][pJackSkill] ++;

	if(PlayerInfo[playerid][pJackSkill] == 50)
	{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 2, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
	else if(PlayerInfo[playerid][pJackSkill] == 100)
	{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 3, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
	else if(PlayerInfo[playerid][pJackSkill] == 200)
	{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 4, bêdziesz wiêcej zarabiaæ oraz szybciej ukraœæ nowe auto."); }
	else if(PlayerInfo[playerid][pJackSkill] == 400)
	{ SendClientMessage(playerid, COLOR_YELLOW, "* Twój skill z³odzieja samochodów wynosi teraz 5, bêdziesz najwiêcej zarabiaæ oraz najszybciej kraœæ auta."); }
	
	new level = PlayerInfo[playerid][pJackSkill], reward = 0, cooldown = 0, premiaTekst[64] = "";
	if(level >= 0 && level <= 50)
	{
		new rand = random(sizeof(SELLCAR1));
		reward = SELLCAR1[rand];
		cooldown = ZA_COOLDOWN_1_S;
	}
	else if(level >= 51 && level <= 100)
	{
		new rand = random(sizeof(SELLCAR2));
		reward = SELLCAR2[rand];
		cooldown = ZA_COOLDOWN_2_S;
	}
	else if(level >= 101 && level <= 200)
	{
		new rand = random(sizeof(SELLCAR3));
		reward = SELLCAR3[rand];
		cooldown = ZA_COOLDOWN_3_S;
	}
	else if(level >= 201 && level <= 400)
	{
		new rand = random(sizeof(SELLCAR4));
		reward = SELLCAR4[rand];
		cooldown = ZA_COOLDOWN_4_S;
	}
	else if(level >= 401)
	{
		new rand = random(sizeof(SELLCAR4));
		reward = SELLCAR5[rand];
		cooldown = ZA_COOLDOWN_5_S;
	}


	if(stole_a_car_lspd_bonus[playerid] == 3)
	{
		premiaTekst = " (niezwykle gor¹cy towar)";
		reward += ZA_DELUXE_CAR_REWARD;
	}
	else
	{
		reward += veh_model_bonus_reward;
	}

	reward = CalculateRewardAfterCarDamages(veh_id, reward);

	if(stole_a_car_lspd_bonus[playerid] == 1)
	{
		format(premiaTekst, sizeof(premiaTekst), " (mno¿nik %i%%%% za gor¹cy towar)", ZA_HOT_STUFF_BONUS*100);
		reward *= ZA_HOT_STUFF_BONUS;
	}
	else if(stole_a_car_lspd_bonus[playerid] == 2)
	{
		format(premiaTekst, sizeof(premiaTekst), " (mno¿nik %i%%%% za BARDZO gor¹cy towar)", ZA_VERY_HOT_STUFF_BONUS*100);
		reward *= ZA_VERY_HOT_STUFF_BONUS;			
	}

	new string[128];
	format(string, sizeof(string), "Sprzeda³eœ pojazd za $%d%s. Kolejny pojazd mo¿esz ukraœæ za %i minut.", reward, premiaTekst, cooldown / 60);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

	DajKase(playerid, reward); //moneycheat
	PlayerInfo[playerid][pCarTime] = cooldown;

	RemovePlayerFromVehicleEx(playerid);
	SetVehicleParamsEx(veh_id, 0, 0, 0, 1, 0, 0, 0);
	new is_deluxe = (stole_a_car_lspd_bonus[playerid] == 3);
	SetTimerEx("CarThiefUnspawnStolenCar", 5000, false, "db", veh_id, is_deluxe);

	EndCarThiefMission(playerid);

	return 1;
}


//end