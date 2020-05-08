//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ spec ]-------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:spec(playerid, params[], help)
{
	new string[144];
	new sendername[MAX_PLAYER_NAME+1];
	new giveplayer[MAX_PLAYER_NAME+1];

    if(IsPlayerConnected(playerid))
    {
        if(IsAScripter(playerid) || PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 3)
        {
            GetPlayerName(playerid, sendername, sizeof(sendername));
            new pid;
			if(sscanf(params, "k<fix>", pid)) return sendTipMessage(playerid, "U¿yj /spec [Nick lub ID gracza] - Aby wy³¹czyæ - Klawisz skoku");
            else if(pid == INVALID_PLAYER_ID) return sendErrorMessage(playerid, "Cel nie jest osiagalny.");
            else if(pid == playerid) return sendErrorMessage(playerid, "Nie mo¿esz podgl¹daæ siebie samego.");
			else if(PlayerInfo[pid][pAdmin] >= 1 && PlayerInfo[playerid][pAdmin] < 1000) return sendErrorMessage(playerid, "Nie mo¿esz specowaæ tego admina!"); 
	        /*if(SpectateTime[playerid] >= 1)
	        {
				new Float:spectime = (SpectateTime[playerid]*2)/60;
	            if (PlayerInfo[playerid][pZG] >= 1)
			    {
			        format(string, sizeof(string), "Zaufani/%s.ini", sendername);
			        dini_FloatSet(string, "Realna_aktywnosc", dini_Float(string, "Realna_aktywnosc")+spectime);
			    }
			    else
			    {
		            format(string, sizeof(string), "Admini/%s.ini", sendername);
		        	dini_FloatSet(string, "Realna_aktywnosc", dini_Float(string, "Realna_aktywnosc")+spectime);
				}
	        	SpectateTime[playerid] = 0;
	        }*/
			SetPVarInt(playerid, "OnSpecChanging", 1);
            if(Unspec[playerid][Coords][0] == 0.0)
            {
                GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
                Unspec[playerid][sPint] = GetPlayerInterior(playerid);
                Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);
            }
		   	Spectate[playerid] = pid;
			new Float:health;
			GetPlayerHealth(pid, health);
			GetPlayerName(pid, giveplayer, sizeof(giveplayer));
			new cash =  GetPlayerMoney(pid);
			SetPlayerInterior(playerid, GetPlayerInterior(pid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(pid));
			new specIP[32], iptext[64], jailWiadomosc[64];
			format(jailWiadomosc, sizeof(jailWiadomosc), " | Jail/AJ - %ds ", PlayerInfo[pid][pJailTime]);
			GetPlayerIp(pid, specIP, sizeof(specIP));
			if(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
			{
				format(iptext, sizeof(iptext)," | IP - %s", specIP);
			} 
			format(string, sizeof(string), "Podglad: %s [%d] $%d | Lvl: %d | Prawko - %s%s| VWorld - %d | Int - %d%s",
				giveplayer,
				pid,
				cash,
				PlayerInfo[pid][pLevel],
				(PlayerInfo[pid][pCarLic]==1) ? ("Tak") : ("Nie"),
				(PlayerInfo[pid][pJailTime] > 0) ? (jailWiadomosc) : (" "), 
				GetPlayerVirtualWorld(pid), 
				GetPlayerInterior(pid), 
				(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid)) ? iptext : ""
			);
				
			SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
			PhoneOnline[playerid] = 1;
            TogglePlayerSpectating(playerid, 1);
            Streamer_ToggleAllItems(playerid, STREAMER_TYPE_OBJECT, 0);
            SetTimerEx("SpecToggle", 3000, false, "i", playerid);
            if(IsPlayerInAnyVehicle(pid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(pid), SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 2);
            else PlayerSpectatePlayer(playerid, pid, SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 1);
			if(playerTargetSpec[playerid] != INVALID_SPECTATE_ID)
			{
				if(PlayerInfo[playerTargetSpec[playerid]][pAdmin] < 2000)
				{
					playerTargetSpec[playerid] = INVALID_SPECTATE_ID; 
					return 1;
				}
				format(string, sizeof(string), "[CMD_USE_WARNING] Admin %s [%d] podgl¹da  %s [%d]", 
				GetNickEx(playerid), 
				playerid,
				GetNick(pid),
				pid); 
				SendClientMessage(playerTargetSpec[playerid], COLOR_RED, string); 
			}
			DeletePVar(playerid, "func_SetPVarInt");
			//SetTimerEx("func_SetPVarInt", 250, false, "dsd", playerid, "OnSpecChanging", 0);
        }
	}
	return 1;
}
