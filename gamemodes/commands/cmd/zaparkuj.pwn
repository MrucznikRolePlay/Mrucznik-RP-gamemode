//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zaparkuj ]-----------------------------------------------//
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

YCMD:zaparkuj(playerid, params[], help)
{
	new string[256];
	new VW = GetPlayerVirtualWorld(playerid); 
	if(IsPlayerInAnyVehicle(playerid))
	{
        new lVeh = GetPlayerVehicleID(playerid);
		if(!IsCarOwner(playerid, lVeh)) return sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Ciebie!");
		if(IsAPlane(lVeh))
		{
   			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			if((IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0) || strcmp(pZone, "Las Venturas Airport", true) == 0 || strcmp(pZone, "Lotnisko", true) == 0 || strcmp(pZone, "Easter Bay Airport", true) == 0 || strcmp(pZone, "Verdant Meadows", true) == 0)
			{
                new Float:X, Float:Y, Float:Z;
				new Float:A;
				GetVehicleZAngle(lVeh, A);
				GetPlayerPos(playerid, X,Y,Z);

                CarData[VehicleUID[lVeh][vUID]][c_Pos][0] = X;
                CarData[VehicleUID[lVeh][vUID]][c_Pos][1] = Y;
                CarData[VehicleUID[lVeh][vUID]][c_Pos][2] = Z;
				CarData[VehicleUID[lVeh][vUID]][c_VW] = VW; 
                CarData[VehicleUID[lVeh][vUID]][c_Rot] = A;
                Car_Save(VehicleUID[lVeh][vUID], CAR_SAVE_STATE);

				format(string, sizeof(string), "Twój %s zosta³ zaparkowany w tym miejscu!", VehicleNames[GetVehicleModel(lVeh)-400]);
				sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
			}
			else
			{
			    if(IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0)
		    	{
					sendTipMessage(playerid, "Samoloty i helikoptery mo¿esz parkowaæ tylko na lotnisku (Aby móc parkowaæ je ko³o domu, kup l¹dowisko w domu)");
				}
				else
				{
				    format(string, sizeof(string), "Z obecnym levelem l¹dowiska mo¿esz zaparkowaæ swój pojazd lataj¹cy tylko %d metrów od domu", Dom[PlayerInfo[playerid][pDom]][hLadowisko]);
               		sendTipMessage(playerid, string);
				}
			}
		}
        else //NORM
        {
            new Float:X, Float:Y, Float:Z;
			new Float:A;
			GetVehicleZAngle(lVeh, A);
			GetPlayerPos(playerid, X,Y,Z);

            CarData[VehicleUID[lVeh][vUID]][c_Pos][0] = X;
            CarData[VehicleUID[lVeh][vUID]][c_Pos][1] = Y;
            CarData[VehicleUID[lVeh][vUID]][c_Pos][2] = Z;
            CarData[VehicleUID[lVeh][vUID]][c_Rot] = A;
			CarData[VehicleUID[lVeh][vUID]][c_VW] = VW; 
            Car_Save(VehicleUID[lVeh][vUID], CAR_SAVE_STATE);

			format(string, sizeof(string), "Twój %s zosta³ zaparkowany w tym miejscu!", VehicleNames[GetVehicleModel(lVeh)-400]);
			sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
        }
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ w wozie.");
	}
	return 1;
}
