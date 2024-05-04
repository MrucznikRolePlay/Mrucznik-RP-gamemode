//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  businfo                                                  //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_businfo_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(GUIExit[playerid] == 0)
    	{
            command_businfo_showDialog(playerid);
		}
	}
    return 1;
}

command_businfo_showDialog(playerid)
{
    ShowPlayerDialogEx(playerid, 5000, DIALOG_STYLE_LIST, "Wybierz interesuj¹c¹ ciê zagadnienie", "Linia 55 - skill 1\nLinia 72 - skill 1\nLinia 82 - skill 2\nLinia 96 - skill 2\nLinia 85 - skill 2\nInformacje\nPomoc", "Wybierz", "WyjdŸ");
}

command_businfo_dialog(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
    if(dialogid == 5000)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 55","Przystanki koñcowe:\nKoœció³ <==> Mrucznik Tower\n\nCzas przejazdu trasy: 9minut \n\nIloœæ przystanków: 13\n\nSzczegó³owy rozpis trasy:\n Koœció³\n Motel Jefferson\n Glen Park\n Skate Park\n Unity Station\n Urz¹d Miasta\n Bank\n Kasyno\n Market Station\n Baza San News i Restauracja\n Siedziba FBI\n Molo Wêdkarskie\n Mrucznik Tower","Wróæ","WyjdŸ");
                    //\n\nOpis:\n Wsiadaj¹c do tego autobusu na pewno odwiedzisz\n ka¿de miejsce naprawdê warte twojej uwagi\n Jednak z powodu du¿ej liczby przystnaków\n czas podró¿y znacznie siê wyd³u¿a.
                }
                case 1:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 72","Przystanki koñcowe:\nBaza Mechaników <==> Mrucznik Tower\n\nCzas przejazdu trasy: 3min 50s\n\nIloœæ przystanków: 9\n\nSzczegó³owy rozpis trasy:\n Mrucznik Tower (praca prawnika i ³owcy)\n Market Station\n Szpital\n AmmuNation (praca dilera broni)\n Bank)\n Urz¹d Miasta (wyrób licencji)\n Stacja Benzynowa\n Si³ownia (praca ochroniarza - sprzedaje pancerze i boksera)\n Willowfield\n Baza Mechaników","Wróæ","WyjdŸ");
                    //\n\nOpis:\n Szybka linia zapewniaj¹ca g³ównie cywilom szybki\n transport miêdzy kluczowymi punktami w mieœcie\n Najwa¿niejsza i najszybsza linia LSBD
                }
                case 2:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 82","Przystanki koñcowe:\nZajezdnia Commerce <==> Bay Side LV\n\nCzas przejazdu trasy:  11 minut \n\nIloœæ przystanków:  9\n\nSzczegó³owy rozpis trasy:\n Zajezdnia Commerce / Basen 'tsunami'\n Urz¹d Miasta\n Baza Mechaników\n Agencja Ochrony\n miasteczko Palomino Creek\n Hilltop Farm\n Dillimore\n Bluberry\n Bay Side","Wróæ","WyjdŸ");
                    // \n Trasa po Red County jest bardzo malownicza\n zaœ droga do bay side usypiaj¹ca\n Najd³u¿sza trasa LSDB
                }
                case 3:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 96","W Przystanki koñcowe:\nBaza Wojskowa <==> Mrucznik Tower\n\nCzas przejazdu trasy:  ? \n\nIloœæ przystanków:  12\n\nSzczegó³owy rozpis trasy:\n Baza Wojskowa\n Fabryka (dostawa matsów)\n Pas Startowy \n Wiadukt\n Unity Station\n Verdant Bluffs (ty³y Urzêdu Miasta)\n Zajezdnia Commerce\n Galerie Handlowe\n Burger Shot Marina\n Baza FBI\n Wypo¿yczalnia aut (odbiór matsów)\n Mrucznik Tower","Wróæ","WyjdŸ");
                        //\n\nOpis:\nKolejna trasa ze wschodu na zachód, jednak tym razem\n szlakiem mniej uczêszczanych miejsc\n Ulubiona trasa pocz¹tkuj¹cych dilerów broni
                }
                case 4:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Linia 85","Przystanki koñcowe:\nWysypisko <==> Szpital\n\nCzas przejazdu trasy:  ? \n\nIloœæ przystanków:  12\n\nSzczegó³owy rozpis trasy:\n Wysypisko\n Clukin Bell Willofield\n Myjnia Samochodowa\n Baza Mechaników\n Agencja Ochrony\n Las Colinas \n Motel Jefferson\n Glen Park\n Mrucznikowy GS\n Bank\n Szpital\n\n Opis:\n Niebezpieczna trasa prowadz¹ce przez tereny prawie wszytkich gangów","Wróæ","WyjdŸ");
                }
                case 5:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Informacje","Z autobusu najlepiej korzystaæ wtedy gdy jesteœ pewien ¿e dana linia jest w trasie\n\nPamiêtaj, ze autobusy oznaczone numeremm linii poruszaj¹ siê zgodnie z okreœlon¹ tras¹\n\nJak zostaæ kierowc¹ autobusu?\nNale¿y z³o¿yæ podanie na forum do Korporacji Transportowej\nMo¿na równie¿ podj¹æ siê pracy kierowcy dostêpnej przy basenie","Wróæ","WyjdŸ");
                }
                case 6:
                {
                    ShowPlayerDialogEx(playerid,5001,DIALOG_STYLE_MSGBOX,"Komendy","Dla pasa¿era:\n\n/businfo - wyœwietla informacje o autobusach\n/wezwij bus - pozwala wezwaæ autobus ktory podwiezie ciê w dowolne miejsce\n/anuluj bus - kasuje wezwanie autobusu\n\n\nDla Kierowcy:\n/fare [cena] - pozwala wejœæ na s³u¿bê i ustaliæ cenê za bilet\n/trasa - rozpoczyna kurs wed³ug wyznaczonej trasy\n/zakoncztrase - przerywa trasê\n/zd - zamyka drzwi i umo¿liwia ruszenie z przystanku","Wróæ","WyjdŸ");
                }
            }
        }
        return 1;
    }
    else if(dialogid == 5003 || dialogid == 5002 || dialogid == 5001)
    {
        if(response)
        {
            command_businfo_showDialog(playerid);
        }
        return 1;
    }
    return 0;
}

//end