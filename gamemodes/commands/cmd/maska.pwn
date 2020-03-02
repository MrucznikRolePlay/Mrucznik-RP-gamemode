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
		new nick[32];
		if(IsPlayerAttachedObjectSlotUsed(playerid, 1) && GetPVarString(playerid, "maska_nick", nick, 32))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga maskê z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			RemovePlayerAttachedObject(playerid,1);
			MSGBOX_Show(playerid, "~g~~h~Pokazano ~w~twarz", MSGBOX_ICON_TYPE_OK);
			//
			foreach(new i : Player)
			{
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
			DestroyDynamic3DTextLabel(HiddenPlayerName[playerid]);
			SetPlayerName(playerid, nick);
			SetRPName(playerid);
			format(PlayerInfo[playerid][pNick], 32, "%s", nick);
			DeletePVar(playerid, "maska_nick");
		}
		else
		{
			//SetPlayerColor(playerid, COLOR_BLACK);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new Float:X, Float:Y, Float:Z, pName[MAX_PLAYER_NAME];
    		GetPlayerPos( playerid, X, Y, Z );
			format(string, sizeof(string), "* %s zak³ada maskê na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
			MSGBOX_Show(playerid, "~r~~h~Ukryto ~w~twarz", MSGBOX_ICON_TYPE_OK);
			//
			format(pName, sizeof(pName), "Zamaskowany_%d", PlayerInfo[playerid][pUID]);
			if(SetPlayerName(playerid, pName))
			{
				SetRPName(playerid);
				format(PlayerInfo[playerid][pNick], 32, "%s", pName);
				SetPVarString(playerid, "maska_nick", sendername);
				format(pName, sizeof(pName), "Nieznajomy_%d (%d)", PlayerInfo[playerid][pUID], playerid);
				HiddenPlayerName[playerid] = CreateDynamic3DTextLabel(pName, 0xFFFFFFAA, 0.0, 0.0, 0.15, 25.0, playerid, INVALID_VEHICLE_ID, 1, -1, -1, -1);
				foreach(new i : Player)
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
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
