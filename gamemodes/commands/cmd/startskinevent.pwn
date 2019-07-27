//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------[ startskinevent ]---------------------------------------------------//
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

YCMD:startskinevent(playerid, params[], help)
{
	new string[256];
    if(IsPlayerConnected(playerid))
    {
		new value; 
		if(sscanf(params, "d", value))
		{
			sendTipMessage(playerid, "U¿yj: /startskinevent [ID]"); 
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 3500)
		{
			if(eventForSkin[value] == 0)
			{
				eventForSkin[value] = 1;
				format(string, sizeof(string), "%s w³¹czy³ event dla skina %d", GetNick(playerid), value); 
				SendMessageToAdmin(string, COLOR_YELLOW);
			}
			else if(eventForSkin[value] == 1)
			{
				eventForSkin[value] = 0;
				format(string, sizeof(string), "%s wy³¹czy³ event dla skina %d", GetNick(playerid), value); 
				SendMessageToAdmin(string, COLOR_YELLOW);
			}
		}
	}
	return 1;
}



