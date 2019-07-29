//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: anty-vpn.pwn ]---------------------------------------------//
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
#include <a_http>

//------------------<[ Makra: ]>-------------------
//------------------<[ Define: ]>-------------------
//-----------------<[ Zmienne: ]>-------------------
new race_check[MAX_PLAYERS];

//------------------<[ Enumy: ]>--------------------
//------------------<[ Forwardy: ]>--------------------
//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -anty-vpn- loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -anty-vpn- unloaded");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid) 
{
	new ip[16], string[64];
	race_check[playerid] = playerid;
	GetPlayerIp(playerid, ip, sizeof(ip));
	format(string, sizeof string, "51.68.141.69:8088/check?ip=", ip);
	HTTP(playerid, HTTP_GET, string, "", "Mru_AntyVPNResponse");
}

public OnPlayerDisconnect(playerid, reason)
{
	race_check[playerid] = -1;
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
stock Mru_AntyVPNResponse(playerid, response_code, data[])
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	if(race_check[playerid] != playerid)
	{
		if(strcmp(data, "true", false) == 0) 
		{
			SendClientMessage(playerid, 0xFF0000FF, "U¿ywanie VPN'a na serwerze jest zabronione! Zostajesz skickowany.");
			CallLocalFunction("KickEx", "i", playerid);
			printf("ANTY-VPN: Player %s[%d] was kicked for using VPN.", name, id);
			return 1;
		}
		
		if(strcmp(data, "false", false) != 0)
		{
			printf("Error! Problem in anty-vpn request for playerd %s[%d], response: %s (%d)", name, playerid, data, response_code);
		}
	}
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------