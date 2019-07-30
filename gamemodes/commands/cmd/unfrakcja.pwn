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
					format(string, sizeof(string), "* Zosta³eœ wyrzucony z frakcji przez %s.", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					SendClientMessage(para1, COLOR_LIGHTBLUE, "* Jesteœ cywilem.");
    				Log(adminLog, INFO, "Admin %s usun¹³ gracza %s z frakcji %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), PlayerInfo[para1][pMember]);
					PlayerInfo[para1][pMember] = 0;
					PlayerInfo[para1][pLider] = 0;
					PlayerInfo[para1][pJob] = 0;
                    orgUnInvitePlayer(para1);
					MedicBill[para1] = 0;
					SetPlayerSpawn(para1);
					format(string, sizeof(string), "  Wyrzuci³es %s z frakcji.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
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
