//premium.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: premium.pwn ]------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*

*/
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

//

//-----------------<[ Funkcje: ]>-------------------
premium_ConvertToNewSystem(playerid)
{
	
}

DajMC(playerid, mc)
{
	if(mc <= 0)
	{
		printf("ERROR: funkcja DajMC miala ujemna wartosc dla playerid: %s[%d] Wartosc: %d", GetNick(playerid), playerid, mc);
		return;
	}
	PremiumInfo[playerid][pMC] += mc;
}

ZabierzMC(playerid, mc)
{
	if(mc <= 0)
	{
		printf("ERROR: funkcja ZabierzMC miala ujemna wartosc dla playerid: %s[%d] Wartosc: %d", GetNick(playerid), playerid, mc);
		return;
	}
	PremiumInfo[playerid][pMC] -= mc;
}

KupKP(playerid)
{
	
}

KupPojazdPremium(playerid, id)
{
	if(!(id < MAX_PREMIUM_VEHICLES && id >= 0))
	{
		DialogPojazdy(playerid);
		return;
	}
	if(PremiumInfo[playerid][pMC] < PojazdyPremium[id][Cena])
	{
		SendClientMessage(playerid, -1, "Nie staæ ciê na ten pojazd!");
		DialogPojazdy(playerid);
		return;
	}

	new string[128];
	MRP_ShopPurchaseCar(playerid, PojazdyPremium[id][Model], PojazdyPremium[id][Cena]);
	format(string, sizeof(string), "%s kupil pojazd premium %s za %d Mrucznik Coins", GetNick(playerid), VehicleNames[PojazdyPremium[id][Model]-400], PojazdyPremium[id][Cena]);
	PremiumLog(string);
}

//---< Is >---
IsPlayerSposnor(playerid)
{
	if(PremiumInfo[playerid][pSponsor] == 1)
		return 1;
	return 0;
}

IsPlayerPremium(playerid)
{
	if(PremiumInfo[playerid][pKP] == 1)
		return 1;
	return 0;
}

IsAUnikat(modelid)
{
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
		if(modelid == PojazdyPremium[i][Model])
			return 1;
	return 0;
}

//-----------------<[ Dialogi: ]>-------------------

