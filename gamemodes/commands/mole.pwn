//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ mole ]-------------------------------------------------//
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

CMD:mole(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pAdmin] >= 100)
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /mole [mole text]");
			return 1;
		}
		
        format(string, sizeof(string), "CMD_Info: /mole u¿yte przez %s [%d] - %s", GetNick(playerid), playerid, params);
        CMDLog(string);
		SendCommandLogMessage(string);
		
		SendSMSMessageToAll(555, params); //mole
	}
	return 1;
}

/*CMD:hq(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pLider] == 1 || PlayerInfo[playerid][pLider] == 2 || PlayerInfo[playerid][pLider] == 3)
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			//sendTipMessage(playerid, "U¿yj /hq [hq text]");
			return 1;
		}
		format(string, sizeof(string), "HQ: %s, bez odbioru", params);
		if (gTeam[playerid] != 2 ){SendClientMessage(playerid, COLOR_DBLUE, string);}
		SendTeamBeepMessage(2, COLOR_DBLUE, string);
		printf("HQ: %s", params);
	}
	return 1;
}*/

