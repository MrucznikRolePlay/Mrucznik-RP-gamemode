//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kill ]-------------------------------------------------//
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

YCMD:kill(playerid, params[], help)
{
	new giveplayer[MAX_PLAYER_NAME];
	

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /kill [ID/Imie_Nazwisko]");
			return 1;
		}

		if (PlayerInfo[playerid][Admin] >= 1)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {		
					SetPVarInt(playerid, "skip_bw", 1);
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					SetPlayerHealth(playa, 0);
					Log(adminLog, INFO, "Admin %s zabi³ %s komend¹ /kill", GetPlayerLogName(playerid), GetPlayerLogName(playa));

					_MruAdmin(playerid, sprintf("Zabi³eœ gracza %s [%d] za pomoc¹ komendy", GetNick(playa), playa));
					if(playerid != playa) _MruAdmin(playa, sprintf("Zosta³eœ zabity przez admina %s [%d]", GetNick(playerid), playerid));

					SendCommandLogMessage(sprintf("Admin %s [%d] da³ /kill graczowi %s [%d]", GetNickEx(playerid), playerid, GetNick(playa), playa));
					
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
