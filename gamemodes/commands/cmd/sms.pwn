//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ sms ]--------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/
YCMD:sms(playerid, params[], help)
{
	new string[256];
	new smsCost; 
	new givePlayerNumber, messSMS[128]; 
	//Sprawdzanie - check
	if(sscanf(params, "ds[128]", givePlayerNumber, messSMS))
	{
		sendTipMessage(playerid, "U¿yj /sms [numer] [treœæ]");
		return 1;
	}
	if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu! Kup go w sklepie.");
		return 1;
	}
	if(PhoneOnline[playerid] == 1)
	{
		sendTipMessage(playerid, "Twój telefon jest wy³¹czony! W³¹cz go za pomoc¹ /togtel");
		return 1;
	}
	if(givePlayerNumber <= 0)
	{
		SendClientMessage(playerid, -1, "S³ychaæ g³uchy ton");
		return 1; 
	}
	//Sprawdzanie czy to numer do SN
	if(givePlayerNumber >= 100 && givePlayerNumber <= 150)
	{
		new SanWorkers = GetFractionMembersNumber(FRAC_SN, true);
		if(givePlayerNumber == 100)
		{
			smsCost = COST_SN_SMS_0; 
		}
		if(givePlayerNumber == 110)
		{
			smsCost = COST_SN_SMS_1; 
		}
		if(givePlayerNumber == 120)
		{
			smsCost = COST_SN_SMS_2; 
		}
		if(givePlayerNumber == 130)
		{
			smsCost = COST_SN_SMS_3; 
		}
		if(givePlayerNumber == 140)
		{
			smsCost = COST_SN_SMS_4; 
		}
		if(givePlayerNumber == 150)
		{
			smsCost = COST_SN_SMS_5; 
		}
		if(gSNLockedLine[givePlayerNumber-100] || SanWorkers == 0) 
		{
			GameTextForPlayer(playerid, "~r~Linia zamknieta", 5000, 1);
			return 1;
		}
		if(GetPlayerMoney(playerid) < smsCost)
		{
			sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci œrodków!"); 
			return 1;
		}
		//All its okay, continue code:
		new giveMoneyForWorker = smsCost/SanWorkers; 
		Sejf_Add(FRAC_SN, (smsCost/2)); 
		Sejf_Save(FRAC_SN); 
		ZabierzKase(playerid, smsCost); 
		format(string, sizeof(string), "Dodatkowy koszt p³atnego SMS: %d$", smsCost);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "* %s wyjmuje telefon i wysy³a wiadomoœæ.", GetNick(playerid, true));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		foreach(new i : Player)
		{
			if(GetPlayerFraction(i) == FRAC_SN)
			{
				if(SanDuty[i] == 1)
				{
					SendSMSMessage(PlayerInfo[playerid][pPnumber], i, messSMS);
					format(string, sizeof(string), "P³atny SMS wygenerowa³: %d$, czyli %d$ dla ka¿dego", smsCost, giveMoneyForWorker);
					SendClientMessage(i, COLOR_YELLOW, string);
					DajKase(i, giveMoneyForWorker);
				}
			}
		}
		return 1;
	}
	//Normal SMS
	if(givePlayerNumber != 555) 
	{
		smsCost = 450; //Przypisanie watoœci koszta sms
		new checkNumberPlayer = FindPlayerByNumber(givePlayerNumber);
		
		if(checkNumberPlayer == INVALID_PLAYER_ID)
		{
			SendClientMessage(playerid, COLOR_GREY, "Nie uda³o siê wys³aæ wiadomoœci - gracz o takim numerze jest offline.");
			return 1;
		}
		
		if(PhoneOnline[checkNumberPlayer] == 1)
		{
			sendErrorMessage(playerid, "Nie uda³o siê wys³aæ wiadomoœci - gracz ma wy³¹czony telefon.");
			return 1;
		}
		if(kaska[playerid] < smsCost)
		{
			format(string, sizeof(string), "Koszt tego SMS wynosi: %d$, nie masz a¿ tylu pieniêdzy.", smsCost);
			sendErrorMessage(playerid, string);
			return 1;
		}
		format(string, sizeof(string), "* %s wyjmuje telefon i wysy³a wiadomoœæ.", GetNick(playerid, true));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		new slotKontaktu = PobierzSlotKontaktuPoNumerze(playerid, givePlayerNumber);
		if(slotKontaktu >= 0)
		{
			format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %s (%d).", messSMS, Kontakty[playerid][slotKontaktu][eNazwa], givePlayerNumber);
		}
		else
		{
			format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %d.", messSMS, givePlayerNumber);
		}
		SendClientMessage(playerid, COLOR_YELLOW, string);
		
		//pobór op³at
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "~r~$-%d", smsCost);
		GameTextForPlayer(playerid, string, 5000, 1);
		ZabierzKase(playerid, smsCost);
		SendClientMessage(playerid, COLOR_WHITE, "Wiadomoœæ dostarczona.");
		SendSMSMessage(PlayerInfo[playerid][pPnumber], checkNumberPlayer, messSMS);
		return 1;
	}
	if(givePlayerNumber == 555)
	{
		if(strcmp("tak", messSMS, true) == 0)
		{
			SendSMSMessage(555, playerid, "Nie mam pojêcia o czym mówisz");
		}
		else
		{
			SendSMSMessage(555, playerid, "To proste napisz tak");
		}
	}
	return 1;
}

