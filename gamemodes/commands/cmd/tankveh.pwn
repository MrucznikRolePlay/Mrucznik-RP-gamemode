//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ tankveh ]------------------------------------------------//
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

YCMD:tankveh(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "»» Nie jesteœ w pojeŸdzie!");
        if(IsPlayerInAnyVehicle(playerid)) {
            new string[128];
            if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
            {
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
                Gas[vehicleid] = 100;
                format(string, sizeof(string), " »» Pojazd o ID (%d) zosta³ dotankowany", vehicleid);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string); 
				
				format(string, sizeof(string), "AdmCmD: %s zatankowa³ auto %s (%d)[%d].", GetNickEx(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				//SendPunishMessage(string, playerid);
                SendMessageToAdmin(string, COLOR_RED); 
				Log(adminLog, INFO, "Admin %s zatankowa³ auto %s", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid));
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
            }
            else
            {
                noAccessMessage(playerid);
            }
        }
    }
    return 1;
}
