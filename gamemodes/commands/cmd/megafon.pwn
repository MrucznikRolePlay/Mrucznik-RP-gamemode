//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ megafon ]------------------------------------------------//
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

YCMD:megafon(playerid, params[], help)
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
		//=========================[DLA S¥DU]======================================
		if(IsPlayerInRangeOfPoint(playerid, 2.2, 1306.3802,-1305.0647,36.7236))//Oskar¿ony
		{
			format(string, sizeof(string), "[Oskar¿ony %s: %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.2, 1305.8812,-1294.8978,36.7216))//Oskar¿yciel
		{
			format(string, sizeof(string), "[Oskar¿yciel %s: %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.2, 1304.4594,-1300.0845,35.6941))//Swiadek
		{
			format(string, sizeof(string), "[Œwiadek %s: %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			return 1;
		}
		//=======================[KONIEC]==================================================
		//=======================[DLA ORGANIZACJI:]========================================
		
		if(PlayerInfo[playerid][pMember] == 1||PlayerInfo[playerid][pLider] == 1)
		{
			format(string, sizeof(string), "[Oficer %s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 2||PlayerInfo[playerid][pLider] == 2)
		{
			format(string, sizeof(string), "[Agent FBI %s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 3||PlayerInfo[playerid][pLider] == 3)
		{
		    format(string, sizeof(string), "[Funkcjonariusz %s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 7||PlayerInfo[playerid][pLider] == 7)
		{
		    format(string, sizeof(string), "[Agent GSA %s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pJob] == 1 && PlayerInfo[playerid][pDetSkill] > 400)
		{
		    format(string, sizeof(string), "[£owca Nagród %s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if(PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4)
		{
		    format(string, sizeof(string), "[Specjalista SAM-ERS %s:o< %s]", sendername, params);
		    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		//PADZIOCH
		else if(PlayerInfo[playerid][pMember] == FRAC_SN || PlayerInfo[playerid][pLider] == FRAC_SN)
		{
			format(string, sizeof(string), "[Reporter %s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		else if( (PlayerInfo[playerid][pMember] == FRAC_KT || PlayerInfo[playerid][pLider] == FRAC_KT) && PlayerInfo[playerid][pRank] >= 3)
		{
			format(string, sizeof(string), "[Korporacja Transportowa %s:o< %s]", sendername, params);
			ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		//
		else if(PlayerInfo[playerid][pMember] == 17||PlayerInfo[playerid][pLider] == 17)
		{
			format(string, sizeof(string), "[Stra¿ak %s:o< %s]", sendername, params);
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
        else if(GetPlayerOrg(playerid) == FAMILY_SAD && PlayerInfo[playerid][pRank] > 2)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, 1310.2848,-1299.7623,36.9401))
            {
                format(string, sizeof(string), "[Sêdzia %s: %s]", sendername, params);
			    ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
            }
            else
            {
                return sendTipMessage(playerid, "Jako sêdzia mo¿esz u¿ywaæ mikrofonu tylko na sali rozpraw!");
            }
        }
		else
		{
		    noAccessMessage(playerid);
			return 1;
		}
		printf("%s", string);
		format(string, sizeof(string), "Megafon: %s!!", params);
		SetPlayerChatBubble(playerid,string,COLOR_YELLOW,30.0,8000);
	}
	return 1;
}
