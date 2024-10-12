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
command_sprawdzczasgry_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] == 0)
	{
        return 1;
    }

    new giveplayerid;
    if( sscanf(params, "k<fix>", giveplayerid))
    {
        sendTipMessage(playerid, "U¿yj /sprawdzczasgry [id gracza]");
        return 1;
    }

    if(!IsPlayerConnected(giveplayerid) || giveplayerid == INVALID_PLAYER_ID)
    {
        sendTipMessage(playerid, "Tego gracza nie ma na serwerze!");
        return 1;         
    }

    new sessionLength = GetTickCount() - pSessionStart[giveplayerid];
    sessionLength -= sessionLength % 1000; // zaokr¹glenie do pe³nych sekund

    new sLenUnderMinuteTicks = sessionLength % 60000;
    new sLenUnderHourTicks = sessionLength % 3600000;

    new sessionSeconds = sLenUnderMinuteTicks / 1000;
    new sessionMinutes = (sLenUnderHourTicks - sLenUnderMinuteTicks) / 60000;
    new sessionHours = (sessionLength - sLenUnderHourTicks) / 3600000;

	new string[128];
    format(string, sizeof(string), "Czas gry gracza %s [ID %d]: Godzin - %d | Minut - %d | Sekund - %d", 
        GetNick(giveplayerid), giveplayerid, sessionHours, sessionMinutes, sessionSeconds);
    SendClientMessage(playerid, COLOR_WHITE, string);

	return 1;
}

//end
