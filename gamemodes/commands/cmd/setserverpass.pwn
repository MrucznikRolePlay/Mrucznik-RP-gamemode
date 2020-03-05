//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ restart ]------------------------------------------------//
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

YCMD:setservpass(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
			new string[128], passServ[64]; 
			if( sscanf(params, "s[64]", passServ))
			{
				sendTipMessage(playerid, "U¿yj /ssp [nowe haslo]");
				return 1;
			}
			if(strlen(passServ) < 4)
			{
				sendErrorMessage(playerid, "Zbyt krótkie has³o"); 
				return 1;
			}
			format(string, sizeof(string), "%s zarz¹dzi³ zamkniêcie serwera! Has³o zosta³o w³¹czone", GetNickEx(playerid));
			foreach(new i : Player)
			{
				sendErrorMessage(i, string);
				sendErrorMessage(i, "Wracamy za krótk¹ chwilê!"); 
				if(!IsAScripter(i) && PlayerInfo[i][pAdmin] == 0)
				{
					Kick(i); 
				}
			}
			format(string, sizeof(string), "password %s", passServ);
			SendRconCommand(string);
		}
		else
		{
			sendErrorMessage(playerid, "BRAK UPRAWNIEÑ!");
			return 1;
		}
	}
	return 1;
}
