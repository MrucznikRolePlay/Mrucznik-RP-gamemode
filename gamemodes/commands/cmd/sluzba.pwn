//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ sluzba ]------------------------------------------------//
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

YCMD:sluzba(playerid, params[], help)
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
        if(IsAPolicja(playerid) && OnDutyCD[playerid] == 1)
        {
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "U¿yj /dutycd !");
            return 1;
        }
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ  podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
			return 1;
		}

        new frac = GetPlayerFraction(playerid);
        if((FracGetsUniformOnDuty(frac) || GetPlayerOrg(playerid) == 12) && PlayerInfo[playerid][pUniform] == 0)
        {
            sendTipMessage(playerid, "Nie masz skina frakcyjnego, u¿yj /fskin !");
            return 1;
        }
		
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wzi¹æ s³u¿be musisz byæ pieszo!");

        if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
        {
            sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");
            return 1;
        }

        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(frac == 1)
        {
            if (IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Oficer %s bierze odznakê i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    DajBronieFrakcyjne(playerid);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerArmour(playerid, 90.0);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                    OnDuty[playerid] = 1;
                    SetPlayerToTeamColor(playerid);
                    AddLSPDMemberToThiefMapIcons(playerid);
                }
                else if(OnDuty[playerid]==1)
                {
                    format(string, sizeof(string), "* Oficer %s odk³ada odznakê i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    OnDuty[playerid] = 0;
                    SetPlayerArmour(playerid, 0.0);
                    PrzywrocBron(playerid);
                    SetPlayerToTeamColor(playerid);
                    RmvLSPDMemberFromThiefMapIcons(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ w szatni !");
                return 1;
            }
        }
        else if(frac == 2)
        {
            if (IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Agent FBI %s bierze odznakê i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    DajBronieFrakcyjne(playerid);
                    SetPlayerArmour(playerid, 90);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 1;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                    SetPlayerToTeamColor(playerid);
                }
                else if(OnDuty[playerid]==1)
                {
                    format(string, sizeof(string), "* Agent FBI %s odk³ada odznakê i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
                    PrzywrocBron(playerid);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerToTeamColor(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ w szatni !");
                return 1;
            }
        }
        else if(frac == 3)
        {
            if(IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Funkcjonariusz %s bierze mundur i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    DajBronieFrakcyjne(playerid);
                    SetPlayerArmour(playerid, 90);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 1;
                    SetPlayerToTeamColor(playerid);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                }
                else if(OnDuty[playerid]==1)
                {
                    format(string, sizeof(string), "* Funkcjonariusz %s odk³ada mundur i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
                    SetPlayerToTeamColor(playerid);
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
		else if(GetPlayerOrg(playerid) == 12)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 5.0, 2522.8916,-2441.6270,13.6435) )
            {
				if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* ¯o³nierz %s bierze odznakê i broñ ze swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 90);
                    SetPlayerHealth(playerid, 100);
					
					if(PlayerInfo[playerid][pSex] == 1)
						SetPlayerSkinEx(playerid, 287);
					else
						SetPlayerSkinEx(playerid, 191);
                    OnDuty[playerid] = 1;
                }
                else if(OnDuty[playerid]==1)
                {
                    format(string, sizeof(string), "* ¯o³nierz %s odk³ada odznakê i broñ do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    PrzywrocBron(playerid);
                }
			}
		}
        else if(frac == 4)
        {
            if (PlayerToPoint(4, playerid,1147.3623,-1314.4891,13.6743))
            {
                if(JobDuty[playerid] == 1)
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie LSRS, nie bêdziesz widzia³ zg³oszeñ.");
                    JobDuty[playerid] = 0;
                    Medics -= 1;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerToTeamColor(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ na s³u¿bie LSRS, kiedy ktoœ bêdzie potrzebowa³ pomocy zostanie wyœwietlony komunikat.");
                    JobDuty[playerid] = 1;
                    Medics += 1;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                    SetPlayerToTeamColor(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ w szatni !");
                return 1;
            }
        }
        else if(GetPlayerJob(playerid) == JOB_MEDIC)
        {
            if(JobDuty[playerid] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie LSRS, nie bêdziesz widzia³ zg³oszeñ.");
                JobDuty[playerid] = 0;
                Medics -= 1;
                SetPlayerToTeamColor(playerid);
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ na s³u¿bie LSRS, kiedy ktoœ bêdzie potrzebowa³ pomocy zostanie wyœwietlony komunikat.");
                JobDuty[playerid] = 1;
                Medics += 1;
                SetPlayerToTeamColor(playerid);
            }
        }
        else if(frac == 11)
        {
            if(JobDuty[playerid] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie urzêdasa.");
                JobDuty[playerid] = 0;
                SetPlayerToTeamColor(playerid);
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
				
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ ju¿ na s³u¿bie urzêdasa. IdŸ do Urzêdu urzêdasie.");
                JobDuty[playerid] = 1;
                SetPlayerToTeamColor(playerid);
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
            }
        }
        else if(frac == 7)
        {
            if (PlayerToPoint(5, playerid, 1521.8843,-1479.6427,22.9377))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Agent USSS %s wyci¹ga broñ i garnitur z szafy.", sendername);//a
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    OnDuty[playerid]= 1;
                    DajBronieFrakcyjne(playerid);
                    SetPlayerArmour(playerid, 90);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                    SetPlayerToTeamColor(playerid);
                }
                else if(OnDuty[playerid]==1)
                {
                    format(string, sizeof(string), "* Agent USSS %s chowa broñ i garnitur do szafy.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerToTeamColor(playerid);
                    PrzywrocBron(playerid);
                }
            }
        }
        else if(frac == 10)
        {
			if(JobDuty[playerid] == 1)
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "*Nie jesteœ ju¿ na s³u¿bie taksówkarza");
				JobDuty[playerid] = 0;
				SetPlayerToTeamColor(playerid);
				SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
            }
            else
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wchodzisz na s³u¿bê, udaj siê do pojazdu!");
                JobDuty[playerid] = 1;
                SetPlayerToTeamColor(playerid);
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
            }
        }
        else if(PlayerInfo[playerid][pJob] == 7)
        {
            if(AntySpam[playerid] == 0)
            {
                if(JobDuty[playerid] == 1)
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie mechanika, nie bêd¹ ci siê wyœwietlaæ zg³oszenia.");
                    JobDuty[playerid] = 0;
                    Mechanics -= 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ na s³u¿bie mechanika, kiedy ktoœ bêdzie ciê potrzebowa³ zostanie wyœwietlony komunikat.");
                    JobDuty[playerid] = 1;
                    Mechanics += 1;
                }
                AntySpam[playerid] = 1;
                SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Odczekaj 10 sekund");
            }
        }
        else if(frac == 9)
        {
            if(SanDuty[playerid] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jesteœ ju¿ na s³u¿bie reportera, komunikaty oraz kasa za SMS nie bêd¹ wysy³ane.");
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                SanDuty[playerid] = 0;
                SetPlayerToTeamColor(playerid);
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ na s³u¿bie reportera.");
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                SanDuty[playerid] = 1;
                SetPlayerToTeamColor(playerid);
            }
        }
        else
        {
            sendTipMessage(playerid, "Nie jesteœ policjantem !");
        }
    }
    return 1;
}
