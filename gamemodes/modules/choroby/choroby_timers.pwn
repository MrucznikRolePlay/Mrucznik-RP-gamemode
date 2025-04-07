//-----------------------------------------------<< Timers >>------------------------------------------------//
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
	System chor�b.
*/

//

//-----------------<[ Timery: ]>-------------------
//CallEffectTimer(playerid, disease, callback)

timer EffectTimer[5000](playerid, uid, eDiseases:disease, effectID)
{
	if(PlayerInfo[playerid][pUID] != uid) return 1;

	if(IsPlayerSick(playerid, disease)) 
	{
		new effect[eEffectData];
		VECTOR_get_arr(DiseaseData[disease][VEffects], effectID, effect);
		CallEffectTimer(playerid, disease, effect, effectID);

		if(IsPlayerTreated(playerid)) //nie wywo�uj efekt�w podczas leczenia
		{
			return 1;
		}
		if(Spectate[playerid] != INVALID_PLAYER_ID) //nie wywo�uj efekt�w gdy specuje
		{
			return 1;
		}

		if(GetPlayerImmunity(playerid) <= EFFECT_ACTIVATION_IMMUNITY_BOUNDARY || effect[BreaksThroughImmunity])
		{ // wywo�uj efekty tylko gdy gracz nie ma odporno�ci lub gdy efekt przebija si� przez odporno�� 
			DoInfecting(playerid, disease, effect);
			CallEffectActivateCallback(playerid, disease, effect);
		}
		else
		{
			DecreasePlayerImmunity(playerid, 1);
		}
	}
	return 1;
}

timer InfectedEffectMessage[15000](playerid) 
{
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zarazi�e� si� jak�� chorob�, lepiej id� do lekarza.");
	ChatMe(playerid, "poczu� si� chory.");
	return 1;
}

timer TreatmentCounter[1000](playerid, count)
{
	new doctorid = GetPVarInt(playerid, "treatment-doctorid");
	GameTextForPlayer(playerid, sprintf("Kuracja ~r~%ds", count), 1000, 4);
	if(IsPlayerConnected(doctorid))
		GameTextForPlayer(doctorid, sprintf("Kuracja ~r~%ds", count), 1000, 4);

	if(count >= 0) 
	{
		if(	IsPlayerConnected(doctorid) && GetDistanceBetweenPlayers(playerid,doctorid) < 5) 
		{	
			AbortCurration[playerid] = 0;
			defer TreatmentCounter(playerid, count-1);
		}
		else
		{
			if(AbortCurration[playerid] == 60)
			{
				//abort treatment
				if(IsPlayerConnected(doctorid))
				{
					GameTextForPlayer(doctorid, "Kuracja przerwana.", 1000, 1);
					SendClientMessage(doctorid, COLOR_RED, "Kuracja przerwana - oddali�e� si� od pacjenta na zbyt d�ugo!");
				}
				GameTextForPlayer(playerid, "Kuracja przerwana.", 1000, 1);
				SendClientMessage(playerid, COLOR_RED, "Kuracja przerwana - oddali�e� si� od doktora na zbyt d�ugo!");
				SetPVarInt(playerid, "disease-treatement", 0);
				return;
			}
			if(IsPlayerConnected(doctorid))
				GameTextForPlayer(doctorid, "Wracaj do pacjenta!", 1000, 1);
			GameTextForPlayer(playerid, "Wracaj do lekarza!", 1000, 1);
			AbortCurration[playerid]++;
			defer TreatmentCounter(playerid, count);
		}
	} 
	else 
	{
		EndPlayerTreatment(playerid, doctorid);
	}
}

task ChorobyMinutaTimer[60000]() 
{
	foreach(new i : Player)
	{
		//Grypa
		new Float:hp;
		GetPlayerHealth(i, hp);
		if(hp < 20.0) 
		{
			Grypa[i]++;
			if(Grypa[i] == 60)
			{
				if(InfectOrDecreaseImmunity(i, GRYPA)) {
					SendClientMessage(i, COLOR_LIGHTBLUE, "Twoja posta� by�a zbyt d�ugo os�abiona (niskie HP) i zarazi�a si� gryp�!");
				}
				Grypa[i] = 0;
			}
		}
		else
		{
			Grypa[i] = 0;
		}

		//Tourett
		if(Tourett[i] > 0) Tourett[i]--;

		//PTSD
		if(PTSDCounter[i] > 0) PTSDCounter[i]--;
	}
}

//end