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

CMD:megaphone(playerid, params[]) return cmd_megafon(playerid, params);
CMD:m(playerid, params[]) return cmd_megafon(playerid, params);
CMD:megafon(playerid, params[])
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
            if(IsPlayerInRangeOfPoint(playerid, 5.0, 1310.2848,-1299.7623,36.9401))
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


