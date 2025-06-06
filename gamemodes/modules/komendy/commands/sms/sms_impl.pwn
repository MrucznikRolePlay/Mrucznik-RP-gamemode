//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sms_Impl(playerid, params[256])
{
    new string[256];
	new smsCost; 
	new givePlayerNumber, messSMS[128]; 
	//Sprawdzanie - check
	if(sscanf(params, "ds[128]", givePlayerNumber, messSMS))
	{
		sendTipMessage(playerid, "U�yj /sms [numer] [tre��]");
		return 1;
	}
	if(PlayerInfo[playerid][pJailed] != 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu w wi�zieniu!"); 
		return 1;
	}
	if(isPlayerCuffed[playerid])
	{
		sendErrorMessage(playerid, "Nie mo�esz u�ywa� telefonu podczas bycia skutym!");
		return 1;
	}
	if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu! Kup go w sklepie.");
		return 1;
	}
	if(PhoneOnline[playerid] == 1)
	{
		sendTipMessage(playerid, "Tw�j telefon jest wy��czony! W��cz go za pomoc� /togtel");
		return 1;
	}
	if(givePlayerNumber <= 0)
	{
		SendClientMessage(playerid, -1, "S�ycha� g�uchy ton");
		return 1; 
	}
	if(strlen(messSMS) > 105)
	{
		sendErrorMessage(playerid, "Twoja wiadomo�� by�a zbyt d�uga, skr�� j�!"); 
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
		if(kaska[playerid] < smsCost)
		{
			sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci �rodk�w!"); 
			return 1;
		}
		//All its okay, continue code:
		new giveMoneyForWorker = (smsCost/2)/SanWorkers; 
		Sejf_Add(FRAC_SN, (smsCost/2)); 
		Sejf_Save(FRAC_SN); 
		ZabierzKase(playerid, smsCost); 
		format(string, sizeof(string), "Dodatkowy koszt p�atnego SMS: %d$", smsCost);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "* %s wyjmuje telefon i wysy�a wiadomo��.", GetNick(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    Log(chatLog, INFO, "%s sms SAN %d: %s", GetPlayerLogName(playerid), givePlayerNumber, messSMS);
		foreach(new i : Player)
		{
			if(GetPlayerFraction(i) == FRAC_SN)
			{
				if(SanDuty[i] == 1)
				{
					SendSMSMessage(PlayerInfo[playerid][pPnumber], i, messSMS);
					format(string, sizeof(string), "P�atny SMS wygenerowa�: %d$, czyli %d$ dla ka�dego i %d$ do sejfu", smsCost, giveMoneyForWorker, (smsCost/2));
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
		smsCost = 50; //Przypisanie wato�ci koszta sms
		new checkNumberPlayer = FindPlayerByNumber(givePlayerNumber);
		
		if(checkNumberPlayer == INVALID_PLAYER_ID)
		{
			SendClientMessage(playerid, COLOR_GREY, "Nie uda�o si� wys�a� wiadomo�ci - gracz o takim numerze jest offline.");
			return 1;
		}
		
		if(PhoneOnline[checkNumberPlayer] == 1)
		{
			sendErrorMessage(playerid, "Nie uda�o si� wys�a� wiadomo�ci - gracz ma wy��czony telefon.");
			return 1;
		}
		if(kaska[playerid] < smsCost)
		{
			format(string, sizeof(string), "Koszt tego SMS wynosi: %d$, nie masz a� tylu pieni�dzy.", smsCost);
			sendErrorMessage(playerid, string);
			return 1;
		}
		format(string, sizeof(string), "* %s wyjmuje telefon i wysy�a wiadomo��.", GetNick(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    Log(chatLog, INFO, "%s sms do %s: %s", GetPlayerLogName(playerid), GetPlayerLogName(checkNumberPlayer), messSMS);
		SavePlayerSentMessage(playerid, sprintf("%s wys�a� SMS do %s: %s", GetNick(playerid), GetNick(checkNumberPlayer), messSMS), FROMME);
		SavePlayerSentMessage(checkNumberPlayer, sprintf("%s otrzyma� SMS od %s: %s", GetNick(checkNumberPlayer), GetNick(playerid), messSMS), TOME);
		if(PlayerInfo[playerid][pPodPW] == 1 || PlayerInfo[checkNumberPlayer][pPodPW] == 1) //podgl?d admina
        {
            format(string, sizeof(string), "AdmCmd -> %s(%d) /sms -> %s(%d): %s", GetNick(playerid), playerid, GetNick(checkNumberPlayer), checkNumberPlayer, messSMS);
            ABroadCast(COLOR_YELLOW,string,1,1);
        }
		new slotKontaktu = PobierzSlotKontaktuPoNumerze(playerid, givePlayerNumber);
		if(slotKontaktu >= 0)
		{
			format(string, sizeof(string), "Wys�ano SMS: %s, Odbiorca: %s (%d).", messSMS, Kontakty[playerid][slotKontaktu][eNazwa], givePlayerNumber);
		}
		else
		{
			format(string, sizeof(string), "Wys�ano SMS: %s, Odbiorca: %d.", messSMS, givePlayerNumber);
		}
		SendClientMessage(playerid, COLOR_YELLOW, string);
		//pob�r op�at
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "~r~$-%d", smsCost);
		GameTextForPlayer(playerid, string, 5000, 1);
		ZabierzKase(playerid, smsCost);
		SendClientMessage(playerid, COLOR_WHITE, "Wiadomo�� dostarczona.");
		SendSMSMessage(PlayerInfo[playerid][pPnumber], checkNumberPlayer, messSMS);
		return 1;
	}
	if(givePlayerNumber == 555)
	{
		if(strcmp("tak", messSMS, true) == 0)
		{
			SendSMSMessage(555, playerid, "Nie mam poj�cia o czym m�wisz");
		}
		else
		{
			SendSMSMessage(555, playerid, "To proste napisz tak");
		}
	}
	return 1;
}

//end
