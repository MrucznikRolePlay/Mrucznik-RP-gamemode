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

	// for(new eDiseases:i = eDiseases:1; i<eDiseases; i++) {
	// 	DeactivateDiseaseEffects(playerid, i);
	// }
}

CurePlayer(playerid, eDiseases:disease)
{
	VECTOR_remove_val(VPlayerDiseases[playerid], disease);
	MruMySQL_RemoveDisease(playerid, disease);
	// DeactivateDiseaseEffects(playerid, disease);
}

InfectPlayer(playerid, eDiseases:disease)
{
	MruMySQL_AddDisease(playerid, disease);
	InfectPlayerWithoutSaving(playerid, disease);
}

InfectPlayerWithoutSaving(playerid, eDiseases:disease)
{
	VECTOR_push_back_val(VPlayerDiseases[playerid], disease);
	// ActivateDiseaseEffects(playerid, disease);
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

//-----------------<[ Disease effects: ]>-------------------
public NoEffect(playerid, disease)
{

}

//end