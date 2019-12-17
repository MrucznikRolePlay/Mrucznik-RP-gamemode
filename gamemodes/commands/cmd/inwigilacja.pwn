//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ innyspawn ]-----------------------------------------------//
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

YCMD:inwigilacja(playerid, params[], help)
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 150)
        {
            new para1;
            if( sscanf(params, "k<fix>", para1))
            {
                sendTipMessage(playerid, "U¿yj /inwiglacja [playerid/CzêœæNicku]");
                return 1;
            }
            
            if(para1 != INVALID_PLAYER_ID)
		    {
		        GetPlayerName(para1, giveplayer, sizeof(giveplayer));
		        if(PlayerInfo[para1][pPodPW] == 0)
				{
                    SendCommandLogMessage(sprintf("Admin %s [%d] w³¹czy³ inwigilacje dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));
					PlayerInfo[para1][pPodPW] = 1;
                    format(string, sizeof(string), "AdmCmd: %s wlaczyl inwigilacje PW %s",GetNick(playerid) ,giveplayer);
					Log(adminLog, INFO, "Admin %s w³¹czy³ inwigilacje /w dla gracza %s", GetPlayerLogName(playerid), GetPlayerLogName(para1));
				}
				else
				{
                    SendCommandLogMessage(sprintf("Admin %s [%d] wy³¹czy³ inwigilacje dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));
					PlayerInfo[para1][pPodPW] = 0;
					Log(adminLog, INFO, "Admin %s wy³¹czy³ inwigilacje /w dla gracza %s", GetPlayerLogName(playerid), GetPlayerLogName(para1));
				}
			}
        }
        else if(PlayerInfo[playerid][pAdmin] >= 1)
        {
            new para1;
            if( sscanf(params, "k<fix>", para1))
            {
                sendTipMessage(playerid, "U¿yj /inwiglacja [playerid/CzêœæNicku]");
                return 1;
            }
            if(para1 != INVALID_PLAYER_ID)
		    {
		        GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                if(PlayerInfo[para1][pPodPW] == 1)
				{
                    SendCommandLogMessage(sprintf("Admin %s [%d] wy³¹czy³ inwigilacje dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));
					PlayerInfo[para1][pPodPW] = 0;
					Log(adminLog, INFO, "Admin %s wy³¹czy³ inwigilacje /w dla gracza %s", GetPlayerLogName(playerid), GetPlayerLogName(para1));
                }
                else
                {
                    sendTipMessage(playerid, "Komenda dostêpna od 150@lvl.")
                }
            }
        }
        else
        {
            return 1;
        }
    }
    return 1;
}
