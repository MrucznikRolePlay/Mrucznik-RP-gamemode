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
command_sluzba_Impl(playerid)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAPolicja(playerid) && PoziomPoszukiwania[playerid] > 0)
        {
            sendTipMessage(playerid, "Osoby poszukiwane przez policj� nie mog� rozpocz�� s�u�by !");
            return 1;
        }
        if(IsAPolicja(playerid) && OnDutyCD[playerid] == 1)
        {
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "U�yj /dutycd!");
            return 1;
        }
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz tego u�y�  podczas @Duty! Zejd� ze s�u�by u�ywaj�c /adminduty");
			return 1;
		}

        new frac = GetPlayerFraction(playerid);
        if(FracGetsUniformOnDuty(frac) && PlayerInfo[playerid][pUniform] == 0)
        {
            sendTipMessage(playerid, "Nie masz skina frakcyjnego, u�yj /fskin !");
            return 1;
        }
		
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby wzi�� s�u�be musisz by� pieszo!");

        if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
        {
            sendErrorMessage(playerid, "Jeste� podczas wsiadania - odczekaj chwile. Nie mo�esz znajdowa� si� w poje�dzie.");
            return 1;
        }

        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(frac == 1)
        {
            if (IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Oficer %s bierze odznak� i bro� ze swojej szafki.", sendername);
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
                    format(string, sizeof(string), "* Oficer %s odk�ada odznak� i bro� do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    OnDuty[playerid] = 0;
					SecretAgent[playerid] = 0;
                    SetPlayerArmour(playerid, 0.0);
                    PrzywrocBron(playerid);
                    SetPlayerToTeamColor(playerid);
                    RmvLSPDMemberFromThiefMapIcons(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jeste� w szatni !");
                return 1;
            }
        }
        else if(frac == 2)
        {
            if (IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Agent FBI %s bierze odznak� i bro� ze swojej szafki.", sendername);
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
                    format(string, sizeof(string), "* Agent FBI %s odk�ada odznak� i bro� do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
					SecretAgent[playerid] = 0;
                    PrzywrocBron(playerid);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerToTeamColor(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jeste� w szatni !");
                return 1;
            }
        }
        else if(frac == 3)
        {
            if(IsAtDutyPlace(playerid))
            {
                if(OnDuty[playerid]==0)
                {
                    format(string, sizeof(string), "* Funkcjonariusz %s bierze mundur i bro� ze swojej szafki.", sendername);
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
                    format(string, sizeof(string), "* Funkcjonariusz %s odk�ada mundur i bro� do swojej szafki.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
					SecretAgent[playerid] = 0;
                    SetPlayerToTeamColor(playerid);
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    PrzywrocBron(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jeste� w szatni !");
                return 1;
            }
        }
        else if(frac == 4)
        {
            if (PlayerToPoint(4, playerid,1147.3623,-1314.4891,13.6743))
            {
                if(JobDuty[playerid] == 1)
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie LSRS, nie b�dziesz widzia� zg�osze�.");
                    JobDuty[playerid] = 0;
                    Medics -= 1;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                    SetPlayerToTeamColor(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� na s�u�bie LSRS, kiedy kto� b�dzie potrzebowa� pomocy zostanie wy�wietlony komunikat.");
                    JobDuty[playerid] = 1;
                    Medics += 1;
                    SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                    SetPlayerToTeamColor(playerid);
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jeste� w szatni !");
                return 1;
            }
        }
        else if(GetPlayerJob(playerid) == JOB_MEDIC)
        {
            if(JobDuty[playerid] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie LSRS, nie b�dziesz widzia� zg�osze�.");
                JobDuty[playerid] = 0;
                Medics -= 1;
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                SetPlayerToTeamColor(playerid);
                OOCNews(COLOR_LIGHTRED, sprintf("Medyk %s zszed� ze s�u�by.", GetNick(playerid)));
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� na s�u�bie LSRS, kiedy kto� b�dzie potrzebowa� pomocy zostanie wy�wietlony komunikat.");
                JobDuty[playerid] = 1;
                Medics += 1;
                if(PlayerInfo[playerid][pUniform] == 0)
                {
                    if(PlayerInfo[playerid][pSex] == 1) PlayerInfo[playerid][pUniform] = 20743;
                    else PlayerInfo[playerid][pUniform] = 20468;
                }
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                SetPlayerToTeamColor(playerid);
                OOCNews(COLOR_LIGHTRED, sprintf("Medyk %s jest na s�u�bie, wpisz /wezwij medyk je�li potrzebujesz pomocy!", GetNick(playerid)));
            }
        }
        else if(frac == 11)
        {
            if(JobDuty[playerid] == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie urz�dasa.");
                JobDuty[playerid] = 0;
                SetPlayerToTeamColor(playerid);
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
				
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� ju� na s�u�bie urz�dasa. Id� do Urz�du urz�dasie.");
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
                    format(string, sizeof(string), "* Agent USSS %s wyci�ga bro� i garnitur z szafy.", sendername);//a
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
                    format(string, sizeof(string), "* Agent USSS %s chowa bro� i garnitur do szafy.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    SetPlayerArmour(playerid, 0);
                    SetPlayerHealth(playerid, 100);
                    OnDuty[playerid] = 0;
					SecretAgent[playerid] = 0;
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
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "*Nie jeste� ju� na s�u�bie taks�wkarza");
				JobDuty[playerid] = 0;
				SetPlayerToTeamColor(playerid);
				SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
            }
            else
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wchodzisz na s�u�b�, udaj si� do pojazdu!");
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
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie mechanika, nie b�d� ci si� wy�wietla� zg�oszenia.");
                    JobDuty[playerid] = 0;
                    Mechanics -= 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� na s�u�bie mechanika, kiedy kto� b�dzie ci� potrzebowa� zostanie wy�wietlony komunikat.");
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
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Nie jeste� ju� na s�u�bie reportera, komunikaty oraz kasa za SMS nie b�d� wysy�ane.");
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
                SanDuty[playerid] = 0;
                SetPlayerToTeamColor(playerid);
            }
            else
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeste� na s�u�bie reportera.");
                SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
                SanDuty[playerid] = 1;
                SetPlayerToTeamColor(playerid);
            }
        }
        else
        {
            sendTipMessage(playerid, "Nie jeste� policjantem !");
        }
    }
    return 1;
}

//end
