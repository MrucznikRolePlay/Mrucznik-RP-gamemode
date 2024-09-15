//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ cp_usun ]------------------------------------------------//
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

YCMD:cp_usun(playerid, params[], help)
{
	new string[128];

	if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
	{
		if(PlayerInfo[playerid][pRank] >= 4)
		{
		    if(tworzenietrasy[playerid] != 666)
		    {
		        if(Wyscig[tworzenietrasy[playerid]][wCheckpointy] != 0)
		        {
		            format(string, sizeof(string), "Usuniêto checkpoint numer %d.", Wyscig[tworzenietrasy[playerid]][wCheckpointy]);
					SendClientMessage(playerid, COLOR_GREY, string);
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][0] = 0;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][1] = 0;
		            wCheckpoint[tworzenietrasy[playerid]][Wyscig[tworzenietrasy[playerid]][wCheckpointy]][2] = 0;
		            Wyscig[tworzenietrasy[playerid]][wCheckpointy] --;
					if(Wyscig[tworzenietrasy[playerid]][wCheckpointy] > 0)
						SetPlayerRaceCheckpoint(playerid,Wyscig[tworzenietrasy[playerid]][wTypCH],wCheckpoint[tworzenietrasy[playerid]][(Wyscig[tworzenietrasy[playerid]][wCheckpointy]-1)][0], wCheckpoint[tworzenietrasy[playerid]][(Wyscig[tworzenietrasy[playerid]][wCheckpointy]-1)][1], wCheckpoint[tworzenietrasy[playerid]][(Wyscig[tworzenietrasy[playerid]][wCheckpointy]-1)][2],0.0,0.0,0.0, Wyscig[tworzenietrasy[playerid]][wRozmiarCH]);
					return 1;
		        }
		        else
		        {
		            sendErrorMessage(playerid, "Nie postawi³eœ jeszcze ani jednego checkpointu!");
		        }
		    }
		    else
 			{
 			    sendErrorMessage(playerid, "Nie jesteœ w trakcie tworzenia wyœcigu!");
 			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnieñ (wymagana 4 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Twoja organizacja nie posiada biznesu Toru wyœcigowego!");
	}
	return 1;
}
