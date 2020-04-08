//---------------------------------------------<< Callbacks >>-----------------------------------------------//
//                                                  pojazdy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	System pojazdów.
*/

//
#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
pojazdy_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 31)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					KolorPierwszy[playerid] = 0;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 1:
				{
					KolorPierwszy[playerid] = 1;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 2:
				{
					KolorPierwszy[playerid] = 2;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 3:
				{
					KolorPierwszy[playerid] = 3;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 4:
				{
					KolorPierwszy[playerid] = 4;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 5:
				{
					KolorPierwszy[playerid] = 126;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 6:
				{
					KolorPierwszy[playerid] = 6;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 7:
				{
					KolorPierwszy[playerid] = 7;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 8:
				{
					KolorPierwszy[playerid] = 8;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 9:
				{
					KolorPierwszy[playerid] = 42;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 10:
				{
					KolorPierwszy[playerid] = 16;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 11:
				{
					KolorPierwszy[playerid] = 20;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 35, DIALOG_STYLE_INPUT, "Wybierz Kolor 1", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "WyjdŸ");
				}
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 32)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 0, CenaPojazdu[playerid]);
				}
				case 1:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 1, CenaPojazdu[playerid]);
				}
				case 2:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 2, CenaPojazdu[playerid]);
				}
				case 3:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 3, CenaPojazdu[playerid]);
				}
				case 4:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 4, CenaPojazdu[playerid]);
				}
				case 5:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 126, CenaPojazdu[playerid]);
				}
				case 6:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 6, CenaPojazdu[playerid]);
				}
				case 7:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 7, CenaPojazdu[playerid]);
				}
				case 8:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 8, CenaPojazdu[playerid]);
				}
				case 9:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 42, CenaPojazdu[playerid]);
				}
				case 10:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 16, CenaPojazdu[playerid]);
				}
				case 11:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 20, CenaPojazdu[playerid]);
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "WyjdŸ");
				}
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 33)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					KolorPierwszy[playerid] = 0;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 1:
				{
					KolorPierwszy[playerid] = 1;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 2:
				{
					KolorPierwszy[playerid] = 2;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 3:
				{
					KolorPierwszy[playerid] = 3;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 4:
				{
					KolorPierwszy[playerid] = 4;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 5:
				{
					KolorPierwszy[playerid] = 126;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 6:
				{
					KolorPierwszy[playerid] = 6;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 7:
				{
					KolorPierwszy[playerid] = 7;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 8:
				{
					KolorPierwszy[playerid] = 8;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 9:
				{
					KolorPierwszy[playerid] = 42;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 10:
				{
					KolorPierwszy[playerid] = 16;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 11:
				{
					KolorPierwszy[playerid] = 20;
					ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 37, DIALOG_STYLE_INPUT, "Wybierz Kolor 1", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "WyjdŸ");
				}
			}
		}
	}
	else if(dialogid == 34)
	{
		if(response)
		{
			new veh = GetPlayerVehicleID(playerid);
			switch(listitem)
			{
				case 0..8:
				{
					if(IsCarOwner(playerid, veh))
					{
						ChangeVehicleColor(veh, KolorPierwszy[playerid], listitem);
						MRP_ChangeVehicleColor(veh, KolorPierwszy[playerid], listitem);
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd przemalowany! -1500$");
						ZabierzKase(playerid, 1500);
					}
				}
				case 9:
				{
					if(IsCarOwner(playerid, veh))
					{
						ChangeVehicleColor(veh, KolorPierwszy[playerid], 42);
						MRP_ChangeVehicleColor(veh, KolorPierwszy[playerid], listitem);
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd przemalowany! -1500$");
						ZabierzKase(playerid, 1500);
					}
				}
				case 10:
				{
					if(IsCarOwner(playerid, veh))
					{
						ChangeVehicleColor(veh, KolorPierwszy[playerid], 16);
						MRP_ChangeVehicleColor(veh, KolorPierwszy[playerid], listitem);
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd przemalowany! -1500$");
						ZabierzKase(playerid, 1500);
					}
				}
				case 11:
				{
					if(IsCarOwner(playerid, veh))
					{
						ChangeVehicleColor(veh, KolorPierwszy[playerid], 20);
						MRP_ChangeVehicleColor(veh, KolorPierwszy[playerid], listitem);
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd przemalowany! -1500$");
						ZabierzKase(playerid, 1500);
					}
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 38, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "WyjdŸ");
				}
			}
		}
		if(!response)
		{
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 36)
	{
		if(response)
		{
			if(strval(inputtext) > 0 &&  strval(inputtext) < 255)
			{
				KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], strval(inputtext), CenaPojazdu[playerid]);
			}
			else
			{
				ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 255)", "Wybierz", "WyjdŸ");
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 37)
	{
		if(response)
		{
			if(strval(inputtext) > 0 &&  strval(inputtext) < 255)
			{
				KolorPierwszy[playerid] = strval(inputtext);
				ShowPlayerDialogEx(playerid, 34, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
			}
			else
			{
				ShowPlayerDialogEx(playerid, 37, DIALOG_STYLE_INPUT, "Wybierz Kolor 1", "Wpisz numer koloru (od 0 do 255)", "Wybierz", "WyjdŸ");
			}
		}
		if(!response)
		{
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 38)
	{
		if(response)
		{
			if(strval(inputtext) > 0 &&  strval(inputtext) < 255)
			{
				new veh = GetPlayerVehicleID(playerid);
				if(IsCarOwner(playerid, veh))
				{
					ChangeVehicleColor(veh, KolorPierwszy[playerid], strval(inputtext));
					MRP_ChangeVehicleColor(veh, KolorPierwszy[playerid], strval(inputtext));
					SendClientMessage(playerid, 0xFFC0CB, "Pojazd przemalowany! -1500$");
					ZabierzKase(playerid, 1500);
				}
			}
			else
			{
				ShowPlayerDialogEx(playerid, 38, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "WyjdŸ");
			}
		}
		if(!response)
		{
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 303)
	{
		if(response)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				if(!IsCarOwner(playerid, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale¿y do Ciebie.");

				new vehicleid = GetPlayerVehicleID(playerid);
				new giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				Log(payLog, INFO, "%s zez³omowa³ auto %s i dosta³ 5000$", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid));
				RemovePlayerFromVehicleEx(playerid);
				ClearAnimations(playerid);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);

				for(new i=0;i<MAX_CAR_SLOT;i++)
				{
					if(PlayerInfo[playerid][pCars][i] == VehicleUID[vehicleid][vUID])
						PlayerInfo[playerid][pCars][i] = 0;
				}
				Car_Destroy(VehicleUID[vehicleid][vUID]);

				DajKase(playerid, 5000);
				SendClientMessage(playerid, COLOR_YELLOW, "Auto zez³omowane, dostajesz 5000$");
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Wsi¹dŸ do pojazdu pojazdu");
			}
		}
	}
	//System ³odzi
	else if(dialogid == 400)//System ³odzi - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Ponton
				{
					ShowPlayerDialogEx(playerid, 402, DIALOG_STYLE_MSGBOX, "Kupowanie Pontonu", "Ponton\n\nCena: 2.250.000$\nPrêdkoœæ Maksymalna: 120km/h\nWielkosc: Ma³y\nOpis: Ma³y, zwrotny oraz szybki ponton. Idealny do emocjonalnego p³ywania po morzu. Jego cena jest przyjazna dla pocz¹tkuj¹cych ¿eglarzy. W 2 kolorach.", "Kup!", "Wróæ");
					pojazdid[playerid] = 473;
					CenaPojazdu[playerid] = 2250000;
				}
				case 1://Kuter
				{
					ShowPlayerDialogEx(playerid, 401, DIALOG_STYLE_MSGBOX, "Kupowanie Kutra", "Kuter\n\nCena: 3.700.000$\nPrêdkoœæ Maksymalna: 70km/h\nWielkosc: Spory\nOpis: Jest to wolna oraz ma³o zwrotna ³ódŸ. Idealnie nadaje siê do ³owienia ryb. Pok³ad czêœciowo zadaszony, reszta otwarta. Dostêpny w 1 kolorze.", "Kup!", "Wróæ");
					pojazdid[playerid] = 453;
					CenaPojazdu[playerid] = 3700000;
				}
				case 2://Coastguard
				{
					ShowPlayerDialogEx(playerid, 403, DIALOG_STYLE_MSGBOX, "Kupowanie Coastguarda", "Coastguard\n\nCena: 8.500.000$\nPrêdkoœæ Maksymalna: 160km/h\nWielkosc: Œredni\nOpis: Dosyæ szybkki oraz zwrotny statek. Nie jest zadaszony, pok³ad jest pod³u¿ny. U¿ywany przez ratowników. Malowany na 2 kolory.", "Kup!", "Wróæ");
					pojazdid[playerid] = 472;
					CenaPojazdu[playerid] = 8500000;
				}
				case 3://Launch
				{
					ShowPlayerDialogEx(playerid, 404, DIALOG_STYLE_MSGBOX, "Kupowanie Launcha", "Launch\n\nCena: 11.000.000$\nPrêdkoœæ Maksymalna: 150km/h\nWielkosc: Œredni\nOpis: £ódŸ bojowa, u¿ywana przez wojsko, ma pod³u¿ny kad³ub. Dostêpna jest wersja cywilna z atrap¹ karabinu. Nie jest zbyt zwrotna i szybka, ale ma walory bojowe. Zadaszona przednia czêœæ. Malowana w 1 kolorze.", "Kup!", "Wróæ");
					pojazdid[playerid] = 595;
					CenaPojazdu[playerid] = 11000000;
				}
				case 4://Speeder
				{
					ShowPlayerDialogEx(playerid, 405, DIALOG_STYLE_MSGBOX, "Kupowanie Speedera", "Speeder\n\nCena: 13.500.000$\nPrêdkoœæ Maksymalna: 220km/h\nWielkosc: Œredni\nOpis: Typowa motorówka: smuk³a, du¿e przyspieszenie i prêdkoœæ. Jej zwrotnoœæ nie jest zachwycaj¹ca ale powinna zadowoliæ wiêkszoœæ u¿ytkowników. Malowana w 1 kolorze.", "Kup!", "Wróæ");
					pojazdid[playerid] = 452;
					CenaPojazdu[playerid] = 13500000;
				}
				case 5://Jetmax
				{
					ShowPlayerDialogEx(playerid, 407, DIALOG_STYLE_MSGBOX, "Kupowanie Jetmaxa", "Jetmax\n\nCena: 20.000.000$\nPrêdkoœæ Maksymalna: 220km/h\nWielkosc: Spory\nOpis: Motorówka wyœcigowa, stworzona do du¿ych prêdkoœci. Jej cecha charakterystyczna to ogromny silnik wystaj¹cy z ty³u ³odzi. Malowana w 2 kolorach.", "Kup!", "Wróæ");
					pojazdid[playerid] = 493;
					CenaPojazdu[playerid] = 20000000;
				}
				case 6://Tropic
				{
					ShowPlayerDialogEx(playerid, 406, DIALOG_STYLE_MSGBOX, "Kupowanie Tropica", "Speeder\n\nCena: 25.000.000$\nPrêdkoœæ Maksymalna: 160km/h\nWielkosc: Du¿y\nOpis: Luksusowy jacht wycieczkowy. Posiada dwa piêtra, miejsce mieszkalne i dach. Nie jest zwrotny ale szybki. Idealny dla bogaczy.", "Kup!", "Wróæ");
					pojazdid[playerid] = 454;
					CenaPojazdu[playerid] = 25000000;
				}
				case 7://Squallo
				{
					ShowPlayerDialogEx(playerid, 408, DIALOG_STYLE_MSGBOX, "Kupowanie Squallo", "Squallo\n\nCena: 25.000.000$\nPrêdkoœæ Maksymalna: 260km/h\nWielkosc: Spory\nOpis: Motorówka luksusowo wyœcigowa. Jej prêdkoœæ jest nieprzyzwoicie du¿a a wygl¹d i luksus sprawi¹ ¿e bêdzie siê czu³ jak prawdziwy bogacz. Malowana w 2 kolorach.", "Kup!", "Wróæ");
					pojazdid[playerid] = 446;
					CenaPojazdu[playerid] = 25000000;
				}
				case 8://Jacht
				{
					ShowPlayerDialogEx(playerid, 409, DIALOG_STYLE_MSGBOX, "Kupowanie Jachtu", "Jacht\n\nCena: 40.000.000$\nPrêdkoœæ Maksymalna: 80km/h\nWielkosc: Wielki\nOpis: Jacht to statek dla ludzi którzy wyprawiaj¹ siê w miêdzykontynentaln¹ przeprawê oraz pragn¹ luksusu. Mo¿na w nim spaæ i normalnie gdy¿ posiada spore wnêtrze. Malowany w 2 kolorach.\n((UWAGA! Pojazd posiada wnêtrze do którego mo¿na wchodziæ komend¹ /wejdzw))", "Kup!", "Wróæ");
					pojazdid[playerid] = 484;
					CenaPojazdu[playerid] = 40000000;
				}
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid >= 401 && dialogid <= 409)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranej ³odzi");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 400, DIALOG_STYLE_LIST, "Kupowanie ³odzi", "Ponton\t\t2 250 000$\nKuter\t\t3 700 000$\nCoastguard\t8 500 000$\nLaunch\t\t11 000 000$\nSpeeder\t13 500 000$\nJetmax\t\t20 000 000$\nTropic\t\t25 000 000$\nSquallo\t\t25 000 000$\nJacht\t\t40 000 000$", "Wybierz", "WyjdŸ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 410)//System samolotów - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Dodo
				{
					ShowPlayerDialogEx(playerid, 411, DIALOG_STYLE_MSGBOX, "Kupowanie Dodo", "Dodo\n\nCena: 30.000.000$\nPrêdkoœæ lotu poziomego: 150km/h\nWielkosc: Ma³y\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 593;
					CenaPojazdu[playerid] = 30000000;
				}
				case 1://Cropduster
				{
					ShowPlayerDialogEx(playerid, 412, DIALOG_STYLE_MSGBOX, "Kupowanie Cropdustera", "Cropduster\n\nCena: 35.000.000$\nPrêdkoœæ lotu poziomego: 140km/h\nWielkosc: Œredni\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 512;
					CenaPojazdu[playerid] = 35000000;
				}
				case 2://Beagle
				{
					ShowPlayerDialogEx(playerid, 413, DIALOG_STYLE_MSGBOX, "Kupowanie Beagle", "Beagle\n\nCena: 170.000.000$\nPrêdkoœæ lotu poziomego: 160km/h\nWielkosc: Spory\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 511;
					CenaPojazdu[playerid] = 170000000;
				}
				case 3://Stuntplane
				{
					ShowPlayerDialogEx(playerid, 414, DIALOG_STYLE_MSGBOX, "Kupowanie Stuntplane", "Stuntplane\n\nCena: 185.000.000$\nPrêdkoœæ lotu poziomego: 190km/h\nWielkosc: Ma³y\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 513;
					CenaPojazdu[playerid] = 185000000;
				}
				case 4://Nevada
				{
					ShowPlayerDialogEx(playerid, 415, DIALOG_STYLE_MSGBOX, "Kupowanie Nevady", "Nevada\n\nCena: 280.000.000$\nPrêdkoœæ lotu poziomego: 205km/h\nWielkosc: Du¿y\nOpis: ((UWAGA! Pojazd posiada wnêtrze do którego mo¿na wchodziæ komend¹ /wejdzw))", "Kup!", "Wróæ");
					pojazdid[playerid] = 553;
					CenaPojazdu[playerid] = 280000000;
				}
				case 5://Shamal
				{
					ShowPlayerDialogEx(playerid, 416, DIALOG_STYLE_MSGBOX, "Kupowanie Shamala", "Shamal\n\nCena: 515.250.000$\nPrêdkoœæ lotu poziomego: 300km/h\nWielkosc: Du¿y\nOpis: Odrzutowiec ((UWAGA! Pojazd posiada wnêtrze do którego mo¿na wchodziæ komend¹ /wejdzw))", "Kup!", "Wróæ");
					pojazdid[playerid] = 519;
					CenaPojazdu[playerid] = 515250000;
				}
				/*case 6://Wodolotu
				{
					ShowPlayerDialogEx(playerid, 417, DIALOG_STYLE_MSGBOX, "Kupowanie XXXXXXXXXX", "XXXXXXXXXX\n\nCena: .000.000$\nPrêdkoœæ lotu poziomego: km/h\nWielkosc: \nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = xXx;
					CenaPojazdu[playerid] = OOOOOOOOOOOOOOOOO;
				}*/
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid >= 411 && dialogid <= 417)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego samolotu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 410, DIALOG_STYLE_LIST, "Kupowanie samolotu", "Dodo\t\t50 000 000$\nCropduster\t35 000 000$\nBeagle\t\t170 000 000$\nStuntplane\t185 000 000$\nNevada\t\t280 000 000$\nShamal\t\t515 250 000$", "Wybierz", "WyjdŸ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 420)//System helikopterów - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Sparrow
				{
					ShowPlayerDialogEx(playerid, 421, DIALOG_STYLE_MSGBOX, "Kupowanie Sparrowa", "Sparrow\n\nCena: 125.000.000$\nŒrednia prêdkoœæ lotu: 160km/h\nWielkosc: Ma³y\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 469;
					CenaPojazdu[playerid] = 125000000;
				}
				case 1://Maverick
				{
					ShowPlayerDialogEx(playerid, 422, DIALOG_STYLE_MSGBOX, "Kupowanie Mavericka", "Maverick\n\nCena: 200.000.000$\nŒrednia prêdkoœæ lotu: 180km/h\nWielkosc: Œredni\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 487;
					CenaPojazdu[playerid] = 200000000;
				}
				case 2://Leviathan
				{
					ShowPlayerDialogEx(playerid, 423, DIALOG_STYLE_MSGBOX, "Kupowanie Leviathana", "Leviathan\n\nCena: 265.000.000$\nŒrednia prêdkoœæ lotu: 130km/h\nWielkosc: Du¿y\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 417;
					CenaPojazdu[playerid] = 265000000;
				}
				case 3://Raindance
				{
					ShowPlayerDialogEx(playerid, 424, DIALOG_STYLE_MSGBOX, "Kupowanie Raindance", "Raindance\n\nCena: 325.000.000$\nŒrednia prêdkoœæ lotu: 100km/h\nWielkosc: Spory\nOpis:", "Kup!", "Wróæ");
					pojazdid[playerid] = 563;
					CenaPojazdu[playerid] = 325000000;
				}
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid >= 421 && dialogid <= 424)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego helikopteru");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 420, DIALOG_STYLE_LIST, "Kupowanie Helikopteru", "Sparrow\t\t125 000 000$\nMaverick\t\t200 000 000$\nLeviathan\t\t265 000 000$\nRaindance\t\t325 000 000$", "Wybierz", "WyjdŸ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 440)//SYSTEM AUT - kategorie
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 450, DIALOG_STYLE_LIST, 
						"Samochody sportowe", 
						"Turismo 10kk\nInfernus 12,5mln\nBullet 8mln\nSuper GT 7,5mln\nCheetah 7mln\nBanshee 6mln\nComet 5mln\n" \
						"Buffalo 3mln\nZR-350 2,5mln\nPhoenix 750tys\nEuros 4mln\nSultan 5mln\nJester 4,5mln\nElegy 4mln\n" \
						"Uranus 3,25mln\nAlpha 900tys\nFlash 3,52mln\nHotknife 1,3mln", 
						"Wybierz", "Wróæ"
					);
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 451, DIALOG_STYLE_LIST, 
						"Samochody osobowe", 
						"Bravura 160tys\nManana 180tys\nEsperanto 200tys\nPremier 280tys\nPrevion 150tys\nNebula 320tys\n" \
						"Solair 350tys\nGlendale 280tys\nOceanic 340tys\nHermes 275tys\nSabre 300tys\nRegina 375tys\n" \
						"Greenwood 275tys\nBlista Compact 500tys\nMajestic 250tys\nBuccaneer 140tys\nFortune 400tys\n" \
						"Cadrona 375tys\nWillard 340tys\nIntruder 385tys\nPrimo 340tys\nTahoma 390tys\nEmperor 230k\nClub 700tys\nSurnise", 
						"Wybierz", "Wróæ"
					);
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 452, DIALOG_STYLE_LIST, 
						"Samochody luksusowe", 
						"Limuzyna 5mln\nVirgo 680tys\nWashington 750tys\nStafford 1,8mln\nSentiniel 600tys\nAdmiral 860tys\n" \
						"Elegant 750tys\nMerit 500tys\nStratum 2,85mln\nVincent 700tys", 
						"Wybierz", "Wróæ"
					);
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 453, DIALOG_STYLE_LIST, 
						"Samochody terenowe", 
						"Rancher 600tys\nHuntley 350tys\nLandstalker 200tys\nMesa 700tys\nBF Injection 800tys\nHummer 7mln", 
						"Wybierz", "Wróæ"
					);
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 454, DIALOG_STYLE_LIST, 
						"Pick-up`y", 
						"Yosemite 350tys\nBobcat 160tys\nPicador 220tys\nSadler 180tys\nWalton 80tys\nSlamvan 4,5mln", 
						"Wybierz", "Wróæ"
					);
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 455, DIALOG_STYLE_LIST, 
						"Kabriolety", 
						"Comet 5mln\nWindsor 5,5mln\nFeltzer 1,4mln\nStalion 250tys", 
						"Wybierz", "Wróæ"
					);
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 456, DIALOG_STYLE_LIST, 
						"Lowridery", 
						"Blade 1,28mln\nSavanna 1,33mln\nRemington 1,4mln\nTornado 1,23mln\nVoodoo 1,22mln\nBroadway 1,21mln", 
						"Wybierz", "Wróæ"
					);
				}
				case 7:
				{
					ShowPlayerDialogEx(playerid, 457, DIALOG_STYLE_LIST, 
						"Na ka¿d¹ kieszeñ", 
						"Clover 45tys\nTampa 40tys\nPerenniel 60tys\nGlendale(obity) 28tys\nSadler(obity) 25tys\nTurbowózek œmiesznie tanio\nSkuter 17tys", 
						"Wybierz", "Wróæ"
					);
				}
				case 8:
				{
					ShowPlayerDialogEx(playerid, 458, DIALOG_STYLE_LIST, 
						"Jednoœlady", 
						"NRG-500 11,5mln\nFCR-900 8mln\nBF-400 4,5mln\nFreeway 900tys\nWayfarer 750tys\nSanchez 1,5mln\nQuad 600tys\nFaggio 17tys", 
						"Wybierz", "Wróæ"
					);
				}
				case 9:
				{
					ShowPlayerDialogEx(playerid, 459, DIALOG_STYLE_LIST, 
						"Inne pojazdy", 
						"Burrito 350tys\nBandito 1,3mln\nHotknife 1,3mln\nCamper 350tys\nKamping 700tys\nHustler 550tys", 
						"Wybierz", "Wróæ"
					);
				}
			}
		}
	}
	else if(dialogid == 443)
	{
		if(response)
		{
			new lUID = PlayerInfo[playerid][pKluczeAuta];
			if(lUID == 0) return 1;

			new idx = Car_GetIDXFromUID(lUID);
			if(idx == -1) return 1;
			if(CarData[idx][c_Keys] != PlayerInfo[playerid][pUID])
			{
				SendClientMessage(playerid, COLOR_NEWS, "Kluczyki od tego pojazdu zosta³y zabrane przez w³aœciciela.");
				PlayerInfo[playerid][pKluczeAuta] = 0;
				return 1;
			}
			switch(listitem)
			{
				case 0://spawnuj kluczyki - tu jest bug?
				{
					if(CarData[idx][c_ID] != 0)
					{
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd do którego masz kluczyki jest ju¿ zespawnowany");
						return 1;
					}
					Car_Spawn(idx);
					Log(serverLog, INFO, "Gracz %s zespawnowa³ pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(idx));
					SendClientMessage(playerid, 0xFFC0CB, "Twój pojazd zosta³ zrespawnowany");
					
				}
				case 1://ZnajdŸ
				{
					new Float:autox, Float:autoy, Float:autoz;
					new pojazdszukany = CarData[idx][c_ID];
					if(pojazdszukany == 0) return 1;
					GetVehiclePos(pojazdszukany, autox, autoy, autoz);
					SetPlayerCheckpoint(playerid, autox, autoy, autoz, 6);
					SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
					SendClientMessage(playerid, 0xFFC0CB, "JedŸ do czerwonego markera");

				}
				case 2://Poka¿ parking
				{
					SetPlayerCheckpoint(playerid, CarData[idx][c_Pos][0],CarData[idx][c_Pos][1],CarData[idx][c_Pos][2], 6);
					SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
					SendClientMessage(playerid, 0xFFC0CB, "JedŸ do czerwonego markera");

				}
			}
		}
	}
	else if(dialogid == 450)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4001, DIALOG_STYLE_MSGBOX, "Kupowanie Turismo", "Turismo\n\nCena: 10.000.000$\nPrêdkoœæ Maksymalna: 240km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 451;
					CenaPojazdu[playerid] = 10000000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4001, DIALOG_STYLE_MSGBOX, "Kupowanie Infernusa", "Infernus\n\nCena: 12.500.000$\nPrêdkoœæ Maksymalna: 240km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 411;
					CenaPojazdu[playerid] = 12500000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4002, DIALOG_STYLE_MSGBOX, "Kupowanie Bulleta", "Bullet\n\nCena: 8.000.000$\nPrêdkoœæ Maksymalna: 230km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 541;
					CenaPojazdu[playerid] = 8000000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4003, DIALOG_STYLE_MSGBOX, "Kupowanie Super GT", "Super GT\n\nCena: 7.500.000$\nPrêdkoœæ Maksymalna: 230km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 506;
					CenaPojazdu[playerid] = 7500000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4004, DIALOG_STYLE_MSGBOX, "Kupowanie Cheetah", "Cheetah\n\nCena: 7.000.000$\nPrêdkoœæ Maksymalna: 230km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 415;
					CenaPojazdu[playerid] = 7000000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4005, DIALOG_STYLE_MSGBOX, "Kupowanie Banshee", "Banshee\n\nCena: 6.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 429;
					CenaPojazdu[playerid] = 6000000;
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 4006, DIALOG_STYLE_MSGBOX, "Kupowanie Cometa", "Comet\n\nCena: 5.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 480;
					CenaPojazdu[playerid] = 5000000;
				}
				case 7:
				{
					ShowPlayerDialogEx(playerid, 4007, DIALOG_STYLE_MSGBOX, "Kupowanie Buffalo", "Buffalo\n\nCena: 3.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 402;
					CenaPojazdu[playerid] = 3000000;
				}
				case 8:
				{
					ShowPlayerDialogEx(playerid, 4008, DIALOG_STYLE_MSGBOX, "Kupowanie ZR-350", "ZR-350\n\nCena: 2.500.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 477;
					CenaPojazdu[playerid] = 2500000;
				}
				case 9:
				{
					ShowPlayerDialogEx(playerid, 4009, DIALOG_STYLE_MSGBOX, "Kupowanie Phoenixa", "Phoenix\n\nCena: 750.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 603;
					CenaPojazdu[playerid] = 750000;
				}
				case 10:
				{
					ShowPlayerDialogEx(playerid, 4010, DIALOG_STYLE_MSGBOX, "Kupowanie Eurosa", "Euros\n\nCena: 4.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 587;
					CenaPojazdu[playerid] = 4000000;
				}
				case 11:
				{
					ShowPlayerDialogEx(playerid, 4011, DIALOG_STYLE_MSGBOX, "Kupowanie Sultana", "Sultan\n\nCena: 5.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 560;
					CenaPojazdu[playerid] = 5000000;
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 4012, DIALOG_STYLE_MSGBOX, "Kupowanie Jestera", "Jester\n\nCena: 4.500.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 559;
					CenaPojazdu[playerid] = 4500000;
				}
				case 13:
				{
					ShowPlayerDialogEx(playerid, 4013, DIALOG_STYLE_MSGBOX, "Kupowanie Elegy", "Elegy\n\nCena: 4.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 562;
					CenaPojazdu[playerid] = 4000000;
				}
				case 14:
				{
					ShowPlayerDialogEx(playerid, 4014, DIALOG_STYLE_MSGBOX, "Kupowanie Uranusa", "Uranus\n\nCena: 3.250.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 558;
					CenaPojazdu[playerid] = 3250000;
				}
				case 15:
				{
					ShowPlayerDialogEx(playerid, 4015, DIALOG_STYLE_MSGBOX, "Kupowanie Aplha", "Alpha\n\nCena: 900.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 602;
					CenaPojazdu[playerid] = 900000;
				}
				case 16:
				{
					ShowPlayerDialogEx(playerid, 4016, DIALOG_STYLE_MSGBOX, "Kupowanie Flasha", "Flash\n\nCena: 3.520.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 565;
					CenaPojazdu[playerid] = 3520000;
				}
				case 17:
				{
					ShowPlayerDialogEx(playerid, 4017, DIALOG_STYLE_MSGBOX, "Kupowanie Hotknife", "Hotknife\n\nCena: 1.300.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 434;
					CenaPojazdu[playerid] = 1300000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 451)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4100, DIALOG_STYLE_MSGBOX, "Kupowanie Bravury", "Bravura\n\nCena: 160.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 401;
					CenaPojazdu[playerid] = 160000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4101, DIALOG_STYLE_MSGBOX, "Kupowanie Manany", "Manana\n\nCena: 180.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 410;
					CenaPojazdu[playerid] = 180000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4102, DIALOG_STYLE_MSGBOX, "Kupowanie Esperanto", "Esperanto\n\nCena: 200.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 419;
					CenaPojazdu[playerid] = 200000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4103, DIALOG_STYLE_MSGBOX, "Kupowanie Premiera", "Premier\n\nCena: 280.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 426;
					CenaPojazdu[playerid] = 280000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4104, DIALOG_STYLE_MSGBOX, "Kupowanie Previona", "Previon\n\nCena: 150.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 436;
					CenaPojazdu[playerid] = 150000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4105, DIALOG_STYLE_MSGBOX, "Kupowanie Nebuli", "Nebula\n\nCena: 320.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 516;
					CenaPojazdu[playerid] = 320000;
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 4106, DIALOG_STYLE_MSGBOX, "Kupowanie Solair", "Solair\n\nCena: 350.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 458;
					CenaPojazdu[playerid] = 350000;
				}
				case 7:
				{
					ShowPlayerDialogEx(playerid, 4107, DIALOG_STYLE_MSGBOX, "Kupowanie Glendale", "Glendale\n\nCena: 280.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 466;
					CenaPojazdu[playerid] = 280000;
				}
				case 8:
				{
					ShowPlayerDialogEx(playerid, 4108, DIALOG_STYLE_MSGBOX, "Kupowanie Oceanic", "Oceanic\n\nCena: 340.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 467;
					CenaPojazdu[playerid] = 340000;
				}
				case 9:
				{
					ShowPlayerDialogEx(playerid, 4109, DIALOG_STYLE_MSGBOX, "Kupowanie Hermesa", "Hermes\n\nCena: 275.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 474;
					CenaPojazdu[playerid] = 275000;
				}
				case 10:
				{
					ShowPlayerDialogEx(playerid, 4110, DIALOG_STYLE_MSGBOX, "Kupowanie Sabre", "Sabre\n\nCena: 300.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 475;
					CenaPojazdu[playerid] = 300000;
				}
				case 11:
				{
					ShowPlayerDialogEx(playerid, 4111, DIALOG_STYLE_MSGBOX, "Kupowanie Reginy", "Regina\n\nCena: 375.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 479;
					CenaPojazdu[playerid] = 375000;
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 4112, DIALOG_STYLE_MSGBOX, "Kupowanie Greenwooda", "Greenwood\n\nCena: 275.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 492;
					CenaPojazdu[playerid] = 275000;
				}
				case 13:
				{
					ShowPlayerDialogEx(playerid, 4113, DIALOG_STYLE_MSGBOX, "Kupowanie Blisty", "Blista Compact\n\nCena: 500.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 496;
					CenaPojazdu[playerid] = 500000;
				}
				case 14:
				{
					ShowPlayerDialogEx(playerid, 4114, DIALOG_STYLE_MSGBOX, "Kupowanie Majestica", "Majestic\n\nCena: 250.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 517;
					CenaPojazdu[playerid] = 250000;
				}
				case 15:
				{
					ShowPlayerDialogEx(playerid, 4115, DIALOG_STYLE_MSGBOX, "Kupowanie Buccaneera", "Buccaneer\n\nCena: 140.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 518;
					CenaPojazdu[playerid] = 140000;
				}
				case 16:
				{
					ShowPlayerDialogEx(playerid, 4116, DIALOG_STYLE_MSGBOX, "Kupowanie Fortune", "Fortune\n\nCena: 400.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 526;
					CenaPojazdu[playerid] = 400000;
				}
				case 17:
				{
					ShowPlayerDialogEx(playerid, 4117, DIALOG_STYLE_MSGBOX, "Kupowanie Cadrony", "Cadrona\n\nCena: 375.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 527;
					CenaPojazdu[playerid] = 375000;
				}
				case 18:
				{
					ShowPlayerDialogEx(playerid, 4118, DIALOG_STYLE_MSGBOX, "Kupowanie Willarda", "Willard\n\nCena: 340.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 529;
					CenaPojazdu[playerid] = 340000;
				}
				case 19:
				{
					ShowPlayerDialogEx(playerid, 4119, DIALOG_STYLE_MSGBOX, "Kupowanie Intrudera", "Intruder\n\nCena: 385.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 546;
					CenaPojazdu[playerid] = 385000;
				}
				case 20:
				{
					ShowPlayerDialogEx(playerid, 4120, DIALOG_STYLE_MSGBOX, "Kupowanie Primo", "Primo\n\nCena: 340.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 547;
					CenaPojazdu[playerid] = 340000;
				}
				case 21:
				{
					ShowPlayerDialogEx(playerid, 4121, DIALOG_STYLE_MSGBOX, "Kupowanie Tahomy", "Tahoma\n\nCena: 390.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 566;
					CenaPojazdu[playerid] = 390000;
				}
				case 22:
				{
					ShowPlayerDialogEx(playerid, 4122, DIALOG_STYLE_MSGBOX, "Kupowanie Emperora", "Emperor\n\nCena: 230.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 585;
					CenaPojazdu[playerid] = 230000;
				}
				case 23:
				{
					ShowPlayerDialogEx(playerid, 4123, DIALOG_STYLE_MSGBOX, "Kupowanie Cluba", "Club\n\nCena: 700.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 589;
					CenaPojazdu[playerid] = 700000;
				}
				case 24:
				{
					ShowPlayerDialogEx(playerid, 4124, DIALOG_STYLE_MSGBOX, "Kupowanie Surnise", "Surnise\n\nCena: 395.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 550;
					CenaPojazdu[playerid] = 395000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 452)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4200, DIALOG_STYLE_MSGBOX, "Kupowanie Limuzyny", "Limuzyna\n\nCena: 5.000.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 4\nOpis: Pojazd posiada wnêtrze do którego mo¿na \n\t wchodziæ i wychodziæ komend¹ /wejdzw", "Kup!", "Wróæ");
					pojazdid[playerid] = 409;
					CenaPojazdu[playerid] = 5000000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4201, DIALOG_STYLE_MSGBOX, "Kupowanie Virgo", "Virgo\n\nCena: 680.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 491;
					CenaPojazdu[playerid] = 680000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4203, DIALOG_STYLE_MSGBOX, "Kupowanie Washington", "Washington\n\nCena: 750.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 421;
					CenaPojazdu[playerid] = 750000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4203, DIALOG_STYLE_MSGBOX, "Kupowanie Stafforda", "Stafford\n\nCena: 1.800.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 580;
					CenaPojazdu[playerid] = 1800000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4204, DIALOG_STYLE_MSGBOX, "Kupowanie Sentinela", "Sentinel\n\nCena: 600.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 405;
					CenaPojazdu[playerid] = 600000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4205, DIALOG_STYLE_MSGBOX, "Kupowanie Admirala", "Admiral\n\nCena: 800.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 445;
					CenaPojazdu[playerid] = 800000;
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 4206, DIALOG_STYLE_MSGBOX, "Kupowanie Eleganta", "Elegant\n\nCena: 750.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 507;
					CenaPojazdu[playerid] = 750000;
				}
				case 7:
				{
					ShowPlayerDialogEx(playerid, 4207, DIALOG_STYLE_MSGBOX, "Kupowanie Merita", "Merit\n\nCena: 500.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 551;
					CenaPojazdu[playerid] = 500000;
				}
				case 8:
				{
					ShowPlayerDialogEx(playerid, 4208, DIALOG_STYLE_MSGBOX, "Kupowanie Stratuma", "Stratum\n\nCena: 2.850.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 561;
					CenaPojazdu[playerid] = 2850000;
				}
				case 9:
				{
					ShowPlayerDialogEx(playerid, 4209, DIALOG_STYLE_MSGBOX, "Kupowanie Vincenta", "Vincent\n\nCena: 700.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 540;
					CenaPojazdu[playerid] = 700000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 453)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4300, DIALOG_STYLE_MSGBOX, "Kupowanie Ranchera", "Rancher\n\nCena: 600.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 489;
					CenaPojazdu[playerid] = 600000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4301, DIALOG_STYLE_MSGBOX, "Kupowanie Huntleya", "Huntley\n\nCena: 350.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 579;
					CenaPojazdu[playerid] = 350000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4302, DIALOG_STYLE_MSGBOX, "Kupowanie Landstalkera", "Landstalker\n\nCena: 200.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 400;
					CenaPojazdu[playerid] = 200000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4302, DIALOG_STYLE_MSGBOX, "Kupowanie Mesy", "Mesa\n\nCena: 700.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 500;
					CenaPojazdu[playerid] = 700000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4303, DIALOG_STYLE_MSGBOX, "Kupowanie BF Injection", "BF Injection\n\nCena: 800.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Najlepszy do lansowania siê na pla¿y", "Kup!", "Wróæ");
					pojazdid[playerid] = 424;
					CenaPojazdu[playerid] = 800000;
				}
				/*=========[ZABLOKOWANO Z POWODU NADU¯YÆ POJAZDU - 18-02-2019]=============
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4304, DIALOG_STYLE_MSGBOX, "Kupowanie Sandkinga", "Sandking\n\nCena: 4.000.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 2\nOpis: Sportowy wóz terenowy, kolory raczej ciemne.\nPrzejedzie przez ka¿d¹ przeszkodê!", "Kup!", "Wróæ");
					pojazdid[playerid] = 495;
					CenaPojazdu[playerid] = 4000000;
				}*/
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4304, DIALOG_STYLE_MSGBOX, "Kupowanie Hummera", "Hummer\n\nCena: 7.000.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 2\nOpis: Wojskowy wóz terenowy, tylko jeden kolor.", "Kup!", "Wróæ");
					pojazdid[playerid] = 470;
					CenaPojazdu[playerid] = 7000000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 454)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4400, DIALOG_STYLE_MSGBOX, "Kupowanie Yosemite", "Yosemite\n\nCena: 350.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 554;
					CenaPojazdu[playerid] = 350000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4401, DIALOG_STYLE_MSGBOX, "Kupowanie Bobcata", "Bobcat\n\nCena: 160.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 422;
					CenaPojazdu[playerid] = 160000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4402, DIALOG_STYLE_MSGBOX, "Kupowanie Picadora", "Picador\n\nCena: 220.000$\nPrêdkoœæ Maksymalna: 165km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 600;
					CenaPojazdu[playerid] = 220000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4403, DIALOG_STYLE_MSGBOX, "Kupowanie Sadlera", "Sadler\n\nCena: 180.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 543;
					CenaPojazdu[playerid] = 180000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4404, DIALOG_STYLE_MSGBOX, "Kupowanie Waltona", "Walton\n\nCena: 80.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 478;
					CenaPojazdu[playerid] = 80000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4603, DIALOG_STYLE_MSGBOX, "Kupowanie Slamvana", "Slamvan\n\nCena: 4.500.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Van, dostêpne malunki i full tuning.", "Kup!", "Wróæ");
					pojazdid[playerid] = 535;//dodaj slamvana slamavana
					CenaPojazdu[playerid] = 4500000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 455)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4500, DIALOG_STYLE_MSGBOX, "Kupowanie Cometa", "Comet\n\nCena: 5.000.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 480;
					CenaPojazdu[playerid] = 5000000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4501, DIALOG_STYLE_MSGBOX, "Kupowanie Windsora", "Windsor\n\nCena: 5.550.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 555;
					CenaPojazdu[playerid] = 5550000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4502, DIALOG_STYLE_MSGBOX, "Kupowanie Feltzera", "Feltzer\n\nCena: 1.400.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 533;
					CenaPojazdu[playerid] = 1400000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4503, DIALOG_STYLE_MSGBOX, "Kupowanie Staliona", "Stalion\n\nCena: 250.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 439;
					CenaPojazdu[playerid] = 250000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 456)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4600, DIALOG_STYLE_MSGBOX, "Kupowanie Blade", "Blade\n\nCena: 1.280.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 536;
					CenaPojazdu[playerid] = 1280000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4601, DIALOG_STYLE_MSGBOX, "Kupowanie Savanny", "Savanna\n\nCena: 1.330.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 567;
					CenaPojazdu[playerid] = 1330000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4602, DIALOG_STYLE_MSGBOX, "Kupowanie Remington", "Savanna\n\nCena: 1.400.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 534;
					CenaPojazdu[playerid] = 1400000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4603, DIALOG_STYLE_MSGBOX, "Kupowanie Tornada", "Tornado\n\nCena: 1.230.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 576;
					CenaPojazdu[playerid] = 1230000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4604, DIALOG_STYLE_MSGBOX, "Kupowanie Voodoo", "Voodoo\n\nCena: 1.220.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 412;
					CenaPojazdu[playerid] = 1220000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4605, DIALOG_STYLE_MSGBOX, "Kupowanie Broadwaya", "Broadway\n\nCena: 1.210.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 575;
					CenaPojazdu[playerid] = 1210000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 457)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4700, DIALOG_STYLE_MSGBOX, "Kupowanie Clovera", "Clover\n\nCena: 45.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 542;
					CenaPojazdu[playerid] = 45000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4701, DIALOG_STYLE_MSGBOX, "Kupowanie Tampy", "Tampa\n\nCena: 40.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 549;
					CenaPojazdu[playerid] = 40000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4701, DIALOG_STYLE_MSGBOX, "Kupowanie Perennial", "Perennial\n\nCena: 60.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 404;
					CenaPojazdu[playerid] = 60000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4702, DIALOG_STYLE_MSGBOX, "Kupowanie Glendale(obity)", "Glendale(obity)\n\nCena: 28.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 604;
					CenaPojazdu[playerid] = 28000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4703, DIALOG_STYLE_MSGBOX, "Kupowanie Sadler(obity)", "Sadler(obity)\n\nCena: 25.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 605;
					CenaPojazdu[playerid] = 25000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4704, DIALOG_STYLE_MSGBOX, "Kupowanie Turbowózek", "Turbowózek\n\nCena: 7.500$\nPrêdkoœæ Maksymalna: 80km/h\nIloœæ miejsc: 1\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 572;
					CenaPojazdu[playerid] = 7500;
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 4705, DIALOG_STYLE_MSGBOX, "Kupowanie Skuter", "Skuter\n\nCena: 17.000$\nPrêdkoœæ Maksymalna: 120km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 462;
					CenaPojazdu[playerid] = 17000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 458)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4800, DIALOG_STYLE_MSGBOX, "Kupowanie NRG-500", "NRG-500\n\nCena: 11.500.000$\nPrêdkoœæ Maksymalna: 240km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 522;
					CenaPojazdu[playerid] = 11500000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4801, DIALOG_STYLE_MSGBOX, "Kupowanie FCR-900", "FCR-900\n\nCena: 8.000.000$\nPrêdkoœæ Maksymalna: 220km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 521;
					CenaPojazdu[playerid] = 8000000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4802, DIALOG_STYLE_MSGBOX, "Kupowanie BF-400", "BF-400\n\nCena: 4.500.000$\nPrêdkoœæ Maksymalna: 200km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 581;
					CenaPojazdu[playerid] = 4500000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4803, DIALOG_STYLE_MSGBOX, "Kupowanie Freeway", "Freeway\n\nCena: 900.000$\nPrêdkoœæ Maksymalna: 180km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 463;
					CenaPojazdu[playerid] = 900000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4804, DIALOG_STYLE_MSGBOX, "Kupowanie Wayfarer", "Wayfarer\n\nCena: 750.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 586;
					CenaPojazdu[playerid] = 750000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4805, DIALOG_STYLE_MSGBOX, "Kupowanie Sancheza", "Sanchez\n\nCena: 1.500.000$\nPrêdkoœæ Maksymalna: 230km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 468;
					CenaPojazdu[playerid] = 1500000;
				}
				case 6:
				{
					ShowPlayerDialogEx(playerid, 4806, DIALOG_STYLE_MSGBOX, "Kupowanie Quad", "Quad\n\nCena: 600.000$\nPrêdkoœæ Maksymalna: 230km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 471;
					CenaPojazdu[playerid] = 600000;
				}
				case 7:
				{
					ShowPlayerDialogEx(playerid, 4807, DIALOG_STYLE_MSGBOX, "Kupowanie Skuter", "Skuter\n\nCena: 17.000$\nPrêdkoœæ Maksymalna: 120km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 462;
					CenaPojazdu[playerid] = 17000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 459)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, 4900, DIALOG_STYLE_MSGBOX, "Kupowanie Burrito", "Burrito\n\nCena: 350.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 482;
					CenaPojazdu[playerid] = 350000;
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 4901, DIALOG_STYLE_MSGBOX, "Kupowanie Bandito", "Bandito\n\nCena: 1.300.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 1\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 568;
					CenaPojazdu[playerid] = 1300000;
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 4902, DIALOG_STYLE_MSGBOX, "Kupowanie Hotknife", "Hotknife\n\nCena: 1.300.000$\nPrêdkoœæ Maksymalna: 170km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 434;
					CenaPojazdu[playerid] = 1300000;
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 4903, DIALOG_STYLE_MSGBOX, "Kupowanie Camper", "Camper\n\nCena: 350.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 4\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 483;
					CenaPojazdu[playerid] = 350000;
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 4904, DIALOG_STYLE_MSGBOX, "Kupowanie Kamping", "Kamping\n\nCena: 700.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 10-15 (Ruchomy dom)\nOpis: Pojazd posiada wnêtrze do którego mo¿na \n\t wchodziæ i wychodziæ komend¹ /wejdzw", "Kup!", "Wróæ");
					pojazdid[playerid] = 508;
					CenaPojazdu[playerid] = 700000;
				}
				case 5:
				{
					ShowPlayerDialogEx(playerid, 4905, DIALOG_STYLE_MSGBOX, "Kupowanie Hustler", "Hustler\n\nCena: 550.000$\nPrêdkoœæ Maksymalna: 160km/h\nIloœæ miejsc: 2\nOpis: Brak", "Kup!", "Wróæ");
					pojazdid[playerid] = 545;
					CenaPojazdu[playerid] = 550000;
				}
			}
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
		}
	}
	else if(dialogid == 499)
	{
		if(!response) return 1;
		new lUID = strval(inputtext);
		if(lUID < 0)
		{
			ShowCarsForPlayer(playerid, playerid);
			SendClientMessage(playerid, COLOR_RED, "× Ten pojazd jest zablokowany, skontaktuj siê z administratorem.");
			return 1;
		}

		new string[2048];
		format(string, sizeof(string), "Spawnuj\nRespawnuj\nUnspawnuj\nZnajdŸ\nPoka¿ parking\nPrzemaluj\nZ³omuj\nUsuñ tuning\n{E2BA1B}Tablica rejestracyjna (KP){FFFFFF}");
		ShowPlayerDialogEx(playerid, 500, DIALOG_STYLE_LIST, "Panel pojazdu", string, "Wybierz", "WyjdŸ");
		IloscAut[playerid] = lUID;
		return 1;
	}
	else if(dialogid == 500)
	{
		if(!response)
		{
			ShowCarsForPlayer(playerid, playerid);
			return 1;
		}
		new lUID = IloscAut[playerid];
		switch(listitem)
		{
			case 0:
			{
				if(CarData[lUID][c_ID] == 0)
				{
					Car_Spawn(lUID);
					Log(serverLog, INFO, "Gracz %s zrespawnowa³ pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(lUID));
					SendClientMessage(playerid, COLOR_WHITE, "Twój pojazd zosta³ {2DE9B1}zespawnowany{FFFFFF}!");
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "Twój pojazd jest ju¿ {2DE9B1}zespawnowany{FFFFFF}, stoi tam gdzie go zostawi³eœ!");
				}
			}
			case 1: ShowPlayerDialogEx(playerid, 7780, DIALOG_STYLE_MSGBOX, "Respawnuj wóz", "Czy na pewno chcesz zrespawnowaæ æ ten wó¿?\nKoszt respawnu wozu to {FF0000}5000${FFFAFA}!!!", "Respawnuj", "Anuluj");
			case 2: ShowPlayerDialogEx(playerid, 7781, DIALOG_STYLE_MSGBOX, "Unspawnuj wóz", "Czy na pewno chcesz unspawnowaæ ten wó¿?\nKoszt unspawnowania wozu to {FF0000}5000${FFFAFA}!!!", "Unspawnuj", "Anuluj");
			case 3://ZnajdŸ
			{
				if(CarData[lUID][c_ID] == 0) return SendClientMessage(playerid, 0xFFC0CB, "Auto nie jest zespawnowane.");
				new Float:autox, Float:autoy, Float:autoz;
				new pojazdszukany = CarData[lUID][c_ID];
				GetVehiclePos(pojazdszukany, autox, autoy, autoz);
				SetPlayerCheckpoint(playerid, autox, autoy, autoz, 6);
				SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
				SendClientMessage(playerid, 0xFFC0CB, "Lokalizacja pojazdu zosta³a oznaczona na mapie.");
			}
			case 4://Poka¿ parking
			{
				SetPlayerCheckpoint(playerid, CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], 6);
				SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
				SendClientMessage(playerid, 0xFFC0CB, "Lokalizacja pojazdu zosta³a oznaczona na mapie.");
			}
			case 5://Przemaluj
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(kaska[playerid] >= 1500)
					{
						ShowPlayerDialogEx(playerid, 33, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
					}
					else
					{
						SendClientMessage(playerid, 0xFFC0CB, "Nie masz pieniêdzy na przemalowanie (1500$)");
					}
				}
			}
			case 6://Z³omuj
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(CarData[lUID][c_ID] == 0) return SendClientMessage(playerid, 0xFFC0CB, "Auto nie jest zespawnowane!");
					if(CarData[lUID][c_ID] != GetPlayerVehicleID(playerid)) return SendClientMessage(playerid, 0xFFC0CB, "Nie siedzisz w aucie, ktore chcesz zezlomowac!");
					ShowPlayerDialogEx(playerid, 303, DIALOG_STYLE_MSGBOX, "Z³omowanie wozu", "Czy na pewno chcesz zez³omowaæ ten wóz? Zarobisz na tym tylko 5000$!", "Z£OMUJ", "WYJD");
				}
			}
			case 7://Usuñ tuning/Przywróc parking
			{
				CarData[lUID][c_Nitro] = 0;
				CarData[lUID][c_bHydraulika] = false;
				CarData[lUID][c_Felgi] = 0;
				CarData[lUID][c_Malunek] = 3;
				CarData[lUID][c_Spoiler] = 0;
				CarData[lUID][c_Bumper][0] = 0;
				CarData[lUID][c_Bumper][1] = 0;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning zostanie usuniêty przy najbli¿szym respawnie.");
			}
			case 8://rejestracja (NumberPlate)
			{
				if(!IsPlayerPremiumOld(playerid)) return sendTipMessage(playerid, "Nie posiadasz konta premium! Wpisz /kp.");
				ShowPlayerDialogEx(playerid, 7783, DIALOG_STYLE_INPUT, "Rejestracja", "WprowadŸ nowy numer/tekst na swojej tablicy rejestracyjnej\n(do 9 znaków):", "Ustaw", "Wróæ");
			}
		}
		return 1;
	}
	else if(dialogid >= 4000 && dialogid <= 4017)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 450, DIALOG_STYLE_LIST, "Samochody sportowe", "Turismo 10mln\nInfernus 12,5mln\nBullet 8mln\nSuper GT 7,5mln\nCheetah 7mln\nBanshee 6mln\nComet 5mln\nBuffalo 3mln\nZR-350 2,5mln\nPhoenix 750tys\nEuros 4mln\nSultan 5mln\nJester 4,5mln\nElegy 4mln\nUranus 3,25mln\nAlpha 900tys\nFlash 3,52mln\nHotknife 1,3mln", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4100 && dialogid <= 4124)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 451, DIALOG_STYLE_LIST, "Samochody osobowe", "Bravura 160tys\nManana 180tys\nEsperanto 200tys\nPremier 280tys\nPrevion 150tys\nNebula 320tys\nSolair 350tys\nGlendale 280tys\nOceanic 340tys\nHermes 275tys\nSabre 300tys\nRegina 375tys\nGreenwood 275tys\nBlista Compact 500tys\nMajestic 250tys\nBuccaneer 140tys\nFortune 400tys\nCadrona 375tys\nWillard 340tys\nIntruder 385tys\nPrimo 340tys\nTahoma 390tys\nEmperor 230k\nClub 700tys\nSurnise", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4200 && dialogid <= 4209)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 452, DIALOG_STYLE_LIST, "Samochody luksusowe", "Limuzyna 5mln\nVirgo 680tys\nWashington 750tys\nStafford 1,8mln\nSentiniel 600tys\nAdmiral 860tys\nElegant 750tys\nMerit 500tys\nStratum 2,85mln\nVincent 700tys", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4300 && dialogid <= 4305)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 453, DIALOG_STYLE_LIST, "Samochody terenowe", "Rancher 600tys\nHuntley 350tys\nLandstalker 200tys\nMesa 700tys\nBF Injection 800tys\nHummer 7mln", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4400 && dialogid <= 4404)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 454, DIALOG_STYLE_LIST, "Pick-up`y", "Yosemite 350tys\nBobcat 160tys\nPicador 220tys\nSadler 180tys\nWalton 80tys\nSlamvan 4,5mln", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4500 && dialogid <= 4503)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 455, DIALOG_STYLE_LIST, "Kabriolety", "Comet 5mln\nWindsor 5,5mln\nFeltzer 1,4mln\nStalion 250tys", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4600 && dialogid <= 4605)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 456, DIALOG_STYLE_LIST, "Lowridery", "Blade 1,28mln\nSavanna 1,33mln\nRemington 1,4mln\nTornado 1,23mln\nVoodoo 1,22mln\nBroadway 1,21mln", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4700 && dialogid <= 4705)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 457, DIALOG_STYLE_LIST, "Na ka¿d¹ kieszeñ", "Clover 45tys\nTampa 40tys\nPerenniel 60tys\nGlendale(obity) 28tys\nSadler(obity) 25tys\nTurbowózek œmiesznie tanio\nSkuter 17tys", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4800 && dialogid <= 4807)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 458, DIALOG_STYLE_LIST, "Jednoœlady", "NRG-500 11,5mln\nFCR-900 8mln\nBF-400 4,5mln\nFreeway 900tys\nWayfarer 750tys\nSanchez 1,5mln\nQuad 600tys\nFaggio 17tys", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 4900 && dialogid <= 4907)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nRó¿owy\n¯ó³ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "WyjdŸ");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 459, DIALOG_STYLE_LIST, "Inne pojazdy", "Burrito 350tys\nBandito 1,3mln\nHotknife 1,3mln\nCamper 350tys\nKamping 700tys\nHustler 550tys", "Wybierz", "Wróæ");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 7780)//Potwierdzenie Respawnuj
	{
		if(response)
		{
			if(kaska[playerid] >= 5000)
			{
				new vehicleid;

				if((vehicleid = CarData[IloscAut[playerid]][c_ID]) != 0)
				{
					Car_Unspawn(vehicleid);
					Car_Spawn(IloscAut[playerid]);
					Log(serverLog, INFO, "Gracz %s zrespawnowa³ pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(IloscAut[playerid]));

					ZabierzKase(playerid, 5000);
					SendClientMessage(playerid, 0xFFC0CB, "Pojazd zosta³ zrespawnowany. Koszt: {FF0000}5000$");
				}
				else
				{
					SendClientMessage(playerid, 0xFFC0CB, "Ten pojazd nie jest zespawnowany");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, 0xFFC0CB, "Nie staæ ciê!");
				ShowCarsForPlayer(playerid, playerid);
			}
		}
		if(!response)
		{
			ShowCarsForPlayer(playerid, playerid);
		}
	}
	else if(dialogid == 7781)//Potwierdzenie Unspawnuj
	{
		if(response)
		{
			if(kaska[playerid] >= 5000)
			{
				new vehicleid;

				if((vehicleid = CarData[IloscAut[playerid]][c_ID]) != 0)
				{
					Car_Unspawn(vehicleid);
					Log(serverLog, INFO, "Gracz %s unspawnowa³ pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(IloscAut[playerid]));

					ZabierzKase(playerid, 5000);
					SendClientMessage(playerid, 0xFFC0CB, "Pojazd zosta³ unspawnowany. Koszt: {FF0000}5000$");
				}
				else
				{
					SendClientMessage(playerid, 0xFFC0CB, "Ten pojazd nie jest zespawnowany");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, 0xFFC0CB, "Nie staæ ciê!");
				ShowCarsForPlayer(playerid, playerid);
			}
		}
		if(!response)
		{
			ShowCarsForPlayer(playerid, playerid);
		}
	}
	else if(dialogid == 7783)
	{
		new lUID = IloscAut[playerid];
		if(!response) return RunCommand(playerid, "/car",  "");
		if(strlen(inputtext) < 1 || strlen(inputtext) > 9)
		{
			RunCommand(playerid, "/car",  "");
			SendClientMessage(playerid, COLOR_GRAD1, "Nieodpowiednia iloœæ znaków.");
			return 1;
		}
		else for (new i = 0, len = strlen(inputtext); i != len; i ++) {
			if ((inputtext[i] >= 'A' && inputtext[i] <= 'Z') || (inputtext[i] >= 'a' && inputtext[i] <= 'z') || (inputtext[i] >= '0' && inputtext[i] <= '9') || (inputtext[i] == ' '))
				continue;
			else return SendClientMessage(playerid, COLOR_GRAD1, "U¿y³eœ nieodpowiednich znaków rejestracji (tylko litery i cyfry).");
		}
		CarData[lUID][c_Rejestracja] = strval(inputtext);
		SendClientMessage(playerid, 0xFFC0CB, "Tablica zostanie zmieniona po respawnie.");
		return 1;
	}
	return 0;
}

//end