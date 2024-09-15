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
command_czas_Impl(playerid, params[256])
{
    new string[256];

    if(IsPlayerConnected(playerid))
	{
	    new mtext[20];
		new year, month,day;
		getdate(year, month, day);
		if(month == 1) { mtext = "Styczen"; }
		else if(month == 2) { mtext = "Luty"; }
		else if(month == 3) { mtext = "Marzec"; }
		else if(month == 4) { mtext = "Kwiecien"; }
		else if(month == 5) { mtext = "Maj"; }
		else if(month == 6) { mtext = "Czerwiec"; }
		else if(month == 7) { mtext = "Lipiec"; }
		else if(month == 8) { mtext = "Sierpien"; }
		else if(month == 9) { mtext = "Wrzesien"; }
		else if(month == 10) { mtext = "Pazdziernik"; }
		else if(month == 11) { mtext = "Listopad"; }
		else if(month == 12) { mtext = "Grudzien"; }
	    new hour,minuite,second;
		gettime(hour,minuite,second);
		FixHour(hour);
		hour = shifthour;
		if (minuite < 10)
		{
			format(string, sizeof(string), "~y~%d %s %d ~n~~g~|~w~%d:0%d~g~|", day, mtext, year, hour, minuite);
		}
		else
		{
			format(string, sizeof(string), "~y~%d %s %d~n~~g~|~w~%d:%d~g~|", day, mtext, year, hour, minuite);
		}

		if (PlayerInfo[playerid][pJailTime] > 0 && PlayerInfo[playerid][pJailed] != 10)
		{
			format(string, sizeof(string), "%s~n~~w~Czas Aresztu: %d sec", string, PlayerInfo[playerid][pJailTime]-10);
		}

		if (stole_a_car_seconds_to_find_cp[playerid] > 0)
		{
			format(string, sizeof(string), "%s~n~~w~Czas do znalezienia dziupli: %d sec", string, stole_a_car_seconds_to_find_cp[playerid]);
		}
		
		GameTextForPlayer(playerid, string, 5000, 1);
	}
	return 1;
}

//end
