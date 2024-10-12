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
command_checkcar_Impl(playerid, params[256])
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || Uprawnienia(playerid, ACCESS_PANEL)  || PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
	{
        new vehid;
		if( sscanf(params, "d", vehid))
		{
			sendTipMessage(playerid, "U¿yj /checkcar [Vehicle ID]");
			return 1;
		}
        if(vehid < 1 || vehid >= MAX_VEHICLES)
            return sendErrorMessage(playerid, "Niepoprawne ID pojazdu.");
        if(GetVehicleModel(vehid) == 0)
            return sendErrorMessage(playerid, "Taki pojazd nie istnieje.");
        new uid = VehicleUID[vehid][vUID];
        if(uid == 0)
            return sendErrorMessage(playerid, "Pojazd nie nale¿y do systemu.");
        new str[128];
        format(str, 128, "System: Pojazd nale¿y do %s - %s (UID: %d)", CarOwnerNames[CarData[uid][c_OwnerType]], Car_PrintOwner(uid), CarData[uid][c_UID]);
        SendClientMessage(playerid, COLOR_GREEN, str);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

//end
