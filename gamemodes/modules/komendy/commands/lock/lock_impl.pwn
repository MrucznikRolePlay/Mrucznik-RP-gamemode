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
command_lock_Impl(playerid, params[256])
{
    new newcar=0, Float:dis=2.75, Float:x, Float:y, Float:z, Float:currdist;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        GetVehiclePos(i, x, y, z);
        if((currdist = GetPlayerDistanceFromPoint(playerid, x, y, z)) < dis)
        {
            dis = currdist;
            newcar = i;
        }
    }
    if(newcar != 0)
    {
	    if(Car_GetOwnerType(newcar) == CAR_OWNER_FRACTION)// wszystkie auta frakcji
	    {
            if(Car_GetOwner(newcar) == GetPlayerFraction(playerid))
            {
                Car_Lock(playerid, newcar);
            }
        }
        else if(Car_GetOwnerType(newcar) == CAR_OWNER_FAMILY) //organizacyjny
        {
            if(Car_GetOwner(newcar) == PlayerInfo[playerid][pOrg])
            {
                Car_Lock(playerid, newcar);
            }
        }
        else if(Car_GetOwnerType(newcar) == CAR_OWNER_PLAYER)
        {
            if(IsCarOwner(playerid, newcar, true))
            {
                Car_Lock(playerid, newcar);
            }
        }
    }
    return 1;
}

//end
