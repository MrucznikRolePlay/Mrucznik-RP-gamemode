//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  choroby                                                  //
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
// Data utworzenia: 07.02.2020
//Opis:
/*
	System chorób.
*/

//

//-----------------<[ Funkcje: ]>-------------------
eDiseases:GetDiseaseID(diseaseName[]) 
{
	for(new eDiseases:i; i<eDiseases; i++) 
	{
		if(strcmp(DiseaseData[i][ShortName], diseaseName, true) == 0) 
		{
			return i;
		}
	}
	return eDiseases:NONE;
}

CureFromAllDiseases(playerid)
{
	VECTOR_foreach(i : VPlayerDiseases[playerid])
	{
		DeactivateDiseaseEffects(playerid, eDiseases:MEM_get_val(i));
	}
	VECTOR_clear(VPlayerDiseases[playerid]);
	MruMySQL_RemoveAllDiseases(playerid);
}

CurePlayer(playerid, eDiseases:disease)
{
	VECTOR_remove_val(VPlayerDiseases[playerid], disease);
	MruMySQL_RemoveDisease(playerid, disease);
	DeactivateDiseaseEffects(playerid, disease);
}

InfectPlayer(playerid, eDiseases:disease)
{
	if(IsPlayerSick(playerid, disease))
	{
		return 0;
	}
	if(GetPlayerAdminDutyStatus(playerid) == 1) return 0;
	MruMySQL_AddDisease(playerid, disease);
	InfectPlayerWithoutSaving(playerid, disease);
	return 1;
}

InfectPlayerWithoutSaving(playerid, eDiseases:disease)
{
	VECTOR_push_back_val(VPlayerDiseases[playerid], disease);
	ActivateDiseaseEffect(playerid, disease);
	return 1;
}

DiagnosePlayer(playerid, diagnoserid)
{
    SendClientMessage(diagnoserid, COLOR_WHITE, sprintf("|__________ Wynik diagnozy %s __________|", GetNick(playerid)));
    SendClientMessage(playerid, COLOR_WHITE, sprintf("|__________ Diagnoza od lekarza %s __________|", GetNick(diagnoserid)));
	if(IsPlayerHealthy(playerid))
	{
		SendClientMessage(diagnoserid, COLOR_GREY, "Gracz jest zdrowy.");
		SendClientMessage(playerid, COLOR_GREY, "Jesteœ zdrowy.");
		return 1;
	}

	VECTOR_foreach(i : VPlayerDiseases[playerid])
	{
		new eDiseases:disease = eDiseases:MEM_get_val(i);
		SendClientMessage(diagnoserid, COLOR_GREY, sprintf("Wykryto chorobê: "INCOLOR_LIGHTBLUE"%s", DiseaseData[disease][Name]));
		SendClientMessage(playerid, COLOR_GREY, sprintf("Wykryto chorobê: "INCOLOR_LIGHTBLUE"%s", DiseaseData[disease][Name]));
	}
	return 1;
}

IsPlayerHealthy(playerid)
{
	return VECTOR_size(VPlayerDiseases[playerid]) == 0;
}

IsPlayerSick(playerid, eDiseases:disease) 
{
	return VECTOR_find_val(VPlayerDiseases[playerid], disease) != INVALID_VECTOR_INDEX;
}

ActivateDiseaseEffect(playerid, eDiseases:disease)
{
	if(GetPlayerAdminDutyStatus(playerid) == 1) return 1;
	new effectID = 0;
	VECTOR_foreach(v : DiseaseData[disease][VEffects])
	{
		new effect[eEffectData];
		MEM_UM_zero(UnmanagedPointer:MEM_UM_get_addr(effect[eEffectData:0]), sizeof(effect));
		MEM_get_arr(v, _, effect, sizeof(effect));

		if(effect[Pernament]) 
		{
			CallEffectActivateCallback(playerid, disease, effect);
		} 
		else 
		{
			CallEffectTimer(playerid, disease, effect, effectID);
		}
		effectID ++;
	}
	return 1;
}

DeactivateDiseaseEffects(playerid, eDiseases:disease)
{
	VECTOR_foreach(v : DiseaseData[disease][VEffects])
	{
		new effect[eEffectData];
		MEM_UM_zero(UnmanagedPointer:MEM_UM_get_addr(effect[eEffectData:0]), sizeof(effect));
		MEM_get_arr(v, _, effect, sizeof(effect));

		CallEffectDesactivateCallback(playerid, disease, effect);
	}
}

CallEffectTimer(playerid, eDiseases:disease, effect[eEffectData], effectID) 
{
	new effectTime = effect[MinTime] + random(effect[TimeRange]);
	defer EffectTimer[effectTime](playerid, PlayerInfo[playerid][pUID], disease, effectID);
	return 1;
}

CallEffectActivateCallback(playerid, eDiseases:disease, effect[eEffectData])
{
	if(isnull(effect[ActivateCallback])) return 1;
	CallLocalFunction(effect[ActivateCallback], "iii", playerid, disease, effect[AdditionalValue]);
	return 1;
}

