//-----------------------------------------------<< Source >>------------------------------------------------//
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
	Monetyzacja, us³ugi premium.
*/

//

//-----------------<[ Include: ]>-------------------
#include "premium_dialogs.pwn"

//-----------------<[ Funkcje: ]>-------------------
premium_ConvertToNewSystem(playerid)
{
	if(PlayerInfo[playerid][OldDonateRank] != 0)
	{
		DajKP(playerid, gettime()+KP_3_MIESIACE, false); // KP na 3 msc dla osób, które mieli premiuma na starym systemie
		DajMC(playerid, 500); // i jeszcze prezent...

		_MruGracz(playerid, "Uwaga! Twoje premium zosta³o przeniesione na nowy system!");
		_MruGracz(playerid, "Otrzyma³eœ Konto Premium na 3 miesi¹ce i dodatkowe 500 MC do wykorzystania.");

		Log(premiumLog, INFO, "%s otrzyma³ konwersje KP %d na nowy system", GetPlayerLogName(playerid), PlayerInfo[playerid][OldDonateRank]);
		PlayerInfo[playerid][OldDonateRank] = 0;
	}
}

premium_clearCache(playerid)
{
	PremiumInfo[playerid][pMC] = 0;
	PremiumInfo[playerid][pKP] = 0;
	PremiumInfo[playerid][pExpires] = 0;

	VECTOR_clear(VPremiumSkins[playerid]);
}

premium_loadForPlayer(playerid)
{
	if(PlayerInfo[playerid][OldDonateRank] != 0)
	{
		premium_ConvertToNewSystem(playerid);
	}

	new kpMC, kpStarted, kpEnds, kpLastLogin, kpActive;
	MruMySQL_LoadPremiumData(playerid, kpMC, kpEnds, kpStarted, kpLastLogin, kpActive);

	if(kpActive)
	{
		new shouldEnd = kpEnds-(gettime()+3600);
		if(kpEnds != 0 && shouldEnd <= 0)
		{
			sendErrorMessage(playerid, "Twoje konto premium wygas³o!");
			PremiumInfo[playerid][pKP] = 0;
			ZabierzKP(playerid);
		}
		else
		{
			new expirationTime = kpEnds-gettime();
			if(expirationTime < KP_TYDZIEN)
			{
				_MruAdmin(playerid, 
					sprintf("UWAGA! Twoje konto premium wygasa za %d dni i %d godzin", 
						floatround(floatdiv(expirationTime, 86400), floatround_floor), 
						floatround(floatdiv(expirationTime, 3600), floatround_floor)%24
					)
				);
			}
			else
			{
				_MruAdmin(playerid, "Jesteœ posiadaczem konta premium! :)");
			}
			PremiumInfo[playerid][pKP] = 1;
		}
		if(IsPlayerPremium(playerid)) 
		{
			PremiumInfo[playerid][pExpires] = kpEnds;
		}
	}

	if(kpMC > 0) PremiumInfo[playerid][pMC] = kpMC;

	MruMySQL_LoadPlayerPremiumSkins(playerid);
}

premium_printMcBalance(playerid)
{
	return _MruGracz(playerid, sprintf("Aktualnie na Twoim koncie znajduje siê %d MruCoins.", PremiumInfo[playerid][pMC]));
}

//---< Private >---
ZabierzKP(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		Log(premiumLog, E_LOGLEVEL:DEBUG, "%s zabrano KP", GetPlayerLogName(playerid));
		PremiumInfo[playerid][pKP] = 0;
		MruMySQL_RemoveKP(playerid);
	}
}

DajKP(playerid, time, bool:msg=true)
{
	if(IsPlayerConnected(playerid))
    {
		Log(premiumLog, E_LOGLEVEL:DEBUG, "%s nadano KP na %d", GetPlayerLogName(playerid), time);
        MruMySQL_SetKP(playerid, time);

        new expirationTime = time-gettime();
        if(expirationTime > 0 && time != 0)
        {
        	if(msg)
        	{
	            _MruAdmin(playerid, 
					sprintf("Otrzyma³eœ Konto Premium. Wygasa ono za %d dni i %d godzin.", 
						floatround(floatdiv(expirationTime, 86400), floatround_floor), 
						floatround(floatdiv(expirationTime, 3600), floatround_floor)%24
					)
				);
        	}

			PremiumInfo[playerid][pExpires] = time;
            PremiumInfo[playerid][pKP] = 1;
        }
        else if(time == 0)
        {
            _MruAdmin(playerid, "Otrzyma³eœ konto Premium na czas nieokreœlony.");
            PremiumInfo[playerid][pKP] = 1;
        }
    }
}

