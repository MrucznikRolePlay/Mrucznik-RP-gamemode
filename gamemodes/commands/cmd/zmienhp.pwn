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
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

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
					SetPlayerHealth(playa, health);
					if(IsPlayerInAnyVehicle(playerid))
					{
					    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						printf("SETHP: AdmCmd: %s da³ %d hp %s", sendername, health,  giveplayer);
					    SetVehicleHealth(GetPlayerVehicleID(playa), health);
                        CarData[VehicleUID[GetPlayerVehicleID(playa)][vUID]][c_HP] = 1000.0;
						new string[128];
						format(string, sizeof(string), "%s da³ %d hp dla %s", sendername, health, giveplayer);
						SendMessageToAdmin(string, COLOR_P@);
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscInne[playerid] = iloscInne[playerid]+1;
						}
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
