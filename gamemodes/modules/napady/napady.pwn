//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   napady                                                  //
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
// Autor: Sanda³
// Data utworzenia: 17.02.2024
//Opis:
/*

*/
	
//

//-----------------<[ Funkcje: ]>-------------------

Heist_GetAttackZoneid(playerid)
{
	for(new i = 0; i < HEIST_ZONESCOUNT; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 20.0, HeistZone[i][Heist_x], HeistZone[i][Heist_y], HeistZone[i][Heist_z]))
			return i;
	}
	return -1;
}
Heist_EligibleToContinue(attackerid)
{
	new playerid = Heist_Attackers[attackerid];
	if(GetPlayerVirtualWorld(playerid) != 0)
		return 0;
	if(PlayerInfo[playerid][pBW] > 0)
		return 0;
	if(Kajdanki_JestemSkuty[playerid] > 0)
		return 0;
	
	return 1;
}

Heist_Notify(type)
{
	new wanted[144];
	if(type == HEIST_MSG_STEAL)
	{
		format(wanted, sizeof(wanted), "Centrala: Otrzymano zg³oszenie o napadzie na sklep Las Collinas:");
		SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTGREEN, wanted, true);
		format(wanted, sizeof(wanted), "Centrala: Potencjalnie %d uzbrojonych napastników, poruszaj¹cy siê pojazdem marki %s", Heist_AttackersCount, VehicleNames[GetVehicleModel(Heist_CurrentVehicleid)-400]);
		SendFamilyMessage(FRAC_LSPD, COLOR_ALLDEPT, wanted, true);
		format(wanted, sizeof(wanted), "Centrala: napad³o na sklep przy ulicy Los Flores. Zg³oszone przez naocznych œwiadków.");
		SendFamilyMessage(FRAC_LSPD, COLOR_ALLDEPT, wanted, true);
	}
	else if(type == HEIST_MSG_ESCAPE)
	{
		format(wanted, sizeof(wanted), "Centrala: Otrzymano zg³oszenie o napadzie na sklep Las Collinas:");
		SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTGREEN, wanted, true);
		format(wanted, sizeof(wanted), "Centrala: Podejrzani odje¿dzaj¹ pojazdem marki %s spod sklepu.", VehicleNames[GetVehicleModel(Heist_CurrentVehicleid)-400]);
		SendFamilyMessage(FRAC_LSPD, COLOR_ALLDEPT, wanted, true);
	}
	else if(type == HEIST_MSG_GPSUPDATE)
	{
		format(wanted, sizeof(wanted), "Centrala: W systemie nawigacyjnym zaaktualizowano przybli¿on¹ lokacjê podejrzanych o napad.");
		SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTGREEN, wanted, true);
	}
	return 1;
}

Heist_CountLSPD()
{
	new counted_duties = 0;
	new leader, member;
	foreach(new i : Player)
	{
		leader = PlayerInfo[i][pLider];
	    member = PlayerInfo[i][pMember];
		if(OnDuty[i] && (leader == 1 || member == 1))
			counted_duties++;
	}
	return counted_duties;
}

Heist_UpdateMapIcon()
{
	new Float:x, Float:y, Float:z;
	GetVehiclePos(Heist_CurrentVehicleid, x, y, z);
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i) && OnDuty[i] && (PlayerInfo[i][pLider] == 1 || PlayerInfo[i][pMember] == 1))
		{
			if(IsValidDynamicMapIcon(Heist_Icons[i]))
			{
				Streamer_SetItemPos(STREAMER_TYPE_MAP_ICON, Heist_Icons[i], x, y, z);
			}
			else
			{
				Heist_Icons[i] = CreateDynamicMapIcon(x, y, z, 0, 0xECF542FF, -1, -1, i, -1, MAPICON_GLOBAL);
			}
		}
	}
	Heist_Notify(HEIST_MSG_GPSUPDATE);
}

Heist_DestroyMapIcon(id = -1)
{
	if(id == -1)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(!IsValidDynamicMapIcon(Heist_Icons[i]))
				continue;
			else
			{
				DestroyDynamicMapIcon(Heist_Icons[i]);
				Heist_Icons[i] = -1;
			}
		}
	}
	else
	{
		if(IsValidDynamicMapIcon(Heist_Icons[id]))
		{
			DestroyDynamicMapIcon(Heist_Icons[id]);
			Heist_Icons[id] = -1;
		}
	}
}

Heist_Remove(attackerid)
{
	new playerid = Heist_Attackers[attackerid];
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "Zosta³eœ od³¹czony od napadu.");
	PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	SetTimerEx("Heist_ClearData", 500, false, "d", attackerid);
}

Heist_Lost()
{
	new playerid;
	for(new i = 0; i < Heist_AttackersCount; i++)
	{
		if(Heist_Attackers[i] == -1) continue;
		playerid = Heist_Attackers[i];
		SendClientMessage(playerid, COLOR_RED, ">> Napad nieudany!");
		PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	}
	SetTimerEx("Heist_ClearData", 500, false, "d", 5);
}

