//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ setac ]-------------------------------------------------//
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

YCMD:setac(playerid, params[], help)
{
	if(PlayerInfo[playerid][Admin] >= 1000 || IsAScripter(playerid))
	{
		new string[128];
		new ac_option;
		new onoff;
		
		if(sscanf(params, "dD(-1)", ac_option, onoff)) 
		{
			sendTipMessage(playerid, "U¿yj /setac [id opcji] (on = 1, off = 0, -1/nic - status)");
			return 1; 
		}
		
		if(ac_option == -1)
		{
			for(new i; i<sizeof(nexac_ac_names); i++)
			{
				format(string, sizeof(string), "AC: %s = %s", nexac_ac_names[i], (IsAntiCheatEnabled(i)) ? "true" : "false");
				SendClientMessage(playerid, -1, string);
			}
			return 1;
		}
		if(ac_option >= sizeof(nexac_ac_names) || ac_option < 0)
		{
			SendClientMessage(playerid, -1, "Nie ma takiej opcji");
			return 1;
		}
		
		//panel ac
		if(onoff == -1)
		{
			format(string, sizeof(string), "AC set: %s = %s", nexac_ac_names[ac_option], (IsAntiCheatEnabled(ac_option)) ? "true" : "false");
			SendClientMessage(playerid, -1, string);
		}
		else if(onoff == 0 || onoff == 1)
		{
			EnableAntiCheat(ac_option, onoff);
			format(string, sizeof(string), "AC set: %s = %s", nexac_ac_names[ac_option], (IsAntiCheatEnabled(ac_option)) ? "true" : "false");
			SendClientMessage(playerid, -1, string);
		}
		else
		{
			SendClientMessage(playerid, -1, "1 - on, 0 - off, -1 - status");
			return 1; 
		}
	}
	return 1;
}
