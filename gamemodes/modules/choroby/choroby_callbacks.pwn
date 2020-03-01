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
	System chorób.
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
	else 
	{
		//padaczka
		if(bodypart == BODY_PART_HEAD)
		{
			if(random(200) == 0)
			{
				InfectPlayer(playerid, PADACZKA);
			}
		}
	}
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	if(regex_match(nick, "[^a-zA-Z](kurwa|chuj|huj|cipa|fiut|zjeb|kurwy|jeb|pizda|pizdy|szmul|dzban|kutas|dupa|cipka|pierdol|pierdolony)[^a-zA-Z]") <= 0)
	{
		Tourett[playerid]++;
		if(Tourett[playerid] >= 60)
		{
			InfectPlayer(playerid, TOURETT);
		}
	}
	return 1;
}

//end