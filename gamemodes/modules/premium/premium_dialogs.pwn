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
					DialogPojazdyPremium(playerid);
				}
				case 10:
				{
					DialogZmianyNicku(playerid);
				}
				case 11:
				{
					DialogSkiny(playerid);
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
			if((PremiumInfo[playerid][pKP] && PremiumInfo[playerid][pMC] >= PRZEDLUZ_KP_CENA) || PremiumInfo[playerid][pMC] >= MIESIAC_KP_CENA)
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
	//------------------ AKTYWACJA MC ------------------
	else if(dialogid == PREMIUM_DIALOG(DOTACJE))
	{
		if(response)
		{
			DialogAktywujMC_Mail(playerid);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(AKTYWACJA_MC_EMAIL))
	{
		if(response)
		{
			SetPVarString(playerid, "mc_email", inputtext);
			DialogAktywujMC_Kod(playerid);
		}
		else
		{
			DialogMenuDotacje(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(AKTYWACJA_MC_KOD))
	{
		if(response)
		{
			new kod[64];
			strcopy(kod, inputtext, sizeof(kod));
			regex_replace(kod, "[^a-zA-Z0-9-]", " "); // usun biale znaki z kodu, by przy kopiowaniu z forum wszystko bylo ok
			strtrim(kod);
			
			SetPVarString(playerid, "mc_kod", kod);
			new email[256];
			GetPVarString(playerid, "mc_email", email, 256);

			_MruGracz(playerid, "Trwa aktywacja Mrucznik Coinów...");
			SprawdzAktywacjeMC(playerid, email, kod);
		}
		else
		{
			DialogAktywujMC_Mail(playerid);
		}
	}
	else if(dialogid == PREMIUM_DIALOG(AKTYWACJA_MC_FAIL))
	{
		if(response)
		{
			DialogAktywujMC_Mail(playerid);
		}
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
			if(!PlayerToPoint(10.0, playerid, 2132.0371,-1149.7332,24.2372))
			{
				_MruGracz(playerid, "Aby kupiæ pojazd unikatowy musisz znajdowaæ siê przy salonie aut.");
				DialogPojazdyPremium(playerid);
				return 1;
			}
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
			if(!IsAtClothShop(playerid))
			{
				_MruGracz(playerid, "Aby kupiæ unikatowy przedmiot, musisz znajdowaæ siê w sklepie z ubraniami.");
				DialogPrzedmioty(playerid);
				return 1;
			}

			if(PlayerHasAttachedObject(playerid, PrzedmiotyPremium[listitem][Model]))
			{
				sendErrorMessage(playerid, "Masz ju¿ ten przedmiot!");
				return DialogPrzedmioty(playerid);
			}

			KupPrzedmiotPremium(playerid, listitem);
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
			if(PlayerHasSkin(playerid, SkinyPremium[listitem][Model]))
			{
				sendErrorMessage(playerid, "Masz ju¿ ten skin!");
				return DialogSkiny(playerid);
			}

			if(!IsAtClothShop(playerid))
			{
				_MruGracz(playerid, "Aby kupiæ unikatowy skin, musisz znajdowaæ siê w sklepie z ubraniami.");
				DialogSkiny(playerid);
				return 1;
			}
			
			KupSkinPremium(playerid, listitem);
			DialogSkinyPremiumGracza(playerid);
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
			valstr(param, skin);
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
		TimestampToDate(PremiumInfo[playerid][pExpires],date[0],date[1],date[2],null, null, null, 2);
		format(kpinfo, sizeof(kpinfo), ""#PREMIUM_EMBED2"(Wygasa: %02d.%02d.%d)", date[2], date[1], date[0]);
	}


	format(string, sizeof(string), ""#HQ_COLOR_TEKST"Iloœæ MruCoins: \t\t"#PREMIUM_EMBED2"%d MC\n" \
		"    "HQ_COLOR_TEKST2"Otwórz paczkê MruCoinsów\n"\
		""#HQ_COLOR_TEKST"Konto Premium %s\n"\
		"    "HQ_COLOR_TEKST2"%s konto premium\n"\
		""#HQ_COLOR_TEKST"Numer Telefonu: \t"#PREMIUM_EMBED2"%d\n"\
		"    "HQ_COLOR_TEKST2"Zmieñ numer telefonu\n"\
		""#HQ_COLOR_TEKST"Pojazdy\n"\
		"    "HQ_COLOR_TEKST2"Dodatkowy slot "#PREMIUM_EMBED2"(Slotów: %d)\n"\
		"    "HQ_COLOR_TEKST2"Kup pojazd unikatowy\n"\
		""#HQ_COLOR_TEKST"Postaæ\n"\
		"    "HQ_COLOR_TEKST2"Dodatkowa zmiana nicku\n"\
		"    "HQ_COLOR_TEKST2"Unikatowy skin\n"\
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

static stock DialogRynekMC(playerid) //TODO: stworzyæ licytacje
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
		INCOLOR_WHITE"mrucznik-rp.pl/store\n\n" \
		INCOLOR_DIALOG"Jesli posiadasz ju¿ klucz do aktywacji Mrucznik Coinów, kliknij dalej.", 
	"Dalej", "Wróæ");
}

//------- AKTYWACJA MC'KÓW ------------------
DialogAktywujMC_Mail(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(AKTYWACJA_MC_EMAIL), DIALOG_STYLE_INPUT, "Premium - e-mail", 
		"Podaj e-mail konta forum, z którego zosta³y zakupione Mrucznik Coiny", 
	"Dalej", "Wróæ");
}

DialogAktywujMC_Kod(playerid)
{
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(AKTYWACJA_MC_KOD), DIALOG_STYLE_INPUT, "Premium - kod", 
		"Podaj klucz licencyjny paczki Mrucznik Coinów", 
	"Dalej", "Wróæ");
}

DialogAktywujMC_Fail(playerid, error[])
{
	new string[512];
	format(string, sizeof(string), "Niestety, nie uda³o siê aktywowaæ paczki Mrucznik Coinów.\n\n" \
		INCOLOR_LIGHTRED"B³¹d: %s\n\n" \
		INCOLOR_DIALOG"SprawdŸ wprowadzone dane i spróbuj jeszcze raz.\n" \
		"W razie dalszych problemów, skontaktuj siê z administracj¹.", error);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(AKTYWACJA_MC_FAIL), DIALOG_STYLE_MSGBOX, "Premium - b³¹d", 
		string,
	"Ponów", "WyjdŸ");
}

DialogAktywujMC_Success(playerid, mc)
{
	new string[256];
	format(string, sizeof(string), "Twoje "INCOLOR_GOLD"%d Mrucznik Coinów"INCOLOR_DIALOG" zosta³o aktywowane!\nDziêkujemy za wspieranie serwera :)", mc);
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(AKTYWACJA_MC_SUKCES), DIALOG_STYLE_MSGBOX, "Premium - MC aktywowane!", 
		 string,
	"WyjdŸ", "");
}

