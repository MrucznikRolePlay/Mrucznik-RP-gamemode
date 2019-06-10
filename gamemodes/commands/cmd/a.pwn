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

YCMD:a(playerid, params[], help)
{
	new string[144];
    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/a)dmin [admin chat]");
			return 1;
		}
		
		new rankname[10+MAX_PLAYER_NAME];
		if(PlayerInfo[playerid][pAdmin] >= 1) 
		{
			format(rankname, sizeof(rankname), "Admin [%d] %s:", PlayerInfo[playerid][pAdmin]);
		}
		else if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 4)
		{
			format(rankname, sizeof(rankname), "Pó³-Admin [%d] %s:", PlayerInfo[playerid][pNewAP]);
		}
		else if(IsAScripter(playerid))
		{
			format(rankname, sizeof(rankname), "Skrypter %s:");
		}
		else 
		{
			noAccessMessage(playerid);
			return 1;
		}
		SendAdminMessage(0xFFC0CB, string);
		SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
	}
	return 1;
}



