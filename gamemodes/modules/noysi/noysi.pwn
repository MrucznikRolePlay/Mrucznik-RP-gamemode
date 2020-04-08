//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  noysi                                                    //
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
#include "noysi.def"
#include "noysi.hwn"
#include "noysi_dialogs.pwn"
//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
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
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end