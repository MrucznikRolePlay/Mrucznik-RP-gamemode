//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  premium                                                  //
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

*/

//

//-----------------<[ Dialogi: ]>-------------------

premium_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == PREMIUM_DIALOG(MENU))
	{
		if(response)
		{
			switch(listitem)
			{
				case 0,1: 
				{
					DialogDotacje(playerid);
				}
				case 3: 
				{
					DialogKupKP(playerid);
				}
				case 5:
				{
					DialogTelefon(playerid);
				}
				case 7:
				{
					DialogSlotyPojazdu(playerid);
				}
				case 8:
				{
					if(PlayerToPoint(10.0, playerid, 2132.0371,-1149.7332,24.2372))
					{
						DialogPojazdyPremium(playerid);
					}
					else
					{
						_MruGracz(playerid, "Aby kupiæ pojazd unikatowy musisz znajdowaæ siê przy salonie aut.");
						DialogMenuDotacje(playerid);
					}
				}
				case 10:
				{
					DialogZmianyNicku(playerid);
				}
				case 11:
				{
					if(IsAtClothShop(playerid))
					{
						DialogSkiny(playerid);
					}
					else
					{
						_MruGracz(playerid, "Pamiêtaj, ¿e aby kupiæ unikatowy skin, musisz znajdowaæ siê w sklepie z ubraniami.");
						DialogMenuDotacje(playerid);
					}
				}
				case 12:
				{
					DialogPrzedmioty(playerid);
				}
				default:
				{
					DialogMenuDotacje(playerid);
				}
			}
		}
	}
	//------------------ MENU DIALOG OPTIONS ------------------
	else if(dialogid == PREMIUM_DIALOG(KUP_KP))
	{
		if(response)
		{
			if(PremiumInfo[playerid][pMC] >= MIESIAC_KP_CENA)
			{
				if(IsPlayerPremium(playerid)) 
				{
					PrzedluzKP(playerid);
					DialogMenuDotacje(playerid);
				}
				else
				{
					KupKP(playerid);
					DialogMenuDotacje(playerid);
				}
			}
			else
			{
				_MruGracz(playerid, "Nie masz wystarczaj¹cej iloœci Mrucznik Coin'ów aby przed³u¿yæ/zakupiæ konto premium!");
				DialogKupKP(playerid);
			}
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(DOTACJE))
	{
		DialogMenuDotacje(playerid);
	}
	//------------------ DIALOG US£UGI PREMIUM ------------------
	else if(dialogid == PREMIUM_DIALOG(LICYTACJE))
	{
		if(response)
		{
			//TODO: stworzyæ licytacje
			SendClientMessage(playerid, -1, "W budowie.");
		}
		else
		{
			DialogMenuDotacje(playerid);
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
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(PRZEDMIOTY))
	{
		if(response)
		{
			//TODO: stworzyæ przedmioty
			SendClientMessage(playerid, -1, "W budowie.");
		}
		else
		{
			DialogMenuDotacje(playerid);
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
			DialogMenuDotacje(playerid);
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
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(SKINY))
	{
		if(response)
		{
			new skin = strval(inputtext);
			if(IsPremiumSkin(skin))
			{
				if(!PlayerHasSkin(playerid, skin))
				{
					KupSkinPremium(playerid, skin);
				}
				else
				{
					sendErrorMessage(playerid, "Masz ju¿ ten skin!");
					return DialogSkiny(playerid);
				} 
			}
			else
			{
				sendErrorMessage(playerid, "Skin o podanym ID nie jest skinem unikalnym");
				return DialogSkiny(playerid);
			}
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(TELEFON))
	{
		if(response)
		{
			KupNumerTelefonu(playerid, inputtext);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(ZMIENSKIN))
	{
		if(response)
		{
			new skin = DynamicGui_GetDataInt(playerid, listitem);

			new param[4];
			valstr(param,skin);

			return RunCommand(playerid, "/premiumskin",  param); 
		}
		else
		{
			return 1;
		}
	}
	return 1;
}

DialogMenuDotacje(playerid)
{
	new string[1024], kpinfo[40] = "";
	if(IsPlayerPremium(playerid))
	{
		new date[3], null;
		TimestampToDate(PremiumInfo[playerid][pExpires],date[0],date[1],date[2],null, null, null,2);
		format(kpinfo, sizeof(kpinfo), ""#PREMIUM_EMBED2"(Wygasa: %02d.%02d.%d)", date[2], date[1], date[0]);
	}


	format(string, sizeof(string), ""#HQ_COLOR_TEKST"Iloœæ MruCoins: \t\t"#PREMIUM_EMBED2"%d MC\n" \
		"    "HQ_COLOR_TEKST2"Kup MruCoins\n"\
		""#HQ_COLOR_TEKST"Konto Premium %s\n"\
		"    "HQ_COLOR_TEKST2"%s konto premium\n"\
		""#HQ_COLOR_TEKST"Numer Telefonu: \t"#PREMIUM_EMBED2"%d\n"\
		"    "HQ_COLOR_TEKST2"Zmieñ numer telefonu\n"\
		""#HQ_COLOR_TEKST"Pojazdy\n"\
		"    "HQ_COLOR_TEKST2"Dodatkowy slot "#PREMIUM_EMBED2"(Slotów: %d)\n"\
		"    "HQ_COLOR_TEKST2"Kup pojazd unikatowy\n"\
		""#HQ_COLOR_TEKST"Postaæ\n"\
		"    "HQ_COLOR_TEKST2"Dodatkowa zmiana nicku\n"\
		"    "HQ_COLOR_TEKST2"Unikatowy skin\n",
		"    "HQ_COLOR_TEKST2"Obiekt do noszenia\n",
		//"Rynek Mrucznik Coins'ów\n"
		//"Wspomó¿ nasz serwer i otrzymaj Mrucznik Coins'y!", 
	PremiumInfo[playerid][pMC], kpinfo, ((IsPlayerPremium(playerid)) ? ("Przed³u¿") : ("Kup")), PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCarSlots]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(MENU), DIALOG_STYLE_LIST, "Premium", string, "Wybierz", "WyjdŸ");
	return 1;
}

//------- MENU DIALOG ------------------
static DialogKupKP(playerid)
{
	new string[256];
	if(IsPlayerPremium(playerid))
		format(string, sizeof(string), "Mo¿esz przed³u¿yæ konto premium o 30 dni za "INCOLOR_GREEN""#PRZEDLUZ_KP_CENA" Mrucznik Coinsów\nCzy chcesz to zrobiæ?");
	else
		format(string, sizeof(string), "Mo¿esz kupiæ konto premium na 30 dni za "INCOLOR_GREEN""#MIESIAC_KP_CENA" Mrucznik Coinsów\nCzy chcesz to zrobiæ?");
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(KUP_KP), DIALOG_STYLE_MSGBOX, "Premium - KP", string, "Tak", "Nie");
}

static DialogRynekMC(playerid) //TODO
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
		INCOLOR_WHITE"www.mrucznik-rp.pl", 
	"Wróæ", "");
}

//------- US£UGI PREMIUM ------------------
DialogLicytacje(playerid)
{
	//TODO
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(LICYTACJE), DIALOG_STYLE_LIST, "Premium - Us³ugi - Licytacje", 
		"W budowie"\
		"",
	"Wybierz", "Wróæ");
	return 1;
}

DialogPojazdyPremium(playerid)
{
	new string[1590];
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
	{
		if(PojazdyPremium[i][Model] != 0)
			format(string, sizeof(string), "%s%s - "INCOLOR_GREEN"%d Mrucznik Coins\n", string, VehicleNames[PojazdyPremium[i][Model]-400], PojazdyPremium[i][Cena]);
	}
	string[strlen(string)-1] = '\0';
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(POJAZDY), DIALOG_STYLE_LIST, "Premium - Us³ugi - Pojazdy", string,"Kup", "Wróæ");
	sendTipMessageEx(playerid, COLOR_RED, "Uwaga klikniêcie w pojazd powoduje jego natychmiastowy zakup!"); 
	sendTipMessageEx(playerid, COLOR_RED, "Je¿eli nie jesteœ zdecydowany nie naciskaj w nazwê pojazdu."); 
	return 1;
}

DialogPrzedmioty(playerid)
{
	//TODO
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(PRZEDMIOTY), DIALOG_STYLE_LIST, "Premium - Us³ugi - Przedmioty", 
		" "\
		"",
	"Kup", "Wróæ");
}

