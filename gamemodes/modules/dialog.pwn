forward cmd_bus_Dialog_Response(playerid, dialogid, response, listitem, string:inputtext[]); 
public cmd_bus_Dialog_Response(playerid, dialogid, response, listitem, string:inputtext[]) {
	if(response) {
		Dialog_ShowCallback(playerid, using public cmd_bus_Dialog, DIALOG_STYLE_LIST, "Wybierz interesującą cię zagadnienie", "Linia 55\nLinia 72\nLinia 82\nLinia 96\nLinia 85\nObecnie w trasie\nWycieczki\nInformacje\nPomoc", "Wybierz", "Wyjdź");
	}
}

forward cmd_bus_Dialog(playerid, dialogid, response, listitem, string:inputtext[]); 
public cmd_bus_Dialog(playerid, dialogid, response, listitem, string:inputtext[]) {
	if(response)
	    {
	    switch(listitem)
		{
		    case 0:
			{
	       		//ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 55","Przystanki końcowe:\nKościół <==> Mrucznik Tower\n\nCzas przejazdu trasy: 9minut \n\nIlość przystanków: 13\n\nSzczegółowy rozpis trasy:\n Kościół\n Motel Jefferson\n Glen Park\n Skate Park\n Unity Station\n Urząd Miasta\n Bank\n Kasyno\n Market Station\n Baza San News i Restauracja\n Siedziba FBI\n Molo Wędkarskie\n Mrucznik Tower","Wróć","Wyjdź");
	       		Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Linia 55","Przystanki końcowe:\nKościół <==> Mrucznik Tower\n\nCzas przejazdu trasy: 9minut \n\nIlość przystanków: 13\n\nSzczegółowy rozpis trasy:\n Kościół\n Motel Jefferson\n Glen Park\n Skate Park\n Unity Station\n Urząd Miasta\n Bank\n Kasyno\n Market Station\n Baza San News i Restauracja\n Siedziba FBI\n Molo Wędkarskie\n Mrucznik Tower","Wróć","Wyjdź");
				//\n\nOpis:\n Wsiadając do tego autobusu na pewno odwiedzisz\n każde miejsce naprawdę warte twojej uwagi\n Jednak z powodu dużej liczby przystnaków\n czas podróży znacznie się wydłuża.
			}
			case 1:
			{
			    //ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 72","Przystanki końcowe:\nBaza Mechaników <==> Mrucznik Tower\n\nCzas przejazdu trasy: 3min 50s\n\nIlość przystanków: 9\n\nSzczegółowy rozpis trasy:\n Mrucznik Tower (praca prawnika i łowcy)\n Market Station\n Szpital\n AmmuNation (praca dilera broni)\n Bank)\n Urząd Miasta (wyrób licencji)\n Stacja Benzynowa\n Siłownia (praca ochroniarza - sprzedaje pancerze i boksera)\n Willowfield\n Baza Mechaników","Wróć","Wyjdź");
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Linia 72","Przystanki końcowe:\nBaza Mechaników <==> Mrucznik Tower\n\nCzas przejazdu trasy: 3min 50s\n\nIlość przystanków: 9\n\nSzczegółowy rozpis trasy:\n Mrucznik Tower (praca prawnika i łowcy)\n Market Station\n Szpital\n AmmuNation (praca dilera broni)\n Bank)\n Urząd Miasta (wyrób licencji)\n Stacja Benzynowa\n Siłownia (praca ochroniarza - sprzedaje pancerze i boksera)\n Willowfield\n Baza Mechaników","Wróć","Wyjdź");
				//\n\nOpis:\n Szybka linia zapewniająca głównie cywilom szybki\n transport między kluczowymi punktami w mieście\n Najważniejsza i najszybsza linia LSBD
			}
			case 2:
			{

			    //ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 82","Przystanki końcowe:\nZajezdnia Commerce <==> Bay Side LV\n\nCzas przejazdu trasy:  11 minut \n\nIlość przystanków:  9\n\nSzczegółowy rozpis trasy:\n Zajezdnia Commerce / Basen 'tsunami'\n Urząd Miasta\n Baza Mechaników\n Agencja Ochrony\n miasteczko Palomino Creek\n Hilltop Farm\n Dillimore\n Bluberry\n Bay Side","Wróć","Wyjdź");
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Linia 82","Przystanki końcowe:\nZajezdnia Commerce <==> Bay Side LV\n\nCzas przejazdu trasy:  11 minut \n\nIlość przystanków:  9\n\nSzczegółowy rozpis trasy:\n Zajezdnia Commerce / Basen 'tsunami'\n Urząd Miasta\n Baza Mechaników\n Agencja Ochrony\n miasteczko Palomino Creek\n Hilltop Farm\n Dillimore\n Bluberry\n Bay Side","Wróć","Wyjdź");
				// \n Trasa po Red County jest bardzo malownicza\n zaś droga do bay side usypiająca\n Najdłuższa trasa LSDB
			}
	   		case 3:
			{
			   //ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 96","W Przystanki końcowe:\nBaza Wojskowa <==> Mrucznik Tower\n\nCzas przejazdu trasy:  ? \n\nIlość przystanków:  12\n\nSzczegółowy rozpis trasy:\n Baza Wojskowa\n Fabryka (dostawa matsów)\n Pas Startowy \n Wiadukt\n Unity Station\n Verdant Bluffs (tyły Urzędu Miasta)\n Zajezdnia Commerce\n Galerie Handlowe\n Burger Shot Marina\n Baza FBI\n Wypożyczalnia aut (odbiór matsów)\n Mrucznik Tower","Wróć","Wyjdź");
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Linia 96","W Przystanki końcowe:\nBaza Wojskowa <==> Mrucznik Tower\n\nCzas przejazdu trasy:  ? \n\nIlość przystanków:  12\n\nSzczegółowy rozpis trasy:\n Baza Wojskowa\n Fabryka (dostawa matsów)\n Pas Startowy \n Wiadukt\n Unity Station\n Verdant Bluffs (tyły Urzędu Miasta)\n Zajezdnia Commerce\n Galerie Handlowe\n Burger Shot Marina\n Baza FBI\n Wypożyczalnia aut (odbiór matsów)\n Mrucznik Tower","Wróć","Wyjdź");
				 //\n\nOpis:\nKolejna trasa ze wschodu na zachód, jednak tym razem\n szlakiem mniej uczęszczanych miejsc\n Ulubiona trasa początkujących dilerów broni
			}
  			case 4:
			{
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Linia 85","Przystanki końcowe:\nWysypisko <==> Szpital\n\nCzas przejazdu trasy:  ? \n\nIlość przystanków:  12\n\nSzczegółowy rozpis trasy:\n Wysypisko\n Clukin Bell Willofield\n Myjnia Samochodowa\n Baza Mechaników\n Agencja Ochrony\n Las Colinas \n Motel Jefferson\n Glen Park\n Mrucznikowy GS\n Bank\n Szpital\n\n Opis:\n Niebezpieczna trasa prowadzące przez tereny prawie wszytkich gangów","Wróć","Wyjdź");
			}
  			case 5:
			{
			   // ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Wycieczki","W budowie","Wróć","Wyjdź");
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Wycieczki","W budowie","Wróć","Wyjdź");
			}
  			case 6:
			{
       			// ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Wycieczki","Informacje o wycieczkach są zamieszczane na czatach głównych\n Oczywiście nie ma nic za darmo\n San News zarabia na reklamach zaś KT tradycyjnei na biletach\n pamiętaj że na wycieczki nie bierzemy własnego samochodu\n lecz korzystamy z podstawionych przez organizatora autobusów\n Wycieczka to świetna zabawa i mnóstwo konkursów z nagrodami, dlatego warto się na nich pojawiać.","Wróć","Wyjdź");
       			 Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Wycieczki","Informacje o wycieczkach są zamieszczane na czatach głównych\n Oczywiście nie ma nic za darmo\n San News zarabia na reklamach zaś KT tradycyjnei na biletach\n pamiętaj że na wycieczki nie bierzemy własnego samochodu\n lecz korzystamy z podstawionych przez organizatora autobusów\n Wycieczka to świetna zabawa i mnóstwo konkursów z nagrodami, dlatego warto się na nich pojawiać.","Wróć","Wyjdź");
			}
			case 7:
			{
			    //ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Informacje","Z autobusu najlepiej korzystać wtedy gdy jesteś pewien że dana linia jest w trasie\n\nPamiętaj, ze autobusy oznaczone numeremm linii poruszają się zgodnie z określoną trasą\n\nJak zostać kierowcą autobusu?\nNależy złożyć podanie na forum do Korporacji Transportowej\nMozna również podjąć się pracy kierowcy minibusa dostępnej przy basenie","Wróć","Wyjdź");
			    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Informacje","Z autobusu najlepiej korzystać wtedy gdy jesteś pewien że dana linia jest w trasie\n\nPamiętaj, ze autobusy oznaczone numeremm linii poruszają się zgodnie z określoną trasą\n\nJak zostać kierowcą autobusu?\nNależy złożyć podanie na forum do Korporacji Transportowej\nMozna również podjąć się pracy kierowcy minibusa dostępnej przy basenie","Wróć","Wyjdź");
			}
			case 8:
			{
				//    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Komendy","Dla pasażera:\n\n/businfo - wyświetla informacje o autobusach\n/wezwij bus - pozwala wezwać autobus ktory podwiezie cię w dowolne miejsce\n/anuluj bus - kasuje wezwanie autobusu\n\n\nDla Kierowcy:\n/fare [cena] - pozwala wejść na służbę i ustalić cenę za bilet\n/trasa - rozpoczyna kurs według wyznaczonej trasy\n/zakoncztrase - przerywa trasę\n/zd - zamyka drzwi i umożliwia ruszenie z przystanku","Wróć","Wyjdź");
				    Dialog_ShowCallback(playerid, using public cmd_bus_Dialog_Response, DIALOG_STYLE_MSGBOX,"Komendy","Dla pasażera:\n\n/businfo - wyświetla informacje o autobusach\n/wezwij bus - pozwala wezwać autobus ktory podwiezie cię w dowolne miejsce\n/anuluj bus - kasuje wezwanie autobusu\n\n\nDla Kierowcy:\n/fare [cena] - pozwala wejść na służbę i ustalić cenę za bilet\n/trasa - rozpoczyna kurs według wyznaczonej trasy\n/zakoncztrase - przerywa trasę\n/zd - zamyka drzwi i umożliwia ruszenie z przystanku","Wróć","Wyjdź");
			}
		}
	}
}