//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ zakoncztrase ]---------------------------------------------//
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

YCMD:zakoncztrase(playerid, params[], help)
{
	if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || PlayerInfo[playerid][pJob] == 10)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pRank] >= 1 || PlayerInfo[playerid][pJob] == 10)
			{
				DisablePlayerCheckpoint(playerid);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia55] = 0;
				PlayerInfo[playerid][pLinia72] = 0;
				PlayerInfo[playerid][pLinia82] = 0;
				PlayerInfo[playerid][pLinia96] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				Przystanek(playerid, COLOR_PURPLE, "Los Santos Bus Departament\nKomunikacja miejska");
				sendTipMessage(playerid, "Zakoñczy³eœ trasê i wygasi³eœ tablice");
			}
			else
			{
				sendErrorMessage(playerid, "Nie posiadasz 2 rangi!");
			}
			return 1;
		}
	}
	else
	{
	sendErrorMessage(playerid, "Nie jesteœ z Korporacji Transportowej!");
	}
	return 1;
}
