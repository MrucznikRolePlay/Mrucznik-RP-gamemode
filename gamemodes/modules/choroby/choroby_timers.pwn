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
	System chorób.
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

		DecreaseImmunity(playerid);
		if(IsPlayerTreated(playerid)) //nie wywo³uj efektów podczas leczenia
		{
			return 1;
		}

		CallEffectActivateCallback(playerid, disease, effect);
		DoInfecting(playerid, disease, effect);
	}
	return 1;
}

timer InfectedEffectMessage[15000](playerid) 
{
	ChatMe(playerid, "poczu³ siê chory.");
	return 1;
}

timer CurrationCounter[1000](playerid, count)
{
	GameTextForPlayer(playerid, sprintf("Leczenie: ~r~%ds", count), 1000, 1);

	if(count <= 0) 
	{
		new doctorid = GetPVarInt(playerid, "treatment-doctorid");
		if(IsPlayerConnected(doctorid) && GetDistanceBetweenPlayers(playerid,doctorid) < 5) 
		{	
			AbortCurration[playerid] = 0;
			defer CurrationCounter(playerid, count-1);
		}
		else
		{
			if(AbortCurration[playerid] == 60)
			{
				//abort treatment
				if(IsPlayerConnected(doctorid))
					GameTextForPlayer(doctorid, "Kuracja przerwana.", 1000, 1);
				GameTextForPlayer(playerid, "Kuracja przerwana.", 1000, 1);
				SetPVarInt(playerid, "disease-treatement", 0);
				return;
			}
			if(IsPlayerConnected(doctorid))
				GameTextForPlayer(doctorid, "Wracaj do pacjenta!", 1000, 1);
			GameTextForPlayer(playerid, "Wracaj do lekarza!", 1000, 1);
			AbortCurration[playerid]++;
			defer CurrationCounter(playerid, count);
		}
	} 
	else 
	{
		EndPlayerTreatment(playerid);
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
				InfectPlayer(i, GRYPA);
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