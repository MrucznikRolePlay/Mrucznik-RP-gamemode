//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    logi                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Narzêdzia do obs³ugi logów.
*/

//

//-----------------<[ Funkcje: ]>-------------------
GetPlayerLogName(playerid)
{
    if(IsPlayerConnected(playerid) && gPlayerLogged[playerid]) {
        safe_return sprintf("{Player: %s[%d]}", GetNickEx(playerid), PlayerInfo[playerid][pUID]);
    } 
    safe_return sprintf("{Player: %s}", GetNickEx(playerid));
}

GetWeaponLogName(weapon, ammo=-1)
{
    new gunname[32];
    GetWeaponName(weapon, gunname, sizeof(gunname));
    if(ammo == -1)
    {
        safe_return sprintf("{Weapon: %s[id: %d]}", gunname, weapon);
    }
    else
    {
        safe_return sprintf("{Weapon: %s[id: %d, ammo: %d]}", gunname, weapon, ammo);
    }
}

GetVehicleLogName(vehicleid)
{
    safe_return sprintf("{Vehicle: %s[%d]}", VehicleNames[GetVehicleModel(vehicleid)-400], CarData[VehicleUID[vehicleid][vUID]][c_UID]);
}

GetCarDataLogName(cardata)
{
    safe_return sprintf("{Vehicle: %s[%d]}", VehicleNames[CarData[cardata][c_Model]-400], CarData[cardata][c_UID]);
}

GetHouseLogName(house)
{
    safe_return sprintf("{House: %d}", house);
}

GetBusinessLogName(business)
{
    safe_return sprintf("{Business: %s[%d]}", Business[business][b_Name], business);
}

GetGraffitiLogText(graffiti)
{
    safe_return sprintf("{Graffiti: %s[%d]}", graffiti, GraffitiInfo[graffiti][grafText]);
}

GetFractionLogName(fraction)
{
    safe_return sprintf("{Fraction: %s[%d]}", FractionNames[fraction], fraction);
}

GetOrgLogName(org)
{
    safe_return sprintf("{Organization: %s[%d]}", OrgInfo[org][o_Name], org);
}

GetJobLogName(jobid)
{
    safe_return sprintf("{Job: %s[%d]}", GetJobName(Jobs:jobid), jobid);
}

GetFrontBizLogName(bizId)
{
    safe_return sprintf("{FrontBusiness: %s[%d]}", FrontBusiness[bizId][Name], bizId);
}

GetBusRouteLogName(route)
{
    safe_return sprintf("{BusRoute: %s[%d]}", BusRoute[route][br_Name], route);
}

GetBusStopLogName(route, busstop)
{
    safe_return sprintf("{BusStop: %s[%d]}", BusStop[route][busstop][bs_Name], busstop);
}

//end