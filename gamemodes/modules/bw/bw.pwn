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
//-----------------<[ Funkcje: ]>-------------------
stock IsPlayerAimingEx(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

InfoMedicsInjury(injureplayer, bool:injury, bool:bw)
{
	new string[144], pZone[MAX_ZONE_NAME], type[144];
	GetPlayer2DZone(injureplayer, pZone, MAX_ZONE_NAME);
	type = (injury ? "Ranny" : "Nieprzytomny");
	if(injury)
	{
		format(string, sizeof(string), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}- Lokalizacja: {FF0000}%s", type, pZone);
	}
	else if(bw)
	{
		format(string, sizeof(string), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}w salach pooperacyjnych", type);
	}
	SendClientMessageToAll(COLOR_GRAD2, "Wysy³am komunikat do ERS o BW/injury");
	SendTeamMessage(4, COLOR_ALLDEPT, string);
}
OnPlayerInjurySpawn(playerid)
{
	new string[144];
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerHealth(playerid, INJURY_HP);
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	SetPlayerFacingAngle(playerid, GetPVarInt(playerid, "bw-faceangle"));
	SetCameraBehindPlayer(playerid);
	new type = (PlayerInfo[playerid][pBW] > 0) ? "nieprzytomny" : "ranny";
	format(string, sizeof(string), "{FF542E}Jesteœ %s!\n{FFFFFF}Mo¿esz wezwaæ pomoc lub poczekaæ a¿ ktoœ Ciê dobije.", type);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string); 
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SendClientMessageToAll(COLOR_GRAD2, "Spawnuje gracza z Injury");
	return 1;
}
GiveInjury(playerid, bool:injury = false, bool:bw = false, customtime = 0)
{
	new Float:playerangle;
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	GetPlayerFacingAngle(playerid, playerangle);
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
	SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
	SetPVarInt(playerid, "bw-faceangle", Float:playerangle);
	if(injury)
	{
		SendClientMessageToAll(COLOR_GRAD2, "#1: Gracz zostal ranny.");
		if(!customtime) customtime = INJURY_TIME;
		PlayerInfo[playerid][pBW] = 0;
		PlayerInfo[playerid][pInjury] = customtime;
		SetPlayerChatBubble(playerid, "(( Ranny ))", COLOR_PANICRED, 30.0, (customtime * 1000));
	}
	else if(bw)
	{
		SendClientMessageToAll(COLOR_GRAD2, "#2: Gracz dosta³ BW.");
		TogglePlayerControllable(playerid, 0);
		if(!customtime) customtime = BW_TIME;
		PlayerInfo[playerid][pInjury] = 0;
		PlayerInfo[playerid][pBW] = customtime;
		SetPlayerChatBubble(playerid, "(( Nieprzytomny ))", COLOR_PANICRED, 30.0, (customtime * 1000));
		SetPlayerSpawn(playerid);
	}
	InfoMedicsInjury(playerid, injury, bw);
	return 1;
}
FreezePlayerOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#3: Zamra¿am gracza");
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SetTimerEx("FreezePlayer", 1500, false, "i", playerid);
	return 1;
}
PlayerEnterVehOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#4: Gracz próbuje wejœæ do pojazdu");
	Player_RemoveFromVeh(playerid);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz wsi¹œæ do pojazdu.");
	return 1;
}
PlayerChangeWeaponOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#5: Gracz zmienia broñ, wiêc cofam mu j¹");
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	return 1;
}
//-----------------<[ Timery: ]>-------------------
PlayerHasInjuryTimer(playerid)
{
	new string[128], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[playerid][pInjury] > 0)
	{
		SendClientMessageToAll(COLOR_GRAD2, "#6: Timer: gracz jest ranny, animki itp");
		ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pInjury]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
		GameTextForPlayer(i, string, 2500, 3);
		if(PlayerInfo[i][pInjury] <= 0)
		{
			SendClientMessageToAll(COLOR_GRAD2, "#7: Timer: gracz nie uzyska³ pomocy, nadajê mu BW");
			PlayerInfo[i][pInjury] = 0;
			GiveInjury(i, false, true);
		}
	}
	else if(PlayerInfo[playerid][pBW] > 0)
	{
		SendClientMessageToAll(COLOR_GRAD2, "#8: Timer: gracz ma BW");
		ApplyAnimation(i, "CRACK", "crckidle1", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pBW]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Nieprzytomny: %d", PlayerInfo[i][pBW]);
		GameTextForPlayer(i, string, 2500, 3);
		if(PlayerInfo[i][pBW] <= 0)
		{
			SendClientMessageToAll(COLOR_GRAD2, "#9: Timer: Graczowi minê³o BW, wybudzam go.");
			SetPlayerChatBubble(playerid, " ", 0xFF0000FF, 100.0, 1000);
			PlayerInfo[i][pBW]=0;
			TogglePlayerControllable(i, 1);
			ClearAnimations(i);
			SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
			GameTextForPlayer(i, "tutaj po bw, Obudziles sie po pobiciu!", 5000, 5);
			SetPVarInt(i, "bw-sync", 0);
			PlayerInfo[i][pMuted] = 0;
		}
	}
	return 1;
}

BWSpawnAtHospital(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "#10: Losujê graczowi ³ózko w szpitalu i mutuje go");
	new randbed = random(sizeof(HospitalBeds));
	SetPVarInt(playerid, "bw-vw", 90);
	SetPVarInt(playerid, "bw-int", 0);
	SetPVarInt(playerid, "bw-faceangle", HospitalBeds[randbed][3]);
	PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
	PlayerInfo[playerid][pPos_x] = HospitalBeds[randbed][0];
	PlayerInfo[playerid][pPos_y] = HospitalBeds[randbed][1];
	PlayerInfo[playerid][pPos_z] = HospitalBeds[randbed][2];
	SetPlayerCameraPos(playerid,HospitalBeds[randbed][0] + 3, HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	SetPlayerCameraLookAt(playerid,HospitalBeds[randbed][0], HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	PlayerInfo[playerid][pMuted] = 1;
	OnPlayerInjurySpawn(playerid);
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end