//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   trasa                                                   //
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
command_trasa_Impl(playerid)
{
	new Veh = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || GetPlayerJob(playerid) == JOB_DRIVER)
	{
		if(IsPlayerConnected(playerid))
		{
			if(IsAPublicTransport(Veh))
			{
				comand_trasa_dialog_show(playerid);
			}
			else
			{
				sendTipMessage(playerid, "Nie jesteœ w autobusie!");
			}
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ kierowc¹ ani z Korporacji Transportowej!");
	}
    return 1;
}

comand_trasa_dialog_show(playerid)
{
	ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 - niebieska (920$/p , 9min, 21p, +2)\nLinia 72 - pomarañczowa (800$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (1240$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (2400$/p , 11min, 18p, +3)\nLinia 85 3s (1080$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
}

command_trasa_dialog(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext

	if(dialogid == 8155)//SYstem autobusów - tablice
	{
		if(response == 1)
		{
			switch(listitem)
			{
				case 0,1: // trasa 55 i 72 1 skill
				{
					if(PlayerInfo[playerid][pNatrasiejest] != 0)
					{
						MruMessageFail(playerid, "Ju¿ jesteœ w trasie!");
						comand_trasa_dialog_show(playerid);
						return 1;
					}

					StartBusRoute(playerid, listitem);
				}
				case 2,3,4: // trasa 96, 82, 85 od 2 skilla
				{
					if(PlayerInfo[playerid][pNatrasiejest] != 0)
					{
						MruMessageFail(playerid, "Ju¿ jesteœ w trasie!");
						comand_trasa_dialog_show(playerid);
						return 1;
					}

					if(GetPlayerJobSkill(playerid, JOB_DRIVER) < 2) 
					{
						MruMessageFail(playerid, "T¹ trasê mo¿esz wzi¹æ, gdy zdobêdziesz 2 skill kierowcy.");
						comand_trasa_dialog_show(playerid);
						return 1;
					}

					StartBusRoute(playerid, listitem);
				}
				case 5:
				{
					if(PlayerInfo[playerid][pNatrasiejest] == 0)
					{
						if( (GetPlayerJob(playerid) == JOB_DRIVER && PlayerInfo[playerid][pCarSkill] >= 400) || PlayerInfo[playerid][pMember] == 10 && PlayerInfo[playerid][pRank] >= 4 ||PlayerInfo[playerid][pLider] == 10)
						{
							Przystanek(playerid, COLOR_BLUE, "Wycieczka\nKoszt: 7500$\n Wiêcej informacji u kierowcy.");
							/*BusDrivers += 1; TransportDuty[playerid] = 2; TransportValue[playerid]= 15000;
							GetPlayerName(playerid,sendername,sizeof(sendername));
							format(string, sizeof(string), "Przewodnik %s zaprasza wszytkich na wycieczkê autobusow¹, koszt: $15000", sendername, TransportValue[playerid]);
							OOCNews(TEAM_GROVE_COLOR,string);*/
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, " Potrzebujesz 5skill lub 4 rangi aby organizowaæ wycieczki.");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, " Jesteœ ju¿ w trasie !");
					}
				}
				case 6:
				{
					if(GetPlayerJob(playerid) == JOB_DRIVER)
					{
						SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
						CP[playerid]=1201;
						PlayerInfo[playerid][pLinia55] = 0;
						PlayerInfo[playerid][pLinia72] = 0;
						PlayerInfo[playerid][pLinia82] = 0;
						PlayerInfo[playerid][pLinia96] = 0;
						PlayerInfo[playerid][pNatrasiejest] = 0;
						SendClientMessage(playerid, COLOR_YELLOW, " Rozpoczynasz zjazd do zajezdni, wskazuje j¹ sygna³ GPS. ");
						Przystanek(playerid, COLOR_BLUE, "Linia ZAJ \n Kierunek: Zajezdnia Commerce\n {808080}Zatrzymuje siê na przystankach");
						SendClientMessage(playerid, COLOR_ALLDEPT, " KT przypomina: {C0C0C0}Odstawiony do zajezdni autobus to szczêœliwy autobus :) ");
					}
					else if (PlayerInfo[playerid][pMember] == 10 ||PlayerInfo[playerid][pLider] == 10)
					{
						SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
						CP[playerid]=1200;
						PlayerInfo[playerid][pLinia55] = 0;
						PlayerInfo[playerid][pLinia72] = 0;
						PlayerInfo[playerid][pLinia82] = 0;
						PlayerInfo[playerid][pLinia96] = 0;
						PlayerInfo[playerid][pNatrasiejest] = 0;
						SendClientMessage(playerid, COLOR_YELLOW, " Rozpoczynasz zjazd do zajezdni, wskazuje j¹ sygna³ GPS. ");
						Przystanek(playerid, COLOR_BLUE, "Linia ZAJ \n Kierunek: Zajezdnia Ocean Docks\n {808080}Zatrzymuje siê na przystankach");
						SendClientMessage(playerid, COLOR_ALLDEPT, " LSBD przypomina: {C0C0C0}Odstawiony do zajezdni autobus to szczêœliwy autobus :) ");
					}
				}
				case 7:
				{
					SendClientMessage(playerid, COLOR_YELLOW, "|_____________Objaœnienia_____________|");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}500$/p {FFFFF0}- okreœla premiê za ka¿dy przystanek");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}5min{FFFFF0} - orientacyjny czas przejazdy ca³ej trasy (dwa okr¹¿enia)");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}13p{FFFFF0} - liczba przystanków na trasie");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}/businfo{FFFFF0} - wyœwietla informacje o systemie autobusów (w budowie)");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}/zakoncztrase{FFFFF0} - przerywa wykonywan¹ trasê i zmienia tablicê na domyœln¹");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}/zd{FFFFF0} - zamyka drzwi w autobusie i umo¿liwa dalsz¹ jazdê");
					SendClientMessage(playerid, COLOR_GREEN, "Wyp³atê za przejechane przystanki otrzymuje siê DOPIERO po przejechaniu ca³ej trasy!");
					SendClientMessage(playerid, COLOR_GREEN, "{FF00FF}PodpowiedŸ:{FFFFF0} najszybsze zarobki gwarantuje linia 72");
					SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD<<_____________|");
				}
			}
		}
		return 1;
	}
	return 0;
}


//end