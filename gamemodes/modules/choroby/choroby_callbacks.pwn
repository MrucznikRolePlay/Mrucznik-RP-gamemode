//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
choroby_OnPlayerLogin(playerid)
{
	MruMySQL_LoadDiseasesData(playerid);
	return 1;
}

hook OnGameModeInit()
{
	choroby_InitEffects();
}

hook OnPlayerDisconnect(playerid, reason)
{
	VECTOR_clear(VPlayerDiseases[playerid]);
	PlayerImmunity[playerid] = 0;
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	//infecting on contact
	if(weaponid >= 0 && weaponid <= 15) //melee weapons only
	{
		if(!IsPlayerHealthy(issuerid)) 
		{
			VECTOR_foreach(i : VPlayerDiseases[issuerid])
			{
				new eDiseases:disease = eDiseases:MEM_get_val(i);
				if(DiseaseData[disease][SpreadingOnContact])
				{
					if(IsPlayerSick(playerid, disease)) 
						return 1;

					//10% chance to get infected
					if(RandomizeSouldBeInfected(10, DiseaseData[disease][ContagiousRatio])) 
						return 1;

					InfectPlayer(playerid, disease);
					new messageTime = random(60000);//minuta
					defer InfectedEffectMessage[messageTime](playerid);
				}
			}
		}
	}
	return 1;
}

//end