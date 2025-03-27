//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 antycheat                                                 //
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
// Data utworzenia: 16.09.2019
//Opis:
/*
	Anty-cheat serwera + integracje z zewnêtrznymi anty-cheatami.
*/

//

#include <YSI\y_hooks>

//------------<[ Sta³e dla Pawn.RakNet ]>------------

static const VEHICLE_DESTROYED = 136;
static const UNOCCUPIED_SYNC = 209;

//-----------------<[ Funkcje: ]>-------------------
ProcessACCode(playerid, code)
{
	if(IsPlayerNPC(playerid))
	{
		return;
	}
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	switch(nexac_additional_settings[code])
	{
		case OFF: 
		{
			//should never occur
		}
		case KICK:
		{
			SetPVarInt(playerid, "CheatDetected", 1);
			ACKickMessage(playerid, code);
			KickEx(playerid);
		}
		case INSTAKICK: //code == 50 || code == 28 || code == 27 || code == 5
		{
			ACKickMessage(playerid, code);
			Kick(playerid);
		}
		case LVL1KICK:
		{
			if(PlayerInfo[playerid][pLevel] <= 1)
			{
				SetPVarInt(playerid, "CheatDetected", 1);
				ACKickMessage(playerid, code);
				KickEx(playerid);
			}
			else
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			} 
		}
		case LVL1MARK:
		{
			if(PlayerInfo[playerid][pLevel] == 1)
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			}
		}
		case LVL1INSTAKICK:
		{
			if(PlayerInfo[playerid][pLevel] <= 1)
			{
				ACKickMessage(playerid, code);
				Kick(playerid);
			}
			else
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			} 
		}
		case ADMIN_WARNING:
		{
			SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] prawdopodobnie czituje. | %s [%d]", 
				GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
				0xFF00FFFF);
			ACWarningDelay(playerid, code);
		}
		case MARK_AS_CHEATER:
		{
			MarkPotentialCheater(playerid);
			ACWarningDelay(playerid, code);
		}
		case MARK_AND_WARNING:
		{
			SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] najprawdopodobniej czituje. | %s [%d]", 
				GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
				0xFF00FFFF);
			MarkPotentialCheater(playerid);
			ACWarningDelay(playerid, code);
		}
	}
}

