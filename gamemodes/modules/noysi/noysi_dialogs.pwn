//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               noysi_dialogs                                               //
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
//Opis:
/*
	
*/
// Autor: Creative
// Data utworzenia: 08.04.2020

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==4192)
	{
		if( response == 0 ) return 1;
		new dg_value = DynamicGui_GetValue(playerid, listitem);

		if( dg_value == DG_DESC_DELETE )
		{
			Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, "");
			PlayerInfo[playerid][pDesc][0] = EOS;
			sendTipMessage(playerid, "Usun¹³eœ swój opis");
		}
		else if( dg_value == DG_DESC_ADD)
		{
			ShowPlayerDialogEx(playerid, 4193, DIALOG_STYLE_INPUT, "Ustaw opis postaci", "Wpisz nowy opis postaci\t", "Ok", "WyjdŸ");
		}
		else if( dg_value == DG_DESC_USEOLD )
		{
			new DBResult:db_result;
			db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `uid`=%d", DynamicGui_GetDataInt(playerid, listitem)));

			new oldDesc[256];
			db_get_field_assoc(db_result, "text", oldDesc, 256);

			db_result = db_query(db_handle, sprintf("UPDATE * FROM `mru_opisy` SET `last_used`=%d WHERE `uid`=%d", gettime(), DynamicGui_GetDataInt(playerid, listitem)));

			strcopy(PlayerInfo[playerid][pDesc], oldDesc);
			
			Attach3DTextLabelToPlayer(PlayerInfo[playerid][pDescLabel], playerid, 0.0, 0.0, -0.7);


			Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, BreakLines(oldDesc, "\n", 32));
			
			sendTipMessage(playerid, "Ustawi³eœ nowy opis");
		}
	}
	if(dialogid==4193)
	{
		if( response == 0 ) return RunCommand(playerid, "/opis",  "");

		if(strlen(inputtext) > 110) return sendTipMessage(playerid, "Zbyt d³uga wiadomoœæ");

		new inputOpis[256];
		strcopy(inputOpis, inputtext, 256);

		mysql_real_escape_string(inputOpis, inputOpis);
		
		new DBResult:db_result;
		db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`='%d' AND `text`='%s'", PlayerInfo[playerid][pUID], inputOpis));

		new rows = db_num_rows(db_result);

		new dLen = strlen(inputOpis);
		
		new initPoint, endPoint, tempCounts;

		for(endPoint = 0; endPoint < dLen; endPoint++) {

		    if(inputOpis[endPoint] == '{') {

		        initPoint = endPoint;
		        endPoint += 7;
		        if(endPoint < dLen) {

		            if(inputOpis[endPoint] == '}') {

		                for(tempCounts = 1; tempCounts < 7; tempCounts++) {

		                    if(!(tolower(inputOpis[initPoint+tempCounts]) >= 97
		                    && tolower(inputOpis[initPoint+tempCounts]) <= 102)
		                    && !(inputOpis[initPoint+tempCounts] >= 48
		                    && inputOpis[initPoint+tempCounts] <= 57))
		                        break;
						}
						if(tempCounts != 7)
						    continue;

						strdel(inputOpis, initPoint, ++endPoint);
						dLen = strlen(inputOpis);
						endPoint -= 8;
					}
				}
			}
		}

		if( rows )
		{
			new descUid = db_get_field_assoc_int(db_result, "uid");

			db_result = db_query(db_handle, sprintf("UPDATE `mru_opisy` SET `last_used`=%d WHERE `uid`=%d", gettime(), descUid));
		}
		else
		{
			db_free_result(db_query(db_handle, sprintf("INSERT INTO `mru_opisy` (`uid`,`text`, `owner`, `last_used`) VALUES (null, '%s', '%d', '%d')", inputOpis, PlayerInfo[playerid][pUID], gettime())));
		}

		strcopy(PlayerInfo[playerid][pDesc], inputOpis);


		Attach3DTextLabelToPlayer(PlayerInfo[playerid][pDescLabel], playerid, 0.0, 0.0, -0.7);
		Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, BreakLines(inputOpis, "\n", 32));
		sendTipMessage(playerid, "Ustawi³eœ nowy opis");
	}
	return 0;
}

fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 1958)
	{
		if(!response) return 1;

		switch(listitem)
		{
			case 0: factionLeaderPanel(playerid, FPANEL_MANAGEP);
			case 1: factionLeaderPanel(playerid, FPANEL_MANAGEV);
			case 2: factionLeaderPanel(playerid, FPANEL_MANAGES);
			case 3: factionLeaderPanel(playerid, FPANEL_SEJF);
		}

		return 1;
	}
	if(dialogid == 1959)
	{
		if( !response ) return factionLeaderPanel(playerid);

		switch( DynamicGui_GetValue(playerid, listitem) )
		{
			case FPANEL_DG_NEXT: showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page")+1);
			case FPANEL_DG_PREV: showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page")-1);
			case FPANEL_DG_OSOBA: 
			{
				new pracownik_uid = DynamicGui_GetDataInt(playerid, listitem);

				showEmployeeInfo(playerid, pracownik_uid);
			}
		}
	}
	if(dialogid == 1960)
	{
		if ( !response ) {
			showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
			DeletePVar(playerid, "fpanel_uid");
			return 1;
		}

    	if(listitem == 3)
    	{
    		new pracownik_nick[26];
    		strmid(pracownik_nick, MruMySQL_GetNameFromUID(GetPVarInt(playerid, "fpanel_uid")), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			if(ReturnUser(pracownik_nick) != INVALID_PLAYER_ID) {
                sendTipMessage(playerid, "Gracz jest online, u¿yj /zwolnij");
                return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
            }
            if(MruMySQL_GetAccInt("Member", pracownik_nick) != PlayerInfo[playerid][pLider] ) return sendErrorMessage(playerid, "No ³adne hakowanie!");
            MruMySQL_SetAccInt("Rank", pracownik_nick, 99);
            MruMySQL_SetAccInt("Member", pracownik_nick, 99);
            MruMySQL_SetAccInt("PodszywanieSie", pracownik_nick, 0);
            MruMySQL_SetAccInt("Uniform", pracownik_nick, 0);
            MruMySQL_SetAccInt("Team", pracownik_nick, 3);
            new msg[75];
            format(msg, sizeof(msg), "Zwolni³eœ %s ze swojej frakcji", pracownik_nick, FractionNames[PlayerInfo[playerid][pLider]]);
            sendTipMessage(playerid, msg, COLOR_LIGHTBLUE);
            DeletePVar(playerid, "fpanel_uid");

            return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
    	} 
    	else if(listitem == 4)
    	{

    		new fracid = PlayerInfo[playerid][pLider];
    		new typ = 0;
    		new str[512];
		    for(new i=0;i<10;i++)
		    {
		        if(strlen((typ == 0) ? (FracRang[fracid][i]) : (FamRang[fracid][i])) < 2)
		            format(str, 512, "%s[%d] -\n", str, i);
		        else
		            format(str, 512, "%s[%d] %s\n", str, i, (typ == 0) ? (FracRang[fracid][i]) : (FamRang[fracid][i]));
		    }

		    return ShowPlayerDialogEx(playerid, 1966, DIALOG_STYLE_LIST, "Wybierz rangê, któr¹ chcesz nadaæ graczowi", str, "Nadaj", "Anuluj");
    	}
    	else
    	{
    		new uid = GetPVarInt(playerid, "fpanel_uid");
			DeletePVar(playerid, "fpanel_uid");    		
    		return showEmployeeInfo(playerid, uid);
    	}
	}
	if(dialogid == 1966)
	{
		if( !response )
		{
			showEmployeeInfo(playerid, GetPVarInt(playerid, "fpanel_uid"));
			DeletePVar(playerid, "fpanel_uid");
			return 1;
		}
		if(strlen(FracRang[GetPlayerFraction(playerid)][listitem]) < 1) return sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Ta ranga nie jest stworzona!");

		new pracownik_nick[26];
    	strmid(pracownik_nick, MruMySQL_GetNameFromUID(GetPVarInt(playerid, "fpanel_uid")), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
		if(ReturnUser(pracownik_nick) != INVALID_PLAYER_ID) {
            sendTipMessage(playerid, "Gracz jest online, u¿yj /dajrange");
            return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
        }
        if(MruMySQL_GetAccInt("Member", pracownik_nick) != PlayerInfo[playerid][pLider] ) return sendErrorMessage(playerid, "No ³adne hakowanie!");

		new upordown[58];
		upordown = (MruMySQL_GetAccInt("Rank", pracownik_nick) <= listitem) ? "Awansowa³eœ" : "Zdegradowa³eœ";
		MruMySQL_SetAccInt("Rank", pracownik_nick, listitem);

		new msg[144];

		format(msg, sizeof(msg), "%s %s na rangê %s", upordown, pracownik_nick, FracRang[PlayerInfo[playerid][pLider]][listitem]);
        sendTipMessage(playerid, msg, COLOR_LIGHTBLUE);

        new uid = GetPVarInt(playerid, "fpanel_uid");
		DeletePVar(playerid, "fpanel_uid");    		
    	return showEmployeeInfo(playerid, uid);
	}
	return 0;
}

hq_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 1595)
	{
		if(!response) return 1;
		if(listitem == 0)
			ShowHeadquarters(playerid, HQ_WL);
		if(listitem == 1)
			ShowHeadquarters(playerid, HQ_ZGL);
	}
	if(dialogid == 1596)
	{
		if(!response) return ShowHeadquarters(playerid);
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
			new string[2500];
			if(!response) return ShowHeadquarters(playerid);

			//new szczegol;
			new dg_value = DynamicGui_GetValue(playerid, listitem), dg_data = DynamicGui_GetDataInt(playerid, listitem);

			if(response && dg_value != DG_SELECT_ZGL) return 1;

	        format(string, sizeof(string), ""#HQ_COLOR_TEKST2"Informacja o zg³oszeniu");
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_PLACEHOLDER"====================================================", string);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Treœæ: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_tresc]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Godzina: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_kiedy]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Zg³osi³: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_nadal]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Obszar: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_lokacja]);
	        new statusTxt[30];
	        switch(Zgloszenie[dg_data][zgloszenie_status]) {
	            case 0: statusTxt = "Nie podjêto jeszcze decyzji";
	            case 1: statusTxt = "Akceptowane";
	            case 2: statusTxt = "Odrzucone";
	            case 3: statusTxt = "Fa³szywe";
	            case 4: statusTxt = "Wykonane";
	            case 5: statusTxt = "Anulowane";
	        }
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Status: "#HQ_COLOR_TEKST2"%s", string, statusTxt);
	        format(string, sizeof(string), "%s\n ", string);
	        if(Zgloszenie[dg_data][zgloszenie_status] == 1) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Przyj¹³: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
	            if(!strcmp(Zgloszenie[dg_data][zgloszenie_przyjal], GetNick(playerid))) {
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"Oznacz jako: WYKONANE", string);
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"Oznacz jako: FA£SZYWE", string);    
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ANULOWANE"Oznacz jako: ANULOWANE", string);
	            }
	        } else if(Zgloszenie[dg_data][zgloszenie_status] == 0) {
	            format(string, sizeof(string), "%s\n ", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"Akceptuj zg³oszenie", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"Odrzuæ zg³oszenie", string);    
	        } else if(Zgloszenie[dg_data][zgloszenie_status] == 2) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Odrzuci³: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
	        } else {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Wyda³ decyzjê: "#HQ_COLOR_TEKST2"%s", string, Zgloszenie[dg_data][zgloszenie_przyjal]);
			}

			SetPVarInt(playerid, "zarzadzajZgl", dg_data);

			ShowPlayerDialogEx(playerid, 1597, DIALOG_STYLE_LIST, "Szczegó³y Zgloszenia", string, "Wybierz", "Wróæ");
		}
		if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
		{
			new string[2500];
			if(!response) return ShowHeadquarters(playerid);

			//new szczegol;
			new dg_value = DynamicGui_GetValue(playerid, listitem), dg_data = DynamicGui_GetDataInt(playerid, listitem);

			if(response && dg_value != DG_SELECT_ZGL) return 1;

	        format(string, sizeof(string), ""#HQ_COLOR_TEKST2"Informacja o zg³oszeniu");
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_PLACEHOLDER"====================================================", string);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Treœæ: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_tresc]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Godzina: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_kiedy]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Zg³osi³: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_nadal]);
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Obszar: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_lokacja]);
	        new statusTxt[30];
	        switch(ZgloszenieSasp[dg_data][zgloszenie_status]) {
	            case 0: statusTxt = "Nie podjêto jeszcze decyzji";
	            case 1: statusTxt = "Akceptowane";
	            case 2: statusTxt = "Odrzucone";
	            case 3: statusTxt = "Fa³szywe";
	            case 4: statusTxt = "Wykonane";
	            case 5: statusTxt = "Anulowane";
	        }
	        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Status: "#HQ_COLOR_TEKST2"%s", string, statusTxt);
	        format(string, sizeof(string), "%s\n ", string);
	        if(ZgloszenieSasp[dg_data][zgloszenie_status] == 1) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Przyj¹³: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
	            if(!strcmp(ZgloszenieSasp[dg_data][zgloszenie_przyjal], GetNick(playerid))) {
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"Oznacz jako: WYKONANE", string);
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"Oznacz jako: FA£SZYWE", string);    
	                format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ANULOWANE"Oznacz jako: ANULOWANE", string);
	            }
	        } else if(ZgloszenieSasp[dg_data][zgloszenie_status] == 0) {
	            format(string, sizeof(string), "%s\n ", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"Akceptuj zg³oszenie", string);
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"Odrzuæ zg³oszenie", string);    
	        } else if(ZgloszenieSasp[dg_data][zgloszenie_status] == 2) {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Odrzuci³: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
	        } else {
	            format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Wyda³ decyzjê: "#HQ_COLOR_TEKST2"%s", string, ZgloszenieSasp[dg_data][zgloszenie_przyjal]);
			}

			SetPVarInt(playerid, "zarzadzajZgl", dg_data);

			ShowPlayerDialogEx(playerid, 1597, DIALOG_STYLE_LIST, "Szczegó³y Zgloszenia", string, "Wybierz", "Wróæ");
		}
	}
	if(dialogid == 1597)
	{
		if(!response) return ShowHeadquarters(playerid);
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
			new szczegol = GetPVarInt(playerid, "zarzadzajZgl");
	        if(listitem == 9)
	        {
	            new zglstatus = Zgloszenie[szczegol][zgloszenie_status];
	            if(zglstatus == 0)
	            {
	                if(!strcmp(Zgloszenie[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg³oszeñ nie mo¿na akceptowaæ!");
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                Zgloszenie[szczegol][zgloszenie_status] = 1;
	            }
	            else
	            { 
	                Zgloszenie[szczegol][zgloszenie_status] = 4;
	            }
	        } else if (listitem == 10) {
	            new zglstatus = Zgloszenie[szczegol][zgloszenie_status];
	            if(zglstatus == 0) {
	                if(!strcmp(Zgloszenie[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg³oszeñ nie mo¿na odrzucaæ!");
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                Zgloszenie[szczegol][zgloszenie_status] = 2;
	            } else {
	                Zgloszenie[szczegol][zgloszenie_status] = 3;
	            }
	        } else if(listitem == 11) {
	            Zgloszenie[szczegol][zgloszenie_status] = 5;
	        }
	        ShowHeadquarters(playerid, HQ_ZGL);
    	}
    	if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
		{
			new szczegol = GetPVarInt(playerid, "zarzadzajZgl");
	        if(listitem == 9)
	        {
	            new zglstatus = ZgloszenieSasp[szczegol][zgloszenie_status];
	            if(zglstatus == 0)
	            {
	                if(!strcmp(ZgloszenieSasp[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg³oszeñ nie mo¿na akceptowaæ!");
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 1;
	            }
	            else
	            { 
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 4;
	            }
	        } else if (listitem == 10) {
	            new zglstatus = ZgloszenieSasp[szczegol][zgloszenie_status];
	            if(zglstatus == 0) {
	                if(!strcmp(ZgloszenieSasp[szczegol][zgloszenie_nadal], "Brak")) return sendErrorMessage(playerid, "Pustych zg³oszeñ nie mo¿na odrzucaæ!");
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 2;
	            } else {
	                ZgloszenieSasp[szczegol][zgloszenie_status] = 3;
	            }
	        } else if(listitem == 11) {
	            ZgloszenieSasp[szczegol][zgloszenie_status] = 5;
	        }
	        ShowHeadquarters(playerid, HQ_ZGL);
    	}
	}
	return 0;
}

noYsi_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 1590)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 1: ShowPodrecznik(playerid, HELP_TYPY_KAR);
			case 2: ShowPodrecznik(playerid, HELP_PRZEWINIENIA);
			case 3: ShowPodrecznik(playerid, HELP_ZASADYKAR);
			case 5: ShowPodrecznik(playerid, HELP_WHATISRP);
			case 6: ShowPodrecznik(playerid, HELP_PROFITYFORO);
			case 7: ShowPodrecznik(playerid, HELP_MOREHELP);
			case 9: RunCommand(playerid, "/pomoc2", "");
			default: ShowPodrecznik(playerid);
		}
	}
	else if(dialogid == 1591)
	{
		if(!response) return ShowPodrecznik(playerid);
		ShowPodrecznik(playerid, HELP_TYPY_KAR);
	}
	else if(dialogid == 1592)
	{
		if(!response) return ShowPodrecznik(playerid);
		ShowPlayerDialogEx(playerid, 1593, DIALOG_STYLE_MSGBOX, "Opis Przewinienia", opis_przewinienia[listitem], "Ok", "");
	}
	else if(dialogid == 1593)
	{
		if(response) return ShowPodrecznik(playerid);
		else return 1;
	}
	else if(dialogid == 1594)
	{
		if(response) return ShowPodrecznik(playerid);
	}
	return 0;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end