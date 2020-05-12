//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------
SetAntyCheatForPlayer(playerid, valueCode)
{
	SetPVarInt(playerid, "AntyCheatOff", valueCode);
	return 1;
}

forward CheckCode2003(killerid, playerid);
public CheckCode2003(killerid, playerid)
{
    new string[256];
    if(IsPlayerConnected(playerid))
	{
    	MruDialog(killerid, "ACv2: Kod #2003", "Zosta³eœ wyrzucony za weapon hack.");
		format(string, sizeof string, "ACv2 [#2003]: %s zosta³ wyrzucony za weapon hack.", GetNickEx(killerid));
    	SendCommandLogMessage(string);
    	KickEx(killerid);
		Log(warningLog, INFO, string);
		Log(punishmentLog, INFO, string);
	}
	else
	{
	    format(string, sizeof string, "ACv2 [#2003] WARNING: Prawdopodobnie próba wymuszenia kodu na graczu %s.", GetNickEx(killerid));
    	SendCommandLogMessage(string);
		Log(warningLog, INFO, string);
	}
}
forward AntyCheatON(playerid);
public AntyCheatON(playerid)
{
	timeAC[playerid]++; 
	if(timeAC[playerid] >= 3)
	{
		SetAntyCheatForPlayer(playerid, 0);
		timeAC[playerid] = 0; 
		KillTimer(timerAC[playerid]); 
	}
}

forward OznaczCzitera(playerid);
public OznaczCzitera(playerid)
{
	new string[71+MAX_PLAYER_NAME];
	SetPVarInt(playerid, "AC_oznaczony", 1);
	if(gettime() > GetPVarInt(playerid, "lastSobMsg"))
	{
		SetPVarInt(playerid, "lastSobMsg", gettime() + 60);
		format(string, sizeof(string), "%s[%d] jest podejrzany o S0beita", GetNick(playerid), playerid);
		SendAdminMessage(COLOR_PANICRED, string);
	}
	return 1;
}

//end