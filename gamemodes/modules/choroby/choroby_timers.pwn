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

		if(PlayerImmunity[playerid] > 0) 
		{
			PlayerImmunity[playerid]--;
			return 1;
		}

		if(GetPVarInt(playerid, "disease-treatement") == 0) //nie wywo³uj efektów podczas leczenia
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
	ChatMe(playerid, "poczu³ siê, jakby zarazi³ siê chorob¹.");
	return 1;
}

timer CurrationCounter[1000](playerid, count)
{
	GameTextForPlayer(playerid, sprintf("Leczenie: ~r~%ds", count), 1000, 1);

	if(count <= 0) {
		defer CurrationCounter(playerid, count-1);
	} else {
		EndPlayerTreatment(playerid);
	}
}

//end