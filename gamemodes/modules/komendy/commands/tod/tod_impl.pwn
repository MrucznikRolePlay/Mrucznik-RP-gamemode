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
command_tod_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
		new hour;
		if( sscanf(params, "d", hour))
		{
			sendTipMessage(playerid, "U¿yj /tod [czas] (0-23)");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
            SetWorldTime(hour);
            ServerTime = hour;
			
			format(string, sizeof(string), "Czas zmieniony na %d Godzine.", hour);
			BroadCast(COLOR_GRAD1, string);

            format(string, sizeof(string), "CMD_Info: /tod u¿yte przez %s [%d]", GetNickEx(playerid), playerid);
            SendCommandLogMessage(string);
        	Log(adminLog, INFO, "Admin %s u¿y³ /tod z wartoœci¹ %d", GetPlayerLogName(playerid), hour);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
			foreach(new i : Player)//Je¿eli gracze s¹ w intkach 
			{
				if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)
				{
					SetInteriorTimeAndWeather(i);
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

//end
