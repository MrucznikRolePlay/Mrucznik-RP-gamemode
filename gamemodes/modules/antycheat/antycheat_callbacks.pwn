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
forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
	new string[144];
	new plrIP[16];
    GetPlayerIp(playerid, plrIP, sizeof(plrIP));
	if(type == 0) //Type of cheating (when 0 it returns the ID, when 1 - IP)
	{
		printf("Cheats detected (code: %d) for player: %s[%d] ip: %s", code, GetNickEx(playerid), playerid, ip_address);

		if(PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
		{
			//disable all codes for admins
			return 1;
		}

		if(IsProblematicCode(code) && PlayerInfo[playerid][pLevel] > 1)
		{
			//disable problematic codes for trusted players
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
		
		if(GetPVarInt(playerid, "CheatDetected") == 1 || GetPVarInt(playerid, "CheatDetectedEx") == 1)
		{
			//kod wy³¹czony, jeœli wykryto (zapobiega dublowaniu komunikatów o wykryciu kodu nim gracz zostanie skickowany).
			return 1;
		}
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
            case 9:    format(code_decoded, sizeof(code_decoded), "Speed (pieszo)");
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
            //case 22:  format(code_decoded, sizeof(code_decoded), "Lagcomp");
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
            //case 34:  format(code_decoded, sizeof(code_decoded), "AFK-Ghosting");
            case 35:    format(code_decoded, sizeof(code_decoded), "Aimbot (2)");
            //case 36:  format(code_decoded, sizeof(code_decoded), "Fake NPC");
            //case 37:  format(code_decoded, sizeof(code_decoded), "Reconnect");
            case 38:    format(code_decoded, sizeof(code_decoded), "Wysoki ping");
            case 39:    format(code_decoded, sizeof(code_decoded), "Czitowanie dialogow");
            //case 40:  format(code_decoded, sizeof(code_decoded), "Sandbox");
            case 41:    format(code_decoded, sizeof(code_decoded), "Zla wersja samp");
            case 42:    format(code_decoded, sizeof(code_decoded), "Rcon-Hack");
            case 43:    format(code_decoded, sizeof(code_decoded), "Tuning Crasher");
            case 44:    format(code_decoded, sizeof(code_decoded), "Inv. seat Crasher");
            case 45:    format(code_decoded, sizeof(code_decoded), "Dialog Crasher");
            case 46:    format(code_decoded, sizeof(code_decoded), "Dodatki Crasher");
            case 47:    format(code_decoded, sizeof(code_decoded), "Bronie Crasher");
            //case 48:  format(code_decoded, sizeof(code_decoded), "flood connect");
            //case 49:  format(code_decoded, sizeof(code_decoded), "flood callbacks");
            //case 50:  format(code_decoded, sizeof(code_decoded), "flood change seat");
            case 51:    format(code_decoded, sizeof(code_decoded), "DDOS");
            case 52:    format(code_decoded, sizeof(code_decoded), "Anti-NOPs");
            default:    format(code_decoded, sizeof(code_decoded), "Inne");
        }
		format(string, sizeof(string), "Anti-Cheat: %s [ID: %d] [IP: %s] dosta³ kicka. | %s [%d]", GetNickEx(playerid), playerid, (PlayerInfo[playerid][pNewAP] > 0 ? "(ukryte)" : plrIP), code_decoded, code);
		SendMessageToAdmin(string, 0x9ACD32AA);
		format(string, sizeof(string), "Anti-Cheat: Dosta³eœ kicka. | %s [%d]", code_decoded, code);
		SendClientMessage(playerid, 0x9ACD32AA, string);
		SendClientMessage(playerid, 0x9ACD32AA, "Je¿eli uwa¿asz, ¿e antycheat zadzia³a³ nieprawid³owo, zg³oœ to administracji, podaj¹c kod z jakim otrzyma³eœ kicka.");
        Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: kod %d", GetPlayerLogName(playerid), code);
		if(code == 50 || code == 28 || code == 27 || code == 5)
		{
			Kick(playerid);
			SetPVarInt(playerid, "CheatDetected", 1);
		}
		else if(code == 16 || code == 17)
		{
			SetPVarInt(playerid, "ammohackdetect", 1);
		}
		else
		{
			KickEx(playerid);
			SetPVarInt(playerid, "CheatDetected", 1);
		}
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

//end