NexACDecodeCode(code)
{
	new code_decoded[32];
	switch(code)
	{
		case 0:     format(code_decoded, sizeof(code_decoded), "AirBreak (pieszo)");
		case 1:     format(code_decoded, sizeof(code_decoded), "AirBreak (pojazd)");
		case 2:     format(code_decoded, sizeof(code_decoded), "TP (pieszo)");
		case 3:     format(code_decoded, sizeof(code_decoded), "TP (pojazd)");
		case 4:     format(code_decoded, sizeof(code_decoded), "TP (do/miedzy auta)");
		case 5:     format(code_decoded, sizeof(code_decoded), "TP (auto do gracza)");
		case 6:     format(code_decoded, sizeof(code_decoded), "TP (do pickupow)");
		case 7:     format(code_decoded, sizeof(code_decoded), "Fly (pieszo)");
		case 8:     format(code_decoded, sizeof(code_decoded), "Fly (pojazd)");
		case 9:     format(code_decoded, sizeof(code_decoded), "Speed (pieszo)");
		case 10:    format(code_decoded, sizeof(code_decoded), "Speed (pojazd)");
		case 11:    format(code_decoded, sizeof(code_decoded), "HP (pojazd)");
		case 12:    format(code_decoded, sizeof(code_decoded), "HP (pieszo)");
		case 13:    format(code_decoded, sizeof(code_decoded), "Kamizelka");
		case 14:    format(code_decoded, sizeof(code_decoded), "Pieniadze");
		case 15:    format(code_decoded, sizeof(code_decoded), "Bronie");
		case 16:    format(code_decoded, sizeof(code_decoded), "Dodawanie ammo");
		case 17:    format(code_decoded, sizeof(code_decoded), "Nieskonczonosc ammo");
		case 18:    format(code_decoded, sizeof(code_decoded), "AnimHack");
		case 19:    format(code_decoded, sizeof(code_decoded), "GodMode (pieszo)");
		case 20:    format(code_decoded, sizeof(code_decoded), "GodMode (pojazd)");
		case 21:    format(code_decoded, sizeof(code_decoded), "Niewidzialnosc");
		case 22:  format(code_decoded, sizeof(code_decoded), "Lagcomp");
		case 23:    format(code_decoded, sizeof(code_decoded), "Tuning");
		case 24:    format(code_decoded, sizeof(code_decoded), "Parkour mod");
		case 25:    format(code_decoded, sizeof(code_decoded), "Szybkie animki");
		case 26:    format(code_decoded, sizeof(code_decoded), "Rapidfire");
		case 27:    format(code_decoded, sizeof(code_decoded), "FakeSpawn");
		case 28:    format(code_decoded, sizeof(code_decoded), "FakeKill");
		case 29:    format(code_decoded, sizeof(code_decoded), "Aimbot");
		case 30:    format(code_decoded, sizeof(code_decoded), "Bieg CJa");
		case 31:    format(code_decoded, sizeof(code_decoded), "Strzelanie autami");
		case 32:    format(code_decoded, sizeof(code_decoded), "Kradniecie aut");
		case 33:    format(code_decoded, sizeof(code_decoded), "Unfreeze");
		case 34:  format(code_decoded, sizeof(code_decoded), "AFK-Ghosting");
		case 35:    format(code_decoded, sizeof(code_decoded), "Aimbot (2)");
		case 36:  format(code_decoded, sizeof(code_decoded), "Fake NPC");
		case 37:  format(code_decoded, sizeof(code_decoded), "Reconnect");
		case 38:    format(code_decoded, sizeof(code_decoded), "Wysoki ping");
		case 39:    format(code_decoded, sizeof(code_decoded), "Czitowanie dialogow");
		case 40:  format(code_decoded, sizeof(code_decoded), "Sandbox");
		case 41:    format(code_decoded, sizeof(code_decoded), "Zla wersja samp");
		case 42:    format(code_decoded, sizeof(code_decoded), "Rcon-Hack");
		case 43:    format(code_decoded, sizeof(code_decoded), "Tuning Crasher");
		case 44:    format(code_decoded, sizeof(code_decoded), "Inv. seat Crasher");
		case 45:    format(code_decoded, sizeof(code_decoded), "Dialog Crasher");
		case 46:    format(code_decoded, sizeof(code_decoded), "Dodatki Crasher");
		case 47:    format(code_decoded, sizeof(code_decoded), "Bronie Crasher");
		case 48:  format(code_decoded, sizeof(code_decoded), "flood connect");
		case 49:  format(code_decoded, sizeof(code_decoded), "flood callbacks");
		case 50:  format(code_decoded, sizeof(code_decoded), "flood change seat");
		case 51:    format(code_decoded, sizeof(code_decoded), "DDOS");
		case 52:    format(code_decoded, sizeof(code_decoded), "Anti-NOPs");
		case 53:    format(code_decoded, sizeof(code_decoded), "Anti-FakeKill");
		default:    format(code_decoded, sizeof(code_decoded), "Inne");
	}
	return code_decoded;
}

SetAntyCheatForPlayer(playerid, valueCode)
{
	SetPVarInt(playerid, "AntyCheatOff", valueCode);
	return 1;
}

PlayerCanSpawnWihoutTutorial(playerid)
{
	if(PlayerInfo[playerid][pLevel] == 1 && (PlayerInfo[playerid][pSex] == 0 || PlayerInfo[playerid][pOrigin] == 0 || PlayerInfo[playerid][pAge] == 0)) //anty sobeit spawn
	{
		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		SendMessageToAdmin(
			sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] najprawdopodobniej czituje. | Spawn pomijaj¹c tutorial", GetNickEx(playerid), playerid, ip), 
			0xFF00FFFF
		);
		sendErrorMessage(playerid, "Zespawnowa³eœ siê bez wyboru p³ci/pochodzenia/wieku postaci! Zosta³eœ wyrzucony z serwera.");
		KickEx(playerid);
		return 0;
	}
	return 1;
}

forward CheckCode2003(killerid, playerid);
public CheckCode2003(killerid, playerid)
{
    new string[256];
    if(IsPlayerConnected(playerid))
	{
    	MruDialog(killerid, "ACv2: Kod #2003", "Zosta³eœ wyrzucony za weapon hack.");
		format(string, sizeof string, "ACv2 [#2003]: %s zosta³ wyrzucony za weapon hack.", GetNickEx(killerid));
    	SendCommandLogMessage(string);
    	KickEx(killerid);
		Log(warningLog, INFO, string);
		Log(punishmentLog, INFO, string);
	}
	else
	{
	    format(string, sizeof string, "ACv2 [#2003] WARNING: Prawdopodobnie próba wymuszenia kodu na graczu %s.", GetNickEx(killerid));
		MarkPotentialCheater(playerid);
    	SendCommandLogMessage(string);
		Log(warningLog, INFO, string);
	}
}
forward AntyCheatON(playerid);
public AntyCheatON(playerid)
{
	timeAC[playerid]++; 
	if(timeAC[playerid] >= 3)
	{
		SetAntyCheatForPlayer(playerid, 0);
		timeAC[playerid] = 0; 
		KillTimer(timerAC[playerid]); 
	}
}

