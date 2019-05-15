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
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		//
		format(string, sizeof(string), "~b~%s: ~w~%s",sendername,params);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				GameTextForPlayer(i, string, 5000, 6);
			}
		}
        Log(cmdLog, INFO, string);
		return 1;
	}
	else
	{
		noAccessMessage(playerid);
		return 1;
	}
}
