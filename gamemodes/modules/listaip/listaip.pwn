//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

stock IP5AddIPToList(playerNick[], ip[])
{
	if(ip_5_list_idx >= IP_5_LIST_SIZE)
	{
		ip_5_list_idx = 0;
	}

	new idx = HashMap_Get(ip_5_hashmap, playerNick);
	if(idx == -1)
	{
		HashMap_Set(ip_5_hashmap, playerNick, ip_5_list_idx);
		idx = ip_5_list_idx;
		ip_5_list[idx][IP_LIST_NUMBER_OF_IP] = 0;
		ip_5_list_idx++;
	}

	new numberOfIPs = ip_5_list[idx][IP_LIST_NUMBER_OF_IP];

	if(numberOfIPs == 5)
	{
		for(new i = 0; i < 4; i++)
		{
			format(ip_5_list[idx][IP_LIST_IP5][i][0], IP_5_STR_SIZE, "%s", ip_5_list[idx][IP_LIST_IP5][i+1][0]);
		}
		ip_5_list[idx][IP_LIST_NUMBER_OF_IP] = 4;
		numberOfIPs = 4;
	}

	format(ip_5_list[idx][IP_LIST_IP5][numberOfIPs][0], IP_5_STR_SIZE, "%s", ip);
	ip_5_list[idx][IP_LIST_NUMBER_OF_IP]++;

	return 1;
}

stock IP5ShowIPListStr(playerid, playerNick[])
{
	new ipListStr[IP_5_O_STR_SIZE];
	new idx = HashMap_Get(ip_5_hashmap, playerNick);

	format(ipListStr, IP_5_O_STR_SIZE, "Adresy IP %s:\n", playerNick);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, ipListStr);

	if(idx == -1)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Brak zapisanych adresów.");
	}
	else
	{
		new numberOfIPs = ip_5_list[idx][IP_LIST_NUMBER_OF_IP];
		for(new i = numberOfIPs - 1; i >= 0; i--)
		{
			format(ipListStr, IP_5_O_STR_SIZE, "%d) %s\n", numberOfIPs - i, ip_5_list[idx][IP_LIST_IP5][i][0]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, ipListStr);
		}
	}
}

//end