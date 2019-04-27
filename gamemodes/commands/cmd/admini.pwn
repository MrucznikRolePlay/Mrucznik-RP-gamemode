//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ admini ]------------------------------------------------//
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

YCMD:admini(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[128]; 
		SendClientMessage(playerid, -1, "Lista administratorów na s³u¿bie:"); 
		SendClientMessage(playerid, -1, " "); 
		foreach(new i : Player)
		{
			if(GetPlayerAdminDutyStatus(i) == 1)
			{
				GetPVarString(i, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname)); 
				if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] != 5000)
				{
					format(string, sizeof(string), "{FFFFFF}Administrator: {FF6A6A}%s {FFFFFF}[ID: %d] [FN: %s] [@LVL: %d]", GetNick(i), i, FirstNickname); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] != 5)
				{
					format(string, sizeof(string), "{FFFFFF}Pó³-Admin: {00C0FF}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname); 
				}
				else if(PlayerInfo[i][pNewAP] == 5) 
				{
					format(string, sizeof(string), "{FFFFFF}Skrypter serwera: {747b41}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname);
				}
				else if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{FFFFFF}G³ówny administrator: {FF6A6A}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname);
				}
				sendTipMessage(playerid, string); 
			}
		}
		
	}
	return 1;
}
