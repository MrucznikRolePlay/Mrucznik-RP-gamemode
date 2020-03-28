//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ cnn ]--------------------------------------------------//
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

YCMD:cnn(playerid, params[], help)
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /cnn [cnn formattextu ~n~=Nowalinia ~r~=Czerwony ~g~=Zielony ~b~=Niebieski ~w~=Bia³y ~y~=¯ó³ty]");
			return 1;
		}
		new string[128];
		//
		format(string, sizeof(string), "~b~%s: ~w~%s",GetNickEx(playerid),params);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				GameTextForPlayer(i, string, 5000, 6);
			}
		}
        Log(adminLog, INFO, "Admin %s u¿y³ /cnn o treœci: %s", GetPlayerLogName(playerid), params);
		return 1;
	}
	else
	{
		noAccessMessage(playerid);
		return 1;
	}
}
