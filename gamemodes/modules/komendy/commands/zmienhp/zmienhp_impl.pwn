//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_zmienhp_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new playa, health;
		if( sscanf(params, "k<fix>D(0)", playa, health))
		{
			sendTipMessage(playerid, "U�yj /sethp [playerid/Cz��Nicku] [health]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					new giveplayer[MAX_PLAYER_NAME], additional[54];
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					SetPlayerHealth(playa, health);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					if(IsPlayerInAnyVehicle(playa))
					{
						new vehid = GetPlayerVehicleID(playa);
						SetVehicleHealth(vehid, health);
						RepairVehicle(vehid);
                        CarData[VehicleUID[vehid][vUID]][c_HP] = 1000.0;
						additional = " oraz naprawi� pojazd";
					}

					Log(adminLog, INFO, "Admin %s ustawi� %s hp na %d%s", GetPlayerLogName(playerid), GetPlayerLogName(playa), health, additional);
					new string[128];
					format(string, sizeof(string), "%s da� %d hp dla %s%s", GetNickEx(playerid), health, giveplayer, additional);
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

//end
