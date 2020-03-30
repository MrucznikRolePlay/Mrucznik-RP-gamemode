//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kolo ]-------------------------------------------------//
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

YCMD:kolo(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1016.93560791,-1101.91369629,-67.59101868))
        {
            if(kaska[playerid] < 5000)
            {
                return SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Potrzebujesz $5000 aby zakrêciæ ko³em.");
            }
            
            new kolo = true_random(61);
            GetPlayerName(playerid, sendername, sizeof(sendername));
            if(kolo >= 1 && kolo <= 30)//1
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na: 1$", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(kolo > 30 && kolo <= 45)//2
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na: 2$", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(kolo > 45 && kolo <= 53)//5
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na: 5$", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(kolo > 53 && kolo <= 57)//10
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na: 10$", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(kolo == 58 || kolo == 59)//20
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na: 20$", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            else if(kolo == 60 || kolo == 61)//*
            {
                format(string, sizeof(string), "* %s zakrêci³ ko³em fortuny które zatrzyma³o siê na gwieŸdzie fortuny (40$)", sendername);
				ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
            }
            ZabierzKase(playerid, 5000);
			sendTipMessageEx(playerid, TEAM_AZTECAS_COLOR, "Kasyno pobiera op³atê za u¿ycie ko³a fortuny (5000$)");
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ przy kole fortuny!");
        }
    }
	return 1;
}
