//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  animacje                                                 //
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
// Autor: Sanda�
// Data utworzenia: 01.02.2024
//Opis:
/*

*/
	
//

//-----------------<[ Funkcje: ]>-------------------
ALockdown_SearchTable(playerid)
{
	for(new i = 0; i < Vlockdown_counter; i++)
	{
		if(VLockdown[i] == PlayerInfo[playerid][pUID])
			return 1;
	}
	return 0;
}

ALockdown_Check(playerid)
{
	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pConnectTime] <= 2)
	{
		if(Lockdown_Mode > 0 && !ALockdown_SearchTable(playerid))
		{
			if(PlayerInfo[playerid][pConnectTime] == 0 && Lockdown_Mode == LOCKDOWN_MODE_NEWACCOUNTS)
				return 1;
			if(PlayerInfo[playerid][pConnectTime] <= 2 && Lockdown_Mode == LOCKDOWN_MODE_YOUNGACCOUNTS)
				return 1;
		}
		else
			return 0;
	}
	return 0;
}

ALockdown_Notify(playerid, type, user = -1)
{
	new adminname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, adminname, sizeof(adminname));
	if(user != -1)
	{
		new username[MAX_PLAYER_NAME];
		GetPlayerName(user, username, sizeof(username));
	}
	new string[128];
	switch(type)
	{
		case LOCKDOWN_MODE_OFFLINE:
		{
			Log(adminLog, INFO, "%s wy��czy� system lockdown.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s wy��czy� system lockdown.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MODE_NEWACCOUNTS:
		{
			Log(adminLog, INFO, "%s w��czy� system lockdown dla nowych kont.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s w��czy� system lockdown dla kont z 0h.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MODE_YOUNGACCOUNTS:
		{
			Log(adminLog, INFO, "%s w��czy� system lockdown dla kont poni�ej 3h.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s w��czy� system lockdown dla kont poni�ej 3h.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MSG_JOINEDSERVER:
		{
			Log(serverLog, INFO, "%s zosta� obj�ty systemem lockdown z powodu nowego konta.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s (%d) zosta� obj�ty lockdown. Ilosc godzin:[%d]", GetNickEx(playerid), playerid, PlayerInfo[playerid][pConnectTime]);
			SendAdminMessage(0xCBCBCB, string);
			format(string, sizeof(string), "Poczekaj na weryfikacje nowego konta przez administracje.");
			SendClientMessage(playerid, COLOR_RED, string);
		}
		case LOCKDOWN_MSG_PENDING:
		{
			format(string, sizeof(string), "[Lockdown]%s oczekuje na weryfikacje.", GetNickEx(playerid));
			SendAdminMessage(0xCBCBCB, string);
		}
		case LOCKDOWN_MSG_REMINDER:
		{
			format(string, sizeof(string), "Poczekaj na weryfikacje nowego konta przez administracje.");
			SendClientMessage(playerid, COLOR_RED, string);
		}
		case LOCKDOWN_MSG_VERIFIED:
		{
			format(string, sizeof(string), "[Lockdown]%s zweryfikowa� gracza %s", GetNickEx(playerid), GetNickEx(user));
			SendAdminMessage(0xF6B26B, string);
			Log(adminLog, INFO, "Admin %s zweryfikowa� gracza %s dla systemu lockdown.", GetPlayerLogName(playerid), GetPlayerLogName(user));
			format(string, sizeof(string), "Zosta�e� pomy�lnie zweryfikowany.");
			SendClientMessage(user, COLOR_WHITE, string);
		}
		case LOCKDOWN_MSG_RULEBREAK:
		{
			format(string, sizeof(string), "[Lockdown]%s dosta� kick z powodu zmiany vw podczas lockdown. VW=%d; Required=%d", GetNickEx(playerid), GetPlayerVirtualWorld(playerid), Lockdown_assignedVW[playerid]);
			SendAdminMessage(0xE06666, string);
			Log(punishmentLog, INFO, "%s zosta� skickowany z serwera z powodu zmiany vw podczas lockdown.", GetPlayerLogName(playerid));
		}
	}
}

ALockdown_ExcludeFromPlaying(playerid)
{
	Lockdown_assignedVW[playerid] = random(500) + 101;
	ALockdown_SetLockdownVW(playerid);
	SetPVarInt(playerid, "Lockdown-izolacja", 1);
	ALockdown_Notify(playerid, LOCKDOWN_MSG_JOINEDSERVER);
	Lockdown_Timer[playerid] = SetTimerEx("ALockdown_Timer",550,true,"d",playerid);
}

ALockdown_SetLockdownVW(playerid)
{
	SetPlayerVirtualWorld(playerid, Lockdown_assignedVW[playerid]);
}

ALockdown_Verified(playerid, admin)
{
	VLockdown[Vlockdown_counter] = PlayerInfo[playerid][pUID];
	Vlockdown_counter++;
	ALockdown_DestroyData(playerid);
	SetPVarInt(playerid, "Lockdown-izolacja", 0);
	SetPlayerVirtualWorld(playerid, 0);
	ALockdown_Notify(admin, LOCKDOWN_MSG_VERIFIED, playerid);
}
ALockdown_DestroyData(playerid)
{
	KillTimer(Lockdown_Timer[playerid]);
	Lockdown_assignedVW[playerid] = 0;
	Lockdown_MSGCounter[playerid] = 0;
	Lockdown_Warning_Counter[playerid] = 0;
}


//end

