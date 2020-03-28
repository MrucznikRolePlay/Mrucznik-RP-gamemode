//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ setstrong ]-----------------------------------------------//
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

YCMD:setstrong(playerid, params[], help)
{
	new valueStrong, giveplayerid;
	new string[128];
	if( sscanf(params, "k<fix>d", giveplayerid, valueStrong))
	{
		sendTipMessage(playerid, "U¿yj /setstrong [ID] [Wartoœæ] ");
		return 1;
	}
	if(valueStrong >= MAX_STRONG_VALUE)
	{
		format(string, sizeof(string), "Nie mo¿esz ustaliæ wartoœci wiêkszej jak %d", MAX_STRONG_VALUE);
		sendTipMessage(playerid, string); 
		return 1;
	}
	if(IsPlayerConnected(playerid) && IsPlayerConnected(giveplayerid))
	{
		if(PlayerInfo[giveplayerid][pStrong] != MAX_STRONG_VALUE)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3500 || IsAScripter(playerid))
			{
				format(string, sizeof(string), "Administrator %s ustali³ Ci wartoœæ si³y na %d [Poprzednia wartoœæ %d]", GetNickEx(playerid), valueStrong, PlayerInfo[giveplayerid][pStrong]);
				sendTipMessageEx(giveplayerid, COLOR_P@, string);
				format(string, sizeof(string), "Ustali³eœ wartoœæ si³y %s na %d - jego poprzednia wartoœæ to %d", GetNick(giveplayerid), valueStrong, PlayerInfo[giveplayerid][pStrong]); 
				sendTipMessageEx(playerid, COLOR_P@, string); 
				PlayerInfo[giveplayerid][pStrong] = valueStrong;
			}
			else
			{
				sendTipMessage(playerid, "Brak wystarczaj¹cych uprawnieñ"); 
				return 1;
			}
		}
		else
		{
			sendTipMessage(playerid, "Ten gracz ma ju¿ maksymaln¹ wartoœæ si³y!"); 
			return 1;
		}
	
	}
	else
	{
		sendTipMessage(playerid, "Gracz nie jest pod³¹czony"); 
	}
	return 1;
}
