//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                              praca_przemytnik                                             //
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
// Data utworzenia: 31.03.2024
//Opis:
/*
	Praca przemytnika.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
Przemytnik_OnPlayerText(playerid, text[])
{
	switch(GetPVarInt(playerid, "smuggling"))
	{
		case 0:
		{
			return 0;
		}
		case 1: // pocz�tek rozmowy
		{
			if(strcmp(text, "tak", true) == 0)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Podaj mi jak nazywa si� Tw�j kierowca.");
				SetPVarInt(playerid, "smuggling", 2);
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): W takim razie �egnam.", 450);
				MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
			}
		}
		case 2: // podaj kierowc�
		{
			new giveplayerid;
			if(sscanf(text, "k<fix>", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie znam nikogo takiego, na pewno poda�e� mi prawid�owe Imi�_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_DRIVER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ten go�� nie jest zawodowym kierowc�, nie ufam mu.");
				return 1;
			}

			if(GetPlayerJobSkill(giveplayerid, JOB_DRIVER) < 5)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ten go�� ma zbyt ma�e umiej�tno�ci by bra� udzia� w akcji, znajd� kogo� bardziej do�wiadczonego (5 skill).");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zdaje sie, �e ta osoba jest ju� zaj�ta i bierze udzia� w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Podaj mi imi� swojego kolejnego wsp�lnika, kt�ry b�dzie podnosi� paczki.", 450);
			MarcepanPhone(playerid, COLOR_GRAD2, "Je�li nie masz wi�cej wsp�lnik�w, wpisz: 'to wszyscy'.");
			SetPVarInt(playerid, "smuggling", 3);
			SetPVarInt(playerid, "smuggling-driver-id", giveplayerid);
			SetPVarInt(playerid, "smuggling-driver-uid", PlayerInfo[giveplayerid][pUID]);
		}
		case 3: // podaj wsp�lnik�w
		{
			if(strcmp(text, "to wszyscy", true) == 0)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, w takim razie ustalmy miejsce zebrania kontrabandy.", 450);
				MarcepanPhone(playerid, COLOR_YELLOW, "Gdy b�dziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
				SetPVarInt(playerid, "smuggling", 4);
				return 1;
			}

			new giveplayerid;
			if(sscanf(text, "k<fix>", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie znam nikogo takiego, na pewno poda�e� mi prawid�owe Imi�_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_SMUGGLER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie chcemy jako wsp�lnik�w os�b postronnych, tylko do�wiadczeni przemytnicy s� gwarantem udanej akcji.");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zdaje sie, �e ta osoba jest ju� zaj�ta i bierze udzia� w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, czy to wszyscy, czy masz jeszcze jakiego� wsp�lnika?", 450);
			MarcepanPhone(playerid, COLOR_GRAD2, "Je�li nie masz wi�cej wsp�lnik�w, wpisz: 'to wszyscy'.");
			
			new index = GetPVarInt(playerid, "smuggling-partner-index");
			SetPVarInt(playerid, sprintf("smuggling-partner-%d-id", index), giveplayerid);
			SetPVarInt(playerid, sprintf("smuggling-partner-%d-uid", index), PlayerInfo[giveplayerid][pUID]);
			SetPVarInt(playerid, "smuggling-partner-index", index+1);
		}
		case 4: // podaj pozycj�
		{
			if(strcmp(text, "tutaj", true) == 0)
			{
				if(!IsPlayerAtViceCityMainland(playerid))
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Punkt zboru musi znajdowa� si� w Vice City Mainland.");
					return 1;
				}

				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, pobra�em twoj� pozycj�, przywioz� tam kontener do kt�rego b�dziesz musia� dostarczy� �adunek.", 450);
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Wykup kontrabandy od nas to 1 000 000$, chcesz zap�aci� przelewem czy got�wk�?");
				SetPVarInt(playerid, "smuggling", 5);
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPVarFloat(playerid, "smuggling-x", x);
				SetPVarFloat(playerid, "smuggling-y", y);
				SetPVarFloat(playerid, "smuggling-z", z);
				return 1;
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie marnuj mojego czasu, gdy b�dziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
			}
		}
		case 5: // zap�a�
		{
			if(strcmp(text, "gotowka", true) == 0 || strcmp(text, "got�wk�", true) == 0)
			{
				if(kaska[playerid] < SMUGGLING_COST)
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie pr�buj mnie oszuka�, jeste� go�odupcem. Wr�� jak zarobisz na kupno kontrabandy.", 450);
					MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
					DeletePVar(playerid, "smuggling");
					return 1;
				}
				ZabierzKase(playerid, SMUGGLING_COST);
			}
			else if(strcmp(text, "przelewem", true) == 0 || strcmp(text, "przelew", true) == 0)
			{
				if(PlayerInfo[playerid][pAccount] < SMUGGLING_COST)
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie pr�buj mnie oszuka�, jeste� go�odupcem. Wr�� jak zarobisz na kupno kontrabandy.", 450);
					MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
					DeletePVar(playerid, "smuggling");
					return 1;
				}
				PlayerInfo[playerid][pAccount] -= SMUGGLING_COST;
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zap�acisz przelewem czy got�wk�?", 450);
				MarcepanPhone(playerid, COLOR_GRAD2, "Wpisz 'przelewem' lub 'got�wk�'.");
				return 1;
			}

			Log(payLog, INFO, "%s zorganizowa� przemyt za %d$", GetNick(playerid), SMUGGLING_COST);

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): W porz�dku, wysy�am Ci koordynaty naszego statku.", 450);
			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Udaj si� tam wodolotem wraz ze swoim kierowc� aby odebra� kontraband�.", 700);
			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Udanej akcji, le� nisko!", 800);
        	MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.", 1000);

			MarcepanPhone(playerid, COLOR_PANICRED, "WA�NE! By wystartowa� wodolotem, ustaw /fpslimit 30 i upewnij si�, �e masz w��czony frame limiter w ustawieniach GTA SA", 1100);
			MarcepanPhone(playerid, COLOR_PANICRED, "Aby wej�� do wodolotu jako pasa�er, u�yj komendy /wejdzw", 1200);

			StartSmuggling(playerid);
			DeletePVar(playerid, "smuggling");
		}
		default:
		{
			return 0;
		}
	}
	return 1;
}

Przemytnik_OnPlayerLogin(playerid)
{
	new actionID = GetPlayerSmugglingActionID(playerid);
	if(actionID == -1)
	{
		return 1;
	}

	Group_SetPlayer(SmugglingAction[actionID][s_crewGroup], playerid, true);

	new role = GetPlayerSmugglingRole(playerid);
	if(role == SMUGGLING_ROLE_INITIATOR || role == SMUGGLING_ROLE_DRIVER)
	{
		switch(SmugglingAction[actionID][s_stage])
		{	
			case SMUGGLING_STAGE_PICKUP:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony. Udaj si� do checkpointu.");
				CreateSmugglingPickupCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_FLY:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony. Wracaj do wodolotu zrzuca� paczki!");
				ShowSmugglingCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_DROP:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony. Wracaj do wodolotu zrzuca� paczki!");
				ShowSmugglingCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_GATHER:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony. Wracaj dostracza� paczki do strefy zboru!");
				CreateSmugglingGatherCheckpoint(playerid, actionID);
			}
		}
	}
	else
	{
		switch(SmugglingAction[actionID][s_stage])
		{	
			case SMUGGLING_STAGE_PICKUP:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony.");
				CreateSmugglingGatherCheckpoint(playerid, actionID);
			}
			default:
			{
				MruMessageGoodInfo(playerid, "Tw�j udzia� w akcji przemytniczej zosta� przywr�cony. Wracaj dostracza� paczki do strefy zboru!");
				CreateSmugglingGatherCheckpoint(playerid, actionID);
			}
		}
	}
	return 1;
}

Przemytnik_OnPlayerEnterRaceCP(playerid)
{
	if(!IsAWodolot(GetPlayerVehicleID(playerid)))
	{
		return 0;
	}

	new actionID = GetPlayerSmugglingActionID(playerid);
	if(actionID == -1)
	{
		return 0;
	}

	new role = GetPlayerSmugglingRole(playerid);
    if(role != SMUGGLING_ROLE_INITIATOR && role != SMUGGLING_ROLE_DRIVER)
    {
		return 0;
    }

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && role == SMUGGLING_ROLE_INITIATOR)
    {
        MruMessageFail(playerid, "Musisz by� pasa�erem wodolotu. Tw�j kierowca powinien nim kierowa�.");
        return 1;
    }

	if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_FLY)
	{
		if(role == SMUGGLING_ROLE_INITIATOR)
		{
			SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_DROP;
			MruMessageGoodInfo(playerid, "Musisz teraz przelecie� przez "#CHECKPOINT_PER_DROP" checkpointy aby dokona� zrzutu kontrabandy.");
		}
		else
		{
			MruMessageGoodInfo(playerid, "Musisz teraz przelecie� przez "#CHECKPOINT_PER_DROP" checkpointy aby Tw�j partner m�g� dokona� zrzutu kontrabandy.");
		}
		ShowSmugglingCheckpoint(playerid, actionID);
		PlayerPlaySound(playerid, 1138, 0, 0, 0);
		return 1;
	}
	else if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_DROP)
	{
		if(SmugglingAction[actionID][s_enableContrabandDrop])
		{
        	MruMessageFail(playerid, "Aby kontynuowa� zbieranie checkpoint�w - zrzu�cie paczk� z kontraband�.");
			return 1;
		}

		if(role == SMUGGLING_ROLE_INITIATOR)
		{
			SmugglingAction[actionID][s_capturedCheckpoints] += 1;
			if(SmugglingAction[actionID][s_capturedCheckpoints] % CHECKPOINT_PER_DROP == 0)
			{
				SmugglingAction[actionID][s_enableContrabandDrop] = 1;
				MruMessageGoodInfoF(playerid, "Uda�o Ci si� przelecie� przez %d checkpointy, mo�esz teraz dokona� zrzutu na odpowiedniej wysoko�ci za pomoc� komendy /zrzut!", CHECKPOINT_PER_DROP);
				ChatMe(playerid, "przygotowuje si� do zrzutu paczki z kontraband�");
				GameTextForPlayer(playerid, "~g~Mozesz zrzucic kontrabande!", 5000, 6);
				DisablePlayerRaceCheckpoint(playerid);
				PlayerPlaySound(playerid, 1137, 0, 0, 0);
			}
			else
			{
				PlayerPlaySound(playerid, 1138, 0, 0, 0);
				ShowSmugglingCheckpoint(playerid, actionID);
			}
		}
		else
		{
			PlayerPlaySound(playerid, 1138, 0, 0, 0);
			DisablePlayerRaceCheckpoint(playerid);
			defer Driver_ShowSmugglingCP(playerid, actionID); // defer this call to make sure that the initiator process the checkpoint logic first
		}

		if(SmugglingAction[actionID][s_capturedCheckpoints] >= MAX_SMUGGLING_CHECKPOINTS)
		{
			MruMessageGoodInfo(playerid, "Uda�o Ci si� przelecie� przez wszystkie checkpointy.");
			DisablePlayerRaceCheckpoint(playerid);
			CreateSmugglingGatherCheckpoint(playerid, actionID);
			PlayerPlaySound(playerid, 1139, 0, 0, 0);
		}
		return 1;
	}
	else if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_GATHER)
	{
			MruMessageGoodInfo(playerid, "Uda�o Ci si� przelecie� przez wszystkie checkpointy.");
			DisablePlayerRaceCheckpoint(playerid);
			CreateSmugglingGatherCheckpoint(playerid, actionID);
			PlayerPlaySound(playerid, 1139, 0, 0, 0);
	}
	return 1;
}

timer Driver_ShowSmugglingCP[100](playerid, actionID)
{
	if(!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if(SmugglingAction[actionID][s_enableContrabandDrop] == 0)
	{
		ShowSmugglingCheckpoint(playerid, actionID);
	}
	return 1;
}

Przemyt_OnPlayerDropMovable(playerid, boxid, boxType, Float:x, Float:y, Float:z, Float:angle)
{
	#pragma unused x,y,z,angle
	if(boxType != BOX_TYPE_CONTRABAND_ACTION && boxType != BOX_TYPE_CONTRABAND)
	{
		return 0;
	}

	new actionID = -1;
	if(boxType == BOX_TYPE_CONTRABAND_ACTION)
	{
		actionID = GetSmugglingActionByBoxID(boxid);
	}
	if(GetPlayerJob(playerid) == JOB_SMUGGLER || actionID != -1)
	{
		if(actionID != -1 && boxType == BOX_TYPE_CONTRABAND_ACTION) // przemytnik z akcji
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0,
				SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ]))
			{
				MruMessageGoodInfo(playerid, "Uda�o Ci si� dostarczy� paczk� z kontraband� do punktu zboru!");
				GatherPackage(actionID, boxid, Boxes[boxid][box_bonus]);
				SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, sprintf("%s dostarczy� paczk� z kontraband� do punktu zboru!", GetNick(playerid)));
			}
		}
		else // zwyk�y przemytnik
		{
			if(IsPlayerInRangeOfPoint(playerid, 15.0, SmugglersHole[0], SmugglersHole[1], SmugglersHole[2]))
			{
				new contraband;
				if(boxType == BOX_TYPE_CONTRABAND_ACTION)
				{
					contraband = Boxes[boxid][box_bonus] / 2;
					if(actionID != -1)
					{
						GatherPackage(actionID, boxid, 0);
						SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Wrogi przemytnik zgarn�� wasz� paczk� z kontraband�!");
					}
					else
					{
						printf("Error: niepoprawna akcja dla paczki kontrabandowej: %d, %d", boxid, playerid);
						DestroyBox(boxid);
					}
				}
				else
				{
					contraband = Boxes[boxid][box_bonus];
					DestroyBox(boxid);
				}

				if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_BOAT))
				{
					contraband = floatround(contraband * 1.2); // +20%
				}

				MruMessageGoodInfo(playerid, "Uda�o Ci si� dostarczy� paczk� z kontraband� do dziupli przemytniczej!");
				MruMessageGoodInfoF(playerid, "Znajdowa�o si� w niej %d kontrabandy. Jest teraz Twoja!", contraband);
				Log(payLog, INFO, "Gracz %s odebral %d kontrabandy z paczki.", GetPlayerLogName(playerid), contraband);
				GiveContraband(playerid, contraband);
				DisablePlayerCheckpoint(playerid);
			}
		}
	}

	ChatMe(playerid, "upuszcza paczk� z kontraband�.");
	return 1;
}

Przemyt_OnPlayerPickupMovable(playerid, boxid, boxType)
{
	if(boxType != BOX_TYPE_CONTRABAND_ACTION && boxType != BOX_TYPE_CONTRABAND)
	{
		return 0;
	}

	new smugglingAction = -1;
	if(boxType == BOX_TYPE_CONTRABAND_ACTION)
	{
		smugglingAction = GetPlayerSmugglingActionID(playerid);
	}

	new packageState[32];
	if(boxType == BOX_TYPE_CONTRABAND_ACTION)
	{
		if(Boxes[boxid][box_bonus] == BIG_PACKAGE_CONTRABAND_AMMOUNT)
		{
			format(packageState, sizeof(packageState), "du��");
		}
		else if(Boxes[boxid][box_bonus] >= BIG_PACKAGE_CONTRABAND_AMMOUNT/2)
		{
			format(packageState, sizeof(packageState), "uszkodzon�");
		}
		else
		{
			format(packageState, sizeof(packageState), "mocno uszkodzon�");
		}
	}
	else
	{
		format(packageState, sizeof(packageState), "ma��");
	}

	// �owca / LSPD
	if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
	{
		MruMessageGoodInfo(playerid, "Podnios�e� paczk� z przemytem! Zniszcz te nielegalne przedmioty aby uzyska� nagrod�.");
		new shootCount = 1+ Boxes[boxid][box_bonus] / SHOOTS_RATIO;
		MruMessageGoodInfoF(playerid, "Aby to zrobi� upu�� j� i zacznij do niej strzela� (potrzeba oko�o %d strza��w by j� zniszczy�).", shootCount);
	}

	if(GetPlayerJob(playerid) == JOB_SMUGGLER || smugglingAction != -1)
	{
		if(smugglingAction != -1 && boxType == BOX_TYPE_CONTRABAND_ACTION) // przemytnik z akcji
		{
			MruMessageGoodInfoF(playerid, "Uda�o Ci si� zebra� %s paczk� z kontraband� zrzucon� przez Twoj� ekip�. Dostarcz j� do punktu zboru!", packageState);
			CreateSmugglingGatherCheckpoint(playerid, smugglingAction);
		}
		else // zwyk�y przemytnik
		{
			if(boxType == BOX_TYPE_CONTRABAND_ACTION)
			{
				MruMessageGoodInfoF(playerid, "Uda�o Ci si� zebra� %s paczk� z kontraband� zrzucon� przez wrog� ekip�. Dostarcz j� do dziupli przemytniczej (checkpoint)!", packageState);
			}
			else
			{
				MruMessageGoodInfo(playerid, "Uda�o Ci si� podnie�� paczk� z kontraband�! Dostarcz j� do dziupli przemytniczej (checkpoint)!");
			}
			CreateSmugglingGatherCheckpoint(playerid, smugglingAction, true);
		}
	}

	ChatMe(playerid, sprintf("podnosi %s paczk� z kontraband�.", packageState));
	return 1;
}

Przemyt_OnPlayerShootMovable(playerid, weaponid, boxid, boxType)
{
	#pragma unused weaponid
	if(boxType != BOX_TYPE_CONTRABAND_ACTION && boxType != BOX_TYPE_CONTRABAND)
	{
		return 0;
	}

	new rand = random(100);
	if(rand <= DMG_CHANCE) 
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(Boxes[boxid][box_object], x, y, z);

		Boxes[boxid][box_bonus] -= floatround(GetWeaponMaxDamage(weaponid), floatround_ceil);
		if(Boxes[boxid][box_bonus] <= 0)
		{
			if(boxType == BOX_TYPE_CONTRABAND_ACTION)
			{
				new actionID = GetSmugglingActionByBoxID(boxid);
				if(actionID != -1)
				{
					GatherPackage(actionID, boxid, 0);
					SendSmugglingCrewMessage(actionID, COLOR_PANICRED, "Kto� zniszczy� zrzucon� paczk� z kontraband�!");
				}
				else
				{
					printf("Error: niepoprawna akcja dla paczki kontrabandowej: %d, %d", boxid, playerid);
					DestroyBox(boxid);
				}
			}
			else
			{
				DestroyBox(boxid);
			}

			ChatMe(playerid, "zniszczy� paczk� z kontraband�.");

			if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
			{
				new reward = Boxes[boxid][box_initialBonus] * DESTROY_CONTRABAND_REWARD_PER_PACKAGE;
				MruMessageGoodInfoF(playerid, "Uda�o Ci si� zniszczy� nielegaln� kontraband�! Otrzymujesz %d$ nagrody.", reward);
				DajKase(playerid, reward);
				Log(payLog, INFO, "Gracz %s dostal %d$ za zniszczenie paczki z kontrabanda", GetPlayerLogName(playerid), reward);
			}
		}

		PlayerPlaySound(playerid, 1135, x, y, z); // hit (SOUND_BASEBALL_BAT_HIT_PED) - metaliczny d�wi�k
		defer DeferedDestroyObject(CreateDynamicObject(18680, x, y, z-1.0, 0.0, 0.0, float(random(360)), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
		Streamer_Update(playerid);
	}

	return 1;
}

OnPlayerShootSmugglingBoat(playerid, vehicleid)
{
	if(GetPlayerJob(playerid) != JOB_SMUGGLER)
	{
		return;
	}

	new driverid = INVALID_PLAYER_ID;
    foreach(new i : NPC)
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			driverid = i;
		}
	}
	
	if(driverid == INVALID_PLAYER_ID)
	{
		return;
	}

	if(BotSmugglingPackages <= 0)
	{
		RemovePlayerFromVehicle(driverid);
		SetVehicleHealth(vehicleid, 20.0);
		return;
	}

	new Float:x, Float:y, Float:z, Float:hp;
	GetVehiclePos(vehicleid, x, y, z);

	if(IsVehicleInRangeOfPoint(vehicleid, 20.0, -4448.16, 876.198, -0.700195)) // dont drop on spawn
	{
		return;
	}

	// drop box with 5% chance
	new rand = random(20);
	if(rand < 1)
	{
		GetVehicleHealth(vehicleid, hp);
		SetVehicleHealth(vehicleid, hp-200.0);
		
		new boxid = DropBoxFromCar(1580, BOX_TYPE_CONTRABAND, 1 + random(20), vehicleid); 
		if(boxid != -1)
		{
			MruMessageGoodInfo(playerid, "Trafi�e� w ��d� przemytnik�w! Wypad�a z niej ma�a paczka kontrabandy.");
		}
		BotSmugglingPackages--;
		PlayerPlaySound(playerid, 31205, 0.0, 0.0, 0.0);
	}
	else
	{
		PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0); // hit (SOUND_BASEBALL_BAT_HIT_PED) - metaliczny d�wi�k
	}
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(JetpackGas[playerid] > 0)
	{
		SetSmugglingItem(playerid, SMUGGLING_ITEM_JETPACK_GAS, JetpackGas[playerid]);
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(IsAWodolot(vehicleid))
	{
		for(new i; i<SMUGGLING_ACTIONS_PER_DAY; i++)
		{
			if(SmugglingAction[i][s_SkimmerID] == vehicleid)
			{
				// drop package with half of the drop
				SendSmugglingCrewMessage(i, TEAM_AZTECAS_COLOR, "Wodolot zosta� zniszczony! Wypad�a z niego paczka przemytnicza z uszkodzonym towarem.");

				SmugglingAction[i][s_enableContrabandDrop] = 0;
				SmugglingAction[i][s_packagesToDrop]--;

				new Float:x, Float:y, Float:z;
				GetVehiclePos(vehicleid, x, y, z);
				GetPosBehindVehicle(vehicleid, x, y, z, 1.0);
				CreateContrabandDrop(i, x, y, z, SmugglingAction[i][s_packagesToDrop], true);

				if(SmugglingAction[i][s_packagesToDrop] == 0)
				{
					// last package dropped, start gather stage
					SmugglingAction[i][s_stage] = SMUGGLING_STAGE_GATHER;
					SendSmugglingCrewMessage(i, TEAM_AZTECAS_COLOR, "To by�a ostatnia paczka, teraz czas zebra� je wszystkie.");
				}
			}
		}
	}
}

//end