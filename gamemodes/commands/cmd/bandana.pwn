//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ bandana ]------------------------------------------------//
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

YCMD:bandana(playerid, params[], help)
{
	if(IsAPrzestepca(playerid) || (IsAFBI(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		new string[64];
		new sendername[MAX_PLAYER_NAME];

		if(IsPlayerAttachedObjectSlotUsed(playerid, 2))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga bandane z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			RemovePlayerAttachedObject(playerid,2);
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
			new Float:X, Float:Y, Float:Z, pName[55];
    		GetPlayerPos( playerid, X, Y, Z );
			SetPlayerColor(playerid, COLOR_BLACK);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s zak³ada bandane na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerAttachedObject(playerid, 2, 18896, 2, 0.122467, 0.007340, 0.003190, 274.433288, 0.248657, 262.665466, 1.000000, 1.000000, 1.000000 );//bandana - czarna
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
	return 1;
}
