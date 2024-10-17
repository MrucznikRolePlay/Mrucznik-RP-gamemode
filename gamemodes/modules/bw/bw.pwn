//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    bw                                                     //
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
//Opis:
/*
	Zawiera system rannego i BW.
*/
// Autor: Creative
// Data utworzenia: 19.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
BW_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused listitem, inputtext
	if(dialogid == DIALOG_ID_KILL)
	{
		if(response) 
		{
			command_kill_accept(playerid);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

BW_OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused reason
	new string[MAX_MESSAGE_LENGTH];

	// koniec wywiadu
	if(TalkingLive[playerid] != INVALID_PLAYER_ID)
	{
		SendPlayerMessageToAll(COLOR_NEWS, "NEWS: Wywiad zakoñczony - nasz rozmówca zosta³ ciê¿ko ranny i przewieziony do szpitala!");
		new talker = TalkingLive[playerid];
		TalkingLive[playerid] = INVALID_PLAYER_ID;
		TalkingLive[talker] = INVALID_PLAYER_ID;
	}

	// koniec rozmowy telefonicznej
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Jesteœ ranny - po³¹czenie zakoñczone.");
		if(Mobile[playerid] >= 0)
		{
			SendClientMessage(Mobile[playerid], COLOR_YELLOW, "S³ychaæ nag³y trzask i po³¹czenie zostaje zakoñczone.");
		}
		StopACall(playerid);
	}

	// œmieræ podczas wyœcigu
	if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
	{
		format(string, sizeof(string), "Wyœcig: {FFFFFF}%s zgin¹³ jak prawdziwy œcigant [*]", GetNickEx(playerid));
		WyscigMessage(COLOR_YELLOW, string);
		IloscZawodnikow --;
		if(IloscZawodnikow <= Ukonczyl)
		{
			KoniecWyscigu(-1);
		}
	}

	// gracz obroni³ siê przed ³owc¹ nagród
	if(lowcaz[playerid] == killerid)
	{
		lowcaz[playerid] = 501;
		SendClientMessage(playerid, COLOR_YELLOW, "Zlecenie zosta³o anulowane - nie mo¿esz wzi¹æ teraz zlecenia na tego samego gracza!");
	}

	// boost narkotykowy
	if(GetPVarInt(playerid, "ZjadlDragi") == 1)
	{
		new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
		SetPVarInt(playerid, "ZjadlDragi", 0);
		sendTipMessage(playerid, "Z powodu œmierci twój boost (dragów) zosta³ wy³¹czony, za¿yj kolejn¹ dawkê!"); 
		KillTimer(TimerEfektNarkotyku[playerid]);
		SetStrong(playerid, FirstValue);
	}

	// gdy osoba z workiem trafi do szpitala
	if(Worek_MamWorek[playerid] != 0) 
	{
		Worek_MamWorek[playerid] = 0;
		Worek_KomuZalozylem[Worek_KtoZalozyl[playerid]] = INVALID_PLAYER_ID;
		Worek_Uzyty[Worek_KtoZalozyl[playerid]] = 0;
		Worek_KtoZalozyl[playerid] = INVALID_PLAYER_ID;
		UnHave_Worek(playerid);
	}
	
	// gdy osoba nadajaca worek trafi do szpitala
	if(Worek_Uzyty[playerid] != 0)
	{
		Worek_MamWorek[Worek_KomuZalozylem[playerid]] = 0;
		Worek_KtoZalozyl[Worek_KomuZalozylem[playerid]] = INVALID_PLAYER_ID;
		UnHave_Worek(Worek_KomuZalozylem[playerid]);
		Worek_Uzyty[playerid] = 0;
		Worek_KomuZalozylem[playerid] = INVALID_PLAYER_ID;
	}

	if(GetPVarInt(playerid, "kill-bw") == 1)
	{
		if(!IsPlayerConnected(killerid))
		{
			killerid = GetPVarInt(playerid, "bw-killerid");
		}
	}
	ZespawnujGraczaSzpitalBW(playerid, IsPlayerAtViceCity(playerid));

	if(IsPlayerConnected(killerid))
	{
		PlayerInfo[killerid][pKills] ++;

		// daj wanted level mordercy
		if(giveWL)
		{
			if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid )
			{
				NadajWLBW(killerid, playerid, true);
			}
		}

		// œmieræ z kontraktem
		if(PlayerInfo[playerid][pHeadValue] > 0)
		{
			if(PlayerInfo[killerid][pMember] == 8 || PlayerInfo[killerid][pLider] == 8)
			{
				if(GoChase[killerid] == playerid)
				{
					//jeœli zabity mia³ kajdanki
					if(isPlayerCuffed[playerid])
					{
						format(string, sizeof(string), "* Wiêzieñ %s zosta³ zastrzelony przez Hitmana (MK). Nastêpnym razem zadbaj o bezpieczeñstwo swojego wiêŸnia *", GetNick(playerid));
						SendClientMessage(whoIsCuffing[playerid], COLOR_LIGHTRED, string);
						UncuffPlayer(playerid);
					}

					SetPVarInt(playerid, "bw-hitmankiller",  1);
					SetPVarInt(playerid, "bw-killerid",  killerid);
					return NadajBW(playerid, BW_TIME_CRIMINAL);
				}
			}
		}

		// zeruj WL dla frakcji porz¹dkowych
		if(IsAPolicja(playerid) && OnDuty[playerid] == 1)
		{
			PoziomPoszukiwania[playerid] = 0;
		}

		// œmieræ przestêpcy
		if(PoziomPoszukiwania[playerid] >= 1)
		{
			// œmieræ z r¹k ³owcy nagród
			new bool:killedByBountyHunter = false;
			if(PlayerInfo[killerid][pJob] == 1)
			{
				if(lowcaz[killerid] == playerid)
				{
					new reward = PoziomPoszukiwania[playerid] * 5000;
					lowcaz[killerid] = 501;
					format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", reward);
					GameTextForPlayer(killerid, string, 5000, 1);
					PoziomPoszukiwania[killerid] = 0;
					ClearCrime(killerid);
					DajKase(killerid, reward);
					PlayerPlaySound(killerid, 1058, 0.0, 0.0, 0.0);
					PlayerInfo[killerid][pDetSkill] += 2;
					SendClientMessage(killerid, COLOR_GRAD2, "Skill + 2");
					killedByBountyHunter = true;
				}
			}

			// jeœli gracz otrzyma³ obrazenia od porz¹dkowych - wsadŸ do paki
			if(IsPlayerDamagedByCop(playerid) || killedByBountyHunter || GetPVarInt(playerid, "kill-bw") == 1)
			{
				PutDeadPlayerInJail(playerid);
				return 1; //zrespawnuj gracza w wiêzieniu
			}
		}

		// œmieræ na strefie biznesu
		new bizId = IsPlayerAtFrontBusinnesZone(playerid);
		if(bizId != -1)
		{
			if(FrontBusiness[bizId][TakeoverActive])
			{
				new redisKey[64];
				format(redisKey, sizeof(redisKey), "player:%d:restricted-area", PlayerInfo[playerid][pUID]);
				Redis_SetInt(RedisClient, redisKey, bizId);
				RedisExpire(redisKey, 3600);

				// œmieræ podczas przejmowania biznesu - 15jmin BW
				MruMessageBadInfo(playerid, "Zosta³eœ zabity na strefie biznesu podczas jego przejmowania - otrzymujesz d³u¿sze BW.");
				return NadajBW(playerid, 60 * 15);
			}
			if(IsPlayerConnected(killerid) && GetPlayerOrg(killerid) == FrontBusiness[bizId][Owner])
			{
				// œmieræ z rêki w³aœciciela biznesu - 10 min BW
				MruMessageBadInfo(playerid, "Zosta³eœ zabity na strefie biznesu przez cz³onka organizacji, która go kontroluje - dostajesz d³u¿sze BW.");
				return NadajBW(playerid, 60 * 10);
			}
		}

		// œmieræ z r¹k przestêpcy
		if(IsAPrzestepca(killerid)) 
		{
			return NadajBW(playerid, BW_TIME_CRIMINAL);
		}

		// œmieræ z r¹k gracza
		if(PlayerInfo[killerid][pLevel] >= 3 || (IsAPolicja(killerid) && OnDuty[killerid] == 1)) 
		{
			return NadajBW(playerid);
		}
	}
	else // œmieræ z niczyjej rêki
	{
		// jeœli gracz otrzyma³ obrazenia od porz¹dkowych - wsadŸ do paki
		if(PoziomPoszukiwania[playerid] >= 1 && IsPlayerDamagedByCop(playerid))
		{
			PutDeadPlayerInJail(playerid);
			return 1; //zrespawnuj gracza w wiêzieniu
		}
	}
	return 1;
}

