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
	switch(YHash(diseaseName))
	{
		default:
			return eDiseases:NONE;
	}
	return eDiseases:NONE;
}

CureFormAll(playerid)
{
	VECTOR_clear(VPlayerDiseases[playerid]);
	MruMySQL_RemoveAllDiseases(playerid);
}

CurePlayer(playerid, eDiseases:disease)
{
	VECTOR_remove_val(VPlayerDiseases[playerid], disease);
	MruMySQL_RemoveDisease(playerid, disease);
	DeactivateDiseaseEffect(playerid, disease);
}

InfectPlayer(playerid, eDiseases:disease)
{
	MruMySQL_AddDisease(playerid, disease);
	InfectPlayerWithoutSaving(playerid, disease);
}

InfectPlayerWithoutSaving(playerid, eDiseases:disease)
{
	VECTOR_push_back_val(VPlayerDiseases[playerid], disease);
	ActivateDiseaseEffect(playerid, disease);
}

DiagnosePlayer(playerid, diagnoserid)
{
    SendClientMessage(diagnoserid, COLOR_WHITE, sprintf("|__________ Wynik diagnozy %s __________|", GetNick(playerid)));
	if(IsPlayerHealthy(playerid))
	{
		SendClientMessage(diagnoserid, COLOR_GREY, "Gracz jest zdrowy.");
		return 1;
	}

	VECTOR_foreach(i : VPlayerDiseases[playerid])
	{
		new eDiseases:disease = eDiseases:MEM_get_val(i);
		SendClientMessage(diagnoserid, COLOR_GREY, sprintf("Wykryto chorobê: "INCOLOR_LIGHTBLUE"%s", DiseaseData[disease][Name]));
	}
	return 1;
}

IsPlayerHealthy(playerid)
{
	return VECTOR_size(VPlayerDiseases[playerid]) == 0;
}

PlayerHasDisease(playerid, eDiseases:disease) 
{
	return VECTOR_find_val(VPlayerDiseases[playerid], disease) != INVALID_VECTOR_INDEX;
}

ActivateDiseaseEffect(playerid, eDiseases:disease)
{
	VECTOR_foreach(i : DiseaseData[disease][VEffects])
	{
		new eEffects:effect = eEffects:MEM_get_val(i);
		if(Effects[effect][Pernament]) 
		{
			CallEffectActivateCallback(playerid, disease, effect);
		} 
		else 
		{
			CallEffectTimer(playerid, disease, effect);
		}
	}
	return 1;
}

DeactivateDiseaseEffect(playerid, eDiseases:disease)
{
	VECTOR_foreach(i : DiseaseData[disease][VEffects])
	{
		new eEffects:effect = eEffects:MEM_get_val(i);
		CallEffectDesactivateCallback(playerid, disease, effect);
	}
}

CallEffectTimer(playerid, eDiseases:disease, eEffects:effect) 
{
	new effectTime = Effects[effect][MinTime] + random(Effects[effect][TimeRange]);
	defer EffectTimer[effectTime](playerid, disease, effect);
	return 1;
}

CallEffectActivateCallback(playerid, eDiseases:disease, eEffects:effect)
{
	CallLocalFunction(Effects[effect][ActivateCallback], "iii", playerid, disease, effect);
	return 1;
}

CallEffectDesactivateCallback(playerid, eDiseases:disease, eEffects:effect)
{
	CallLocalFunction(Effects[effect][DeactivateCallback], "iii", playerid, disease, effect);
	return 1;
}

DoInfecting(playerid, eDiseases:disease, eEffects:effect)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(IsPlayerStreamedIn(i, playerid)) //dla optymalizacji
		{
			if(IsPlayerInRangeOfPoint(i, Effects[effect][ContagiousRange], x, y, z))
			{
				InfectPlayer(i, disease);
				new messageTime = random(60000);//minuta
				defer InfectedEffectMessage[messageTime](playerid);
			}
		}
	}
}

//end