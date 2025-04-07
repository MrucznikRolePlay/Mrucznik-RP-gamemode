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
			MruMessageError(playerid, "B��d - nie jeste� w poje�dzie.");
			return 1;
		}
		if(model < 400)
		{
			MruMessageError(playerid, "B��d - niepoprawny model pojazdu.");
			return 1;
		}

		new ownerOfFractionCar = IsPlayerOwnFractionCar(playerid, vehicleID);

		if(!IsCarOwner(playerid, vehicleID) && !ownerOfFractionCar) 
		{ 
			return sendErrorMessage(playerid, "Ten pojazd nie nale�y do Ciebie!");
		}
		if(IsAPlane(vehicleID))
		{
   			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			if((IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0) || strcmp(pZone, "Las Venturas Airport", true) == 0 || strcmp(pZone, "Lotnisko", true) == 0 || strcmp(pZone, "Easter Bay Airport", true) == 0 || strcmp(pZone, "Verdant Meadows", true) == 0 || ownerOfFractionCar)
			{
				saveCar(playerid, vehicleID, vehicleUID, ownerOfFractionCar);

				format(string, sizeof(string), "Tw�j %s zosta� zaparkowany w tym miejscu!", VehicleNames[model-400]);
				sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
			}
			else
			{
			    if(IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0)
		    	{
					sendTipMessage(playerid, "Samoloty i helikoptery mo�esz parkowa� tylko na lotnisku (Aby m�c parkowa� je ko�o domu, kup l�dowisko w domu)");
				}
				else
				{
				    format(string, sizeof(string), "Z obecnym levelem l�dowiska mo�esz zaparkowa� sw�j pojazd lataj�cy tylko %d metr�w od domu", Dom[PlayerInfo[playerid][pDom]][hLadowisko]);
               		sendTipMessage(playerid, string);
				}
			}
		}
        else //NORM
        {
			saveCar(playerid, vehicleID, vehicleUID, ownerOfFractionCar);

			format(string, sizeof(string), "Tw�j %s zosta� zaparkowany w tym miejscu!", VehicleNames[model-400]);
			sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
        }
		
		new Float:x, Float:y, Float:z;
		GetVehiclePos(vehicleID, x,y,z);
		if(ownerOfFractionCar)
			Log(serverLog, INFO, "Lider %s u�y� /zaparkuj na vuid %d: [%d]%s; %f, %f, %f", GetNick(playerid),vehicleUID, model, VehicleNames[model-400], x, y, z);
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jeste� w wozie.");
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