DialogSlotyPojazdu(playerid)
{
	new string[300];
	format(string, sizeof(string), "Aktualnie posiadasz "INCOLOR_WHITE"%d"INCOLOR_DIALOG" slotów na pojazdy.\nMo¿esz dokupiæ dodatkowe sloty za Mrucznik Coiny, lecz nie mo¿esz posiadaæ wiêcej slotów, ni¿ "INCOLOR_ORANGE""#MAX_CAR_SLOT""INCOLOR_DIALOG".\nKoszt 1 slota to "INCOLOR_GREEN""#CAR_SLOT_CENA""INCOLOR_DIALOG" Mrucznik Coins.\nAby dokupiæ slot, naciœnij"INCOLOR_WHITE"\"Kup\"", PlayerInfo[playerid][pCarSlots]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SLOTY_POJAZDU), DIALOG_STYLE_MSGBOX, "Premium - Us³ugi - Sloty", string, "Kup", "Wróæ");
	return 1;
}

DialogZmianyNicku(playerid)
{
	new string[256];
	format(string, sizeof(string), "Aktualnie posiadasz "INCOLOR_WHITE"%d"INCOLOR_DIALOG" mo¿liwoœci zmiany nicku.\nMo¿esz dokupiæ dodatkowe zmiany nicku za Mrucznik Coiny.\n\nKoszt 1 zmiany nicku to "INCOLOR_GREEN""#ZMIANA_NICKU_CENA""INCOLOR_DIALOG" Mrucznik Coins.\nAby dokupiæ slot, naciœnij"INCOLOR_WHITE"\"Kup\"", PlayerInfo[playerid][pZmienilNick]);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIANY_NICKU), DIALOG_STYLE_MSGBOX, "Premium - Us³ugi - Zmiany nicku", string, "Kup", "Wróæ");
	return 1;
}

DialogSkiny(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SKINY), DIALOG_STYLE_INPUT, "Premium - Us³ugi - Skiny", 
		"Aby zakupiæ unikatowego skina musisz znaæ jego ID.\n"\
		"Unikatowy skin mo¿esz ustawiæ w dowolnym momencie komend¹ /premiumskin.\n"\
		"Mo¿esz posiadaæ nieograniczon¹ iloœæ unikatowych skinów.\n"\
		"Koszt unikatowego skina to "INCOLOR_GREEN""#UNIKATOWY_SKIN_CENA""INCOLOR_DIALOG" Mrucznik Coinów.\n"\
		"Wpisz ID w okienko ni¿ej i naciœnij \"Kup\" aby dokonaæ zakupu.",
	"Kup", "Wróæ");

	return true;
}

