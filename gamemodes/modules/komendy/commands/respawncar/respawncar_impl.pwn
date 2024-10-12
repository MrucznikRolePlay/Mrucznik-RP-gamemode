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
command_respawncar_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1) return 1;
    new v;
    if(sscanf(params, "d", v)) return sendTipMessage(playerid, "U¿yj /respawncar [ID pojazdu]");
    if(!(0 < v < MAX_VEHICLES)) return 1;
    if(GetVehicleModel(v) == 0) return sendErrorMessage(playerid, "Niepoprawne ID pojazdu.");
    new bool:used=false;
    foreach(new p : Player)
	{
		if(GetPlayerVehicleID(p) == v)
		{
            used=true;
            break;
		}
	}
    if(used) return sendErrorMessage(playerid, "Pojazd nie jest pusty");
    else
    {
        Log(adminLog, INFO, "Admin %s respawnowa³ pojazd %s", GetPlayerLogName(playerid), GetVehicleLogName(v));
        RespawnVehicleEx(v);
	    if(Car_GetOwnerType(v) == CAR_OWNER_PLAYER)
	    {
            Car_Unspawn(v);
        }
    }
    return 1;
}

//end
