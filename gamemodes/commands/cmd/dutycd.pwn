//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dutycd ]------------------------------------------------//
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

YCMD:dutycd(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsAPolicja(playerid) && PoziomPoszukiwania[playerid] > 0)
		{
			sendTipMessage(playerid, "Osoby poszukiwane przez policjê nie mog¹ rozpocz¹æ s³u¿by !");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ  podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
			return 1;
		}
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wzi¹æ s³u¿be musisz byæ pieszo!");

        if(OnDuty[playerid]==1 && OnDutyCD[playerid] == 0) return sendTipMessage(playerid, "U¿yj /duty !");

		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
			if (PlayerToPoint(3, playerid,255.3,77.4,1003.6)
			|| PlayerToPoint(5, playerid, 266.7904,118.9303,1004.6172)
			|| PlayerToPoint(3, playerid, 1579.6711,-1635.4512,13.5609)
			|| PlayerToPoint(3, playerid, -2614.1667,2264.6279,8.2109)
			|| PlayerToPoint(3, playerid, 2425.6,117.69,26.5)//nowe domy
			|| PlayerToPoint(3, playerid, -1649.6832,885.4910,-45.4141)//nowe komi by dywan
			|| PlayerToPoint(3, playerid, -1645.3046,895.2336,-45.4141)
            || PlayerToPoint(3, playerid, 1572.1919,-1631.5922,13.3991))//KILSON NOWY SPAWN

			{
				if(OnDuty[playerid]==0 && OnDutyCD[playerid] == 0)
		        {
			    	format(string, sizeof(string), "* Oficer %s bierze odznakê i broñ ze swojej szafki.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					DajBronieFrakcyjne(playerid);
					SetPlayerArmour(playerid, 90);
	    		    SetPlayerHealth(playerid, 100);
	    		    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
					OnDuty[playerid] = 1;
					OnDutyCD[playerid] = 1;
                    //SetPlayerToTeamColor(playerid);
				}
				else if(OnDuty[playerid]==1 && OnDutyCD[playerid] == 1)
				{
					format(string, sizeof(string), "* Oficer %s odk³ada odznakê i broñ do swojej szafki.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetPlayerArmour(playerid, 0.0);
	    		    SetPlayerHealth(playerid, 100);
					
	    		    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    OnDuty[playerid] = 0;
                    OnDutyCD[playerid] = 0;
                    PrzywrocBron(playerid);
                    SetPlayerToTeamColor(playerid);
				}
			}
			else
			{
				sendTipMessage(playerid, "Nie jesteœ w szatni !");
				return 1;
			}
		}
		else if((PlayerInfo[playerid][pMember] == FRAC_BOR && PlayerInfo[playerid][Rank] >= 2) || PlayerInfo[playerid][pLider] == FRAC_BOR)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 1521.8843,-1479.6427,22.9377))
			{
				if(OnDuty[playerid] == 0 && OnDutyCD[playerid] == 0)
				{
					format(string, sizeof(string), "* Agent %s bierze identyfikator i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    DajBronieFrakcyjne(playerid);
                    SetPlayerArmour(playerid, 70);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    OnDuty[playerid] = 1;
                    OnDutyCD[playerid] = 1;
				}
				else
				{
					format(string, sizeof(string), "* Agent %s odk³ada identyfikator i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    OnDuty[playerid] = 0;
                    OnDutyCD[playerid] = 0;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    PrzywrocBron(playerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie jesteœ w odpowiednim miejscu!"); 
				return 1;
			}
		}
		else if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
        {
            if ( IsPlayerInRangeOfPoint(playerid, 5.0, 254.1888,77.0841,1003.6406) || IsPlayerInRangeOfPoint(playerid, 5.0, 609.0364,-555.1090,19.4573) ) //PlayerToPoint(3, playerid,255.3,77.4,1003.6) || PlayerToPoint(3,playerid,266.7904,118.9303,1004.6172) || PlayerToPoint(10.0,playerid, 2515.0200, -2459.5896, 13.8187)
            {
                if(OnDuty[playerid]==0 && OnDutyCD[playerid] == 0)
                {
                    format(string, sizeof(string), "* Funkcjonariusz %s bierze odznakê i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    DajBronieFrakcyjne(playerid);
                    SetPlayerArmour(playerid, 90);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    OnDuty[playerid] = 1;
                    OnDutyCD[playerid] = 1;
                }
                else if(OnDuty[playerid]==1 && OnDutyCD[playerid] == 1)
                {
                    format(string, sizeof(string), "* Funkcjonariusz %s odk³ada odznakê i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
                    OnDutyCD[playerid] = 0;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    PrzywrocBron(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ w szatni !");
                return 1;
            }
        }
		else
		{
		    noAccessMessage(playerid);
		}
	}
	return 1;
}