forward OznaczCzitera(playerid);
public OznaczCzitera(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		return 1;
	}
	new string[71+MAX_PLAYER_NAME];
	SetPVarInt(playerid, "AC_oznaczony", 1);
	if(gettime() > GetPVarInt(playerid, "lastSobMsg"))
	{
		SetPVarInt(playerid, "lastSobMsg", gettime() + 60);
		format(string, sizeof(string), "%s[%d] jest podejrzany o S0beita", GetNick(playerid), playerid);
		SendAdminMessage(COLOR_PANICRED, string);
		MarkPotentialCheater(playerid);
	}
	return 1;
}

MarkPotentialCheater(playerid, value=1)
{
	PotentialCheaters[playerid] += value;
	UpdatePotentialCheatersTxd();
}

UnmarkPotentialCheater(playerid)
{
	if(PotentialCheaters[playerid] > 0)
	{
		PotentialCheaters[playerid] = 0;
		UpdatePotentialCheatersTxd();
	}
}

//----- TextDrawy -----
CreatePotentialCheatersTxd()
{
	PotentialCheatersTitleTxd = TextDrawCreate(519.000000, 102.000000, "Szkodnicy:");
	TextDrawFont(PotentialCheatersTitleTxd, 1);
	TextDrawLetterSize(PotentialCheatersTitleTxd, 0.191666, 0.900000);
	TextDrawTextSize(PotentialCheatersTitleTxd, 400.000000, 17.000000);
	TextDrawSetOutline(PotentialCheatersTitleTxd, 1);
	TextDrawSetShadow(PotentialCheatersTitleTxd, 0);
	TextDrawAlignment(PotentialCheatersTitleTxd, 2);
	TextDrawColor(PotentialCheatersTitleTxd, -1);
	TextDrawBackgroundColor(PotentialCheatersTitleTxd, 255);
	TextDrawBoxColor(PotentialCheatersTitleTxd, 50);
	TextDrawUseBox(PotentialCheatersTitleTxd, 0);
	TextDrawSetProportional(PotentialCheatersTitleTxd, 1);
	TextDrawSetSelectable(PotentialCheatersTitleTxd, 0);
	TextDrawHideForAll(PotentialCheatersTitleTxd);

	for(new i; i<sizeof(PotentialCheatersTxd); i++)
	{
		PotentialCheatersTxd[i] = TextDrawCreate(500.000000, 114.000000 + i*11, " ");
		TextDrawFont(PotentialCheatersTxd[i], 1);
		TextDrawLetterSize(PotentialCheatersTxd[i], 0.137500, 0.900000);
		TextDrawTextSize(PotentialCheatersTxd[i], 607.500000, 17.000000);
		TextDrawSetOutline(PotentialCheatersTxd[i], 1);
		TextDrawSetShadow(PotentialCheatersTxd[i], 0);
		TextDrawAlignment(PotentialCheatersTxd[i], 1);
		TextDrawColor(PotentialCheatersTxd[i], COLOR_RED);
		TextDrawBackgroundColor(PotentialCheatersTxd[i], 255);
		TextDrawBoxColor(PotentialCheatersTxd[i], 50);
		TextDrawUseBox(PotentialCheatersTxd[i], 1);
		TextDrawSetProportional(PotentialCheatersTxd[i], 1);
		TextDrawSetSelectable(PotentialCheatersTxd[i], 1);
		TextDrawHideForAll(PotentialCheatersTxd[i]);
	}
}

ShowPotentialCheatersTxd(playerid)
{
	TextDrawShowForPlayer(playerid, PotentialCheatersTitleTxd);
	for(new i; i<sizeof(PotentialCheatersTxd); i++)
		TextDrawShowForPlayer(playerid, PotentialCheatersTxd[i]);
	IsPotentialCheatersTxdVisible[playerid] = true;
}

