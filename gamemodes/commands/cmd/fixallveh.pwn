//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ fixallveh ]-----------------------------------------------//
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

YCMD:fixallveh(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][Admin] < 1000)
        {
            noAccessMessage(playerid);
            return 1;
        }
        foreach(new i : Player)
        {
            if(IsPlayerInAnyVehicle(i))
            {
                new carID = GetPlayerVehicleID(i); 
                SetVehicleHealth(carID, 1000.0);
                RepairVehicle(carID);
                CarData[VehicleUID[carID][vUID]][c_HP] = 1000.0;
            }
        }
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			iloscInne[playerid] = iloscInne[playerid]+1;
		}
        new string[128];
        format(string, sizeof(string), "Admin %s naprawi³ wszystkim graczom pojazdy", GetNickEx(playerid));
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
		Log(adminLog, INFO, "Admin %s u¿y³ /fixallveh", GetPlayerLogName(playerid));
    }
    return 1;
}
