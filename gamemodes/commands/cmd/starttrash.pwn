//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ starttrash ]------------------------------------------------//
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

YCMD:starttrash(playerid, params[], help)
{
	if(IsPlayerConnected((playerid))
	{
		if(PlayerInfo[playerid][pJob] == 17)
		{
			if(GetPlayerVehicleID(playerid) == 408)
			{
				if(GetPlayerVehicleSeat(playerid) == 0)
				{
					pTrashCollected[playerid] = 0; 
					LoadTrashTextDrawForPlayer(playerid); 
					sendTipMessage(playerid, "Rozpoczynasz pracê œmieciarza - poszukuj œmietników wystawionych przed dom!"); 
					sendTipMessage(playerid, "Udaj siê do pierwszej strefy - oznaczonej czerwonym kolorem na mapie."); 
					StartTrashCollecting(playerid); 
					trasherStartCollecting[playerid] = 1;
					trasherZoneID[playerid] = 1;  
					//trasherJobTimer[playerid] = SetTimerEx("TrasherJob",3000,0,"d",playerid);
				}
				else
				{
					sendTipMessage(playerid, "Aby móc u¿ywaæ tej komendy musisz byæ kierowc¹ pojazdu TrashMaster!"); 
					return 1;
				}
			}
			else
			{
				sendTipMessage(playerid, "Aby móc u¿ywaæ tej komendy musisz byæ w pojeŸdzie TrashMaster"); 
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ œmieciarzem!"); 
			return 1;
		}
	}
	return 1;
}



