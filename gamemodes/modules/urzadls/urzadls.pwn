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
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9729,-1800.9788,77.9453))
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
			if(freePlace < 8)
			{
				//SetActorPos(actorUID[i], okienkoPos[freePlace][0], okienkoPos[freePlace][1], okienkoPos[freePlace][2]);
				SetDynamicActorPos(actorUID[i], okienkoPos[freePlace][0], okienkoPos[freePlace][1], okienkoPos[freePlace][2]);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycjê, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string); 
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				SetDynamicActorVirtualWorld(actorUID[i], 50); 
				UpdateActorText(actorUID[i]);
				format(string, sizeof(string), "Urz¹d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}[Wpisz /kuplicencje]", freePlace+1);
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
			if(freePlace < 8)
			{
				SetDynamicActorPos(actorUID[i], okienkoPos[freePlace][0], okienkoPos[freePlace][1], okienkoPos[freePlace][2]+10);
				if(playerid != INVALID_PLAYER_ID)
				{
					format(string,sizeof(string), "Ustawiono aktorowi [%d] pozycjê, wzrok i VW", actorUID[i]);
					sendTipMessage(playerid, string);
				}
				SetDynamicActorFacingAngle(actorUID[i], okienkoPos[freePlace][3]);
				SetDynamicActorVirtualWorld(actorUID[i], 50); 
				UpdateActorText(actorUID[i]);
				format(string, sizeof(string), "Urz¹d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}Zamkniête!", freePlace+1);
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
	DmvLicenseCost[0] = 5000;
	DmvLicenseCost[1] = 10000;
	DmvLicenseCost[2] = 500000;
	DmvLicenseCost[3] = 350000;
	DmvLicenseCost[4] = 10000;
	DmvLicenseCost[5] = 15000;
	DmvLicenseCost[6] = 20000;
	DmvLicenseCost[7] = 5000000;
	DmvLicenseCost[8] = 10000;
	DmvLicenseCost[9] = 350000;
	return 1; 
}
//end