BW_OnPlayerInjured(playerid, killerid, reason)
{
	new string[MAX_MESSAGE_LENGTH];

	// przywróæ BW jeœli gracz zgin¹³ podczas BW
	if(PlayerInfo[playerid][pBW] > 0)
	{
		return NadajBW(playerid, PlayerInfo[playerid][pBW], false);
	}

	// odkuj skutego gdy skuwaj¹cy dostanie rannego
	if(isPlayerUsingCuffs[playerid])
	{
		UncuffPlayerCuffedBy(playerid);
	}

	if(IsPlayerConnected(killerid))
	{
		SetPVarInt(playerid, "bw-killerid",  killerid);

		if(giveWL)
		{
			if(!IsAPolicja(killerid) && lowcaz[killerid] != playerid)
			{
				NadajWLBW(killerid, playerid, false);
			}
		}

		if(PlayerInfo[playerid][pHeadValue] > 0) //hitmani musz¹ dobiæ, ¿eby zaliczy³o kontrakt
		{
			if(PlayerInfo[killerid][pMember] == 8 || PlayerInfo[killerid][pLider] == 8)
			{
				if(GoChase[killerid] == playerid)
				{
					format(string, sizeof(string), "* Dobij %s, ¿eby wype³niæ kontrakt *", GetNick(playerid));
					SendClientMessage(killerid, COLOR_LIGHTRED, string);
				}
			}
		}

		SetPVarInt(playerid, "bw-reason", reason);
		if(PlayerInfo[killerid][pLevel] >= 3 || IsAPrzestepca(killerid) || (IsAPolicja(killerid) && OnDuty[killerid] == 1))
		{
			return NadajRanny(playerid, 0, true);
		}
		return NadajRanny(playerid, INJURY_TIME_EXCEPTION, true);
	}
	return 1;
}

