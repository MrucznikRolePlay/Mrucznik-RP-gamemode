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
command_login_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pNewAP] == 0 && !IsAScripter(playerid))
		{
			noAccessMessage(playerid);
			return 1;
		}

		if(sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /login [id]");
			return 1;
		}
		if(!IsPlayerConnected(playa)) {
			sendTipMessage(playerid, "Gracz nie jest zalogowany.");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] <1000 && playa != playerid)
		{
			sendTipMessage(playerid, "Mo¿esz u¿ywaæ tej komendy tylko na sobie.");
			return 1;
		}
		new nick[24];
		if(GetPVarString(playa, "maska_nick", nick, 24))
		{
			if(!IsAPolicja(playa)) RemovePlayerAttachedObject(playa,1);
			SetPlayerName(playa, nick);
			SetRPName(playa);
			format(PlayerInfo[playa][pNick], 24, "%s", nick);
			DeletePVar(playa, "maska_nick");
		}
		SetPlayerColor(playa, TEAM_HIT_COLOR);
		new Float:slx, Float:sly, Float:slz;
		GetPlayerPos(playa, slx, sly, slz);
		PlayerPlaySound(playa, 1130, slx, sly, slz+5);
		Log(punishmentLog, INFO, "Admin %s u¿y³ (/login) i wylogowa³ %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
		ABroadCast(COLOR_LIGHTRED,sprintf("AdmCmd: %s wylogowa³ poprzez (/login) gracza %s",GetNickEx(playerid), GetNickEx(playa)),1);
		SendClientMessage(playa, COLOR_PANICRED, sprintf("Zosta³eœ wylogowany przez administratora %s", GetNickEx(playerid)));
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			iloscInne[playerid] = iloscInne[playerid]+1;
		}
		playerid = playa;

		//wiadomoœci
		new reString[144];
		format(reString, sizeof(reString), "SERWER: Gracz znajduj¹cy siê w pobli¿u wyszed³ z serwera (%s, powód: /login).", GetNick(playerid));
		ProxDetector(25.0, playerid, reString, COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
		//czynnoœci
		PlayerTextDrawHide(playerid, Kary[playerid]); 
		PlayerTextDrawHide(playerid, Licznik[playerid]);
		MruMySQL_SaveAccount(playerid);
		ZerujZmienne(playerid);
		gPlayerLogged[playerid] = 0;
		LoggingIn[playerid] = 0;
		OnPlayerConnect(playerid);

		TogglePlayerSpectating(playerid, true);
		defer StartLogin(playerid, SessionID[playerid]);

		//Dla graczy którzy nie maj¹ najnowszej wersji samp'a
		PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);

		new rand = random(5);
		switch(rand)
		{
			case 0:
			{
				PlayerPlaySound(playerid, 171, 0.0, 0.0, 0.0);
			}
			case 1:
			{
				PlayerPlaySound(playerid, 176, 0.0, 0.0, 0.0);
			}
			case 2:
			{
				PlayerPlaySound(playerid, 1076, 0.0, 0.0, 0.0);
			}
			case 3:
			{
				PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
			}
			case 4:
			{
				new rand2 = random(8);
				switch(rand2)
				{
					case 0:
					{
						PlayerPlaySound(playerid, 157, 0.0, 0.0, 0.0);
					}
					case 1:
					{
						PlayerPlaySound(playerid, 162, 0.0, 0.0, 0.0);
					}
					case 2:
					{
						PlayerPlaySound(playerid, 169, 0.0, 0.0, 0.0);
					}
					case 3:
					{
						PlayerPlaySound(playerid, 178, 0.0, 0.0, 0.0);
					}
					case 4:
					{
						PlayerPlaySound(playerid, 180, 0.0, 0.0, 0.0);
					}
					case 5:
					{
						PlayerPlaySound(playerid, 181, 0.0, 0.0, 0.0);
					}
					case 6:
					{
						PlayerPlaySound(playerid, 147, 0.0, 0.0, 0.0);
					}
					case 7:
					{
						PlayerPlaySound(playerid, 140, 0.0, 0.0, 0.0);
					}
				}
			}
		}
	}
	return 1;
}

//end
