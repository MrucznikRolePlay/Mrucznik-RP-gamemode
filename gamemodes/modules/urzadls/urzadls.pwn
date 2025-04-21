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
	Automatyzacja Urz�du Miasta w Los Santos - boty, skrypt bot�w, prawa jazdy [..] .
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
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1445.2811,-1801.1071,77.9612)
	// Vice City
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2977, 186.2629, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2976, 182.4774, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2930, 178.5167, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2979, 168.9292, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.2966, 166.2234, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 356.3013, 163.1573, 1008.3762)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE+1, 359.7069, 173.6590, 1008.3893)
	// Palomino Creek
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 2315.3906,-84.2390,39.2946)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 2315.3916,-80.2855,39.2946))
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
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycj�, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string); 
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				if(freePlace < 8) SetDynamicActorVirtualWorld(actorUID[i], 50);
				else if(freePlace < 15) SetDynamicActorVirtualWorld(actorUID[i], 7110);
				else SetDynamicActorVirtualWorld(actorUID[i], 1);
				UpdateActorText(actorUID[i]);
				if(freePlace < 8) format(string, sizeof(string), "Urz�d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace+1);
				else if(freePlace < 15) format(string, sizeof(string), "Urz�d Miasta Vice City\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace-7);
				else format(string, sizeof(string), "Urz�d Miasta Palomino Creek\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace-14);
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
		format(string, sizeof(string), "|____________Urz�d Miasta otwarty przez system_____________|");
		SendClientMessageToAll(COLOR_LIGHTGREEN, string);	
		return 1;
	}
	format(string, sizeof(string), "|____________Urz�d Miasta otwarty przez %s_____________|", GetNick(playerid));
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
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycj�, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string);
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				SetDynamicActorVirtualWorld(actorUID[i], 50); 
				UpdateActorText(actorUID[i]);
				if(freePlace < 8) format(string, sizeof(string), "Urz�d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}Zamkni�te!", freePlace+1);
				else if(freePlace < 15) format(string, sizeof(string), "Urz�d Miasta Vice City\n{0080FF}Okienko %d \n {FF0000}Zamkni�te!", freePlace-7);
				else format(string, sizeof(string), "Urz�d Miasta Palomino Creek\n{0080FF}Okienko %d \n {FF0000}Zamkni�te!", freePlace-14);
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

	format(string, sizeof(string), "|____________Urz�d Miasta zamkni�ty przez %s_____________|", GetNick(playerid));
	SendClientMessageToAll(COLOR_LIGHTGREEN, string);
	return 1;
}

DefaultItems_LicenseCost()
{
	DmvLicenseCost[0] = 5_000; // dow�d
	DmvLicenseCost[1] = 10_000; // karta w�dkarsaka
	DmvLicenseCost[2] = 50_000; // pozwolenie na bro�
	DmvLicenseCost[3] = 100_000; // patent �eglarski
	DmvLicenseCost[4] = 5_000; // prawo jazdy - teoria
	DmvLicenseCost[5] = 7_500; // prawo jazdy - praktyka
	DmvLicenseCost[6] = 5_000; // prawo jazdy - odbi�r
	DmvLicenseCost[7] = 500_000; // licencja pilota
	return 1; 
}
//end