HidePotentialCheatersTxd(playerid)
{
	TextDrawHideForPlayer(playerid, PotentialCheatersTitleTxd);
	for(new i; i<sizeof(PotentialCheatersTxd); i++)
		TextDrawHideForPlayer(playerid, PotentialCheatersTxd[i]);
	IsPotentialCheatersTxdVisible[playerid] = false;
}

UpdatePotentialCheatersTxd()
{
	new PlayerArray<top_cheaters>;
	new i;

	sortPlayersInline top_cheaters => (R = l > r) {
		R = PotentialCheaters[l] > PotentialCheaters[r];
	}
	
	forPlayerArray (top_cheaters => playerid) {
		if(PotentialCheaters[playerid] > 0)
		{
			PotentialCheatersID[i] = playerid;
			TextDrawSetString(PotentialCheatersTxd[i], sprintf("%s [%d] - %d", GetNickEx(playerid), playerid, PotentialCheaters[playerid]));
			if(GetPVarInt(playerid, "AC_oznaczony")) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_PANICRED);
			} else if(PlayerInfo[playerid][pLevel] == 1) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_NEWS);
			} else if(PotentialCheaters[playerid] >= 10) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_RED);
			} else {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_GREY);
			}
			TextDrawBoxColor(PotentialCheatersTxd[i], 50);

			i++;
			if(i == MAX_POTENTIAL_CHEATERS)
				break;
		}
	}

	for(; i<MAX_POTENTIAL_CHEATERS; i++)
	{
		TextDrawSetString(PotentialCheatersTxd[i], " ");
		TextDrawBoxColor(PotentialCheatersTxd[i], 0x00000000);
	}
}

// ----- Nex-AC modifications ------
NexACSaveCode(code, eNexACAdditionalSettings:type)
{
	if(type == OFF)
	{
        EnableAntiCheat(code, false);
	}
	else 
	{
        EnableAntiCheat(code, true);
	}
	nexac_additional_settings[code] = type;
	NexACSaveAdditionalConfig();
}

NexACLoadAdditionalConfig()
{
	new i, string[415], File:cfgFile;
	if(fexist(AC_ADDITIONAL_CONFIG_FILE))
	{
		if((cfgFile = fopen(AC_ADDITIONAL_CONFIG_FILE, io_read)))
		{
			new j;
			while(fread(cfgFile, string) > 0)
			{
				sscanf(string, "i'//'i", j, i);
				nexac_additional_settings[i] = eNexACAdditionalSettings:j;
			}
			fclose(cfgFile);
		}
		else return 0;
	}
	else
	{
		NexACSaveAdditionalConfig();
	}
	return 1;
}

NexACSaveAdditionalConfig()
{
	static strtmp[10];
	new string[415], File:cfgFile;
	if((cfgFile = fopen(AC_ADDITIONAL_CONFIG_FILE, io_write)))
	{
		for(new i; i < sizeof(nexac_additional_settings); ++i)
		{
			format(strtmp, sizeof strtmp, "%d //%d\r\n", nexac_additional_settings[i], i);
			strcat(string, strtmp);
		}
		fwrite(cfgFile, string);
		fclose(cfgFile);
	}
}

bool:CheckACWarningDelay(playerid, code)
{
	return GetPVarInt(playerid, "LastDetectedCode")-1 == code;
}

ACWarningDelay(playerid, code)
{
	SetPVarInt(playerid, "LastDetectedCode", code+1);
	defer ClearACWarningDelay(playerid);
}

timer ClearACWarningDelay[1000](playerid)
{
	SetPVarInt(playerid, "LastDetectedCode", 0);
}

GetNexACAdditionalSettingName(type)
{
	new name[22];
	switch(type)
	{
		case OFF: 
		{
			strcat(name, "OFF");
		}
		case KICK:
		{
			strcat(name, "KICK");
		}
		case INSTAKICK:
		{
			strcat(name, "INSTAKICK");
		}
		case LVL1KICK:
		{
			strcat(name, "KICK 1LVL/OZNACZ");
		}
		case LVL1MARK:
		{
			strcat(name, "OZNACZ 1LVL");
		}
		case LVL1INSTAKICK:
		{
			strcat(name, "INSTAKICK 1LVL/OZNACZ");
		}
		case ADMIN_WARNING:
		{
			strcat(name, "WARNING");
		}
		case MARK_AS_CHEATER:
		{
			strcat(name, "OZNACZ");
		}
		case MARK_AND_WARNING:
		{
			strcat(name, "OZNACZ + WARNING");
		}
	}
	return name;
}