PutDeadPlayerInJail(playerid)
{
	new string[MAX_MESSAGE_LENGTH];
	// typ celi w jakim przestêpca bêdzie siedzieæ
	new jailType, jailName[16];
	if(PoziomPoszukiwania[playerid] < 6)
	{
		jailType = 1; // zwyk³a cela
		WantLawyer[playerid] = 1;
		strcat(jailName, "wiêzieniu");
	}
	else
	{
		jailType = 2; // demorgan
		strcat(jailName, "DeMorgan");
	}

	// co siê dzieje z przestêpc¹ po œmierci
	new jailFine = (4000)*(PoziomPoszukiwania[playerid]);
	ZabierzKase(playerid, jailFine);//moneycheat
	PlayerInfo[playerid][pWantedDeaths] += 1;
	PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(400);
	PoziomPoszukiwania[playerid] = 0;
	SetPlayerWantedLevel(playerid, 0);
	poscig[playerid] = 0;
	UsunBron(playerid);

	PlayerInfo[playerid][pJailed] = jailType;
	format(string, sizeof(string), "* Jesteœ w %s na %d Sekund i straci³eœ $%d gdy¿ ucieka³eœ lub strzela³eœ do funkcjonariusza policji.", jailName, PlayerInfo[playerid][pJailTime], jailFine);
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Je¿eli nie chcesz aby taka sytuacja powtórzy³a siê w przysz³oœci, skorzystaj z us³ug prawnika który zbije twój WL.");
}

