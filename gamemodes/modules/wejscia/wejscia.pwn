//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  wejscia                                                  //
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
// Autor: Mrucznik & Simeone
// Data utworzenia: 04.05.2019
//Opis:
/*
	System wej��/wyj�� oraz wjazd�w/wyjazd�w do interior�w/lokacji.
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
DodajWejscieNoPickup(Float:fx1, Float:fy1, Float:fz1, vw1=0, int1=0, Float:fx2, Float:fy2, Float:fz2, vw2=0, int2=0, wejdzUID=0, playerLocal=255)
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
	return iloscwejsc++;
}

DodajWejscie(Float:fx1, Float:fy1, Float:fz1, Float:fx2, Float:fy2, Float:fz2, vw1=0, int1=0, vw2=0, int2=0, nazwain[]="", nazwaout[]="", wejdzUID=0, playerLocal=255, bool:specialCome=false, outPickup=1239, inPickup=1239)
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
	if(specialCome)
	{
		wejscia[iloscwejsc][w_specCome] = 1.3;
	}
	if(isnull(nazwain)) 
	{
		CreateDynamicPickup(inPickup, 2, fx1, fy1, fz1, vw1, int1);
	}
	else  
	{
		new Float:range = (int1 == 0 && vw1 == 0) ? EXTERIOR_3DTEXT_RANGE : INTERIOR_3DTEXT_RANGE;
		CreateDynamic3DTextLabel(nazwain, COLOR_BROWN, fx1, fy1, fz1, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw1, int1);
	}
	if(isnull(nazwaout)) 
	{
		CreateDynamicPickup(outPickup, 2, fx1, fy1, fz1, vw2, int2);
	}
	else 
	{
		new Float:range = ((int2 == 0 && vw2 == 0) ? (EXTERIOR_3DTEXT_RANGE) : (INTERIOR_3DTEXT_RANGE));
		CreateDynamic3DTextLabel(nazwaout, COLOR_BROWN, fx2, fy2, fz2, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw2, int2);
	}
	
	return iloscwejsc++;
}
Sprawdz_w_cord(playerid, id)
{
	new playerPos;//0 - nigdzie, 1 - na /wejdz, 2 - na /wyjdz
	if(wejscia[id][w_specCome] > 0.5)
	{
		if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw1]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int1]
		&& IsPlayerInRangeOfPoint(playerid, wejscia[id][w_specCome], wejscia[id][w_x1],wejscia[id][w_y1],wejscia[id][w_z1]))
		{
			playerPos = OUT_INTERIOR; 
		}
		else if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw2]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int2]
		&& IsPlayerInRangeOfPoint(playerid, wejscia[id][w_specCome], wejscia[id][w_x2],wejscia[id][w_y2],wejscia[id][w_z2]))
		{
			playerPos = IN_INTERIOR; 
		}
		else
		{
			playerPos = NOT_IN_ENTER_RANGE;
		}
	}
	else 
	{
		if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw1]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int1]
		&& IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[id][w_x1],wejscia[id][w_y1],wejscia[id][w_z1]))
		{
			playerPos = OUT_INTERIOR; 
		}
		else if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw2]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int2]
		&& IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[id][w_x2],wejscia[id][w_y2],wejscia[id][w_z2]))
		{
			playerPos = IN_INTERIOR; 
		}
		else
		{
			playerPos = NOT_IN_ENTER_RANGE;
		}
	}
	return playerPos;
}
Sprawdz_UID_Wchodzenie(playerid, Check_ID)
{
	if(Check_ID == 1)
	{
		if(dmv == 1 || IsAnInstructor(playerid) || IsABOR(playerid))
		{
			if(wywalzdmv[playerid] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz�d Miasta w Los Santos Wita! <<<<");
				SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje si� zaraz za rogiem, po prawej stronie.");
				SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz si� na najwy�szym poziomie, winda znajduje si� w holu g��wnym");
				SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patent�w znajduj� si� po lewej i prawej stronie w holu pierwszym");
				SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urz�du powsta� w listopadzie 2018 roku, za inicjatyw� Satius & Arkam & Simeone]");
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> �yczymy przyjemnego czekania na licencje! <<<<");
				GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
				
				
				if(PlayerInfo[playerid][pMember] != FRAC_LSPD // Nie jest PD
				&& PlayerInfo[playerid][pMember] != FRAC_FBI // Nie jest FBI
				&& PlayerInfo[playerid][pMember] != FRAC_BOR
				&& PlayerInfo[playerid][pLider] == 0 // Nie jest liderem
				&& GetPlayerOrg(playerid) == 0)//Nie jest cz�onkiem ORG
				{
					SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
					SendClientMessage(playerid, COLOR_WHITE, "Przechodz�c przez wykrywacz metalu s�yszysz alarm.");
					SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon� tabliczk� informuj�c� o zakazie");
					SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k�opot�w, wi�c oddajesz sw�j arsena� agentowi USSS.");
					SendClientMessage(playerid, COLOR_PANICRED, "((Bro� otrzymasz po �mierci//ponownym zalogowaniu))");
					SetPVarInt(playerid, "mozeUsunacBronie", 1);
					RemovePlayerWeaponsTemporarity(playerid);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "Zosta�e� wyrzucony z Urz�du przez agent�w USSS, spr�buj p�niej.");
				SendClientMessage(playerid, COLOR_WHITE, "[Czas wyrzucenia: 10 minut]");
				noAccessCome[playerid] = 1; 
				return 1;
			}
		}
		else
		{

			SendClientMessage(playerid,COLOR_RED,"|_________________Godziny pracy Urz�du_________________|");
			SendClientMessage(playerid,COLOR_WHITE,"                   {ADFF2F}�Poniedzia�ek - Pi�tek:");
			SendClientMessage(playerid,COLOR_WHITE,"                          Od 18:00 do 19:00");
			SendClientMessage(playerid,COLOR_WHITE,"");
			SendClientMessage(playerid,COLOR_RED,"             **********************************************");
			SendClientMessage(playerid,COLOR_WHITE,"                  {DDA0DD}�Sobota- Niedziela");
			SendClientMessage(playerid,COLOR_WHITE,"                          Od 15:00 do 16:00");
			SendClientMessage(playerid,COLOR_WHITE,"");
			SendClientMessage(playerid,COLOR_RED,"|____________>>> Urz�d Miasta Los Santos <<<____________|");
			noAccessCome[playerid] =1; 
			return 1;
		}	
	}
	else if(Check_ID == 2)
	{
		SendClientMessage(playerid, -1, "Powodzenia podczas egzaminu praktycznego!"); 
		GameTextForPlayer(playerid, "~n~~r~Powodzenia", 5000, 1); 	
	}	
	else if(Check_ID == 3)
	{
		if(doorFBIStatus == 0 && GetPlayerFraction(playerid) != FRAC_FBI)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Drzwi s� zamkni�te"); 
			noAccessCome[playerid] =1; 
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Biurowiec FBI w Los Santos Wita! <<<<");
			SendClientMessage(playerid, COLOR_WHITE, "-> Recepcja znajduje si� po twojej lewej stronie");
			SendClientMessage(playerid, COLOR_WHITE, "-> Wej�cie do wi�zienia stanowego na wprost"); 
			SendClientMessage(playerid, COLOR_WHITE, "-> Winda znajduje si� za recepcj�");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Federal Bureau of Investigation <<<<");
			GameTextForPlayer(playerid, "~w~Witamy w~y~ Biurowcu ~b~FBI~n~~r~by UbunteQ & Iwan", 5000, 1);
		}
	}
	else if(Check_ID == 4)
	{
		sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Los Santos=====");
		sendTipMessage(playerid, "* Aby zarz�dza� swoim kontem wpisz /kontobankowe (/kb)");
		sendTipMessage(playerid, "* Aby zarz�dza� kontem swojej frakcji przejd� w zak�adk� ''Frakcyjne''");
		sendTipMessage(playerid, "* Sejf znajduje si� 10m pod ziemi� --> Bezpieczna lokata!");
	}
	else if(Check_ID == 5) 
	{
		sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Palomino Creek=====");
		sendTipMessage(playerid, "* Aby zarz�dza� swoim kontem wpisz /kontobankowe (/kb)");
		sendTipMessage(playerid, "* Aby zarz�dza� kontem swojej frakcji przejd� w zak�adk� ''Frakcyjne''");
		sendTipMessage(playerid, "* Sejf znajduje si�  6m pod ziemi� --> Bezpieczna lokata!");	
	}
	else if(Check_ID == 6) //bonehead club
	{
		//tutaj ewentualne link do muzyki - odkomentowa� ni�ej
		//new muzik[128];
		//PlayAudioStreamForPlayer(playerid,muzik,2447.8284,-1963.1549,13.5469,100,0);
	}
	else if(Check_ID == 7)//Wejscie do VINYL
	{
		if(vinylStatus == 0)
		{
			if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
			{
				sendErrorMessage(playerid, "Klub jest teraz zamkni�ty!"); 
				return 1;
			}
		}
		else
		{
			if(GetPVarInt(playerid, "Vinyl-bilet") == 0)
			{
				if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
				{
					sendErrorMessage(playerid, "Nie posiadasz biletu do Vinyl Club"); 
					noAccessCome[playerid] = 1; 
					return 1;
				}
			}
		}
		SetPlayerTW(playerid, 5000, 1, 6); 
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 8)
	{
		if(GetPVarInt(playerid, "Vinyl-bilet") != 2 && !IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
		{
			sendErrorMessage(playerid, "Brak dost�pu do strefy V.I.P"); 
			noAccessCome[playerid] = 1; 
			return 1;
		}
		SetPlayerTW(playerid, 5000, 1, 6); 
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 9)
	{
		if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
		{
			sendTipMessage(playerid, "Ups! Wygl�da na to, �e drzwi s� zamkni�te"); 
			noAccessCome[playerid] = 1; 
			return 1;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~Scena DJ", 5000, 1);
		}
	}
	else if(Check_ID == 10)
	{
		GameTextForPlayer(playerid, "~w~Witamy w Klubie by~n~  ~h~~g~MrN", 5000, 1);
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);	
	}
	else if(Check_ID == 11)
	{
		GameTextForPlayer(playerid, "~w~By ~r~Sergio ~w~& ~r~ Deduir", 5000, 1); 
	}
	else if(Check_ID == 13)
	{
		//WOLNE
	}
	else if(Check_ID == 14)
	{
		sendTipMessageEx(playerid, COLOR_GREEN, "======[Los Santos MMA 2]======");
		sendTipMessageEx(playerid, COLOR_P@, "Sponsorzy:");
		sendTipMessage(playerid, "San News;");
		sendTipMessageEx(playerid, COLOR_P@, "W�odarze:");
		sendTipMessage(playerid, "Beyonce Bennett"); 
		sendTipMessageEx(playerid, COLOR_P@, "Walka wieczoru:"); 
		sendTipMessage(playerid, "BRAK USTALONEJ"); 
		sendTipMessageEx(playerid, COLOR_GREEN, "===========[Fight]===========");
		GameTextForPlayer(playerid, "~w~By~n~~r~Dreptacz", 5000, 1); 
	}
	else if(Check_ID == 15)
	{
		GameTextForPlayer(playerid, "~w~By~n~~g~Dreptacz", 5000, 1); 
		sendTipMessage(playerid, "Zapraszamy na rze�!");

	}
	else if(Check_ID == 16)//Wi�zienie stanowe - wej�cie i wyj�cie
	{
		if(!IsAPolicja(playerid) && !IsABOR(playerid))
		{
			SendClientMessage(playerid, COLOR_WHITE, "Simon_Mrucznikov m�wi: Zaraz zaraz kolego! A ty gdzie? Nie mo�esz tu wej��!"); 
			noAccessCome[playerid] = 1;
			return 1;
		}
		GameTextForPlayer(playerid, "~w~by~n~Simeone & Rozalka", 5000, 1);
	}
	else if(Check_ID == 18 || Check_ID == 19) //ibiza audio
	{
		PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 21) //bar HA
	{
		GameTextForPlayer(playerid, "~w~Bar by ~p~~h~Just Miko & skBarman", 5000, 1);
		return 1;
	}
	return 0; 
}
Sprawdz_UID_Wychodzenie(playerid, Check_ID)
{
	if(Check_ID == 10)
	{
		StopAudioStreamForPlayer(playerid); 
	}
	else if(Check_ID == 6)
	{
		StopAudioStreamForPlayer(playerid);	
	}
	else if(Check_ID == 2)
	{
		if(dmv == 1 || IsAnInstructor(playerid) || IsABOR(playerid))
		{
			if(wywalzdmv[playerid] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz�d Miasta w Los Santos Wita! <<<<");
				SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje si� zaraz za rogiem, po prawej stronie.");
				SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz si� na najwy�szym poziomie, winda znajduje si� w holu g��wnym");
				SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patent�w znajduj� si� po lewej i prawej stronie w holu pierwszym");
				SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urz�du powsta� w listopadzie 2018 roku, za inicjatyw� Satius & Arkam & Simeone]");
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> �yczymy przyjemnego czekania na licencje! <<<<");
				GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
				
				
				if(PlayerInfo[playerid][pMember] != FRAC_LSPD // Nie jest PD
				&& PlayerInfo[playerid][pMember] != FRAC_FBI // Nie jest FBI
				&& PlayerInfo[playerid][pMember] != FRAC_BOR
				&& PlayerInfo[playerid][pLider] == 0 // Nie jest liderem
				&& GetPlayerOrg(playerid) == 0)//Nie jest cz�onkiem ORG
				{
					SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
					SendClientMessage(playerid, COLOR_WHITE, "Przechodz�c przez wykrywacz metalu s�yszysz alarm.");
					SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon� tabliczk� informuj�c� o zakazie");
					SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k�opot�w, wi�c oddajesz sw�j arsena� agentowi USSS.");
					SendClientMessage(playerid, COLOR_PANICRED, "((Bro� otrzymasz po �mierci//ponownym zalogowaniu))");
					SetPVarInt(playerid, "mozeUsunacBronie", 1);
					RemovePlayerWeaponsTemporarity(playerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Zosta�e� wyrzucony z urz�du!, nie pr�buj wchodzi� tylnim wej�ciem");
				noAccessCome[playerid] =1;
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Brak dost�pu do tego wej�cia"); 
			return 1;
		}
	}
	else if(Check_ID == 16)//Wi�zienie stanowe - g��wne wej�cie
	{
		if(PlayerInfo[playerid][pJailed] > 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Pavlo_Rudovy m�wi: Koleszko? Nie pomyli�o Ci si� co�? Wracaj do celi!!"); 
			noAccessCome[playerid] =1;
			return 1;
		}
		GameTextForPlayer(playerid, "~w~by~n~Simeone & Rozalka", 5000, 1);
	}
	else if(Check_ID == 18) //ibiza audio
	{
		PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 19)
	{
		StopAudioStreamForPlayer(playerid); 
	}
	return 0; 
}

SprawdzWejscia(playerid)
{
	for(new i; i<iloscwejsc; i++)
	{
		if(Sprawdz_w_cord(playerid, i) == OUT_INTERIOR)
		{
			Sprawdz_UID_Wchodzenie(playerid, wejscia[i][w_UID]);
			if(noAccessCome[playerid] == 1)
			{
				noAccessCome[playerid] = 0;
				return 1;
			}
			SetPlayerPos(playerid,  wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]);
			SetPlayerInterior(playerid, wejscia[i][w_int2]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
			PlayerInfo[playerid][pLocal] = wejscia[i][w_pLocal];
			SetInteriorTimeAndWeather(playerid);
			SetTimerEx("ActorsFix", 4000, 0, "i", playerid);
			Wchodzenie(playerid);
			return 1;
		}
		if(Sprawdz_w_cord(playerid, i) == IN_INTERIOR)
		{
			Sprawdz_UID_Wychodzenie(playerid, wejscia[i][w_UID]);
			if(noAccessCome[playerid] == 1)
			{
				noAccessCome[playerid] = 0;
				return 1;
			}
			SetPlayerPos(playerid,  wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]);
			SetPlayerInterior(playerid, wejscia[i][w_int1]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
			PlayerInfo[playerid][pLocal] = PLOCAL_DEFAULT;
			SetServerWeatherAndTime(playerid);
			SetTimerEx("ActorsFix", 4000, 0, "i", playerid);
			Wchodzenie(playerid);
			return 1;
		}
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		for(new iduo; iduo<CurrentMaxCarEntrance; iduo++)
		{
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]))//Wej�cie
			{
				if(wjazdy[iduo][pFracOwn] != 0 && wjazdy[iduo][pFracOwn] != GetPlayerFraction(playerid))
				{
					return 0;
				}
				if(wjazdy[iduo][pOrgOwn] != 0 && wjazdy[iduo][pOrgOwn] != GetPlayerOrg(playerid))
				{
					return 0;
				}
				SetPlayerInterior(playerid, wjazdy[iduo][wj_Int]);
				SetPlayerVirtualWorld(playerid, wjazdy[iduo][wj_VW]);
				SetPlayerLocal(playerid, wjazdy[iduo][wj_PLOCAL]);
				SetPlayerPos(playerid, wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]);
				return 1;
				
			}
			if(GetPlayerVirtualWorld(playerid) == wjazdy[iduo][wj_VW] && 
				GetPlayerInterior(playerid) == wjazdy[iduo][wj_VW] &&
				IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]))
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerLocal(playerid, PLOCAL_DEFAULT);
				SetPlayerPos(playerid, wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]);
			}
		
		}
	}
	return 0;
}

//-------------------
//-----[ Wjedz ]-----
//-------------------
StworzWjedz(Float:wjedzX, Float:wjedzY, Float:wjedzZ, Float:wyjedzX, Float:wyjedzY, Float:wyjedzZ, Float:RangePoint, VW, int=0, MessageIN[]=" ", MessageOut[]=" ", FracOwner=0, OrgOwner=0, local)
{
	new idx = CurrentMaxCarEntrance;
	wjazdy[idx][wj_X] = wjedzX;
	wjazdy[idx][wj_Y] = wjedzY;
	wjazdy[idx][wj_Z] = wjedzZ;
	wjazdy[idx][wy_X] = wyjedzX;
	wjazdy[idx][wy_Y] = wyjedzY;
	wjazdy[idx][wy_Z] = wyjedzZ;
	wjazdy[idx][wj_VW] = VW;
	wjazdy[idx][wj_Int] = int;
	wjazdy[idx][wj_PLOCAL] = local;
	wjazdy[idx][pFracOwn] = FracOwner;
	wjazdy[idx][pOrgOwn] = OrgOwner;
	wjazdy[idx][RangeofPoint] = RangePoint;

	if(isnull(MessageIN)) 
	{
		CreateDynamicPickup(1239, 2, wjedzX, wyjedzY, wjedzZ, 0, 0);
	}
	else  
	{
		CreateDynamic3DTextLabel(MessageIN, COLOR_RED, wjedzX, wjedzY, wjedzZ, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
	if(isnull(MessageOut)) 
	{
		CreateDynamicPickup(1239, 2, wyjedzX, wyjedzY, wyjedzZ, VW, 0);
	}
	else 
	{
		CreateDynamic3DTextLabel(MessageOut, COLOR_RED, wyjedzX, wyjedzY, wyjedzZ, 9.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, VW, 0);
	}
	
	return CurrentMaxCarEntrance++;
}
//new 
SprawdzWjazdy(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerVehicleSeat(playerid) != 0)
	{
		sendErrorMessage(playerid, "Nie jeste� kierowc�"); 
		return 1;
	}
	
	new vehicleid = GetPlayerVehicleID(playerid);
	for(new i; i<CurrentMaxCarEntrance; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wej�cie
		{
			if(wjazdy[i][pFracOwn] != 0 && wjazdy[i][pFracOwn] != GetPlayerFraction(playerid))
			{
				sendTipMessage(playerid, "Nie mo�esz tutaj wjecha�"); 
				return 0;
			}
			if(wjazdy[i][pOrgOwn] != 0 && wjazdy[i][pOrgOwn] != GetPlayerOrg(playerid))
			{
				sendTipMessage(playerid, "Nie mo�esz tutaj wjecha�"); 
				return 0;
			}

			// player
			SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
			SetPlayerInterior(playerid, wjazdy[i][wj_Int]);
			SetInteriorTimeAndWeather(playerid);
			SetPlayerLocal(playerid, wjazdy[i][wj_PLOCAL]);
			// vehicle
			SetVehicleVirtualWorld(vehicleid, wjazdy[i][wj_VW]);
			LinkVehicleToInterior(vehicleid, wjazdy[i][wj_Int]);
			defer ResetPosition(vehicleid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z], 5);

			foreach(new i2 : Player)
			{
				if(GetPlayerVehicleID(i2) == vehicleid && GetPlayerVehicleSeat(i2) != 0)
				{
					SetInteriorTimeAndWeather(i2);
					SetPlayerVirtualWorld(i2, wjazdy[i][wj_VW]);
					SetPlayerInterior(i2, wjazdy[i][wj_Int]);
					SetPlayerLocal(i2, wjazdy[i][wj_PLOCAL]);
				}
			}
			return 1;
		}
		else if(GetPlayerVirtualWorld(playerid) == wjazdy[i][wj_VW] &&
			IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//wyjcie
		{
			// player
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetInteriorTimeAndWeather(playerid);
			SetPlayerLocal(playerid, PLOCAL_DEFAULT);
			// vehicle
			SetVehicleVirtualWorld(vehicleid, 0);
			LinkVehicleToInterior(vehicleid, 0);
			defer ResetPosition(vehicleid, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z], 5);

			SetServerWeatherAndTime(playerid); 
			foreach(new i2 : Player)
			{
				if(GetPlayerVehicleID(i2) == vehicleid && GetPlayerVehicleSeat(i2) != 0)
				{
					SetServerWeatherAndTime(i2);
					SetPlayerVirtualWorld(i2, 0);
					SetPlayerInterior(i2, 0);
					SetPlayerLocal(i2, PLOCAL_DEFAULT);
				}
			}
			return 1;
		}
		
	}
	return 0;
}

timer ResetPosition[100](vehicleid, Float:x, Float:y, Float:z, times)
{
	SetVehiclePos(vehicleid, x, y, z);
	if(times > 0)
	{
		defer ResetPosition(vehicleid, x, y, z, times-1);
	}
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end