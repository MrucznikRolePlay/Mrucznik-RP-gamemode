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
// Autor: Mrucznik & Sanda³ & Creative
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

public CruiseControl_Static_TurnOn(playerid, type)
{
    //type: 0 - dla graczy z 1lvl, 1 - dla rowerów
    //pozniej trzeba dodaæ nowy typ w pojazdy_timers.pwn
    if(type == 0 && (IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)) 
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Zosta³a ci na³o¿ona blokada prêdkoœci do 50km/h, nie posiadasz prawa jazdy.");
		pCruiseSpeed[playerid] = CruiseControlStatic_NoCarLic;
		CruiseControl_ShowTXD(playerid);
		new timer = SetTimerEx("CruiseControl_Static", 200, true, "ii", playerid, type);
		SetPVarInt(playerid, "timer_StaticCruiseControl", timer);
	}
	else if(type == 1 && (IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0))
	{
		pCruiseSpeed[playerid] = CruiseControlStatic_Bike;
		CruiseControl_ShowTXD(playerid);
		new timer = SetTimerEx("CruiseControl_Static", 200, true, "ii", playerid, type);
		SetPVarInt(playerid, "timer_StaticCruiseControl", timer);

	}
}

public CruiseControl_ChangedKeyBool(playerid) pCruiseCanChange[playerid] = 1;


public CruiseControl_Static(playerid, type)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetPVarInt(playerid, "timer_StaticCruiseControl"))
    {
        new Float:vX, Float:vY, Float:vZ;
		new speed;
        pCruiseTXD[playerid]++;
        GetVehicleVelocity(GetPlayerVehicleID(playerid), vX, vY, vZ);
        new carid = GetPlayerVehicleID(playerid);
        new playerkmh = GetVehicleSpeed(carid);
		if(type == 0) speed = CruiseControlStatic_NoCarLic;
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