//-----------------<[ Funkcje: ]>-------------------
stock IsPlayerAimingEx(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

stock IsPlayerDamagedByCop(playerid)
{
	new damagedTimestamp = GetPVarInt(playerid, "damaged_by_cop");
	if(damagedTimestamp == 0)
	{
		return false;
	}
	new threshold = 600;
	new now = gettime();
	new damagedByCop = now - damagedTimestamp >= threshold;
	return damagedByCop;
}

InfoMedicsInjury(injureplayer, bool:injury, bool:bw)
{
	new string[144], string2[144], pZone[MAX_ZONE_NAME], type[144], reason;
	GetPlayer2DZone(injureplayer, pZone, MAX_ZONE_NAME);
	reason = GetPVarInt(injureplayer,"bw-reason");
	if(reason <= 54 && reason > 0)
	{
		if(reason > 46 && ((reason-46) == 7 || (reason-46) == 8))
		{
			format(type, sizeof(type), "Œmiertelnie ranny");
		}
		else
		{
			format(type, sizeof(type), (bw ? "Nieprzytomny" : "Ranny"));
		}
	}
	else
	{
		format(type, sizeof(type), (bw ? "Nieprzytomny" : "Ranny"));
	}

	if(injury)
	{
		format(string2, sizeof(string2), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}w okolicach %s", type, pZone);
	}
	else if(bw)
	{
		format(string2, sizeof(string2), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}pacjent w salach pooperacyjnych", type);
	}

	if(reason <= 54 && reason > 0)
	{
		format(string, sizeof(string), "%s z urazami od %s", string2, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
	}
	else
	{
		string = string2;
	}
	//SendClientMessageToAll(COLOR_GRAD2, "#1 Wysy³am komunikat do ERS");
	SendTeamMessageOnDuty(4, COLOR_ALLDEPT, string, true);
	return 1;
}
NadajRanny(playerid, customtime = 0, bool:medicinformation = true)
{
	new reason = GetPVarInt(playerid,"bw-reason");
	if(reason <= 54 && reason > 0)
	{
		if(reason > 46 && ((reason-46) == 7 || (reason-46) == 8)) return NadajBW(playerid); //upadek lub zatoniecie
	}
	new Float:faceangle, interior, vw;
	interior = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	GetPlayerFacingAngle(playerid, faceangle);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); 
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", vw);
	SetPVarInt(playerid, "bw-int", interior);
	SetPVarFloat(playerid, "bw-faceangle", faceangle);
	//SendClientMessageToAll(COLOR_GRAD2, "#2: NadajRanny");
	if(!customtime) customtime = INJURY_TIME;
	PlayerInfo[playerid][pBW] = 0;
	PlayerInfo[playerid][pInjury] = customtime;
	if(!GetPVarInt(playerid, "timer_DamagedHP")) SetPVarInt(playerid, "timer_DamagedHP", SetTimerEx("DamagedHP", (customtime * 1000), false, "i", playerid));
	SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 70.0, (customtime * 1000));
	if(medicinformation)
	{
		if((vw == 0 || vw == 90) && interior == 0) InfoMedicsInjury(playerid, true, false);
	}
	return 1;
}

