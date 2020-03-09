//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ uwb ]--------------------------------------------------//
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

YCMD:uwb(playerid, params[], help)//usuñ wszystkie bronie
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendTipMessage(playerid, "Najpierw zejdŸ z @DUTY!"); 
			return 1;
		}
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
		sendTipMessage(playerid, "Wszystkie bronie usuniête");
		//komunikat o wyrzuceniu
		new string[256];
		format(string, sizeof(string), "%s wyrzuca na ziemie swoj¹ zepsut¹ broñ.", GetNick(playerid)); 
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
