//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  urzadls                                                  //
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
// Autor: Simeone
// Data utworzenia: 20.09.2019
//Opis:
/*
	Automatyzacja Urzêdu Miasta w Los Santos - boty, skrypt botów, prawa jazdy [..] .
*/

//

//-----------------<[ Funkcje: ]>-------------------
PlayerInDmvPoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0215,-1792.1661,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0216,-1795.3773,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0219,-1798.5234,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0416,-1801.7599,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9628,-1791.4224,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9757,-1794.6508,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9752,-1797.7997,77.9453)
	// Vice City
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2977, 186.2629, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2976, 182.4774, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2930, 178.5167, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2979, 168.9292, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2966, 166.2234, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.3013, 163.1573, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 359.7069, 173.6590, 1008.3893))
	{
		return true;
	}
	return false;
}

CreateActorsInDMV(playerid)
{
	DmvActorStatus=true; 
	new freePlace; 
	new string[124];
	for(new i; i<valActor; i++)
	{
		if(Actors[i][a_Group] == AGROUP_DMV)
		{
			if(freePlace < sizeof(okienkoPos))
			{
				SetDynamicActorPos(actorUID[i], okienkoPos[freePlace][0], okienkoPos[freePlace][1], okienkoPos[freePlace][2]);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycjê, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string); 
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				if(i < 8) SetDynamicActorVirtualWorld(actorUID[i], 50);
				else SetDynamicActorVirtualWorld(actorUID[i], 7110);
				UpdateActorText(actorUID[i]);
				if(i < 8) format(string, sizeof(string), "Urz¹d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace+1);
				else format(string, sizeof(string), "Urz¹d Miasta Vice City\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace+1-8);
				UpdateDynamic3DTextLabelText(okienko[freePlace], 0xFFFFFFFF, string);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string, sizeof(string), "Ustawiono nowy text dla okienka [%d], zaktualizowano text actora [%d] na %s", freePlace, actorUID[i], Actors[i][a_Name]);
					sendTipMessage(playerid,  string); 
				}
				freePlace++; 
			}
		}
	}
	dmv = 1; 
	if(playerid == INVALID_PLAYER_ID)
	{
		format(string, sizeof(string), "|____________Urz¹d Miasta otwarty przez system_____________|");
		SendClientMessageToAll(COLOR_LIGHTGREEN, string);	
		return 1;
	}
	format(string, sizeof(string), "|____________Urz¹d Miasta otwarty przez %s_____________|", GetNick(playerid));
	SendClientMessageToAll(COLOR_LIGHTGREEN, string);
	return 1;
}

DestroyActorsInDMV(playerid)
{
	DmvActorStatus=false; 
	new freePlace; 
	new string[124];
	for(new i; i<valActor; i++)
	{
		if(Actors[i][a_Group] == AGROUP_DMV)
		{
			if(freePlace < sizeof(okienkoPos))
			{
				SetDynamicActorPos(actorUID[i], okienkoPos[freePlace][0], okienkoPos[freePlace][1], 0.0);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycjê, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string);
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				SetDynamicActorVirtualWorld(actorUID[i], 50); 
				UpdateActorText(actorUID[i]);
				if(i < 8) format(string, sizeof(string), "Urz¹d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}Zamkniête!", freePlace+1);
				else format(string, sizeof(string), "Urz¹d Miasta Vice City\n{0080FF}Okienko %d \n {FF0000}Zamkniête!", freePlace+1);
				UpdateDynamic3DTextLabelText(okienko[freePlace], 0xFFFFFFFF, string);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string, sizeof(string), "Ustawiono nowy text dla okienka [%d], zaktualizowano text actora [%d] na %s", freePlace, actorUID[i], Actors[i][a_Name]);
					sendTipMessage(playerid,  string); 
				}
				freePlace++; 
			}
		}
	}
	dmv = 0;
	return 1;
}

DefaultItems_LicenseCost()
{
	DmvLicenseCost[0] = 5_000; // dowód
	DmvLicenseCost[1] = 10_000; // karta wêdkarsaka
	DmvLicenseCost[2] = 50_000; // pozwolenie na broñ
	DmvLicenseCost[3] = 100_000; // patent ¿eglarski
	DmvLicenseCost[4] = 5_000; // prawo jazdy - teoria
	DmvLicenseCost[5] = 7_500; // prawo jazdy - praktyka
	DmvLicenseCost[6] = 5_000; // prawo jazdy - odbiór
	DmvLicenseCost[7] = 500_000; // licencja pilota
	return 1; 
}
//end