DajMC(playerid, mc)
{
	Log(premiumLog, E_LOGLEVEL:DEBUG, "%s nadano %dMC, poprzedni stan: %dMC", GetPlayerLogName(playerid), mc, PremiumInfo[playerid][pMC]);
	if(mc <= 0)
	{
		Log(premiumLog, ERROR,"ERROR: funkcja DajMC miala ujemna wartosc dla %s Wartosc: %d", GetPlayerLogName(playerid), mc);
		return 0;
	}

	PremiumInfo[playerid][pMC] += mc;
	MruMySQL_SaveMc(playerid);
	return 1;
}

ZabierzMC(playerid, mc)
{
	Log(premiumLog, E_LOGLEVEL:DEBUG, "%s zabrano %dMC, poprzedni stan: %dMC", GetPlayerLogName(playerid), mc, PremiumInfo[playerid][pMC]);
	if(mc <= 0)
	{
		Log(premiumLog, ERROR, "ERROR: funkcja ZabierzMC miala ujemna wartosc dla %s", GetPlayerLogName(playerid), mc);
		return 0;
	}

	PremiumInfo[playerid][pMC] -= mc;
	MruMySQL_SaveMc(playerid);
	return 1;
}

KupKP(playerid)
{
	ZabierzMC(playerid, MIESIAC_KP_CENA);
	DajKP(playerid, gettime()+KP_MIESIAC);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "Gratulacjê! Zakupi³eœ konto premium. Od teraz masz dostêp do mo¿liwoœci premium. Dziêkujemy za wspieranie serwera!"); 
}

PrzedluzKP(playerid)
{
	ZabierzMC(playerid, PRZEDLUZ_KP_CENA);
	DajKP(playerid, PremiumInfo[playerid][pExpires]+KP_MIESIAC);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "Konto premium przed³u¿one :D!"); 
}

KupPojazdPremium(playerid, id)
{
	if(!(id < MAX_PREMIUM_VEHICLES && id >= 0))
	{
		DialogPojazdyPremium(playerid);
		return 1;
	}
	if(PremiumInfo[playerid][pMC] < PojazdyPremium[id][Cena])
	{
		sendErrorMessage(playerid, "Nie staæ Ciê na ten pojazd");
		return DialogPojazdyPremium(playerid);
	}
	MRP_ShopPurchaseCar(playerid, PojazdyPremium[id][Model], PojazdyPremium[id][Cena]);
	Log(premiumLog, INFO, "%s kupil pojazd premium %s za %dMC",
		GetPlayerLogName(playerid), 
		VehicleNames[PojazdyPremium[id][Model]-400], 
		PojazdyPremium[id][Cena]);
	premium_printMcBalance(playerid);
	DialogMenuDotacje(playerid);
	return 1;
}

KupPrzedmiotPremium(playerid, id)
{
	if(PremiumInfo[playerid][pMC] < PrzedmiotyPremium[id][Cena])
	{
		sendErrorMessage(playerid, "Nie staæ Ciê na ten przedmiot!");
		return DialogPrzedmioty(playerid);
	}

	ZabierzMC(playerid, PrzedmiotyPremium[id][Cena]);

	Log(premiumLog, INFO, "%s kupi³ unikatowy przedmiot %d za %dMC",
		GetPlayerLogName(playerid), 
		PrzedmiotyPremium[id][Model],
		PrzedmiotyPremium[id][Cena]);
	
	PlayerAttachments_Create(playerid, 
		PrzedmiotyPremium[id][Model],
		PrzedmiotyPremium[id][Bone],
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		1.0, 1.0, 1.0
	);
	
	_MruAdmin(playerid, sprintf("Gratulujemy dobrego wyboru. Kupi³eœ przedmiot o ID %d za %d MC.", PrzedmiotyPremium[id][Model], PrzedmiotyPremium[id][Cena]));
	_MruAdmin(playerid, "Listê swoich przedmiotów premium znajdziesz pod komend¹ /dodatki");

	premium_printMcBalance(playerid);
	return 1;
}

KupSlotPojazdu(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;

	if(PremiumInfo[playerid][pMC] < CAR_SLOT_CENA)
	{
		sendErrorMessage(playerid, "Nie staæ Ciê na zakup dodatkowego slotu.");
		return DialogSlotyPojazdu(playerid);
	}

	if(MRP_GetPlayerCarSlots(playerid) >= 10)
	{
		sendErrorMessage(playerid, "Masz ju¿ maksymaln¹ iloœæ slotów.");
		return DialogMenuDotacje(playerid);
	}

	ZabierzMC(playerid, CAR_SLOT_CENA);
	MRP_SetPlayerCarSlots(playerid, MRP_GetPlayerCarSlots(playerid)+1);

	Log(premiumLog, INFO, "%s kupi³ slot wozu za "#CAR_SLOT_CENA"MC",
		GetPlayerLogName(playerid));
	_MruAdmin(playerid, sprintf("Kupi³eœ sobie slot na auto za %d MC. Masz teraz %d slotów.", CAR_SLOT_CENA, MRP_GetPlayerCarSlots(playerid)));

	premium_printMcBalance(playerid);
	DialogMenuDotacje(playerid);
	return 1;
}

