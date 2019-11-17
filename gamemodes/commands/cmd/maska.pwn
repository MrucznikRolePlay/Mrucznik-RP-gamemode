//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ maska ]-------------------------------------------------//
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

YCMD:maska(playerid, params[], help)
{
	if(IsAPrzestepca(playerid) || (IsAFBI(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		new string[64];
		new sendername[MAX_PLAYER_NAME];

		if(IsPlayerAttachedObjectSlotUsed(playerid, 1))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga maskê z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			RemovePlayerAttachedObject(playerid,1);
			MSGBOX_Show(playerid, "~g~~h~Pokazano twarz", MSGBOX_ICON_TYPE_OK);
			foreach(new i : Player)
			{
				if(GetPlayerAdminDutyStatus(playerid))
				{
					Delete3DTextLabel(HiddenPlayerName[playerid]);
				}
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
		}
		else
		{
			SetPlayerColor(playerid, COLOR_BLACK);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new Float:X, Float:Y, Float:Z, pName[55];
    		GetPlayerPos( playerid, X, Y, Z );
			format(string, sizeof(string), "* %s zak³ada maskê na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
			MSGBOX_Show(playerid, "~g~~h~Ukryto twarz", MSGBOX_ICON_TYPE_OK);
			foreach(new i : Player)
			{
				if(GetPlayerAdminDutyStatus(playerid))
				{
		   			Delete3DTextLabel(HiddenPlayerName[playerid]);
					format(pName, sizeof(pName), "%s [%d]\n((maska))", GetNick(playerid), playerid);
					HiddenPlayerName[playerid] = Create3DTextLabel(pName, COLOR_WHITE, X, Y, Z, 40.0, playerid);
					Attach3DTextLabelToPlayer(HiddenPlayerName[playerid], playerid, 0, 0, 0.3);
				}
				ShowPlayerNameTagForPlayer(i, playerid, 0);
			}
		
		} 
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
