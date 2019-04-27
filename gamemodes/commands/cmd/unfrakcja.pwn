//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ unfrakcja ]-----------------------------------------------//
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

YCMD:unfrakcja(playerid, params[], help)
{
	new string[64];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /unfrakcja [ID gracza]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1000 || Uprawnienia(playerid, ACCESS_MAKELEADER) || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("AdmCmd: %s zosta³ wyrzucony przez %s.", sendername, giveplayer);
					format(string, sizeof(string), "* Zosta³eœ wyrzucony z frakcji przez %s.", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					SendClientMessage(para1, COLOR_LIGHTBLUE, "* Jesteœ cywilem.");
					PlayerInfo[para1][pMember] = 0;
					PlayerInfo[para1][pLider] = 0;
					PlayerInfo[para1][pJob] = 0;
                    orgUnInvitePlayer(para1);
					MedicBill[para1] = 0;
					SpawnPlayer(para1);
					format(string, sizeof(string), "  Wyrzuci³es %s z frakcji.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
					format(string, sizeof(string), "%s unfrakcjowal gracza %s", sendername, GetNick(para1));
					ActionLog(string);
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
