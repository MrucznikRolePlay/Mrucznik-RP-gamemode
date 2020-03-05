//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ fdaj ]-------------------------------------------------//
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

YCMD:fdaj(playerid, params[], help)
{
	new string[256];
    if(PlayerInfo[playerid][pAdmin] >=10 || IsAScripter(playerid))
	{
	    new giveplayerid, level;
		if( sscanf(params, "k<fix>d", giveplayerid, level))
		{
			sendTipMessage(playerid, "U¿yj /fdaj [id gracza] [id stylu]");
			return 1;
		}

		if(level == 4 || level == 5 || level == 6 || level == 7 || level == 15 || level == 16)
		{
			if(PlayerInfo[playerid][pLevel] >= 1)
			{
				SetPlayerFightingStyle(playerid, level);
				format(string, sizeof(string), "Administrator %s ustawi³ Ci styl walki na %d", GetNickEx(playerid), level); 
				sendTipMessageEx(giveplayerid, COLOR_P@, string); 
				format(string, sizeof(string), "Ustawi³eœ styl walki dla %s na %d", GetNick(giveplayerid), level);
				sendTipMessageEx(playerid, COLOR_P@, string); 
			}
		}
		else
		{
			return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Dostêpne style walk:\n\n4 - FIGHT_STYLE_NORMAL\n5 - FIGHT_STYLE_BOXING\n6 - FIGHT_STYLE_KUNGFU\n7 - FIGHT_STYLE_KNEEHEAD\n15 - FIGHT_STYLE_GRABKICK\n16 - FIGHT_STYLE_ELBOW"); 
		}
	}
	return 1;
}
