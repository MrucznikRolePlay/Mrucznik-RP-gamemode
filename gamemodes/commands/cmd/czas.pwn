//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ czas ]-------------------------------------------------//
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

YCMD:czas(playerid, params[], help)
{
	new string[128];

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
			if (PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s %d ~n~~g~|~w~%d:0%d~g~|~n~~w~Czas Aresztu: %d sek", day, mtext, year, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s %d ~n~~g~|~w~%d:0%d~g~|", day, mtext, year, hour, minuite);
			}
		}
		else
		{
			if (PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s %d~n~~g~|~w~%d:%d~g~|~n~~w~Czas Aresztu: %d sec", day, mtext, year, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s %d~n~~g~|~w~%d:%d~g~|", day, mtext, year, hour, minuite);
			}
		}
		GameTextForPlayer(playerid, string, 5000, 1);
	}
	return 1;
}
