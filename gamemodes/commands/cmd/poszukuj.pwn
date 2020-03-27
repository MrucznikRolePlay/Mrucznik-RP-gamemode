//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ poszukuj ]---------------------------------------------------//
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

YCMD:poszukiwania(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
	/*	if(PlayerInfo[playerid][Job] != 1)
		{
			sendErrorMessage(playerid, "Nie jesteœ ³owc¹ nagród!"); 
			return 1;
		}
		if(hunterStatus[playerid] == 0)
		{
			sendTipMessage(playerid, "W³¹czy³eœ wyœwietlanie na mapie osób z WL 10"); 
			sendTipMessage(playerid, "Dane aktualizuj¹ siê do systemu co 2 minuty!"); 
			hunterStatus[playerid]++; 
			timerForHunter[playerid] = SetTimerEx("PlayerShowForHunter", 5000, false, "d", playerid);
		}
		else if(hunterStatus[playerid] > 0)
		{
			sendTipMessage(playerid, "Wy³¹czy³eœ wyœwietlanie na mapie osób z WL"); 
			hunterStatus[playerid]=0;
			KillTimer(timerForHunter[playerid]);
			foreach(new i : Player)
			{
				if(hunterSeeMe[i] == playerid)
				{
					DestroyDynamicCP(chpIDHunter[i]); 
				}
			}
		}
		*/
		sendErrorMessage(playerid, "Trwaj¹ prace nad t¹ komend¹!"); 
	}
	return 1;
}



