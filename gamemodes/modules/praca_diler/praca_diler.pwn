//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                praca_diler                                                //
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
// Data utworzenia: 31.03.2024
//Opis:
/*
	Praca Dilera Narkotyków.
*/

//

#include "command_wez_dragi.pwn"

//-----------------<[ Funkcje: ]>-------------------
IsPlayerInDrugCar(playerid)
{
	new vehicleID = GetPlayerVehicleID(playerid);
	if(vehicleID == INVALID_VEHICLE_ID) 
	{
		return 0;
	}
	if(GetVehicleModel(vehicleID) == 423)
	{
		return 1;
	}
	return 0;
}

IsPlayerInDrugsTakingPoint(playerid)
{
	for(new i = 0; i < sizeof(DrugsTakingPoints); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 7.0, DrugsTakingPoints[i][0], DrugsTakingPoints[i][1], DrugsTakingPoints[i][2]))
		{
			return 1;
		}
	}
	return 0;
}

GetClosestDrugDealer(playerid)
{
    new dealerid = INVALID_PLAYER_ID;
    new Float:distance = 99999.0;
    foreach(new i : Player)
    {
        if(GetPlayerJob(i) == JOB_DRUG_DEALER && GetPVarInt(i, PVAR_DEALER_PRICE) != 0 && 
			IsPlayerInAnyVehicle(i) && IsPlayerInDrugCar(i) && IsPlayerNear(playerid, i, 20))
        {
			new Float:newDistance = GetDistanceBetweenPlayers(playerid,i);
			if(newDistance < distance)
			{
            	dealerid = i;
			}
        }
    }
	return dealerid;
}

EnableDrugDealing(playerid, vehicleid, price)
{
	if(GetPVarInt(playerid, PVAR_DEALER_PRICE) != 0)
	{
		DisableDrugDealing(playerid, vehicleid);
	}

	SetPVarInt(playerid, PVAR_DEALER_PRICE, price);

	new STREAMER_TAG_3D_TEXT_LABEL:text3d = CreateDynamic3DTextLabel(sprintf("Cennik lodów:\n1 ga³ka - %d$\n\n((wpisz /kupdragi aby kupiæ narkotyki))", price), 
		COLOR_VIOLET, 0.0, 0.0, 0.3, 10.0, INVALID_PLAYER_ID, vehicleid);
	MAP_insert_val_val(VehicleDrugInfo, _:vehicleid, text3d);

	SetVehicleAsObjective(vehicleid, true);
	return 1;
}

DisableDrugDealing(playerid, vehicleid)
{
	new text3d = MAP_get_val_val(VehicleDrugInfo, _:vehicleid);
	MAP_remove_val(VehicleDrugInfo, _:vehicleid);
	DestroyDynamic3DTextLabel(text3d);

	DeletePVar(playerid, PVAR_DEALER_PRICE);

	SetVehicleAsObjective(vehicleid, false);
	return 1;
}


//end