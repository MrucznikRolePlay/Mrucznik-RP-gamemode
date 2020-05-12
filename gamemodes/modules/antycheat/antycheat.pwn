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

//-----------------<[ Funkcje: ]>-------------------
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
		default:    format(code_decoded, sizeof(code_decoded), "Inne");
	}
	return code_decoded;
}

SetAntyCheatForPlayer(playerid, valueCode)
{
	SetPVarInt(playerid, "AntyCheatOff", valueCode);
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
		PotentialCheatersID[i] = playerid;
		TextDrawSetString(PotentialCheatersTxd[i], sprintf("%s [%d] - %d", GetNickEx(playerid), playerid, PotentialCheaters[playerid]));
		if(GetPVarInt(playerid, "AC_oznaczony")) {
			TextDrawColor(PotentialCheatersTxd[i], COLOR_PANICRED);
		} else if(PotentialCheaters[playerid] >= 10) {
			TextDrawColor(PotentialCheatersTxd[i], COLOR_RED);
		} else {
			TextDrawColor(PotentialCheatersTxd[i], COLOR_GREY);
		}

		i++;
	}
}

//end