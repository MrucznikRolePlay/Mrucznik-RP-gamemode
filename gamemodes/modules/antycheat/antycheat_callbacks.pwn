//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	CreatePotentialCheatersTxd();
	NexACLoadAdditionalConfig();
	return 1;
}

hook OnPlayerConnect(playerid)
{
	for(new i; i<MAX_TAKEN_DAMAGE_ISSUERS; i++)
	{
		TakenDamageIssuers[playerid][i] = INVALID_PLAYER_ID;
	}
	TakenDamageIndex[playerid] = 0;
}

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
	if(IsPlayerPaused(playerid)) return 1;
	if(type == 0) //Type of cheating (when 0 it returns the ID, when 1 - IP)
	{
		printf("Cheats detected (code: %d) for player: %s[%d] ip: %s", code, GetNickEx(playerid), playerid, ip_address);

		if(PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
		{
			//disable all codes for admins
			return 1;
		}

		if(GetPVarInt(playerid, "CodeACDisable") > 0) 
		{
			//disable if player call to cmd "wjedz" 
			return 1;
		}

		if(GetPVarInt(playerid, "AntyCheatOff") > 0 )
		{
			timerAC[playerid] = SetTimerEx("AntyCheatON", 2500, true, "i", playerid);
			return 1; 
		}
		
		if(GetPVarInt(playerid, "CheatDetected") == 1)
		{
			//kod wy³¹czony, jeœli wykryto (zapobiega dublowaniu komunikatów o wykryciu kodu nim gracz zostanie skickowany).
			return 1;
		}

		if(CheckACWarningDelay(playerid, code))
		{
			//zapobiega spmowaniu komunikatami
			return 1;
		}

		//What to do
		if(code == 16 || code == 17)
		{
			SetPVarInt(playerid, "ammohackdetect", 1);
			return 1;
		}

		ProcessACCode(playerid, code);
	}
	else //type with ip
	{
		printf("Cheats detected (code: %d) ip: %s", code, ip_address);
		new ac_strtmp[32];
		format(ac_strtmp, sizeof ac_strtmp, "banip %s", ip_address);
		SendRconCommand(ac_strtmp);
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(gPlayerLogged[playerid] == 0)
	{
		if(GetPlayerVirtualWorld(playerid) != 1488)
		{
			SetPlayerVirtualWorld(playerid, 1488);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_SPAWNED || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: spawn bêd¹c niezalogowanym");
			SendClientMessage(playerid, COLOR_PANICRED, "Zosta³eœ zkickowany za spawn jako niezalogowany");
			KickEx(playerid);
			return -1; //stop processing and return 0
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    //---------------------------------------------- Anti Cheat ------------------------------------//
   /* if(newstate == PLAYER_STATE_DRIVER) {
        if(GetPVarInt(playerid, "iLastDrive") != 0 && (gettime() - GetPVarInt(playerid, "iLastDrive")) <= 1) {
            SetPVarInt(playerid, "iFlags", GetPVarInt(playerid, "iLastDrive")+1);
            if(GetPVarInt(playerid, "iLastDrive") >= 2) {
                format(string, 256, "%s podejrzany o tepanie aut. Dostal kicka. LVL: %d (%dh online)", GetNick(playerid), PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pConnectTime]);
                SendAdminMessage(COLOR_LIGHTRED, string);
                Kick(playerid);
                return true;
            }
        }

        SetPVarInt(playerid, "iLastDrive", gettime());
    } */
	if(gPlayerLogged[playerid] == 0)
	{
		if(newstate == PLAYER_STATE_SPAWNED || newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		{
			Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: spawn bêd¹c niezalogowanym");
			SendClientMessage(playerid, COLOR_PANICRED, "Zosta³eœ zkickowany za spawn jako niezalogowany");
			KickEx(playerid);
			return -2; //stop processing and return 1
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	UnmarkPotentialCheater(playerid);
	HidePotentialCheatersTxd(playerid);
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	for(new i; i<sizeof(PotentialCheatersTxd); i++)
	{
		if(clickedid == PotentialCheatersTxd[i])
		{
			Command_ReProcess(playerid, sprintf("spec %d", PotentialCheatersID[i]), false);
			return 1;
		}
	}
	return 1;
}

hook OnPlayerGiveDamage(playerid, damageid, Float:amount, weaponid, bodypart)
{
	if(damageid == INVALID_PLAYER_ID) return 1;

	// Oznaczanie graczy, którzy zadali obra¿enia graczowi wedle raportowania oprawcy
	new idx = TakenDamageIndex[damageid];
	new next_idx = (TakenDamageIndex[damageid] + 1) % MAX_TAKEN_DAMAGE_ISSUERS;
	if(TakenDamageIssuers[damageid][idx] != playerid)
	{
		TakenDamageIndex[damageid] = next_idx;
		TakenDamageIssuers[damageid][next_idx] = playerid;
	}
	return 1;
}

AC_OnPlayerLogin(playerid)
{
	if(PlayerInfo[playerid][pConnectTime] == 0)
	{
		MarkPotentialCheater(playerid);
	}
}

//end