NadajBW(playerid, customtime = 0, bool:medicinformation = true)
{
	new string[144];
	if(GetPVarInt(playerid, "bw-hitmankiller") == 1)
	{
		new killerid = GetPVarInt(playerid, "bw-killerid");
		if(IsPlayerConnected(killerid))
		{
			DajKase(killerid, PlayerInfo[playerid][pHeadValue]);
			format(string,sizeof(string),"<< Hitman %s wype³ni³ kontrakt na: %s i zarobi³ $%d >>",GetNick(killerid),GetNick(playerid),PlayerInfo[playerid][pHeadValue]);
			SendFamilyMessage(8, COLOR_YELLOW, string);
			format(string,sizeof(string),"NR Marcepan_Marks: Szok! Zamach na ¿ycie %s. Zosta³ on ciê¿ko ranny i przewieziony do szpitala.",GetNick(playerid));
			SendClientMessageToAll(COLOR_NEWS, string);
			Log(payLog, INFO, "Hitman %s zabi³ %s i zarobi³ %d$", GetPlayerLogName(killerid), GetPlayerLogName(playerid), PlayerInfo[playerid][pHeadValue]);
			PlayerInfo[playerid][pHeadValue] = 0;
			GotHit[playerid] = 0;
			GetChased[playerid] = 999;
			GoChase[killerid] = 999;
			DeletePVar(playerid, "bw-hitmankiller");
			DeletePVar(playerid, "bw-killerid");
			customtime = BW_TIME_CRIMINAL;

			new redisKey[40];
			format(redisKey, sizeof(redisKey), "player:%d:contracts-done", PlayerInfo[killerid][pUID]);
			RedisIncrBy(redisKey, 1);
			RedisExpire(redisKey);
		}
	}
	new Float:faceangle, interior, vw;
	interior = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	GetPlayerFacingAngle(playerid, faceangle);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); 
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", vw);
	SetPVarInt(playerid, "bw-int", interior);
	SetPVarFloat(playerid, "bw-faceangle", faceangle);
	//SendClientMessageToAll(COLOR_GRAD2, "#2-2: NadajBW");
	if(!customtime) customtime = BW_TIME;
	PlayerInfo[playerid][pInjury] = 0;
	PlayerInfo[playerid][pBW] = customtime;
	if(GetPVarInt(playerid, "timer_DamagedHP"))
	{
		KillTimer(GetPVarInt(playerid, "timer_DamagedHP"));
		DeletePVar(playerid, "timer_DamagedHP");
		DamagedHP(playerid);
	}
	SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 70.0, (customtime * 1000));
	if(medicinformation)
	{
		if((vw == 0 || vw == 90) && interior == 0) InfoMedicsInjury(playerid, false, true);
	}
	return 1;
}

FreezePlayerOnInjury(playerid)
{
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 1, 0, 1); 
	SetTimerEx("FreezePlayer", 1500, false, "i", playerid);
	return 1;
}

PlayerEnterVehOnInjury(playerid)
{
	Player_RemoveFromVeh(playerid);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz wsi¹œæ do pojazdu.");
	return 1;
}

PlayerChangeWeaponOnInjury(playerid)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#5: PlayerChangeWeaponOnInjury");
	SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	return 1;
}

ZespawnujGraczaBW(playerid)
{
	Wchodzenie(playerid);
	new string[256], type[144];
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "bw-faceangle"));
	SetCameraBehindPlayer(playerid);
	format(type, sizeof(type), (PlayerInfo[playerid][pBW] > 0 ? "nieprzytomny" : "ranny"));
	format(string, sizeof(string), "{FF542E}Jesteœ %s! {FFFFFF}Mo¿esz wezwaæ pomoc (/wezwij medyk, /dzwon 911) lub poczekaæ %d sekund.", type, (PlayerInfo[playerid][pBW] > 0 ? PlayerInfo[playerid][pBW] : PlayerInfo[playerid][pInjury]));
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	format(string, sizeof(string), "Gracze z apteczk¹ mog¹ udzieliæ Ci pomocy medycznej za pomoc¹ (/apteczka). Zalecamy odgrywaæ odniesione obra¿enia.");
	SendClientMessage(playerid, COLOR_WHITE, string);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 1, 0, 1); 
	SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid); 
	SetPlayerHealth(playerid, INJURY_HP);
	if(GetPVarInt(playerid, "timer_DamagedHP"))
	{
		SetPlayerAttachedObject(playerid,2,1240,17,0.587000,-0.027000,0.028000,86.100051,79.499977,-69.599990,1.000000,1.000000,1.000000); // HEALTH ICONS.
	}
	return 1;
}

