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

CMD:txt(playerid, params[]) return cmd_sms(playerid, params);
CMD:t(playerid, params[]) return cmd_sms(playerid, params);
CMD:sms(playerid, params[])
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
		kosztSMS += numerLinii*100;
		
        if(gSNLockedLine[numerLinii] || liczbaPracownikowSAN == 0) 
		{
			GameTextForPlayer(playerid, "~r~Linia zamknieta", 5000, 1);
			return 1;
		}
		else
		{
			zarobekPracownikaSAN = kosztSMS/liczbaPracownikowSAN;
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
		foreach(Player, i)
		{
			if(GetPlayerFraction(i) == FRAC_SN)
			{
				if(SanDuty[i] == 1)
				{
					SendSMSMessage(PlayerInfo[playerid][pPnumber], i, wiadomosc);
					format(string, sizeof(string), "P³atny SMS wygenerowa³: %d$, czyli %d$ dla ka¿dego", kosztSMS, zarobekPracownikaSAN);
					SendClientMessage(i, COLOR_YELLOW, string);
					DajKase(i, zarobekPracownikaSAN);
				}
			}
		}
	}
	else if(numerTelefonuOdbiorcy != 555) 
	{//zwyk³y sms
		SendSMSMessage(PlayerInfo[playerid][pPnumber], reciverid, wiadomosc);
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


