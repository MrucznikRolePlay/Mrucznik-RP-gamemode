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
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): podaj mi jak nazywa siê Twój kierowca.");
				SetPVarInt(playerid, "smuggling", 2);
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): w takim razie ¿egnam.");
				MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
			}
		}
		case 2: // podaj kierowcê
		{
			new giveplayerid;
			if(sscanf(text, "r", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie znam nikogo takiego, na pewno poda³eœ mi prawid³owe Imiê_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_DRIVER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): ten goœæ nie jest zawodowym kierowc¹, nie ufam mu.");
				return 1;
			}

			if(GetPlayerJobSkill(giveplayerid, JOB_DRIVER) < 5)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): ten goœæ ma zbyt ma³e umiejêtnoœci by braæ udzia³ w akcji, znajdŸ kogoœ bardziej doœwiadczonego (5 skill).");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): zdaje sie, ¿e ta osoba jest ju¿ zajêta i bierze udzia³ w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): podaj mi imiê swojego kolejnego wspólnika, który bêdzie podnosi³ paczki.");
			MarcepanPhone(playerid, COLOR_GRAD2, "Jeœli nie masz wiêcej wspólników, wpisz: 'to wszyscy'.");
			SetPVarInt(playerid, "smuggling", 3);
			SetPVarInt(playerid, "smuggling-driver-id", giveplayerid);
			SetPVarInt(playerid, "smuggling-driver-uid", PlayerInfo[giveplayerid][pUID]);
		}
		case 3: // podaj wspólników
		{
			if(strcmp(text, "to wszyscy", true) == 0)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): ok, w takim razie ustalmy miejsce zebrania kontrabandy.");
				MarcepanPhone(playerid, COLOR_YELLOW, "Gdy bêdziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
				SetPVarInt(playerid, "smuggling", 4);
				return 1;
			}

			new giveplayerid;
			if(sscanf(text, "r", giveplayerid) || !IsPlayerConnected(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie znam nikogo takiego, na pewno poda³eœ mi prawid³owe Imiê_Nazwisko?");
				return 1;
			}

			if(GetPlayerJob(giveplayerid) != JOB_SMUGGLER)
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie chcemy jako wspólników osób postronnych, tylko doœwiadczeni przemytnicy s¹ gwarantem udanej akcji.");
				return 1;
			}

			if(IsPlayerSmuggling(giveplayerid))
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): zdaje sie, ¿e ta osoba jest ju¿ zajêta i bierze udzia³ w innej akcji przemytniczej.");
				return 1;
			}

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): ok, czy to wszyscy, czy masz jeszcze jakiegoœ wspólnika?");
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
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): ok, pobra³em twoj¹ pozycjê, przywiozê tam kontener do którego bêdziesz musia³ dostarczyæ ³adunek.");
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): wykup kontrabandy od nas to 1 000 000$, chcesz zap³aciæ przelewem czy gotówk¹?");
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
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie marnuj mojego czasu, gdy bêdziesz gotowy, powiedz: 'tutaj' a pobiore Twoje koordynaty.");
			}
		}
		case 5: // zap³aæ
		{
			if(strcmp(text, "gotowka", true) == 0 || strcmp(text, "gotówk¹", true) == 0)
			{
				if(kaska[playerid] < SMUGGLING_COST)
				{
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie próbuj mnie oszukaæ, jesteœ go³odupcem. Wróæ jak zarobisz na kupno kontrabandy.");
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
					MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): nie próbuj mnie oszukaæ, jesteœ go³odupcem. Wróæ jak zarobisz na kupno kontrabandy.");
					MarcepanPhone(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
					DeletePVar(playerid, "smuggling");
					return 1;
				}
				PlayerInfo[playerid][pAccount] -= SMUGGLING_COST;
			}
			else
			{
				MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): zap³acisz przelewem czy gotówk¹?");
				MarcepanPhone(playerid, COLOR_GRAD2, "Wpisz 'przelewem' lub 'gotówk¹'.");
				return 1;
			}

			Log(payLog, INFO, "%s zorganizowa³ przemyt za %d$", GetNick(playerid), SMUGGLING_COST);

			MarcepanPhone(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): w porz¹dku, wysy³am Ci koordynaty naszego statku.");
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
	// TODO: gdy akcja przemytnicza siê skoñczy, nie przywracaj graczom ich udzia³u
	new actionID = GetPlayerSmugglingActionID(playerid);
	if(actionID == -1)
	{
		return 1;
	}

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
			// start DROP stage
			SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_DROP;
			MruMessageGoodInfoF(playerid, "Musisz teraz przelecieæ przez %d checkpointy aby dokonaæ zrzutu kontrabandy.", CHECKPOINT_PER_DROP);
		}
		else
		{
			MruMessageGoodInfoF(playerid, "Musisz teraz przelecieæ przez %d checkpointy aby Twój partner móg³ dokonaæ zrzutu kontrabandy.", CHECKPOINT_PER_DROP);
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
				SmugglingAction[actionID][s_capturedCheckpoints] = 0;
				SmugglingAction[actionID][s_enableContrabandDrop] = 1;
				MruMessageGoodInfoF(playerid, "Uda³o Ci siê przelecieæ przez %d checkpointy, mo¿esz teraz dokonaæ zrzutu na odpowidniej wysokoœci za pomoc¹ komendy /zrzut!", CHECKPOINT_PER_DROP);
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
			MruMessageGoodInfoF(playerid, "Uda³o Ci siê przelecieæ przez %d checkpointy!", CHECKPOINT_PER_DROP);
			PlayerPlaySound(playerid, 1138, 0, 0, 0);
			ShowSmugglingCheckpoint(playerid, actionID);
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

Przemyt_OnPlayerDropMovable(playerid, boxid, boxType, Float:x, Float:y, Float:z, Float:angle)
{
	#pragma unused x,y,z,angle
	if(boxType != BOX_TYPE_CONTRABAND_ACTION && boxType != BOX_TYPE_CONTRABAND)
	{
		return 0;
	}

	if(GetPlayerJob(playerid) == JOB_SMUGGLER)
	{
		new actionID = GetPlayerSmugglingActionID(playerid);
		if(actionID == -1) // przemytnik z akcji
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0,
				SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ]))
			{
				MruMessageGoodInfo(playerid, "Uda³o Ci siê dostarczyæ paczkê z kontraband¹ do punktu zboru!");
				if(boxType == BOX_TYPE_CONTRABAND_ACTION)
				{
					GatherPackage(actionID, boxid, Boxes[boxid][box_bonus]);
					// TODO: komunikat o dostarczeniu paczki dla ekipy przemycaj¹cej
				}
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
					// TODO: komunikat o przechwyceniu paczki dla ekipy przemycaj¹cej
				}
				else
				{
					contraband = Boxes[boxid][box_bonus];
				}
				MruMessageGoodInfo(playerid, "Uda³o Ci siê dostarczyæ paczkê z kontraband¹ do dziupli przemytniczej!");
				MruMessageGoodInfoF(playerid, "Znajdowa³o siê w niej %d kontrabandy. Jest teraz Twoja!", contraband);
				GiveContraband(playerid, contraband);
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

	if(boxType == BOX_TYPE_CONTRABAND_ACTION)
	{
		new actionID = GetSmugglingActionByBoxID(boxid);
		DestroySmugglingBoxFlare(actionID);
	}

	// ³owca / LSPD
	if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
	{
		MruMessageGoodInfo(playerid, "Podnios³eœ paczkê z przemytem! Zniszcz te nielegalne przedmioty aby uzyskaæ nagrodê.");
		MruMessageGoodInfoF(playerid, "Aby to zrobiæ upuœæ j¹ i zacznij do niej strzelaæ (potrzeba %d strza³ów by j¹ zniszczyæ).", Boxes[boxid][box_bonus]);
	}
	if(GetPlayerJob(playerid) == JOB_SMUGGLER)
	{
		new smugglingAction = GetPlayerSmugglingActionID(playerid);
		if(smugglingAction == -1) // przemytnik z akcji
		{
			MruMessageGoodInfo(playerid, "Uda³o Ci siê zebraæ paczkê z kontraband¹ zrzucon¹ przez Twoj¹ ekipê. Dostarcz j¹ do punktu zboru!");
			// TODO: stworz checkpoint
		}
		else // zwyk³y przemytnik
		{
			MruMessageGoodInfo(playerid, "Uda³o Ci siê zebraæ paczkê z kontraband¹ zrzucon¹ przez wrog¹ ekipê. Dostarcz j¹ do dziupli przemytniczej (checkpoint)!");
			// TODO: stworz checkpoint
		}
	}

	ChatMe(playerid, "podnosi paczkê z kontraband¹.");
	return 1;
}

