//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setskin ]------------------------------------------------//
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

CMD:setskin(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setskin [playerid/CzêœæNicku] [id skinu]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 311)
				{
					sendTipMessage(playerid, "Numer skinu od 0 do 311!");
					if(PlayerInfo[playerid][pAdmin] != 12345)
					{
						return 1;
					}
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby nadaæ skina gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pModel] = level;
					PlayerInfo[para1][pSkin] = level;
					printf("AdmCmd: %s zmieni³ skin gracza %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój skin zosta³ zmieniony na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ skin graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else if (PlayerInfo[playerid][pAdmin] >= 3 && para1 == playerid)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 311)
				{
					sendTipMessage(playerid, "Numer skinu od 0 do 311!");
					if(PlayerInfo[playerid][pAdmin] != 12345)
					{
						return 1;
					}
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby nadaæ skina gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pModel] = level;
					printf("AdmCmd: %s zmieni³ skin gracza %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój skin zosta³ zmieniony na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ skin graczowi %s na %d.", giveplayer,level);
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