//-----------------<[ Timery: ]>-------------------
RannyTimer(playerid)
{
	new string[256], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[i][pInjury] > 0)
	{
		//SendClientMessageToAll(COLOR_GRAD2, "------Timer: RannyTimer");
		if(GetPlayerState(i) != PLAYER_STATE_PASSENGER) ApplyAnimation(i, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 1, 0, 1); 
		PlayerInfo[i][pInjury]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
		GameTextForPlayer(i, string, 2500, 3);
		SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pInjury] * 1000));
		if(PlayerInfo[i][pInjury] <= 0)
		{
			PlayerInfo[i][pInjury] = 0;
			format(string, sizeof(string), "{AAF542}Obudzi³eœ siê! {FFFFFF}Twoja postaæ odnios³a obra¿enia, które zalecamy odgrywaæ.");
			//ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string); 
			SendClientMessage(playerid, COLOR_NEWS, string);
			//SendClientMessageToAll(COLOR_GRAD2, "#7: O¿ywiam gracza, nikt go nie dobi³");
			ZdejmijBW(playerid);
			/* opcjonalnie dobicie gracza i nadanie BW jesli nie uratowany - kod poni¿ej
			PlayerInfo[i][pInjury] = 999;
			SetPlayerHealth(i, 0); */
		}
	}
	return 1;
}

BWTimer(playerid)
{
	new string[128], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[playerid][pBW] > 0)
	{
		//SendClientMessageToAll(COLOR_GRAD2, "------Timer: BWTimer");
		if(GetPlayerState(i) != PLAYER_STATE_PASSENGER) ApplyAnimation(i, "CRACK", "crckidle1", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pBW]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Nieprzytomny: %d", PlayerInfo[i][pBW]);
		GameTextForPlayer(i, string, 2500, 3);
		SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pBW] * 1000));
		if(PlayerInfo[i][pBW] <= 0)
		{
			PlayerInfo[i][pBW] = 0;
			format(string, sizeof(string), "* Otrzyma³eœ rachunek w wysokoœci %d$ za hospitalizacjê.", HOSPITALIZATION_COST);
			SendClientMessage(i, COLOR_LIGHTBLUE, string);
			ZabierzKase(i, HOSPITALIZATION_COST);
			ZdejmijBW(i);
			GameTextForPlayer(i, "~n~~n~~g~~h~Obudziles sie", 5000, 5);
			format(string, sizeof(string), "{AAF542}Obudzi³eœ siê! {FFFFFF}Twoja postaæ odnios³a obra¿enia, które zalecamy odgrywaæ.");
			SendClientMessage(i, COLOR_NEWS, string);

			ShowPlayerDialogEx(playerid, 9687, DIALOG_STYLE_MSGBOX, "Spawn", "Mo¿esz wybraæ, czy chcesz zostaæ w szpitalu, czy zespawnowaæ siê na swoim spawnie.", "Szpital", "Spawn");
		}
		SetCameraBehindPlayer(i);
	}
	return 1;
}