Przemyt_OnPlayerShootMovable(playerid, weaponid, boxid, boxType, Float:x, Float:y, Float:z)
{
	#pragma unused weaponid
	if(boxType != BOX_TYPE_CONTRABAND_ACTION && boxType != BOX_TYPE_CONTRABAND)
	{
		return 0;
	}

	new rand;
	if(boxType == BOX_TYPE_CONTRABAND)
	{
		rand = random(10); // 10% chances to take damage
	}
	if(rand == 0) 
	{
		Boxes[boxid][box_bonus] -= 1;
		if(Boxes[boxid][box_bonus] <= 0)
		{
			if(boxType == BOX_TYPE_CONTRABAND_ACTION)
			{
				new actionID = GetSmugglingActionByBoxID(boxid);
				DestroySmugglingBoxFlare(actionID);
				GatherPackage(actionID, boxid, 0);
				// TODO: komunikat o zniszczeniu paczki dla ekipy przemycaj¹cej
			}

			PlayerPlaySound(playerid, 1131, x, y, z); // hit wooden object? (SOUND_AMMUNATION_GUN_COLLISION)

			if(IsAPolicja(playerid) || GetPlayerJob(playerid) == JOB_LOWCA)
			{
				new reward;
				if(boxType == BOX_TYPE_CONTRABAND_ACTION) 
					reward = DESTROY_CONTRABAND_REWARD;
				else if(boxType == BOX_TYPE_CONTRABAND) 
					reward = DESTROY_CONTRABAND_SMALL_REWARD;
				MruMessageGoodInfoF(playerid, "Uda³o Ci siê zniszczyæ nielegaln¹ kontrabandê! Otrzymujesz %d$ nagrody.", reward);
				DajKase(playerid, reward);
			}
			return 1;
		}
	}

	PlayerPlaySound(playerid, 1135, x, y, z); // hit (SOUND_BASEBALL_BAT_HIT_PED)
	return 1;
}

//end