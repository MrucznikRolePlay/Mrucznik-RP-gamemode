//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ dutymoto ]-----------------------------------------------//
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

CMD:dutymoto(playerid, params[]) 
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsACop(playerid) && PoziomPoszukiwania[playerid] > 0)
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
        if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
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
                    SetPlayerSkin(playerid, 284);
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
                    SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
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
        if(GetPlayerSkin(playerid) == 0)
        {
            SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
            sendTipMessage(playerid, "Nie masz skina frakcyjnego!");
        }
    }
    return 1;
}
