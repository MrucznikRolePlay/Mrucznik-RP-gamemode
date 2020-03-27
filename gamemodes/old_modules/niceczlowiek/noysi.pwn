BreakLines(string[], delimiter[], limit)
{
	new inserts, tempLimit = limit, pos[50], string2[150], lastEmptyPos;
	format(string2, 150, string);
	
	for(new i; i < strlen(string); i++)
	{
		if( string[i] == ' ' ) lastEmptyPos = i;
		if( string[i] == '~' && string[i+1] == 'n' && string[i+2] == '~' ) tempLimit = i + limit;
		if( i >= tempLimit )
		{
			inserts += 1;
			tempLimit = i + limit;
			
			pos[inserts-1] = lastEmptyPos + ((inserts-1) * strlen(delimiter));
			if( inserts > 1 ) pos[inserts-1] -= (inserts-1);
		}
	}
	
	for(new d; d < 50; d++)
	{
		if( pos[d] == 0 ) break;
		strdel(string2, pos[d], pos[d]+1);
		strins(string2, delimiter, pos[d]);
	}
	
	return _:string2;
}

#define DLG_NO_ACTION		1
#define DG_DESC_DELETE 		2
#define DG_DESC_ADD 		3
#define DG_DESC_USEOLD		4

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
		db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`='%d' AND `text`='%s'", PlayerInfo[playerid][UID], inputOpis));

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
			db_free_result(db_query(db_handle, sprintf("INSERT INTO `mru_opisy` (`uid`,`text`, `owner`, `last_used`) VALUES (null, '%s', '%d', '%d')", inputOpis, PlayerInfo[playerid][UID], gettime())));
		}

		strcopy(PlayerInfo[playerid][pDesc], inputOpis);


		Attach3DTextLabelToPlayer(PlayerInfo[playerid][pDescLabel], playerid, 0.0, 0.0, -0.7);
		Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, BreakLines(inputOpis, "\n", 32));
		sendTipMessage(playerid, "Ustawi³eœ nowy opis");
	}
	return 0;
}

#define FPANEL_MAIN			1
#define FPANEL_MANAGEP		2
#define FPANEL_MANAGEV		3
#define FPANEL_MANAGES		4
#define FPANEL_SEJF			5

#define FPANEL_PER_PAGE 	20 // iloœæ osó na stronê

#define FPANEL_DG_OSOBA		1
#define FPANEL_DG_PREV		2
#define FPANEL_DG_NEXT		3

fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
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

showEmployeeInfo(playerid, employeeUid)
{
	new pracownik_nick[26], rankname[26], ranga, employeestring[1100];
    new isLider;
               
    strmid(pracownik_nick, MruMySQL_GetNameFromUID(employeeUid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
    ranga = MruMySQL_GetAccInt("Rank", pracownik_nick);
    isLider = MruMySQL_GetAccInt("Lider", pracownik_nick);
    new dorangi = MruMySQL_GetAccInt("Member", pracownik_nick);

    if(isLider > 0) {
        sendTipMessage(playerid, "Dostêp do danych na temat osób z panelem zabroniony", COLOR_LIGHTBLUE);
        return showFactionWorkers(playerid, GetPVarInt(playerid, "fpanel_Page"));
    }
    strmid(rankname, FracRang[dorangi][ranga], 0, 25, 26);
    format(employeestring, sizeof(employeestring), ""#KARA_STRZALKA"    »» "#KARA_TEKST"Nick: "#KARA_TEKST"%s", pracownik_nick);
    format(employeestring, sizeof(employeestring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST"Ranga: "#KARA_TEKST"%s", employeestring, rankname);
    format(employeestring, sizeof(employeestring), "%s\n ", employeestring);
    format(employeestring, sizeof(employeestring), "%s\n"#HQ_COLOR_STRZALKA"    »» {dafc10}Wyrzuæ Pracownika", employeestring);  
    format(employeestring, sizeof(employeestring), "%s\n"#HQ_COLOR_STRZALKA"    »» {dafc10}Zmieñ rangê", employeestring);  
    SetPVarInt(playerid, "fpanel_uid", employeeUid);
    ShowPlayerDialogEx(playerid, 1960, DIALOG_STYLE_LIST, "Panel Lidera » Zarz¹dzanie Pracownikiem", employeestring, "Ok", "Wstecz");
    return 1;
}

factionLeaderPanel(playerid, page = FPANEL_MAIN)
{
	if(page == FPANEL_MAIN)
	{
		new mainstring[350];
		new ftitle[130];
		new id = PlayerInfo[playerid][pLider];
    	format(mainstring, sizeof(mainstring), ""#KARA_TEKST"»» Zarz¹dzanie pracownikami");
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"»» Zarz¹dzanie pojazdami", mainstring);
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"»» Zarz¹dzanie skinami", mainstring);
    	format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"»» Zarz¹dzanie sejfem", mainstring);
    	format(ftitle, sizeof(ftitle), "%s", FractionNames[id]);
    	ShowPlayerDialogEx(playerid, 1958, DIALOG_STYLE_LIST, ftitle, mainstring, "Ok", "WyjdŸ");
	}
	if(page == FPANEL_MANAGEP)
	{
		return showFactionWorkers(playerid, 1);
	}
	if(page == FPANEL_MANAGES)
	{
		sendTipMessage(playerid, "Ta opcja bêdzie dostêpna wkrótce");
		return factionLeaderPanel(playerid);
	}
	if(page == FPANEL_MANAGEV)
	{
		sendTipMessage(playerid, "Ta opcja bêdzie dostêpna wkrótce");
		return factionLeaderPanel(playerid);
	}
	return 1;
}


#define HELP_MAIN			0
#define HELP_TYPY_KAR 		1
#define HELP_PRZEWINIENIA	2
#define HELP_ZASADYKAR 		3
#define HELP_WHATISRP 		4
#define HELP_PROFITYFORO 	5
#define HELP_MOREHELP 		6
#define HELP_CMD			7

new opis_przewinienia[50][600];
new przewinienia[3000];

LoadPrzewinienia()
{
	new File:file = fopen("kary.mrp", io_read), line[700];
    format(przewinienia, sizeof(przewinienia), "Przewinienie\t\t\tTyp kary");
    new counter = 0;
    while(fread(file, line))
    {
        new typKary;
        new przewinienie[70];
        new typKaryStr[45];
        new opisp[600];
        sscanf(line, "p<|>s[70]ds[600]", przewinienie, typKary, opisp);
        switch(typKary) {
            case 0: typKaryStr = ""#KARA_NIEZNACZNA"Kara nieznaczna";
            case 1: typKaryStr = ""#KARA_LEKKA"Kara lekka";
            case 2: typKaryStr = ""#KARA_SREDNIA"Kara œrednia";
            case 3: typKaryStr = ""#KARA_CIEZKA"Kara ciê¿ka";
            case 4: typKaryStr = ""#KARA_BARDZOCIEZKA"Kara bardzo ciê¿ka";
            case 5: typKaryStr = ""#KARA_BANICJI"Kara banicji";
            case 6: typKaryStr = ""#KARA_SPECJALNA"Kara specjalna";
        }
        format(przewinienia, sizeof(przewinienia), "%s\n"#KARA_TEKST2"%s\t\t\t%s", przewinienia, przewinienie, typKaryStr);
        for(new i = strlen(opisp) - 1; i > -1; i--) {
            if(opisp[i] == '*') {
                opisp[i] = '\n';
            }
        }
        format(opis_przewinienia[counter], sizeof(opisp), "%s", opisp);
        counter++;
	}
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

ShowPodrecznik(playerid, page=HELP_MAIN)
{
	new mainstring[2000];
	if( page == HELP_MAIN )
	{
		format(mainstring, sizeof(mainstring), ""#KARA_TEKST"Zasady panuj¹ce na serwerze");
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Typy Kar", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Przewinienia", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Zasady Nadawania Kar", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"Dla nowicjuszy", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Czym jest Role Play", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Profity posiadania konta na forum", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Jak uzyskaæ dodatkow¹ pomoc", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_TEKST"Inne", mainstring);
	    format(mainstring, sizeof(mainstring), "%s\n"#KARA_STRZALKA"    »» "#KARA_TEKST2"Komendy dostêpne na serwerze", mainstring);

	    ShowPlayerDialogEx(playerid, 1590, DIALOG_STYLE_LIST, "Podrêcznik", mainstring, "Dalej", "WyjdŸ");
	}	
	if( page == HELP_TYPY_KAR )
	{
		new typy_kar[500];
        format(typy_kar, sizeof(typy_kar), "Stopieñ\t\t\tKara");
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_NIEZNACZNA"Kara Nieznaczna (I stopieñ)\t\t\t"#KARA_TEKST2"Do 5 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_LEKKA"Kara Lekka (II stopieñ)\t\t\t"#KARA_TEKST2"Do 10 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_SREDNIA"Kara Œrednia (III stopieñ)\t\t\t"#KARA_TEKST2"Do 20 minut AJ", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_CIEZKA"Kara Ciê¿ka (IV stopieñ)\t\t\t"#KARA_TEKST2"Do 30 minut AJ, Warn", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_BARDZOCIEZKA"Kara Bardzo Ciê¿ka (V stopieñ)\t\t\t"#KARA_TEKST2"Warn, Ban", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_SPECJALNA"Kara Specjalna\t\t\t"#KARA_TEKST2"Opisana przy przypadku", typy_kar);
        format(typy_kar, sizeof(typy_kar), "%s\n"#KARA_BANICJI"Kara Banicji\t\t\t"#KARA_TEKST2"Ban", typy_kar);
        ShowPlayerDialogEx(playerid, 1591, DIALOG_STYLE_TABLIST_HEADERS, "Typy Kar", typy_kar, "Ok", "Wróæ");
	}

	if( page == HELP_PRZEWINIENIA ) 
	{
		ShowPlayerDialogEx(playerid, 1592, DIALOG_STYLE_TABLIST_HEADERS, "Przewinienia", przewinienia, "Ok", "Wróæ");
	}

	if( page == HELP_ZASADYKAR )
	{
		new zasady[2000];
		format(zasady, sizeof(zasady), "1. Admin ma prawo nadaæ karê tylko i wy³¹cznie za czynnoœci przewidziane w LKiZ oraz o wysokoœci przewidzianej w LKiZ. \n\tZa jedn¹ czynnoœæ niezgodn¹ z LKiZ gracz mo¿e otrzymaæ tylko 1 karê.");
        format(zasady, sizeof(zasady), "%s\n \n2. Je¿eli czynnoœæ jest zabroniona w LKiZ, ale wykonywanie tej czynnoœci przez gracza nikomu nie przeszkadza oraz jest \n\takceptowana przez wszystkich obecnych graczy, admin mo¿e siê powstrzymaæ od ukarania (tylko gdy jest pewien, ¿e akcja nie przeszkadza ¿adnemu graczowi który j¹ widzi/s³yszy).", zasady);
        format(zasady, sizeof(zasady), "%s\n \n3. Staramy siê nadawaæ karê adekwatnie do sytuacji oraz postawy gracza", zasady);
        format(zasady, sizeof(zasady), "%s\n \n4. Obowi¹zuje zakaz ³¹czenia wartoœci kar. Je¿eli gracz pope³ni³ 2 czyny do 15minut AJ oraz 1 do 30minut AJ to dajemy mu karê maksymalnie 30 minut AJ \n\ti resztê jego przewinieñ mo¿emy umieœciæ w nawiasie.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n5. Podawany powód musi byæ czytelny i jednoznaczny, powinien wyraŸnie informowaæ co gracz zrobi³ Ÿle.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n6. Je¿eli gracz z³o¿y³ skargê na forum, stopieñ kary mo¿e zostaæ podniesiony o 1 poziom (lub wartoœæ mo¿e byæ zwiêkszona x2 w przypadku kar specjalnych)", zasady);
        format(zasady, sizeof(zasady), "%s\n \n7. Je¿eli jakaœ czynnoœæ jest wykonywana nagminnie, pomimo upomnieñ i kar, mo¿na nadaæ warna \n\t(nawet je¿eli stopieñ przewinienia tego nie przewiduje) lub zwiêkszyæ wartoœæ kary x2 lub stopieñ kary o 1.", zasady);
        format(zasady, sizeof(zasady), "%s\n \n8. Je¿eli czynnoœæ dotyczy wielu graczy, jest wykonywana na wiêcej ni¿ 3 osobach, mamy prawo podnieœæ stopieñ kary o 1. \n\t(np. HK dla 10 = Masowe HK i kara stopnia 5)\n\tUwaga! Przy nadawaniu takiej kary administrator musi wpisaæ w powodzie s³owo \"Masowe\".\n\tUwaga! Zasada dzia³a jedynie dla nastêpuj¹cych przewinieñ: DM(i jego odmiany), DB, HK, CK, DD/CZ", zasady);
        ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Zasady", zasady, "Ok", "");
	}

	if( page == HELP_WHATISRP )
	{
		new zasady[2350];
		format(zasady, sizeof(zasady), "To odgrywanie prawdziwego ¿ycia w œwiecie wirtualnym. Role Play na naszym serwerze polega na kreowaniu swojej postaci i odgrywaniu prawdziwego ¿ycia w grze. \nOznacza to ¿e mo¿emy pracowaæ (jako policjant, mechanik czy te¿ p³atny morderca), kupowaæ domy, samochody oraz wiele innych rzeczy.");
        format(zasady, sizeof(zasady), "%s\nOdgrywamy tak¿e ró¿ne sytuacje, np. napady na bank, wyœcigi uliczne, sprzeda¿ narkotyków. Nasze postacie zarabiaj¹ pieni¹dze oraz zdobywaj¹ umiejêtnoœci i znajomoœci.\n\tAby graæ zgodnie z zasadami RP - po prostu wczuj siê w postaæ tak, jakbyœ to ty ni¹ by³.", zasady);
        format(zasady, sizeof(zasady), "%s\nJednak na naszym podejœciu panuje tak¿e tak zwane \"LuŸne RP\". Oznacza to, ¿e na naszym serwerze odgrywanie prawdziwego ¿ycia\n\tprzystosowuje siê do warunków jakie daje GTA SA i to, ¿e nie musimy szanowaæ ¿ycia swojej postaci jak w³asnego.", zasady);
        format(zasady, sizeof(zasady), "%s\nW ten sposób aby odegrywaæ prawid³owo nie pytamy siê siebie w myœli - \"co bym zrobi³ gdybym by³ \n\tw prawdziwym ¿yciu\" - tylko - \"co bym zrobi³ w prawdziwym ¿yciu gdyby prawdziwe ¿ycie wygl¹da³o tak jak sytuacja ogólna w grze\".", zasady);
        format(zasady, sizeof(zasady), "%s\n \nAby wczuæ siê w Role Play panuj¹cy na Mruczniku, prezentujemy krótki rys fabularny serwera: \n ", zasady);           
        format(zasady, sizeof(zasady), "%s\nLos Santos jest miastem opanowanym przez przestêpców, nawet cywile chodz¹ po mieœcie uzbrojeni. Ka¿dy walczy o swoje miejsce si³¹ a tych,\n\t\tktórzy stoj¹ na drodze do ich celu traktuj¹ seri¹ z ka³acha.", zasady);
        format(zasady, sizeof(zasady), "%s\nSantos to nie el dorado pokoju gdzie ludzie ¿yj¹ w zgodzie z Policj¹ i wszyscy poœwiêcaj¹ siê radosnej i owocnej wspó³pracy.\n\tTo miasto, w którym co drugi obywatel jest kryminalist¹ a na ka¿dym zakrêcie mo¿e czekaæ ciê œmieræ.", zasady);
        format(zasady, sizeof(zasady), "%s\nWiêc nie czekaj, weŸ sprawy w swoje rêcê i do³¹cz do ludzi siej¹cych zamêt w Los Santos lub grup, które maj¹ na celu uspokojenie mot³ochu i sprawienie by sprawiedliwoœæ zatriumfowa³a.\n\tB¹dŸ zostañ (nie)uczciwym pracownikiem i stañ siê najbogatszym cz³owiekiem w LS.", zasady);
        format(zasady, sizeof(zasady), "%s\n \nJak ¿ycie twojej postaci potoczy siê dalej, zale¿y tylko i wy³¹cznie od ciebie! Powodzenia!", zasady);
		ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Czym jest Role Play", zasady, "Ok", ""); 
	}

	if( page == HELP_PROFITYFORO )
	{
		new zasady[900];
		format(zasady, sizeof(zasady), ""#KARA_TEKST2"Opcja\t"#KARA_BANICJI"Bez forum\t"#KARA_NIEZNACZNA"Z forum");
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Swobodna gra na serwerze\t"#KARA_NIEZNACZNA"Tak\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Branie udzia³u w ¿yciu spo³ecznoœci\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Do³¹czanie do frakcji\t"#KARA_SREDNIA"Zazwyczaj nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Dostêp do poradników\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n"#KARA_TEKST2"Dostêp do informacji o aktualizacjach\t"#KARA_BANICJI"Nie\t"#KARA_NIEZNACZNA"Tak", zasady);
        format(zasady, sizeof(zasady), "%s\n \n \n"#KARA_TEKST2"Nie czekaj! Zarejestruj siê na {FFFFFF}Mrucznik-RP.pl", zasady);

        ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_TABLIST_HEADERS, "Profity posiadania konta na Forum", zasady, "Ok", ""); 
	}

	if ( page == HELP_MOREHELP )
	{
		ShowPlayerDialogEx(playerid, 1594, DIALOG_STYLE_MSGBOX, "Profity posiadania konta na Forum", "W celu uzyskania dodatkowej pomocy, skorzystaj z komendy /zapytaj.\n \nWpisz /zapytaj [NAG£ÓWEK- na przyk³ad SALON AUT] Treœæ- na przyk³ad: gdzie znajduje siê salon aut\n \n", "Ok", ""); 	
	}

	return 1;
}




#define HQ_MAIN 	1
#define HQ_WL		2
#define HQ_ZGL		3

#define DG_SELECT_ZGL	1


hq_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	noYsi_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
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


ShowHeadquarters(playerid, page=HQ_MAIN)
{
	if(page == HQ_MAIN)
	{
		new string[256];
		format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Lista poszukiwanych", string);
        format(string, sizeof(string), "%s\n"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"Ostatnie zg³oszenia", string);

  		ShowPlayerDialogEx(playerid, 1595, DIALOG_STYLE_LIST, "HeadQuarters/MDC", string, "Ok", "WyjdŸ");
	}
	if(page == HQ_WL)
	{
		RunCommand(playerid, "/wanted", "");
		return ShowHeadquarters(playerid);
	}
	if(page == HQ_ZGL)
	{
		DynamicGui_Init(playerid);
		new string[1200] = "";
		format(string, sizeof(string), "");
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
			for(new i = 0, j=OSTATNIE_ZGLOSZENIA; i<j; i++) {
		        if(Zgloszenie[i][zgloszenie_status] == 0) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"%s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 1) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"%s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 2) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"[Odrzucone] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 3) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_FALSZYWE"[Fa³szywe] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 4) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_WYKONANE"[Wykonane] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
			    } else if(Zgloszenie[i][zgloszenie_status] == 5) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ANULOWANE"[Anulowane] %s\n", string, Zgloszenie[i][zgloszenie_tresc]);
		        }
	        	DynamicGui_AddRow(playerid, DG_SELECT_ZGL, i);
        	}
        	ShowPlayerDialogEx(playerid, 1596, DIALOG_STYLE_LIST, ("Ostatnie zg³oszenia"), string, "Ok", "Wstecz");
		}
		if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
		{
	        for(new i = 0, j=OSTATNIE_ZGLOSZENIASASP; i<j; i++) {
		        if(ZgloszenieSasp[i][zgloszenie_status] == 0) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_TEKST"%s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 1) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_AKCEPTOWANE"%s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 2) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ODRZUCONE"[Odrzucone] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 3) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_FALSZYWE"[Fa³szywe] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 4) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_WYKONANE"[Wykonane] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
			    } else if(ZgloszenieSasp[i][zgloszenie_status] == 5) {
			        format(string, sizeof(string), "%s"#HQ_COLOR_STRZALKA"    »» "#HQ_COLOR_ANULOWANE"[Anulowane] %s\n", string, ZgloszenieSasp[i][zgloszenie_tresc]);
		        }
		        DynamicGui_AddRow(playerid, DG_SELECT_ZGL, i);
	        }
	        ShowPlayerDialogEx(playerid, 1596, DIALOG_STYLE_LIST, ("Ostatnie zg³oszenia"), string, "Ok", "Wstecz");
    	}
	}
	return 1;
}
