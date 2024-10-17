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
    ShowPlayerDialogEx(playerid, 5000, DIALOG_STYLE_LIST, "Wybierz interesuj¹c¹ ciê zagadnienie", "O autobusach\nKomendy", "Wybierz", "WyjdŸ");
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
                    ShowPlayerDialogEx(playerid, 5001, DIALOG_STYLE_MSGBOX, "O autobusach", 
                        "Z autobusu najlepiej korzystaæ wtedy gdy jesteœ pewien ¿e dana linia jest w trasie\n\n\
                        Pamiêtaj, ze autobusy oznaczone numeremm linii poruszaj¹ siê zgodnie z okreœlon¹ tras¹\n\n\
                        Jak zostaæ kierowc¹ autobusu?\nNale¿y do³¹czyæ do pracy kierowcy w Kafuman Cab Vice City",
                        "Wróæ","WyjdŸ");
                }
                case 1:
                {
                    ShowPlayerDialogEx(playerid, 5001, DIALOG_STYLE_MSGBOX, "Komendy",
                        "Dla pasa¿era:\n\n\
                        /businfo - wyœwietla informacje o autobusach\n\
                        /wezwij bus - pozwala wezwaæ autobus ktory podwiezie ciê w dowolne miejsce\n\
                        /anuluj bus - kasuje wezwanie autobusu\n\n\n\
                        Dla Kierowcy:\n\
                        /fare [cena] - pozwala wejœæ na s³u¿bê i ustaliæ cenê za bilet\n\
                        /trasa - rozpoczyna kurs wed³ug wyznaczonej trasy\n\
                        /zakoncztrase - przerywa trasê\n\
                        /zd lub C - zamyka drzwi i umo¿liwia ruszenie z przystanku\n",
                        "Wróæ","WyjdŸ");
                }
            }
        }
        return 1;
    }
    else if(dialogid == 5001)
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