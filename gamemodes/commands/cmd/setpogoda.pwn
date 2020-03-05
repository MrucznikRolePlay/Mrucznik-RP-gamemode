//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ pogoda ]------------------------------------------------//
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
	Zmienia pogodê dla gracza o podanym ID.
*/


// Notatki skryptera:
/*
	
*/

YCMD:setpogoda(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 1 || !IsAScripter(playerid))
		{
		    noAccessMessage(playerid);
		    return 1;
		}
		new weather, giveplayerid;
		if( sscanf(params, "k<fix>d", giveplayerid, weather))
		{
		    sendTipMessage(playerid, "U¿yj /pogoda [ID/Czêœæ nicku] [pogodaid]");
		    return 1;
		}
		if(weather < 2||weather > 20)
		{ 
			sendTipMessageEx(playerid, COLOR_GREY, "Id pogody od 2 do 20 !"); 
			return 1; 
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza!");
			return 1;
		}

		SetPlayerWeatherEx(giveplayerid, weather);
		new string[128];
		format(string, sizeof(string), "Admin %s zmieni³ pogodê dla %s na %d", GetNickEx(playerid), GetNick(giveplayerid), weather); 
		SendMessageToAdmin(string, COLOR_P@);
		format(string, sizeof(string), "Administrator %s zmieni³ Ci pogodê na %d", GetNickEx(playerid), weather);
		sendTipMessage(giveplayerid, string); 
	}
	return 1;
}