Heist_Win()
{
	if(Heist_AttackersCounter > 0)
	{
		new playerid, string[52];
		new kasa = HEIST_PAYOUT;
		for(new i = 0; i < Heist_AttackersCounter; i++)
		{
			playerid = Heist_Attackers[i];
			if(playerid != -1)
			{
				if(IsPlayerInVehicle(playerid, Heist_CurrentVehicleid))
				{
					kasa = HEIST_PAYOUT;
					kasa = kasa + random(HEIST_RANDPAYOUT);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "Uda³o ci siê pomyœlnie ochroniæ zdobycz z napadu!");
					PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
					DajKase(playerid, kasa);
					format(string, sizeof(string), ">> Twoja dzia³ka z napadu to $%d", kasa);
					SendClientMessage(playerid, COLOR_GREEN, string);
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "Zosta³eœ od³¹czony od napadu.");
					PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
				}
			}
				
		}
	}
	SetTimerEx("Heist_ClearData", 500, false, "d", 5);
}

Heist_ProcessAttack(playerid)
{
	
	if(Heist_BlockHeisting == 1 || Heist_HeistOFF == 1)
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Przed chwil¹ by³ napad.");
		return 0;
	}
	if(Heist_CountLSPD() < HEIST_MINIMUMLSPD)
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Za ma³o dostêpnych jednostek policji na serwerze do napadu.");
		return 0;
	}

	new zoneid = Heist_GetAttackZoneid(playerid);
	new vehicleid = GetPlayerVehicleID(playerid);

	if(zoneid == -1)
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Nie jesteœ w pobli¿u sklepu do napadania.");
		return 0;
	}
	if(vehicleid != 0){
		if(IsAHeliModel(vehicleid))
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Nie mo¿esz rozpocz¹c napadu w helikopterze.");
			return 0;
		}
		if(IsAPlane(vehicleid))
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Nie mo¿esz rozpocz¹c napadu w samolocie.");
			return 0;
		}
		for(new i = 0; i < 4; i++)
		{
			Heist_Attackers[i] = -1;
		}
		foreach(new i : Player)
		{
			if(IsPlayerInVehicle(i, vehicleid))
			{
				if(IsAPrzestepca(i))
				{
					Heist_Attackers[Heist_AttackersCount] = i;
					sendTipMessage(i, "Zosta³eœ dodany do ekipy napadu.");
					PlayerPlaySound(i, 1149, 0.0, 0.0, 0.0);
					Heist_AttackersCount++;
					Heist_AttackersCounter++;
				}
			}
		}
		if(Heist_AttackersCount >= 2 && Heist_AttackersCount < 5)
		{
			Heist_CurrentZoneid = zoneid;
			Heist_CurrentVehicleid = vehicleid;
			Heist_StartAttack();
			return 1;
		}
		else
		{
			sendTipMessage(playerid, "Za ma³o osób do przeprowadzenia napadu siedzi w tym aucie!");
			sendTipMessage(playerid, "Od 2 do 4 osób z org. przestêpczych mo¿e przeprowadziæ napad.");
			SetTimerEx("Heist_ClearData", 100, false, "d", 5);
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Musisz rozpocz¹æ napad w pojeŸdzie którym bêdziesz uciekaæ!");
	}
	return 0;
}

Heist_StartAttack()
{
	new playerid;
	for(new i = 0; i < Heist_AttackersCount; i++)
	{
		playerid = Heist_Attackers[i];
		if(playerid != -1)
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Waszym celem jest wyczekanie kilku minut w pobli¿u sklepu, oczekuj¹c na koniec kradzie¿y.");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Po zakoñczeniu odliczania bêdziecie musieli uciec tym samym autem.");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Odejœcie od napadu, zginiêcie, kajdanki lub zepsute auto oznaczaj¹ koniec ucieczki.");
		}
	}
	Heist_Steal_Countdown = HEIST_STEAL_TIME;
	Heist_Timers = SetTimer("Heist_Timer",3000,true);
	SetTimer("Heist_UnlockCooldown", 1000 * 60 * HEIST_COOLDOWNS, false);
	Heist_BlockHeisting = 1;
}

Heist_ProcessEscape()
{
	new playerid;
	for(new i = 0; i < Heist_AttackersCount; i++)
	{
		playerid = Heist_Attackers[i];
		if(playerid != -1)
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Pomyœlnie ukrad³eœ ³up! Musisz teraz wróciæ do auta i uciekaæ do czasu zakoñczenia odliczania.");
			PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
		}
	}
	KillTimer(Heist_Timers);
	Heist_Steal_Countdown = HEIST_ESCAPE_TIME;
	Heist_Timers = SetTimer("Heist_Escape",5000,true);
	Heist_Notify(HEIST_MSG_ESCAPE);
}


//end

