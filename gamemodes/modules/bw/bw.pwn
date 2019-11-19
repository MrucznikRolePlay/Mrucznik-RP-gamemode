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
OnPlayerInjurySpawn(playerid)
{
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerHealth(playerid, INJURY_HP);
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	SetPlayerPosEx(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPlayerFacingAngle(playerid, GetPVarInt(playerid, "bw-angle"));
	SetCameraBehindPlayer(playerid);
	if(GetPVarInt(playerid, "bw-skin") != 0) SetPlayerSkinEx(playerid, GetPVarInt(playerid, "bw-skin"));
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Mo¿esz wezwaæ pomoc lub poczekaæ a¿ ktoœ Ciê dobije."); 
	//dialog
	//SendClientMessage(playerid, COLOR_LIGHTRED, "You are injured.");
	//SendClientMessage(playerid, COLOR_LIGHTRED, "Either wait for assistance or /acceptdeath.");
	// AcceptDeathTimer[playerid] = SetTimer("CanAcceptDeath", 60000, false);
	//LoseHealthTimer[playerid] = SetTimer("LoseHealth", 10000, true);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	return 1;
}
GiveInjury(playerid, bool:injury, bool:bw)
{
	if(injury)
	{
		new Float:playerangle;
		GetPlayerFacingAngle(playerid, playerangle);
		PlayerInfo[playerid][pInjury] = INJURY_TIME;
		//SetPlayerColor(playerid,COLOR_PANICRED);
		GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
		SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
		SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "bw-angle", playerangle);
		/*for(new i = 0; i < MAX_VEHICLES; i ++)
		{
			SetVehicleParamsForPlayer(i, playerid, 0, 1);
		}*/
		//komunikat do ERS o rannym jako funkcja
        //GetPlayerPos(playerid, x, y, z);
        //GetPlayerFacingAngle(playerid, angle);
	}
	else if(bw)
	{
		
	}
	return 1;
}
FreezePlayerOnInjury(playerid)
{
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
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
	ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	PlayerInfo[i][pInjury]-=2;
	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
	GameTextForPlayer(i, string, 2500, 3);
	if(PlayerInfo[i][pInjury] <= 0)
	{
		ClearAnimations(i);
		PlayerInfo[i][pInjury] = 0;
		TogglePlayerControllable(i, 1);
		SetPVarInt(i, "bw-sync", 0);
		PlayerInfo[i][pMuted] = 0;
		GameTextForPlayer(i, "Obudziles sie po pobiciu!", 5000, 5);
		//co zrobiæ gdy czas minie
		/*PlayerInfo[i][pInjury]=0;
		PlayerInfo[i][pBW]=0;
		TogglePlayerControllable(i, 1);
		GameTextForPlayer(i, "Obudziles sie po pobiciu!", 5000, 5);
		PlayerInfo[i][pMuted] = 0;
		*/
	}
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end