ZespawnujGraczaSzpitalBW(playerid, viceCity=false)
{
	if(viceCity)
	{
		new randbed = random(sizeof(HospitalBedsVC));
		SetPVarInt(playerid, "bw-vw", 7110);
		SetPVarInt(playerid, "bw-int", 3);
		SetPVarFloat(playerid, "bw-faceangle", HospitalBedsVC[randbed][3]);
		PlayerInfo[playerid][pPos_x] = HospitalBedsVC[randbed][0];
		PlayerInfo[playerid][pPos_y] = HospitalBedsVC[randbed][1];
		PlayerInfo[playerid][pPos_z] = HospitalBedsVC[randbed][2];
		PlayerInfo[playerid][pMuted] = 1;
		ZespawnujGraczaBW(playerid);
		SetPlayerCameraPos(playerid,HospitalBedsVC[randbed][0] + 3, HospitalBedsVC[randbed][1], HospitalBedsVC[randbed][2]);
		SetPlayerCameraLookAt(playerid,HospitalBedsVC[randbed][0], HospitalBedsVC[randbed][1], HospitalBedsVC[randbed][2]);
		Wchodzenie(playerid);
	}
	else
	{
		new randbed = random(sizeof(HospitalBeds));
		SetPVarInt(playerid, "bw-vw", 90);
		SetPVarInt(playerid, "bw-int", 0);
		SetPVarFloat(playerid, "bw-faceangle", HospitalBeds[randbed][3]);
		PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
		PlayerInfo[playerid][pPos_x] = HospitalBeds[randbed][0];
		PlayerInfo[playerid][pPos_y] = HospitalBeds[randbed][1];
		PlayerInfo[playerid][pPos_z] = HospitalBeds[randbed][2];		
		PlayerInfo[playerid][pMuted] = 1;
		ZespawnujGraczaBW(playerid);
		SetPlayerCameraPos(playerid,HospitalBeds[randbed][0] + 3, HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
		SetPlayerCameraLookAt(playerid,HospitalBeds[randbed][0], HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
		Wchodzenie(playerid);
	}
	return 1;
}

NadajWLBW(killerid, victim, bool:bw)
{
	if(GetPlayerVirtualWorld(killerid) == 5000) return 1;
	//SendClientMessageToAll(COLOR_GRAD2, "#10: NadajWLBW");
	new string[144];
	new playerid = victim;
	format(string, sizeof(string), (bw ? "Morderstwo" : "Okaleczenie"));
	if(IsAPolicja(playerid) && OnDutyCD[playerid] != 1 && OnDuty[playerid])
	{
		PoziomPoszukiwania[killerid] += 2;
		strcat(string, " Policjanta");
	}
	if(lowcaz[killerid] == playerid)
		strcat(string, " £owcy Nagród");
	if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER || GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
		strcat(string, " z okna pojazdu");

	PlayerPlaySound(killerid, 1083, 0.0, 0.0, 0.0);
	PoziomPoszukiwania[killerid] ++;
	SetPlayerCriminal(killerid, INVALID_PLAYER_ID, string);
	if(PoziomPoszukiwania[killerid] >= 10)
	{
		sendTipMessageEx(killerid, COLOR_LIGHTRED, "Masz ju¿ 10 listów goñczych!");
		sendTipMessage(killerid, "Zaczynasz stawaæ siê coraz bardziej smakowity dla ³owców! Pilnuj siê!"); 
	}
	return 1;
}

ZdejmijBW(playerid, drunklvl = 7000)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#11: ZdejmijBW");
	new i = playerid;
	PlayerInfo[i][pBW]=0;
	PlayerInfo[i][pInjury]=0;
	PlayerInfo[i][pMuted] = 0;
	TogglePlayerControllable(i, 1);
	if(GetPVarInt(playerid, "timer_DamagedHP"))
	{
		KillTimer(GetPVarInt(playerid, "timer_DamagedHP"));
		DamagedHP(playerid);
	}
	SetPVarInt(i, "bw-sync", 0);
	ClearAnimations(i);
	SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
	SetPlayerChatBubble(playerid, "** Og³uszony **", COLOR_PANICRED, 70.0, (120 * 1000));
	// SetPlayerChatBubble(playerid, " ", 0xFF0000FF, 100.0, 1000); - lub usuwamy napis nad g³ow¹
	SetPlayerDrunkLevel(playerid, drunklvl);
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end