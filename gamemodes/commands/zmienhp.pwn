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

CMD:sethp(playerid, params[]) return cmd_zmienhp(playerid, params);
CMD:zmienhp(playerid, params[])
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

		if (PlayerInfo[playerid][pAdmin] >= 10 || PlayerInfo[playerid][pAdmin] == 7)
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

