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
#define VPN_SERVICE_ADDRESS "51.68.141.69"
#define VPN_SERVICE_PORT ":8088"

//-----------------<[ Zmienne: ]>-------------------
new race_check[MAX_PLAYERS];
new vpnCheckServiceOnLine = false;

//------------------<[ Enumy: ]>--------------------
//------------------<[ Forwardy: ]>--------------------
forward Mru_AntyVPNResponse(playerid, response_code, data[]);
forward Mru_AntyVPNTest(id, response_code, data[]);

//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -anty-vpn- loaded");
	print("--------------------------------------\n");
	
	print("ANTY-VPN: Sending test request");
	HTTP(0, HTTP_GET, VPN_SERVICE_ADDRESS VPN_SERVICE_PORT "/check?ip=1.236.132.203", "", "Mru_AntyVPNTest");
	
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
	if(vpnCheckServiceOnLine)
	{
		new ip[16], string[64];
		race_check[playerid] = playerid;
		GetPlayerIp(playerid, ip, sizeof(ip));
		format(string, sizeof string, VPN_SERVICE_ADDRESS VPN_SERVICE_PORT "/check?ip=", ip);
		HTTP(playerid, HTTP_GET, string, "", "Mru_AntyVPNResponse");
	}
}

public OnPlayerDisconnect(playerid, reason)
{
	race_check[playerid] = -1;
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
public Mru_AntyVPNResponse(playerid, response_code, data[])
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	if(race_check[playerid] != playerid)
	{
		if(strcmp(data, "true", false) == 0) 
		{
			SendClientMessage(playerid, 0xFF0000FF, "U¿ywanie VPN'a na serwerze jest zabronione! Zostajesz skickowany.");
			CallLocalFunction("KickEx", "i", playerid);
			printf("ANTY-VPN: Player %s[%d] was kicked for using VPN.", name, playerid);
			return 1;
		}
		
		if(strcmp(data, "false", false) != 0)
		{
			printf("Error! Problem in anty-vpn request for playerid %s[%d], response: %s (%d)", name, playerid, data, response_code);
		}
	}
	return 1;
}

public Mru_AntyVPNTest(id, response_code, data[])
{
	printf("ANTY-VPN: test request result: %s (%d)", data, response_code);
	if(response_code == 200 && strcmp(data, "true", false) == 0) {
		vpnCheckServiceOnLine = true;
	}
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------