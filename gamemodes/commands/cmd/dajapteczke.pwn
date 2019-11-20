//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ dajapteczke ]----------------------------------------------//
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

YCMD:dajapteczke(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new playa, ilosc;
		if( sscanf(params, "k<fix>D(0)", playa, ilosc))
		{
			sendTipMessage(playerid, "U¿yj /dajapteczke [playerid/CzêœæNicku] [ilosc]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					new giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}

					PlayerInfo[playa][pHealthPacks] = ilosc;
					Log(adminLog, INFO, "Admin %s ustawi³ %s apteczki na %d", GetPlayerLogName(playerid), GetPlayerLogName(playa), ilosc);
					new string[128];
					format(string, sizeof(string), "%s ustawi³ %d apteczki dla %s", sendername, ilosc, giveplayer);
					SendMessageToAdmin(string, COLOR_P@);
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
