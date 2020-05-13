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
	if(IsAPolicja(playerid) || IsAPrzestepca(playerid))
	{
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			return sendErrorMessage(playerid, "Nie mo¿esz za³o¿yæ maski bêd¹c na AdminDuty!"); 
		}
		if(IsAFBI(playerid))
		{
			if(PlayerInfo[playerid][pRank] < 2)
			{
				return sendErrorMessage(playerid, "Maska jest dostêpna od [2] rangi");
			}
		}
		else if(IsAPolicja(playerid))
		{
			if(PlayerInfo[playerid][pRank] < 3)
			{
				return sendErrorMessage(playerid, "Maska jest dostêpna od [3] rangi");
			}
			else
			{
				if(OnDutyCD[playerid] != 1 && OnDuty[playerid] != 1) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Najpierw u¿yj /duty !");
				if(GetPlayerSkin(playerid) != 285) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "¯eby u¿yæ maski musisz mieæ skin SWAT (/swat)");
			}
		}
		if(AntySpam[playerid] == 1)
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
	        return 1;
	    }
		SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
		AntySpam[playerid] = 1;
		new string[64];
		new sendername[MAX_PLAYER_NAME];
		new nick[32];
		if(GetPVarString(playerid, "maska_nick", nick, 24))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga maskê z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(!IsAPolicja(playerid)) RemovePlayerAttachedObject(playerid,1);
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
			if(!IsAPolicja(playerid)) SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.1, 0.05, -0.005, 0, 90, 90);//maska hokeisty biala
			MSGBOX_Show(playerid, "~r~~h~Ukryto ~w~twarz", MSGBOX_ICON_TYPE_OK);
			new maskid[6];
			randomString(maskid, sizeof(maskid));
			strToUpper(maskid);
			if(PlayerInfo[playerid][pSex] == 1)
			{
				format(pName, sizeof(pName), "Zamaskowany_%d", maskid);
			}
			else
			{
				format(pName, sizeof(pName), "Zamaskowana_%d", maskid);
			}
			if(SetPlayerName(playerid, pName))
			{
				SetPlayerColor(playerid, TEAM_HIT_COLOR);
				SetRPName(playerid);
				format(PlayerInfo[playerid][pNick], 24, "%s", pName);
				SetPVarString(playerid, "maska_nick", sendername);
				Log(nickLog, INFO, "Gracz %s za³o¿y³ maskê %s", GetPlayerLogName(playerid), pName);
				sendErrorMessage(playerid, "OSTRZE¯ENIE: Nadu¿ywanie maski skutkuje natychmiastowym wyrzuceniem z frakcji.");
			}
		
		} 
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
