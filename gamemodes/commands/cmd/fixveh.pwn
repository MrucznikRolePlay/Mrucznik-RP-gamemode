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
        if(PlayerInfo[playerid][pAdmin] < 10 ||  PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
				SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
				RepairVehicle(GetPlayerVehicleID(playerid));
				CarData[vuid][c_HP] = 1000.0;
				
				new string[128];
				format(string, sizeof(string), "AdmCmd: %s naprawi³ auto %s (%d)[%d].", GetNick(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				SendPunishMessage(string, playerid);
				KickLog(string);
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
