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
    ShowPlayerDialogEx(playerid, 5000, DIALOG_STYLE_LIST, "Wybierz interesuj�c� ci� zagadnienie", "O autobusach\nKomendy", "Wybierz", "Wyjd�");
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
                        "Z autobusu najlepiej korzysta� wtedy gdy jeste� pewien �e dana linia jest w trasie\n\n\
                        Pami�taj, ze autobusy oznaczone numeremm linii poruszaj� si� zgodnie z okre�lon� tras�\n\n\
                        Jak zosta� kierowc� autobusu?\nNale�y do��czy� do pracy kierowcy w Kafuman Cab Vice City",
                        "Wr��","Wyjd�");
                }
                case 1:
                {
                    ShowPlayerDialogEx(playerid, 5001, DIALOG_STYLE_MSGBOX, "Komendy",
                        "Dla pasa�era:\n\n\
                        /businfo - wy�wietla informacje o autobusach\n\
                        /wezwij bus - pozwala wezwa� autobus ktory podwiezie ci� w dowolne miejsce\n\
                        /anuluj bus - kasuje wezwanie autobusu\n\n\n\
                        Dla Kierowcy:\n\
                        /fare [cena] - pozwala wej�� na s�u�b� i ustali� cen� za bilet\n\
                        /trasa - rozpoczyna kurs wed�ug wyznaczonej trasy\n\
                        /zakoncztrase - przerywa tras�\n\
                        /zd lub C - zamyka drzwi i umo�liwia ruszenie z przystanku\n",
                        "Wr��","Wyjd�");
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