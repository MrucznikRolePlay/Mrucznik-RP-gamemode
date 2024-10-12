//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_megafon_Impl(playerid, params[256])
{
    new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		//new tmpcar = GetPlayerVehicleID(playerid);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/m)egafon [tekst]");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /b [treœæ]");
			return 1;
		}
		//=========================[DLA SAN NEWS]==================================
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 292.9130,-1572.0863,118.1219))
		{
			format(string, sizeof(string), "[Uczestnik [1] %s: %s]", sendername, params);
			ProxDetector(50.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 294.8142,-1572.0300,118.1219))
		{
			format(string, sizeof(string), "[Uczestnik [2] %s: %s]", sendername, params);
			ProxDetector(50.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 297.7858,-1572.1030,118.1219))
		{
			format(string, sizeof(string), "[Uczestnik [3] %s: %s]", sendername, params);
			ProxDetector(50.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 299.9479,-1572.0898,118.1219))
		{
			format(string, sizeof(string), "[Uczestnik [4] %s: %s]", sendername, params);
			ProxDetector(50.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 296.5654,-1574.9280,118.1219))
		{
			format(string, sizeof(string), "[Prowadz¹cy %s: %s]", sendername, params);
			ProxDetector(50.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		//=========================[DLA S¥DU]======================================
		if(GetPlayerVirtualWorld(playerid)== 15 || GetPlayerVirtualWorld(playerid)== 16 || GetPlayerVirtualWorld(playerid)== 17)
		{
			if(IsPlayerInRangeOfPoint(playerid,5,1319.7424,-1359.5912,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1319.8655,-1319.5767,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1313.1859,-1295.6798,79.7320))//Oskar¿ony
			{
				format(string, sizeof(string), "[Oskar¿ony %s: %s]", sendername, params);
				ProxDetector(100.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid,5,1311.6882,-1359.3763,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1311.6819,-1319.5743,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1306.6122,-1295.5017,79.7320))//Oskar¿yciel
			{
				format(string, sizeof(string), "[Oskar¿yciel %s: %s]", sendername, params);
				ProxDetector(100.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid,5,1315.5699,-1355.1246,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1315.6741,-1314.7883,73.1409)
			|| IsPlayerInRangeOfPoint(playerid,5,1321.9991,-1283.2745,80.1720))//Swiadek
			{
				format(string, sizeof(string), "[Œwiadek %s: %s]", sendername, params);
				ProxDetector(100.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				return 1;
			}
		}
		//=======================[KONIEC]==================================================
		//=======================[DLA ORGANIZACJI:]========================================
		
		if(PlayerInfo[playerid][pMember] == 1||PlayerInfo[playerid][pLider] == 1)
		{
			format(string, sizeof(string), "[%s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 2||PlayerInfo[playerid][pLider] == 2)
		{
			format(string, sizeof(string), "[%s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 3||PlayerInfo[playerid][pLider] == 3)
		{
		    format(string, sizeof(string), "[%s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 7||PlayerInfo[playerid][pLider] == 7)
		{
		    format(string, sizeof(string), "[%s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pJob] == 1 && PlayerInfo[playerid][pDetSkill] > 400)
		{
		    format(string, sizeof(string), "[%s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS)
		{
		    format(string, sizeof(string), "[%s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == FRAC_SN || PlayerInfo[playerid][pLider] == FRAC_SN)
		{
			format(string, sizeof(string), "[%s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if( (PlayerInfo[playerid][pMember] == FRAC_KT || PlayerInfo[playerid][pLider] == FRAC_KT) && PlayerInfo[playerid][pRank] >= 3)
		{
			format(string, sizeof(string), "[%s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		//
		else if(PlayerInfo[playerid][pMember] == 17||PlayerInfo[playerid][pLider] == 17)
		{
			format(string, sizeof(string), "[%s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
        else if((PlayerInfo[playerid][pMember] == 11 || PlayerInfo[playerid][pLider] == 11) && PlayerInfo[playerid][pRank] >= 5)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, 1471.2521,-1825.2295,78.3412))
            {
                format(string, sizeof(string), "[Wyk³adowca %s: %s]", sendername, params);
                ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
            }
            else
            {
                return sendTipMessage(playerid, "Jako wyk³adowca mo¿esz u¿ywaæ mikrofonu tylko na sali wyk³adowczej!");
            }
        }
		else if(IsAClubBusinessOwner(playerid) && PlayerInfo[playerid][pRank] > 1)
        {
			new player_vw;
			player_vw = GetPlayerVirtualWorld(playerid);
			if(player_vw == 21 || player_vw == 22 || player_vw == 23 || player_vw == 24 || player_vw == 26 || player_vw == 27)
			{
				if(IsPlayerInRangeOfPoint(playerid, 1000, 430.4849,-1837.2827,-65.5105))
				{
					format(string, sizeof(string), "[Ibiza> %s: %s]", sendername, params);
					ProxDetector(100.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
				}
			}
		}
		else
		{
		    noAccessMessage(playerid);
			return 1;
		}
	    Log(chatLog, INFO, "%s megafon: %s", GetPlayerLogName(playerid), params);
		format(string, sizeof(string), "Megafon: %s!!", params);
		SetPlayerChatBubble(playerid,string,COLOR_YELLOW,30.0,8000);
	}
	return 1;
}

//end
