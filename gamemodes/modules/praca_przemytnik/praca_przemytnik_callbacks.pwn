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
		case 1: // pocz¹tek rozmowy
		{
			if(strcmp(text, "tak", true) == 0)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Podaj mi jak nazywa siê Twój kierowca.");
				SetPVarInt(playerid, "smuggling", 2);
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): W takim razie ¿egnam.");
				MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
			}
		}
		case 2: // podaj kierowcê
		{
			new giveplayerid;
			if(sscanf(text, "k<fix>", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie znam nikogo takiego, na pewno poda³eœ mi prawid³owe Imiê_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_DRIVER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ten goœæ nie jest zawodowym kierowc¹, nie ufam mu.");
				return 1;
			}

			if(GetPlayerJobSkill(giveplayerid, JOB_DRIVER) < 5)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ten goœæ ma zbyt ma³e umiejêtnoœci by braæ udzia³ w akcji, znajdŸ kogoœ bardziej doœwiadczonego (5 skill).");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zdaje sie, ¿e ta osoba jest ju¿ zajêta i bierze udzia³ w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Podaj mi imiê swojego kolejnego wspólnika, który bêdzie podnosi³ paczki.");
			MarcepanPhone(playerid, COLOR_GRAD2, "Jeœli nie masz wiêcej wspólników, wpisz: 'to wszyscy'.");
			SetPVarInt(playerid, "smuggling", 3);
			SetPVarInt(playerid, "smuggling-driver-id", giveplayerid);
			SetPVarInt(playerid, "smuggling-driver-uid", PlayerInfo[giveplayerid][pUID]);
		}
		case 3: // podaj wspólników
		{
			if(strcmp(text, "to wszyscy", true) == 0)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, w takim razie ustalmy miejsce zebrania kontrabandy.");
				MarcepanPhone(playerid, COLOR_YELLOW, "Gdy bêdziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
				SetPVarInt(playerid, "smuggling", 4);
				return 1;
			}

			new giveplayerid;
			if(sscanf(text, "k<fix>", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie znam nikogo takiego, na pewno poda³eœ mi prawid³owe Imiê_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_SMUGGLER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie chcemy jako wspólników osób postronnych, tylko doœwiadczeni przemytnicy s¹ gwarantem udanej akcji.");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zdaje sie, ¿e ta osoba jest ju¿ zajêta i bierze udzia³ w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, czy to wszyscy, czy masz jeszcze jakiegoœ wspólnika?");
			MarcepanPhone(playerid, COLOR_GRAD2, "Jeœli nie masz wiêcej wspólników, wpisz: 'to wszyscy'.");
			
			new index = GetPVarInt(playerid, "smuggling-partner-index");
			SetPVarInt(playerid, sprintf("smuggling-partner-%d-id", index), giveplayerid);
			SetPVarInt(playerid, sprintf("smuggling-partner-%d-uid", index), PlayerInfo[giveplayerid][pUID]);
			SetPVarInt(playerid, "smuggling-partner-index", index+1);
		}
		case 4: // podaj pozycjê
		{
			if(strcmp(text, "tutaj", true) == 0)
			{
				if(!IsPlayerAtViceCityMainland(playerid))
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Punkt zboru musi znajdowaæ siê w Vice City Mainland.");
					return 1;
				}

				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Ok, pobra³em twoj¹ pozycjê, przywiozê tam kontener do którego bêdziesz musia³ dostarczyæ ³adunek.");
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Wykup kontrabandy od nas to 1 000 000$, chcesz zap³aciæ przelewem czy gotówk¹?");
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
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie marnuj mojego czasu, gdy bêdziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
			}
		}
		case 5: // zap³aæ
		{
			if(strcmp(text, "gotowka", true) == 0 || strcmp(text, "gotówk¹", true) == 0)
			{
				if(kaska[playerid] < SMUGGLING_COST)
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie próbuj mnie oszukaæ, jesteœ go³odupcem. Wróæ jak zarobisz na kupno kontrabandy.");
					MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
					DeletePVar(playerid, "smuggling");
					return 1;
				}
				ZabierzKase(playerid, SMUGGLING_COST);
			}
			else if(strcmp(text, "przelewem", true) == 0 || strcmp(text, "przelew", true) == 0)
			{
				if(PlayerInfo[playerid][pAccount] < SMUGGLING_COST)
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie próbuj mnie oszukaæ, jesteœ go³odupcem. Wróæ jak zarobisz na kupno kontrabandy.");
					MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
					DeletePVar(playerid, "smuggling");
					return 1;
				}
				PlayerInfo[playerid][pAccount] -= SMUGGLING_COST;
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zap³acisz przelewem czy gotówk¹?");
				MarcepanPhone(playerid, COLOR_GRAD2, "Wpisz 'przelewem' lub 'gotówk¹'.");
				return 1;
			}

			Log(payLog, INFO, "%s zorganizowa³ przemyt za %d$", GetNick(playerid), SMUGGLING_COST);

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): W porz¹dku, wysy³am Ci koordynaty naszego statku.");
			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Udaj siê tam wodolotem wraz ze swoim kierowc¹ aby odebraæ kontrabandê.");
			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Udanej akcji, leæ nisko!");
        	MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");

			MarcepanPhone(playerid, COLOR_PANICRED, "WA¯NE! By wystartowaæ wodolotem, ustaw /fpslimit 30 i upewnij siê, ¿e masz w³¹czony frame limiter w ustawieniach GTA SA");
			MarcepanPhone(playerid, COLOR_PANICRED, "Aby wejœæ do wodolotu jako pasa¿er, u¿yj komendy /wejdzw");

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
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony. Udaj siê do checkpointu.");
				CreateSmugglingPickupCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_FLY:
			{
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony. Wracaj do wodolotu zrzucaæ paczki!");
				ShowSmugglingCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_DROP:
			{
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony. Wracaj do wodolotu zrzucaæ paczki!");
				ShowSmugglingCheckpoint(playerid, actionID);
			}
			case SMUGGLING_STAGE_GATHER:
			{
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony. Wracaj dostraczaæ paczki do strefy zboru!");
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
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony.");
				CreateSmugglingGatherCheckpoint(playerid, actionID);
			}
			default:
			{
				MruMessageGoodInfo(playerid, "Twój udzia³ w akcji przemytniczej zosta³ przywrócony. Wracaj dostraczaæ paczki do strefy zboru!");
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
        MruMessageFail(playerid, "Musisz byæ pasa¿erem wodolotu. Twój kierowca powinien nim kierowaæ.");
        return 1;
    }

	if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_FLY)
	{
		if(role == SMUGGLING_ROLE_INITIATOR)
		{
			SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_DROP;
			MruMessageGoodInfo(playerid, "Musisz teraz przelecieæ przez "#CHECKPOINT_PER_DROP" checkpointy aby dokonaæ zrzutu kontrabandy.");
		}
		else
		{
			MruMessageGoodInfo(playerid, "Musisz teraz przelecieæ przez "#CHECKPOINT_PER_DROP" checkpointy aby Twój partner móg³ dokonaæ zrzutu kontrabandy.");
		}
		ShowSmugglingCheckpoint(playerid, actionID);
		PlayerPlaySound(playerid, 1138, 0, 0, 0);
		return 1;
	}
	else if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_DROP)
	{
		if(SmugglingAction[actionID][s_enableContrabandDrop])
		{
        	MruMessageFail(playerid, "Aby kontynuowaæ zbieranie checkpointów - zrzuæcie paczkê z kontraband¹.");
			return 1;
		}

		if(role == SMUGGLING_ROLE_INITIATOR)
		{
			SmugglingAction[actionID][s_capturedCheckpoints] += 1;
			if(SmugglingAction[actionID][s_capturedCheckpoints] % CHECKPOINT_PER_DROP == 0)
			{
				SmugglingAction[actionID][s_enableContrabandDrop] = 1;
				MruMessageGoodInfoF(playerid, "Uda³o Ci siê przelecieæ przez %d checkpointy, mo¿esz teraz dokonaæ zrzutu na odpowiedniej wysokoœci za pomoc¹ komendy /zrzut!", CHECKPOINT_PER_DROP);
				ChatMe(playerid, "przygotowuje siê do zrzutu paczki z kontraband¹");
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
			MruMessageGoodInfo(playerid, "Uda³o Ci siê przelecieæ przez wszystkie checkpointy.");
			DisablePlayerRaceCheckpoint(playerid);
			CreateSmugglingGatherCheckpoint(playerid, actionID);
			PlayerPlaySound(playerid, 1139, 0, 0, 0);
		}
		return 1;
	}
	else if(SmugglingAction[actionID][s_stage] == SMUGGLING_STAGE_GATHER)
	{
			MruMessageGoodInfo(playerid, "Uda³o Ci siê przelecieæ przez wszystkie checkpointy.");
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
				MruMessageGoodInfo(playerid, "Uda³o Ci siê dostarczyæ paczkê z kontraband¹ do punktu zboru!");
				GatherPackage(actionID, boxid, Boxes[boxid][box_bonus]);
				SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, sprintf("%s dostarczy³ paczkê z kontraband¹ do punktu zboru!", GetNick(playerid)));
			}
		}
		else // zwyk³y przemytnik
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, SmugglersHole[0], SmugglersHole[1], SmugglersHole[2]))
			{
				new contraband;
				if(boxType == BOX_TYPE_CONTRABAND_ACTION)
				{
					contraband = Boxes[boxid][box_bonus] / 2;
					actionID = GetSmugglingActionByBoxID(boxid);
					GatherPackage(actionID, boxid, 0);
					SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, "Wrogi przemytnik zgarn¹³ wasz¹ paczkê z kontraband¹!");
				}
				else
				{
					contraband = Boxes[boxid][box_bonus];
					DestroyBox(boxid);
				}
				MruMessageGoodInfo(playerid, "Uda³o Ci siê dostarczyæ paczkê z kontraband¹ do dziupli przemytniczej!");
				MruMessageGoodInfoF(playerid, "Znajdowa³o siê w niej %d kontrabandy. Jest teraz Twoja!", contraband);
				GiveContraband(playerid, contraband);
				DisablePlayerCheckpoint(playerid);
			}
		}
	}

	ChatMe(playerid, "upuszcza paczkê z kontraband¹.");
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
		new actionID = GetSmugglingActionByBoxID(boxid);
		smugglingAction = GetPlayerSmugglingActionID(playerid);
		DestroySmugglingBoxFlare(actionID);
	}

	new packageState[32];
	if(boxType == BOX_TYPE_CONTRABAND_ACTION)
	{
		if(Boxes[boxid][box_bonus] == BIG_PACKAGE_CONTRABAND_AMMOUNT)
		{
			format(packageState, sizeof(packageState), "du¿¹");
		}
		else if(Boxes[boxid][box_bonus] >= BIG_PACKAGE_CONTRABAND_AMMOUNT/2)
		{
			format(packageState, sizeof(packageState), "uszkodzon¹");
		}
		else
		{
			format(packageState, sizeof(packageState), "mocno uszkodzon¹");
		}
	}
	else
	{
		format(packageState, sizeof(packageState), "ma³¹");
	}

	// ³owca / LSPD
	if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
	{
		MruMessageGoodInfo(playerid, "Podnios³eœ paczkê z przemytem! Zniszcz te nielegalne przedmioty aby uzyskaæ nagrodê.");
		new shootCount = 1+ Boxes[boxid][box_bonus] / SHOOTS_RATIO;
		MruMessageGoodInfoF(playerid, "Aby to zrobiæ upuœæ j¹ i zacznij do niej strzelaæ (potrzeba oko³o %d strza³ów by j¹ zniszczyæ).", shootCount);
	}

	if(GetPlayerJob(playerid) == JOB_SMUGGLER || smugglingAction != -1)
	{
		if(smugglingAction != -1 && boxType == BOX_TYPE_CONTRABAND_ACTION) // przemytnik z akcji
		{
			MruMessageGoodInfoF(playerid, "Uda³o Ci siê zebraæ %s paczkê z kontraband¹ zrzucon¹ przez Twoj¹ ekipê. Dostarcz j¹ do punktu zboru!", packageState);
			CreateSmugglingGatherCheckpoint(playerid, smugglingAction);
		}
		else // zwyk³y przemytnik
		{
			if(boxType == BOX_TYPE_CONTRABAND_ACTION)
			{
				MruMessageGoodInfoF(playerid, "Uda³o Ci siê zebraæ %s paczkê z kontraband¹ zrzucon¹ przez wrog¹ ekipê. Dostarcz j¹ do dziupli przemytniczej (checkpoint)!", packageState);
			}
			else
			{
				MruMessageGoodInfo(playerid, "Uda³o Ci siê podnieœæ paczkê z kontraband¹! Dostarcz j¹ do dziupli przemytniczej (checkpoint)!");
			}
			CreateSmugglingGatherCheckpoint(playerid, smugglingAction, false);
		}
	}

	ChatMe(playerid, sprintf("podnosi %s paczkê z kontraband¹.", packageState));
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
				DestroySmugglingBoxFlare(actionID);
				GatherPackage(actionID, boxid, 0);
				SendSmugglingCrewMessage(actionID, COLOR_PANICRED, "Ktoœ zniszczy³ zrzucon¹ paczkê z kontraband¹!");
			}
			else
			{
				DestroyBox(boxid);
			}

			ChatMe(playerid, "zniszczy³ paczkê z kontraband¹.");

			if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
			{
				new reward = Boxes[boxid][box_initialBonus] * DESTROY_CONTRABAND_REWARD_PER_PACKAGE;
				MruMessageGoodInfoF(playerid, "Uda³o Ci siê zniszczyæ nielegaln¹ kontrabandê! Otrzymujesz %d$ nagrody.", reward);
				DajKase(playerid, reward);
			}
		}

		PlayerPlaySound(playerid, 1135, x, y, z); // hit (SOUND_BASEBALL_BAT_HIT_PED) - metaliczny dŸwiêk
		SendClientMessage(playerid, 0xFFFFFFFF, sprintf("hit %f %f %f", x, y, z));
		defer DeferedDestroyObject(CreateDynamicObject(18680, x, y, z-1.0, 0.0, 0.0, float(random(360)), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
		Streamer_Update(playerid);
	}

	return 1;
}

//end