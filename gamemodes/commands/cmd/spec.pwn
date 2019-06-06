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
	new string[128];
	new sendername[MAX_PLAYER_NAME+1];
	new giveplayer[MAX_PLAYER_NAME+1];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 3)
        {
            GetPlayerName(playerid, sendername, sizeof(sendername));
            new pid;
			if(sscanf(params, "k<fix>", pid)) return sendTipMessage(playerid, "U¿yj /spec [Nick lub ID gracza] - Aby wy³¹czyæ - Klawisz skoku");
            if(pid == INVALID_PLAYER_ID) return sendErrorMessage(playerid, "Cel nie jest osiagalny.");
            if(pid == playerid) return sendErrorMessage(playerid, "Cel nie jest osiagalny.");
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
            SetPlayerColor(playerid,COLOR_SPEC);
			format(string, sizeof(string), "Podglad: %s [%d] $%d | Lvl: %d | Prawko - %s | AJ/Jail - %s",giveplayer,pid,cash,PlayerInfo[pid][pLevel],(PlayerInfo[pid][pCarLic]==1) ? ("Tak") : ("Nie"),(PlayerInfo[pid][pJailTime] > 0) ? ("Tak") : ("Nie"));
			SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
			PhoneOnline[playerid] = 1;
            TogglePlayerSpectating(playerid, 1);
            Streamer_ToggleAllItems(playerid, STREAMER_TYPE_OBJECT, 0);
            SetTimerEx("SpecToggle", 3000, false, "i", playerid);
            if(IsPlayerInAnyVehicle(pid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(pid), SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 2);
            else PlayerSpectatePlayer(playerid, pid, SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 1);
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pAdmin] >= 1)
				{
					if(showSpec[i] != 666)
					{
						if(showSpec[i] == playerid || showSpec[i] == -1)
						{
							format(string, sizeof(string), "Admin %s [%d] podgl¹da [spec] gracza %s [%d]", GetNick(playerid), playerid, giveplayer, pid);
							sendTipMessageEx(i, COLOR_RED,  string); 
						}
					}
				}
			}
        }
	}
	return 1;
}
