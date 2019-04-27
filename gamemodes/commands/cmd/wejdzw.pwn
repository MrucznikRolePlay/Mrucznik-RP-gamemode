//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wejdzw ]------------------------------------------------//
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


CMD:wejdzw(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(GetPVarInt(playerid, "AC-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Jesteœ odizolowany, nie mo¿esz u¿ywaæ tej komendy.");

		if(WnetrzeWozu[playerid] != 0)
	    {
	        Z_WnetrzaWozu(playerid, WnetrzeWozu[playerid]);
	    }
	    else
	    {
		    for(new v; v < MAX_VEHICLES; v++)
		    {
				new model = GetVehicleModel(v);
				if(IsAInteriorVehicle(model))
				{
	   				new Float:vehx, Float:vehy, Float:vehz;
	          		GetVehiclePos(v, vehx, vehy, vehz);
	          		if(IsPlayerInRangeOfPoint(playerid, 15.0, vehx, vehy, vehz))
	          		{
                        if(PlayerInfo[playerid][pJailed] != 0)
                        {
                            if(PlayerInfo[playerid][pJailed] == 3)
                            {
                                new string[256];
                                format(string, sizeof(string), "Cziter %s zostal zbanowany za ucieczke z AJ",  GetNick(playerid));
                                BanLog(string);
                                Ban(playerid);
                            }
                            return 1;
                        }
	          		    if(VehicleUID[v][vIntLock] == 1 || GetVehicleModel(v) == 570)
	          		    {
							if(GetVehicleModel(v) == 570 && PlayerInfo[playerid][pBiletpociag] == 1 || GetVehicleModel(v) == 570 && GetPlayerFraction(playerid) == FRAC_KT)
							{
								Do_WnetrzaWozu(playerid, v, model);
							}
							else if(GetVehicleModel(v) == 570 && PlayerInfo[playerid][pBiletpociag] == 0)
							{
								sendErrorMessage(playerid, "Nie posiadasz biletu! Kup go na dworcu za pomoc¹ /kupbiletpoci¹g(/kbpo)");
								return 1;
							}
							else
							{
								Do_WnetrzaWozu(playerid, v, model);
							}
							
							return 1;
						}
						else
						{
						    sendTipMessage(playerid, "Interior jest zamkniêty! Otwórz go za pomoc¹ /lockint");
						    return 1;
						}
	          		}
				}
		    }
		    sendTipMessage(playerid, "Jesteœ zbyt daleko od pojazdu do którego mo¿na wejœæ w ten sposób");
		    return 1;
	   	}
	}
	return 1;
}


