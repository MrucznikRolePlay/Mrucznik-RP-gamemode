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
command_flip_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 1  && PlayerInfo[playerid][pAdmin] != 7 && !IsAZaufanyGracz(playerid))
		{
		    noAccessMessage(playerid);
		    return 1;
		}
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
		    sendTipMessage(playerid, "U�yj /flip [id Gracza]");
		}
		else
		{
			if(!IsPlayerConnected(giveplayerid))
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza");
				return 1;
			}
	  		new VehicleID, Float:X, Float:Y, Float:Z;
	  		GetPlayerPos(giveplayerid, X, Y, Z);
	  		VehicleID = GetPlayerVehicleID(giveplayerid);
	  		SetVehiclePos(VehicleID, X, Y, Z);
	  		SetVehicleZAngle(VehicleID, 0);

            _MruAdmin(playerid, sprintf("Postawi�e� na ko�ach %s [ID: %d]", GetNick(giveplayerid), giveplayerid));
            if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Admin %s [ID: %d] postawi� Ci� na ko�ach", GetNickEx(playerid), playerid));
		}
	}
	return 1;
}

//end
