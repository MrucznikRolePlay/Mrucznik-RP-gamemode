stock BreakLines(string[], delimiter[], limit)
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

stock opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
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

COMMAND:opis(playerid, params[])
{
	if(PlayerInfo[playerid][pBP] != 0)
	{
		return SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokadê pisania na czatach globalnych, nie mo¿esz utworzyæ opisu.");
	}
	DynamicGui_Init(playerid);
	new string[1400];
		
	if(!isnull(PlayerInfo[playerid][pDesc]))
	{
		new str[256];
		strcopy(str, PlayerInfo[playerid][pDesc], 256);
		strdel(str, 55, 256); // jednak pokazujemy ca³y opis :D
		format(string, sizeof(string), "%s{f4f5fa}%s...\n", string, str);
		DynamicGui_AddRow(playerid, DLG_NO_ACTION);
	
		format(string, sizeof(string), "%s{888888}##\t{ff0000}Usuñ opis\n", string);
		DynamicGui_AddRow(playerid, DG_DESC_DELETE);
	}
	else
	{
		format(string, sizeof(string), "%s{888888}##\t{00B33C}Ustaw opis\n", string);
		DynamicGui_AddRow(playerid, DG_DESC_ADD);
	}

	format(string, sizeof(string), "%s\t\t\n", string);
	DynamicGui_AddBlankRow(playerid);
	format(string, sizeof(string), "%s{00B33C}Ostatnie opisy\n", string);
	DynamicGui_AddBlankRow(playerid);

	new DBResult:db_result;
	db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`=%d ORDER BY `last_used` DESC LIMIT 5", PlayerInfo[playerid][pUID]));

	new rows = db_num_rows(db_result);
		
	if( rows )
	{
			//for(new row = 0; row < rows; row++)
		for(new row; row < rows; row++,db_next_row(db_result))   
		{
			new tmpText[256];
			db_get_field(db_result, 1, tmpText, sizeof(tmpText));
			strdel(tmpText, 55, 256);
			format(string, sizeof(string), "%s(%d)\t%s...\n", string, row+1, tmpText);
			DynamicGui_AddRow(playerid, DG_DESC_USEOLD, db_get_field_assoc_int(db_result, "uid"));
		}
	}
	else 
	{
		format(string, sizeof(string), "%sBrak\n", string);
		DynamicGui_AddBlankRow(playerid);
	}

	ShowPlayerDialogEx(playerid, 4192, DIALOG_STYLE_LIST, "Opis", string, "Ok", "X");
	return 1;
}

COMMAND:usunopis(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return 1;
	new id;
    if(sscanf(params, "k<fix>", id)) return SendClientMessage(playerid, -1, "(USUÑ OPIS) - Podaj Nick lub ID gracza.");
    if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza");

    if(isnull(PlayerInfo[id][pDesc]))
	{
		return sendErrorMessage(playerid, "Ten gracz nie ma ustawionego opisu");
	}
	else
	{
		Update3DTextLabelText(PlayerInfo[id][pDescLabel], 0xBBACCFFF, "");
		PlayerInfo[id][pDesc][0] = EOS;
		new msg[128];
		format(msg, 128, "Administrator %s usun¹³ twój opis", GetNick(playerid, true));
		sendErrorMessage(id, msg);
		format(msg, 128, "Usun¹³eœ opis %s", GetNick(id, true));
		sendErrorMessage(playerid, msg);
	}
	return 1;
}


#define CHANGELOG_MAIN		1

COMMAND:zmiany(playerid, params[]) return RunCommand(playerid, "/changelog",  params);
COMMAND:changelog(playerid, params[])
{
	showChangeLog(playerid);
	return 1;
}

stock changeLog_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 1963)
	{
		return showChangeLog(playerid);
	}
	if(dialogid == 1962)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				new string[2200];
				format(string, 2200, "{FFFFFF}Lista zmian aktualizacji 2.5.84\n\n");
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}Przyczepialne obiekty kamizelki\t\n", string);
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}Anty-sprint po obezw³adnieniu\t\n", string);
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}Nowa wybiera³ka\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Inny sposób sprawdzania uprawnieñ pojazdów\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Zmiana spawnu NOA\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Brak kamizelki na spawnie dla s³u¿b porz¹dkowych\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}G³oœnik nie jest ju¿ wyjmowany z pojazdu SAN\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Zmiany w iloœci pieniêdzy przyznawanej za zabicie przestêpcy\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}80%% trafia do sejfu, 20%% do oficera\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}20 osób na stronê dla komendy /fpanel\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Zmiany w komendzie /napraw\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}Zwiêkszenie cen za tankowanie i naprawê\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}Bugfix GPS\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}Naprawiono bug z pust¹ list¹ /wanted u ³owców nagród\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}Ograniczono /wezportfel do 1 000 000$\t\n", string);

				ShowPlayerDialogEx(playerid, 1963, DIALOG_STYLE_MSGBOX, "{C0C0C0}Mrucznik-RP » Zmiany w wersji 2.5.84", string, "Ok", "");
			}
			case 1:
			{
				new string[2200];
				format(string, 2200, "{FFFFFF}Lista zmian aktualizacji 2.5.83\n\n");
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}wprowadzono opisy z mapy 3.0 ( /opis )\t\n", string);
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}przebieranie siê w skiny frakcyjne/cywilne dla frakcji bez /duty ( /skinf )\t\n", string);
				format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}mechanicy mog¹ sprawdziæ neony w aucie ( /sprawdzneon ) (koszt 10k)\t\n", string);
				format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}na koñcu komunikatu o AFK bêdzie pojawia³o siê ID gracza\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}naprawa b³êdu uniemo¿liwiaj¹cego YKZ u¿yæ /wepchnij\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}usuniêto mo¿liwoœæ u¿ywania /ub po /wb (do czasu respawnu)\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}poprawiono kilka pomniejszych b³êdów\t\n", string);
				format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}pozbyto siê bugów, przez które z³odzieje mogli korzystaæ z sejfów innych bez has³a\t\n", string);

				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] == 5)
				{
					format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}dodano /marcepan który przeprowadza symulacjê Marcepana\t\n", string);
					format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}gdy gracz wyjdzie i ma dostaæ Marcepana admini zobacz¹ log na czacie\t\n", string);
					format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}/opis usun [id] to teraz /usunopis [id]\t\n", string);
				}

				ShowPlayerDialogEx(playerid, 1963, DIALOG_STYLE_MSGBOX, "{C0C0C0}Mrucznik-RP » Zmiany w wersji 2.5.83", string, "Ok", "");
			}
			case 2:
			{
				new string[2200];
		        format(string, 2200, "{FFFFFF}Lista zmian aktualizacji 2.5.82\n\n");
		        format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}panel dla liderów frakcji ( /fpanel )\t\n", string);
		        format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}powrót komendy /pobij - brak aj za /q oraz 45s czekania po pobiciu\t\n", string);
		        format(string, 2200, "%s{C0C0C0}bugfix\t{FFFFFF}naprawiony bug z domkami\t\n", string);
		        format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}/hq dla sasd oraz sasd w /call 911\t\n", string);
		        format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}przejazd na granicach p³atny $1750 ( /przejazd )\t\n", string);
		        format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}ulepszenie matsiarz daje bonusowe materia³y przy dostarczeniu\t\n", string);
		        format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}dopasowanie kamizelki na skinie ( /dopasuj )\t\n", string);
		        format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}po pójœciu do paki przez cmd /paka /aresztuj poœcig siê deaktywuje\t\n", string);
		        format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}interior biura i magazyny dla /rodziny 23\t\n", string);
		        format(string, 2200, "%s{C0C0C0}zmiana\t{FFFFFF}niewielkie poprawki stabilnoœci\t\n", string);

		        if (PlayerInfo[playerid][pAdmin] >= 1000)
				{
					format(string, 2200, "%s{C0C0C0}nowoœæ\t{FFFFFF}dodano /fixallveh\t\n", string);
				}

		        ShowPlayerDialogEx(playerid, 1963, DIALOG_STYLE_MSGBOX, "{C0C0C0}Mrucznik-RP » Zmiany w wersji 2.5.82", string, "Ok", "");
			}
			case 3:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono bugi i b³êdy.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Central Bank Los Santos - exterior banku");
				SendClientMessage(playerid,COLOR_WHITE,"Centrum rozrywki Los Santos - interior");
				SendClientMessage(playerid,COLOR_WHITE,"Centrum rozrywki Los Santos - exterior");
				SendClientMessage(playerid,COLOR_WHITE,"OP dla góry Chiliad ");
				SendClientMessage(playerid,COLOR_WHITE,"Ciekawostki na mapie");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawienie b³êdów Rockstar");
				SendClientMessage(playerid,COLOR_WHITE,"Oznakowanie Los Santos");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêcie parkingu LSPD");
				SendClientMessage(playerid,COLOR_WHITE,"Nowy parking LSPD - ulepszany z ka¿dym kolejnym update");
				SendClientMessage(playerid,COLOR_WHITE,"Parking na zaholowane pojazdy dla LSPD");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono wypadaj¹ce samochody GSA");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono wypadaj¹ce samochody FBI");
				SendClientMessage(playerid,COLOR_WHITE,"Dodanie nowego miejsca dla biznesu - LSCDF");
				SendClientMessage(playerid,COLOR_WHITE,"Upiêkszenia Los Santos");
				SendClientMessage(playerid,COLOR_WHITE,"Parking przed LSMC");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty z propozycji");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty dla Money Makers");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty dla CassinoAutoService");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty dla low folow ");

				showChangeLog(playerid);
			}
			case 4:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   BY PECET   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"System Po¿arów v0.2");
				SendClientMessage(playerid,COLOR_WHITE,"Do sejfu LSFD trafia 20k od zgaszonego po¿aru");
				SendClientMessage(playerid,COLOR_WHITE,"Wyd³u¿ono czas gaszenia po¿arów");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano wiêcej scenariuszy po¿arów");
				SendClientMessage(playerid,COLOR_WHITE,"Usprawniono informowanie o po¿arach (dla Administracji)");
				SendClientMessage(playerid,COLOR_WHITE,"Do sejfu LSFD i do stra¿aka trafia po 2,5k za usuniêt¹ plamê oleju");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /windalock dla S¹du (w przysz³oœci planowane dodanie dla innych frakcji, które bêd¹ chcia³y komendê)");
				SendClientMessage(playerid,COLOR_WHITE,"Usprawniono interior S¹du (jest jaœniej i niezale¿nie od pogody na zewn¹trz - wewn¹trz nie pada)");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano /odznaka dla pracowników S¹du");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano /dutysbi dla SASP");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono komendê /tp (dla Administracji)");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano /togpodglad (dla Administracji)");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano /wejdz i /wyjdz na strzelnicê dla Gunshop LS");
				SendClientMessage(playerid,COLOR_WHITE,"Domenda /akceptuj naprawa tylko na wy³¹czonym silniku, trwa okreœlon¹ iloœæ czasu i wymaga mechanika w pobli¿u, który w momencie naprawiania musi staæ obok pojazdu");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /armia-wiadomosc dla U.S. Army");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /sprzedajrybe - OD TERAZ MO¯ESZ SPRZEDAÆ RYBY, KTÓRE Z£OWI£EŒ W 24/7! Cena za kilogram: 20$!");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /su, /ob, /barierka, brak otrzymywania WL za zabójstwo dla F.S. Army");
				SendClientMessage(playerid,COLOR_WHITE,"Mniejsze poprawki maj¹ce na celu optymalizacjê i usprawnienie skryptu.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Pos¹g Los Santos - KilsOn");
				SendClientMessage(playerid,COLOR_WHITE,"Przeniesiona centrala GSA - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty 'Ciekawostki' - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Czêsto skracane zakrêty - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Nowa baza San Andreas Army - soldiercolt");
				SendClientMessage(playerid,COLOR_WHITE,"OP dla Blueberry - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Interior rady miasta Blueberry - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Interior 'Komisja ds. Mechaników' - _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Op dla Dillimore - Niuniek");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawki Rockstar/obecnej mapy - KilsOn i _Szymon");
				SendClientMessage(playerid,COLOR_WHITE,"Obiekty przed DMV - KilsOn");
				SendClientMessage(playerid,COLOR_WHITE,"Parking podziemny dla FBI - _Szymon");

				showChangeLog(playerid);
			}
			case 5:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   BY niceCzlowiek   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Frakcje porz¹dkowe otrzymuj¹ teraz pieni¹dze do sejfu frakcyjnego za aresztowania, mandaty oraz kaucje.");
				SendClientMessage(playerid,COLOR_WHITE,"Pozwolenia prawnicze wydaje siê teraz za pomoc¹ /pozwolenie [id], druga osoba musi je akceptowaæ za pomoc¹ /app ");
				SendClientMessage(playerid,COLOR_WHITE,"Wprowadzono komendê /bwtime, która pozwala administracji ustaliæ czas BW,");
				SendClientMessage(playerid,COLOR_WHITE,"Wprowadzono komendê /kamizelka, która pozwala policjantom przywdziaæ kamizelkê (obiekt oraz 100% pancerza),");
				SendClientMessage(playerid,COLOR_WHITE,"Podniesiono skill SDPistol,");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono resetowanie patrolu, gdy jeden z patroluj¹cych wyjdzie z serwera,");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano zawijanie czatu do normalnego czatu, oraz komend: /w /s /k /me /do,");
				SendClientMessage(playerid,COLOR_WHITE,"Oddzielono anty-spam /report od reszty liczników anty-spamu,");
				SendClientMessage(playerid,COLOR_WHITE,"W³¹czono BW na ca³e San Andreas,");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano mo¿liwoœæ zmiany muzyki w klubie bonehead");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto bug z /tankuj");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano legalnoœæ broni Od teraz, ka¿da zakupiona broñ w gunstore bêdzie w /sb wyœwietla³a siê jako LEGALNA...");
				SendClientMessage(playerid,COLOR_WHITE,"... a ka¿da broñ zakupiona od mafii bêdzie okreœlona jako Z NIEZNANEGO RÓD£A");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono sloty rodzin oraz odbudowano sejfy frakcyjne");
				SendClientMessage(playerid,COLOR_BLUE,"----------   BY PECET   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano system po¿arów by PECET");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /tablet dla org. porz¹dkowych - PECET");

				showChangeLog(playerid);
			}
			case 6: 
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
		        SendClientMessage(playerid,COLOR_WHITE,"Dodano now¹ frakcjê - SASP (San Andreas State Police).");
		        SendClientMessage(playerid,COLOR_WHITE,"Dodano bramki SASP na autostradach.");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowy interior posterunku BaySide.");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowy wygl¹d komendy /zmienskin dla HA.");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowe miejsce DeMorgan.");

		        showChangeLog(playerid);
			}
			case 7:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
		        SendClientMessage(playerid,COLOR_BLUE,"----------    Systemy   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Stworzono system stref gangów i wojny gangów. Frakcje takie jak Groove, BallaZ, Nortenos, WPS oraz");
		        SendClientMessage(playerid,COLOR_WHITE,"gangi na slotach rodzin od 5 do 10 maj¹ uprawnienia do podbijania stref. Frakcje w/w maj¹ swoje sta³e");
		        SendClientMessage(playerid,COLOR_WHITE,"strefy kontroli, których nie da siê przej¹æ. Gangi przejmuj¹ teren, gdy maj¹ wystarczaj¹c¹ iloœæ osób");
		        SendClientMessage(playerid,COLOR_WHITE,"w tej samej strefie. Atak rozpoczyna osoba z rang¹ 4 lub wiêksz¹. Warunkiem przejêcia jest równie¿");
		        SendClientMessage(playerid,COLOR_WHITE,"taka sama lub wiêksza iloœæ gangsterów online kontroluj¹cych dan¹ strefê. Strefê przejmuje siê w ci¹gu 15 minut.");
		        SendClientMessage(playerid,COLOR_WHITE,"Podczas ataku, osoby umieraj¹ce otrzymuj¹ BW na 3 minuty, które mo¿e byæ nadane tylko przez gangsterów lub policjê.");
		        SendClientMessage(playerid,COLOR_WHITE,"Strefa zostaje przejêta, gdy ³¹czna iloœæ obroñców w strefie jest mniejsza od iloœci atakuj¹cych.");
		        SendClientMessage(playerid,COLOR_WHITE,"Atak na strefê jest oznaczony na mapie poprzez miganie strefy na kolor czerwony.");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   Komendy   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Dla administracji: /unbw oraz /respawncar");
		        SendClientMessage(playerid,COLOR_WHITE,"Dla rodzin: /pr kolor (wymagane do podbojów)");
		        SendClientMessage(playerid,COLOR_WHITE,"/zaznacz - pozwala wybraæ Textdraw (np. do licznika)");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   Inne   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Przesuniêto TXD stref gangów");
		        SendClientMessage(playerid,COLOR_WHITE,"Dodano nowy licznik prêdkoœci");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   ZMIANY   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"29.08 - Naprawa crashu z adresu 0x00756B89");
		        SendClientMessage(playerid,COLOR_WHITE,"30.08 - /vopis, zmiana koloru czatu /zg");
		        SendClientMessage(playerid,COLOR_WHITE,"Ikona w prawym górnym rogu oznacza informacje ze strony serwera, aby zaznaczyæ wpisz (/zaznacz i ESC)");

		        showChangeLog(playerid);
			}
			case 8:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
		        SendClientMessage(playerid,COLOR_BLUE,"----------    Systemy   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Likwidacja starego systemu pojazdów frakcyjnych (przypisanych na sta³e) wprowadzenie nowego");
		        SendClientMessage(playerid,COLOR_WHITE,"Poprawiono optymalnosæ g³ównych timerów serwera");
		        SendClientMessage(playerid,COLOR_WHITE,"Wprowadzenie banów w MySQL");
		        SendClientMessage(playerid,COLOR_WHITE,"Ogólna poprawa kondycji kont graczy w MySQL");
		        SendClientMessage(playerid,COLOR_WHITE,"System uprawnieñ (do panelu kar i logów oraz do pewnych komend np. /dajzaufanego)");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowy system barierek dla frakcji (/barierka i /barierka usun). Maksymalna ilosæ to 10 na frakcjê!");
		        SendClientMessage(playerid,COLOR_WHITE,"Dynamiczne nazwy rang - mo¿liwosc zmiany rang aktualnie tylko przez te osoby (0Verte, Mrucznik, Kubi)");
		        SendClientMessage(playerid,COLOR_WHITE,"Kierunkowskazy dla pojazdów ko³owych");
		        SendClientMessage(playerid,COLOR_BLUE,"----------    Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Biuro ICC (projekt DywaniK)");
				SendClientMessage(playerid,COLOR_WHITE,"Przebudowa szpitala LSMC (projekt abram01)");
				SendClientMessage(playerid,COLOR_WHITE,"Stworzenie remizy stra¿ackiej (projekt abram01)");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowa siedziba San News (projekt DywaniK)");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowa baza wojska SFHQ (projekt DywaniK)");
		        SendClientMessage(playerid,COLOR_WHITE,"Poprawiona wersja warsztatów rodziny RSC (14)");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowy bar na Glen Park");
		        SendClientMessage(playerid,COLOR_WHITE,"Vinyl Club interior (projekt Albert i Patryk)");
		        SendClientMessage(playerid,COLOR_WHITE,"Ibiza Club interior");
		        SendClientMessage(playerid,COLOR_WHITE,"Ca³kowicie zmiana bazy KT, nowy wygl¹d z zewn¹trz i nowe biura (projekt Kubi)");
		        SendClientMessage(playerid,COLOR_WHITE,"Nowy interior AT-400 (projekt Kubi)");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   Komendy   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Przerobione komendê /spec dla administracji");
		        SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /opis (FINALLY) wiêcej informacji w /opispomoc");
		        SendClientMessage(playerid,COLOR_WHITE,"ICC otrzyma³o komendê na otwieranie drzwi restauracji (/zamek)");
		        SendClientMessage(playerid,COLOR_WHITE,"Modyfikacja /kajdanki dla BOR");
		        SendClientMessage(playerid,COLOR_WHITE,"Modyfikacja /su dla BOR (mog¹ nadaæ tylko pierwszy WL)");
		        SendClientMessage(playerid,COLOR_WHITE,"Dla taksówek: /fare od teraz liczy trasê w kilometrach");
		        SendClientMessage(playerid,COLOR_WHITE,"Przywrócono AT-400 oraz komendy do zarz¹dzania lotniskami i lotami (/lot)");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   Poprawki   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Naprawiono b³¹d, gdzie policja mog³a u¿ywaæ /mdc po wyjsciu z interioru");
		        SendClientMessage(playerid,COLOR_WHITE,"Poprawiono komendê /rodziny i /biznesy, wywietlaj¹ teraz prawid³owe informacje");
		        SendClientMessage(playerid,COLOR_WHITE,"Kostka w kasynie zosta³a ca³kowicie zmieniona");
		        SendClientMessage(playerid,COLOR_WHITE,"G³osnik SN ma teraz d³u¿szy link do wpisania");
		        SendClientMessage(playerid,COLOR_BLUE,"----------   Inne   ---------");
		        SendClientMessage(playerid,COLOR_WHITE,"Usuniêto mo¿liwosc teleportacji do wiêzienia stanowego (przez komisariat)");
		        SendClientMessage(playerid,COLOR_WHITE,"Piêkno: Dodano animacje podczas postrza³u w czêsci cia³a");
		        SendClientMessage(playerid,COLOR_WHITE,"Piêkno: Dodano nowy styl TXD dla rozmaitych informacji (np. /togw /togtel)");
		        SendClientMessage(playerid,COLOR_WHITE,"Ballas dosta³o zmianê pojazdów, spawna");
		        SendClientMessage(playerid,COLOR_WHITE,"Frakcja LSFD otrzyma³a w³asny slot 17. Od teraz jest osobn¹ frakcj¹ o czatach radiowych");
		        SendClientMessage(playerid,COLOR_WHITE,"Piêkno: DŸwiêk dzwoni¹cego telefonu oraz wybierania numerów");
		        SendClientMessage(playerid,COLOR_WHITE,"Piêkno: Modernizacja /call 911 - dodano listê GUI i mo¿liwosæ wezwania stra¿y");
		        SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja 2.4.92 <<<_______________________|");

		        showChangeLog(playerid);
			}
			case 9:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------    Systemy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Przywrócono system ³owienia ryb oraz gotowania posi³ków (z mapy Godfather)");
				SendClientMessage(playerid,COLOR_WHITE,"Przeniesiono ca³kowicie stary system kont na nowy");//komenda /zmiennick na standardy mysql
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja 2.4.911 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 10:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------    Systemy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Automat do usuwania podwójnych w³ascicieli, kontroli aktywnoœci i bugu z ikonk¹.");
				//SendClientMessage(playerid,COLOR_WHITE,"Przerobiono system banów na nowy, wydajniejszy i wygodniejszy");
				//SendClientMessage(playerid,COLOR_WHITE,"Taksometr KT wylicza stawki za kilometr i nie znika (by Kubi)");//NIE DZIA£A
				//SendClientMessage(playerid,COLOR_WHITE,"Ulepszono pracê ³owcy nagród (poddawanie siê w GUI, automatyczny dobór zleceñ, pogonie i inne)");
				//SendClientMessage(playerid,COLOR_WHITE,"");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Wybudowano dom przy molo bez ko³a (by Sejciak)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Utworzono ruchom¹ bramê na plac manewrowy(by abram01)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Dodano i opracowano now¹ bazê BOR (by abram01)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Zmieniono bramê NoA (by abram01)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Wstawiono i opracowano nowy interior FBI (by Dywan)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Wnêtrze karetki dostêpne poprzez /wejdzw (by abram01 & Mrucznik)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Wnêtrze Kampinga (model 508 - Journey) dostêpne poprzez /wejdzw (by CrucixTM & Mrucznik)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Zamykane sklepy w Verona Mall (by Kobaltowy Eryk)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Lepiej oznakowano wejœcie do placu manewrowego DMV (by abram01)");
				SendClientMessage(playerid,COLOR_WHITE,"Znaki drogowe pod DMV (by Dywan)");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Pojazdy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Zmienione pozycje i kolor pojazdów Vagos");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Znaki TAXI dla heli, sultana i limuzyny KT");//sprawdzone - dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Full tuning dla sultana KT");//sprawdzone - dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana pojazdów LSPD ID 66(427)/151(482)/281(521) na modele 498/413/528"); //sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Dodanie napisów SWAT dla Boxville'a LSPD (id 66) ");//sprawdzone - dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Niedaleko bazy mechaników znajduje siê Predator LSPD (id 212)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"£odzie YKZ s¹ dostêpne niezale¿nie od posiadanej rangi");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana pozycji Hummera NG (id 16)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Podmiana pojazdów NG ID 280(539)/23(497)/24(595) na modele 497/548/430");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêcie PCJ-600 FBI (id 142) i zmiana spawnów wybranych pojazdów.");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Podmiana pojazdów FBI ID 141(541)/139(541) na modele 490/482");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Dodanie napisów FBI 'Emergency Support Unit' dla Buritto FBI (id 141)");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_BLUE,"----------   Drobne    ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Nowy spawn Vagos");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Za³atano dziurê w bazie HA");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Inny stream w Bonehead Club");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana nazwy dla przykrywki YKZ");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Ca³kowita zmiana nazwy frakcji z TFaTf na NoA");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Automatyczne wznawianie GUI przy zakupach w 24/7");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto informacje o posiadaniu pojazdów, przywróceniu broni i kosztach leczenia przy wejœciu na serwer");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_BLUE,"----------   Komendy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Za pomoc¹ /fixr mo¿na naprawiæ bug z dŸwiêkiem helikoptera");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Odpalanie i gaszenie silnika klawiszem Y - {7CFC00}WA¯NE");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Koguty mo¿na w³¹czaæ klawiszem H");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Komenda /kajdanki dzia³a tak¿e dla agentów BOR z 2 rang¹");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Medycy mog¹ teraz aktywowaæ i odbieraæ sygna³ GPS");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Po zmiane nicku wywo³ywany jest kreator postaci umo¿liwiaj¹cy zmianê wieku, pochodzenia i p³ci.");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komendê /taryfikator zawieraj¹ca spis przewinieñ za które mo¿na otrzymaæ mandat");//nie dzia³a przerzucanie dialogów, pomoc prawna crashuje serwer
				if (PlayerInfo[playerid][pDonateRank] == 3)
				{
					SendClientMessage(playerid,COLOR_WHITE,"Mo¿liwoœc zyskania jednej zmiany nicku za pomoca komendy /odejmijzmiane (dla KP lvl 3)");//sprawdzone-dzia³a
				}
				SendClientMessage(playerid,COLOR_BLUE,"----------   B³êdy i niedoróbki   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Przywrócono koœció³ i poprawiono napis nad nim.");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono komendê /odznaka dla stra¿y po¿arnej");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Komenda /wezportfel dzia³a poprawnie dla frakcji WPS");//sprawdzone-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono licznik KT.");//chyba-dzia³a
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono wyjœcie ze sklepu przy stacji benzynowej");//chyba-dzia³a
				if (PlayerInfo[playerid][pAdmin] >= 1)
				{
					SendClientMessage(playerid,COLOR_BLUE,"----------   Dla adminów   ---------");
					SendClientMessage(playerid,COLOR_WHITE,"Dopisano wszytkie komendy admina do /ah");//sprawdzone-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Rangi @ z nowy komendami to teraz: 1,5,(7),10,15,20,25,35,50,100,200,1000,2000,5000");//sprawdzone-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Wp³aty na /charity s¹ teraz widoczne dla wszytkich @");//sprawdzone-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Data w pay.log");//sprawdzone-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Dodano komunikat o ZNIWELOWANIU maj¹tku do pay.log");//chyba-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Dodano komunikat o Z£OMOWANIU DOMU z powodu: nieaktywnoœci i podwójnego w³asciciela do pay.log");//chyba-dzia³a
					SendClientMessage(playerid,COLOR_WHITE,"Po wpisaniu komendy /spec wyœwietla siê dodatkowo level i prawo jazdy gracza (0=brak, 1=posiada)");//sprawdzone-dzia³a
				}
				//Dodaj kary w txd by kubi
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja 2.4.91 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 11:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   G³ówne systemy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Podpiêto mapê pod bazy danych");
				SendClientMessage(playerid,COLOR_WHITE,"W³¹czono konwersje plików kont na bazy danych");
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja v2.4.9 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 12:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   B³êdy i niedoróbki   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Skiny WPS (206 202 133 291) nie s¹ ju¿ dostêpne dla osób spoza tej frakcji");
				SendClientMessage(playerid,COLOR_WHITE,"Wyœwietlanie nazwy WPS i ich rang w /stats");
				SendClientMessage(playerid,COLOR_WHITE,"KT po zalogowaniu i œmierci otrzymuj¹ skin i kolor cywila");
				SendClientMessage(playerid,COLOR_WHITE,"Frakcja WPS mo¿e ju¿ korzystaæ z komend przestêpczych");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano interior Bonehead Club wraz z bramami");
				SendClientMessage(playerid,COLOR_WHITE,"Zoptymalizowano obiety");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Modyfikacje komend   ---------");
				//SendClientMessage(playerid,COLOR_WHITE,"Zmodyfikowano komendê /w - teraz zbyt d³ugi tekst przenoszony jest do nastêpnego /w");
				//SendClientMessage(playerid,COLOR_WHITE,"Komenda /podglad nie przywraca podgl¹du po relogu gracza");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano czat /f i /fo dla frakcji WPS");
				SendClientMessage(playerid,COLOR_WHITE,"Przywrócono czat /fo dla BOR i Urzêdu");
				SendClientMessage(playerid,COLOR_WHITE,"Patent ¿eglarski mo¿na wydawaæ dopiero od 2 rangi");
				SendClientMessage(playerid,COLOR_WHITE,"Komenda /omdv i /cmdv jest dostêpna od 1 rangi");
				SendClientMessage(playerid,COLOR_WHITE,"Prawo jazdy mo¿na teraz wydawaæ od pierwszej rangi");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Inne   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano skin klauna, kurczaka i lidera DMV do wybieralki");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano skin Tempenego dla LSPD");
				if(PlayerInfo[playerid][pAdmin] == 5000)
				{
					SendClientMessage(playerid,COLOR_BLUE,"----------   Skryptowe   ---------");
					SendClientMessage(playerid,COLOR_WHITE,"Dodano nowe funkcje: AntyReklama(string[]), AntyCzitText(string[])");
				}
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja v2.4.811 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 13:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Zablokowano wjazd do fabryki broni. Poprawiono jej wnêtrze.");
				SendClientMessage(playerid,COLOR_WHITE,"Nowe Verona Mall (z pomieszczeniami do zagospodarowania)");
				SendClientMessage(playerid,COLOR_WHITE,"Zmodyfikowany dwa sultany LSPD, tak aby bardziej przypomina³y radiolki");
				SendClientMessage(playerid,COLOR_WHITE,"Oznakowano dwa Sultany FBI");
				SendClientMessage(playerid,COLOR_WHITE,"Osoba zakuta w kajdanki ma je na rêkach");
				SendClientMessage(playerid,COLOR_WHITE,"Ruchomy diabelski m³yn (by Pablo_Borsellino)");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano konfesjona³y (by abram01)");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano koguty dla taxówek specjalnych");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Modyfikacje komend   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Mo¿liwoœc stosowania komend: /fed /su i /tazer wobec SP nie bêd¹cych na s³u¿bie");
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana komunikatów dot. s³u¿by SP wyœwietlanej w /odznaka");
				SendClientMessage(playerid,COLOR_WHITE,"Osoby z WL nie mog¹ braæ /duty");
				SendClientMessage(playerid,COLOR_WHITE,"W komendzie /mandat kwoty pieniê¿ne zast¹piono stawkami dziennymi");
				SendClientMessage(playerid,COLOR_WHITE,"Po w³¹czeniu czatu /n wyœwietlany jest samouczek na temat zachowania siê na tym czacie");
				SendClientMessage(playerid,COLOR_WHITE,"W komendach z pieniêdzmi mo¿emy wpisywaæ u¿ywaæ skrótu 'k', np. /przelew 45 60kk = /przelew 45 60000000 ");
				SendClientMessage(playerid,COLOR_WHITE,"Broñ u dilera mog¹ kupiæ osoby z co najmniej 2lvl i licencj¹ na broñ.");
				SendClientMessage(playerid,COLOR_WHITE,"Sd pistol to broñ od 2 skilla dilera broni a pistolety (z mo¿liwoœci¹ kupna bez licencji) od 1 skilla");
				SendClientMessage(playerid,COLOR_WHITE,"Komenda /take dzia³a od 1 rangi");
				SendClientMessage(playerid,COLOR_WHITE,"Wymóg posiadania s³u¿by dla komend: /ob , /kajdanki");
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana nazw niektórych rang na czacie /n");
				SendClientMessage(playerid,COLOR_BLUE,"----------   B³êdy i niedoróbki   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto b³¹d z niewidocznymi powodami kar.");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono niedoróbki zwi¹zane z nowym komi.");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto czystkê ballas");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono licznik zabiæ z /stats");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono warning o Drive-By");
				SendClientMessage(playerid,COLOR_WHITE,"Brak komunikatu o wpisanie /spec off przy wpisaniu pustego /spec");
				SendClientMessage(playerid,COLOR_WHITE,"Brak komunikatu o wpisanie /sethp [id] [ilosc] przy wpisaniu pustego /sethp [id]");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto podwójne 'dalej' w samouczku");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto ma³e bugi i b³êdy.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Personalizacja frakcji   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana kobiecego skina SAN(9) z ID 148 na 141");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Skryptowe   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Uporz¹dkowano czytelnoœæ i wydajnoœæ kodu w wybranych callback'ach");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto czêœc zbêdnych zmiennych i funkcji");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Systemy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Aktualizator hase³: co 6 miesiêcy system bêdzie prosi³ gracza o zmianê has³a w celu poprawy bezpieczeñstwa kont");
				SendClientMessage(playerid,COLOR_WHITE,"Podwy¿szenie zarobków w pracy kierowcy autobusu");
				SendClientMessage(playerid,COLOR_WHITE,"Ulepszono zamykanie drzwi, zmodyfikowano trasê lini nr 72");
				SendClientMessage(playerid,COLOR_WHITE,"Nieznaczna zmiana miejsca dostarczania materia³ów");
				SendClientMessage(playerid,COLOR_WHITE,"Zwiêkszenie cen materia³ów (500$/1 paczka) i benzyny (40/1%%)");
				SendClientMessage(playerid,COLOR_WHITE,"Przebudowano system nadawania WL za morderstwo");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Nowe komendy   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"/setint - ustawia graczowi interior (1 @lvl)");
				SendClientMessage(playerid,COLOR_WHITE,"/setvw - ustawia graczowi vw (1@)");
				SendClientMessage(playerid,COLOR_WHITE,"/clearwlall - zeruje wszystkim graczom WL (1@)");
				SendClientMessage(playerid,COLOR_WHITE,"/getint - pobiera interior gracza");
				SendClientMessage(playerid,COLOR_WHITE,"/getvw - pobiera vw gracza");
				SendClientMessage(playerid,COLOR_WHITE,"/changelog [wersja] - wyœwietla zmiany wprowadzone w ostatniej aktualizacji lub podanej wersji");
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja v2.4.810 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 14:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Nowy interior LSMC.");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniête zbêdne obiekty (bank, parking przy LSMC).");
				SendClientMessage(playerid,COLOR_WHITE,"Wróci³a stara baza mechów.");
				SendClientMessage(playerid,COLOR_WHITE,"Zaktualizowano i zoptymalizowano obiekty.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Modyfikacje komend   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Nowy /komunikat dla biznesów.");
				SendClientMessage(playerid,COLOR_WHITE,"Maska od [2] rangi dla FBI.");
				SendClientMessage(playerid,COLOR_WHITE,"System Nieruchomoœci - /biznespomoc.");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano /sprzedajmats.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Personalizacja frakcji   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana skina dla YKZ.");
				SendClientMessage(playerid,COLOR_WHITE,"Zmiana ceny kursu taksówek.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Skryptowe   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawki AC.");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano znaczniki na mapê.");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano komunikat dla graczy przy roz³¹czaniu siê gracza w pobli¿u.");
				if(PlayerInfo[playerid][pAdmin] >= 1)
				{
					SendClientMessage(playerid,COLOR_BLUE,"----------   Komendy i poprawki   ---------");
					SendClientMessage(playerid,COLOR_WHITE,"Poprawki do /spec (mo¿e pomog¹).");
					SendClientMessage(playerid,COLOR_WHITE,"Komenda /zbijwl nie wyrzuca komunikatu o policjancie w pobli¿u, gdy ten jest na specu.");
					SendClientMessage(playerid,COLOR_WHITE,"Komenda /dajbiznes i /zabierzbiznes dla Adminów z 5000lvl i wy¿ej.");
				}
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja v2.5.92 <<<_______________________|");

				showChangeLog(playerid);
			}
			case 15:
			{
				SendClientMessage(playerid,COLOR_P@,"|_____________________________Lista zmian_____________________________|");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Nowoœci   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Nowy system telefonów. Od teraz gdy ktoœ do nas zadzwoni to ju¿ nie wyœwietli siê jego nick z gry, lecz sam numer telefonu (autor: Mrucznik)");
				SendClientMessage(playerid,COLOR_WHITE,"Nowa komenda /resms - odpowiada na ostatni¹ otrzyman¹ wiadomoœæ SMS");
				SendClientMessage(playerid,COLOR_WHITE,"Nowa komenda /wizytówka - za pomoc¹ której mo¿esz wrêczyæ graczowi wizytówkê");
				SendClientMessage(playerid,COLOR_WHITE,"Nowa komenda /kontakty - umo¿liwia zarz¹dzaniem kontaktami");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Obiekty   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Urz¹d Miasta Los Santos (autor: Satius)");
				SendClientMessage(playerid,COLOR_WHITE,"Ammu Nation Los Santos (autor: Beczka)");
				SendClientMessage(playerid,COLOR_WHITE,"Pojazd San Van (autor: skLuke)");
				SendClientMessage(playerid,COLOR_WHITE,"Ramirez Car Service (autor: Abstynent)");
				SendClientMessage(playerid,COLOR_WHITE,"Hells Angels MC (autor: Charlie112)");
				SendClientMessage(playerid,COLOR_WHITE,"Plac manewrowy (autor: Satius)");
				SendClientMessage(playerid,COLOR_WHITE,"Dos Santos Car Service (autor: Abstynent)??");
				SendClientMessage(playerid,COLOR_WHITE,"Przywrócenie starych doków (autor: Simeone)??");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawione literówki San Andres Network");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawione literówki USSS");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawione b³êdy Rockstara");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono interior nr. 11");
				SendClientMessage(playerid,COLOR_WHITE,"Dodano barierki zagradzaj¹ce wjazd do banku");
				SendClientMessage(playerid,COLOR_WHITE,"Object Pack dla skTom jako nagroda za pochwa³y od graczy.");
				SendClientMessage(playerid,COLOR_BLUE,"----------   Poprawki b³êdów   ---------");
				SendClientMessage(playerid,COLOR_WHITE,"Darmowa broñ od dilera po œmierci - poprawiono");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono komendê dla DMV (/pjtest)");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono bug wywiadu (gdy reporter wychodzi z serwera wywiad automatycznie siê koñczy)");
				SendClientMessage(playerid,COLOR_WHITE,"Skill pracy dorywczej busiarza dzia³a poprawnie");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawka panelu dla administracji");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono bug barierek dla frakcji USSS");
				SendClientMessage(playerid,COLOR_WHITE,"Skill pracy dorywczej kuriera dzia³a poprawnie");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawki komend dla administracji");
				SendClientMessage(playerid,COLOR_WHITE,"Dodanie nowych komend dla administracji");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono bug /tankowanie");
				SendClientMessage(playerid,COLOR_WHITE,"Nowe komendy dla pó³administratorów");
				SendClientMessage(playerid,COLOR_WHITE,"Komenda /kajdanki zosta³a naprawiona");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono komendê /skinf dla frakcji");
				SendClientMessage(playerid,COLOR_WHITE,"Gaszenie silniku tylko dla pojazdów, które maj¹ silnik");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêto komunikat o kasku w aucie");
				SendClientMessage(playerid,COLOR_WHITE,"W demorgan nie mo¿na mieæ ju¿ broni");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono bugi we frakcji FBI");
				SendClientMessage(playerid,COLOR_WHITE,"Nowe komendy i naprawa panelu KO");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawienie œcie¿ek MP3");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono kamery w kancelarii prawniczej");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono bug z interiorem Cluckin'Bell");
				SendClientMessage(playerid,COLOR_WHITE,"Odblokowanie czatu OOC podczas BW");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono wynagrodzenie za plamy i po¿ary dla LSFD");
				SendClientMessage(playerid,COLOR_WHITE,"Naprawiono bug z rad¹ miasteczka Dillimore");
				SendClientMessage(playerid,COLOR_WHITE,"Od teraz /trasa w KT jest od [0] rangi");
				SendClientMessage(playerid,COLOR_WHITE,"Usuniêcie b³êdu zwi¹zanego z kradzie¿¹ auta");
				SendClientMessage(playerid,COLOR_WHITE,"Dodanie BW dla USSS.");
				SendClientMessage(playerid,COLOR_WHITE,"Poprawiono drobne b³êdy jêzykowe");
				if(PlayerInfo[playerid][pAdmin] >= 1)
				{
					SendClientMessage(playerid,COLOR_BLUE,"----------   Dla administracji   ---------");
					SendClientMessage(playerid,COLOR_WHITE,"Stworzenie nowych komend: /tankveh, /gotobank, /gotostacja");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawiono komendy: /gotosalon, /gotomechy, /gotoadmin, /gotostad");
					SendClientMessage(playerid,COLOR_WHITE,"Poprawa literówek w komendach administracyjnych");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawiono /spec");
					SendClientMessage(playerid,COLOR_WHITE,"Usuniêcie komunikatu o /q na /spec");
					SendClientMessage(playerid,COLOR_WHITE,"Nowe prace do wyboru pod komend¹ /setstat");
					SendClientMessage(playerid,COLOR_WHITE,"Nowe komendy dla Pó³Administratorów: /pwarn, /warn, /unbw, /pogodaall");
					SendClientMessage(playerid,COLOR_WHITE,"Nowa komenda /czyjtonumer(sprawdza do kogo nalezy dany numer telefonu)");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawa b³êdu zwi¹zanego z /dowod, /pl na specu");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawienie komendy /mole");
					SendClientMessage(playerid,COLOR_WHITE,"Dodanie /addcar i /removecar dla KO");
					SendClientMessage(playerid,COLOR_WHITE,"Dodanie komendy /usunopisveh dla panelu KO");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawa /panel unwarn gdy gracz jest online");
					SendClientMessage(playerid,COLOR_WHITE,"Naprawa panelu KO");
				}
				SendClientMessage(playerid,COLOR_P@,"|_______________________>>> Wersja v2.5.93 <<<_______________________|");

				showChangeLog(playerid);
			}
		}
	}
	return 0;
}

stock showChangeLog(playerid, page = CHANGELOG_MAIN)
{
	if(page == CHANGELOG_MAIN)
	{
		new string[900];
		format(string, sizeof(string), "##\t"#HQ_COLOR_TEKST2"2.5.84\n");
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.83\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.82\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.8\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.7\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.6\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.2\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.93\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.92\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.911\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.91\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.9\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.811\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.4.810\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.92\n", string);
		format(string, sizeof(string), "%s##\t"#HQ_COLOR_TEKST2"2.5.93", string);
		ShowPlayerDialogEx(playerid, 1962, DIALOG_STYLE_LIST, "Wybierz aktualizacjê", string, "Ok", "WyjdŸ");
	}
	return 1;
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

stock fPanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	opis_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	changeLog_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
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
            MruMySQL_SetAccInt("Skin", pracownik_nick, 0);
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

		    return ShowPlayerDialogEx(playerid, 1966, DIALOG_STYLE_LIST, "Wybierz rangê, któr¹ chcesz nadaæ graczu", str, "Nadaj", "Anuluj");
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

		MruMySQL_SetAccInt("Rank", pracownik_nick, listitem);

		new msg[128];

		format(msg, sizeof(msg), "Awansowa³eœ %s na rangê %s", pracownik_nick, FracRang[PlayerInfo[playerid][pLider]][listitem]);
        sendTipMessage(playerid, msg, COLOR_LIGHTBLUE);

        new uid = GetPVarInt(playerid, "fpanel_uid");
		DeletePVar(playerid, "fpanel_uid");    		
    	return showEmployeeInfo(playerid, uid);
	}
	return 0;
}

stock showEmployeeInfo(playerid, employeeUid)
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

stock showFactionWorkers(playerid, page=1)
{
	new query[128];

	new id = PlayerInfo[playerid][pLider];

	format(query, sizeof(query), "SELECT COUNT(*) FROM `mru_konta` WHERE `Member`='%d' AND Rank < 90", id);

	mysql_query(query);
	mysql_store_result();
	new row[24];
	mysql_fetch_row_format(row,"|");
	new ilosc = strval(row);

	mysql_free_result();

	if(ilosc == 0) return sendErrorMessage(playerid, "Ta frakcja nie ma pracowników");

	new header[128], Float:pp = ilosc / FPANEL_PER_PAGE;
	format(header, sizeof(header), "Panel Lidera » Pracownicy [%d/%d]", page, floatround(pp, floatround_ceil)+1);

	DynamicGui_Init(playerid);

	new str[1400];

	format(str, sizeof(str), "Imie i Nazwisko\tRanga");

	new offset = (page - 1) * FPANEL_PER_PAGE;

	format(query, sizeof(query), "SELECT UID,Nick,Rank,Lider FROM `mru_konta` WHERE `Member`='%d' AND Rank < 90 ORDER BY Rank Desc LIMIT %d,%d;", id, offset, FPANEL_PER_PAGE);
	mysql_query(query);
	mysql_store_result();

	new nick[24], uid, rank, lider = 0, rankname[36];
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ds[24]dd", uid, nick, rank, lider);
        if(rank != 99 && lider == 0)
        {
	        strmid(rankname, FracRang[id][rank], 0, 35, 36);
	        format(str, sizeof(str), "%s\n%s\t[%d] %s", str, nick, rank, rankname);
	        DynamicGui_AddRow(playerid, FPANEL_DG_OSOBA, uid);
	    }
    }

    if( page > 1 )
	{
		format(str, sizeof(str), "%s\n\n{888888}<<< Poprzednia strona\n  \n", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_PREV);

		DynamicGui_AddBlankRow(playerid);
	}

	if( ilosc > (page*FPANEL_PER_PAGE) )
	{
		format(str, sizeof(str), "%s\n\n{888888}Nastêpna strona >>>", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_NEXT);
	}

	SetPVarInt(playerid, "fpanel_Page", page);

	mysql_free_result();

	ShowPlayerDialogEx(playerid, 1959, DIALOG_STYLE_TABLIST_HEADERS, header, str, "Wybierz", "Cofnij");

	return 1;
}

stock factionLeaderPanel(playerid, page = FPANEL_MAIN)
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

COMMAND:fpanel(playerid, params[])
{
	if(PlayerInfo[playerid][pLider] < 1) return noAccessMessage(playerid);
	factionLeaderPanel(playerid, FPANEL_MAIN);
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

stock LoadPrzewinienia()
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

stock noYsi_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
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

stock ShowPodrecznik(playerid, page=HELP_MAIN)
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


COMMAND:lkiz(playerid, params[]) return RunCommand(playerid, "/podrecznik",  params);
COMMAND:pomoc(playerid, params[]) return RunCommand(playerid, "/podrecznik",  params);
COMMAND:podrecznik(playerid, params[])
{
	ShowPodrecznik(playerid, HELP_MAIN);
	return 1;
}




#define HQ_MAIN 	1
#define HQ_WL		2
#define HQ_ZGL		3

#define DG_SELECT_ZGL	1


stock hq_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
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
	            if(!strcmp(Zgloszenie[dg_data][zgloszenie_przyjal], GetNick(playerid, true))) {
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
	            if(!strcmp(ZgloszenieSasp[dg_data][zgloszenie_przyjal], GetNick(playerid, true))) {
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
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid, true), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
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
	                strmid(Zgloszenie[szczegol][zgloszenie_przyjal], GetNick(playerid, true), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
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
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid, true), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
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
	                strmid(ZgloszenieSasp[szczegol][zgloszenie_przyjal], GetNick(playerid, true), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
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


stock ShowHeadquarters(playerid, page=HQ_MAIN)
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
		//TODO: cmd_wanted(playerid);
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

COMMAND:hq(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1 || PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
	{
		ShowHeadquarters(playerid);
	}
	else
	{
		return noAccessMessage(playerid);
	}
	return 1;
}
