//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ czyjtonumer ]----------------------------------------------//
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

YCMD:czyjtonumer(playerid, params[], help)
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHalfAdmin] >= 1 || IsAScripter(playerid))
	{
		new number, offline, string[128];
		if( sscanf(params, "dD(0)", number, offline))
		{
			sendTipMessage(playerid, "U¿yj /czyjtonumer [numer] (0 - gracze online, 1 - wszystkie konta)");
			sendTipMessage(playerid, "FUNKCJA: Pokazuje do kogo nale¿y numer telefonu.");
			return 1;
		}
		
		if(number <= 0)
		{
			sendErrorMessage(playerid, "Numer telefonu musi byæ wiêkszy ni¿ 0!");
			return 1;
		}
		
		if(number == 555)
		{
			format(string, sizeof(string), "Osoby z numerem %d:", number);
			SendClientMessage(playerid, COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Marcepan_Marks");
			return 1;
		}
		
		if(offline)
		{
			format(string, sizeof(string), "Osoby z numerem %d:", number);
			SendClientMessage(playerid, COLOR_WHITE, string);
			
			MruMySQL_CzyjToNumer(playerid, number);
		}
		else
		{
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pPnumber] == number)
				{
					SendClientMessage(playerid, COLOR_WHITE, GetNick(i));
				}
			}
		}
	}
	else
	{
		noAccessMessage(playerid);
  	}
	return 1;
}
