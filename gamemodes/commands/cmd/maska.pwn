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
	if(IsACop(playerid) || IsAPrzestepca(playerid) || (IsAFBI(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		if(IsACop(playerid))
		{
			if(PlayerInfo[playerid][pRank] < 3)
			{
				sendErrorMessage(playerid, "Maska jest dostêpna od [3] rangi");
			}
			else
			{
				if(OnDutyCD[playerid] != 1 && OnDuty[playerid] != 1) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "U¿yj /duty !");
				sendErrorMessage(playerid, "OSTRZE¯ENIE: Nadu¿ywanie maski skutkuje natychmiastowym wyrzuceniem z frakcji.");
			}
		}
		new string[64];
		new sendername[MAX_PLAYER_NAME];
		new nick[32];
		if(GetPVarString(playerid, "maska_nick", nick, 24))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga maskê z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(!IsACop(playerid)) RemovePlayerAttachedObject(playerid,1);
			MSGBOX_Show(playerid, "~g~~h~Pokazano ~w~twarz", MSGBOX_ICON_TYPE_OK);
			SetPlayerName(playerid, nick);
			SetRPName(playerid);
			format(PlayerInfo[playerid][pNick], 24, "%s", nick);
			DeletePVar(playerid, "maska_nick");
		}
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new Float:X, Float:Y, Float:Z, pName[MAX_PLAYER_NAME];
    		GetPlayerPos( playerid, X, Y, Z );
			format(string, sizeof(string), "* %s zak³ada maskê na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(!IsACop(playerid)) SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
			MSGBOX_Show(playerid, "~r~~h~Ukryto ~w~twarz", MSGBOX_ICON_TYPE_OK);
			format(pName, sizeof(pName), "Zamaskowany_%d", PlayerInfo[playerid][pUID]);
			if(SetPlayerName(playerid, pName))
			{
				SetPlayerColor(playerid, TEAM_HIT_COLOR);
				SetRPName(playerid);
				format(PlayerInfo[playerid][pNick], 24, "%s", pName);
				SetPVarString(playerid, "maska_nick", sendername);
			}
		
		} 
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
