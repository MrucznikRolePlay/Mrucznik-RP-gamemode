//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ unblock ]------------------------------------------------//
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

YCMD:unblock(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /unblock [nick]");
			return 1;
		}
        if(MruMySQL_Unblock(params, playerid))
        {
    		format(string, sizeof(string), "Administrator %s ublokowa³ %s", sendername, params);
            //SendPunishMessage(string);
            ABroadCast(COLOR_YELLOW,string,1);
            Log(punishmentLog, INFO, "Admin %s odblokowa³ %s", GetPlayerLogName(playerid), params);
        }
	}
	return 1;
}