ACKickMessage(playerid, code)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] dosta³ kicka. | %s [%d]", 
		GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
		0x9ACD32AA);
	SendClientMessage(playerid, 0x9ACD32AA, sprintf("Anti-Cheat: Dosta³eœ kicka. | %s [%d]", NexACDecodeCode(code), code));
	SendClientMessage(playerid, 0x9ACD32AA, "Je¿eli uwa¿asz, ¿e antycheat zadzia³a³ nieprawid³owo, zg³oœ to administracji, podaj¹c kod z jakim otrzyma³eœ kicka.");
	Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: kod %d", GetPlayerLogName(playerid), code);
}

ACv2_DrivingWithoutPremissions(playerid, vehicleid)
{
	new string[256];
	//ACv2: Kicking players that are trying to drive the car without permission
	if(!Player_CanUseCar(playerid, vehicleid) && (PlayerInfo[playerid][pAdmin] < 1 || !IsAScripter(playerid)))
	{
		// Skurwysyn kieruje bez prawka lub autem frakcji xD (Xd)
		if(GetPVarInt(playerid, "AntyCheatOff") == 0)
		{
			MruDialog(playerid, "ACv2: Kod #2001", "Dosta³eœ kicka za kierowanie samochodem bez wymaganych uprawnieñ");
			format(string, sizeof string, "ACv2 [#2001]: %s dosta³ kicka za jazdê bez uprawnieñ [Veh: %d]", GetNickEx(playerid), GetPlayerVehicleID(playerid));
			SendCommandLogMessage(string);
			Log(warningLog, INFO, string);
			Log(punishmentLog, INFO, string);
			KickEx(playerid);
			return 1;
		}
	}
	return 0;
}

AC_AntyFakeKill(playerid, killerid, reason)
{
	#pragma unused reason // TODO: It could be enhanced with reason checking

	// Check, if player has been damaged by killerid. If not, it is probably a fake kill.
	// It could generate false positive on hunter/seasparrow (armed vehicles ect.) kill or a drive-by kill.
	// If player has been damaged by killerid (and killer report it to the server) this method will return 0.
	for(new i; i<MAX_TAKEN_DAMAGE_ISSUERS; i++)
	{
		if(TakenDamageIssuers[playerid][i] == INVALID_PLAYER_ID) continue;
		if(TakenDamageIssuers[playerid][i] == killerid) return 0;
	}

	ProcessACCode(playerid, AC_CODE_FAKEKILL);
	return 1;
}

//----------------<[ Spam UnoccupiedSync i piêtrzenie aut - lagi ]>-----------------------