CallEffectDesactivateCallback(playerid, eDiseases:disease, effect[eEffectData])
{
	if(isnull(effect[DeactivateCallback])) return 1;
	CallLocalFunction(effect[DeactivateCallback], "iii", playerid, disease, effect[AdditionalValue]);
	return 1;
}

DoInfecting(playerid, eDiseases:disease, effect[eEffectData])
{
	if(PlayerInfo[playerid][pBW] != 0 && GetPlayerAdminDutyStatus(playerid) != 0)
		return 1;

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(IsPlayerStreamedIn(i, playerid)) //dla optymalizacji
		{
			if(PlayerInfo[i][pBW] == 0 && GetPlayerAdminDutyStatus(i) == 0 && IsPlayerInRangeOfPoint(i, effect[ContagiousRange], x, y, z))
			{
				if(PlayerImmunity[i] <= 0) 
				{
					if(RandomizeSouldBeInfected(effect[InfectionChance], DiseaseData[disease][ContagiousRatio])) // do infection
					{
						if(IsPlayerSick(i, disease)) return 1;
						InfectPlayer(i, disease);
						new messageTime = random(60000);//minuta
						defer InfectedEffectMessage[messageTime](i);
					}
				}
				else
				{
					DecreaseImmunity(i);
				}
			}
		}
	}
	return 1;
}

RandomizeSouldBeInfected(Float:chance, Float:ratio=1.0) 
{
	new infectionRand = random(100000); //dok³adnoœæ do 0.001%
	new Float:infectionChance = chance * ratio * 1000;
	return infectionRand < infectionChance;
}

ShowDiseaseList(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "|__________________ Choroby __________________|");
	new string[144];
	for(new i; i<_:eDiseases; i++) 
	{
		if(i%5 == 0) 
		{
			if(i != 0) SendClientMessage(playerid, COLOR_GREY, string);
			format(string, sizeof(string), "Dostêpne nazwy: ");
		}
		strcat(string, DiseaseData[eDiseases:i][ShortName]);
		strcat(string, " ");
	}
	SendClientMessage(playerid, COLOR_GREY, string);
	SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
	return 1;
}

StartPlayerTreatment(playerid, doctorid, eDiseases:disease)
{
	new time = DiseaseData[disease][CureTime];
	SetPVarInt(playerid, "disease-treatement", disease);
	SetPVarInt(playerid, "treatment-doctorid", doctorid);

	ApplyAnimation(playerid, "BEACH", "bather", 4.0999, 1, 0, 0, 1, 0, 1);

	TreatmentCounter(playerid, time+1);
	return 1;
}

EndPlayerTreatment(playerid, doctorid)
{
	new eDiseases:disease = eDiseases:GetPVarInt(playerid, "disease-treatement");
	new chance = DiseaseData[disease][DrugResistance];
	new rand = random(100);
	SetPVarInt(playerid, "disease-treatement", 0);
	ClearAnimations(playerid);

	if(rand < chance) //nie uda³o siê
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Niestety, leczenie siê nie powiod³o. Spróbuj jeszcze raz.");
		GameTextForPlayer(playerid, "~r~Nie uda³o siê :(", 5000, 1);
		GameTextForPlayer(doctorid, sprintf("~r~Nie uda³o siê wyleczyc %s", GetNick(playerid)), 5000, 1);
	}
	else //uda³o siê
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Uda³o Ci siê pokonaæ chorobê!");
		CurePlayer(playerid, disease);
		GameTextForPlayer(playerid, "~g~Wyleczony!", 5000, 1);
		GameTextForPlayer(doctorid, sprintf("~g~Pacjent %s wyleczony!", GetNick(playerid)), 5000, 1);
		PlayerImmunity[playerid] = 5;
	}
}

IsPlayerTreated(playerid)
{
	return GetPVarInt(playerid, "disease-treatement") != 0;
}

DecreaseImmunity(playerid)
{
	if(GetPlayerAdminDutyStatus(playerid) == 1) return 1;
	PlayerImmunity[playerid]--;
	if(PlayerImmunity[playerid] <= 0)
	{
		if(GetPVarInt(playerid, "maseczka") > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "Twoja maseczka ju¿ nie spe³nia swojej roli ochronnej!");
			DetachPlayerItem(playerid, GetPVarInt(playerid, "maseczka")-1);
			SetPVarInt(playerid, "maseczka", 0);
		}
		return 0;
	}
	return PlayerImmunity[playerid];
}

//-----------------<[ Disease effects: ]>-------------------
AddEffect(eDiseases:disease, activateCallback[32], deactivateCallback[32], minTime, timeRange, bool:pernament=false, Float:contagiousRange=0.0, infectionChance=0, additionalValue=0)
{
	new array[eEffectData]; //TODO: Czy mo¿na to zrobiæ inicjalizacj¹ {}?
	strcat(array[ActivateCallback], activateCallback, 32);
	strcat(array[DeactivateCallback], deactivateCallback, 32);
	array[MinTime] = minTime;
	array[TimeRange] = timeRange;
	array[Pernament] = pernament;
	array[ContagiousRange] = contagiousRange;
	array[InfectionChance] = infectionChance;
	array[AdditionalValue] = additionalValue;
	VECTOR_push_back_arr(DiseaseData[disease][VEffects], array);
	return 1;
}

//end