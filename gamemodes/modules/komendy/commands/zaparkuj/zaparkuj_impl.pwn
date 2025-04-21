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
command_zaparkuj_Impl(playerid)
{
    new string[256];
	if(IsPlayerInAnyVehicle(playerid))
	{
        new vehicleID = GetPlayerVehicleID(playerid);
		new vehicleUID = VehicleUID[vehicleID][vUID];
		new model = GetVehicleModel(vehicleID);
		if(vehicleID == -1)
		{
			MruMessageError(playerid, "B≥πd - nie jesteú w pojeüdzie.");
			return 1;
		}
		if(model < 400)
		{
			MruMessageError(playerid, "B≥πd - niepoprawny model pojazdu.");
			return 1;
		}

		new ownerOfFractionCar = IsPlayerOwnFractionCar(playerid, vehicleID);

		if(!IsCarOwner(playerid, vehicleID) && !ownerOfFractionCar) 
		{ 
			return sendErrorMessage(playerid, "Ten pojazd nie naleøy do Ciebie!");
		}
		if(IsAPlane(vehicleID))
		{
   			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			if((IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0) || strcmp(pZone, "Las Venturas Airport", true) == 0 || strcmp(pZone, "Lotnisko", true) == 0 || strcmp(pZone, "Easter Bay Airport", true) == 0 || strcmp(pZone, "Verdant Meadows", true) == 0 || ownerOfFractionCar)
			{
				saveCar(playerid, vehicleID, vehicleUID, ownerOfFractionCar);

				format(string, sizeof(string), "TwÛj %s zosta≥ zaparkowany w tym miejscu!", VehicleNames[model-400]);
				sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
			}
			else
			{
			    if(IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0)
		    	{
					sendTipMessage(playerid, "Samoloty i helikoptery moøesz parkowaÊ tylko na lotnisku (Aby mÛc parkowaÊ je ko≥o domu, kup lπdowisko w domu)");
				}
				else
				{
				    format(string, sizeof(string), "Z obecnym levelem lπdowiska moøesz zaparkowaÊ swÛj pojazd latajπcy tylko %d metrÛw od domu", Dom[PlayerInfo[playerid][pDom]][hLadowisko]);
               		sendTipMessage(playerid, string);
				}
			}
		}
        else //NORM
        {
			saveCar(playerid, vehicleID, vehicleUID, ownerOfFractionCar);

			format(string, sizeof(string), "TwÛj %s zosta≥ zaparkowany w tym miejscu!", VehicleNames[model-400]);
			sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
        }
		
		new Float:x, Float:y, Float:z;
		GetVehiclePos(vehicleID, x,y,z);
		if(ownerOfFractionCar)
			Log(serverLog, INFO, "Lider %s uøy≥ /zaparkuj na %s: %f, %f, %f", GetNick(playerid), GetVehicleLogName(vehicleID), x, y, z);
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteú w wozie.");
	}
	return 1;
}

saveCar(playerid, vehicleID, vehicleUID, respawn)
{
	new Float:X, Float:Y, Float:Z;
	new Float:A;
	new VW = GetPlayerVirtualWorld(playerid); 
	GetVehicleZAngle(vehicleID, A);
	GetPlayerPos(playerid, X,Y,Z);

	CarData[vehicleUID][c_Pos][0] = X;
	CarData[vehicleUID][c_Pos][1] = Y;
	CarData[vehicleUID][c_Pos][2] = Z;
	CarData[vehicleUID][c_VW] = VW; 
	CarData[vehicleUID][c_Rot] = A;
	Car_Save(vehicleUID, CAR_SAVE_STATE);
	if (respawn) 
	{
		Car_Unspawn(vehicleID);
		Car_Spawn(vehicleUID);
	}
}

//end
