//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setteam ]------------------------------------------------//
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

CMD:setteam(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setteam [playerid/CzêœæNicku] [team 1(civ) - 2(cop)]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pTeam] = level;
					gTeam[para1] = level;
					//SetPlayerWeapons(para1);
					SetPlayerSpawn(para1);
					printf("AdmCmd: %s zmienil druzyne %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "Twoja dru¿yna zosta³a zmieniona na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Zmieni³eœ dru¿ynê graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
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
