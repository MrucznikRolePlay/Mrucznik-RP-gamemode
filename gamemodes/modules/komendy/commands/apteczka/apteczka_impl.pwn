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
command_apteczka_Impl(playerid, params[256])
{
    new playa, giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[144];
	if(sscanf(params, "k<fix>", playa))
	{
		//domowa apteczka
		if(PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pDom] || PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pWynajem] && Dom[PlayerInfo[playerid][pDom]][hUL_D] != 0)
		{
			new dom = PlayerInfo[playerid][pDom];
			if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]))
			{
				if(Dom[dom][hApteczka] != 0)
				{
					SetPlayerHealth(playerid, 100);
					format(string, sizeof(string), "%s wyci¹ga apteczkê domow¹, banda¿uje rany, za¿ywa mru-apap. Czuje siê lepiej.", GetNick(playerid));
					ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					format(string, sizeof(string), "---[%s u¿y³ apteczki domowej]---", GetNick(playerid));
					SendAdminMessage(COLOR_GREEN, string);
					GameTextForPlayer(playerid, "~r~Czujesz sie lepiej ~n~ dzieki mrupap", 6000, 1);	
					return 1;
				}
			}
		}
		sendTipMessage(playerid, "U¿yj /apteczka [ID gracza], b¹dŸ /apteczka bêd¹c w domu.");
		return 1;
	}
	if(!IsPlayerConnected(playa) || playa == INVALID_PLAYER_ID) 
	{
		return sendErrorMessage(playerid, "Nie ma takiego gracza.");
	}

	if(playa == playerid)
	{
		return sendErrorMessage(playerid, "Nie mo¿esz sam siebie opatrzyæ.");
	}

	if(PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0) return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ apteczki gdy jesteœ ranny!");
	if (isPlayerCuffed[playerid]) return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ apteczki bêd¹c skutym!");

	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(GetDistanceBetweenPlayers(playerid,playa) > 5)
	{
		format(string, sizeof(string),"Jesteœ zbyt daleko od gracza %s", giveplayer);
		return SendClientMessage(playerid, COLOR_GRAD1, string);
	}

	if((PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS || GetPlayerJob(playerid) == JOB_MEDIC) && (OnDuty[playerid] == 1 || JobDuty[playerid] == 1))
	{	
		if(PlayerInfo[playa][pBW] == 0 && PlayerInfo[playa][pInjury] == 0) return sendTipMessage(playerid, "Gracz nie jest wystarczaj¹co ranny wiêc nie wymaga interwencji.");
		format(string, sizeof string, "Proponujesz %s zastosowanie apteczki i wyleczenie mu ran.", GetNick(playa));
		SendClientMessage(playerid, -1, string);
		format(string, sizeof string, "* Lekarz %s proponuje Ci wyleczenie ran i udzielenie pomocy medycznej.", GetNick(playerid));
		SetPVarInt(playa, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(playa, D_UZYCIE_APTECZKI, DIALOG_STYLE_MSGBOX, "Pomoc medyczna", string, "Przyjmij", "Anuluj");
		ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
	}
	else
	{
		if(PlayerInfo[playerid][pHealthPacks] < 1) return sendErrorMessage(playerid, "Nie posiadasz przy sobie apteczki, mo¿esz je kupiæ u medyków!");

		if(PlayerInfo[playa][pBW] > 0)
		{
			return sendTipMessage(playerid, "Gracz wymaga interwencji lekarza! (/wezwij medyk, /dzwon 911)");
		}

		if(PlayerInfo[playa][pInjury] == 0)
		{
			return sendTipMessage(playerid, "Gracz nie jest wystarczaj¹co ranny wiêc nie wymaga interwencji.");
		}

		format(string, sizeof string, "Proponujesz %s zastosowanie apteczki i wyleczenie mu ran.", GetNick(playa));
		SendClientMessage(playerid, -1, string);
		format(string, sizeof string, "* %s proponuje Ci wyleczenie ran i udzielenie pomocy medycznej.", GetNick(playerid));
		SetPVarInt(playa, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(playa, D_UZYCIE_APTECZKI, DIALOG_STYLE_MSGBOX, "Pomoc medyczna", string, "Przyjmij", "Anuluj");
		ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
	}
	return 1;
}

//end