ListPlayerUniqueSkins(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[16*MAX_PREMIUM_SKINS];

	for(new i; i<MAX_PREMIUM_SKINS; i++)
	{
		if(UniqueSkins[playerid][i])
		{
			format(list, sizeof list, "%sSkin ID: %d\n", list, SkinyPremium[i][Model]);
			count++;
			DynamicGui_AddRow(playerid, 1, SkinyPremium[i][Model]);
		}
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz unikatowych skinów");

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIENSKIN), DIALOG_STYLE_LIST, "Premium - Twoje Skiny", list, "Ustaw", "WyjdŸ");

	return true;
}

DialogTelefon(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(TELEFON), DIALOG_STYLE_INPUT, "Premium - Us³ugi - Telefon", 
		"Aby ustawiæ nowy numer telefonu, wpisz go w okienko ni¿ej i naciœnij "INCOLOR_WHITE"\"Kup\""INCOLOR_DIALOG".\n"\
		"Ceny numerów w zale¿noœci od iloœci cyfr:\n"\
		"1 cyfra - "INCOLOR_GREEN""#TELEFON_CENA_1" MC"INCOLOR_DIALOG"\n"\
		"2 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_2" MC"INCOLOR_DIALOG"\n"\
		"3 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_3" MC"INCOLOR_DIALOG"\n"\
		"4 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_4" MC"INCOLOR_DIALOG"\n"\
		"wiêcej ni¿ 4 cyfry - "INCOLOR_GREEN""#TELEFON_CENA_5" MC"INCOLOR_DIALOG"\n",
	"Wybierz", "Wróæ");
	return 1;
}