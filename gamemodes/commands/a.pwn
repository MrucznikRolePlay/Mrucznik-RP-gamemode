//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ a ]---------------------------------------------------//
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

CMD:admin(playerid, params[]) return cmd_a(playerid, params);
CMD:a(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/a)dmin [admin chat]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			format(string, sizeof(string), "*%d Admin %s: %s", PlayerInfo[playerid][pAdmin], sendername, params);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendAdminMessage(0xFFC0CB, string);
				SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
			}
			printf("Admin %s: %s", sendername, params);
		}
		if((PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 4) && PlayerInfo[playerid][pAdmin] == 0)
		{
			format(string, sizeof(string), "*%d Pó³Admin %s: %s", PlayerInfo[playerid][pNewAP], sendername, params);
			if (PlayerInfo[playerid][pNewAP] >= 1)
			{
				SendAdminMessage(0xFFC0CB, string);
				SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
			}
			printf("PolAdmin %s: %s", sendername, params);
		}
        if(PlayerInfo[playerid][pNewAP] == 5 && PlayerInfo[playerid][pAdmin] == 0)
        {
            format(string, sizeof(string), "* Skrypter %s: %s", sendername, params);
            if (PlayerInfo[playerid][pNewAP] >= 1)
            {
                SendAdminMessage(0xFFC0CB, string);
				SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
            }
            printf("Skrypter %s: %s", sendername, params);
        }
	}
	return 1;
}

