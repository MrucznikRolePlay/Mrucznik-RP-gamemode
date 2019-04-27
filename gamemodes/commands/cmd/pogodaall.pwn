//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ pogodaall ]-----------------------------------------------//
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

CMD:pogodaall(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 7)
		{
			new weather;
			if( sscanf(params, "d", weather))
			{
			    sendTipMessage(playerid, "U¿yj: /pogodaall [pogodaid]");
			    return 1;
			}


			if(weather < 2||weather > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Id pogody od 2 do 20 !"); return 1; }
			SetWeatherEx(weather);
			sendTipMessageEx(playerid, COLOR_GREY, "Pogoda zmieniona dla wszystkich !");
            new string[128];
            format(string, 128, "CMD_Info: /pogodaall u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
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
		    return 1;
		}
	}
	return 1;
}

