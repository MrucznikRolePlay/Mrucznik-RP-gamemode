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
	if(IsPlayerInAnyVehicle(playerid))
	{
        new vehicleID = GetPlayerVehicleID(playerid);
		new vehicleUID = VehicleUID[vehicleID][vUID];
		new lider = PlayerInfo[playerid][pLider];
        new org = GetPlayerOrg(playerid);

    	new liderOwner = CarData[vehicleUID][c_OwnerType] == CAR_OWNER_FRACTION && \
        lider == CarData[vehicleUID][c_Owner] && 
        lider > 0;
    	new orgOwner = CarData[vehicleUID][c_OwnerType] == CAR_OWNER_FAMILY && \
        org == CarData[vehicleUID][c_Owner];
		
		if( !IsCarOwner(playerid, vehicleID) && !liderOwner && (!orgOwner && !orgIsLeader(playerid)) ) 
		{ 
			return sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Ciebie!");
		}
		if(IsAPlane(vehicleID))
		{
   			new pZone[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
			if((IsPlayerInRangeOfPoint(playerid, Dom[PlayerInfo[playerid][pDom]][hLadowisko], Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y],  Dom[PlayerInfo[playerid][pDom]][hWej_Z]) && PlayerInfo[playerid][pDom] != 0) || strcmp(pZone, "Las Venturas Airport", true) == 0 || strcmp(pZone, "Lotnisko", true) == 0 || strcmp(pZone, "Easter Bay Airport", true) == 0 || strcmp(pZone, "Verdant Meadows", true) == 0 || liderOwner || orgOwner)
			{
				new doRespawn = liderOwner || orgOwner;
				saveCar(playerid, vehicleID, vehicleUID, doRespawn);

				format(string, sizeof(string), "Twój %s zosta³ zaparkowany w tym miejscu!", VehicleNames[GetVehicleModel(vehicleID)-400]);
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
			new doRespawn = liderOwner || orgOwner;
			saveCar(playerid, vehicleID, vehicleUID, doRespawn);

			format(string, sizeof(string), "Twój %s zosta³ zaparkowany w tym miejscu!", VehicleNames[GetVehicleModel(vehicleID)-400]);
			sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
        }
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ w wozie.");
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
