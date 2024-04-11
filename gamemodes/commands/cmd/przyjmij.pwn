//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ przyjmij ]-----------------------------------------------//
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

YCMD:przyjmij(playerid, params[], help)
{
	new string[160];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /przyjmij [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pLider] >= 1)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
				    if (GetPlayerFraction(para1) == 0 && GetPlayerOrg(para1) == 0)
				    {
				        if(PlayerInfo[para1][pJob] > 0)
				        {
				            sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz przyj¹æ tego gracza, gdy¿ posiada ju¿ pracê!");
				            return 1;
				        }
                        new ftextid = PlayerInfo[playerid][pLider];
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pMember] = PlayerInfo[playerid][pLider];
						PlayerInfo[para1][pRank] = 0;
						PlayerInfo[para1][pJob] = 0;
						SetDefaultUniform(para1);
						Log(serverLog, INFO, "%s przyj¹³ %s do frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetFractionLogName(ftextid));
						format(string, sizeof(string), "Zosta³eœ przyjêty do %s przez lidera %s", FractionNames[ftextid], sendername);
						sendTipMessageEx(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "Przyj¹³eœ %s do swojej frakcji %s", giveplayer,FractionNames[ftextid]);
						sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
                        MruMySQL_SetAccInt("Member", giveplayer, PlayerInfo[playerid][pLider]);
                        MruMySQL_SetAccInt("Rank", giveplayer, 0);
					    sendTipMessageEx(para1, COLOR_LIGHTRED, "U¿yj /uniform w sklepie z ciuchami aby zmieniæ ubranie robocze.");
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest obecnie poszukiwany / ma inn¹ frakcjê / jest w rodzinie.");
					    return 1;
					}
				}
			}//not connected
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
