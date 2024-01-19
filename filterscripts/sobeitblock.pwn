//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: sobeitblock.pwn ]---------------------------------------------//
//Opis:
/*
*/
//Adnotacje:
/*
    Chuj ci w dupe ksenon.
*/
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

//

#include <a_samp>


//------------------<[ Define: ]>-------------------
#undef MAX_PLAYERS
#define MAX_PLAYERS 500
#define MAX_UPDATE_COUNT 10

//-----------------<[ Zmienne: ]>-------------------
new string[256];
new File:fSobeitLog;
new pUpdateCount[MAX_PLAYERS];
new bool:pClientCheck[MAX_PLAYERS][2];

//------------------<[ Forwardy: ]>--------------------
forward KickPlayer(playerid);

//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
    new year, month, day;
    getdate(year, month, day);

    format(string, sizeof(string), "sobeitlog/%d_%02d_%02d.txt", year, month, day);
    fSobeitLog = fopen(string, io_append);

	print("\n--------------------------------------");
	print(" Fliterscript -sobeitblock- zaladowany");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -sobeitblock- wylaczony");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientCheck(playerid, 5, 0x5E8606, 0, 2);
    SendClientCheck(playerid, 69, 0x3A9ED, 0, 2); // 0.3.DL

    return 1;
}

public OnPlayerUpdate(playerid)
{
    if (pUpdateCount[playerid] != -1 && ++ pUpdateCount[playerid] == MAX_UPDATE_COUNT)
    {
        pUpdateCount[playerid] = -1;

        OznaczCzitera(playerid);
        // KickPlayerForSobeit(playerid);
    }

    return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    if (actionid == 5 && memaddr == 0x5E8606)
    {
        pClientCheck[playerid][0] = true;

        if (retndata != 204)
        {
            OznaczCzitera(playerid);
            // KickPlayerForSobeit(playerid);
        }
    }
    else if (actionid == 69 && memaddr == 0x3A9ED)
    {
        pClientCheck[playerid][1] = true;

        if (retndata != 136)
        {
            OznaczCzitera(playerid);
            // KickPlayerForSobeit(playerid);
        }
    }

    if (pClientCheck[playerid][0] && pClientCheck[playerid][1])
    {
        pUpdateCount[playerid] = -1;
    }

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    pUpdateCount[playerid] = 0;
	pClientCheck[playerid] = bool:{false, false};

    return 1;
}

public KickPlayer(playerid)
{
    return Kick(playerid);
}

//-----------------<[ Funkcje: ]>-------------------
OznaczCzitera(playerid)
{
    return CallRemoteFunction("OznaczCzitera", "i", playerid);
}

stock ReturnPlayerName(playerid)
{
    new name[MAX_PLAYER_NAME + 1];
    
    if (IsPlayerConnected(playerid))
    {
        if (GetPVarType(playerid, "maska_nick") != PLAYER_VARTYPE_NONE)
        {
            GetPVarString(playerid, "maska_nick", name, sizeof(name));
        }
        else
        {
            GetPlayerName(playerid, name, sizeof(name));
        }
    }

    return name;
}

stock ReturnPlayerIp(playerid)
{
    new ip[16];
    GetPlayerIp(playerid, ip, sizeof(ip));
    return ip;
}

stock KickPlayerForSobeit(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }

    SendClientMessage(playerid, 0xFF000000, "Wykryto niedozwolone programy, zostajesz wyrzucony(-na).");

    format(string, sizeof(string), "Gracz %s IP (%s) zosta³ wyrzucony przez AC. Powód: Sobeit", ReturnPlayerName(playerid), ReturnPlayerIp(playerid));
    AddPlayerToLog(string);

    SetTimerEx("KickPlayer", 1000, false, "d", playerid);
    return 1;
}

stock AddPlayerToLog(const str[])
{
    new
        year, month, day,
        hour, minute, second;

	getdate(year, month, day);
    gettime(hour, minute, second);

	format(string, sizeof(string), "%02d:%02d:%02d %s\r\n", hour, minute, second, str);
	fwrite(fSobeitLog, string);
}
