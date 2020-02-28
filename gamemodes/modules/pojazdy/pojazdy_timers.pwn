//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                  pojazdy                                                  //
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
	System pojazdów.
*/

//

//-----------------<[ Timery: ]>-------------------
public CruiseControl(playerid)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
    {
        new Float:vX, Float:vY, Float:vZ;
        pCruiseTXD[playerid]++;
        GetVehicleVelocity(GetPlayerVehicleID(playerid), vX, vY, vZ);
        new carid = GetPlayerVehicleID(playerid);
        new playerkmh = GetVehicleSpeed(carid);
        if(playerkmh > pCruiseSpeed[playerid])
        {
            SetVehicleVelocity(GetPlayerVehicleID(playerid), vX*0.9, vY*0.9, vZ);
        }
        if(pCruiseTXD[playerid] == 4)
        {
            CruiseControl_UpdateTXD(playerid);
            pCruiseTXD[playerid] = 0;
        }
    }
    else
    {
        CruiseControl_TurnOff(playerid);
    }
}

public CruiseControl_Static(playerid, type)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
    {
        new Float:vX, Float:vY, Float:vZ;
		new speed;
        pCruiseTXD[playerid]++;
        GetVehicleVelocity(GetPlayerVehicleID(playerid), vX, vY, vZ);
        new carid = GetPlayerVehicleID(playerid);
        new playerkmh = GetVehicleSpeed(carid);
		if(type == 0) speed = CruiseControlStatic_NewPlayer;
		else if(type == 1) speed = CruiseControlStatic_Bike;
        if(playerkmh > speed)
        {
            SetVehicleVelocity(GetPlayerVehicleID(playerid), vX*0.9, vY*0.9, vZ);
        }
        if(pCruiseTXD[playerid] == 4)
        {
            CruiseControl_UpdateTXD(playerid);
            pCruiseTXD[playerid] = 0;
        }
    }
    else
    {
        CruiseControl_Static_TurnOff(playerid);
    }
}
//end