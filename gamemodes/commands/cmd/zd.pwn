//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ zd ]--------------------------------------------------//
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

YCMD:zd(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    new Veh = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || PlayerInfo[playerid][pJob] == 10)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pRank] >= 1 || PlayerInfo[playerid][pJob] == 10)
			{
				if(IsAPublicTransport(Veh))
				{
				    if(PlayerInfo[playerid][pDrzwibusazamkniete]==0)
				    {
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s naciska guzik i powoli zamyka drzwi", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetTimerEx("ZamykanieDrzwi",4000,0,"d",playerid);
						GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Trwa zamykanie drzwi...", 4000, 3);
					}
					else
					{
						sendErrorMessage(playerid, "Drzwi autobusu s¹ ju¿ zamkniête !");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie jesteœ w autobusie Korporacji !");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie posiadasz 2 rangi !");
			}
			return 1;
		}
	}
	else
	{
	sendErrorMessage(playerid, "Nie jesteœ z Korporacji Transportowej !");
	}
	return 1;
}
