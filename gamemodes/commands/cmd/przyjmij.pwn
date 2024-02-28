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
                        if(PlayerInfo[playerid][pLider] == 1) { PlayerInfo[para1][pTeam] = 2; PlayerInfo[para1][pUniform] = 280; }
				        else if(PlayerInfo[playerid][pLider] == 2) { PlayerInfo[para1][pTeam] = 2; PlayerInfo[para1][pUniform] = 286;  }
				        else if(PlayerInfo[playerid][pLider] == 3) { PlayerInfo[para1][pTeam] = 2; PlayerInfo[para1][pUniform] = 71; }
				        else if(PlayerInfo[playerid][pLider] == 4) { PlayerInfo[para1][pTeam] = 1; PlayerInfo[para1][pUniform] = 70; }
				        else if(PlayerInfo[playerid][pLider] == 5) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 258; }
				        else if(PlayerInfo[playerid][pLider] == 6) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 117; }
				        else if(PlayerInfo[playerid][pLider] == 7) { PlayerInfo[para1][pTeam] = 12; PlayerInfo[para1][pUniform] = 59; }
				        else if(PlayerInfo[playerid][pLider] == 8) { PlayerInfo[para1][pTeam] = 10; PlayerInfo[para1][pUniform] = 127; }
				        else if(PlayerInfo[playerid][pLider] == 9) { PlayerInfo[para1][pTeam] = 12; PlayerInfo[para1][pUniform] = 148; }
				        else if(PlayerInfo[playerid][pLider] == 10) { PlayerInfo[para1][pTeam] = 12; PlayerInfo[para1][pUniform] = 253; }
				        else if(PlayerInfo[playerid][pLider] == 11) { PlayerInfo[para1][pTeam] = 12; PlayerInfo[para1][pUniform] = 60; }
				        else if(PlayerInfo[playerid][pLider] == 12) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 270; }
				        else if(PlayerInfo[playerid][pLider] == 13) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 103; }
				        else if(PlayerInfo[playerid][pLider] == 14) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 108; }
                        else if(PlayerInfo[playerid][pLider] == 15) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 8; }
                        else if(PlayerInfo[playerid][pLider] == 16) { PlayerInfo[para1][pTeam] = 5; PlayerInfo[para1][pUniform] = 206; }
                        else if(PlayerInfo[playerid][pLider] == 17) { PlayerInfo[para1][pTeam] = 1; PlayerInfo[para1][pUniform] = 278;}
						else return 1;
                        new ftextid = PlayerInfo[playerid][pLider];
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pMember] = PlayerInfo[playerid][pLider];
						PlayerInfo[para1][pRank] = 0;
						PlayerInfo[para1][pJob] = 0;
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
