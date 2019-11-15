//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zmienhp ]------------------------------------------------//
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

YCMD:zmienhp(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new playa, health;
		if( sscanf(params, "k<fix>D(0)", playa, health))
		{
			sendTipMessage(playerid, "U¿yj /sethp [playerid/CzêœæNicku] [health]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 10 || PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					new giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerHealth(playa, health);
					Log(adminLog, INFO, "Admin %s ustawi³ %s hp na %d", GetPlayerLogName(playerid), GetPlayerLogName(playa), health);
					new string[128];
					format(string, sizeof(string), "%s da³ %d hp dla %s", sendername, health, giveplayer);
					SendMessageToAdmin(string, COLOR_P@);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					if(IsPlayerInAnyVehicle(playerid))
					{
						SetVehicleHealth(GetPlayerVehicleID(playa), health);
						RepairVehicle(GetPlayerVehicleID(playa));
                        CarData[VehicleUID[GetPlayerVehicleID(playa)][vUID]][c_HP] = 1000.0;
					}
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