AC_AntyVehSpamLag()
{
	if(!performUnoccupiedVehCheckAC)
	{
		return;
	}

	static v_close_count;
	static string[128];
	static Float:v_bbox[MAX_VEHICLES][8][3];
	static Float:v_pos[MAX_VEHICLES][3];

	// Zapisujemy pozycje wszystkich pojazdów na serwerze
	foreach(new v : Vehicle)
	{
		GetVehiclePos(v, v_pos[v][0], v_pos[v][1], v_pos[v][2]);
	}

	new p_sus_syncs[MAX_PLAYERS] = {0, ...};
	new Bool:v_bbox_udpdated[MAX_VEHICLES] = {false, ...}, Bool:rotation_initialized[MAX_VEHICLES] = {false, ...};

	foreach(new v : Vehicle)
	{
		// Czy pojazd zosta³ przesuniêty przez synchronizacjê auta bez kierowcy?
		if(unoccupiedVehToCheckAC[v])
		{
			v_close_count = 0;
			new v_to_respawn[MAX_VEHICLES] = {false, ...};
			new Float:v_diagonal = GetVehicleBoundingBoxDiagonal(v);

			if(!v_bbox_udpdated[v])
			{
				rotation_initialized[v] = GetVehicleBoundingBox(v, v_bbox[v]);
			}

			// Zliczanie ile innych pojazdów znajduje siê w b. bliskiej odleg³oœci od auta przesuniêtego przez UnoccupiedSync
			foreach(new v_other : Vehicle)
			{
				if(v != v_other && (!v_bbox_udpdated[v_other] || rotation_initialized[v_other]))
				{
					new Float:v_distance = GetDistanceBetweenPoints(v_pos[v][0], v_pos[v][1], v_pos[v][2], 
						v_pos[v_other][0], v_pos[v_other][1], v_pos[v_other][2]);
					
					if(v_distance <= v_diagonal)
					{
						if(!v_bbox_udpdated[v_other])
						{
							rotation_initialized[v_other] = GetVehicleBoundingBox(v_other, v_bbox[v_other]);

							if(!rotation_initialized[v_other])
							{
								continue;
							}
						}

						if(CheckIfCuboidsIntersect(v_bbox[v], v_bbox[v_other]))
						{
							v_close_count++;
							v_to_respawn[v_other] = true;
						}
					}
				}
			}

			// Je¿eli pojazdów zbitych w zwarte k³êbowisko jest nie mniej ni¿ 4 (g³ówny pojazd 'v' i 3 inne), to podejmij odpowiednie dzia³ania
			if(v_close_count >= 3)
			{
				v_to_respawn[v] = true;

				new blockUnoccupiedThreshold = floatround(1.0 / 3.0 * float(v_close_count));
				new sendAdminWarningThreshold = floatround(0.9 * float(v_close_count));

				foreach(new v_respawn : Vehicle)
				{
					if(v_to_respawn[v_respawn])
					{
						// Sprawdzamy którzy gracze zsynchronizowali zmianê pozycji pojazdu bêd¹cego czêœci¹ k³êbowiska
						foreach(new p : Player)
						{
							if(p_sus_syncs[p] != -1 && unoccupiedVehToCheckPlayersAC[v_respawn][p])
							{
								p_sus_syncs[p]++; // Zliczamy dla ilu pojazdów z k³êbowiska zmiana pozycji zosta³a zsynchronizowana przez danego gracza

								// Je¿eli gracz zsynchronizowa³ zmiany pozycji dla wystarczaj¹cej liczby pojazdów z k³êbowiska, podejmujemy odpowiednie dzia³ania
								if(p_sus_syncs[p] == blockUnoccupiedThreshold)
								{
									unoccupiedVehBlockAC[p] = true;
									format(string, sizeof string, "AC: %s [%d] dosta³ blokadê na synchronizacjê pojazdów bez kierowcy.", GetNickEx(p), p);
									SendCommandLogMessage(string);
								}
								if(p_sus_syncs[p] == sendAdminWarningThreshold)
								{
									format(string, sizeof string, "AC: %s [%d] BYÆ MO¯E próbuje lagowaæ pojazdami.", GetNickEx(p), p);
									SendCommandLogMessage(string);
									Log(warningLog, INFO, string);
									p_sus_syncs[p] = -1; // oznaczenie, ¿e gracz przekroczy³ ju¿ najwy¿szy próg i nie trzeba go sprawdzaæ dla kolejnych pojazdów w k³êbowisku
								}
							}
						}
					}
				}

				// Po rozprawieniu siê z potencjalnymi winowajcami, zrespawnuj auta w k³êbowisku
				foreach(new v_respawn : Vehicle)
				{
					if(v_to_respawn[v_respawn])
					{
						unoccupiedVehToCheckAC[v_respawn] = false; // Nie ma sensu po raz kolejny sprawdzaæ tych aut, bo zosta³y one ju¿ zrespawnowane
						RespawnVehicleEx(v_respawn);
					}
				}
			}

			foreach(new p : Player)
			{
				unoccupiedVehToCheckPlayersAC[v][p] = false;
				if(p_sus_syncs[p] > 0)
				{
					p_sus_syncs[p] = 0;
				}
			}

			unoccupiedVehToCheckAC[v] = false;
		}
	}

	performUnoccupiedVehCheckAC = false;
}

IPacket:UNOCCUPIED_SYNC(playerid, BitStream:bs)
{
    // Sprawdzenie czy na gracza zosta³a na³o¿ona blokada na synchronizacje pojazdów bez kierowcy
	if(unoccupiedVehBlockAC[playerid])
	{
		return 0;
	}

	return 1;
}

// ----------------<[ AntiVehicleSpawn (https://github.com/katursis/Pawn.RakNet/wiki/AntiVehicleSpawn) ]>-----------------------

IRPC:VEHICLE_DESTROYED(playerid, BitStream:bs)
{
    new vehicleid;

    BS_ReadUint16(bs, vehicleid);

    if (GetVehicleModel(vehicleid) < 400)
    {
        return 0;
    }

	new Float:health, Float:depth, Float:vehicledepth;

    GetVehicleHealth(vehicleid, health);

    if (health >= 250.0 &&
        !CA_IsVehicleInWater(vehicleid, depth, vehicledepth) &&
        !IsVehicleUpsideDown(vehicleid)
    ) {
        return 0;
    }

    return 1;
}

//end