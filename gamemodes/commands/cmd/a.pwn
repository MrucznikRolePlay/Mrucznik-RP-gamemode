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
	new string[144];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U?yj (/a)dmin [admin chat]");
			return 1;
		}
		
		new rankname[10];
		if(PlayerInfo[playerid][pAdmin] >= 1) 
		{
			format(rankname, sizeof(rankname), "%d Admin", PlayerInfo[playerid][pAdmin]);
		}
		else if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 4)
		{
			format(rankname, sizeof(rankname), "%d Pó³Admin", PlayerInfo[playerid][pNewAP]);
		}
		else if(IsAScripter(playerid))
		{
			format(rankname, sizeof(rankname), "Skrypter");
		}
		else 
		{
			noAccessMessage(playerid);
			return 1;
		}
		
		format(string, sizeof(string), "*%s %s: %s", rankname, sendername, params);
		SendAdminMessage(0xFFC0CB, string);
		SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
	}
	return 1;
}



