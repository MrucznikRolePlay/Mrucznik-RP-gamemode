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

		CallEffectActivateCallback(playerid, disease, effect);
		CallEffectTimer(playerid, disease, effect, effectID);

		new infectionRand = random(100);
		new Float:infectionChance = DiseaseData[disease][ContagiousRatio] * effect[InfectionChance];
		if(infectionRand < infectionChance) // do infection
		{
			DoInfecting(playerid, disease, effect);
		}
	}
	return 1;
}

timer InfectedEffectMessage[15000](playerid) 
{
	ChatMe(playerid, "poczu³ siê, jakby zarazi³ siê chorob¹.");
	return 1;
}

//end