premium_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == PREMIUM_DIALOG(MENU))
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //Posiadane Mrucznik Coins'y
				{
					DialogMenu(playerid);
				}
				case 1: //Kup konto premium/przed³u¿ konto premium
				{
					DialogKupKP(playerid);
				}
				case 2: //Us³ugi premium
				{
					DialogUslugiPremium(playerid);
				}
				case 3: //Rynek Mrucznik Coinsów
				{
					if(IsPlayerPremium(playerid))
						DialogRynekMC(playerid);
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "Tylko gracze z aktywnym kontem premium mog¹ korzystaæ z rynku Mrucznik Coinów!");
						DialogMenu(playerid);
					}
				}
				case 4: //Wspomó¿ nasz serwer i otrzymaj Mrucznik Coinsy
				{
					DialogDotacje(playerid);
				}
			}
		}
	}
	//------- MENU DIALOG OPTIONS ------------------
	else if(dialogid == PREMIUM_DIALOG(KUP_KP))
	{
		if(response)
		{
			if(PremiumInfo[playerid][pMC] >= MIESIAC_KP_CENA)
			{
				KupKP(playerid);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Gratulacje! Konto premium na miesi¹c zosta³o przypisane do twojego konta!");
				DialogMenu(playerid);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Nie masz wystarczaj¹cej iloœci Mrucznik Coin'ów aby przed³u¿yæ/zakupiæ konto premium!");
				DialogKupKP(playerid);
			}
		}
		else
		{
			DialogMenu(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(USLUGI_PREMIUM))
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //Licytacje - limitowane okazje
				{
					DialogLicytacje(playerid);
				}
				case 1: //Pojazdy unikatowy
				{
					DialogPojazdy(playerid);
				}
				case 2: //Przedmioty specjalne
				{
					DialogPrzedmioty(playerid);
				}
				case 3: //Dodatkowe sloty na pojazdy
				{
					DialogSlotyPojazdu(playerid);
				}
				case 4: //Dodatkowa zmiana nicku
				{
					DialogZmianyNicku(playerid);
				}
				case 5: //Unikatowe skiny
				{
					DialogSkiny(playerid);
				}
				case 6: //Zmiana numeru telefonu
				{
					DialogTelefon(playerid);
				}
			}
		}
		else
		{
			DialogMenu(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(RYNEK_MC))
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //Oferty kupna Mrucznik Coinów
				{
				}
				case 1: //Oferty sprzeda¿y Mrucznik Coinów
				{
				}
				case 2: //Stwórz ofertê kupna
				{
				}
				case 3: //Stwórz ofertê sprzeda¿y
				{
				}
				case 4: //Moje oferty
				{
				}
				case 5: //Historia transakcji
				{
				}
			}
		}
		else
		{
			DialogMenu(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(DOTACJE))
	{
		DialogMenu(playerid);
	}
	//------- DIALOG US£UGI PREMIUM ------------------
	else if(dialogid == PREMIUM_DIALOG(LICYTACJE))
	{
		if(response)
		{
			
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(POJAZDY))
	{
		if(response)
		{
			KupPojazdPremium(playerid, listitem);
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(PRZEDMIOTY))
	{
		if(response)
		{
			
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(SLOTY_POJAZDU))
	{
		if(response)
		{
			KupSlotPojazdu(playerid);
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(ZMIANY_NICKU))
	{
		if(response)
		{
			KupZmianeNicku(playerid);
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(SKINY))
	{
		if(response)
		{
			KupSkin(playerid, strval(inputtext));
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(TELEFON))
	{
		if(response)
		{
			KupNumerTelefonu(playerid, strval(inputtext));
		}
		else
		{
			DialogUslugiPremium(playerid);
		}
	}
	//------- DIALOG RYNEK MC ------------------
	else if(dialogid == PREMIUM_DIALOG(TELEFON))
	{
		
	}
	return 1;
}

static DialogMenu(playerid)
{
	new string[512], kpinfo[40];
	if(IsPlayerPremium(playerid))
		format(kpinfo, sizeof(kpinfo), "Konto premium wygasa %02d.%02d.%d", PremiumInfo[playerid][pExpirationDate][2], PremiumInfo[playerid][pExpirationDate][1], PremiumInfo[playerid][pExpirationDate][0]);
	else
		format(kpinfo, sizeof(kpinfo), "Kup konto premium");
	format(string, sizeof(string), "Posiadane Mrucznik Coins'y: "INCOLOR_GREEN2"%d\n" \
		"%s\n"\
		"Us³ugi premium\n"\
		"Rynek Mrucznik Coins'ów\n"\
		"Wspomó¿ nasz serwer i otrzymaj Mrucznik Coins'y!", 
	PremiumInfo[playerid][pMC], kpinfo);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(MENU), DIALOG_STYLE_LIST, "Premium", string, "Wybierz", "WyjdŸ");
	return 1;
}

//------- MENU DIALOG ------------------
static DialogKupKP(playerid)
{
	new string[256];
	if(IsPlayerPremium(playerid))
		format(string, sizeof(string), "Mo¿esz przed³u¿yæ swoje konto premium o miesi¹c za "#MIESIAC_KP_CENA" Mrucznik Coinsów\nCzy chcesz to zrobiæ?");
	else
		format(string, sizeof(string), "Mo¿esz kupiæ swoje konto premium o miesi¹c za "#MIESIAC_KP_CENA" Mrucznik Coinsów\nCzy chcesz to zrobiæ?");
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(KUP_KP), DIALOG_STYLE_MSGBOX, "Premium - KP", string, "Tak", "Nie");
}

static DialogUslugiPremium(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(USLUGI_PREMIUM), DIALOG_STYLE_LIST, "Premium - Us³ugi", 
		"Licytacje - limitowane okazje\n"\
		"Pojazdy unikatowy\n"\
		"Przedmioty specjalne\n"\
		"Dodatkowe sloty na pojazdy\n"\
		"Dodatkowa zmiana nicku\n"\
		"Unikatowe skiny\n"\
		"Zmiana numeru telefonu",
	"Wybierz", "Wróæ");
}

static DialogRynekMC(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(RYNEK_MC), DIALOG_STYLE_LIST, "Premium - Rynek MC", 
		"Oferty kupna Mrucznik Coinów\n"\
		"Oferty sprzeda¿y Mrucznik Coinów\n"\
		"Stwórz ofertê kupna\n"\
		"Stwórz ofertê sprzeda¿y\n"\
		"Moje oferty\n"\
		"Historia transakcji",
	"Wybierz", "Wróæ");
}

static DialogDotacje(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(DOTACJE), DIALOG_STYLE_MSGBOX, "Premium - Dotacje", 
		"Je¿eli wspomo¿esz nasz serwer dotacj¹ o okreœlonej wysokoœci, otrzymasz od nas okreœlon¹ iloœæ Mrucznik Coinsów.\n" \
		"Informacje o tym, w jaki sposób mo¿esz wesprzeæ nasz serwer, znajdziesz na naszym forum\n" \
		"www.mrucznik-rp.pl", 
	"Wróæ", "");
}

//------- US£UGI PREMIUM ------------------
static DialogLicytacje(playerid)
{
	//zaawansowany system
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(LICYTACJE), DIALOG_STYLE_LIST, "Premium - Us³ugi - Licytacje", 
		"W budowie"\
		"",
	"Wybierz", "Wróæ");
}

static DialogPojazdy(playerid)
{
	new string[512];
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
	{
		if(PojazdyPremium[i][Model] != 0)
			format(string, sizeof(string), "%s%s = %d Mrucznik Coins\n", string, VehicleNames[PojazdyPremium[i][Model]-400], PojazdyPremium[i][Cena]);
	}
	string[strlen(string)-1] = '\0';
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(POJAZDY), DIALOG_STYLE_LIST, "Premium - Us³ugi - Pojazdy", string,"Kup", "Wróæ");
}

static DialogPrzedmioty(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(PRZEDMIOTY), DIALOG_STYLE_LIST, "Premium - Us³ugi - Przedmioty", 
		""\
		"",
	"Kup", "Wróæ");
}

