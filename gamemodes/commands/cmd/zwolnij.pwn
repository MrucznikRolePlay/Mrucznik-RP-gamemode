//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zwolnij ]------------------------------------------------//
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

YCMD:zwolnij(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /zwolnij [idgracza/FragmentNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pLider] >= 1)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
				    if (PlayerInfo[para1][pMember] > 0 && PlayerInfo[para1][pLider] == 0)
				    {
				        if(PlayerInfo[playerid][pLider] == PlayerInfo[para1][pMember])
						{
							//unfrakcja tu funkcje
							GetPlayerName(para1, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
                            new liderid = PlayerInfo[playerid][pLider];
							Log(serverLog, INFO, "%s wyrzuci³ %s z frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetFractionLogName(liderid));
							format(string, sizeof(string), "Zostales wyrzucony z frakcji %s przez %s.", FractionNames[liderid],sendername);
							sendTipMessageEx(para1, COLOR_LIGHTBLUE, string);
							gTeam[para1] = 3;
							PlayerInfo[para1][pTeam] = 3;
							PlayerInfo[para1][pMember] = 0;
							PlayerInfo[para1][pRank] = 0;
							PlayerInfo[para1][pUniform] = 0;
							PlayerInfo[para1][pTajniak] = 0;
							JobDuty[para1] = 0;
							OnDuty[para1] = 0;
							RmvLSPDMemberFromThiefMapIcons(para1);
							SanDuty[para1] = 0;
							SetTimerEx("AntySB", 5000, 0, "d", para1);
							AntySpawnBroni[para1] = 5;
							UsunBron(para1);
							SetPlayerColor(para1,TEAM_HIT_COLOR);
							SetSpawnInfo(para1, gTeam[para1], PlayerInfo[para1][pSkin],0.0,0.0,0.0,0,0,0,0,0,0,0);
							MedicBill[para1] = 0;
							SetPlayerSpawn(para1);
                            MruMySQL_SetAccInt("Rank", giveplayer, 0);
                            MruMySQL_SetAccInt("Member", giveplayer, 0);
							format(string, sizeof(string), "Wyrzuci³eœ %s ze swojej frakcji %s", giveplayer, FractionNames[liderid]);
							sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
						}
						else
						{
							format(string, sizeof(string), "Gracz %s nie nale¿y do Twojej frakcji.", giveplayer);
							sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
						}
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
