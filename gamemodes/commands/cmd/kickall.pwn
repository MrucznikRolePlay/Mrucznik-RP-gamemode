//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ KickEx_all ]----------------------------------------------//
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

YCMD:kickall(playerid, params[], help)
{
	if(IsAHeadAdmin(playerid))
	{
		new string[64], sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Admin %s (id:%d) zkickowal wszystkich graczy",sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		Log(adminLog, INFO, "Admin %s zkickowa³ wszystkich graczy", GetPlayerLogName(playerid));   

		foreach(new i : Player)
		{
			SendClientMessage(playerid, COLOR_WHITE,"*$AdmCmd$*: zkickowales wszystkich graczy!");
			KickEx(i);
		}
	}
    return 1;
}
