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
command_setcarhp_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new vehicleid, health;
		if( sscanf(params, "dd", vehicleid, health))
		{
			sendTipMessage(playerid, "U¿yj /setcarhp [carid] [hp]");
			return 1;
		}
    
        if (PlayerInfo[playerid][pAdmin] >= 10 || IsAScripter(playerid))
        {
            if(GetVehicleModel(vehicleid))
            {
                new vuid = VehicleUID[vehicleid][vUID];
                SetVehicleHealth(vehicleid, health);
                CarData[vuid][c_HP] = (health > 1000 ? 1000 : health);
                Log(adminLog, INFO, "Admin %s ustawi³ hp auta %s na %d", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid), health);
                new string[128];
                format(string, sizeof(string), "Admin %s ustawi³ hp auta [vID: %d] na %d", GetNickEx(playerid), vehicleid, Float:health);
                SendMessageToAdmin(string, COLOR_P@);
            }
            else
            {
                sendTipMessage(playerid, "Niepoprawne ID pojazdu. (/dl)");
            }
        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}

//end
