//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ wk ]--------------------------------------------------//
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

YCMD:wk(playerid, params[], help)
{
    if(PlayerInfo[playerid][pKluczeAuta] != 0)
    {
        new uid = Car_GetIDXFromUID(PlayerInfo[playerid][pKluczeAuta]);
        if(uid != -1) 
		{
			CarData[uid][c_Keys] = 0;
		}
  		PlayerInfo[playerid][pKluczeAuta] = 0;
  		sendTipMessage(playerid, "Kluczyki wywalone (skrót komendy: /wk)", COLOR_LIGHTBLUE);

		//log
		new string[256];
		new year, month, day;
		getdate(year, month, day);
		format(string, sizeof(string), "[%d|%d|%d] %s wyrzucil klucze [KEYS: %d]", year,
		month, 
		day, 
		GetNick(playerid, true),
		PlayerInfo[playerid][pUID],
		PlayerInfo[playerid][pKluczeAuta]);
		Log(autaLog, INFO, string);
  	}
  	else
  	{
  	    sendErrorMessage(playerid, "Nie masz kluczy");
  	}
	return 1;
}
