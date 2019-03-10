//MODULE_NAME.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: MODULE_NAME.pwn ]------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*JanPawe³DrugiGwa³cilMa³eDzieci

*/
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

//

//-----------------<[ Funkcje: ]>-------------------
stock DodajWejscie(Float:fx1, Float:fy1, Float:fz1, Float:fx2, Float:fy2, Float:fz2, vw1=0, int1=0, vw2=0, int2=0, nazwain[]="", nazwaout[]="", wejdzUID=0, playerLocal=255)
{
	wejscia[iloscwejsc][w_x1] = fx1;
	wejscia[iloscwejsc][w_y1] = fy1;
	wejscia[iloscwejsc][w_z1] = fz1;
	wejscia[iloscwejsc][w_x2] = fx2;
	wejscia[iloscwejsc][w_y2] = fy2;
	wejscia[iloscwejsc][w_z2] = fz2;
	wejscia[iloscwejsc][w_vw1] = vw1;
	wejscia[iloscwejsc][w_int1] = int1;
	wejscia[iloscwejsc][w_vw2] = vw2;
	wejscia[iloscwejsc][w_int2] = int2;
	wejscia[iloscwejsc][w_pLocal] = playerLocal;
	wejscia[iloscwejsc][w_UID] = wejdzUID;
	
	
	if(isnull(nazwain)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw1, int1);
	}
	else  
	{
		new Float:range = (int1 == 0 && vw1 == 0) ? EXTERIOR_3DTEXT_RANGE : INTERIOR_3DTEXT_RANGE;
		CreateDynamic3DTextLabel(nazwain, COLOR_PURPLE, fx1, fy1, fz1, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw1, int1);
	}
	if(isnull(nazwaout)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw2, int2);
	}
	else 
	{
		new Float:range = ((int2 == 0 && vw2 == 0) ? (EXTERIOR_3DTEXT_RANGE) : (INTERIOR_3DTEXT_RANGE));
		CreateDynamic3DTextLabel(nazwaout, COLOR_PURPLE, fx2, fy2, fz2, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw2, int2);
	}
	
	return iloscwejsc++;
}