static DialogSlotyPojazdu(playerid)
{
	new string[256];
	format(string, sizeof(string), "Aktualnie posiadasz %d slotów na pojazdy.\nMo¿esz dokupiæ dodatkowe sloty za Mrucznik Coiny, lecz nie mo¿esz posiadaæ wiêcej slotów, ni¿ "#MAX_CAR_SLOT".\nKoszt 1 slota to "#CAR_SLOT_CENA" Mrucznik Coins.\nAby dokupiæ slot, naciœnij\"Kup\"", PlayerInfo[playerid][pCarSlots]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SLOTY_POJAZDU), DIALOG_STYLE_MSGBOX, "Premium - Us³ugi - Sloty", string, "Kup", "Wróæ");
}

static DialogZmianyNicku(playerid)
{
	new string[256];
	format(string, sizeof(string), "Aktualnie posiadasz %d mo¿liwoœci zmiany nicku.\nMo¿esz dokupiæ dodatkowe zmiany nicku za Mrucznik Coiny.\n\nKoszt 1 zmiany nicku to "#ZMIANA_NICKU_CENA" Mrucznik Coins.\nAby dokupiæ slot, naciœnij\"Kup\"", PlayerInfo[playerid][pZmienilNick]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIANY_NICKU), DIALOG_STYLE_MSGBOX, "Premium - Us³ugi - Zmiany nicku", string, "Kup", "Wróæ");
}

static DialogSkiny(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SKINY), DIALOG_STYLE_INPUT, "Premium - Us³ugi - Skiny", 
		"Aby zakupiæ unikatowego skina musisz znaæ jego ID.\n"\
		"Unikatowy skin mo¿esz ustawiæ w dowolnym momencie komend¹ /premiumskin.\n"\
		"Mo¿esz posiadaæ tylko 1 unikatowy skin na raz (je¿eli masz ju¿ unikatowy skin a kupisz nowy - nadpiszesz obecny)\n"\
		"Koszt unikatowego skina to "#UNIKATOWY_SKIN_CENA" Mrucznik Coinów.\n"\
		"Wpisz ID w okienko ni¿ej i naciœnij \"Kup\" aby dokonaæ zakupu.",
	"Kup", "Wróæ");
}

static DialogTelefon(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(TELEFON), DIALOG_STYLE_INPUT, "Premium - Us³ugi - Telefon", 
		"Aby ustawiæ nowy numer telefonu, wpisz go w okienko ni¿ej i naciœnij \"Kup\".\n"\
		"Ceny numerów w zale¿noœci od iloœci cyfr:\n"\
		"1 cyfra - "#TELEFON_CENA_1"\n"\
		"2 cyfry - "#TELEFON_CENA_2"\n"\
		"3 cyfry - "#TELEFON_CENA_3"\n"\
		"4 cyfry - "#TELEFON_CENA_4"\n"\
		"wiêcej ni¿ 4 cyfry - "#TELEFON_CENA_5"\n",
	"Wybierz", "Wróæ");
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
CMD:kp(playerid, params[]) return cmd_premium(playerid, params);
CMD:dotacje(playerid, params[]) return cmd_premium(playerid, params);
CMD:premium(playerid, params[])
{
    if(IsPlayerConnected(playerid) && gPlayerLogged[playerid] != 0)
    {
        DialogMenu(playerid);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
    }
    return 1;
}

//end