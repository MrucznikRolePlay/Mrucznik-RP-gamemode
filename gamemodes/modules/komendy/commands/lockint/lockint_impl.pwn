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
command_lockint_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new model = GetVehicleModel(vehicleid);
			if(IsAInteriorVehicle(model))
			{
                if(!(IsCarOwner(playerid, vehicleid) || (Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && Car_GetOwner(vehicleid) == GetPlayerFraction(playerid)) ))
				{
					return sendTipMessageEx(playerid, COLOR_LIGHTGREEN, "Ten pojazd nie nale¿y do Ciebie!");
				}
				
				if(VehicleUID[vehicleid][vIntLock] == 0)
				{
				    VehicleUID[vehicleid][vIntLock] = 1;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ interior");
				}
				else
				{
				    VehicleUID[vehicleid][vIntLock] = 0;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ interior");
				}
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Ten wóz nie ma interioru");
		    }
	   	}
	   	else
	   	{
	   	    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w wozie");
	   	}
	}
	return 1;
}

//end