/*
Stare SMS
YCMD:sms(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));

	new numerTelefonuOdbiorcy, wiadomosc[128];
	if( sscanf(params, "ds[128]", numerTelefonuOdbiorcy, wiadomosc))
	{
		sendTipMessage(playerid, "U¿yj /sms [numer telefonu] [wiadomoœæ]");
		return 1;
	}
	if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu.");
		return 1;
	}
	if(PhoneOnline[playerid] == 1)
	{
		sendErrorMessage(playerid, "Twój telefon jest wy³¹czony. Wpisz /togtel aby go w³¹czyæ.");
		return 1;
	}
	if(numerTelefonuOdbiorcy <= 0)
	{
		sendErrorMessage(playerid, "Niepoprawny numer telefonu.");
		return 1;
	}
	
	new kosztSMS = txtcost;
	new zarobekPracownikaSAN;
	new reciverid;
	if(numerTelefonuOdbiorcy >= 100 && numerTelefonuOdbiorcy <= 150) 
	{
		new numerLinii = numerTelefonuOdbiorcy-100;
		new liczbaPracownikowSAN = GetFractionMembersNumber(FRAC_SN, true);
		//kosztSMS += numerLinii*100;
		//Ustawianie koszta sms
		if(numerTelefonuOdbiorcy == 100)
		{
			kosztSMS = COST_SN_SMS_0; 
		}
		if(numerTelefonuOdbiorcy == 110)
		{
			kosztSMS = COST_SN_SMS_1; 
		}
		if(numerTelefonuOdbiorcy == 120)
		{
			kosztSMS = COST_SN_SMS_2; 
		}
		if(numerTelefonuOdbiorcy == 130)
		{
			kosztSMS = COST_SN_SMS_3; 
		}
		if(numerTelefonuOdbiorcy == 140)
		{
			kosztSMS = COST_SN_SMS_4; 
		}
		if(numerTelefonuOdbiorcy == 150)
		{
			kosztSMS = COST_SN_SMS_5; 
		}
        if(gSNLockedLine[numerLinii] || liczbaPracownikowSAN == 0) 
		{
			GameTextForPlayer(playerid, "~r~Linia zamknieta", 5000, 1);
			return 1;
		}
		else
		{
			zarobekPracownikaSAN = kosztSMS/liczbaPracownikowSAN;
			zarobekPracownikaSAN = zarobekPracownikaSAN/2;
		}
	}
	//zwyk³y sms
	else if(numerTelefonuOdbiorcy != 555) 
	{
		reciverid = FindPlayerByNumber(numerTelefonuOdbiorcy);
		
		if(reciverid == INVALID_PLAYER_ID)
		{
			SendClientMessage(playerid, COLOR_GREY, "Nie uda³o siê wys³aæ wiadomoœci - gracz o takim numerze jest offline.");
			return 1;
		}
		
		if(PhoneOnline[reciverid] == 1)
		{
			sendErrorMessage(playerid, "Nie uda³o siê wys³aæ wiadomoœci - gracz ma wy³¹czony telefon.");
			return 1;
		}
	}
	
	if(kaska[playerid] < kosztSMS)
	{
		format(string, sizeof(string), "Koszt tego SMS wynosi: %d$, nie masz a¿ tylu pieniêdzy.", kosztSMS);
		sendErrorMessage(playerid, string);
		return 1;
	}
	
	
	//all ok - wysy³anie wiadomoœci
	format(string, sizeof(string), "* %s wyjmuje telefon i wysy³a wiadomoœæ.", sendername);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	
	
	//wysy³anie do odbiorcy
	if(numerTelefonuOdbiorcy >= 100 && numerTelefonuOdbiorcy <= 150) 
	{//linia SAN 
		format(string, sizeof(string), "Dodatkowy koszt p³atnego SMS: %d$", kosztSMS - txtcost);
		SendClientMessage(playerid, COLOR_WHITE, string);
		
		//wysy³anie wiadomoœci + hajs dla SN
		foreach(new i : Player)
		{
			if(GetPlayerFraction(i) == FRAC_SN)
			{
				if(SanDuty[i] == 1)
				{
					SendSMSMessage(PlayerInfo[playerid][pPnumber], i, wiadomosc);
					format(string, sizeof(string), "P³atny SMS wygenerowa³: %d$, czyli %d$ dla ka¿dego", kosztSMS, zarobekPracownikaSAN);
					SendClientMessage(i, COLOR_YELLOW, string);
					DajKase(i, zarobekPracownikaSAN);
					Sejf_Add(FRAC_SN, kosztSMS/2);
					Sejf_Save(FRAC_SN); 
				}
			}
		}
	}
	else if(numerTelefonuOdbiorcy != 555) 
	{//zwyk³y sms
		SendSMSMessage(PlayerInfo[playerid][pPnumber], reciverid, wiadomosc);
		format(string, sizeof(string), "* %s - wibruje mu telefon - przyszed³ SMS", GetNick(reciverid, true));
		ProxDetector(30.0, reciverid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	
	//informacja zwrotna dla nadawcy
	new slotKontaktu = PobierzSlotKontaktuPoNumerze(playerid, numerTelefonuOdbiorcy);
	if(slotKontaktu >= 0)
	{
		format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %s (%d).", wiadomosc, Kontakty[playerid][slotKontaktu][eNazwa], numerTelefonuOdbiorcy);
	}
	else
	{
		format(string, sizeof(string), "Wys³ano SMS: %s, Odbiorca: %d.", wiadomosc, numerTelefonuOdbiorcy);
	}
	SendClientMessage(playerid, COLOR_YELLOW, string);
	
	//pobór op³at
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof(string), "~r~$-%d", kosztSMS);
	GameTextForPlayer(playerid, string, 5000, 1);
	ZabierzKase(playerid, kosztSMS);
	SendClientMessage(playerid, COLOR_WHITE, "Wiadomoœæ dostarczona.");
	
	//mole autoodpowiedŸ
	if(numerTelefonuOdbiorcy == 555)
	{
		if(strcmp("tak", wiadomosc, true) == 0)
		{
			SendSMSMessage(555, playerid, "Nie mam pojêcia o czym mówisz");
		}
		else
		{
			SendSMSMessage(555, playerid, "To proste napisz tak");
		}
	}
	return 1;
}
*/ 