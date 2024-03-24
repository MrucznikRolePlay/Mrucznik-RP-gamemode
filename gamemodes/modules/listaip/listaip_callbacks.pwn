//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  listaip                                                  //
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
// Autor: NikodemBanan
// Data utworzenia: 20.03.2024
//Opis:
/*
	Wyœwietlanie 5 ostatnich adresów IP, na których gra³ gracz pod danym nickiem.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnGameModeInit()
{
	HashMap_Init(ip_5_hashmap, ip_5_list, E_IP5_HASH_DATA);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	new ip[32];
	GetPlayerIp(playerid, ip, sizeof(ip));

	new idx = HashMap_Get(ip_5_hashmap, GetNick(playerid));
	if(idx != -1)
	{
		new numberOfIPs = ip_5_list[idx][IP_LIST_NUMBER_OF_IP];
		for(new i = 0; i < numberOfIPs; i++)
		{
			if(strcmp(ip, ip_5_list[idx][IP_LIST_IP5][i][0]) == 0)
			{
				return Y_HOOKS_CONTINUE_RETURN_1;
			}
		}
	}

	IP5AddIPToList(GetNick(playerid), ip);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

//end