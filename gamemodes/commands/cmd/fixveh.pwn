//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ fixveh ]------------------------------------------------//
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

YCMD:fixveh(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][Admin] >= 7 || IsAScripter(playerid))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
				SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
				RepairVehicle(GetPlayerVehicleID(playerid));
				CarData[vuid][c_HP] = 1000.0;
				
				new string[128];
				format(string, sizeof(string), "AdmCmd: %s naprawi³ auto %s (%d)[%d].", GetNickEx(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				SendMessageToAdmin(string, COLOR_RED);
				Log(adminLog, INFO, "Admin %s u¿y³ /fixveh dla pojazdzu %s", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid));
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
