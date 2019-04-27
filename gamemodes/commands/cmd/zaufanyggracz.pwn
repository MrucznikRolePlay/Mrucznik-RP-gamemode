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

CMD:zaufanyggracz(playerid, params[])
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
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
			sendTipMessage(playerid, "Zaufani nie istniej¹! PogódŸ siê z tym."); 
			return 1;
		}
		if(PlayerInfo[playerid][pZG] == 1)
		{
			format(string, sizeof(string), "*%d Opiekun IC %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 2)
		{
			format(string, sizeof(string), "*%d Prawie ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 3)
		{
			format(string, sizeof(string), "*%d Nowy ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 4)
		{
			format(string, sizeof(string), "*%d Zaufany Gracz %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 5)
		{
			format(string, sizeof(string), "*%d Przyzwoity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 6)
		{
			format(string, sizeof(string), "*%d Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 7)
		{
			format(string, sizeof(string), "*%d Bardzo Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 8)
		{
			format(string, sizeof(string), "*%d Œwietny ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 9)
		{
			format(string, sizeof(string), "*%d Znakomity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 10)
		{
			format(string, sizeof(string), "*%d Æwieræ admin %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}

	}
	return 1;
}

