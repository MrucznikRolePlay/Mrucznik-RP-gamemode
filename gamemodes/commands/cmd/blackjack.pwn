//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ blackjack ]-----------------------------------------------//
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

YCMD:blackjack(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1032.69775391,-1092.17980957,-67.58734131) || IsPlayerInRangeOfPoint(playerid, 3.0, 1032.90014648,-1088.91455078,-67.58734131) || IsPlayerInRangeOfPoint(playerid, 3.0, 1023.03601074,-1092.15148926,-67.58734131) || IsPlayerInRangeOfPoint(playerid, 3.0, 1022.98620605,-1088.74023438,-67.58734131))
        {
            new oczko = true_random(13)+2;
            GetPlayerName(playerid, sendername, sizeof(sendername));
            if(oczko >= 2 && oczko <= 10)
            {
			    Log(payLog, INFO, "%s wyci¹gn¹³ kartê: %d", GetPlayerLogName(playerid), oczko);
                format(string, sizeof(string), "* %s wyci¹ga kartê i jest to: %d", sendername, oczko);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(oczko == 11)
            {
			    Log(payLog, INFO, "%s wyci¹gn¹³ kartê: J", GetPlayerLogName(playerid));
                format(string, sizeof(string), "* %s wyci¹ga kartê i jest to: J (walet)", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(oczko == 12)
            {
			    Log(payLog, INFO, "%s wyci¹gn¹³ kartê: Q", GetPlayerLogName(playerid));
                format(string, sizeof(string), "* %s wyci¹ga kartê i jest to: Q (dama)", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(oczko == 13)
            {
			    Log(payLog, INFO, "%s wyci¹gn¹³ kartê: K", GetPlayerLogName(playerid));
                format(string, sizeof(string), "* %s wyci¹ga kartê i jest to: K (król)", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(oczko == 14 || oczko == 15)
            {
			    Log(payLog, INFO, "%s wyci¹gn¹³ kartê: A", GetPlayerLogName(playerid));
                format(string, sizeof(string), "* %s wyci¹ga kartê i jest to: A (as)", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            ZabierzKase(playerid, 100);
			sendTipMessageEx(playerid, TEAM_AZTECAS_COLOR, "Kasyno pobiera op³atê za u¿ycie talii kart (100$)");
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ przy stole do black jacka!");
        }
    }
	return 1;
}
