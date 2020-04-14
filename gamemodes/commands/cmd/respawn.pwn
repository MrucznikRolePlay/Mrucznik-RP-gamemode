//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ respawn ]------------------------------------------------//
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

YCMD:respawn(playerid, params[], help)
{
	new string[128];
	
	
	if(Count >= 30)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHalfAdmin] >= 1 && PlayerInfo[playerid][pHalfAdmin] <= 3 || IsAScripter(playerid))
		{
			SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpoczête");
			BroadCast(COLOR_PANICRED, "Uwaga! Za 30 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
			format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz¹³ odliczanie do Respawnu Aut !", GetNickEx(playerid), playerid);
			ABroadCast(COLOR_PANICRED,string,1);
			CountDownVehsRespawn();	
		}
		else
		{
			sendErrorMessage(playerid, "Poczekaj a¿ skoñczy siê to odliczanie!!!");
		}
	}
	return 1;
}
