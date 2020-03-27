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

YCMD:zaufanygracz(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /zg [admin chat]");
			return 1;
		}
		if(PlayerInfo[playerid][Admin] >= 1 || PlayerInfo[playerid][HalfAdmin] >= 1)
		{
			sendTipMessage(playerid, "Zaufani nie istniej¹! PogódŸ siê z tym."); 
			return 1;
		}
		switch (PlayerInfo[playerid][pZG]) {
			case 1: format(string, sizeof(string), "*%d Opiekun IC %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 2: format(string, sizeof(string), "*%d Prawie ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 3: format(string, sizeof(string), "*%d Nowy ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 4: format(string, sizeof(string), "*%d Zaufany Gracz %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 5: format(string, sizeof(string), "*%d Przyzwoity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 6: format(string, sizeof(string), "*%d Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 7: format(string, sizeof(string), "*%d Bardzo Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 8: format(string, sizeof(string), "*%d Œwietny ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 9: format(string, sizeof(string), "*%d Znakomity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			case 10: format(string, sizeof(string), "*%d Æwieræ admin %s: %s",PlayerInfo[playerid][pZG], sendername, params);
		}
		
		SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
		Log(chatLog, INFO, "%s zaufani gracze chat: %s", GetPlayerLogName(playerid), params);
	}
	return 1;
}
