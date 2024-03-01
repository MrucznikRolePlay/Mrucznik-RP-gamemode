//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  bijatyki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024
//Opis:
/*
	Uporz¹dkowany system /pobij.
*/

//

//-----------------<[ Funkcje: ]>-------------------

BattlePhaseStart(playerid, opponentid, lengthSeconds)
{
	new message_s[256];

	new playerName[MAX_PLAYER_NAME];
	new opponentName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	GetPlayerName(opponentid, opponentName, sizeof(opponentName));

	new randomFightTextID = random(30);
	format(battleCodeToRetype[playerid], sizeof(battleCodeToRetype[]), "%s", BATTLE_CODE_RETYPE_TEXTS[randomFightTextID]);

	format(message_s, sizeof(message_s), "Próbujesz pobiæ %s, za %d sekund rostrzygnie siê bitwa!", opponentName, lengthSeconds);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);

	format(message_s, sizeof(message_s), "%s próbuje ciê pobiæ! Wpisz ten kod aby siê obroniæ:\n%s", playerName, battleCodeToRetype[playerid]);
	ShowPlayerDialogEx(opponentid, BATTLE_FIGHT_DIALOG, DIALOG_STYLE_INPUT, "BITWA!!", message_s, "Wybierz", "WyjdŸ");

	ApplyAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 1, 0, 1);
	ApplyAnimation(opponentid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 1, 0, 1);

	battleIsTooLate[playerid] = false;
	battleIsTooLate[opponentid] = false;
	isFightingNow[playerid] = true;
	isFightingNow[opponentid] = true;

	new battleTimer = SetTimerEx("BattleTimeIsUp", lengthSeconds * 1000, false, "dd", opponentid, playerid);
	SetPVarInt(opponentid, "battleTimer", battleTimer);
}

LoseBattle(playerid, opponentid)
{
	new message_s[256];

	new opponentName[MAX_PLAYER_NAME];
	new playerName[MAX_PLAYER_NAME];

	GetPlayerName(opponentid, opponentName, sizeof(opponentName));
	GetPlayerName(playerid, playerName, sizeof(playerName));

	format(message_s, sizeof(message_s), "* %s wyprowadzi³ cios i pobi³ %s.", opponentName, playerName);
	ProxDetector(30.0, playerid, message_s, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	format(message_s, sizeof(message_s), "%s znokautowa³ ciê bez wiêkszego problemu.", opponentName);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);
	format(message_s, sizeof(message_s), "Odczekaj %d sekund", BATTLE_WAKE_UP_SEC);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);

	format(message_s, sizeof(message_s), "Pobi³eœ %s bez wiêkszego trudu.", playerName);
	SendClientMessage(opponentid, COLOR_LIGHTBLUE, message_s);

	PlayerPlaySound(playerid, 1130, 0.0, 0.0, 0.0);
	PlayerPlaySound(opponentid, 1130, 0.0, 0.0, 0.0);
	PlayerFixRadio(playerid);
	PlayerFixRadio(opponentid);

	TogglePlayerControllable(playerid, 0);
	TogglePlayerControllable(opponentid, 1);
	SetPlayerHealth(playerid, 30.0);

	ClearAnimations(opponentid);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0999, 1, 0, 0, 1, 0, 1);

	isFightingNow[playerid] = false;
	isFightingNow[opponentid] = false;
	fightingOpponentOf[opponentid] = INVALID_PLAYER_ID;
	fightingOpponentOf[playerid] = INVALID_PLAYER_ID;
	isBeatenUp[playerid] = true;
	PlayerInfo[playerid][pMuted] = 1;

	SetTimerEx("WakeUpAfterFight", BATTLE_WAKE_UP_SEC * 1000, 0, "dd", playerid, opponentid);
}


IsPobijInvalid(playerid, opponentid)
{
	if(!IsPlayerConnected(playerid))
    {
		return 1;
	}
	if(PlayerInfo[playerid][pLevel] < 3)
	{
		sendTipMessage(playerid, "Musisz mieæ co najmniej 3 poziom, by u¿ywaæ tej komendy!");
		return 1;
	}
	if(IsAMedyk(playerid))
	{
		sendErrorMessage(playerid, "Nie mo¿esz uzywaæ tej komendy");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Komenda nie dzia³a w kasynie!");
		return 1;
	}
	if(wasRecentlyFighting[playerid])
	{
		sendTipMessage(playerid, "Jesteœ ju¿ zmêczony po ostatniej walce, odpocznij chwilê zanim zaczniesz znowu.", COLOR_GRAD1);
		return 1;
	}
	if(opponentid == INVALID_PLAYER_ID || !IsPlayerConnected(opponentid))
	{
		sendErrorMessage(playerid, "Tego gracza nie ma na serwerze!");
		return 1;
	}
	if(opponentid == playerid)
	{
		sendErrorMessage(playerid, "Nie mo¿esz pobiæ samego siebie!");
		return 1;
	}
	if(!ProxDetectorS(5.0, playerid, opponentid) || Spectate[opponentid] != INVALID_PLAYER_ID)
	{
		sendErrorMessage(playerid, "Ten gracz jest za daleko!");
		return 1;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || GetPlayerState(opponentid) != PLAYER_STATE_ONFOOT)
	{
		sendErrorMessage(playerid, "¯aden z was nie mo¿e byæ w pojeŸdzie!");
		return 1;
	}
	if(GetPlayerAdminDutyStatus(playerid) == 1 || GetPlayerAdminDutyStatus(opponentid) == 1)
	{
		sendErrorMessage(playerid, "¯aden z was nie mo¿e byæ na @duty!"); 
		return 1;
	}
	if(isFightingNow[opponentid])
	{
		sendErrorMessage(playerid, "Ktoœ ju¿ toczy walkê z tym graczem!");
		return 1;
	}
	if(GUIExit[playerid] || GUIExit[opponentid])
	{
		sendErrorMessage(playerid, "¯aden z was nie mo¿e mieæ otwartego okienka dialogowego!");
		return 1;	
	}
	if(isBeatenUp[opponentid] || isBeatenUp[playerid] ||
		isPlayerCuffed[opponentid] || isPlayerCuffed[playerid] ||
		PlayerInfo[opponentid][pBW] != 0 || PlayerInfo[playerid][pBW] != 0 ||
		PlayerInfo[opponentid][pInjury] != 0 || PlayerInfo[playerid][pInjury] != 0)
	{
		sendTipMessage(playerid, "Nie mo¿esz pobiæ rannego lub pobitego gracza / jesteœ ranny lub pobity, nie mo¿esz biæ innych.");
		return 1;
	}
	if(GetPlayerWeapon(opponentid) >= 22)
	{
		sendTipMessage(playerid, "Nie mo¿esz pobiæ gracza z broni¹ w d³oni!");
		return 1;
	}

	return 0;
}


ZerujZmienne_Bijatyki(playerid)
{
	isBeatenUp[playerid] = false;
	wasRecentlyFighting[playerid] = false;
	isFightingNow[playerid] = false;
	fightingOpponentOf[playerid] = INVALID_PLAYER_ID;

	return ZerujZmienne(playerid);
}
#if defined _ALS_ZerujZmienne
    #undef ZerujZmienne
#else
    #define _ALS_ZerujZmienne
#endif
#define ZerujZmienne ZerujZmienne_Bijatyki

//end