stock SprawdzWejscia(playerid)
{
	for(new i; i<iloscwejsc; i++)
	{
		//WEJŒCIA NA UID:
		if(wejscia[i][w_UID] == 6)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				new muzik[128];
				GetSVarString("muzyka_bonehead", muzik, 128);
				PlayAudioStreamForPlayer(playerid,muzik,2447.8284,-1963.1549,13.5469,100,0);
				SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
				SetPlayerInterior(playerid, wejscia[i][w_int2]);
				SetPLocal(playerid, wejscia[i][pLocal]); 
				Wchodzenie(playerid);
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
				SetPlayerInterior(playerid, wejscia[i][w_int1]);
				StopAudioStreamForPlayer(playerid);
				SetPLocal(playerid, 255);
				Wchodzenie(playerid);
			}
			return 1;
		}
		if(wejscia[i][w_UID] == 4)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
				SetPlayerInterior(playerid, wejscia[i][w_int2]);
				sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Los Santos=====");
				sendTipMessage(playerid, "* Aby zarz¹dzaæ swoim kontem wpisz /kontobankowe (/kb)");
				sendTipMessage(playerid, "* Aby zarz¹dzaæ kontem swojej frakcji przejdŸ w zak³adkê ''Frakcyjne''");
				sendTipMessage(playerid, "* Sejf znajduje siê 10m pod ziemi¹ --> Bezpieczna lokata!");
				Wchodzenie(playerid);
				SetPLocal(playerid, PLOCAL_INNE_BANK); 
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
				SetPlayerInterior(playerid, wejscia[i][w_int1]);
				Wchodzenie(playerid);
				SetPLocal(playerid, 255); 
			}
			return 1;
		}
		if(wejscia[i][w_UID] == 5) 
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
				SetPlayerInterior(playerid, wejscia[i][w_int2]);
				sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Palomino Creek=====");
				sendTipMessage(playerid, "* Aby zarz¹dzaæ swoim kontem wpisz /kontobankowe (/kb)");
				sendTipMessage(playerid, "* Aby zarz¹dzaæ kontem swojej frakcji przejdŸ w zak³adkê ''Frakcyjne''");
				sendTipMessage(playerid, "* Sejf znajduje siê  6m pod ziemi¹ --> Bezpieczna lokata!");
				Wchodzenie(playerid);
				SetPLocal(playerid, PLOCAL_INNE_BANK); 
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
				SetPlayerInterior(playerid, wejscia[i][w_int1]);
				Wchodzenie(playerid);
				SetPLocal(playerid, 255); 
			}
			return 1;
		}
		if(wejscia[i][w_UID] == 3)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				if(doorFBIStatus == 0 && GetPlayerFraction(playerid) != FRAC_FBI)
				{
					SendClientMessage(playerid, COLOR_WHITE, "Drzwi s¹ zamkniête"); 
					return 1;
				}
				SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
				SetPlayerInterior(playerid, wejscia[i][w_int2]);
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Biurowiec FBI w Los Santos Wita! <<<<");
				SendClientMessage(playerid, COLOR_WHITE, "-> Recepcja znajduje siê po twojej lewej stronie");
				SendClientMessage(playerid, COLOR_WHITE, "-> Wejœcie do wiêzienia stanowego na wprost"); 
				SendClientMessage(playerid, COLOR_WHITE, "-> Winda znajduje siê za recepcj¹");
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Federal Bureau of Investigation <<<<");
				GameTextForPlayer(playerid, "~w~Witamy w~y~ Biurowcu ~b~FBI~n~~r~by UbunteQ & Iwan", 5000, 1);
				SetPlayerTime(playerid, CzaswIntku[FRAC_FBI], 0);				
				Wchodzenie(playerid);
				SetPLocal(playerid, PLOCAL_FRAC_FBI); 
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
				SetPlayerInterior(playerid, wejscia[i][w_int1]);
				GameTextForPlayer(playerid, "~w~Miasto ~g~Los Santos", 5000, 1); 
				Wchodzenie(playerid);
				SetPLocal(playerid, PLOCAL_DEFAULT);
			}
		
			return 1;
		}
		if(wejscia[i][w_UID] == 2)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]); 
				SendClientMessage(playerid, -1, "Powodzenia podczas egzaminu praktycznego!"); 
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
				SetPlayerInterior(playerid, wejscia[i][w_int2]);
				GameTextForPlayer(playerid, "~n~~r~Powodzenia", 5000, 1); 
				Wchodzenie(playerid);
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				if(dmv == 1 || IsAnInstructor(playerid))
				{
					if(wywalzdmv[playerid] == 1)
					{
						SendErrorMessage(playerid, "Zosta³eœ wyrzucony z Urzêdu Miasta"); 
						return 1;
					}
					SendClientMessage(playerid, COLOR_WHITE, "Witamy ponownie"); 
					SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]);
					SetPlayerInterior(playerid, wejscia[i][w_int1]);
					SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
					SetPLocal(playerid, PLOCAL_FRAC_DMV);
					GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
					SetPlayerTime(playerid, CzaswIntku[FRAC_GOV], 0);
					Wchodzenie(playerid);
					if(PlayerInfo[playerid][pMember] != FRAC_LSPD // Nie jest PD
					&& PlayerInfo[playerid][pMember] != FRAC_FBI // Nie jest FBI
					&& PlayerInfo[playerid][pMember] != FRAC_BOR
					&& PlayerInfo[playerid][pLider] == 0 // Nie jest liderem
					&& GetPlayerOrg(playerid) == 0)//Nie jest cz³onkiem ORG
					{
						SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
						SendClientMessage(playerid, COLOR_WHITE, "Przechodz¹c przez wykrywacz metalu s³yszysz alarm.");
						SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon¹ tabliczkê informuj¹c¹ o zakazie");
						SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k³opotów, wiêc oddajesz swój arsena³ agentowi USSS.");
						SendClientMessage(playerid, COLOR_PANICRED, "((Broñ otrzymasz po œmierci//ponownym zalogowaniu))");
						SetPVarInt(playerid, "mozeUsunacBronie", 1);
						ResetPlayerWeapons(playerid);
					}
				}
				else
				{
					
					SendClientMessage(playerid,COLOR_RED,"|_________________Godziny pracy Urzêdu_________________|");
					SendClientMessage(playerid,COLOR_WHITE,"                   {ADFF2F}§Poniedzia³ek - Pi¹tek:");
					SendClientMessage(playerid,COLOR_WHITE,"                          Od 18:00 do 19:00");
					SendClientMessage(playerid,COLOR_WHITE,"");
					SendClientMessage(playerid,COLOR_RED,"             **********************************************");
					SendClientMessage(playerid,COLOR_WHITE,"                  {DDA0DD}§Sobota- Niedziela");
					SendClientMessage(playerid,COLOR_WHITE,"                          Od 15:00 do 16:00");
					SendClientMessage(playerid,COLOR_WHITE,"");
					SendClientMessage(playerid,COLOR_RED,"|____________>>> Urz¹d Miasta Los Santos <<<____________|");
				}
			
			}
			return 1;
		}	
		if(wejscia[i][w_UID] == 1)//DMV
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw1])
			{
				if(dmv == 1 || IsAnInstructor(playerid) || IsABOR(playerid))
				{
					if(wywalzdmv[playerid] == 0)
					{
						SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz¹d Miasta w Los Santos Wita! <<<<");
						SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje siê zaraz za rogiem, po prawej stronie.");
						SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz siê na najwy¿szym poziomie, winda znajduje siê w holu g³ównym");
						SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patentów znajduj¹ siê po lewej i prawej stronie w holu pierwszym");
						SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urzêdu powsta³ w listopadzie 2018 roku, za inicjatyw¹ Satius & Arkam & Simeone]");
						SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> ¯yczymy przyjemnego czekania na licencje! <<<<");
						SetPlayerPosEx(playerid, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]);
						SetPlayerInterior(playerid, wejscia[i][w_int2]);
						SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
						SetPlayerTime(playerid, CzaswIntku[FRAC_GOV], 0);
						PlayerInfo[playerid][pLocal] = wejscia[i][w_pLocal];
						GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
						Wchodzenie(playerid);
						
						
						if(PlayerInfo[playerid][pMember] != FRAC_LSPD // Nie jest PD
						&& PlayerInfo[playerid][pMember] != FRAC_FBI // Nie jest FBI
						&& PlayerInfo[playerid][pMember] != FRAC_BOR
						&& PlayerInfo[playerid][pLider] == 0 // Nie jest liderem
						&& GetPlayerOrg(playerid) == 0)//Nie jest cz³onkiem ORG
						{
							SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
							SendClientMessage(playerid, COLOR_WHITE, "Przechodz¹c przez wykrywacz metalu s³yszysz alarm.");
							SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon¹ tabliczkê informuj¹c¹ o zakazie");
							SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k³opotów, wiêc oddajesz swój arsena³ agentowi USSS.");
							SendClientMessage(playerid, COLOR_PANICRED, "((Broñ otrzymasz po œmierci//ponownym zalogowaniu))");
							SetPVarInt(playerid, "mozeUsunacBronie", 1);
							ResetPlayerWeapons(playerid);
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, "Zosta³eœ wyrzucony z Urzêdu przez agentów USSS, spróbuj póŸniej.");
						SendClientMessage(playerid, COLOR_WHITE, "[Czas wyrzucenia: 10 minut]");
						return 1;
					}
				}
				else
				{

					SendClientMessage(playerid,COLOR_RED,"|_________________Godziny pracy Urzêdu_________________|");
					SendClientMessage(playerid,COLOR_WHITE,"                   {ADFF2F}§Poniedzia³ek - Pi¹tek:");
					SendClientMessage(playerid,COLOR_WHITE,"                          Od 18:00 do 19:00");
					SendClientMessage(playerid,COLOR_WHITE,"");
					SendClientMessage(playerid,COLOR_RED,"             **********************************************");
					SendClientMessage(playerid,COLOR_WHITE,"                  {DDA0DD}§Sobota- Niedziela");
					SendClientMessage(playerid,COLOR_WHITE,"                          Od 15:00 do 16:00");
					SendClientMessage(playerid,COLOR_WHITE,"");
					SendClientMessage(playerid,COLOR_RED,"|____________>>> Urz¹d Miasta Los Santos <<<____________|");
					return 1;
				}	
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[i][w_x2], wejscia[i][w_y2], wejscia[i][w_z2]) && GetPlayerVirtualWorld(playerid) ==  wejscia[i][w_vw2])
			{
				SetPlayerPosEx(playerid, wejscia[i][w_x1], wejscia[i][w_y1], wejscia[i][w_z1]);
				SetPlayerInterior(playerid, wejscia[i][w_int1]);
				SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
				PlayerInfo[playerid][pLocal] = 255;
				Wchodzenie(playerid);
			}
			return 1;
		}
		
		
		
		//WYKONANIE RESZTY
		if(GetPlayerInterior(playerid) == wejscia[i][w_int1] && GetPlayerVirtualWorld(playerid) == wejscia[i][w_vw1] && IsPlayerInRangeOfPoint(playerid, 2.0, wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]))
		{
			SetPlayerPosEx(playerid,  wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]);
			SetPlayerInterior(playerid, wejscia[i][w_int2]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
			PlayerInfo[playerid][pLocal] = wejscia[i][w_pLocal];
			Wchodzenie(playerid);
			return 1;
		}
		else if(GetPlayerInterior(playerid) == wejscia[i][w_int2] && GetPlayerVirtualWorld(playerid) == wejscia[i][w_vw2] && IsPlayerInRangeOfPoint(playerid, 2.0, wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]))
		{
			SetPlayerPosEx(playerid,  wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]);
			SetPlayerInterior(playerid, wejscia[i][w_int1]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
			PlayerInfo[playerid][pLocal] = 255;
			Wchodzenie(playerid);
			return 1;
		}
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		for(new iduo; iduo<valueWjedz; iduo++)
		{
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]))//Wejœcie
			{
				if(wjazdy[iduo][pFracOwn] == 0 && wjazdy[iduo][pOrgOwn] == 0)
				{
					SetPlayerVirtualWorld(playerid, wjazdy[iduo][wj_VW]);
					SetPLocal(playerid, wjazdy[iduo][wj_PLOCAL]);
					SetPlayerPos(playerid, wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]);
					return 1;
				}
				if(wjazdy[iduo][pFracOwn] > 0 || wjazdy[iduo][pOrgOwn] > 0)
				{
					if(GetPlayerFraction(playerid) == wjazdy[iduo][pFracOwn] || GetPlayerOrg(playerid) == wjazdy[iduo][pOrgOwn])
					{
						SetPlayerVirtualWorld(playerid, wjazdy[iduo][wj_VW]);
						SetPLocal(playerid, wjazdy[iduo][wj_PLOCAL]);
						SetPlayerPos(playerid, wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]);
					}
				}
				
			}
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]))
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPLocal(playerid, PLOCAL_DEFAULT);
				SetPlayerPos(playerid, wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]);
			}
		
		}
	}
	return 0;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end