//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ koxubankot ]----------------------------------------------//
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

YCMD:koxubankot(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /koxubankot [playerid/CzêœæNicku] [level(1-5000) - level 0 zabiera admina]");
			return 1;
		}

		if(IsPlayerAdmin(playerid))
		{
            if(Uprawnienia(playerid, ACCESS_OWNER))
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "AdmCmd: %s mianowa³ %s na %d level admina.", sendername, giveplayer, level);
						Log(statsLog, INFO, string);
						format(string, sizeof(string), "   Zosta³eœ mianowany na %d level admina przez %s", level, sendername);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   Da³eœ %s admina o levelu %d.", giveplayer,level);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
				}
				
			}
			else if(PlayerInfo[playerid][pUID] == 6480)//Pluszak
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "AdmCmd: %s mianowa³ %s na %d level admina.", sendername, giveplayer, level);
						Log(statsLog, INFO, string);
						format(string, sizeof(string), "   Zosta³eœ mianowany na %d level admina przez %s", level, sendername);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   Da³eœ %s admina o levelu %d.", giveplayer,level);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
				}
			
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
