//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: sobeitblock.pwn ]---------------------------------------------//
//Opis:
/*
*/
//Adnotacje:
/*
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
new pUpdateCount[MAX_PLAYERS];
new bool:pSobeit[MAX_PLAYERS];
new bool:pClientCheck[MAX_PLAYERS][2];

//------------------<[ Forwardy: ]>--------------------
forward KickPlayer(playerid);

//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Filterscript -sobeitblock- zaladowany");
    print("--------------------------------------\n");
    return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
    print(" Filterscript -sobeitblock- wylaczony");
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
    pSobeit[playerid] = false;
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
    if (!IsPlayerConnected(playerid) || pSobeit[playerid])
    {
        return 0;
    }

    pSobeit[playerid] = true;

    SendClientMessage(playerid, 0xFF000000, "Wykryto niedozwolone programy, zostajesz wyrzucony(-na).");

    printf("Gracz %s IP (%s) zostal wyrzucony przez AC. Powod: Sobeit", ReturnPlayerName(playerid), ReturnPlayerIp(playerid));

    SetTimerEx("KickPlayer", 1000, false, "d", playerid);
    return 1;
}
