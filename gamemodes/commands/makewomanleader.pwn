//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ makewomanleader ]--------------------------------------------//
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

CMD:makewomanleader(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /makewomanleader [ID gracza] [Numer (1-17)]");
			return 1;
		}

		if(level > 17 || level < 0) { sendTipMessageEx(playerid, COLOR_GREY, "Od 0 do 17 !"); return 1; }
		if (Uprawnienia(playerid, ACCESS_MAKELEADER))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(level != 0)
                    {
    		            if(PlayerInfo[playerid][pMember] > 0 || GetPlayerOrg(para1) != 0)
    		            {
    		                sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest we frakcji jako cz³oenk lub w rodzinie !");
    		                return 1;
    		            }
                    }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pLider] = level;
					format(string, sizeof(string), "Zosta³eœ mianowany liderem frakcji przez Administratora: %s", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Da³eœ kontrolê graczowi %s nad frakcj¹ numer %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
					format(string, sizeof(string), "%s dal kontrole nad frakcja numer %d graczowi %s", sendername, level, giveplayer);
					ActionLog(string);
					
					if(level == 0) { PlayerInfo[para1][pSkin] = 0; }
					else if(level == 1) { PlayerInfo[para1][pSkin] = 93; } //Police Force
					else if(level == 2) { PlayerInfo[para1][pSkin] = 193; } //FBI/ATF
					else if(level == 3) { PlayerInfo[para1][pSkin] = 191; } //National Guard
					else if(level == 4) { PlayerInfo[para1][pSkin] = 69; } //Fire/Ambulance
					else if(level == 5) { PlayerInfo[para1][pSkin] = 211; } //La Cosa Nostra
					else if(level == 6) { PlayerInfo[para1][pSkin] = 169; } //Yakuza
					else if(level == 7) { PlayerInfo[para1][pSkin] = 141; } //Mayor
					else if(level == 8) { PlayerInfo[para1][pSkin] = 219; } //Hitman Agency
					else if(level == 9) { PlayerInfo[para1][pSkin] = 141; } //News Reporters
					else if(level == 10) { PlayerInfo[para1][pSkin] = 192; } //Taxi Cab Company
					else if(level == 11) { PlayerInfo[para1][pSkin] = 150; } //Driving/Flying School
					else if(level == 12) { PlayerInfo[para1][pSkin] = 237; } //Mafia so³ncewska
					else if(level == 13) { PlayerInfo[para1][pSkin] = 195; } //Grove Street
					else if(level == 14) { PlayerInfo[para1][pSkin] = 13; } //Ballas
					else if(level == 15) { PlayerInfo[para1][pSkin] = 192; } //NoA
					else if(level == 16) { PlayerInfo[para1][pSkin] = 129; } //WPS
                    else if(level == 17) { PlayerInfo[para1][pSkin] = 278; } //WPS
				    gTeam[para1] = 19;
				    PlayerInfo[para1][pTeam] = 19;
                    PlayerInfo[para1][pRank] = 6;
                    if(PlayerInfo[para1][pSkin] != 0) SetPlayerSkin(para1, PlayerInfo[para1][pSkin]);
                    else SetPlayerSkin(para1, PlayerInfo[para1][pModel]);
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

