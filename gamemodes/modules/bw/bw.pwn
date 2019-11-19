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
	new string[144], pZone[MAX_ZONE_NAME], type[24];
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
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerHealth(playerid, INJURY_HP);
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	//SetPlayerPosEx(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPlayerFacingAngle(playerid, GetPVarInt(playerid, "bw-angle"));
	SetCameraBehindPlayer(playerid);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Mo¿esz wezwaæ pomoc lub poczekaæ a¿ ktoœ Ciê dobije."); 
	//dialog
	//SendClientMessage(playerid, COLOR_LIGHTRED, "You are injured.");
	//SendClientMessage(playerid, COLOR_LIGHTRED, "Either wait for assistance or /acceptdeath.");
	// AcceptDeathTimer[playerid] = SetTimer("CanAcceptDeath", 60000, false);
	//LoseHealthTimer[playerid] = SetTimer("LoseHealth", 10000, true);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SendClientMessageToAll(COLOR_GRAD2, "Spawnuje gracza z Injury");
	//TUTAJ BW
	return 1;
}
GiveInjury(playerid, bool:injury = false, bool:bw = false, customtime = 0)
{
	new Float:playerangle;
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	if(injury)
	{
		SendClientMessageToAll(COLOR_GRAD2, "Nadaje Injury");
		if(!customtime) customtime = INJURY_TIME;
		GetPlayerFacingAngle(playerid, playerangle);
		PlayerInfo[playerid][pInjury] = customtime;
		SetPlayerChatBubble(playerid, "(( Ranny ))", COLOR_PANICRED, 30.0, (customtime * 1000));
		SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
		SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "bw-angle", playerangle);
	}
	else if(bw)
	{
		SendClientMessageToAll(COLOR_GRAD2, "Nadaje BW");
		//TUTAJ SPAWN W SZPITALU
		if(!customtime) customtime = BW_TIME;
		GetPlayerFacingAngle(playerid, playerangle);
		PlayerInfo[playerid][pBW] = customtime;
		SetPlayerChatBubble(playerid, "(( Nieprzytomny ))", COLOR_PANICRED, 30.0, (customtime * 1000));
		SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
		SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "bw-angle", playerangle);
	}
	InfoMedicsInjury(playerid, injury, bw);
	return 1;
}
FreezePlayerOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "Freezuje gracza gdy ma Injury/BW");
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	SetTimerEx("FreezePlayer", 1500, false, "i", playerid);
	return 1;
}
PlayerEnterVehOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "Usuwam gracza z pojazdu gdy ma Injury/BW");
	Player_RemoveFromVeh(playerid);
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz wsi¹œæ do pojazdu.");
	return 1;
}
PlayerChangeWeaponOnInjury(playerid)
{
	SendClientMessageToAll(COLOR_GRAD2, "Ustawiam graczowi poprzedni¹ broñ");
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	return 1;
}
//-----------------<[ Timery: ]>-------------------
PlayerHasInjuryTimer(playerid, bool:injury, bool:hasbw)
{
	new string[128], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(injury)
	{
		SendClientMessageToAll(COLOR_GRAD2, "Timer: injury");
		ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pInjury]-=2;
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
		GameTextForPlayer(i, string, 2500, 3);
		if(PlayerInfo[i][pInjury] <= 0)
		{
			PlayerInfo[i][pInjury] = 0;
			GiveInjury(i, false, true);
		}
	}
	else if(hasbw)
	{
		SendClientMessageToAll(COLOR_GRAD2, "Timer: BW");
		ApplyAnimation(i, "CRACK", "crckidle1", 4.0, 1, 0, 1, 1, 1);
		PlayerInfo[i][pBW]-=2;
		format(string, 128, "~n~~n~~n~~n~~n~~n~~y~%d", PlayerInfo[i][pBW]);
		GameTextForPlayer(i, string, 2500, 3);
		if(PlayerInfo[i][pBW] <= 0)
		{
			PlayerInfo[i][pBW]=0;
			TogglePlayerControllable(i, 1);
			ClearAnimations(i);
			GameTextForPlayer(i, "tutaj po bw, Obudziles sie po pobiciu!", 5000, 5);
			SetPVarInt(i, "bw-sync", 0);
			PlayerInfo[i][pMuted] = 0;
		}
	}
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end