//------- US£UGI PREMIUM ------------------
/*
DialogLicytacje(playerid)
{
	//TODO: stworzyæ licytacje
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(LICYTACJE), DIALOG_STYLE_LIST, "Premium - Us³ugi - Licytacje", 
		"W budowie"\
		"",
	"Wybierz", "Wróæ");
	return 1;
}*/

DialogPojazdyPremium(playerid)
{
	new string[1590];
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
	{
		strcat(string, sprintf("%d\t%s~n~~g~%dMC\n", PojazdyPremium[i][Model], VehicleNames[PojazdyPremium[i][Model]-400], PojazdyPremium[i][Cena]));
	}
	string[strlen(string)-1] = '\0';
	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(POJAZDY), DIALOG_STYLE_PREVIEW_MODEL, "Premium - Us³ugi - Pojazdy", string, "Kup", "Wstecz");
	sendTipMessageEx(playerid, COLOR_RED, "Uwaga klikniêcie w pojazd powoduje jego natychmiastowy zakup!"); 
	sendTipMessageEx(playerid, COLOR_RED, "Je¿eli nie jesteœ zdecydowany nie naciskaj w nazwê pojazdu."); 
	return 1;
}

DialogPrzedmioty(playerid)
{
	new substring[32];
	static string[MAX_PREMIUM_ITEMS * sizeof(substring)];

	if(isnull(string)) {
        for (new i; i < MAX_PREMIUM_ITEMS; i++) {
            format(substring, sizeof(substring), "%i\t~g~%dMC\n", PrzedmiotyPremium[i][Model], PrzedmiotyPremium[i][Cena]);
            strcat(string, substring);
        } 
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(PRZEDMIOTY), DIALOG_STYLE_PREVIEW_MODEL,
		"Premium - Us³ugi - Przedmioty",
		string,
		"Kup", "Wstecz"
	);
	return 1;
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
	new substring[32];
	static string[MAX_PREMIUM_SKINS * sizeof(substring)];

	if(isnull(string)) {
        for (new i; i < MAX_PREMIUM_SKINS; i++) {
            format(substring, sizeof(substring), "%i\t~g~%dMC\n", SkinyPremium[i][Model], SkinyPremium[i][Cena]);
            strcat(string, substring);
        } 
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(SKINY), DIALOG_STYLE_PREVIEW_MODEL, 
		"Premium - Us³ugi - Skiny", 
		string,
		"Kup", "Wstecz"
	);
	return 1;
}

DialogSkinyPremiumGracza(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[5*MAX_PREMIUM_SKINS];

	VECTOR_foreach(v : VPremiumSkins[playerid])
	{
		new skin = MEM_get_val(v);
		strcat(list, sprintf("%d\n", skin));
		count++;
		DynamicGui_AddRow(playerid, 1, skin);
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz unikatowych skinów.");

	ShowPlayerDialogEx(playerid, PREMIUM_DIALOG(ZMIENSKIN), DIALOG_STYLE_PREVIEW_MODEL, "Premium - Twoje skiny", list, "Ustaw", "Wyjdz");

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