KupZmianeNicku(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;

	if(PremiumInfo[playerid][pMC] < ZMIANA_NICKU_CENA)
	{
		sendErrorMessage(playerid, "Nie staæ Ciê na zakup dodatkowej zmiany nicku");
		return DialogZmianyNicku(playerid);
	}

	ZabierzMC(playerid, ZMIANA_NICKU_CENA);
	MRP_SetPlayerNickChanges(playerid, MRP_GetPlayerNickChanges(playerid)+1);

	Log(premiumLog, INFO, "%s kupil zmiane nicku za "#ZMIANA_NICKU_CENA"MC",
		GetPlayerLogName(playerid));
	_MruAdmin(playerid, sprintf("Kupi³eœ sobie zmianê nicku za %d MC. Masz teraz %d zmian nicku.", ZMIANA_NICKU_CENA, MRP_GetPlayerNickChanges(playerid)));

	premium_printMcBalance(playerid);
	DialogMenuDotacje(playerid);
	return 1;
}

KupSkinPremium(playerid, id)
{
	if(PremiumInfo[playerid][pMC] < SkinyPremium[id][Cena])
	{
		sendErrorMessage(playerid, "Nie staæ Ciê na ten skin");
		return DialogSkiny(playerid);
	}

	MruMySQL_InsertSkin(playerid, id);

	Log(premiumLog, INFO, "%s kupi³ unikatowy skin %d za %dMC",
		GetPlayerLogName(playerid), 
		SkinyPremium[id][Model], 
		SkinyPremium[id][Cena]);

	VECTOR_push_back_val(VPremiumSkins[playerid], SkinyPremium[id][Model]);

	ZabierzMC(playerid, SkinyPremium[id][Cena]);

	_MruAdmin(playerid, sprintf("Gratulujemy dobrego wyboru. Kupi³eœ skin o ID %d za %d MC.", SkinyPremium[id][Model], SkinyPremium[id][Cena]));
	_MruAdmin(playerid, "Listê swoich skinów premium znajdziesz pod komend¹ /skiny");

	premium_printMcBalance(playerid);
	return 1;
}

KupNumerTelefonu(playerid, string:_numer[])
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(strlen(_numer) < 1) return DialogTelefon(playerid);
	if(strlen(_numer) > 9) return DialogTelefon(playerid);

	new numer = strval(_numer);

	if(MruMySQL_IsPhoneNumberAvailable(numer))
	{

		new cena;

		if(strlen(_numer) == 1)
			cena = TELEFON_CENA_1;
		else if(strlen(_numer) == 2)
			cena = TELEFON_CENA_2;
		else if(strlen(_numer) == 3)
			cena = TELEFON_CENA_3;
		else if(strlen(_numer) == 4)
			cena = TELEFON_CENA_4;
		else
			cena = TELEFON_CENA_5;

		if(PremiumInfo[playerid][pMC] < cena)
		{
			sendErrorMessage(playerid, "Nie staæ Ciê na ten numer telefonu");
			return DialogTelefon(playerid);
		}

		ZabierzMC(playerid, cena);
		MRP_SetPlayerPhone(playerid, numer);

		_MruAdmin(playerid, sprintf("Twój nowy numer telefonu: %d.", numer));
		Log(premiumLog, INFO, "%s kupil numer telefonu %d za %dMC.",
			GetPlayerLogName(playerid), numer, cena);

		premium_printMcBalance(playerid);
		DialogMenuDotacje(playerid);
	}
	else
	{
		sendErrorMessage(playerid, "Ten numer jest ju¿ zajêty!");
		return DialogTelefon(playerid);
	}

	return 1;
}

//---< Is >---
IsPlayerPremium(playerid)
{
	if(PremiumInfo[playerid][pKP] == 1)
		return 1;
	return 0;
}

IsPlayerPremiumOld(playerid)
{
	if(PremiumInfo[playerid][pKP] == 1)
		return 1;
	if(PlayerInfo[playerid][OldDonateRank] != 0)
		return 1;
	return 0;
}

stock IsAUnikatowyPojazd(modelid)
{
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
		if(modelid == PojazdyPremium[i][Model])
			return 1;
	return 0;
}

PlayerHasSkin(playerid, skin)
{
	return VECTOR_find_val(VPremiumSkins[playerid], skin) != INVALID_VECTOR_INDEX;
}

IsAMCGiver(playerid) {
	if(!dini_Exists(MC_GIVER_FILE)) return false;
	return dini_Int(MC_GIVER_FILE, "uid") == PlayerInfo[playerid][UID];
}

GetAvaibleMC() {
	if(!dini_Exists(MC_GIVER_FILE)) return 0;
	return dini_Int(MC_GIVER_FILE, "budget");
}

TakeMCFromBudget(value) {
	return dini_IntSet(MC_GIVER_FILE, "budget", GetAvaibleMC()-value);
}


//end