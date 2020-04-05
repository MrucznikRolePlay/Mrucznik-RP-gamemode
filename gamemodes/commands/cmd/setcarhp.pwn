//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ setcarhp ]-----------------------------------------------//
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
// Autor: werem
// Data utworzenia: 29.02.2020

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/
YCMD:setcarhp(playerid, params[], help)
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
                CarData[vuid][c_HP] = health;
                Log(adminLog, INFO, "Admin %s ustawi³ hp auta [ID: %d] na %d", GetPlayerLogName(playerid), vehicleid, health);
                new string[128];
                format(string, sizeof(string), "%s ustawi³ hp auta [ID: %d] na %d", GetNickEx(playerid), vehicleid, health);
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