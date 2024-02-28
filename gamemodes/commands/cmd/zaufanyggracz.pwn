//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ zaufanyggracz ]---------------------------------------------//
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

YCMD:zg(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /zg [admin chat]");
			return 1;
		}
		if(PlayerInfo[playerid][pZG] > 0) 
		{
			switch (PlayerInfo[playerid][pZG]) {
				case 10: format(string, sizeof(string), "* Zas�u�ony %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			}
		}
		else if(PlayerInfo[playerid][pAdmin] >= 5000) 
		{
			format(string, sizeof(string), "* H@ %s: %s", sendername, params);
		}
		else if(PlayerInfo[playerid][pAdmin] >= 1) 
		{
			format(string, sizeof(string), "* Admin %s: %s", sendername, params);
		}
		else if(IsAScripter(playerid))
		{
			format(string, sizeof(string), "* Skrypter %s - %s", sendername, params);
		}
		*/
		
		SendZGMessage(COLOR_BROWN, string);
		Log(chatLog, INFO, "%s zaufani gracze chat: %s", GetPlayerLogName(playerid), params);
	}
	return 1;
}
