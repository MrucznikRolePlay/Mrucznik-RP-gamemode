//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmienwiek ]-----------------------------------------------//
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

CMD:setwiek(playerid, params[]) return cmd_zmienwiek(playerid, params);
CMD:setage(playerid, params[]) return cmd_zmienwiek(playerid, params);
CMD:zmienwiek(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setwiek [playerid/CzêœæNicku] [wiek]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		    	if(para1 != INVALID_PLAYER_ID)
	        	{
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pAge] = level;
					printf("AdmCmd: %s zmieni³ wiek %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój wiek zosta³ zmieniony na %d lat przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ wiek graczowi %s na %d lat.", giveplayer,level);
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
