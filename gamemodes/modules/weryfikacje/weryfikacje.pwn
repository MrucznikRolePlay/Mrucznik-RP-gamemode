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
// Autor: Sanda³
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
	if(IsPlayerConnected(playerid) && Lockdown_Mode > 0)
	{
		if(!ALockdown_SearchTable(playerid))
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
			Log(adminLog, INFO, "%s wy³¹czy³ system lockdown.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s wy³¹czy³ system lockdown.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MODE_NEWACCOUNTS:
		{
			Log(adminLog, INFO, "%s w³¹czy³ system lockdown dla nowych kont.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s w³¹czy³ system lockdown dla kont z 0h.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MODE_YOUNGACCOUNTS:
		{
			Log(adminLog, INFO, "%s w³¹czy³ system lockdown dla kont poni¿ej 2h.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s w³¹czy³ system lockdown dla kont poni¿ej 3h.", GetNickEx(playerid));
			SendAdminMessage(0xFF9900, string);
		}
		case LOCKDOWN_MSG_JOINEDSERVER:
		{
			Log(adminLog, INFO, "%s zosta³ objêty systemem lockdown z powodu nowego konta.", GetPlayerLogName(playerid));
			format(string, sizeof(string), "[Lockdown]%s zosta³ objêty lockdown. Ilosc godzin:[%d]", GetNickEx(playerid), PlayerInfo[playerid][pConnectTime]);
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
			format(string, sizeof(string), "[Lockdown]%s zweryfikowa³ gracza %s", GetNickEx(playerid), GetNickEx(user));
			SendAdminMessage(0xF6B26B, string);
			Log(adminLog, INFO, "%s zweryfikowa³ gracza %s dla systemu lockdown.", GetPlayerLogName(playerid), GetPlayerLogName(user));
		}
		case LOCKDOWN_MSG_RULEBREAK:
		{
			format(string, sizeof(string), "[Lockdown]%s dosta³ kick z powodu zmiany vw podczas lockdown. VW=%d; Required=%d", GetNickEx(playerid), GetPlayerVirtualWorld(playerid), Lockdown_assignedVW[playerid]);
			SendAdminMessage(0xE06666, string);
			Log(punishmentLog, INFO, "%s zosta³ skickowany z serwera z powodu zmiany vw podczas lockdown.", GetPlayerLogName(playerid));
		}
	}
}

ALockdown_ExcludeFromPlaying(playerid)
{
	Lockdown_assignedVW[playerid] = random(500) + 101;
	SetPlayerVirtualWorld(playerid, Lockdown_assignedVW[playerid]);
	ALockdown_Notify(playerid, LOCKDOWN_MSG_JOINEDSERVER);
	Lockdown_Timer[playerid] = SetTimerEx("ALockdown_Timer",700,true,"d",playerid);
}

ALockdown_Verified(playerid, admin)
{
	VLockdown[Vlockdown_counter] = PlayerInfo[playerid][pUID];
	Vlockdown_counter++;
	ALockdown_DestroyData(playerid);
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

public ALockdown_Timer(playerid)
{
	if(ALockdown_Check(playerid) == true)
	{
		if(GetPlayerVirtualWorld(playerid) != Lockdown_assignedVW[playerid] && PlayerInfo[playerid][pTut] == 1)
		{
			Lockdown_Warning_Counter[playerid]++;
			if(Lockdown_Warning_Counter[playerid] >= 4)
			{
				ALockdown_Notify(playerid, LOCKDOWN_MSG_RULEBREAK);
				KickEx(playerid);
				ALockdown_DestroyData(playerid);
			}
			SetPlayerVirtualWorld(playerid, Lockdown_assignedVW[playerid]);
		}
		Lockdown_MSGCounter[playerid]++;
		if(Lockdown_MSGCounter[playerid] >= 270)
		{
			ALockdown_Notify(playerid, LOCKDOWN_MSG_PENDING);
			Lockdown_MSGCounter[playerid] = 0;
		}
		else if(Lockdown_MSGCounter[playerid] == 160)
			ALockdown_Notify(playerid, LOCKDOWN_MSG_REMINDER);
		else if(Lockdown_MSGCounter[playerid] == 70)
			ALockdown_Notify(playerid, LOCKDOWN_MSG_REMINDER);
	}
	else
		ALockdown_DestroyData(playerid);
}


//end

