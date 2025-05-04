//OnDialogResponse.pwn


IsDialogProtected(dialogid)
{
    switch(dialogid)
    {
        case D_PANEL_KAR_NADAJ..D_PANEL_KAR_ZNAJDZ_INFO, D_PERM, D_PANEL_CHECKPLAYER, D_EDIT_RANG_NAME, D_OPIS_UPDATE, D_VEHOPIS_UPDATE: return true;
    }
    return false; //dodac dialogi z mysql
}

CheckDialogId(playerid, dialogid)
{
    if(dialogid < 0) return 0;
	if(dialogid != iddialog[playerid])
    {
        if(dialogid > 10000 && dialogid < 10100) return 0;
        GUIExit[playerid] = 0;
        SendClientMessage(playerid, COLOR_RED, "B��dne ID GUI.");
        Log(serverLog, WARNING, "B��dne ID dialogu dla [%d] aktualny [%d] przypisany %d", playerid, dialogid, iddialog[playerid]);
        return 0;
    }
	return 1;
}

//ID DIALOG�W 9900+ BIZNESY.
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(!CheckDialogId(playerid, dialogid)) return 1;

    if(IsDialogProtected(dialogid) || true) //MySQL anti injection
    {
		for(new i; i<strlen(inputtext); i++)
		{
			if(inputtext[i] == '%')
			{
                SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na posiada� \"%\" w ha�le");
				KickEx(playerid, "niepoprawne has�o");
				return 0;
            }
		}
    }
	if(antyHider[playerid] != 1)
	{
		if(gettime() > GetPVarInt(playerid, "lastDialogCzitMsg"))
		{
			SetPVarInt(playerid, "lastDialogCzitMsg", gettime() + 60);
			new string[128];
			format(string, sizeof(string), "AdmWarn: %s[%d] <- ten gnoj czituje dialogi sprawdzcie co robi (DialogID: [%d]) ", GetNick(playerid), playerid, dialogid);
			SendAdminMessage(COLOR_YELLOW, string);	
		}
		return 1;
	}

	antyHider[playerid] = 0;
	
	//2.6.19
	if(dialogid == DIALOG_EATING)
	{
		if(response)
		{
			zjedz_OnDialogResponse(playerid, listitem);
		}
		return 1;
	}
	if(dialogid == DIALOG_COOKING)
	{
		if(response)
		{
			ugotuj_OnDialogResponse(playerid, listitem);
		}
		return 1;
	}

	//2.5.8
	premium_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	hq_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);


	//2.6.18
	ibiza_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);

	//2.6.19
	graffiti_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	if(biznesy_OnDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(attachemnts_OnDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(pojazdy_OnDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(command_transport_OnDialogResp(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(cmd_organizacje_OnDialogResp(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(BuyOrgSkinDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;
	if(SellOrgSkinDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;

	if(GunShop_OnDialogResponse(playerid, dialogid, response, listitem, inputtext)) return 1;

	if(dialogid == 9145)
	{
		if(response)
		{
			new cena_naprawy = 7500;
			if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
			{
				cena_naprawy /= 2;
			}
			sendTipMessageFormat(playerid, "Zap�aci�e� $%d za wizyt� w warsztacie", cena_naprawy);
			ZabierzKase(playerid, cena_naprawy);
			RepairVehicle(GetPlayerVehicleID(playerid));
			naprawiony[playerid] = 1;
			SetTimerEx("Naprawianie",10000,0,"d",playerid);

			// give 50% of the money to the owner of the spray
			new bizId = IsPlayerAtFrontBusinnesZone(playerid);
			if(bizId != -1)
			{
				GenerateFrontBusinessIncome(bizId, cena_naprawy/2);
			}
		}
	}

	//2.7.5 - nadal nie 3.0
	if(dialogid == DIALOGID_UNIFORM_FRAKCJA)
	{
		if(response)
		{
			new frac = GetPlayerFraction(playerid);
			if(frac == 0 && GetPlayerJob(playerid) == JOB_MEDIC) frac = FRAC_ERS;

			new string[64];
			new skin = FRAC_SKINS[frac][listitem];
			SetPlayerSkinEx(playerid, skin);
			PlayerInfo[playerid][pUniform] = skin;
			format(string, sizeof(string), "* %s zdejmuje ubrania i zak�ada nowe.", GetNick(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	else if(dialogid == DIALOGID_UNIFORM_FAMILY)
	{
		if(response)
		{
			new string[64];
			new skin = OrgSkins[GetPlayerOrg(playerid)][listitem];
			SetPlayerSkinEx(playerid, skin);
			PlayerInfo[playerid][pUniform] = skin;
			format(string, sizeof(string), "* %s zdejmuje ubrania i zak�ada nowe.", GetNick(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	//2.5.2
	else if(dialogid == DIALOG_HA_ZMIENSKIN(0))
	{
		if(response)
		{
			if(FRAC_SKINS[listitem+1][0] == 0)
			{
				sendErrorMessage(playerid, "Ta frakcja nie ma skin�w");
				ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(0), DIALOG_STYLE_LIST, "Zmiana ubrania", DialogListaFrakcji(), "Start", "Anuluj");
				return 1;
			}
			ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(listitem+1), DIALOG_STYLE_PREVMODEL, "Zmiana ubrania", DialogListaSkinow(listitem+1), "Start", "Anuluj");
		}
	}
	else if(dialogid >= DIALOG_HA_ZMIENSKIN(1) && dialogid <= DIALOG_HA_ZMIENSKIN(MAX_FRAC))
	{
		if(response)
		{
			new string[64];
			SetPlayerSkinEx(playerid, FRAC_SKINS[dialogid-DIALOG_HA_ZMIENSKIN(0)][listitem]);
			format(string, sizeof(string), "* %s zdejmuje ubrania i zak�ada nowe.", GetNick(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(0), DIALOG_STYLE_LIST, "Zmiana ubrania", DialogListaFrakcji(), "Start", "Anuluj");
		}
	}
	else if(dialogid == 9520)
	{
	    new kasa = GetPVarInt(playerid, "Mats-kasa");
        new giveplayerid = GetPVarInt(playerid, "Mats-id");
        new moneys = GetPVarInt(playerid, "Mats-mats");
        new string[256];
		if(!response)
		{
		    SetPVarInt(playerid, "OKupMats", 0);
			SetPVarInt(giveplayerid, "OSprzedajMats", 0);
			SetPVarInt(playerid, "Mats-kasa", 0);
        	SetPVarInt(playerid, "Mats-id", 0);
        	SetPVarInt(playerid, "Mats-mats", 0);
        	sendErrorMessage(playerid, "Sprzeda� zosta�a anulowana!");
        	sendErrorMessage(giveplayerid, "Sprzeda� zosta�a anulowana!");
			return 1;
		}
		if(kaska[playerid] < kasa) return sendErrorMessage(playerid, "Nie masz tyle kasy!");
		if(PlayerInfo[giveplayerid][pMats] < moneys) return sendErrorMessage(playerid, "Gracz nie ma tyle materia��w!");
		if(GetPVarInt(playerid, "OKupMats") == 0) return sendErrorMessage(playerid, "Co� posz�o nie tak! (kupno)");
        //if(GetPVarInt(playerid, "OSprzedajMats") == 0) return sendErrorMessage(playerid, "Co� posz�o nie tak! (sprzeda�)");
		if(GetPVarInt(giveplayerid, "OSprzedajMats") == 1)
		{
			format(string, sizeof(string), "   Dosta�e� %d materia��w od gracza %s za %d $.", moneys, GetNick(giveplayerid), kasa);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "   Da�e� %d materia��w graczowi %s za %d $.", moneys, GetNick(playerid), kasa);
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string),"%s da� %s torb� z materia�ami.", GetNick(giveplayerid), GetNick(playerid));
			ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			PlayerInfo[giveplayerid][pMats] -= moneys;
			PlayerInfo[playerid][pMats] += moneys;
			DajKase(giveplayerid, kasa);
			ZabierzKase(playerid, kasa);
			
			Log(payLog, INFO, "%s kupi� od %s materia�y w ilo�ci %d za %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), moneys, kasa);
			SetPVarInt(playerid, "OKupMats", 0);
			SetPVarInt(giveplayerid, "OSprzedajMats", 0);
			SetPVarInt(playerid, "Mats-kasa", 0);
        	SetPVarInt(playerid, "Mats-id", 0);
        	SetPVarInt(playerid, "Mats-mats", 0);
			
		}
		else
		{
		    sendErrorMessage(playerid, "Co� posz�o nie tak! (sprzeda�)");
		}
	}
	else if(dialogid == 9519)
	{
		if(!response) return 1;
		if(kaska[playerid] < 30000) return sendErrorMessage(playerid, "Nie masz tyle kasy");
		SetPlayerArmour(playerid, 90);
		SetPlayerHealth(playerid, 100);
		ZabierzKase(playerid, 30000);
		sendTipMessage(playerid, "Zaplaciles $30000 za kamizelke i �ycie");
	}	
	else if(dialogid == 9521) //kara warn
	{
		new giveplayerid = GetPVarInt(playerid, "PunishWarnPlayer");
		new string[256];
		if(!response) return sendTipMessage(playerid, sprintf("* Anulowano nadawanie kary warna dla %s.", GetNick(giveplayerid)));
		if(response && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid)))
		{
			new reason[64];
			GetPVarString(playerid, "PunishWarnPlayer_Reason", reason, sizeof(reason));
			format(string, sizeof string, "{FFFFFF}Gracz: {B7EB34}%s\n{FFFFFF}Pow�d warna: {B7EB34}%s{FFFFFF}\n\nWybierz typ kary - WARN czy WARN + KICK", GetNick(giveplayerid), reason);		
			ShowPlayerDialogEx(playerid, 9523, DIALOG_STYLE_MSGBOX, "Nadawanie warna", string, "Warn", "Warn + Kick");
		}
		return 1;
	}
	else if(dialogid == 9522) //kara ban
	{
		new giveplayerid = GetPVarInt(playerid, "PunishBanPlayer");
		if(!response) return sendTipMessage(playerid, sprintf("* Anulowano nadawanie kary bana dla %s.", GetNick(giveplayerid)));
		if(response && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 4 || IsAScripter(playerid)))
		{
			new reason[64], string[256];
			GetPVarString(playerid, "PunishBanPlayer_Reason", reason, sizeof(reason));
			GiveBanForPlayer(giveplayerid, playerid, reason);
			DeletePVar(playerid, "PunishBanPlayer");
			DeletePVar(playerid, "PunishBanPlayer_Reason");

			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscBan[playerid]++;
			}
			else if(GetPlayerAdminDutyStatus(playerid) == 0)
			{
				iloscPozaDuty[playerid]++; 
			}
			if(kary_TXD_Status == 1)
			{
				BanPlayerTXD(giveplayerid, reason); 
			}
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "AdmCmd: Admin zbanowa� %s, pow�d: %s", GetNick(giveplayerid), reason);
				SendPunishMessage(string, playerid); 
			}		
		}
		return 1;
	}
	else if(dialogid == 9523) //kara warn - typ warna
	{
		new giveplayerid = GetPVarInt(playerid, "PunishWarnPlayer");
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
		{
			new reason[64], string[256];
			GetPVarString(playerid, "PunishWarnPlayer_Reason", reason, sizeof(reason));
			GiveWarnForPlayer(giveplayerid, playerid, reason, response);
			DeletePVar(playerid, "PunishWarnPlayer");
			DeletePVar(playerid, "PunishWarnPlayer_Reason");

			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				if(PlayerInfo[giveplayerid][pWarns] >= 3)
				{
					iloscBan[playerid]++;
				}
				else
				{
					iloscWarn[playerid] = iloscWarn[playerid]+1;
				}
			}
			else
			{
				iloscPozaDuty[playerid]++; 
			}

			if(kary_TXD_Status == 1)
			{
				if(PlayerInfo[giveplayerid][pWarns] >= 3)
				{
					format(string, sizeof(string), "%s (3 warny)", reason);
					BanPlayerTXD(giveplayerid, string); 
				}
				else 
				{
					WarnPlayerTXD(giveplayerid, playerid, reason);
				}
			}
			else if(kary_TXD_Status == 0)
			{
				if(PlayerInfo[giveplayerid][pWarns] >= 3)
				{
					format(string, sizeof(string), "AdmCmd: %s zosta� zbanowany przez admina %s, pow�d: %s (3 warny)", GetNickEx(giveplayerid), GetNickEx(playerid), reason); 
				}
				else
				{
					format(string, sizeof(string), "AdmCmd: %s zosta� zwarnowany przez admina %s, pow�d: %s", GetNickEx(giveplayerid), GetNickEx(playerid), reason); 
				}
				SendPunishMessage(string, playerid); 
			}
		}
		return 1;
	}
	else if(dialogid == 6999)//vinyl panel
	{
		if(!response) return 1;
		if(response)
		{
			switch(listitem)
			{
				case 0://Open/Close/nUstal cene Norm./nUstal cene VIP/nUstal cene napoi\nUstal nazwe napoi
				{
					if(vinylStatus == 0)
					{
						vinylStatus = 1; 
						sendTipMessage(playerid, "Otworzy�e�/a� vinyl Club!");
					}
					else if(vinylStatus == 1)
					{
						vinylStatus = 0; 
						sendTipMessage(playerid, "Zamkn��e�/a� vinyl Club!"); 
					}
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Laptop Lidera", "Wprowad� poni�ej kwot�, kt�ra kto� b�dzie musia� zap�aci� za bilet Normalny", "Wybierz", "Odrzu�");
					SetPVarInt(playerid, "b-wybor", 1);
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Laptop Lidera", "Wprowad� poni�ej kwot�, kt�ra kto� b�dzie musia� zap�aci� za bilet VIP", "Wybierz", "Odrzu�");
					SetPVarInt(playerid, "b-wybor", 2);
				}
				case 3:
				{
					ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Laptop Lidera", "Wprowad� poni�ej numer napoju,\ndla kt�rego chcesz zmieni� cen�", "Potwierd�", "Anuluj"); 
					SetPVarInt(playerid, "b-wybor", 3); 
				}
				case 4:
				{
					ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Laptop Lidera", "Wprowad� poni�ej numer napoju,\ndla kt�rego chcesz zmieni� nazw�", "Potwierd�", "Anuluj"); 
					SetPVarInt(playerid, "b-wybor", 6); 
				}
			}
		}
	}
	else if(dialogid == 6998)//vinyl input
	{
		if(!response) return 1;
		if(response)
		{
			if(GetPVarInt(playerid, "b-wybor") == 7) // zmiana nazwy - podaj nazwe
			{
				new drinkID = GetPVarInt(playerid, "b-wprowadzil"); 
				if(strlen(inputtext) <= 31)
				{
					format(vinylDrinkNames[drinkID], 32, inputtext);
					sendTipMessage(playerid, "Pomy�lnie zmieniono nazw� drinka!"); 
				}
				else
				{
					sendErrorMessage(playerid, "Nieprawid�owa d�ugo�� nazwy napoju [MAX 31 znakow]");
				}
				DeletePVar(playerid, "b-wybor");
				DeletePVar(playerid, "b-wprowadzil");
				return 1;
			}
			if(GetPVarInt(playerid, "b-wybor") == 6) // zmiana nazwy - podaj id drinka
			{
				new drinkID = strval(inputtext)-1; 
				SetPVarInt(playerid, "b-wprowadzil", drinkID); 
				new string[124]; 
				if (drinkID < 0 || drinkID > 3) {
					sendErrorMessage(playerid, "Nieprawid�owe ID drinka"); 
					return 1;
				}
				format(string, sizeof(string), "Wprowad� poni�ej now� nazw� dla napoju: %s,\nAktualna cena to: $%d", vinylDrinkNames[drinkID], vinylDrinkCosts[drinkID]);
				ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Panel lidera", string, "Akceptuj", "Odrzu�"); 
				SetPVarInt(playerid, "b-wybor", 7); 
				return 1;
			}
			if(GetPVarInt(playerid, "b-wybor") == 5) // zmiana ceny - podaj cene
			{
				new drinkID = GetPVarInt(playerid, "b-wprowadzil"); 
				new drinkCost = FunkcjaK(inputtext); 
				new string[124]; 
				if(drinkCost > 100000 || drinkCost <= 1)
				{
					sendErrorMessage(playerid, "Nieprawid�owa nowa cena drinka!"); 
					return 1;
				}
				vinylDrinkCosts[drinkID] = drinkCost;
				format(string, sizeof(string), "Zmieni�e� cen� napoju %s. Nowa cena to: %d", vinylDrinkNames[drinkID], drinkCost); 
				sendTipMessage(playerid, string);
				DeletePVar(playerid, "b-wybor");
				DeletePVar(playerid, "b-wprowadzil");
				return 1;
			}
			if(GetPVarInt(playerid, "b-wybor") == 3) // zmiana ceny - podaj id drinka
			{
				new drinkID = strval(inputtext)-1;
				SetPVarInt(playerid, "b-wprowadzil", drinkID); 
				new string[124];
				if (drinkID < 0 || drinkID > 3) {
					sendErrorMessage(playerid, "Nieprawid�owe ID drinka"); 
					return 1;
				}
				format(string, sizeof(string), "Wprowad� poni�ej now� cen� dla napoju: %s,\nAktualna cena to: $%d", vinylDrinkNames[drinkID], vinylDrinkCosts[drinkID]);
				SetPVarInt(playerid, "b-wybor", 5);
				ShowPlayerDialogEx(playerid, 6998, DIALOG_STYLE_INPUT, "Laptop Lidera", string, "Dalej", "Odrzu�");
				return 1;
			}
			new cValue = FunkcjaK(inputtext);
			new string[124];
			if(cValue > 100 && cValue <= 500000)
			{
				if(GetPVarInt(playerid, "b-wybor") == 1)
				{
					vinylCenaNorm = cValue; 
					format(string, sizeof(string), "Nowa cena biletu zwyk�ego to: %d$", vinylCenaNorm);
					sendTipMessage(playerid, string); 
					return 1;
				}
				if(GetPVarInt(playerid, "b-wybor") == 2)
				{
					vinylCenaVIP = cValue; 
					format(string, sizeof(string), "Nowa cena biletu VIP to: %d$", vinylCenaVIP); 
					sendTipMessage(playerid, string); 
					return 1;
				}
			}
			else 
			{
				sendErrorMessage(playerid, "Koszt biletu od 100$ do 500.000$");
				return 1;
			}
		}
	}
	else if(dialogid == 6996)
	{
		if(!response)
		{
			sendTipMessage(playerid, "Wymi�kasz? Abstynent!");
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					BuyVinylDrink(playerid, 0, 2000, 22);
				}
				case 1:
				{
					BuyVinylDrink(playerid, 1, 2500, 22);
				}
				case 2:
				{
					BuyVinylDrink(playerid, 2, 4000, 20);
				}
				case 3:
				{
					BuyVinylDrink(playerid, 3, 5000, 20);
				}
				
			}
		}
	}
	else if(dialogid == 6997)
	{
		if(!response)
		{
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(kaska[playerid] >= vinylCenaNorm)
					{
						ZabierzKase(playerid, vinylCenaNorm); 
						SetPVarInt(playerid, "Vinyl-bilet", 1);//2 = VIP
						sendTipMessage(playerid, "Otrzyma�e� bilet zwyk�y do vinyl clubu");
						GenerateFrontBusinessIncome(40, vinylCenaNorm);
					}
					else 
					{
						sendErrorMessage(playerid, "Brak wystarczaj�cej kwoty!");
						return 1;
					}
				}
				case 1:
				{
					if(kaska[playerid] >= vinylCenaVIP)
					{
						ZabierzKase(playerid, vinylCenaVIP); 
						SetPVarInt(playerid, "Vinyl-bilet", 2);//2 = VIP
						sendTipMessage(playerid, "Otrzyma�e� bilet VIP do vinyl clubu");
						GenerateFrontBusinessIncome(40, vinylCenaVIP);
					}
					else 
					{
						sendErrorMessage(playerid, "Brak wystarczaj�cej kwoty!");
						return 1;
					}
				}
			}
		}
	}
	else if(dialogid == DIALOGID_MUZYKA) 
	{
		switch(listitem)
		{
			case 0:
			{
			    if(!response) return 1;
				PlayerFixRadio(playerid);
				PlayAudioStreamForPlayer(playerid, "http://4stream.pl:18434");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 1:
			{
				ShowViceCityRadioDialog(playerid, DIALOGID_MUZYKA_VC, "Odtwarzacz mp3.");
			}
			case 2:
			{
			    if(!response) return 1;
				PlayerFixRadio(playerid);
				PlayAudioStreamForPlayer(playerid, RadioSANUno);
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 3:
			{
			    if(!response) return 1;
				PlayerFixRadio(playerid);
				PlayAudioStreamForPlayer(playerid, RadioSANDos);
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 4:
			{
			    if(!response) return 1;
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, "http://zet-net-01.cdn.eurozet.pl:8400/listen.pls");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 5:
			{
				if(!response) return 1;
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, "http://www.miastomuzyki.pl/n/rmffm.pls");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 6:
			{
				if(!response) return 1;
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, "http://www.miastomuzyki.pl/n/rmfmaxxx.pls");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 7:
			{
				if(!response) return 1;
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, "https://waw01-03.ic.smcdn.pl/t092-1.mp3");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
				return 1;
			}
			case 8:
			{
				if(!response) return 1;
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, "http://4stream.pl:18214");
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
			}
			case 9:
			{
				if(!response) return 1;
				ShowPlayerDialogEx(playerid, DIALOGID_MUZYKA_URL, DIALOG_STYLE_INPUT, "W�asne MP3", "Wprowadz adres URL do radia/piosenki.", "Start", "Anuluj");
				return 1;
			}
			case 10:
			{
			    if(!response) return 1;
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~r~MP3 Off", 5000, 5);
				PlayerFixRadio(playerid);
				StopAudioStreamForPlayer(playerid);
				SetPVarInt(playerid, "SluchaBasenu", 0);
				DeletePVar(playerid, "HaveAMp3Stream");
				return 1;
			}
		}
	}
	else if(dialogid == DIALOGID_MUZYKA_URL)
	{
		if(response)
		{
			//if(IsAValidURL(inputtext))
			//{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, inputtext);
				SetPVarInt(playerid, "HaveAMp3Stream", 1);
			//}
			//else
			//{
			//	SendClientMessage(playerid, COLOR_GREY, "Z�y adres URL");
			//	ShowPlayerDialogEx(playerid, DIALOGID_MUZYKA_URL, DIALOG_STYLE_INPUT, "W�asne MP3", "Wprowadz adres URL do radia/piosenki.", "Start", "Anuluj");
			//}
		}
		return 1;
	}
	else if(dialogid == DIALOGID_MUZYKA_VC)
	{
		if(!response) return 1;
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, GetViceCityRadioStream(listitem));
		SetPVarInt(playerid, "HaveAMp3Stream", 1);
	}
    else if(dialogid == D_VEHOPIS)
    {
        if(!response) return 1;
        new id;
        if(strcmp(inputtext, "� Ustaw opis", false, 12) == 0) id = 1;
        else if(strcmp(inputtext, "� Zmie� opis", false, 12) == 0) id = 2;
        else if(strcmp(inputtext, "� Usu�", false, 6) == 0) id = 3;

		new veh = GetPlayerVehicleID(playerid);
		new isCarOwner = IsCarOwner(playerid, veh) || IsPlayerOwnFractionCar(playerid, veh);
		if(!isCarOwner) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale�y do Ciebie.");

        switch(id)
        {
            case 1:
            {
                if(strcmp(CarDesc[veh], "BRAK", true) == 0)
                {
                    RunCommand(playerid, "/vopis",  "");
                    SendClientMessage(playerid, COLOR_GRAD2, "Pojazd nie posiada opisu.");
                    return 1;
                }
                CarOpis_Usun(playerid, veh);

                new opis[128];
                format(opis, sizeof opis, "%s", CarDesc[veh]);
				ReColor(opis);
                Car3dTextDesc[veh] = CreateDynamic3DTextLabel(wordwrapEx(opis), COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, veh, 1, -1, -1, -1, 10.0);
                foreach(new p : Player)
				{
					if(!areVehicleDescTurnedOn[p])
					{
						Streamer_RemoveArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[veh], E_STREAMER_PLAYER_ID, p);
					}
				}
				format(CarOpisCaller[veh], MAX_PLAYER_NAME, "%s", GetNick(playerid));
                SendClientMessage(playerid, -1, "{99CC00}Ustawi�es w�asny opis pojazdu, by go usun�� wpisz {CC3333}/vopis usu�{CC3333}");
            }
            case 2:
            {
                ShowPlayerDialogEx(playerid, D_VEHOPIS_UPDATE, DIALOG_STYLE_INPUT, "Opis pojazdu", "Wprowad� ni�ej w�asny opis pojazdu.", "Ustaw", "Wr��");
            }
            case 3:
            {
                if(!CarOpis_Usun(playerid, GetPlayerVehicleID(playerid), true))
                {
                    SendClientMessage(playerid, -1, "Opis: Pojazd nie posiada opisu.");
                    RunCommand(playerid, "/vopis",  "");
                    return 1;
                }
                RunCommand(playerid, "/vopis",  "");
            }
        }
        return 1;
    }
    else if(dialogid == D_VEHOPIS_UPDATE)
    {
        if(!response) return RunCommand(playerid, "/vopis",  "");

		new veh = GetPlayerVehicleID(playerid);
		new isCarOwner = IsCarOwner(playerid, veh) || IsPlayerOwnFractionCar(playerid, veh);
		if(!isCarOwner) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale�y do Ciebie.");


        if(strlen(inputtext) < 4 || strlen(inputtext) > 120)
        {
            RunCommand(playerid, "/vopis",  "");
            SendClientMessage(playerid, COLOR_GRAD1, "Opis: Nieodpowiednia d�ugos� opisu.");
            return 1;
        }
		else
		{
			new givenString[128];
			format(givenString, sizeof(givenString), "%s", inputtext);
			if(strfind(givenString, "(FF0000)", true) != -1 || strfind(givenString, "(000000)", true) != -1)
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Znaleziono niedozwolony kolor.");
				return 1;
			}
			new startpos, endpos;
			if(regex_search(givenString, "[^a-zA-Z0-9����󜿟��ʣ�ӌ�� |\\/@:;+?!,.&\\(\\)\\[\\]\\-]", startpos, endpos) && startpos != -1 && endpos != -1)
			{
				SendClientMessage(playerid, COLOR_GRAD1, sprintf("Znaleziono niedozwolony znak: %s", givenString[startpos]));
				return 1;
			}
		}
        strdel(CarDesc[veh], 0, 128);
		strcat(CarDesc[veh], inputtext);
        MruMySQL_UpdateOpis(veh, CarData[VehicleUID[veh][vUID]][c_UID], 2);

		CarOpis_Usun(playerid, veh);
		new opis[128];
		format(opis, sizeof opis, "%s", CarDesc[veh]);
		ReColor(opis);
		Car3dTextDesc[veh] = CreateDynamic3DTextLabel(wordwrapEx(opis), COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, veh, 1, -1, -1, -1, 10.0);
		foreach(new p : Player)
		{
			if(!areVehicleDescTurnedOn[p])
			{
				Streamer_RemoveArrayData(STREAMER_TYPE_3D_TEXT_LABEL, Car3dTextDesc[veh], E_STREAMER_PLAYER_ID, p);
			}
		}
		format(CarOpisCaller[veh], MAX_PLAYER_NAME, "%s", GetNick(playerid));
		SendClientMessage(playerid, -1, "{99CC00}Ustawi�es w�asny opis pojazdu, by go usun�� wpisz {CC3333}/vopis usu�{CC3333}");
        return 1;
    }
    else if(dialogid == D_PERM)
    {
        if(!(Uprawnienia(playerid, ACCESS_EDITPERM) && IsPlayerAdmin(playerid))) return SendClientMessage(playerid, -1, "(PERM) - Nie posiadasz pe�nych praw.");
        new param[8];
        GetPVarString(playerid, "perm-id", param, 8);
        new id = strval(param);
        new str[128];
        if(!response)
        {

            if(OLD_ACCESS[id] != ACCESS[id])
            {
                OLD_ACCESS[id] = ACCESS[id];
                format(str, 128, "(PERM) %s zapisa� Twoje nowe uprawnienia", GetNickEx(playerid));
                SendClientMessage(id, 0x05CA8CFF, str);
                format(str, 128, "(PERM) Zapisales prawa %s", GetNick(id));
                SendClientMessage(playerid, 0x05CA8CFF, str);
                
				MruMySQL_ZapiszUprawnienia(playerid);
				Log(adminLog, INFO, "Admin %s zmieni� prawa %s na %b", GetPlayerLogName(playerid), GetPlayerLogName(id), ACCESS[id]);
            }
            return 1;
        }
        switch(listitem)
        {
            case 1: ACCESS[id] ^= ACCESS_PANEL;
            case 2: ACCESS[id] ^= ACCESS_KARY;
            case 3: ACCESS[id] ^= ACCESS_KARY_ZNAJDZ;
            case 4: ACCESS[id] ^= ACCESS_KARY_BAN;
            case 5: ACCESS[id] ^= ACCESS_KARY_UNBAN;
            case 6: ACCESS[id] ^= ACCESS_ZG;
            case 7: ACCESS[id] ^= ACCESS_GIVEHALF;
            case 8: ACCESS[id] ^= ACCESS_MAKELEADER;
            case 9: ACCESS[id] ^= ACCESS_MAKEFAMILY;
            case 10: ACCESS[id] ^= ACCESS_DELETEORG;
            case 11: ACCESS[id] ^= ACCESS_EDITCAR;
            case 12: ACCESS[id] ^= ACCESS_EDITRANG;
            case 13: ACCESS[id] ^= ACCESS_EDITPERM;
            case 14: ACCESS[id] ^= ACCESS_SKRYPTER;
        }
        format(str, 128, "(PERM) %s edytowa� Twoje uprawnienia (/uprawnienia)", GetNickEx(playerid));
        SendClientMessage(id, 0x05CA8CFF, str);
        RunCommand(playerid, "/edytujupr",  param);
    }
    else if(dialogid == DIALOG_PATROL)
    {
        if(!response)
        {
            SetPVarInt(playerid, "patrol", 0);
            return 0;
        }
        if(listitem == 0)
        {
            new pat = GetPVarInt(playerid, "patrol-id");
            SetPVarInt(playerid, "patrol-parent", -1);
            PatrolInfo[pat][patroluje][0] = playerid;
            PatrolInfo[pat][patroluje][1] = INVALID_PLAYER_ID;
            PatrolInfo[pat][patstrefa] = 0;
            PatrolInfo[pat][patstan] = 1;
            PatrolInfo[pat][pataktywny] = 2;
            PatrolInfo[pat][pattyp] = 1; //PlayerInfo[playerid][pFrac] 1 PD 2 FBI 3 NG
            PatrolInfo[pat][pattime] = gettime();

            SendClientMessage(playerid, COLOR_BLUE, "Rozpoczynasz patrol samodzielny. Wybierz stref� do patrolowania.");
            Patrol_ShowMap(playerid);
            SetPVarInt(playerid, "patrol-map", 1);
            SelectTextDraw(playerid, 0xD2691E55);
        }
        else
        {
            ShowPlayerDialogEx(playerid, DIALOG_PATROL_PARTNER, DIALOG_STYLE_INPUT, "Konfiguracja patrolu � Partner", "Wprowad� nazw� gracza lub ID, z kt�rym b�dziesz patrolowa� teren.", "Dodaj", "Anuluj");
        }
    }
    else if(dialogid == DIALOG_PATROL_NAME)
    {
        if(!response)
        {
            SetPVarInt(playerid, "patrol", 0);
            return 0;
        }
        if(isnull(inputtext) || strlen(inputtext) < 2) return 0;
        if(strfind(PatrolSq, inputtext, true) == -1)
        {
            strcat(PatrolSq, inputtext);
            format(PatrolInfo[GetPVarInt(playerid, "patrol-id")][patname], 16, "%s" ,inputtext);
            ShowPlayerDialogEx(playerid, DIALOG_PATROL, DIALOG_STYLE_LIST, "Konfiguracja patrolu � Typ", "Patrol samodzielny\nPatrol z partnerem", "Wybierz", "Anuluj");
        }
        else ShowPlayerDialogEx(playerid, DIALOG_PATROL_NAME, DIALOG_STYLE_INPUT, "Konfiguracja patrolu � Nazwa", "Ta nazwa jest zaj�ta.\r\nWprowad� nazw� patrolu (kryptonim)", "Dalej", "Anuluj");
    }
    else if(dialogid == DIALOG_PATROL_PARTNER)
    {
        new pat = GetPVarInt(playerid, "patrol-id");
        if(!response)
        {
            new pos = strfind(PatrolSq, PatrolInfo[pat][patname], true);
            strdel(PatrolSq, pos, pos + strlen(PatrolInfo[pat][patname]));
            strdel(PatrolInfo[pat][patname], 0, 16);

            SetPVarInt(playerid, "patrol", 0);
            return 0;
        }
        new id;
        sscanf(inputtext, "k<fix>", id);
        if(id == INVALID_PLAYER_ID) return ShowPlayerDialogEx(playerid, DIALOG_PATROL_PARTNER, DIALOG_STYLE_INPUT, "Konfiguracja patrolu � Partner", "Nie znaleziono gracza...\r\nWprowad� nazw� gracza lub ID, z kt�rym b�dziesz patrolowa� teren.", "Dodaj", "Anuluj");
        PatrolInfo[pat][patroluje][0] = playerid;
        PatrolInfo[pat][patroluje][1] = id;
        PatrolInfo[pat][patstrefa] = 0;
        PatrolInfo[pat][patstan] = 1;
        PatrolInfo[pat][pataktywny] = 2;
        PatrolInfo[pat][pattime] = gettime();
        new str[128], nick[MAX_PLAYER_NAME+1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "PATROL �� %s chce patrolowa� z Tob� teren. Aby akceptowa� wpisz /patrol akceptuj", nick);
        SetPVarInt(playerid, "patrol-parent", id);
        SetPVarInt(id, "patrol-parent", playerid);
        SetPVarInt(id, "patrol-dec", 1);
        SetPVarInt(playerid, "patrol-id", pat);
        SetPVarInt(playerid, "patrol-time", PatrolInfo[pat][pattime]);
        SetPVarInt(id, "patrol-time", PatrolInfo[pat][pattime]);
        SendClientMessage(id, COLOR_BLUE, str);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wys�ano zapytanie do gracza o pomoc w patrolowaniu.");
    }
    //PANEL ADMINA
    else if(dialogid == D_PANEL_ADMINA)
    {
        if(!response) return 1;
        new upr = GetPVarInt(playerid, "panel-upr");
        if(listitem == 0)
        {
            if(!(upr & 0b10)) return 1;
            SetPVarInt(playerid, "panel-ok", 1);
            ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
        }
        else if(listitem == 1)
        {
            ShowPlayerDialogEx(playerid, D_PANEL_CHECKPLAYER, DIALOG_STYLE_INPUT, "M-RP � Sprawdzanie statystyk gracza", "Wprowad� nick_gracza lub UID konta:                    ", "Sprawd�", "Wyjd�");
        }
    }
    else if(dialogid == D_PANEL_CHECKPLAYER)
    {
        if(!response) return RunCommand(playerid, "/panel",  "");
        if(strlen(inputtext) < 1 || strlen(inputtext) > MAX_PLAYER_NAME)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc!");
            ShowPlayerDialogEx(playerid, D_PANEL_CHECKPLAYER, DIALOG_STYLE_INPUT, "M-RP � Sprawdzanie statystyk gracza", "Wprowad� nick_gracza lub UID konta:                    ", "Sprawd�", "Wyjd�");
            return 0;
        }
		MruMySQL_PobierzStatystyki(playerid, inputtext);

        return 0;
    }
    else if(dialogid == D_PANEL_KAR)
    {
        if(!response) return 1;
        if(GetPVarInt(playerid, "panel-ok") != 1) return 1;
        switch(listitem)
        {
            case 0: //nadaj kare
            {
                ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
            }
            case 1: //zdejmij kare
            {
                ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
            }
            case 2: //wyszukiwarka
            {
                ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Sprawd� dane po IP\nSprawd� dane po nicku", "Wybierz", "Wr��");
            }
        }
    }
    else if(dialogid == D_PANEL_KARY_POWOD)
    {
        if(strlen(inputtext) > 1 && strlen(inputtext) < 64)
        {
            SetPVarString(playerid, "panel-powod", inputtext);
            SetPVarInt(playerid, "panel-kary-continue", 1);

            switch(GetPVarInt(playerid, "panel-list"))
            {
                case 0:
                {
                    ShowPlayerDialogEx(playerid, D_PANEL_KAR_BANIP, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej adres IP.", "Banuj", "Wr��");
                }
                case 1:
                {
                    ShowPlayerDialogEx(playerid, D_PANEL_KAR_BANNICK, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej nick gracza.", "Banuj", "Wr��");
                }
            }
        }
        else return ShowPlayerDialogEx(playerid, D_PANEL_KARY_POWOD, DIALOG_STYLE_LIST, "M-RP � Pow�d", "Prosz� poni�ej wpisa� pow�d.", "Dalej", "");
    }
    else if(dialogid == D_PANEL_KAR_ZDEJMIJ)
    {
        if(!response) return RunCommand(playerid, "/panel",  "");
        if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN))
        {
            SendClientMessage(playerid, COLOR_RED, "Uprawnienia: Nie posiadasz wystarczaj�cych uprawnie�.");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
            return 1;
        }
        switch(listitem)
        {
            case 0:
            {
                ShowPlayerDialogEx(playerid, D_PANEL_KAR_UNBANIP, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej adres IP.", "Odbanuj", "Wr��");
            }
            case 1:
            {
                ShowPlayerDialogEx(playerid, D_PANEL_KAR_UNBANNICK, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej nick gracza.", "Odbanuj", "Wr��");
            }
        }
    }
    else if(dialogid == D_PANEL_KAR_NADAJ)
    {
        if(!response) return RunCommand(playerid, "/panel",  "");
        if(!Uprawnienia(playerid, ACCESS_KARY_BAN))
        {
            SendClientMessage(playerid, COLOR_RED, "Uprawnienia: Nie posiadasz wystarczaj�cych uprawnie�.");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
            return 1;
        }
        SetPVarInt(playerid, "panel-list", listitem);
        DeletePVar(playerid, "panel-kary-continue");
        DeletePVar(playerid, "panel-powod");
        if(GetPVarInt(playerid, "panel-kary-continue") == 0) return ShowPlayerDialogEx(playerid, D_PANEL_KARY_POWOD, DIALOG_STYLE_INPUT, "M-RP � Pow�d", "Prosz� poni�ej wpisa� pow�d.", "Dalej", "");
    }
    else if(dialogid == D_PANEL_KAR_BANIP)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
        if(strlen(inputtext) < 7 || strlen(inputtext) > 16)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc IP!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
            return 1;
        }
        new count, cpos;
        while((cpos = strfind(inputtext, ".", false, cpos)) != -1)
        {
            count++;
            cpos++;
        }
        if(count != 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawny adres IP (dots)!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
            return 1;
        }
        new str[128], powod[128];
        GetPVarString(playerid, "panel-powod", powod, 128);
        MruMySQL_BanujOffline("Brak", powod, playerid, inputtext);

        format(str, 128, "ADM: %s - zablokowano IP: %s pow�d: %s", GetNickEx(playerid), inputtext, powod);
        SendClientMessage(playerid, COLOR_LIGHTRED, str);
        Log(punishmentLog, INFO, "Admin %s zablokowa� offline ip %s, pow�d: %s", 
                GetPlayerLogName(playerid),
                inputtext,
                powod);

        SetPVarInt(playerid, "panel-kary-continue", 0);
    }
    else if(dialogid == D_PANEL_KAR_BANNICK)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
        if(strlen(inputtext) < 1 || strlen(inputtext) > MAX_PLAYER_NAME)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_NADAJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Ban na IP\nBan na nick", "Wybierz", "Wr��");
            return 1;
        }
        new str[128], powod[128];
        GetPVarString(playerid, "panel-powod", powod, 128);
        MruMySQL_BanujOffline(inputtext, powod, playerid);

        format(str, 128, "ADM: %s - zablokowano nick: %s pow�d: %s", GetNickEx(playerid), inputtext, powod);
        SendClientMessage(playerid, COLOR_LIGHTRED, str);
        Log(punishmentLog, INFO, "Admin %s zablokowa� offline %s, pow�d: %s", 
                GetPlayerLogName(playerid),
                inputtext,
                powod);

        SetPVarInt(playerid, "panel-kary-continue", 0);
    }
    else if(dialogid == D_PANEL_KAR_UNBANIP)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
        if(strlen(inputtext) < 7 || strlen(inputtext) > 16)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc IP!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
            return 1;
        }
        new count, cpos=0;
        while((cpos = strfind(inputtext, ".", false, cpos)) != -1)
        {
            count++;
            cpos++;
        }
        if(count != 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawny adres IP (dots)!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
            return 1;
        }
        new str[128];
        if(!MruMySQL_Odbanuj("Brak", inputtext, playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Nie mo�na by�o wykona� zapytania do bazy!");
            return 1;
        }

        format(str, 128, "ADM: %s - odblokowano IP: %s", GetNickEx(playerid), inputtext);
        SendClientMessage(playerid, COLOR_LIGHTRED, str);
        Log(punishmentLog, INFO, "Admin %s odblokowa� ip %s", 
                GetPlayerLogName(playerid),
                inputtext);
    }
    else if(dialogid == D_PANEL_KAR_UNBANNICK)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
        if(strlen(inputtext) < 1 || strlen(inputtext) > MAX_PLAYER_NAME)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZDEJMIJ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Unbanuj IP\nUnbanuj nick", "Wybierz", "Wr��");
            return 1;
        }
        new str[128];
        if(!MruMySQL_Odbanuj(inputtext, "nieznane", playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Nie mo�na by�o wykona� zapytania do bazy!");
            return 1;
        }

        format(str, 128, "ADM: %s - odblokowano nick: %s", GetNickEx(playerid), inputtext);
        SendClientMessage(playerid, COLOR_LIGHTRED, str);
        Log(punishmentLog, INFO, "Admin %s odblokowa� %s", 
                GetPlayerLogName(playerid),
                inputtext);
    }
    else if(dialogid == D_PANEL_KAR_ZNAJDZ)  //Sprawd� dane po IP | Sprawd� dane po nicku
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
        if(!Uprawnienia(playerid, ACCESS_KARY_ZNAJDZ))
        {
            SendClientMessage(playerid, COLOR_RED, "Uprawnienia: Nie posiadasz wystarczaj�cych uprawnie�.");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
            return 1;
        }
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZIP, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej IP do sprawdzenia.", "Sprawd�", "Wr��");
            case 1: ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZNICK, DIALOG_STYLE_INPUT, "M-RP � Panel zarz�dzania karami", "Wprowad� poni�ej NICK do sprawdzenia.", "Sprawd�", "Wr��");
        }
    }
    else if(dialogid == D_PANEL_KAR_ZNAJDZIP)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
        if(strlen(inputtext) < 7 || strlen(inputtext) > 16)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc IP!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Sprawd� dane po IP\nSprawd� dane po nicku", "Wybierz", "Wr��");
            return 1;
        }
        new count, cpos=0;
        while((cpos = strfind(inputtext, ".", false, cpos)) != -1)
        {
            count++;
            cpos++;
        }
        if(count != 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawny adres IP (dots)!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Sprawd� dane po IP\nSprawd� dane po nicku", "Wybierz", "Wr��");
            return 1;
        }
        //OK
		MruMySQL_ZnajdzBanaPoIP(playerid, inputtext);
    }
    else if(dialogid == D_PANEL_KAR_ZNAJDZNICK)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_PANEL_KAR, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", TEXT_D_PANEL_KARY, "Wybierz", "Wyjd�");
        if(strlen(inputtext) < 1 || strlen(inputtext) > MAX_PLAYER_NAME)
        {
            SendClientMessage(playerid, COLOR_RED, "Niepoprawna d�ugosc nazwy!");
            ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Sprawd� dane po IP\nSprawd� dane po nicku", "Wybierz", "Wr��");
            return 1;
        }
        //OK
        MruMySQL_ZnajdzBanaPoNicku(playerid, inputtext);
    }
    else if(dialogid == D_PANEL_KAR_ZNAJDZ_INFO)
    {
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ, DIALOG_STYLE_LIST, "M-RP � Panel zarz�dzania karami", "Sprawd� dane po IP\nSprawd� dane po nicku", "Wybierz", "Wr��");
        return 1;
    }
    //KONIEC PANELU ADMINA

	else if(dialogid == 128)
	{
        if(CheckAlfaNumeric(inputtext))
        {
            SendClientMessage(playerid,COLOR_P@,"Twoje has�o posiada�o nie-alfanumeryczne znak, podaj inne.");
            ShowPlayerDialogEx(playerid, D_REGISTER, DIALOG_STYLE_INPUT, "Rejestracja konta", "Witaj. Aby zacz�� gr� na serwerze musisz si� zarejestrowa�.\nAby to zrobi� wpisz w okienko poni�ej has�o kt�re chcesz u�ywa� w swoim koncie.\nZapami�taj je gdy� b�dziesz musia� go u�ywa� za ka�dym razem kiedy wejdziesz na serwer", "Rejestruj", "Wyjd�");
            return 1;
        }
		SendClientMessage(playerid,COLOR_P@,"|_________________________Rada dnia: zmiana has�a_________________________|");
		SendClientMessage(playerid,COLOR_WHITE,"Zmieni�e� has�o to bardzo dobrze. Zwi�kszy to bezpiecze�stwo twojego konta na serwerze.");
		SendClientMessage(playerid,COLOR_WHITE,"Je�eli posiadasz konto na forum z identycznym has�em, rownie� mo�esz rozwa�y� jego zmian�.");
		SendClientMessage(playerid,COLOR_WHITE,"Teraz najwa�niejsza sprawa {FFA500}KONIECZNIE ZAPAMI�TAJ NOWE HAS�O.");
		SendClientMessage(playerid,COLOR_WHITE,"Z naszych do�wiadcze� wynika, �e du�o os�b zapomina nowo nadane na swoj� posta� has�o.");
		SendClientMessage(playerid,COLOR_WHITE,"Uniknij tej sytuacji w W TEJ CHWILII {CD5C5C}zapisz nowe has�o na karteczce lub wykonaj screen komunikatu poni�ej.");
		SendClientMessage(playerid,COLOR_WHITE,"Je�eli zapomnisz nowe has�o do konta na jego odzyskanie b�dziesz czeka� d�ugie tygodnie!");
		SendClientMessage(playerid,COLOR_WHITE,"Mo�liwe, �e ju� teraz zapomnia�e� has�a. Ale nic nie szkodzi. Poni�ej prezentujemy twoje nowe has�o ( < i > nie s� jego cz�ci�! )");
		SendClientMessage(playerid,COLOR_P@,"|________________________>>> Zapisz nowe has�o na kartce! <<<________________________|");
		new string[128];
		format(string, sizeof(string), "Twoje nowe has�o to: >>>>>> %s <<<<< -> zapisz je!", inputtext);

		if(strcmp(PlayerInfo[playerid][pKey],inputtext, true ) != 0)
		{
			SendClientMessage(playerid, COLOR_PANICRED, string);
			SendClientMessage(playerid, COLOR_PANICRED, string);
			SendClientMessage(playerid, COLOR_PANICRED, string);
			//PlayerInfo[playerid][pCzystka] = 555;
			OnPlayerRegister(playerid,inputtext);
		}
		else
		{
			ShowPlayerDialogEx(playerid, 128, DIALOG_STYLE_INPUT, "Konieczna zmiana hasla", "Uwaga! Konieczna jest zmiana has�a!\nHas�o na tym koncie ju� wygas�o. Koniecznie musisz je zmieni�.\nAby to zrobi� wpisz nowe has�o poni�ej.\n{FF0000}HAS�O NIE MO�E BY� TAKIE SAMO JAK POPRZEDNIE", "Zmien", "");
			return 1;
		}
	}
	else if(dialogid == D_ELEVATOR_USSS)
	{
		if (response)
		{	
			switch(listitem)
			{
				case 0://Parking
				{
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerPos(playerid, 1538.7106,-1474.8816,9.5000);
					Wchodzenie(playerid);
				}
				case 1://Recepcja
				{
					SetPlayerVirtualWorld(playerid, 41);
					SetPlayerPos(playerid, 1529.8018,-1489.0046,16.5134);
					Wchodzenie(playerid);
				}
				case 2://Sala treningowa
				{
					SetPlayerVirtualWorld(playerid, 40);
					SetPlayerPos(playerid, 1549.7249,-1462.1644,3.3250);
					Wchodzenie(playerid);
				}
				case 3://Strefa Pracownika
				{
					SetPlayerVirtualWorld(playerid, 42);
					SetPlayerPos(playerid, 1526.7426,-1469.4413,23.0778);
					Wchodzenie(playerid);
				}
				case 4://Biura
				{
					SetPlayerVirtualWorld(playerid, 43);
					SetPlayerPos(playerid, 1541.2571,-1464.1281,21.8429);
					Wchodzenie(playerid);
				}
				case 5://Akademia
				{
					SetPlayerVirtualWorld(playerid, 44);
					SetPlayerPos(playerid, 1544.1202,-1466.9008,42.8386);
					Wchodzenie(playerid);
				}
				case 6://Dach
				{
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerPos(playerid, 1542.1123,-1467.8416,63.8593);
					Wchodzenie(playerid);
				}
			}
		}
	}
    else if(dialogid == D_ELEVATOR_LSMC)
    {
        if(response)
        {
            if(LSMCElevatorQueue) return SendClientMessage(playerid, -1, "Prosz� poczeka�... Winda jest w u�yciu!");
			switch(listitem)
			{
			    case 0:
				{
				    ElevatorTravel(playerid,-2805.0967,2596.0566,-98.0829, 90,0.0);//pkostnica
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 1:
				{
					if(LSMCWindap0 == 1 && PlayerInfo[playerid][pMember] != FRAC_ERS)
					{
						SendClientMessage(playerid, -1, "Poziom zablokowany.");
						return 1;
					}
					ElevatorTravel(playerid,1144.4740, -1333.2556, 13.8348, 0,90.0);//parking
					PlayerInfo[playerid][pLocal] = PLOCAL_DEFAULT;
				}
				case 2:
				{
        			ElevatorTravel(playerid,1134.0449,-1320.7128,68.3750,90,270.0);//p1
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 3:
				{
					if(LSMCWindap2 == 1 && PlayerInfo[playerid][pMember] != FRAC_ERS)
					{
						SendClientMessage(playerid, -1, "Poziom zablokowany.");
						return 1;
					}
					ElevatorTravel(playerid,1183.3129,-1333.5684,88.1627,90,90.0);//p2
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 4:
				{
					ElevatorTravel(playerid,1168.2112,-1340.6785,100.3780,90,90.0);//p3
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 5:
				{
					ElevatorTravel(playerid,1158.6868,-1339.4423,120.2738,90,90.0);//p4
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 6:
				{
					ElevatorTravel(playerid,1167.7832,-1332.2727,134.7856,90,90.0);//p5
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
    			case 7:
				{
					ElevatorTravel(playerid,1177.4791,-1320.7749,178.0699,90,90.0);//p6
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
				case 8:
            	{
					ElevatorTravel(playerid,1178.2081,-1330.6317,191.5315,90,90.0);//p7
					PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
				}
                case 9:
				{
					if(LSMCWindap8 == 1 && PlayerInfo[playerid][pMember] != FRAC_ERS)
					{
						SendClientMessage(playerid, -1, "Poziom zablokowany.");
						return 1;
					}
            		ElevatorTravel(playerid,1161.8228, -1337.0521, 31.6112,0,180.0);//dach
					PlayerInfo[playerid][pLocal] = PLOCAL_DEFAULT;
				}
			}
        }
	}
    else if(dialogid == DIALOG_KONSOLA_VINYL)
    {
        if(!response) return 1;
        if(strlen(inputtext) < 10) return 1;
		if (ValidateURLAndNotify(playerid, inputtext)) return 1;

        foreach(new i : Player)
        {
            if(IsPlayerInRangeOfPoint(i, VinylAudioPos[3],VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2]) && (GetPlayerVirtualWorld(i) == 71 || GetPlayerVirtualWorld(i) == 72))
            {
                PlayAudioStreamForPlayer(i, inputtext,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            }
        }
        format(VINYL_Stream, 128, "%s",inputtext);
    }
	else if(dialogid == 7420)
	{
	    if(response)
	    {
	        if(strval(inputtext) >= 5 && strval(inputtext) <= 100)
	        {
	            new string[128];
	            new giveplayerid = dajeKontrakt[playerid];
	            new hajs = 0;
	            if(!IsPlayerConnected(giveplayerid))
	            {
	                SendClientMessage(playerid, COLOR_PANICRED, "   Gracz na kt�rego podpisywa�e� zlecenie si� wylogowa�!");
	                return 1;
	            }
				if(PlayerInfo[giveplayerid][pLider] > 0) { hajs += strval(inputtext)*150000; }
				else if(IsAPolicja(playerid)) { hajs = strval(inputtext)*100000; }
				else if(PlayerInfo[giveplayerid][pMember] == 9) { hajs = strval(inputtext)*85000; }
				else if(PlayerInfo[giveplayerid][pMember] > 0 || GetPlayerOrg(giveplayerid) != 0) { hajs = strval(inputtext)*75000; }
				else { hajs = strval(inputtext)*50000; }
				haHajs[playerid] = hajs;
				
		        format(string, sizeof(string), "Cena za g�ow� %s wynosi %d$.\nAby podpisa� na niego kontrakt, kliknij \"Podpisz\"", GetNick(giveplayerid), hajs);
		        ShowPlayerDialogEx(playerid, 7421, DIALOG_STYLE_MSGBOX, "Podpisywanie kontraktu", string, "Podpisz", "Wyjd�");
	        }
	        else
	        {
	            ShowPlayerDialogEx(playerid, 7420, DIALOG_STYLE_INPUT, "Podpisywanie kontraktu", "OOC: Musisz poda�, jak d�ugo zabity gracz ma przebywa� w szpitalu w minutach.\nMinimum 5 minut a maksimum 100. (Cena zlecenia zale�y od ilo�ci minut)", "Dalej", "Wyjd�");
                SendClientMessage(playerid, COLOR_GREY, "    Min 5 Max 100 minut!");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_GREY, "Anulowa�e� podpisywanie kontraktu.");
	        dajeKontrakt[playerid] = 9999;
	        return 1;
	    }
	    return 1;
	}
    else if(dialogid == SCENA_DIALOG_MAIN)
    {
        if(!response) return 1;
        switch(listitem)
        {
            case 0:
            {
                if(!ScenaCreated)
                {
                    new Float:x, Float:y, Float:z, Float:a;
                    GetPlayerPos(playerid, x, y, z);
                    GetPlayerFacingAngle(playerid, a);
                    x += 10.0 * floatsin(-a, degrees);
                    y += 10.0 * floatcos(-a, degrees);
                    Scena_CreateAt(x, y, z+0.2);
                    new str[64];
                    format(str, 64, "Scena stworzona przez %s", GetNick(playerid));
                    SendAdminMessage(COLOR_RED, str);
                    print(str);
                }
                else
                {
                    Scena_Destroy();
                    new str[64];
                    format(str, 64, "Scena zniszczona przez %s", GetNick(playerid));
                    SendAdminMessage(COLOR_RED, str);
                    print(str);
                }
            }
            case 1:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz�dzanie ekranem", "Zmie� napis g��wny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
            }
            case 2:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
            }
            case 3:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz�dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
            }
            case 4: ShowPlayerDialogEx(playerid, SCENA_DIALOG_AUDIO, DIALOG_STYLE_INPUT, "Zarz�dzanie audio", "Wprowad� link", "Ustaw", "Wyjdz");
            case 5:
            {
                if(ScenaSmokeMachine)
                {
                    DestroyDynamicObject(ScenaSmokeObject[0]);
                    DestroyDynamicObject(ScenaSmokeObject[1]);
                    ScenaSmokeMachine=false;
                }
                else
                {
                    ScenaSmokeObject[0] = CreateDynamicObject(2780, ScenaPosition[0]+5.84926, ScenaPosition[1]+4.44155, ScenaPosition[2]+0.10611,   0.00000, 0.00000, -48.24001);
                    ScenaSmokeObject[1] = CreateDynamicObject(2780, ScenaPosition[0]+5.98447, ScenaPosition[1]-5.16050, ScenaPosition[2]+0.10611,   0.00000, 0.00000, -143.22002);
                    ScenaSmokeMachine=true;
                    Scena_Refresh();
                }
            }
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_CREATE)
    {
        if(!response) return 1;

    }
    else if(dialogid == SCENA_DIALOG_EFEKTY)
    {
        if(!response) return 1;
        new str[1024] = "{000000}0\t{FFFFFF}Usu�\n{000000}18668\t{FFFFFF}Krew\n{000000}18670\t{FFFFFF}B�yski\n{000000}18675\t{FFFFFF}Dymek\n{000000}18678\t{FFFFFF}Eksplozja\n{000000}18683\t{FFFFFF}Eksplozja medium\n{000000}18685\t{FFFFFF}Eksplozja ma�a\n{000000}18692\t{FFFFFF}Ogie�\n{000000}18702\t{FFFFFF}Niebieski p�omie�\n{000000}18708\t{FFFFFF}B�belki\n{000000}18718\t{FFFFFF}Iskry\n{000000}18728\t{FFFFFF}Raca\n{000000}18740\t{FFFFFF}Woda\n";
        strcat(str, "{000000}18680\t{FFFFFF}Dym + iskry\n{000000}18715\t{FFFFFF}Dym du�y\n{000000}18693\t{FFFFFF}Ogie� #2\n{000000}18744\t{FFFFFF}Splash big\n{000000}18747\t{FFFFFF}Wodna piana");
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_TYP, DIALOG_STYLE_LIST, "Zarz�dzanie dodatkami", str, "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_COUNT, DIALOG_STYLE_INPUT, "Zarz�dzanie dodatkami", "Podaj ilo�� powt�rze�\t\tnp.\n-1 - dla niesko�czonej p�tli\n0 - dla wy��czenia\nn - liczba", "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_DELAY, DIALOG_STYLE_INPUT, "Zarz�dzanie dodatkami", "Podaj odst�p czasowy\t\tnp.\n0 - sta�y efekt\nn [ms] - czas", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_TYP)
    {
        if(!response) return 1;
        if(strval(inputtext) == 0)
        {
            if(ScenaEffectData[SCEffectTimer] != 0)
            {
                KillTimer(ScenaEffectData[SCEffectTimer]);
                ScenaEffectData[SCEffectTimer] = 0;
            }
            ScenaEffectData[SCEffectDelay] = 0;
        }
        else ScenaEffectData[SCEffectModel] = strval(inputtext);
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz�dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_COUNT)
    {
        if(!response) return 1;
        if(strval(inputtext) < -1 || strval(inputtext) > 0xFFFF) return 1;
        ScenaEffectData[SCEffectCount] = strval(inputtext);

        if(ScenaEffectData[SCEffectTimer] != 0)
        {
            KillTimer(ScenaEffectData[SCEffectTimer]);
            ScenaEffectData[SCEffectTimer] = 0;
        }

        if(ScenaEffectData[SCEffectCount] == -1)
        {
            if(ScenaEffectData[SCEffectDelay] != 0) ScenaEffectData[SCEffectTimer] = SetTimer("Scena_GenerateEffect", ScenaEffectData[SCEffectDelay], 1);
        }
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz�dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_DELAY)
    {
        if(!response) return 1;
        if(strval(inputtext) < 250 || strval(inputtext) > 0xFFFF) return SendClientMessage(playerid, -1, "Od 250");
        ScenaEffectData[SCEffectDelay] = strval(inputtext);

        if(ScenaEffectData[SCEffectTimer] != 0)
        {
            KillTimer(ScenaEffectData[SCEffectTimer]);
            ScenaEffectData[SCEffectTimer] = 0;
        }
        if(ScenaEffectData[SCEffectCount] == -1)
        {
            if(ScenaEffectData[SCEffectDelay] != 0) ScenaEffectData[SCEffectTimer] = SetTimer("Scena_GenerateEffect", ScenaEffectData[SCEffectDelay], 1);
        }

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz�dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN)
    {
        if(!response) return 1;
        new str[512] = "{000000}0\t{FFFFFF}Usu�\n{000000}1\t{FFFFFF}G�ra-d�";
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_TYP, DIALOG_STYLE_INPUT, "Zarz�dzanie ekranem", "Wprowad� napis", "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_EFEKT, DIALOG_STYLE_LIST, "Zarz�dzanie ekranem", str, "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_EXTRA, DIALOG_STYLE_INPUT, "Zarz�dzanie ekranem", "Dla efektu Wirnik:\t\tPr�dko�� (ca�kowite warto�ci)", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_TYP)
    {
        if(!response) return 1;
        if(strlen(inputtext) > 32) return 1;
        format(ScenaScreenText, 32, "%s", inputtext);
        new size = 148-(floatround(floatsqroot(strlen(inputtext)*150))*2);
        if(size < 10) size = 10;
        SetDynamicObjectMaterialText(ScenaScreenObject, 0, inputtext, OBJECT_MATERIAL_SIZE_512x256, "Arial", size, 1, 0xFFFFFFFF, 0, 1);
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz�dzanie ekranem", "Zmie� napis g��wny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_EFEKT)
    {
        if(!response) return 1;
        if(strval(inputtext) == 0)
        {
            ScenaScreenEnable = false;
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(ScenaScreenObject, x, y, z);
            if(ScenaScreenMove == 0) MoveDynamicObject(ScenaScreenObject, x, y, ScenaPosition[2]+4.18430, ScenaScreenData, 0.0, 0.0, 100.0), ScenaScreenMove= 1;
            else if(ScenaScreenMove == 1) MoveDynamicObject(ScenaScreenObject, x, y, ScenaPosition[2]+4.18430, ScenaScreenData, 0.0, 0.0, 100.0), ScenaScreenMove=0;

            SetDynamicObjectMaterialText(ScenaScreenObject, 0, ScenaScreenText, OBJECT_MATERIAL_SIZE_512x256, "Arial", 72, 1, 0xFFFFFFFF, 0, 1);
        }
        else
        {
            ScenaScreenTyp = strval(inputtext);
            ScenaScreenEnable = true;
        }

        Scena_ScreenEffect();
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz�dzanie ekranem", "Zmie� napis g��wny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_EXTRA)
    {
        if(!response) return 1;
        if(strval(inputtext) < 0 || strval(inputtext) > 100) return 1;
        ScenaScreenData = float(strval(inputtext));

        Scena_ScreenEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz�dzanie ekranem", "Zmie� napis g��wny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEONY)
    {
        if(!response) return 1;
        new str[512] = "{000000}0\t{FFFFFF}Usu�\n{000000}1\t{FFFFFF}Slider\n{000000}2\t{FFFFFF}Zderzacz";
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_EFEKT, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", str, "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_COUNT, DIALOG_STYLE_INPUT, "Zarz�dzanie neonami", "Aktualnie brak", "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_DELAY, DIALOG_STYLE_INPUT, "Zarz�dzanie neonami", "Dla efektu:\t\tPr�dko�� (ca�kowite warto�ci)", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_EFEKT)
    {
        if(!response) return 1;
        ScenaNeonData[SCNeonTyp] = 0;
        Scena_NeonEffect();

        ScenaNeonData[SCNeonTyp] = strval(inputtext);
        if(ScenaNeonData[SCNeonTyp] != 0)
        {
            new str[256] = "{000000}18652\t\t{FFFFFF}Bia�y neon\n{000000}18647\t\t{FFFFFF}Czerwony neon\n{000000}18648\t\t{FFFFFF}Niebieski neon\n{000000}18649\t\t{FFFFFF}Zielony neon\n{000000}18650\t\t{FFFFFF}��ty neon\n{000000}18651\t\t{FFFFFF}R�owy neon <3 :*";
            ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_KOLORY, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", str, "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_COUNT)
    {
        if(!response) return 1;
        if(strval(inputtext) < -1 || strval(inputtext) > 100) return 1;
        ScenaNeonData[SCNeonCount] = strval(inputtext);

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_DELAY)
    {
        if(!response) return 1;
        if(strval(inputtext) < 0 || strval(inputtext) > 200) return SendClientMessage(playerid, -1, "Do 200");
        ScenaNeonData[SCNeonDelay] = strval(inputtext);

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_KOLORY)
    {
        if(!response) return 1;
        ScenaNeonData[SCNeonModel] = strval(inputtext);
        ScenaNeonData[SCNeonSliderRefresh]=true;

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz�dzanie neonami", "Ustaw efekt\nUstaw powtarzalno��\nUstaw cz�stotliwo��", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_AUDIO)
    {
        if(!response) return 1;
		if (ValidateURLAndNotify(playerid, inputtext)) return 1;
        format(ScenaAudioStream, 128, "%s", inputtext);
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "scena-audio") == 1)
            {
                StopAudioStreamForPlayer(i);
                SetPVarInt(i, "scena-audio", 0);
            }
        }
        return 1;
    }
	else if(dialogid == SCENA_DIALOG_GETMONEY)
	{
		if(!response)
		{
			return 1;
		}
		if(kaska[playerid] >= 2_000_000)
		{
			ZabierzKase(playerid, 2000000); 
			Sejf_Add(FRAC_SN, 2000000); 
			Sejf_Save(FRAC_SN); 
			new string[124]; 
			format(string, sizeof(string), "%s umie�ci� w sejfie 2 miliony za scen�!"); 
			SendLeaderRadioMessage(FRAC_SN, COLOR_LIGHTGREEN, string); 
			SN_ACCESS[playerid] = 1; 
			sendTipMessageEx(playerid, COLOR_P@, "Umie�ci�e� op�at� za scen� w sejfie SN"); 
		}
		else
		{
			sendTipMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
			return 1;
		}
	}
	else if(dialogid == 7421)
	{
	    if(response)
		{
		    new string[128];
		    new giveplayerid = dajeKontrakt[playerid];
		    new hajs = haHajs[playerid];
            if(!IsPlayerConnected(giveplayerid))
            {
                SendClientMessage(playerid, COLOR_PANICRED, "   Gracz na kt�rego podpisywa�e� zlecenie si� wylogowa�!");
                return 1;
            }
			
			if(kaska[playerid] > 0 && kaska[playerid] >= hajs)
			{
				ZabierzKase(playerid, hajs);
				PlayerInfo[giveplayerid][pHeadValue]+=hajs;
				format(string, sizeof(string), "%s podpisa� kontrakt na %s, nagroda za wykonanie $%d.",GetNick(playerid), GetNick(giveplayerid), hajs);
				SendFamilyMessage(8, COLOR_YELLOW, string);
				format(string, sizeof(string), "* Podpisa�e� kontrakt na %s, za $%d.",GetNick(giveplayerid), hajs);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* %s wk�ada kopert� z pieni�dzmi do skrzynki, po czym zamyka j�.", GetNick(playerid));
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				dajeKontrakt[playerid] = 9999;
				haHajs[playerid] = 0;
				ClearAnimations(playerid);
		        return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_PANICRED, "   Nie masz tylu pieni�dzy!");
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "Anulowa�e� podpisywanie kontraktu.");
	        dajeKontrakt[playerid] = 9999;
	        haHajs[playerid] = 0;
	        return 1;
		}
	}
	else if(dialogid == DIALOG_UNFRAKCJA)
	{
		new id_Lidera = GetPVarInt(playerid, "ID_LIDERA"); 
		new string[256]; 
		if(!response)
		{
			Remove_MySQL_Leader(id_Lidera); 
			format(string, sizeof(string), "* Zosta�e� wyrzucony z frakcji przez %s.", GetNick(playerid));
			SendClientMessage(id_Lidera, COLOR_LIGHTBLUE, string);
			SendClientMessage(id_Lidera, COLOR_LIGHTBLUE, "* Jeste� cywilem.");
			Log(adminLog, INFO, "Admin %s usun�� gracza %s z frakcji %s - pozostawiaj�c VLD.", GetPlayerLogName(playerid), GetPlayerLogName(id_Lidera), GetFractionLogName(PlayerInfo[id_Lidera][pMember]));
			PlayerInfo[id_Lidera][pMember] = 0;
			PlayerInfo[id_Lidera][pLider] = 0;
			PlayerInfo[id_Lidera][pJob] = 0;
			RemovePlayerFromOrg(id_Lidera);
			MedicBill[id_Lidera] = 0;
			SetPlayerSpawn(id_Lidera);
			format(string, sizeof(string), "  Wyrzuci�es %s z frakcji.", GetNick(id_Lidera));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		}
		else 
		{
			RemoveLeadersFromFraction(id_Lidera, playerid); 
		}
	}
    else if(dialogid == D_PRZEBIERZ_FDU)
    {
        if(!response) return 1;
        new lSkin;
        switch(listitem)
        {
            case 0: lSkin = 40;
            case 1: lSkin = 50;
            case 2: lSkin = 93;
            case 3: lSkin = 86;
            case 4: lSkin = 115;
            case 5: lSkin = 122;
            case 6: lSkin = 270;
        }
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, 0xFF8D00FF, "Musisz by� pieszo, �eby zmieni� skin.");
        SetPlayerSkinEx(playerid, lSkin);
        SendClientMessage(playerid, 0xC0FF9CFF, "� Zmieni�e� swoje przebranie.");
    }
	else if(dialogid == 1213)
 	{
		if(response == 1)
 		{
  			switch(listitem)
    		{
	                case 0:
	                {
	                	ApplyAnimation(playerid,"PED","WALK_DRUNK",4.0, 1, 1, 1, 1, 0, 1);
					}
	                case 1:
	                {
	                	ApplyAnimation(playerid,"PED","WALK_civi",4.0, 1, 1, 1, 1, 1, 1);
					}
	                case 2:
	                {
	                	ApplyAnimation(playerid,"PED","WALK_fatold",4.0, 1, 1, 1, 1, 1, 1);
	             	}
	                case 3:
	                {
	                    ApplyAnimation(playerid,"PED","WALK_gang1",4.0, 1, 1, 1, 1, 1, 1);
	                }
	                case 4:
	                {
	                    ApplyAnimation(playerid,"PED","WALK_gang2",4.0, 1, 1, 1, 1, 1, 1);
	                }
					case 5:
					{
					    ApplyAnimation(playerid,"PED","WALK_old",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 6:
					{
                        ApplyAnimation(playerid,"PED","WALK_rocket",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 7:
					{
                        ApplyAnimation(playerid,"PED","WALK_player",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 8:
					{
                        ApplyAnimation(playerid,"PED","WOMAN_walkfatold",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 9:
					{
                        ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 10:
					{
                        ApplyAnimation(playerid,"FAT","FatWalk",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 11:
					{
                        ApplyAnimation(playerid,"PED","WOMAN_Walkbusy",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 12:
					{
                        ApplyAnimation(playerid,"PED","WOMAN_walkshop",4.0, 1, 1, 1, 1, 1, 1);
					}
					case 13:
					{
                        ApplyAnimation(playerid,"MUSCULAR","MuscleWalk",4.0, 1, 1, 1, 1, 1, 1);
  				}
			}
		}
	}
	else if(dialogid == 1215)
	{
		if(response)
		{
			new actorpID = GetPVarInt(playerid, "actorIDChoice");
			new string[124]; 
			switch(listitem)
			{
				case 0: 
				{
					ApplyDynamicActorAnimation(actorUID[actorpID], "COP_AMBIENT", "Coplook_loop", 4.1,  1, 1, 1, 0, 0);
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 1:
				{
					SetActorAnimationEx(actorUID[actorpID], "RAPPING","RAP_C_Loop",  1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 2:
				{
					SetActorAnimationEx(actorUID[actorpID], "BD_FIRE","BD_Panic_Loop", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 3:
				{
					SetActorAnimationEx(actorUID[actorpID], "PED","IDLE_CHAT", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 4:
				{
					SetActorAnimationEx(actorUID[actorpID], "DANCING","bd_clap1", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 5:
				{
					SetActorAnimationEx(actorUID[actorpID], "DANCING","DAN_Loop_A", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 6:
				{
					SetActorAnimationEx(actorUID[actorpID], "JST_BUISNESS","girl_02", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 7:
				{
					SetActorAnimationEx(actorUID[actorpID], "ON_LOOKERS","Pointup_in", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 8:
				{
					SetActorAnimationEx(actorUID[actorpID], "ON_LOOKERS","point_loop", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 9:
				{
					SetActorAnimationEx(actorUID[actorpID], "PAULNMAC","Piss_loop", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 10:
				{
					SetActorAnimationEx(actorUID[actorpID], "SHOP","Smoke_RYD", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 11:
				{
					SetActorAnimationEx(actorUID[actorpID], "SMOKING","M_smk_drag", 1, 1, 1); 
					SetAnimatiorToActorMess(playerid, actorpID);
				}
				case 12:
				{
					ClearDynamicActorAnimations(actorUID[actorpID]);
					format(string, sizeof(string), "Wy��czy�e� animacje dla %s [%d]", Actors[actorpID][a_Name], actorpID);
					sendTipMessage(playerid, string); 
					format(string, sizeof(string), "Admin %s wyczy�ci� animacje dla actora %s [%d]", GetNickEx(playerid), Actors[actorpID], actorpID); 
					SendMessageToAdmin(string, COLOR_RED);
				}
			}
		}
	}
	else if(dialogid == iddialog[playerid])
	{
		if(dialogid == 1)
	    {
	        if(response)
	        {
	    		if(PlayerInfo[playerid][pPos_x] == 2246.6 || PlayerInfo[playerid][pPos_y] == -1161.9 || PlayerInfo[playerid][pPos_z] == 1029.7 || PlayerInfo[playerid][pPos_x] == 0 || PlayerInfo[playerid][pPos_y] == 0)
	      		{
	                SendClientMessage(playerid, 0xFFFFFFFF, "Twoja pozycja zosta�a b��dnie zapisana, dlatego zespawnujesz si� na zwyk�ym spawnie.");
                }
				else
				{
					SendClientMessage(playerid, 0xFFFFFFFF, "Pozycja przywr�cona");
					SetPVarInt(playerid, "spawn", 2);
					SetPlayerSpawnPos(playerid);
				}
			}
			else if(!response)
			{
				PlayerInfo[playerid][pLocal] = 255;
			}
			GUIExit[playerid] = 0;
			lowcap[playerid] = 0;
			return 1;
	    }
		if(dialogid == 9687)
		{
			if(!response)
			{
				SetPlayerSpawnPos(playerid);
			}
			return 1;
		}
	    //OnDialogResposne OKNA DMV
		if(dialogid == 99)
		{
			if(response)
			{
				new string[256];
				new okienkoid = GetPVarInt(playerid, "okienko-edit");
				new mojeimie[MAX_PLAYER_NAME];
				GetPlayerName(playerid, mojeimie, sizeof(mojeimie));
				
			    switch(listitem)
			    {
			        case 0:
			        {
						if(PlayerInfo[playerid][pRank] == 0)
						{
							format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC}Dowody Osobiste\n Karty W�dkarskie\n Egzaminy Praktyczne", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
							UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
						}
						else if(PlayerInfo[playerid][pRank] == 1)
						{
	
							format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC}Dowody Osobiste\n Karty W�dkarskie\n Egzaminy Praktyczne i Teoretyczne\n Pozwolenia na bro�", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
							UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
						}
						else if(PlayerInfo[playerid][pRank] == 2)
						{
							format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC}Dowody Osobiste\n Karty W�dkarskie\n Egzaminy Praktyczne i Teoretyczne\n Pozwolenia na bro�\n Patenty �eglarskie", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
							UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
						}
						else if(PlayerInfo[playerid][pRank] >= 3 || PlayerInfo[playerid][pLider] == 11)
						{
							format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC}Uniwersalne", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
							UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);	
						}
			        }
			        case 1:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC} Egzaminy Praktyczne\n{008080}Zapis i egzamin odbywa si�\n u tej samej osoby", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
						UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			        case 2:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC} Egzaminy Teoretyczne\n{008080}Ka�de kolejne podej�cie\n wymaga zachowania 1h odst�pu", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
						UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			        case 3:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC} Kurs na prawo jazdy\n{008080}Zapisy", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
						UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			        case 4:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {00FFCC} Rejestracja", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
			        	UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			        case 5:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n\n{0080FF}___Okienko %d___\n[%s: %s]\n{FF0000}[ID: %d]\n {FA9C1A} Zaraz Wracam", okienkoid+1,FracRang[11][PlayerInfo[playerid][pRank]],mojeimie,playerid);
			        	UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			        case 6:
			        {
						format(string, sizeof(string), "Urz�d Miasta Los Santos\n{0080FF}Okienko %d \n {FF0000}Nieczynne", okienkoid+1);
						UpdateDynamic3DTextLabelText(okienko[okienkoid], 0xFFFFFFFF, string);
			        }
			    }
			}
		}
	    else if(dialogid == 112)
	    {
            if(!response) return 1;
            switch(listitem)
            {
                case 0:
                {
    	            SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: ��cze z policj�, prosze czeka�...");
    				SendClientMessage(playerid, COLOR_DBLUE, "Police HQ: Witam, prosze poda� kr�tki opis przest�pstwa.");
    				Mobile[playerid] = POLICE_NUMBER;
					Callin[playerid] = CALL_EMERGENCY;
                }
				case 1:
                {
    			    SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: ��cze ze szpitalem, prosze czeka�...");
    				SendClientMessage(playerid, TEAM_CYAN_COLOR, "Szpital: Witam, prosze poda� kr�tki opis zdarzenia.");
    				Mobile[playerid] = LSMC_NUMBER;
					Callin[playerid] = CALL_EMERGENCY;
                }
                case 2:
                {
                	SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: ��cze ze stra�� po�arn�, prosze czeka�...");
    				SendClientMessage(playerid, COLOR_DBLUE, "LSFD HQ: Witam, prosze poda� kr�tki opis zdarzenia.");	
    				Mobile[playerid] = LSMC_NUMBER;
					Callin[playerid] = CALL_EMERGENCY;
                }
				/*
                case 3:
                {
    			    SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: ��cze z dyspozytorem, prosze czeka�...");
    				SendClientMessage(playerid, TEAM_CYAN_COLOR, "SheriffDep: Witam, prosze poda� kr�tki opis przest�pstwa.");
    				Mobile[playerid] = LSFD_NUMBER;
					Callin[playerid] = CALL_EMERGENCY;
                }*/
			}
	    }
        else if(dialogid== WINDA_SAN)
    	{
    	    if(response)
    	    {
    	        switch(listitem)
    	        {
    	            case 0://parking
    	            {
						if(levelLock[FRAC_SN][0] == 1 && PlayerInfo[playerid][pMember] != FRAC_SN)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,0);
    	                SetPlayerPos(playerid,288.0914,-1609.7465,17.9994);
    	            	SetServerWeatherAndTime(playerid); 
						SetPlayerLocal(playerid, PLOCAL_DEFAULT);
    	            }
					case 1://wejscie do budynku
					{
						if(levelLock[FRAC_SN][1] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerInterior(playerid, 0); 
						SetServerWeatherAndTime(playerid); 
						TogglePlayerControllable(playerid, 0);
						Wchodzenie(playerid); 
						SetPlayerPos(playerid, 287.7476,-1609.9395,33.0723); 
						SetPlayerLocal(playerid, PLOCAL_DEFAULT);
					}
    	            case 2://recepcja
    	            {
						if(levelLock[FRAC_SN][2] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,14);
    				    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
    				    SetPlayerPos(playerid, 292.0818,-1610.0715,124.7512);
    				    SetInteriorTimeAndWeather(playerid); 
						GameTextForPlayer(playerid, "~w~By~n~~r~Simeone", 5000, 1);
						SetPlayerLocal(playerid, PLOCAL_ORG_SN);
    	            }
    	            case 3://studia
    	            {
						if(levelLock[FRAC_SN][3] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,16);
    				    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
    				    SetPlayerPos(playerid,296.9033,-1598.3610,117.0619);
						SetInteriorTimeAndWeather(playerid); 
						GameTextForPlayer(playerid, "~w~By~n~~r~Simeone & Rozalka", 5000, 1);
						SetPlayerLocal(playerid, PLOCAL_ORG_SN);
    	            }
    	            case 4://Akademia
    	            {
						if(levelLock[FRAC_SN][4] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,17);
    				    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
    				    SetPlayerPos(playerid,295.1328,-1609.4705,115.6818);
    				    SetInteriorTimeAndWeather(playerid); 
						GameTextForPlayer(playerid, "~w~By~n~~r~Simeone & Rozalka", 5000, 1);
						SetPlayerLocal(playerid, PLOCAL_ORG_SN);
    	            }
    	            case 5:
    	            {
						if(levelLock[FRAC_SN][5] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,18);
    				    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
    				    SetPlayerPos(playerid,290.7577,-1604.3273,134.6113);
    				    SetInteriorTimeAndWeather(playerid); 
						GameTextForPlayer(playerid, "~w~By~n~~r~Simeone & Rozalka", 5000, 1);
						SetPlayerLocal(playerid, PLOCAL_ORG_SN);
    	            }
    	            case 6://dach
    	            {
						if(levelLock[FRAC_SN][6] == 1)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
    	                SetPlayerVirtualWorld(playerid,0);
    	                SetPlayerPos(playerid,285.8397,-1596.4153,114.5687);
    	                SetServerWeatherAndTime(playerid);
						SetPlayerLocal(playerid, PLOCAL_DEFAULT);
    	            }
    	        }
    	    }
    	}
	    else if(dialogid == WINDA_LSPD)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
					case 0:
		            {
		            	if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
			                SetPlayerPos(playerid,1543.3915,-1643.2813,28.4881);
			                SetPlayerVirtualWorld(playerid,29);
			                SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
			                GameTextForPlayer(playerid, "~w~ [Poziom -2]~n~~r~Wiezienie", 5000, 1);
                        }
						else if(ApprovedLawyer[playerid] == 1)
						{
							SetPlayerPos(playerid,1556.7177,-1643.0455,28.4881);
			                SetPlayerVirtualWorld(playerid,29);
			                SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
			                GameTextForPlayer(playerid, "~w~ [Poziom -2]~n~~r~Wiezienie", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 1:
		            {
		            	if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
			                SetPlayerPos(playerid,1568.7660,-1691.4886,5.8906);
			                SetPlayerVirtualWorld(playerid,2);
			                SetPlayerInterior(playerid,0);
			                TogglePlayerControllable(playerid,0);
							Wchodzenie(playerid);
			                GameTextForPlayer(playerid, "~w~ [Poziom -1]~n~~b~Parking Dolny", 5000, 1);
                        }
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 2: {
		            	// parking gorny
		            	if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
			                SetPlayerPos(playerid,1570.9799,-1636.7758,13.5713); // pos gornego
			                SetPlayerVirtualWorld(playerid,0);
			                SetPlayerInterior(playerid,0);
			                TogglePlayerControllable(playerid,0);
							Wchodzenie(playerid);
			                GameTextForPlayer(playerid, "~w~ [Poziom 0]~n~~b~Parking Gorny", 5000, 1);
                        }
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 3:
		            {
		                SetPlayerPos(playerid,1585.8722,-1685.5045,62.2363);
		                SetPlayerVirtualWorld(playerid,25);
		                TogglePlayerControllable(playerid,0);
						SetPlayerInterior(playerid,0);
						Wchodzenie(playerid);
		                GameTextForPlayer(playerid, "~w~ [Poziom 1]~n~~b~Recepcja i glowny hol", 5000, 1);
		            }
		            case 4:
		            {
						if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
							SetPlayerPos(playerid,1585.8090,-1685.1177,65.8762);
							SetPlayerVirtualWorld(playerid,25);
							TogglePlayerControllable(playerid,0);
							SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
							GameTextForPlayer(playerid, "~w~ [Poziom 2]~n~~b~Biuro komendanta", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 5:
		            {
						if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
							SetPlayerPos(playerid,1551.5720,-1701.7196,28.4807);
							SetPlayerVirtualWorld(playerid,26);
							TogglePlayerControllable(playerid,0);
							SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
							GameTextForPlayer(playerid, "~w~ [Poziom 3]~n~~b~Biura", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 6:
		            {
						if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
							SetPlayerPos(playerid,1562.7128,-1639.0281,28.5040);
							SetPlayerVirtualWorld(playerid,27);
							TogglePlayerControllable(playerid,0);
							SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
							GameTextForPlayer(playerid, "~w~ [Poziom 4]~n~~b~Konferencyjne", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
					case 7:
		            {
						if(IsAPolicja(playerid) || IsABOR(playerid))
           				{
							SetPlayerPos(playerid,1564.9027,-1665.8291,28.4815);
							SetPlayerVirtualWorld(playerid,28);
							TogglePlayerControllable(playerid,0);
							SetPlayerInterior(playerid,0);
							Wchodzenie(playerid);
							GameTextForPlayer(playerid, "~w~ [Poziom 4]~n~~b~Sale przesluchan", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
		            case 8:
		            {
						if(IsAPolicja(playerid) || IsABOR(playerid))
						{
							SetPlayerPos(playerid,1565.0798, -1665.6580, 28.4782);
							SetPlayerVirtualWorld(playerid,0);
							SetPlayerInterior(playerid,0);
							GameTextForPlayer(playerid, "~w~ [Poziom 7]~n~~b~Dach", 5000, 1);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla s�u�b porz�dkowych.");
							return 1;
						}
		            }
				}
		    }
		}
   	 	else if(dialogid == 121)
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0:
	                {
                 		SetPlayerPos(playerid, 707.06085205078,-508.38107299805,27.871946334839);//salka konferencyjna
				        GameTextForPlayer(playerid, "~w~Witamy w salce konferencyjnej", 5000, 1);
				        SetPlayerVirtualWorld(playerid, 35);
				        TogglePlayerControllable(playerid, 0);
						Wchodzenie(playerid);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 700.6748046875,-502.41955566406,23.515483856201);//biura
				        GameTextForPlayer(playerid, "~w~Projekt by Kacper Monari", 5000, 1);
				        SetPlayerVirtualWorld(playerid, 35);
				        TogglePlayerControllable(playerid, 0);
						Wchodzenie(playerid);
					}
	                case 2:
	                {
					/*
						SetPlayerPos(playerid, 694.27490234375,-569.04272460938,-79.225189208984);//piwnica
				        GameTextForPlayer(playerid, "~w~Mroczne piwnice i stare biura", 5000, 1);
				        SetPlayerVirtualWorld(playerid, 35);
				        TogglePlayerControllable(playerid, 0);
						Wchodzenie(playerid);*/
						sendTipMessageEx(playerid, 0x800040FF, "Wygl�da na to, �e pi�tro jest czym� przyblokowane"); 
	                }
	            }
	        }
	    }
	    if(dialogid == 122)
		{
			if(response == 1)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
           				if(IsAUrzednik(playerid) || IsABOR(playerid))//zaplecze
           				{
					        SetPlayerPos(playerid,1412.3348388672, -1790.5777587891, 15.370599746704);
					        SetPlayerVirtualWorld(playerid,0);
					        SetPlayerInterior(playerid,0);
					        PlayerInfo[playerid][pLocal] = 255;
					        SendClientMessage(playerid, COLOR_LIGHTGREEN, " *DING* Poziom 0, Zaplecze");
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD2, "Poziom zastrze�ony dla pracownik�w UM");
							return 1;
						}
			        }
			        case 1:
			        {
				        SetPlayerPos(playerid,1450.6615,-1819.2279,77.9613);//g��wna sala urz�du
				        SetPlayerVirtualWorld(playerid,50);
				        SetPlayerInterior(playerid,0);
	                    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
	                    SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Trwa jazda na Poziom 9 - G��wna sala urz�du <<<<");
	                    SendClientMessage(playerid, COLOR_WHITE, "  --> Okienka dla interesant�w");
	                    SendClientMessage(playerid, COLOR_WHITE, "  --> Wyj�cie na plac manewrowy");
	                    SendClientMessage(playerid, COLOR_WHITE, "  --> Toalety na ka�dym skrzydle");
                     	SendClientMessage(playerid, COLOR_WHITE, "  --> Biura & Sale konferencyjne & Senat & Burmistrz & Akademia");
                     	SendClientMessage(playerid, COLOR_WHITE, "  --> Biuro ochrony - biuro kamer");
                     	SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Prosz� czeka�, za chwil� otworz� si� drzwi(10sek) <<<<");
                     	PlayerInfo[playerid][pLocal] = 108;
			        }
					case 2:
					{
						SetPlayerPos(playerid,1481.5200,-1821.0967,58.1563);
						SetPlayerVirtualWorld(playerid,51);
				        SetPlayerInterior(playerid,0);
	                    TogglePlayerControllable(playerid,0);
                        Wchodzenie(playerid);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Trwa jazda na Poziom 10 - Kancelaria Burmistrza <<<<");
						PlayerInfo[playerid][pLocal] = 108;
						GameTextForPlayer(playerid, "~r~by skTom&skLolsy", 5000, 1);	
					}
				}
			}
		}
		else if(dialogid == 19)
		{
			if(response)
			{
				switch(listitem)//Winda FBI","[Poziom -1]Parking podziemny \n[Poziom 0]Parking\n[Poziom 0.5]\n Areszt federalny\n[Poziom 1]Recepcja\n[Poziom 2] Szatnia\n[Poziom 3] Zbrojownia \n[Poziom 4]Biura federalne \n[Poziom 5] Dyrektorat\n[Poziom 6]CID/ERT\n[Poziom 7]Sale Treningowe \n [Poziom X] Dach","Jedz","Anuluj");
				{
					case 0://parking podziemny
					{
						if(levelLock[FRAC_FBI][0] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,2);
						SetPlayerPos(playerid,1093.0625,1530.8715,6.6905);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom -1, Parking podziemny FBI");
						PlayerInfo[playerid][pLocal] = 255;
						GameTextForPlayer(playerid, "~p~by Simeone ~r~Cat", 5000, 1);
					}
					case 1://parking
					{
						if(levelLock[FRAC_FBI][1] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerPos(playerid,596.5255, -1489.2544, 15.3587);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 0, Parking FBI");
						GameTextForPlayer(playerid, "~p~by UbunteQ", 5000, 1);
						PlayerInfo[playerid][pLocal] = 255;
					}
					case 2://areszt federalny
					{
						if(levelLock[FRAC_FBI][2] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid, 1);
						SetPlayerPos(playerid, 594.05334, -1476.27490, 81.82840+0.5);
						GameTextForPlayer(playerid, "~p~Areszt federalny", 5000, 1);
						PlayerInfo[playerid][pLocal] = 255;
					}
					case 3://recepcja
					{
						if(levelLock[FRAC_FBI][3] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,1);
						SetPlayerPos(playerid,586.83704, -1473.89270, 89.30576);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 1, Recepcja");
						GameTextForPlayer(playerid, "~p~by UbunteQ & Iwan", 5000, 1);
						PlayerInfo[playerid][pLocal] = 212;
						Wchodzenie(playerid);
					}
					case 4://szatnia
					{
						if(levelLock[FRAC_FBI][4] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,2);
						SetPlayerPos(playerid,592.65466, -1486.76575, 82.10487);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 2, Szatnia");
						PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
						GameTextForPlayer(playerid, "~p~by UbunteQ & Iwan", 5000, 1);
						PlayerInfo[playerid][pLocal] = 255;
						Wchodzenie(playerid);
					
					}
					case 5://Zbrojownia
					{
						if(levelLock[FRAC_FBI][5] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,3);
						SetPlayerPos(playerid,591.37579, -1482.26672, 80.43560);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 3 - Zbrojownia");
						PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
						GameTextForPlayer(playerid, "~p~by UbunteQ & Iwan", 5000, 1);
						PlayerInfo[playerid][pLocal] = 255;

					}
					case 6://Biura federalne
					{
						if(levelLock[FRAC_FBI][6] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,4);
						SetPlayerPos(playerid,596.21857, -1477.92395, 84.06664);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 4, Biura Federalne");
						PlayerInfo[playerid][pLocal] = 255;
						Wchodzenie(playerid);

					}
					case 7://Dyrektorat
					{
						if(levelLock[FRAC_FBI][7] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,5);
						SetPlayerPos(playerid,589.23029, -1479.66357, 91.74274);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 5, Dyrektorat");
						PlayerInfo[playerid][pLocal] = 212;
						Wchodzenie(playerid);
					}
					case 8://CID ERT
					{
						if(levelLock[FRAC_FBI][8] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,6);
						SetPlayerPos(playerid,585.70782, -1479.54211, 99.01273);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 6, CID/ERT");
						PlayerInfo[playerid][pLocal] = 212;
					}
					case 9://sale treningowe
					{
						if(levelLock[FRAC_FBI][9] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid, 7);
						SetPlayerPos(playerid, 590.42767, -1447.62939, 80.95732);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 7, Sale Treningowe");
					}
					case 10:
					{
						if(levelLock[FRAC_FBI][10] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid, 8);
						SetPlayerPos(playerid, 605.5609, -1462.2583, 88.1674);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Poziom 8, Sale przes�ucha�");
					}
					case 11://dach
					{
						if(levelLock[FRAC_FBI][11] == 1 && PlayerInfo[playerid][pMember] != FRAC_FBI)
						{
							sendTipMessageEx(playerid, COLOR_RED, "Ten poziom jest zablokowany!"); 
							return 1;
						}
						Wchodzenie(playerid);
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerPos(playerid,613.4404,-1471.9745,73.8816);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "Dach");
						PlayerInfo[playerid][pLocal] = 255;
					}
				}
			}
		}
	    else if(dialogid == 12)
	    {
	        if(response)
	        {
				new string[256];
				switch(listitem)
	            {
					case 0..18:
					{
						ShowShopDialog(playerid);
					}
				}
	            switch(listitem)
	            {
					case 0:
					{
						if (kaska[playerid] > 56500)
						{
							new redisKey[64];
							format(redisKey, sizeof(redisKey), "player:%d:zdrapka", PlayerInfo[playerid][pUID]);
							if(RedisGetInt(redisKey) >= 4)
							{
								sendTipMessage(playerid, "Przepraszamy, zu�y�e� wszystkie zdrapki na naszym magazynie!"); 
								sendTipMessage(playerid, "Spr�buj przyj�� za godzin�, mo�e przyjd� nowe."); 
								return 1;
							}
							format(string, sizeof(string), "%s kupuje zdrapk� w sklepie i zaczyna j� zdrapywa�", GetNick(playerid)); 
							ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							new winValue = true_random(100);
							new playerValue = true_random(100);
							ZabierzKase(playerid, 56500);
							RedisIncrBy(redisKey, 1);
							RedisExpire(redisKey, 3600); // 1hour expire time
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
						    { 
								if(playerValue > winValue && playerValue >= 85)
								{
									new bonus = (PlayerInfo[playerid][pTraderPerk]*10000);
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 200.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 200000+bonus); 
								}
								else if(playerValue > winValue && playerValue < 85 && playerValue >= 50)
								{
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 85.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 85000); 
								}
								else if(playerValue < winValue && playerValue > 50)
								{
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 35.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 35000); 
								}
								else
								{
									format(string, sizeof(string), "Po zdrapaniu wida� napis ''Graj dalej'' ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								}
							}
							else
							{
								if(playerValue > winValue && playerValue >= 85)
								{
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 100.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 100000); 
								}
								else if(playerValue > winValue && playerValue < 85 && playerValue >= 50)
								{
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 55.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 55000); 
								}
								else if(playerValue < winValue && playerValue > 50)
								{
									format(string, sizeof(string), "Po zdrapaniu wida� wygran� 15.000$! ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									DajKase(playerid, 15000); 
								}
								else
								{
									format(string, sizeof(string), "Po zdrapaniu wida� napis ''Graj dalej'' ((%s))", GetNick(playerid));
									ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								}
							}
							return 1;
						}
					}
					case 1:
					{
		                if (kaska[playerid] > 500)
						{
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
						    {
								new skill = 500 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 500 - price;
						        format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
								ZabierzKase(playerid, payout);
						    }
						    else
						    {
						        format(string, sizeof(string), "~r~-$%d", 500);
								GameTextForPlayer(playerid, string, 5000, 1);
								ZabierzKase(playerid, 500);
						    }
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							new randphone = 10000 + random(89999);//minimum 1000  max 9999
							format(string, sizeof(string), "   Kupi�e� telefon. Tw�j numer to: %d", randphone);
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_GRAD5, "Mo�esz sprawdzi� go w ka�dej chwili wpisuj�c /stats");
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /telefonpomoc aby zobaczy� komendy telefonu.");
							Log(payLog, INFO, "%s kupi� telefon o numerze %d [Poprzedni: %d]", 
								GetPlayerLogName(playerid), randphone, PlayerInfo[playerid][pPnumber]
							);
							PlayerInfo[playerid][pPnumber] = randphone;
							MruMySQL_SetAccInt("PhoneNr", GetNickEx(playerid), randphone);
							return 1;
						}
					}
					case 2:
					{
						if (kaska[playerid] > 5000)
						{
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
						    {
								new skill = 5000 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 5000 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 5000);
								format(string, sizeof(string), "~r~-$%d", 5000);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			                PlayerInfo[playerid][pPhoneBook] = 1;
							format(string, sizeof(string), "   Ksi��ka telefoniczna zakupiona! Mo�esz teraz sprawdza� numery graczy !");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /numer <id/nick>.");
							return 1;
						}
					}
					case 3:
					{
						if (kaska[playerid] > 500)
						{
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
						    {
								new skill = 500 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 500 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 500);
								format(string, sizeof(string), "~r~-$%d", 500);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							gDice[playerid] = 1;
							format(string, sizeof(string), "   Kostka zakupiona. Mo�esz ni� rzuca� u�ywaj�c /kostka2");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							return 1;
						}
					}
					case 4:
					{
						if(kaska[playerid] > 5000)
						{
						    ZabierzKase(playerid, 5000);
						    GameTextForPlayer(playerid, "~r~-$5000", 5000, 1);
							PlayerInfo[playerid][pGun9] = 43;
							PlayerInfo[playerid][pAmmo9] += 100;
						    GivePlayerWeapon(playerid, 43, 100);
							SendClientMessage(playerid, COLOR_GRAD4, "Aparat zakupiony! Mo�esz nim teraz robi� zdj�cia!");
							return 1;
						}
					}
					case 5:
					{
						if (kaska[playerid] > 10000)
						{
							SendClientMessage(playerid, COLOR_WHITE, "   Brak Towaru!");
							return 1;
						}
					}
					case 6:
					{
						if (kaska[playerid] > 5000)
						{
							/*if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 5000 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 5000 - price;
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid,5000);
								format(string, sizeof(string), "~r~-$%d", 5000);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Pr�dko�ciomierz zakupiony.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /licznik ");*/
							SendClientMessage(playerid, COLOR_WHITE, "   Brak Towaru!");
							return 1;
						}
					}
					case 7:
					{
						if (kaska[playerid] > 49)
						{
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 50 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 50 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 50);
								format(string, sizeof(string), "~r~-$%d", 50);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							Condom[playerid] ++;
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Kondom Zakupiony.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							return 1;
						}
					}
					case 8:
					{
						if (kaska[playerid] > 2500)
						{
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 2500 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 2500 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 2500);
								format(string, sizeof(string), "~r~-$%d", 2500);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Odtwarzacz MP3 Zakupiony.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /muzyka");
							PlayerInfo[playerid][pCDPlayer] = 1;
							return 1;
						}
					}
					case 9:
					{
						if (kaska[playerid] > 20)
						{
						    if(PlayerInfo[playerid][pPiwo] >= 4)
						    {
						    	SendClientMessage(playerid, COLOR_GREY, "   Masz za du�o Piw, nie ud�wigniesz ju� wi�cej !");
						    }
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 20 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 20 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 20);
								format(string, sizeof(string), "~r~-$%d", 20);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Piwo 'Mruczny Gul; zakupione.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /piwo aby wypi�");
							format(string, sizeof(string), "~r~-$%d", 20);
							GameTextForPlayer(playerid, string, 5000, 1);
							PlayerInfo[playerid][pPiwo] += 1;
							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
							return 1;
						}
					}
					case 10:
					{
						if (kaska[playerid] > 25)
						{
						    if(PlayerInfo[playerid][pWino] >= 4)
						    {
						    	SendClientMessage(playerid, COLOR_GREY, "   Masz za du�o Win, nie ud�wigniesz ju� wi�cej !");
						    }
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 25 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 25 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 25);
								format(string, sizeof(string), "~r~-$%d", 25);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Wino 'Komandos zakupione'.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /komandos aby wypi�");
							format(string, sizeof(string), "~r~-$%d", 25);
							GameTextForPlayer(playerid, string, 5000, 1);
							PlayerInfo[playerid][pWino] += 1;
							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
							return 1;
						}
					}
					case 11:
					{
						if (kaska[playerid] > 15)
						{
						    if(PlayerInfo[playerid][pSprunk] >= 5)
						    {
						    	SendClientMessage(playerid, COLOR_GREY, "   Masz za du�o Sprunk�w, nie ud�wigniesz ju� wi�cej !");
						    }
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 15 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 15 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 15);
								format(string, sizeof(string), "~r~-$%d", 15);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Sprunk zakupiony.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /sprunk aby wypi� sprunka");
							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
							PlayerInfo[playerid][pSprunk] += 1;
							return 1;
						}
					}
					case 12:
					{
						if (kaska[playerid] > 2500)
						{
							if(PlayerInfo[playerid][pLevel] < 2)
							{
								sendErrorMessage(playerid, "CB Radio tylko od 2 lvl!");
								return 1;
							}

						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 2500 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 2500 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 2500);
								format(string, sizeof(string), "~r~-$%d", 2500);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "CB-RADIO Zakupione.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
	     					SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /cb w poje�dzie, aby rozmawia� z innymi.");
							PlayerInfo[playerid][pCB] = 1;
							return 1;
						}
					}
					case 13:
					{
						if (kaska[playerid] > 200)
						{
						    if(PlayerInfo[playerid][pCygaro] >= 1)
						    {
						    	SendClientMessage(playerid, COLOR_GREY, "   Masz ju� cygara, po co ci nast�pne?");
						    }
						    if(PlayerInfo[playerid][pTraderPerk] > 0)
					    	{
								new skill = 200 / 100;
								new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
								new payout = 200 - price;
								ZabierzKase(playerid, payout);
								format(string, sizeof(string), "~r~-$%d", payout);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							else
							{
							    ZabierzKase(playerid, 200);
								format(string, sizeof(string), "~r~-$%d", 200);
								GameTextForPlayer(playerid, string, 5000, 1);
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Paczka 5 cygar zakupiona.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							SendClientMessage(playerid, COLOR_WHITE, "WSKAZ�WKA: Wpisz /cygaro aby zapali�");
							PlayerInfo[playerid][pCygaro] = 5;
							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_WHITE, "   Nie masz na to pieni�dzy !");
						}
					}
					case 14:
					{
						if (kaska[playerid] >= 15000 )
						{
							PlayerInfo[playerid][pGun1] = 5;
		            		PlayerInfo[playerid][pAmmo1] = 1;
							GivePlayerWeapon(playerid, 5, 1);
							ZabierzKase(playerid, 15000);
							format(string, sizeof(string), "~r~-$%d", 15000);
							GameTextForPlayer(playerid, string, 5000, 1);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Zakupiono kij baseballowy.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_WHITE, "   Nie masz na to pieni�dzy !");
						}
					}
					case 15:
					{
						if (kaska[playerid] >= 35000 )
						{
							if(PlayerInfo[playerid][pCruiseController] == 1)
							{
								format(string, sizeof(string), "Ju� masz tempomat!");
								SendClientMessage(playerid, COLOR_GRAD4, string);
								return 1;
							}
							PlayerInfo[playerid][pCruiseController] = 1;
							ZabierzKase(playerid, 35000);
							format(string, sizeof(string), "~r~-$%d", 35000);
							GameTextForPlayer(playerid, string, 5000, 1);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Kupi�e� tempomat do auta. Wci�nij CTRL podczas jazdy, �eby aktywowa�.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							format(string, sizeof(string), "Aby zwi�kszy� pr�dko�� auta wci�nij lewy alt, zmniejszanie spacja.");
							SendClientMessage(playerid, COLOR_GRAD4, string);
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_WHITE, "   Nie masz na to pieni�dzy !");
						}
					}
					case 16: //kurczak
					{
						if(kaska[playerid] < 15) 
						{
							sendErrorMessage(playerid, "Nie sta� Ci� na mro�onego kurczaka!");
							return 1;
						}
						if(Groceries[playerid][pChicken] != 0)
						{
							sendErrorMessage(playerid, "Masz ju� mro�onego kurczaka.");
							return 1;
						}
						Groceries[playerid][pChicken] = random(300)+110;
						ZabierzKase(playerid, 15);
						GameTextForPlayer(playerid, "~r~-$15", 5000, 1);
						SendClientMessage(playerid, COLOR_GRAD4, "Kupi�e� mro�onego kurczaka.");
					}
					case 17: //pizza
					{
						if(kaska[playerid] < 30) 
						{
							sendErrorMessage(playerid, "Nie sta� Ci� na mro�on� pizze!");
							return 1;
						}
						if(Groceries[playerid][pPizza] != 0)
						{
							sendErrorMessage(playerid, "Masz ju� mro�on� pizze.");
							return 1;
						}
						Groceries[playerid][pPizza] = random(300)+90;
						ZabierzKase(playerid, 30);
						GameTextForPlayer(playerid, "~r~-$30", 5000, 1);
						SendClientMessage(playerid, COLOR_GRAD4, "Kupi�e� mro�on� pizz�.");
					}
					case 18: //hamburger
					{
						if(kaska[playerid] < 25) 
						{
							sendErrorMessage(playerid, "Nie sta� Ci� na mro�onego hamburgera!");
							return 1;
						}
						if(Groceries[playerid][pHamburger] != 0)
						{
							sendErrorMessage(playerid, "Masz ju� mro�onego hamburgera.");
							return 1;
						}
						Groceries[playerid][pHamburger] = random(300)+100;
						ZabierzKase(playerid, 25);
						GameTextForPlayer(playerid, "~r~-$25", 5000, 1);
						SendClientMessage(playerid, COLOR_GRAD4, "Kupi�e� mro�onego hamburgera.");
					}
					case 19: //maseczka ochronna
					{
						if(kaska[playerid] < 15000) 
						{
							sendErrorMessage(playerid, "Nie sta� Ci� na maseczk� ochronn�!");
							return 1;
						}
						if(GetPVarInt(playerid, "maseczka") == 1)
						{
							sendErrorMessage(playerid, "Masz ju� maseczk� ochronn�!");
							return 1;
						}
						ZabierzKase(playerid, 15000);
						SetPlayerImmunity(playerid, MAX_PLAYER_IMMUNITY);
						SetPVarInt(playerid, "maseczka", 1);
						EditAttachedObject(playerid, AttachPlayerItem(playerid, 18919, 2, -0.07, 0.0, 0.0, 85.0, 170.0, 86.0, 1.000000, 1.000000, 1.000000 ));
					}
				}
			}
		}
		else if(dialogid == 160)
		{
		    if(response)
		    {
		        ShowPlayerDialogEx(playerid, 161, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� komisariat?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	         	taxitest[playerid] = 0;
			}
		}
	 	else if(dialogid == 161)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
					case 0:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 1:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 2:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 3:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 5:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 6:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 7:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 8:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 9:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 10:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 11:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 12:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				    case 13:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
					case 14:
				    {
				        ShowPlayerDialogEx(playerid, 162, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� studio SAN?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
				    }
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 162)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 1:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				        ShowPlayerDialogEx(playerid, 163, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Fabryka Broni?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 163)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 164, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Salon Samochodowy?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 164)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
	                case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 165, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Ko�ci�?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 165)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 166, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznik Tower(biurowiec)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 166)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 167, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Mrucznikowy Gun Shop?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 167)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 168, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Agencja Ochrony (zk� bukmaherski)?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 168)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 169, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Szpital?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 169)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
				    case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 170, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Green Bar?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 170)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				    case 1:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
	                    taxitest[playerid] ++;
					}
					case 2:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 3:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 4:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 5:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 6:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 7:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 8:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 9:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 10:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 11:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 12:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 13:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
					case 14:
				    {
				    	ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_LIST, "W jakiej dzielnicy znajduje si� Bank?", "Rodeo\nGanton\nGlen Park\nDowntown\nPershing Square\nEl Corona\nIdlewood\nPlaya Del Seville\nOcean Docks\nVinewood\nMarket\nJefferson\nLos Flores\nEast Beach\nEast Los Santos", "Wybierz", "Wyjd�");
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	 	else if(dialogid == 171)
	 	{
	 	    if(response)
	 	    {
	 	        switch(listitem)
				{
				    case 0:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;
					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 1:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;
					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 2:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 171, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
				    case 3:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 4:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 5:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 6:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 7:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 8:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 9:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 10:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 11:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 12:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 13:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
					case 14:
				    {
				        if(taxitest[playerid] >= 8)
				        {
							ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Gratulacje, uda�o ci si� wyrobi� licencje taks�wkarsk�! Zostajesz taks�wkarzem. �wietnie znasz miasto.", "OK", "Wyjd�");
		                    taxitest[playerid] = 0;
		                    PlayerInfo[playerid][pJob] = 14;

					        PlayerInfo[playerid][pRank] = 0;
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Podpisa�e� kontrakt z firm� taks�wkars� na 5h, id� po swoj� taryf�! (Aby si� zwolni� wpisz /quitjob)");
					    }
					    else
					    {
					        ShowPlayerDialogEx(playerid, 172, DIALOG_STYLE_MSGBOX, "Wyniki", "Nie znasz miasta tak dobrze aby zosta� taks�wkarzem. Poje�dzij autobusami aby si� z nim zapozna�.", "OK", "Wyjd�");
					    }
					}
				}
	 	    }
	 	    if(!response)
	 	    {
	 	        taxitest[playerid] = 0;
	 	    }
	 	}
	    else if(dialogid == 20)
	    {
	        if(response)
	        {
	            SendClientMessage(playerid, 0xFFFFFFFF, "Bronie przywr�cone");
	            PrzywrocBron(playerid);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 10);
	        }
		}
	    else if(dialogid == 50)
	    {
	        if(response)
	        {
				ShowPlayerDialogEx(playerid,51,DIALOG_STYLE_MSGBOX,"Dost�pne malunki woz�w","Uranus\n\n0- Niebiesko ��ty kolor\n1-Niebiesko fioletowy kolor + grafika po bokach\n2- Niebieski kolor z b�yskawicami\n3- Wyczy�� malunek\n\nJester\n\n0-��to pomara�czowy kolor z pazurami tygrysa\n1-Niebiesko fioletowy kolor z grafik� po bokach\n2-Zielony prz�d, ciemno zielony ty�\n3- Wyczy�� malunek\n\nNaci�nij DALEJ","DALEJ","WSTECZ");
	        }
	    }
	    else if(dialogid == 51)
	    {
	        if(response)
	        {
	            ShowPlayerDialogEx(playerid,52,DIALOG_STYLE_MSGBOX,"Dost�pne malunki woz�w","Sultan\n\n0- Alien (fioletowy malunek)\n1- Niebieski kolor z rajdow� grafik�\n2- X-flow (niebiesko szary kolor)\n3- Wyczy�� malunek\n\nStratum\n\n0- Fioletowy kolor z t�czow� grafik�\n1- Acces (czerowny z grafik�)\n2- Sprunk\n3- Wyczy�� malunek\n\nElegy\n\n0- Niebieski kolor z p�omieniami\n1- Acces (pomara�czowy z grafik�)\n2- Fioletowy z grafik� po bokach\n3- Wyczy�� malunek\n\nNaci�nij DALEJ","DALEJ","WSTECZ");
	        }
			else
			{
				ShowPlayerDialogEx(playerid, 50, DIALOG_STYLE_MSGBOX, "Dost�pne malunki woz�w","LovRider`s:\n(Savanna,Tornado,Blade)\n0- ��te p�omienie\n1- Czerwono ��te paski\n2- Czerwone p�omienie z przodu\n3- Wyczy�� malunek\n\nRemington\n\n0- Br�zowe hieroglify\n1- Czerwono ��te p�omienie\n2- Niebieskie p�omienie\n3- Wyczy�� malunek\n\nSlamvan \n\n0- Czarny z r�owymi paskami\n1- Kolorowe p�omyczki\n2- ��te p�omienie\n3- Wyczy�� malunek\n\nNaci�nij DALEJ aby zobaczy� dalsz� list�","DALEJ","WYJD�");
			}
	    }
	    else if(dialogid == 52)
	    {
	        if(response)
	        {
	            ShowPlayerDialogEx(playerid,53,DIALOG_STYLE_MSGBOX,"Dost�pne malunki woz�w","Flash\n\n0- Czerwono ��ty z grafik�\n1- Fioletowo czerwony z grafik�\n2- Niebiesko fioletowy z grafik�\n3- Wyczy�� malunek\n\nBroadway\n\n0- ��te p�omienie na ca�ym aucie\n1- Czerwone p�omienie z przodu\n2 i 3- wyczy�� malunek\n\nCapmer\n\n0- Hipisowski malnuek\n1, 2 i 3 - wyszy�� malunek\n\n Tylko na wymienionych autach mo�na namalowa� malunek.","WYJD�","WSTECZ");
	        }
			else
			{
				ShowPlayerDialogEx(playerid,51,DIALOG_STYLE_MSGBOX,"Dost�pne malunki woz�w","Uranus\n\n0- Niebiesko ��ty kolor\n1-Niebiesko fioletowy kolor + grafika po bokach\n2- Niebieski kolor z b�yskawicami\n3- Wyczy�� malunek\n\nJester\n\n0-��to pomara�czowy kolor z pazurami tygrysa\n1-Niebiesko fioletowy kolor z grafik� po bokach\n2-Zielony prz�d, ciemno zielony ty�\n3- Wyczy�� malunek\n\nNaci�nij DALEJ","DALEJ","WSTECZ");
			}
	    }
		else if(dialogid == 53)
		{
			if(!response)
			{
				ShowPlayerDialogEx(playerid,52,DIALOG_STYLE_MSGBOX,"Dost�pne malunki woz�w","Sultan\n\n0- Alien (fioletowy malunek)\n1- Niebieski kolor z rajdow� grafik�\n2- X-flow (niebiesko szary kolor)\n3- Wyczy�� malunek\n\nStratum\n\n0- Fioletowy kolor z t�czow� grafik�\n1- Acces (czerowny z grafik�)\n2- Sprunk\n3- Wyczy�� malunek\n\nElegy\n\n0- Niebieski kolor z p�omieniami\n1- Acces (pomara�czowy z grafik�)\n2- Fioletowy z grafik� po bokach\n3- Wyczy�� malunek\n\nNaci�nij DALEJ","WYJD�","WSTECZ");
			}
		}
        else if(dialogid == 501)
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0:
				    {
				        new playa = mechanikid[playerid];
	                    new pojazd = GetPlayerVehicleID(playa);
	                    new model = GetVehicleModel(pojazd);
	                    new zderzakid;
	                    new zderzakid2;
	                    if(model == 562)//Elegy
						{
							zderzakid = 1172;
							zderzakid2 = 1148;
						}
						else if(model == 565)//Flash
						{
						    zderzakid = 1151;
							zderzakid2 = 1152;
						}
						else if(model == 561)//Stratum
						{
						    zderzakid = 1156;
							zderzakid2 = 1157;
						}
						else if(model == 559)//Jester
						{
						    zderzakid = 1161;
							zderzakid2 = 1173;
						}
						else if(model == 558)//Uranus
						{
						    zderzakid = 1165;
							zderzakid2 = 1167;
						}
						else if(model == 560)//Sultan
						{
						    zderzakid = 1140;
							zderzakid2 = 1170;
						}
						if(zderzakid == 0 || zderzakid2 == 0)
						{
						    SendClientMessage(playerid, COLOR_WHITE, "B��D!");
						}
						else
						{
		                    new sendername[MAX_PLAYER_NAME];
		                    new giveplayer[MAX_PLAYER_NAME];
		                    new string[256];

							GetPlayerName(playerid, sendername, sizeof(sendername));
		   					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							format(string, sizeof(string), "* Zamontowa�e� nowe zderzaki graczowi %s (koszt -10 000$)",giveplayer);
			    			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		      				format(string, sizeof(string), "* Mechanik %s zamontowa� ci w twoim %s nowe zderzaki",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia i montuje nowe zderzaki w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Log(payLog, INFO, "%s zamontowa� %s zderzaki [%d, %d] na pojazd %s za %d$",
								GetPlayerLogName(playerid), GetPlayerLogName(playa), zderzakid, zderzakid2, GetVehicleLogName(pojazd), 10000
							);
							ZabierzKase(playerid, 10000);
							format(string, sizeof(string), "~r~-$%d", 10000);
							GameTextForPlayer(playerid, string, 5000, 1);
		     				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			    			AddVehicleComponent(pojazd, zderzakid);//zderzak
			    			AddVehicleComponent(pojazd, zderzakid2);//zderzak

                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][0] = zderzakid;
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][1] = zderzakid2;
                            Car_Save(VehicleUID[pojazd][vUID], CAR_SAVE_TUNE);
						}
				    }
				    case 1:
				    {
				        new playa = mechanikid[playerid];
	           			new pojazd = GetPlayerVehicleID(playa);
	           			new model = GetVehicleModel(pojazd);
	                    new zderzakid;
	                    new zderzakid2;
	                    if(model == 562)//Elegy
						{
						    zderzakid = 1171;
							zderzakid2 = 1149;
						}
						else if(model == 565)//Flash
						{
						    zderzakid = 1150;
							zderzakid2 = 1153;
						}
						else if(model == 561)//Stratum
						{
						    zderzakid = 1154;
							zderzakid2 = 1155;
						}
						else if(model == 559)//Jester
						{
						    zderzakid = 1159;
							zderzakid2 = 1160;
						}
						else if(model == 558)//Uranus
						{
						    zderzakid = 1166;
							zderzakid2 = 1168;
						}
						else if(model == 560)//Sultan
						{
						    zderzakid = 1141;
							zderzakid2 = 1169;
						}
						if(zderzakid == 0 || zderzakid2 == 0)
						{
						    SendClientMessage(playerid, COLOR_WHITE, "B��D!");
						}
						else
						{
		                    new sendername[MAX_PLAYER_NAME];
		                    new giveplayer[MAX_PLAYER_NAME];
		                    new string[256];

							GetPlayerName(playerid, sendername, sizeof(sendername));
		   					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							format(string, sizeof(string), "* Zamontowa�e� nowe zderzaki graczowi %s (koszt -10 000$)",giveplayer);
			    			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		      				format(string, sizeof(string), "* Mechanik %s zamontowa� ci w twoim %s nowe zderzaki",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia i montuje nowe zderzaki w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Log(payLog, INFO, "%s zamontowa� %s zderzaki [%d, %d] na pojazd %s za %d$",
								GetPlayerLogName(playerid), GetPlayerLogName(playa), zderzakid, zderzakid2, GetVehicleLogName(pojazd), 10000
							);
							ZabierzKase(playerid, 10000);
							format(string, sizeof(string), "~r~-$%d", 10000);
							GameTextForPlayer(playerid, string, 5000, 1);
		     				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			    			AddVehicleComponent(pojazd, zderzakid);//zderzak
			    			AddVehicleComponent(pojazd, zderzakid2);//zderzak
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][0] = zderzakid;
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][1] = zderzakid2;
                            Car_Save(VehicleUID[pojazd][vUID], CAR_SAVE_TUNE);
						}
				    }
				}
			}
	    }
	    else if(dialogid == 502)
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0:
				    {
				        new playa = mechanikid[playerid];
	                    new pojazd = GetPlayerVehicleID(playa);
	                    new model = GetVehicleModel(pojazd);
	                    new zderzakid;
	                    new zderzakid2;
						if(model == 575)//brodway
						{
						    zderzakid = 1174;
						    zderzakid2 = 1176;
						}
						else if(model == 534)//remington
						{
						    zderzakid = 1179;
						    zderzakid2 = 1180;
						}
						else if(model == 536)//Blade
						{
						    zderzakid = 1182;
						    zderzakid2 = 1184;
						}
						else if(model == 567)//Savanna
						{
						    zderzakid = 1187;
						    zderzakid2 = 1189;
						}
						else if(model == 576)//Tornado
						{
						    zderzakid = 1191;
						    zderzakid2 = 1192;
						}
						if(zderzakid == 0 || zderzakid2 == 0)
						{
						    SendClientMessage(playerid, COLOR_WHITE, "B��D!");
						}
						else
						{
		                    new sendername[MAX_PLAYER_NAME];
		                    new giveplayer[MAX_PLAYER_NAME];
		                    new string[256];
							GetPlayerName(playerid, sendername, sizeof(sendername));
		   					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							format(string, sizeof(string), "* Zamontowa�e� nowe zderzaki graczowi %s (koszt -10 000$)",giveplayer);
			    			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		      				format(string, sizeof(string), "* Mechanik %s zamontowa� ci w twoim %s nowe zderzaki",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia i montuje nowe zderzaki w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Log(payLog, INFO, "%s zamontowa� %s zderzaki [%d, %d] na pojazd %s za %d$",
								GetPlayerLogName(playerid), GetPlayerLogName(playa), zderzakid, zderzakid2, GetVehicleLogName(pojazd), 10000
							);
							ZabierzKase(playerid, 10000);
							format(string, sizeof(string), "~r~-$%d", 10000);
							GameTextForPlayer(playerid, string, 5000, 1);
		     				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			    			AddVehicleComponent(pojazd, zderzakid);//zderzak
			    			AddVehicleComponent(pojazd, zderzakid2);//zderzak
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][0] = zderzakid;
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][1] = zderzakid2;
                            Car_Save(VehicleUID[pojazd][vUID], CAR_SAVE_TUNE);
						}
				    }
				    case 1:
				    {
				        new playa = mechanikid[playerid];
				        new pojazd = GetPlayerVehicleID(playa);
				        new model = GetVehicleModel(pojazd);
				        new zderzakid;
	                    new zderzakid2;
						if(model == 575)//broadway
						{
	                        zderzakid = 1175;
						    zderzakid2 = 1177;
						}
						else if(model == 534)//remington
						{
						    zderzakid = 1178;
						    zderzakid2 = 1185;
						}
						else if(model == 536)//Blade
						{
						    zderzakid = 1181;
						    zderzakid2 = 1183;
						}
						else if(model == 567)//Savanna
						{
						    zderzakid = 1186;
						    zderzakid2 = 1188;
						}
						else if(model == 576)//Tornado
						{
						    zderzakid = 1190;
						    zderzakid2 = 1193;
						}
						if(zderzakid == 0 || zderzakid2 == 0)
						{
						    SendClientMessage(playerid, COLOR_WHITE, "B��D!");
						}
						else
						{
		                    new sendername[MAX_PLAYER_NAME];
		                    new giveplayer[MAX_PLAYER_NAME];
		                    new string[256];
							GetPlayerName(playerid, sendername, sizeof(sendername));
		   					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							format(string, sizeof(string), "* Zamontowa�e� nowe zderzaki graczowi %s (koszt -10 000$)",giveplayer);
			    			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		      				format(string, sizeof(string), "* Mechanik %s zamontowa� ci w twoim %s nowe zderzaki",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia i montuje nowe zderzaki w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Log(payLog, INFO, "%s zamontowa� %s zderzaki [%d, %d] na pojazd %s za %d$",
								GetPlayerLogName(playerid), GetPlayerLogName(playa), zderzakid, zderzakid2, GetVehicleLogName(pojazd), 10000
							);
							ZabierzKase(playerid, 10000);
							format(string, sizeof(string), "~r~-$%d", 10000);
							GameTextForPlayer(playerid, string, 5000, 1);
		     				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			    			AddVehicleComponent(pojazd, zderzakid);//zderzak
			    			AddVehicleComponent(pojazd, zderzakid2);//zderzak
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][0] = zderzakid;
                            CarData[VehicleUID[pojazd][vUID]][c_Bumper][1] = zderzakid2;
                            Car_Save(VehicleUID[pojazd][vUID], CAR_SAVE_TUNE);
						}
				    }
				}
			}
	    }
	    else if(dialogid == 503)
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0:
				    {
				        new playa = mechanikid[playerid];
	                    new pojazd = GetPlayerVehicleID(playa);
	                    new sendername[MAX_PLAYER_NAME];
	                    new giveplayer[MAX_PLAYER_NAME];
	                    new string[256];

						GetPlayerName(playerid, sendername, sizeof(sendername));
	   					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "* Zamontowa�e� nowe zderzaki graczowi %s (koszt -10 000$)",giveplayer);
		    			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	      				format(string, sizeof(string), "* Mechanik %s zamontowa� ci w twoim %s nowe zderzaki",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
						SendClientMessage(playa, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),"* Mechanik %s wyci�ga narz�dzia i montuje nowe zderzaki w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
						ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						Log(payLog, INFO, "%s zamontowa� %s zderzaki [%d, %d] na pojazd %s za %d$",
							GetPlayerLogName(playerid), GetPlayerLogName(playa), 1133, 1117, GetVehicleLogName(pojazd), 10000
						);
						ZabierzKase(playerid, 10000);
						format(string, sizeof(string), "~r~-$%d", 10000);
						GameTextForPlayer(playerid, string, 5000, 1);
	     				PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		    			AddVehicleComponent(pojazd,1117);//zderzak
                        CarData[VehicleUID[pojazd][vUID]][c_Bumper][0] = 1117;
                        Car_Save(VehicleUID[pojazd][vUID], CAR_SAVE_TUNE);
				    }
				}
			}
        }
	    else if(dialogid == 876)
	    {
			if(response)
			{
			    new string[64] = {0, ...};
				new sendername[MAX_PLAYER_NAME];
            	GetPlayerName(playerid, sendername, sizeof(sendername));
				ResetPlayerWeapons(playerid);
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(PlayerInfo[playerid][pGun0] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
						PlayerInfo[playerid][pGun0] = 0;
						PlayerInfo[playerid][pAmmo0] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j kastet zosta� usuni�ty");
						
            			format(string, sizeof(string),"%s niszczy kastet i rzuca na ziemi�.", sendername);
					}
			        case 1:
			        {
			            if(PlayerInfo[playerid][pGun1] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun1] = 0;
						PlayerInfo[playerid][pAmmo1] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Twoja bro� bia�a zosta�a usni�ta");
						
						format(string, sizeof(string),"%s niszczy bro� bia�� i rzuca na ziemi�.", sendername);
			        }
			        case 2:
			        {
			            if(PlayerInfo[playerid][pGun2] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun2] = 0;
						PlayerInfo[playerid][pAmmo2] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j pistolet zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy pistolet i rzuca na ziemi�.", sendername);
			        }
			        case 3:
			        {
			            if(PlayerInfo[playerid][pGun3] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
	                    PlayerInfo[playerid][pGun3] = 0;
						PlayerInfo[playerid][pAmmo3] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Twoja strzelba zosta�a usuni�ta");
						
						format(string, sizeof(string),"%s niszczy strzelb� i rzuca na ziemi�.", sendername);
			        }
			        case 4:
			        {
			            if(PlayerInfo[playerid][pGun4] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
	                    PlayerInfo[playerid][pGun4] = 0;
						PlayerInfo[playerid][pAmmo4] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j pistolet maszynowy zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy pistolet maszynowy i rzuca na ziemi�.", sendername);
			        }
			        case 5:
			        {
			            if(PlayerInfo[playerid][pGun5] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun5] = 0;
						PlayerInfo[playerid][pAmmo5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j karabin maszynowy zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy karabin maszynowy i rzuca na ziemi�.", sendername);
			        }
			        case 6:
			        {
			            if(PlayerInfo[playerid][pGun6] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun6] = 0;
						PlayerInfo[playerid][pAmmo6] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Twoja snajperka zosta�a usuni�ta");
						
						format(string, sizeof(string),"%s niszczy snajperk� i rzuca na ziemi�.", sendername);
			        }
			        case 7:
			        {
			            if(PlayerInfo[playerid][pGun7] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun7] = 0;
						PlayerInfo[playerid][pAmmo7] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j ogniomiotacz zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy ogniomiotacz i rzuca na ziemi�.", sendername);
			        }
			        case 8:
			        {
			            if(PlayerInfo[playerid][pGun8] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun8] = 0;
						PlayerInfo[playerid][pAmmo8] = 0;
						PlayerInfo[playerid][pGun12] = 0;
						PlayerInfo[playerid][pAmmo12] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Twoje C4 zosta�o usuni�te");
						
						format(string, sizeof(string),"%s niszczy C4 i rzuca na ziemi�.", sendername);
			        }
			        case 9:
			        {
			            if(PlayerInfo[playerid][pGun9] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun9] = 0;
						PlayerInfo[playerid][pAmmo9] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j sprej/aparat/ga�nica zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy spray/aparat/ga�nic� i rzuca na ziemi�.", sendername);
			        }
			        case 10:
			        {
			            if(PlayerInfo[playerid][pGun10] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun10] = 0;
						PlayerInfo[playerid][pAmmo10] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Twoje kwiaty/laska/dildo zosta�o usuni�te");
						
						format(string, sizeof(string),"%s niszczy kwiaty/lask�/dildo i rzuca na ziemi�.", sendername);
			        }
			        case 11:
			        {
			            if(PlayerInfo[playerid][pGun11] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun11] = 0;
						PlayerInfo[playerid][pAmmo11] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j spadochron zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy spadochron i rzuca na ziemi�.", sendername);
			        }
			        case 12:
			        {
			            if(PlayerInfo[playerid][pGun12] == 0) return sendErrorMessage(playerid, "Nie masz broni pod tym slotem!");
			            PlayerInfo[playerid][pGun12] = 0;
						PlayerInfo[playerid][pAmmo12] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "Tw�j detonator zosta� usuni�ty");
						
						format(string, sizeof(string),"%s niszczy detonator i rzuca na ziemi�.", sendername);
			        }
				}

				SetTimerEx("UsuwanieBroniReset", 1000, 0, "d", playerid);
				ShowPlayerDialogEx(playerid, 876, DIALOG_STYLE_LIST, "Usuwanie broni", "Kastet\nBro� bia�a\nPistolet\nStrzelba\nPistolet maszynowy\nKarabin\nSnajperka\nOgniomiotacz\nC4\nAparat/Sprej\nKwiaty/Laska/Dildo\nSpadochron\nDetonator", "Usu�", "Wyjd�");
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
	    }
	    else if(command_businfo_dialog(playerid, dialogid, response, listitem, inputtext))
		{
			return 1;
		}
	    else if(command_trasa_dialog(playerid, dialogid, response, listitem, inputtext))
		{
			return 1;
		}
	 	if(dialogid == D_PJTEST)
		{
			if(response == 1)
      	  	{
				for(new i; i<9; i++)
				{
            		prawoJazdyLosowanie[i] = i;
				}
            	PrawoJazdyRandomGUITest(playerid, prawoJazdyLosowanie, 9 - PlayerInfo[playerid][pPrawojazdypytania]);
            	return 1;
 			}
    	}
  		new question_ids[] = {3, 4, 5, 6, 7, 8, 9, 10, 21};
    	new correct_answers[][] = {"911", "tak", "30", "prawa", "trojkat", "140", "50", "120", "trojkat"};

    	new question_id = -1;

   		for(new i; i < sizeof(question_ids); i++)
    	{
        	if(dialogid == question_ids[i])
        	{
            	question_id = i;
           		break;
        	}
    	}
	   	if(question_id != -1 && response)
		{
			if((strcmp(inputtext, correct_answers[question_id], true) == 0)
        	&& strlen(inputtext) > 1)
        	{
            	PlayerInfo[playerid][pPrawojazdydobreodp] += 1;
        	}
        	KillTimer(TiPJTGBKubi[playerid]);
       		PlayerInfo[playerid][pPrawojazdypytania] += 1;

       		if(PlayerInfo[playerid][pPrawojazdypytania] == 3)
       		{
           		if(PlayerInfo[playerid][pPrawojazdydobreodp] == 3)
           		{
                	PlayerInfo[playerid][pSprawdzczyzdalprawko] = 1;
               		ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_MSGBOX, "Zda�e�!", "Gratulujemy!\r\nZda�e� test na Prawo Jazdy.\r\nZg�o� si� do Urz�dnika w celu\r\nodebrania tych dokument�w!", "OK", "");
                	PlayerInfo[playerid][pCarLic] = 2;
            	}
           		else
           		{
                	PlayerInfo[playerid][pSprawdzczyzdalprawko] = 0;
                	ShowPlayerDialogEx(playerid, 15, DIALOG_STYLE_MSGBOX, "Obla�e�!", "Obla�e�!\r\nNie zda�e� poprawnie testu\r\nna prawo jazdy!\r\nZg�o� si� za 1h", "OK", "");
           		}
		   		new string [256];
           		new playername[MAX_PLAYER_NAME];
		   		GetPlayerName(playerid, playername, sizeof(playername));
		   		format(string, sizeof(string), "* %s odk�ada d�ugopis i przesuwa test w stron� urz�dnika", playername);
		   		ProxDetector(40.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
           		PlayerInfo[playerid][pWtrakcietestprawa] = 0;
           		SetTimerEx("CleanPlayaPointsPJ", 30000, 0, "i", playerid);
			}
			else
 			{
 				PrawoJazdyRandomGUITest(playerid, prawoJazdyLosowanie, 9 - PlayerInfo[playerid][pPrawojazdypytania]);
			}
		}
  		
  		
		//logowanie w GUI
		if(dialogid == D_LOGIN)
		{
		    if(response)
		    {
			    if(IsPlayerConnected(playerid))
			    {
			        if(strlen(inputtext) >= 1 && strlen(inputtext) <= MAX_PASSWORD_LENGTH)
			        {
						OnPlayerLogin(playerid, inputtext);
					}
					else
					{
	        			SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany za niewpisanie has�a!");
			            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany z powodu bezpiecze�stwa za wpisanie pustego has�a. Zapraszamy ponownie.", "Wyjd�", "");
	                    GUIExit[playerid] = 0;
	                    SetPlayerVirtualWorld(playerid, 0);
						KickEx(playerid, "niewpisanie has�a");
					}
				}
			}
			if(!response)
			{
				SendClientMessage(playerid, COLOR_PANICRED, "Wyszed�e� z serwera, zosta�e� roz��czony. Zapraszamy ponownie!");
	            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Wyszed�e� z logowania, zosta�e� roz��czony. Zapraszamy ponownie!", "Wyjd�", "");
	            GUIExit[playerid] = 0;
	            SetPlayerVirtualWorld(playerid, 0);
				KickEx(playerid, "anulowanie logowania");
			}
			return 1;
		}
		if(dialogid == D_REGISTER)
		{
		    if(response)
		    {
		        if(IsPlayerConnected(playerid))
			    {
			        if(strlen(inputtext) >= 1 && strlen(inputtext) <= 64)
			        {
						OnPlayerRegister(playerid, inputtext);
						GUIExit[playerid] = 0;
						SetPlayerVirtualWorld(playerid, 0);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany za niewpisanie has�a!");
			            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany z powodu bezpiecze�stwa za wpisanie pustego lub zbyt d�ugiego has�a. Zapraszamy ponownie.", "Wyjd�", "");
	                    GUIExit[playerid] = 0;
	                    SetPlayerVirtualWorld(playerid, 0);
						KickEx(playerid, "niewpisanie has�a");
					}
				}
				return 1;
	   		}
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_PANICRED, "Wyszed�e� z serwera, zosta�e� roz��czony. Zapraszamy ponownie!");
	            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Wyszed�e� z rejestracji, zosta�e� roz��czony. Zapraszamy ponownie!", "Wyjd�", "");
				KickEx(playerid, "anulowanie logowania");
		    }
		}
		if(dialogid == 235)
		{
		    if(response)
		    {
		        if(strlen(inputtext) >= 1 && strlen(inputtext) <= 64)
			    {
					if(strcmp(inputtext,"SiveMopY", false) == 0 || (DEVELOPMENT && strcmp(inputtext,"DevModeON", false) == 0) )//WiE772Min Zi3EeL$sKoXnUBy RaTMiiN67 --> Has�o administracyjne
					{
						weryfikacja[playerid] = 1;
						if(PlayerInfo[playerid][pJailed] == 0)
						{
							SetPVarInt(playerid, "spawn", 1);
							SetPlayerSpawn(playerid);
							TogglePlayerSpectating(playerid, false);
							lowcap[playerid] = 1;
							ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_MSGBOX, "Serwer", "Czy chcesz si� teleportowa� do poprzedniej pozycji?", "TAK", "NIE");
						}
						else
						{
							SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
							SetPlayerSpawn(playerid);
							TogglePlayerSpectating(playerid, false);
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany!");
						ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany.", "Wyjd�", "");
						GUIExit[playerid] = 0;
						SetPlayerVirtualWorld(playerid, 50);
						KickEx(playerid, "niepoprawna weryfikacja");
					}
			    }
			    else
			    {
					SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany za niewpisanie has�a!");
					ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany z powodu bezpiecze�stwa za wpisanie pustego lub zbyt d�ugiego has�a. Zapraszamy ponownie.", "Wyjd�", "");
					GUIExit[playerid] = 0;
				    SetPlayerVirtualWorld(playerid, 50);
					KickEx(playerid, "niewpisanie has�a");
			    }
		    }
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_PANICRED, "Wyszed�e� z weryfikacji, zosta�e� roz��czony!");
	            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Wyszed�e� z weryfikacji, zosta�e� roz��czony!", "Wyjd�", "");
	            GUIExit[playerid] = 0;
	            SetPlayerVirtualWorld(playerid, 50);
				KickEx(playerid, "brak weryfikacji administratora");
		    }
		}
		if(dialogid == 237)
		{
		    if(response)
		    {
		        if(strlen(inputtext) >= 1 && strlen(inputtext) <= 50)
			    {
			        if(strcmp(inputtext,"TheGFPower69", false) == 0)//Zi3EeL$sKoXnUBy WiE772Min
			        {
					    weryfikacja[playerid] = 1;
					    new gf[64], nickbrusz[MAX_PLAYER_NAME];
			        	GetPlayerName(playerid, nickbrusz, sizeof(nickbrusz));
						format(gf, sizeof(gf), "Admini/%s.ini", nickbrusz);
					    if(!dini_Exists(gf))
				        {
				            dini_Create(gf);
				            dini_IntSet(gf, "Godziny_Online", 0);
							dini_FloatSet(gf, "Realna_aktywnosc", 0);
							dini_IntSet(gf, "Ilosc_Kickow", 0);
							dini_IntSet(gf, "Ilosc_Banow", 0);
				        }
					    OnPlayerLogin(playerid, "GuL973TekeSTDz4-36");
					}
			        else
			        {
			            SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany!");
				        ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany.", "Wyjd�", "");
				        GUIExit[playerid] = 0;
				        SetPlayerVirtualWorld(playerid, 0);
						KickEx(playerid, "niepoprawna weryfikacja administratora");
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_PANICRED, "Zosta�e� zkickowany!");
				    ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Zosta�e� zkickowany.", "Wyjd�", "");
				    GUIExit[playerid] = 0;
				    SetPlayerVirtualWorld(playerid, 0);
					KickEx(playerid, "niepoprawna weryfikacja administratora");
			    }
		    }
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_PANICRED, "Wyszed�e� z weryfikacji, zosta�e� roz��czony!");
	            ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "Wyszed�e� z weryfikacji, zosta�e� roz��czony!", "Wyjd�", "");
	            GUIExit[playerid] = 0;
	            SetPlayerVirtualWorld(playerid, 0);
				KickEx(playerid, "niepoprawna weryfikacja administratora");
		    }
		}
	 	if(dialogid == 325)
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0:
	                {
	                    if(Kredyty[playerid] >= 10)
	                    {
	                    	SetPlayerPos(playerid, 578.9954,-2194.5471,7.1380);//trampolina 5m
				        	GameTextForPlayer(playerid, "~w~Wysokosc 5m ~r~Pobrano 10 kredytow", 5000, 1);
				        	Kredyty[playerid] -= 10;
				        }
				        else
				        {
				            SendClientMessage(playerid, COLOR_GREY, "Nie masz 10 kredyt�w.");
				        }
	                }
	                case 1:
	                {
	                    if(Kredyty[playerid] >= 20)
	                    {
		                    SetPlayerPos(playerid, 577.5804,-2194.8018,12.1380);//trampolina 10m
					        GameTextForPlayer(playerid, "~w~Wysokosc 10m ~r~Pobrano 20 kredytow", 5000, 1);
					        Kredyty[playerid] -= 20;
	                    }
				        else
				        {
				            SendClientMessage(playerid, COLOR_GREY, "Nie masz 20 kredyt�w.");
				        }
	                }
		        }
		    }
		}
		if(dialogid == 324)//wybieralka wej�� FBI
		{
		    if(response)
		    {
		        switch(listitem)
				{
				    case 0:
					{
						SetPlayerPos(playerid, -653.34765625,-5448.5634765625,13.368634223938);
						TogglePlayerControllable(playerid, 0);
						SetPlayerInterior(playerid, 0);
                        Wchodzenie(playerid);
		                SetPlayerInterior(playerid, 8);
		                ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "Strzelnica FBI", "Kryta strzelnica pozwal�ca �wiczy� celno�� z deagl'a mp5 i innych broni\n Zadanie polega na zestrzeleniu jak najwi�kszej liczby manekin�w w czasie ustalonym przez prowadz�cego trening\n Ka�dy celny strza� to 1 punkt\n Obowi�zuje zasada: 1 niecelny strza� = 1 punkt mniej\n (( aby sprawdzi� ile naboi ma agent u�yj /sb [ID]))", "Rozpocznij", "Wyjd�");//Strzelnica FBI �rodek
					}
					case 1:
					{
					    new txt1[1024] = "Dzi�ki tej sprzelnicy na otwartym powietrzu mo�na �wiczy� precyzyjne i dok�adne strza�y z m4,mp5 i rifle\n Cele s� dwucz�ciowe: sk�adaj� si� z g�owy i reszty cia�a\n Zalecane s�: 3 pkt za strza� w g�ow� i 1pkt za strza� w cel\n ";
					    new txt2[512] = "W tym �wiczeniu nie przewidziano ogranicze� czasowych\n, agent oddaje strza� tylko do jednego celu zu�ywaj�c max 3 naboje\n Zniszczenie budki w kt�rej stoi cel skutkuje niezaliczeniem zadania";
					    strcat(txt1, txt2, sizeof(txt1));
					    SetPlayerPos(playerid, 1703.9327392578,141.29598999023,30.903503417969);
						TogglePlayerControllable(playerid, 0);
						SetPlayerInterior(playerid, 0);
                        Wchodzenie(playerid);
		                ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "Strzelnica terenowa FBI", txt1, "Rozpocznij", "Wyjd�");//sTRZELNICA TERENOWA
					}
					case 2:
					{
					    SetPlayerPos(playerid, 1581.8731689453,5490.7412109375,329.73870849609);
						TogglePlayerControllable(playerid, 0);
						SetPlayerInterior(playerid, 0);
						GivePlayerWeapon(playerid, 46, 1);
                        Wchodzenie(playerid);
		                ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "Wie�a spadochroniarska", "Nale�y odpowiednio przeprowadzi� atak z powietrza\n Zadanie polega na wyl�dowaniu na specjalnej tarczy, ilo�c przyznawanych punkt�w jest zale�na od precyzji l�dowania\n Dla zaawansowanych agent�w przewidziano r�wnie� trening p�ywacki\n nale�y przep�yn�� przez rur� znajduj�c� sie pod wod� i wyp�yn�� na powierzchni�.", "Rozpocznij", "Wyjd�");//spadochrin wej�cie �rodek
					}
					case 3:
					{
					    new txt1[1024] = "W opuszczonym domu przest�pcy przetrzymuj� zak�adnik�w\n Zadanie polega na zlikwidowaniu wszytkich przest�pc�w (kobiety) bez �adnych strat w cywilach ( ludzie nieuzbrojeni i m�czy�ni)\n Czas na wykonanie zadania to 1minuta\n Zu�ycie naboi to max 40\n Prowadz�cy trening musi znajdowa� si� w pomieszczeniu aby po 1 minucie podliczy� wyniki agenta\n Na torze znajduje si� 17 zak�adnik�w i 17 bandyt�w";
					    new txt2[512] = "\n Na torze znajduj� sie r�wnie� headshoty i zadanie na celno��\n Zaleca si� przyznawa� 1 pkt za przest�pce -5pkt za zak�adnika 2pkt za headshot oraz 5 pkt za manekina\n Czas powy�ej 1:30sek oraz zu�ycie wi�cej ni� 40 naboi skutkuje niezaliczeniem zadania";
					    strcat(txt1, txt2, sizeof(txt1));
					    SetPlayerPos(playerid, 2236.0786132813,-6891.2177734375,21.423152923584);
						TogglePlayerControllable(playerid, 0);
						SetPlayerInterior(playerid, 8);
                        Wchodzenie(playerid);
		                ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "Szturm na dom", txt1, "Kontynuuj", "Wyjd�");
					}
				}
		    }
		}
		if(dialogid == 60)//cofaczka zmian nick�w
		{
		    if(response)
		    {
				new string [64];
		        switch(listitem)
				{
				    case 0:
					{
						if (kaska[playerid] >= 60000000)
						{
							PlayerInfo[playerid][pZmienilNick] ++;
							format(string, sizeof(string), "%s[%d] cofn��e� jedn� zmian� nicku. Ilo�� wykorzystanych zmian zobaczysz w /stats.",GetNick(playerid),PlayerInfo[playerid][pUID]);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Koszt: 60.000.000$");
							Log(payLog, INFO, "%s cofn�� sobie zmian� nicku za 60000000$", GetPlayerLogName(playerid));
							ZabierzKase(playerid, 60000000);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "Nie masz tyle!");
						}
					}
					case 1:
					{
						if (kaska[playerid] >= 25000000 && PlayerInfo[playerid][pExp] >= 180)
						{
							format(string, sizeof(string), "%s cofn��e� jedn� zmian� nicku. Ilo�� wykorzystanych zmian zobaczysz w /stats.",GetNick(playerid));
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Koszt: 25.000.000$ i 180 punkt�w respektu");
							Log(payLog, INFO, "%s cofn�� sobie zmian� nicku za 25000000$ i 180 punkt�w respektu", GetPlayerLogName(playerid));
							PlayerInfo[playerid][pZmienilNick] ++;
							ZabierzKase(playerid, 25000000);
							PlayerInfo[playerid][pExp] -=180;
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "Nie masz tyle!");
						}
					}
					case 2:
					{
					    if (PlayerInfo[playerid][pExp] >= 340)
						{
							format(string, sizeof(string), "%s cofn��e� jedn� zmian� nicku. Ilo�� wykorzystanych zmian zobaczysz w /stats.",GetNick(playerid));
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Koszt: 340 punkt�w respektu");
							Log(payLog, INFO, "%s cofn�� sobie zmian� nicku za 340 punkt�w respektu", GetPlayerLogName(playerid));
							PlayerInfo[playerid][pZmienilNick] ++;
							PlayerInfo[playerid][pExp] -=340;
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "Nie masz tyle!");
						}
					}
					case 3:
					{

						SendClientMessage(playerid,COLOR_P@,"|_________________________Odj�cie zmiany nicku_________________________|");
						SendClientMessage(playerid,COLOR_WHITE,"Zmiana nicku to dobra rzecz. Jednak wszytko co dobre kiedy� si� ko�czy :c ");
						SendClientMessage(playerid,COLOR_WHITE,"Dlatego umo�liwili�my wam zmiany nicku w dowolnym momencie po wykorzystaniu wszytkich 10 zmian");
						SendClientMessage(playerid,COLOR_WHITE,"Ka�da z opcji jest odpowiednio wywa�ona. Mo�emy wybra� czy wolimy zyska� zmian� cz�st� gr� czy pieni�dzmi.");
						SendClientMessage(playerid,COLOR_WHITE,"Opcja jest dost�pna tylko dla 3lvl KP poniewa� teorytycznie inni mog� zwi�kszy� limit zmian nick�w.");
						SendClientMessage(playerid,COLOR_WHITE,"Wybranie jednej z trzech opcji powoduje ODJ�CIE jednej zmiany nicku.");
						SendClientMessage(playerid,COLOR_WHITE,"Gdy zdob�dziesz ju� odj�cie zmiany nie musisz od razu zmienia� nicku od razu. Mozesz to zrobi� kiedy chcesz.");
						SendClientMessage(playerid,COLOR_P@,"|________________________>>> Pomoc <<<________________________|");
					}
				}
		    }
		}
		if(dialogid == 68)
		{
		    if(response)
		    {			
				switch(listitem)
				{
				    case 0:
					{
						ShowPlayerDialogEx(playerid,61,DIALOG_STYLE_LIST,"Wykroczenia przeciwko porz�dkowi i bezpiecze�stwu publicznemu","Art. 1. U�ywanie wulgaryzm�w do: 5SD\nArt. 2. Namawianie do pope�niania przest�pstwa do: 10SD\nArt. 3. Ekshibicjonizm do 15SD\nArt. 4. Czynno�ci o char. seks. w miejscu pub.: do 20SD\nArt. 5. Nieuzasadnionie mierzenie z broni do ludzi: do 30SD + konfiskata broni\nArt. 6. Podszywanie si� pod s�u�by porz�dkowe: od 25SD do 50SD","Cofnij","");
					}
					case 1:
					{
						ShowPlayerDialogEx(playerid,62,DIALOG_STYLE_LIST,"Posiadanie nielegalnych przedmiot�w","Art. 7. Posiadanie narkotyk�w: do 40SD + konfiskata narkotyk�w\nArt. 8. Bro� bez licencji: 40SD + konfiskata broni\nAkt o BC Bro� ci�ka: od 30 do 50SD + konfiskata broni i licencji na bro�\nKK Posiadanie materia��w: +1WL + konfiskata materia��w","Cofnij","");
					}
					case 2:
					{
						ShowPlayerDialogEx(playerid,63,DIALOG_STYLE_LIST,"Wykroczenia przeciwko mieniu i zdrowiu","Art. 9. Udzia� w b�jce: do 10SD\nArt. 10. Kradzie� pojazdu mechanicznego: do 15SD\nArt. 11. Niszczenie cudzego mienia: do 25SD\nArt. 12. Pobicie: od 10 SD do 30 SD","Cofnij","");
					}
					case 3:
					{
						ShowPlayerDialogEx(playerid,64,DIALOG_STYLE_LIST,"Wykroczenia przeciwko godno�ci osobistej","Art. 13. Zniewa�enie os�b trzecich: do 5SD\nArt. 14. Gro�by karalne: do 10SD\nArt. 15. Obraza policjanta: do 15SD\nArt. 16. Hate crime: do 20SD","Cofnij","");
					}
					case 4:
					{
						ShowPlayerDialogEx(playerid,65,DIALOG_STYLE_LIST,"Utrudnianie dzia�a� policji","Art. 17. Brak dowodu osobistego lub licencji: 5SD za ka�dy dokument\nArt. 18. Nieumy�lne utrudnienie po�cigu policyjnego: do 20SD\nArt. 19. Bierny op�r (nie reagowanie na polecenia policjanta): do 35SD","Cofnij","");
					}
					case 5:
					{
						ShowPlayerDialogEx(playerid,66,DIALOG_STYLE_LIST,"Wykroczenia przeciwko bezpiecze�stwu w ruchu drogowym","Art. 20. Brak w��czonych �wiate� w nocy: 5SD\nArt. 21. Jazda po chodniku: do 10SD\nArt. 22. Post�j w miejscu do tego nieprzeznaczonym: do 10SD\nArt. 23. Spowodowanie innego zagro�enia w ruchu drogowym: do 20SD\nArt. 24. Spowodowanie wypadku: od 10SD do 20SD\nArt. 25. Prowadzenie pod wp�ywem �rodk�w odurzaj�cych: 50SD\n\t\t + konfiskata prawa jazdy","Cofnij","");
					}
					case 6:
					{
						ShowPlayerDialogEx(playerid,67,DIALOG_STYLE_LIST,"Niew�a�ciwe korzystanie z drogi","Art. 26. Nieuzasadnione, d�ugotrwa�e przebywanie pieszego na drodze: do 5SD\nArt. 27. Z�e parkowanie: od 5SD do 10SD\nArt. 28. L�dowanie w miejscu do tego nieprzeznaczonym: 15SD\n\tArt. 28 par. 1. Powoduj�ce zagro�enie w ruchu drogowym: \n\t\tod 15SD do 30SD + konfiskata licencji pilota\nArt. 29. Posiadanie przyciemnionych szyb: 40SD + demonta� szyb","Cofnij","");
					}
					case 7:
					{
						SendClientMessage(playerid,COLOR_P@,"|_________________________Pomoc prawna_________________________|");
						SendClientMessage(playerid,COLOR_WHITE,"Stawka Dzienna (SD) - 10%% nadchodz�cej wyp�atyStawka Dzienna (SD) - 10%% nadchodz�cej wyp�aty. ");
						SendClientMessage(playerid,COLOR_WHITE,"W niejszym zbiorze zamieszczono wszytkie przewinienia za kt�re prawo przewiduje wr�czenie mandatu.");
						SendClientMessage(playerid,COLOR_WHITE,"Kary zosta�y pogrupowane na VII dzia��w aby je zobaczy� nale�y klikn�c na wybrany dzia�.");
						SendClientMessage(playerid,COLOR_WHITE,"{3CB371}Wykr. przec. bezp. i porz. pub.{FFFFFF} - zawier� g��wnie kary za �amanie zasad kultury i dobrego zachowania");
						SendClientMessage(playerid,COLOR_WHITE,"{3CB371}Wykr. przec. bezp. w ruchu drogowym {FFFFFF}- znajdziecie tutaj kary za ci�kie przewinienia zwi�zane z kierowaniem pojazdami");
						SendClientMessage(playerid,COLOR_WHITE,"{3CB371}Niew�. korzystanie z drogi{FFFFFF} - tutaj znajduj� kary lekkie przewinienia w RD oraz niedozwolone modyfikacje pojazd�w.");
						SendClientMessage(playerid,COLOR_WHITE,"");
						SendClientMessage(playerid,COLOR_WHITE,"{3CB371}PODPOWIED�:{FFFFFF}  Zamiast podawa� pe�n� nazw� wykroczenia mo�esz poda� numer artyku�u");
						SendClientMessage(playerid,COLOR_WHITE,"Przyk�adowo: mo�esz w powodzie napisa�: {CD5C5C}'art. 26KW'{FFFFFF} ZAMIAST 'nieuzasadnione, d�ugotrwa�e przebywanie pieszego na drodze'");
						SendClientMessage(playerid,COLOR_P@,"|________________________>>> Kancelaria M&M <<<________________________|");
					}
				}
		    }
		}
		if(dialogid >= 61 && dialogid <= 67)
		{
		    if(response)
		    {
				ShowPlayerDialogEx(playerid,68,DIALOG_STYLE_LIST,"Kodeks wykrocze�: wybierz dzia�","Wykroczenia przeciwko porz�dkowi i bezpiecze�stwu publicznemu\nPosiadanie nielegalnych przedmiot�w\nWykroczenia przeciwko mieniu i zdrowiu\nWykroczenia przeciwko godno�ci osobistej\nUtrudnianie dzia�a� policji\nWykroczenia przeciwko bezpiecze�stwu w ruchu drogowym\nNiew�a�ciwe korzystanie z drogi\nInformacje","Wybierz","Wyjd�");
			}
		}
		if(dialogid == 323)//wybieralka wej�� SAN
		{
		    if(response)
		    {
		        switch(listitem)
				{
				    case 0:
					{
					    if(drukarnia == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, 1817.9636230469,-1314.1984863281,109.95202636719);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                sanwyjdz[playerid] = 1;
			                SetPlayerVirtualWorld(playerid, 0);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Drukarnia jest zamkni�ta i biura SAN s� zamkni�te");
			            }
					}
					case 1:
					{
					    if(studiovic == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, -1768.1467285156,1537.67578125,4767.3256835938);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                SetPlayerInterior(playerid, 13);
                   			sanwyjdz[playerid] = 1;
                   			SetPlayerVirtualWorld(playerid, 0);
		                }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Studio Victim jest zamkni�te");
			            }
					}
					case 2:
					{
					    if(studiog == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, 702.70550537109,-1382.9512939453,-93.994110107422);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                SetPlayerInterior(playerid, 13);
			                sanwyjdz[playerid] = 1;
			                SetPlayerVirtualWorld(playerid, 0);

		                }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Studio G��wne jest zamkni�te");
			            }
					}
					case 3:
					{
					    if(studion == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, -2928.0815429688,3636.6806640625,693.05780029297);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                SetPlayerInterior(playerid, 13);
			                sanwyjdz[playerid] = 1;
			                SetPlayerVirtualWorld(playerid, 0);
		                }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Studio Nagra� jest zamkni�te");
			            }
					}
					case 4:
					{
					    if(biurosan == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, 1833.8078613281,-1275.3975830078,109.40234375);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                sanwyjdz[playerid] = 1;
			                SetPlayerVirtualWorld(playerid, 0);
		                }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Gabinet dyrektora jest zamkni�ty");
			            }
  					}
					case 5:
					{
					    if(drukarnia == 0 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
					    {
						    SetPlayerPos(playerid, 736.890625,-1373.8778076172,30.01620674133);
							TogglePlayerControllable(playerid, 0);
                            Wchodzenie(playerid);
			                SetPlayerVirtualWorld(playerid, 31);
		                }
					}
				}
		    }
		}
		if(dialogid == 322)//zamykanie studi�w SAN
		{
		    if(response)
		    {
		        switch(listitem)
				{
				    case 0:
				    {
				        if(drukarnia == 0)
				        {
				            drukarnia = 1;
				            SendClientMessage(playerid, COLOR_NEWS, "Drukarnia zamkni�ta");
				        }
				        else
				        {
				            drukarnia = 0;
				            SendClientMessage(playerid, COLOR_NEWS, "Drukarnia otwarta");
				        }
				    }
				    case 1:
				    {
				        if(studiovic == 0)
				        {
				            studiovic = 1;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio Victim zamkni�te");
				        }
				        else
				        {
				            studiovic = 0;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio Victim otwarte");
				        }
				    }
				    case 2:
				    {
				        if(studiog == 0)
				        {
				            studiog = 1;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio g��wne zamkni�te");
				        }
				        else
				        {
				            studiog = 0;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio g��wne otwarte");
				        }
				    }
				    case 3:
				    {
				        if(studion == 0)
				        {
				            studion = 1;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio nagra� zamkni�te");
				        }
				        else
				        {
				            studion = 0;
				            SendClientMessage(playerid, COLOR_NEWS, "Studio nagra� otwarte");
				        }
				    }
				    case 4:
				    {
				        if(biurosan == 0)
				        {
				            biurosan = 1;
				            SendClientMessage(playerid, COLOR_NEWS, "Gabinet red. naczelnego zamkni�ty");
				        }
				        else
				        {
				            biurosan = 0;
				            SendClientMessage(playerid, COLOR_NEWS, "Gabinet red. naczelnego otwarty");
				        }
				    }
				}
			}
		}
		if(dialogid == 70)
		{
		    if(response)
		    {
		        ShowPlayerDialogEx(playerid, 71, DIALOG_STYLE_LIST, "Wybierz p�e�", "M�czyzna\nKobieta", "Dalej", "Wstecz");
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 71, DIALOG_STYLE_LIST, "Wybierz p�e�", "M�czyzna\nKobieta", "Dalej", "Wstecz");
		    }
		}
		if(dialogid == 71)
		{
		    if(response)
		    {
		        switch(listitem)
				{
				    case 0://men
				    {
				        ShowPlayerDialogEx(playerid, 72, DIALOG_STYLE_LIST, "Wybierz pochodzenie", "USA\nEuropa\nAzja", "Dalej", "Wstecz");//Ameryka P�nocna\nAmeryka �rodkowa\nAmeryka Po�udniowa\nAfryka\nAustralia\nEuropa Wschodnia\nEuropa Zachodnia\nAzja
	                    PlayerInfo[playerid][pSex] = 1;
	                    SendClientMessage(playerid, COLOR_NEWS, "Twoja posta� jest m�czyzn�.");
					}
				    case 1://baba
				    {
				        ShowPlayerDialogEx(playerid, 72, DIALOG_STYLE_LIST, "Wybierz pochodzenie", "USA\nEuropa\nAzja", "Dalej", "Wstecz");//Ameryka P�nocna\nAmeryka �rodkowa\nAmeryka Po�udniowa\nAfryka\nAustralia\nEuropa Wschodnia\nEuropa Zachodnia\nAzja
	                    PlayerInfo[playerid][pSex] = 2;
	                    SendClientMessage(playerid, COLOR_NEWS, "Twoja posta� jest kobiet�.");
					}
				}
			}
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Witaj na Mrucznik Role Play", "Witaj na serwerze Mrucznik Role Play\nJe�li jeste� tu nowy, to przygotowali�my dla ciebie 2 poradniki\nZa chwil� b�dziesz m�g� je obejrze�, lecz najpierw musisz opisa� posta� kt�r� b�dziesz gra�\n�yczymy mi�ej gry.", "Dalej", "");
		    }
		}
		if(dialogid == 72)
		{
		    if(response)
		    {
				switch(listitem)
				{
				    case 0://usa
				    {
				        PlayerInfo[playerid][pOrigin] = 1;
				        SendClientMessage(playerid, COLOR_NEWS, "Twoja posta� jest teraz obywatelem USA.");
				    }
				    case 1://europa
				    {
				        PlayerInfo[playerid][pOrigin] = 2;
				        SendClientMessage(playerid, COLOR_NEWS, "Twoja posta� jest teraz Europejskim imigrantem.");
				    }
				    case 2://azja
				    {
				        SendClientMessage(playerid, COLOR_NEWS, "Twoja posta� jest teraz Azjatyckim imigrantem.");
				        PlayerInfo[playerid][pOrigin] = 3;
				    }
				}
				ShowPlayerDialogEx(playerid, 73, DIALOG_STYLE_INPUT, "Wybierz wiek postaci", "Wpisz wiek swojej postaci (od 16 do 140 lat)", "Dalej", "Wstecz");
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, 71, DIALOG_STYLE_LIST, "P�e�", "M�czyzna\nKobieta", "Dalej", "Wstecz");
			}
		}
		if(dialogid == 73)
		{
		    if(response)
		    {
		        if(strlen(inputtext) > 1 && strlen(inputtext) < 4)
	            {
	                if(strval(inputtext) >= 16 && strval(inputtext) <= 140)
	                {
	                    PlayerInfo[playerid][pAge] = strval(inputtext);
						ShowPlayerDialogEx(playerid, 74, DIALOG_STYLE_MSGBOX, "Samouczek", "To ju� wszystkie dane jakie musia�e� poda�. Teraz musisz przej�� samouczek.\nAby go rozpocz�� wci�nij 'dalej'", "Dalej", "Wstecz");
	                }
	                else
	                {
	                    ShowPlayerDialogEx(playerid, 73, DIALOG_STYLE_INPUT, "Wiek postaci", "Wpisz wiek swojej postaci (od 16 do 140 lat)", "Dalej", "Wstecz");
	                }
	            }
	            else
	            {
	                ShowPlayerDialogEx(playerid, 73, DIALOG_STYLE_INPUT, "Wiek postaci", "Wpisz wiek swojej postaci (od 16 do 140 lat)", "Dalej", "Wstecz");
	            }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 72, DIALOG_STYLE_LIST, "Pochodzenie", "USA\nEuropa\nAzja", "Dalej", "Wstecz");//Ameryka P�nocna\nAmeryka �rodkowa\nAmeryka Po�udniowa\nAfryka\nAustralia\nEuropa Wschodnia\nEuropa Zachodnia\nAzja
		    }
		}
		if(dialogid == 74)
		{
            if(PlayerInfo[playerid][pLevel] > 1) return 1;
		    if(response)
		    {
		        gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
				TogglePlayerControllable(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				GUIExit[playerid] = 0;
		   		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na Mrucznik Role Play serwer.");
				SendClientMessage(playerid, COLOR_WHITE, "Nie jest to serwer Full-RP ale obowi�zuj� tu podstawowe zasady RP.");
				SendClientMessage(playerid, COLOR_WHITE, "Je�li ich nie znasz przybli�e ci najwa�niejsz� zasade.");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Obowi�zuje absolutny zakaz DeathMatch`u(DM)");
				SendClientMessage(playerid, COLOR_WHITE, "Co to jest DM? To zabijanie graczy na serwerze bez konkretnego powodu.");
				SendClientMessage(playerid, COLOR_WHITE, "Chodzi o to, �e w prawdziwym �yciu, nie zabija�by� wszystkich dooko�a.");
				SendClientMessage(playerid, COLOR_WHITE, "Wi�c je�li chcesz kogo� zabi�, musisz mie� wa�ny pow�d.");
				SendClientMessage(playerid, COLOR_WHITE, "OK, znasz ju� najwa�niejsz� zasad�, reszt� poznasz p�niej.");
	   			TutTime[playerid] = 1;
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 73, DIALOG_STYLE_INPUT, "Wiek postaci", "Wpisz wiek swojej postaci (od 16 do 140 lat)", "Dalej", "Wstecz");
		    }
		}
		if(dialogid == 123)
		{
		    if(response)
		    {
				if(DomOgladany[playerid] == 0)
				{
	                for(new i; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
				    {
						if(IsPlayerInRangeOfPoint(playerid, 3.0, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]))
						{
							if(Dom[i][hKupiony] == 0)
							{
	          					new deem = Dom[i][hDomNr];
						        SetPlayerPos(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
						        SetPlayerInterior(playerid, IntInfo[deem][Int]);
						        PlayerInfo[playerid][pDomWKJ] = i;
						        GameTextForPlayer(playerid, "~g~Masz 30 sekund", 5000, 1);
						        SendClientMessage(playerid,COLOR_PANICRED, "Masz 30 sekund do obejrzenia domu.");
						        SetTimerEx("OgladanieDOM", 30000,0,"d",playerid);
						        return 1;
							}
							else
							{
							    SendClientMessage(playerid,COLOR_GREY, "Ten dom jest kupiony, nie mo�esz go ogl�da�, skontaktuj si� z w�a�cicielem.");
							}
						}
					}
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY, "Musisz odczeka� 3 minuty aby jeszcze raz obejrze� dom.");
				}
		    }
		}
		if(dialogid == 85)//system dom�w
		{
		    if(response)
		    {
				ShowPlayerDialogEx(playerid, 86, DIALOG_STYLE_LIST, "Kupowanie domu - p�atno��", "Zap�a� got�wk�\nZap�a� przelewem z banku", "Wybierz", "Anuluj");
		    }
			else
			{
				SendClientMessage(playerid, COLOR_PANICRED, "(10) Anulowano.");
			}
		}
		if(dialogid == 86)//system dom�w
		{
		    if(response)
		    {
				switch(listitem)
		        {
		            case 0://Informacje o domu
		            {
		       		 	KupowanieDomu(playerid, IDDomu[playerid], 1);
					}
					case 1:
					{
						KupowanieDomu(playerid, IDDomu[playerid], 2);
					}
		   		}
			}
			else
			{
				SendClientMessage(playerid, COLOR_PANICRED, "(9) Anulowano.");
			}
		}
		if(dialogid == 87)//system dom�w
		{
		   	if(response)
		    {
		        ZlomowanieDomu(playerid, PlayerInfo[playerid][pDom]);
		    }
		    else
		    {
		        SendClientMessage(playerid, COLOR_NEWS, "Anulowa�e� z�omowanie");
		    }
		}
		if(dialogid == 810)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        switch(listitem)
		        {
		            case 0://Informacje o domu
		            {
		                new string2[512];
						new wynajem[20];
						if(Dom[dom][hWynajem] == 0)
						{
	                        wynajem = "nie";
						}
						else
						{
	                        wynajem = "tak";
						}
						new drzwi[30];
						if(Dom[dom][hZamek] == 0)
						{
	                        drzwi = "Zamkni�te";
						}
						else
						{
	                        drzwi = "Otwarte";
						}
		                format(string2, sizeof(string2), "ID domu:\t%d\nID wn�trza:\t%d\nCena domu:\t%d$\nWynajem:\t%s\nIlosc pokoi:\t%d\nPokoi wynajmowanych\t%d\nCena wynajmu:\t%d$\nO�wietlenie:\t%d\nDrzwi:\t%s", dom, Dom[dom][hDomNr], Dom[dom][hCena], wynajem, Dom[dom][hPokoje], Dom[dom][hPW], Dom[dom][hCenaWynajmu], Dom[dom][hSwiatlo], drzwi);
		                ShowPlayerDialogEx(playerid, 811, DIALOG_STYLE_MSGBOX, "G��wne informacje domu", string2, "Wr��", "Wyjd�");
		            }
		            case 1://Zamykanie domu
		            {
		                if(Dom[dom][hZamek] == 1 && AntySpam[playerid] == 1)
		                {
							ShowPlayerDialogEx(playerid, 811, DIALOG_STYLE_MSGBOX, "Zamykanie domu", "Odczekaj 10 sekund zanim zamkniesz dom ponownie.", "Wr��", "Wyjd�");
						}
						else if(Dom[dom][hZamek] == 1)
		                {
		                    SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
	    					AntySpam[playerid] = 1;
							Dom[dom][hZamek] = 0;
							ShowPlayerDialogEx(playerid, 811, DIALOG_STYLE_MSGBOX, "Zamykanie domu", "Dom zosta� zamkni�ty pomy�lnie", "Wr��", "Wyjd�");
						}
						else if(Dom[dom][hZamek] == 0)
						{
						    Dom[dom][hZamek] = 1;
		                	ShowPlayerDialogEx(playerid, 811, DIALOG_STYLE_MSGBOX, "Otwieranie domu", "Dom zosta� otworzony pomy�lnie", "Wr��", "Wyjd�");
						}
					}
		            case 2://Panel wynajmu
		            {
	                    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		            }
		            case 3://Panel dodatk�w
		            {
		                ShowPlayerDialogEx(playerid, 1230, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
		            }
	             	case 4://O�wietlenie
		            {
		                ShowPlayerDialogEx(playerid, 812, DIALOG_STYLE_LIST, "Wybierz o�wietlenie", "Zachodz�ce s�o�ce (21:00)\nMrok (0:00)\nDzie� (12:00)\nW�asny tryb (godzina)", "Wybierz", "Wr��");
		            }
		            case 5://Spawn
		            {
						ShowSpawnChangeDialog(playerid);
		            }
		            case 6://Kupowanie dodatk�w
		            {
						KupowanieDodatkow(playerid, dom);
		            }
		            case 7://Pomoc domu
		            {
		                ShowPlayerDialogEx(playerid, 1230, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
		            }
		        }
		    }
		}
		if(dialogid == 1230)
		{
		    if(response || !response)
		    {
		        if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
		    	{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
		    }
		}
		if(dialogid == 811)
		{
		    if(response)
		    {
		        if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
		    	{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
		    }
		}
        if(dialogid == D_INFO)
        {
            return 1;
        }
		if(dialogid == 812)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:// Jasne ze swiat�ami (21:00)
		            {
		                Dom[PlayerInfo[playerid][pDom]][hSwiatlo] = 21;
		                ZapiszDom(PlayerInfo[playerid][pDom]);
		                SendClientMessage(playerid, COLOR_NEWS, "O�wietlenie w domu zosta�o zmienione");
		                if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[PlayerInfo[playerid][pDom]][hInt_X], Dom[PlayerInfo[playerid][pDom]][hInt_Y], Dom[PlayerInfo[playerid][pDom]][hInt_Z]))
		                {
		                	ShowPlayerDialogEx(playerid, 812, DIALOG_STYLE_LIST, "Wybierz o�wietlenie", "Zachodz�ce s�o�ce (21:00)\nMrok (0:00)\nDzie� (12:00)\nW�asny tryb (godzina)", "Wybierz", "Wr��");
		                	SetPlayerTime(playerid, 21, 0);
		                }
		                else
		                {
		                    if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
						    {
								ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
							else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
							{
							    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
		                }
		            }
		            case 1:// �wiat�a w��czone (0:00)
		            {
		                Dom[PlayerInfo[playerid][pDom]][hSwiatlo] = 0;
		                ZapiszDom(PlayerInfo[playerid][pDom]);
	                    SendClientMessage(playerid, COLOR_NEWS, "O�wietlenie w domu zosta�o zmienione");
		                if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[PlayerInfo[playerid][pDom]][hInt_X], Dom[PlayerInfo[playerid][pDom]][hInt_Y], Dom[PlayerInfo[playerid][pDom]][hInt_Z]))
		                {
		                	ShowPlayerDialogEx(playerid, 812, DIALOG_STYLE_LIST, "Wybierz o�wietlenie", "Zachodz�ce s�o�ce (21:00)\nMrok (0:00)\nDzie� (12:00)\nW�asny tryb (godzina)", "Wybierz", "Wr��");
		                	SetPlayerTime(playerid, 0, 0);
		                }
		                else
		                {
		                    if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
						    {
								ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
							else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
							{
							    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
		                }
		            }
		            case 2:// Wy��czone �wiat�o, jasno (12:00)
		            {
		                Dom[PlayerInfo[playerid][pDom]][hSwiatlo] = 12;
		                ZapiszDom(PlayerInfo[playerid][pDom]);
		                SendClientMessage(playerid, COLOR_NEWS, "O�wietlenie w domu zosta�o zmienione");
		                if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[PlayerInfo[playerid][pDom]][hInt_X], Dom[PlayerInfo[playerid][pDom]][hInt_Y], Dom[PlayerInfo[playerid][pDom]][hInt_Z]))
		                {
		                	ShowPlayerDialogEx(playerid, 812, DIALOG_STYLE_LIST, "Wybierz o�wietlenie", "Zachodz�ce s�o�ce (21:00)\nMrok (0:00)\nDzie� (12:00)\nW�asny tryb (godzina)", "Wybierz", "Wr��");
		                	SetPlayerTime(playerid, 12, 0);
		                }
		                else
		                {
		                    if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
						    {
								ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
							else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
							{
							    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
							}
		                }
	             	}
		            case 3: // W�asna godzina
		            {
						ShowPlayerDialogEx(playerid, 813, DIALOG_STYLE_INPUT, "O�wietlenie domu", "Wpisz na godzin� ma si� zmienia� czas po wejsciu do domu.\nGodziny od 7-19 s� jasne a od 20 do 6 ciemne ze �wiat�ami", "Wpisz", "Wr��");
		            }
		        }
		    }
		    if(!response)
		    {
		        if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
		    	{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
		    }
		}
		if(dialogid == 813)
		{
		    if(response)
		    {
		        new godz = strval(inputtext);
		        new string[256];
		        if(godz >= 0 && godz <= 24 || PlayerInfo[playerid][pAdmin] >= 100)
		        {
					format(string, sizeof(string), "O�wietlenie domu zmienione na %d godzin�", godz);
					SendClientMessage(playerid, COLOR_NEWS, string);
					Dom[PlayerInfo[playerid][pDom]][hSwiatlo] = godz;
		   			ZapiszDom(PlayerInfo[playerid][pDom]);
		      		if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[PlayerInfo[playerid][pDom]][hInt_X], Dom[PlayerInfo[playerid][pDom]][hInt_Y], Dom[PlayerInfo[playerid][pDom]][hInt_Z]))
		        	{
		        		ShowPlayerDialogEx(playerid, 813, DIALOG_STYLE_INPUT, "O�wietlenie domu", "Wpisz na godzin� ma si� zmienia� czas po wejsciu do domu.\nGodziny od 7-19 s� jasne a od 20 do 6 ciemne ze �wiat�ami", "Wpisz", "Wr��");
		         		SetPlayerTime(playerid, godz, 0);
		          	}
		           	else
		            {
		            	if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
				    	{
							ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
						{
		    				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
		           	}
				}
				else
				{
	   				ShowPlayerDialogEx(playerid, 813, DIALOG_STYLE_INPUT, "O�wietlenie domu", "Wpisz na godzin� ma si� zmienia� czas po wejsciu do domu.\nGodziny od 7-19 s� jasne a od 20 do 6 ciemne ze �wiat�ami", "Wpisz", "Wr��");
	     			SendClientMessage(playerid, COLOR_NEWS, "Godzina o�wietlenia od 0 do 24");
	      		}
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 812, DIALOG_STYLE_LIST, "Wybierz o�wietlenie", "Zachodz�ce s�o�ce (21:00)\nMrok (0:00)\nDzie� (12:00)\nW�asny tryb (godzina)", "Wybierz", "Wr��");
		    }
		}
		if(dialogid == 814)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:// Normalny spawn
		            {
		                PlayerInfo[playerid][pSpawn] = 0;
		                SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� na swoim normalnym spawnie");

						if(GetPVarInt(playerid, "spawnchange")) 
						{
							DeletePVar(playerid, "spawnchange");
							return 1;
						}
		                if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	 					{
							ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
						{
						    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
		            }
		            case 1:// Spawn przed domem
		            {
		                PlayerInfo[playerid][pSpawn] = 1;
		                SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� przed domem");

						if(GetPVarInt(playerid, "spawnchange")) 
						{
							DeletePVar(playerid, "spawnchange");
							return 1;
						}
		                if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
		    			{
							ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
						{
		    				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
		            }
		            case 2:// Spawn w domu
		            {
	                    PlayerInfo[playerid][pSpawn] = 2;
	                    SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� wewn�trz domu");

						if(GetPVarInt(playerid, "spawnchange")) 
						{
							DeletePVar(playerid, "spawnchange");
							return 1;
						}
	                    if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	 					{
							ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
						{
		    				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
		            }
		            case 3:// Spawn w Vice City
		            {
						if(!IsPlayerAtViceCity(playerid))
						{
							MruMessageFail(playerid, "Spawn w Vice City mo�esz ustawi� tylko wtedy, gdy znajdujesz si� w tym mie�cie.");
							ShowSpawnChangeDialog(playerid);
							return 1;
						}

	                    PlayerInfo[playerid][pSpawn] = 3;
	                    SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� w Vice City");

						if(GetPVarInt(playerid, "spawnchange")) 
						{
							DeletePVar(playerid, "spawnchange");
							return 1;
						}
	                    if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	 					{
							ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
						{
		    				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
						}
		            }
				}
			}
			if(!response)
			{
				if(GetPVarInt(playerid, "spawnchange")) 
				{
					DeletePVar(playerid, "spawnchange");
					return 1;
				}
				if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	   			{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
			}
		}
		if(dialogid == 815)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        new string[256];
		        switch(listitem)
		        {
		            case 0:// Informacje og�lne
		            {
	                    new wynajem[50];
						if(Dom[dom][hWynajem] == 0)
						{
	                        wynajem = "nie wynajmuj";
						}
						else if(Dom[dom][hWynajem] == 1)
						{
	                        wynajem = "dla wszystkich";
						}
						else if(Dom[dom][hWynajem] == 2)
						{
	                        wynajem = "dla wybranych os�b";
						}
						else if(Dom[dom][hWynajem] == 3)
						{
						    if(Dom[dom][hWW] == 1)
						    {
	                        	wynajem = "z warunkiem (frakcja)";
	                        }
	                        else if(Dom[dom][hWW] == 2)
	                        {
	                            wynajem = "z warunkiem (organizacja)";
	                        }
	                        else if(Dom[dom][hWW] == 3)
	                        {
	                            wynajem = "z warunkiem (level)";
	                        }
	                        else if(Dom[dom][hWW] == 4)
	                        {
	                            wynajem = "z warunkiem (konto premium)";
	                        }
						}
		                format(string, sizeof(string), "Wynajem:\t%s\nCena wynajmu:\t%d$\nIlo�� pokoi:\t%d\nPokoje wynajmowane:\t%d\nPokoi do wynaj�cia:\t%d", wynajem, Dom[dom][hCenaWynajmu], Dom[dom][hPokoje], Dom[dom][hPW], Dom[dom][hPDW]);
		                ShowPlayerDialogEx(playerid, 816, DIALOG_STYLE_MSGBOX, "Og�lne informacje o wynajmie", string, "Wr��", "Wyjd�");
		            }
		            case 1:// Zarz�dzaj lokatorami
		            {
		                format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		                ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		            }
		            case 2:// Tryb wynajmu
		            {
		                ShowPlayerDialogEx(playerid, 818, DIALOG_STYLE_LIST, "Tryb wynajmu", "Brak wynajmu\nDla wszystkich\nWybrane osoby\nDla frakcji/organizacji/KP", "Wybierz", "Wr��");
		            }
		            case 3:// Cena wynajmu
		            {
		                ShowPlayerDialogEx(playerid, 824, DIALOG_STYLE_INPUT, "Cena wynajmu", "Wpisz, za ile grcze mog� wynaj�� u ciebie dom.\n(Cena do ustalenia tylko w przypadku wynajmowania dla wszystkich i wynajmu z warunkiem)", "Wybierz", "Wr��");
		            }
		            case 4:// Wiadomo�� dla wynajmuj�cych
		            {
		                ShowPlayerDialogEx(playerid, 825, DIALOG_STYLE_INPUT, "Wiadomo�� dla lokator�w", "Tu mo�esz ustali� co b�dzie si� wy�wietla� osob� kt�re wynajmuj� tw�j dom.", "Wybierz", "Wr��");
		            }
		            case 5:// Uprawnienia lokator�w
		            {
		                new taknie_z[10];
		                new taknie_d[10];
		                if(Dom[dom][hUL_Z] == 1)
		                {
		                    taknie_z = "tak";
		                }
		                else
		                {
		                    taknie_z = "nie";
		                }
		                if(Dom[dom][hUL_D] == 1)
		                {
		                    taknie_d = "tak";
		                }
		                else
		                {
		                    taknie_d = "nie";
		                }
		                format(string, sizeof(string), "Zamykanie i otwieranie drzwi:\t %s\nKorzystanie z dodatk�w:\t %s", taknie_z, taknie_d);
	                    ShowPlayerDialogEx(playerid, 8800, DIALOG_STYLE_LIST, "Uprawnienia lokator�w", string, "Zmie�", "Wr��");
		            }
		            /*case 6:// Informacja o wynajmie
		            {

		            }*/
		        }
		    }
		    if(!response)
			{
				if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	   			{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
			}
		}
		if(dialogid == 816)
		{
		    if(response)
			{
	            if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
	   			{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
			}
		}
		if(dialogid == 817)
		{
		    if(response)
			{
			    new dom = PlayerInfo[playerid][pDom];
			    new string[256];
			    Dom[dom][hPW] --;
			    Dom[dom][hPDW] ++;
			    switch(listitem)
			    {
					case 0:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL1]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL1] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 1:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL2]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL2] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 2:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL3]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL3] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 3:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL4]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL4] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 4:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL5]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL5] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 5:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL6]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL6] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 6:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL7]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL7] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 7:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL8]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL8] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 8:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL9]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL9] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
					case 9:
					{
					    format(string, sizeof(string), "Gracz %d zosta� wyeksmitowany", Dom[dom][hL10]);
					    SendClientMessage(playerid, 0xFFC0CB, string);
					    new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL10] = GeT;
					    format(string, sizeof(string), "Lokator 1:\t%s\nLokator 2:\t%s\nLokator 3:\t%s\nLokator 4:\t%s\nLokator 5:\t%s\nLokator 6:\t%s\nLokator 7:\t%s\nLokator 8:\t%s\nLokator 9:\t%s\nLokator 10:\t%s\n", Dom[dom][hL1], Dom[dom][hL2], Dom[dom][hL3], Dom[dom][hL4], Dom[dom][hL5], Dom[dom][hL6], Dom[dom][hL7], Dom[dom][hL8], Dom[dom][hL9], Dom[dom][hL10]);
		       			ShowPlayerDialogEx(playerid, 817, DIALOG_STYLE_LIST, "Zarz�dzanie lokatorami", string, "Eksmituj", "Wr��");
		       			ZapiszDom(dom);
					}
				}
			}
		    if(!response)
			{
	  			ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			}
		}
		if(dialogid == 818)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        switch(listitem)
		        {
		            case 0:// Brak wynajmu
		            {
		                new GeT[MAX_PLAYER_NAME];
	           			format(GeT, sizeof(GeT), "Brak");
						Dom[dom][hL1] = GeT;
						Dom[dom][hL2] = GeT;
						Dom[dom][hL3] = GeT;
						Dom[dom][hL4] = GeT;
						Dom[dom][hL5] = GeT;
						Dom[dom][hL6] = GeT;
						Dom[dom][hL7] = GeT;
						Dom[dom][hL8] = GeT;
						Dom[dom][hL9] = GeT;
						Dom[dom][hL10] = GeT;
					    SendClientMessage(playerid, COLOR_P@, "Nie wynajmujesz domu. Wszyscy wynajmuj�cy zostali wyeksmitowani.");
					    Dom[dom][hWynajem] = 0;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 818, DIALOG_STYLE_LIST, "Tryb wynajmu", "Brak wynajmu\nDla wszystkich\nWybrane osoby\nDla frakcji/organizacji/KP", "Wybierz", "Wr��");
		            }
		            case 1:// Wynajem dla ka�dego
		            {
	                    SendClientMessage(playerid, COLOR_P@, "Teraz ka�dy mo�e wynaj�� tw�j dom po wpisaniu komendy /wynajmuj pod drzwiami.");
					    Dom[dom][hWynajem] = 1;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 818, DIALOG_STYLE_LIST, "Tryb wynajmu", "Brak wynajmu\nDla wszystkich\nWybrane osoby\nDla frakcji/organizacji/KP", "Wybierz", "Wr��");
		            }
		            case 2:// Lokator�w ustala w�a�ciciel
		            {
					    SendClientMessage(playerid, COLOR_P@, "Teraz ty ustalasz kto ma wynajmowa� pok�j komend� /dajpokoj [id].");
					    Dom[dom][hWynajem] = 2;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 818, DIALOG_STYLE_LIST, "Tryb wynajmu", "Brak wynajmu\nDla wszystkich\nWybrane osoby\nDla frakcji/organizacji/KP", "Wybierz", "Wr��");
		            }
		            case 3:// Wynajem tylko je�eli kto� spe�nia dany warunek
		            {
	                    ShowPlayerDialogEx(playerid, 819, DIALOG_STYLE_LIST, "Warunek wynajmu", "Odpowiednia frakcja\nOdpowiednia organizacja\nOdpowiedni level\nLevel Konta Premium", "Wybierz", "Wyjd�");
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 819)
		{

		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:// Warunek wynajmu: odpowiednia frakcja
		            {
		                ShowPlayerDialogEx(playerid, 820, DIALOG_STYLE_LIST, "Warunek wynajmu - frakcja", "Policja\nFBI\nWojsko\nSAM-ERS\nLa Cosa Nostra\nYakuza\nHitman Agency\nSA News\nTaxi Corporation\nUrz�dnicy\nGrove Street\nPurpz\nLatin Kings", "Wybierz", "Wr��");
		            }
		            case 1:// Warunek wynajmu: odpowiednia organizacja
		            {
		                ShowPlayerDialogEx(playerid, 821, DIALOG_STYLE_LIST, "Warunek wynajmu - organizacja", "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49", "Wybierz", "Wr��");
		            }
		            case 2:// Warunek wynajmu: odpowiednio wysoki level
		            {
		                ShowPlayerDialogEx(playerid, 822, DIALOG_STYLE_INPUT, "Warunek wynajmu - level", "Wpisz od jakiego levelu b�dzie mo�na wynaj�� tw�j dom", "Wybierz", "Wr��");
		            }
		            case 3:// Warunek wynajmu: odpowiednio wysoki level konta premium
		            {
		                ShowPlayerDialogEx(playerid, 823, DIALOG_STYLE_INPUT, "Warunek wynajmu - KP", "Wpisz od jakiego levelu Konta Premium b�dzie mo�na wynaj�� tw�j dom", "Wybierz", "Wr��");
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 818, DIALOG_STYLE_LIST, "Tryb wynajmu", "Brak wynajmu\nDla wszystkich\nWybrane osoby\nDla frakcji/organizacji/KP", "Wybierz", "Wr��");
		    }
		}
		if(dialogid == 820)//warunek - frakcja
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        switch(listitem)
		        {
			        case 0:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji LSPD b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 1;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 1:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji FBI b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 2;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 2:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji NG b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 3;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 3:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji SAM-ERS b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 4;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 4:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji LCN b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 5;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 5:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji YKZ b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 6;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 6:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji HA b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 8;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 7:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji SAN b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 9;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 8:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji Taxi b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 10;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 9:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji DMV b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 11;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 10:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji Grove b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 12;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 11:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji Purpz b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 13;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
			        case 12:
			        {
			            SendClientMessage(playerid, COLOR_P@, "Teraz tylko ludzie z frakcji Latin Kings b�d� mogli wynajmowa� u ciebie dom.");
			    		Dom[dom][hWynajem] = 3;
			    		Dom[dom][hWW] = 1;
			    		Dom[dom][hTWW] = 14;
					    ZapiszDom(dom);
					    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
			        }
				}
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 819, DIALOG_STYLE_LIST, "Warunek wynajmu", "Odpowiednia frakcja\nOdpowiednia organizacja\nOdpowiedni level\nLevel Konta Premium", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 821)//warunek - organizacja
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
				SendClientMessage(playerid, COLOR_P@, sprintf("Teraz tylko ludzie z organizacji %d b�d� mogli wynajmowa� u ciebie dom.", listitem));
				Dom[dom][hWynajem] = 3;
				Dom[dom][hWW] = 2;
				Dom[dom][hTWW] = listitem;
				ZapiszDom(dom);
				ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");

			}
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 819, DIALOG_STYLE_LIST, "Warunek wynajmu", "Odpowiednia frakcja\nOdpowiednia organizacja\nOdpowiedni level\nLevel Konta Premium", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 822)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
				if(strval(inputtext) >= 1 && strval(inputtext) <= 100)
				{
				    new string[256];
				    format(string, sizeof(string), "Teraz tylko ludzie z levelem wi�kszym lub r�wnym %d b�d� mogli wynajmowa� u ciebie dom.", strval(inputtext));
				    SendClientMessage(playerid, COLOR_P@, string);
		    		Dom[dom][hWynajem] = 3;
		    		Dom[dom][hWW] = 3;
		    		Dom[dom][hTWW] = strval(inputtext);
				    ZapiszDom(dom);
				    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_P@, "Level od 1 do 100.");
				    ShowPlayerDialogEx(playerid, 822, DIALOG_STYLE_INPUT, "Warunek wynajmu - level", "Wpisz od jakiego levelu b�dzie mo�na wynaj�� tw�j dom", "Wybierz", "Wr��");
				}
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 819, DIALOG_STYLE_LIST, "Warunek wynajmu", "Odpowiednia frakcja\nOdpowiednia organizacja\nOdpowiedni level\nLevel Konta Premium", "Wybierz", "Wyjd�");
		    }
		}
	    if(dialogid == 823)
		{
		    if(response)
		    {
		        new string[256];
		        new dom = PlayerInfo[playerid][pDom];
				if(strval(inputtext) == 1 || strval(inputtext) == 2 || strval(inputtext) == 3)
				{
				    format(string, sizeof(string), "Teraz tylko ludzie z Kontem Premium wi�kszym lub r�wnym %d b�d� mogli wynajmowa� u ciebie dom.", strval(inputtext));
				    SendClientMessage(playerid, COLOR_P@, string);
		    		Dom[dom][hWynajem] = 3;
		    		Dom[dom][hWW] = 4;
		    		Dom[dom][hTWW] = strval(inputtext);
				    ZapiszDom(dom);
				    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_P@, "Level KP od 1 do 3.");
				    ShowPlayerDialogEx(playerid, 823, DIALOG_STYLE_INPUT, "Warunek wynajmu - KP", "Wpisz od jakiego levelu Konta Premium b�dzie mo�na wynaj�� tw�j dom", "Wybierz", "Wr��");
				}
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 819, DIALOG_STYLE_LIST, "Warunek wynajmu", "Odpowiednia frakcja\nOdpowiednia organizacja\nOdpowiedni level\nLevel Konta Premium", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 824)
		{
		    new string[256];
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
				if(strval(inputtext) >= (2500*IntInfo[Dom[dom][hDomNr]][Kategoria]) && strval(inputtext) <= 1000000 && strval(inputtext) != 0)
				{
		    		Dom[dom][hCenaWynajmu] = strval(inputtext);
				    ZapiszDom(dom);
				    format(string, sizeof(string), "Cena wynajmu ustalona na %d$", strval(inputtext));
				    SendClientMessage(playerid, COLOR_P@, string);
				    ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
				}
				else
				{
				    format(string, sizeof(string), "Cena wynajmu od %d$ do 1000000$", (2500*IntInfo[Dom[dom][hDomNr]][Kategoria]));
				    SendClientMessage(playerid, COLOR_P@, string);
				    ShowPlayerDialogEx(playerid, 824, DIALOG_STYLE_INPUT, "Cena wynajmu", "Wpisz, za ile grcze mog� wynaj�� u ciebie dom.\n(Cena do ustalenia tylko w przypadku wynajmowania dla wszystkich i wynajmu z warunkiem)", "Wybierz", "Wr��");
				}
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 825)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        if(strlen(inputtext) >= 1 || strlen(inputtext) <= 128)
		        {
		            new message[128];
	                format(message, sizeof(message), "%s", inputtext);
	                mysql_real_escape_string(message, message);
		            Dom[dom][hKomunikatWynajmu] = message;
				    ZapiszDom(dom);
				    SendClientMessage(playerid, COLOR_P@, "Komunikat wynajmu to teraz:");
				    SendClientMessage(playerid, COLOR_WHITE, inputtext);
		            ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		        }
		        else
		        {
		            SendClientMessage(playerid, COLOR_P@, "Wiadomo�� mo�e zawiera� od 1 do 1000 znak�w.");
		            ShowPlayerDialogEx(playerid, 825, DIALOG_STYLE_LIST, "Wiadomo�� dla lokator�w", "Tu mo�esz ustali� co b�dzie si� wy�wietla� osob� kt�re wynajmuj� tw�j dom.", "Wybierz", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 826)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        new string[512];
		        switch(listitem)
		        {
		            case 0://Sejf
					{
					    new k;
					    new m;
					    new d;
					    if(Dom[dom][hSejf] < 10)
					    {
					        k = 100000*(Dom[dom][hSejf]+1);
					        m = 5000*(Dom[dom][hSejf]+1);
					        d = 2*(Dom[dom][hSejf]+1);
					    	format(string, sizeof(string), "Sejf - pozwala przechowywa� got�wk�, materia�y, marihuan� i heroin� w domu.\nKa�dy nast�pny poziom sejfu pozwala przechowywa� o 100 000$, 10 000 materia��w i 10 drag�w obu typ�w wi�cej\nKiedy sejf osi�gnie 10 poziom ka�dy nast�pny b�dzie mia� mo�liwo�� przechowywania o 1 000 000$, 100 000 materia��w i 20 drag�w wi�cej\n\nAby kupi� ten sejf musisz posiada� %d$, %d materia��w, %dg Marihuany i %dg Heroiny", k, m, d, d);
						}
						else
						{
						    k = 1000000*(Dom[dom][hSejf]+1);
					        m = 5000*(Dom[dom][hSejf]+1);
					        d = 2*(Dom[dom][hSejf]+1);
							format(string, sizeof(string), "Sejf - pozwala przechowywa� got�wk�, materia�y, marihuan� i heroin� w domu.\nKa�dy nast�pny poziom sejfu pozwala przechowywa� o 100 000$, 10 000 materia��w i 10 drag�w obu typ�w wi�cej\nKiedy sejf osi�gnie 10 poziom ka�dy nast�pny b�dzie mia� mo�liwo�� przechowywania o 1 000 000$, 100 000 materia��w i 20 drag�w wi�cej\n\nAby kupi� ten sejf musisz posiada� %d$, %d materia��w, %dg Marihuany i %dg Heroiny", k, m, d, d);
						}
						ShowPlayerDialogEx(playerid, 827, DIALOG_STYLE_MSGBOX, "Kupowanie sejfu", string, "KUP!", "Cofnij");
					}
					case 1://Zbrojownia
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					    /*if(Dom[dom][hZbrojownia] == 0)
					    {
					    	ShowPlayerDialogEx(playerid, 8281, DIALOG_STYLE_MSGBOX, "Kupowanie Zbrojowni", "Zbrojownia - pozwala przechowywa� bro� w domu.\nNa pocz�tku kupujesz pomnieszczenie zbrojowni, potem mo�esz przystosowa� j� do przechowywania r�nych rodzaj�w broni, na co b�dziesz musia� wyda� dodakowe pieni�dze.\nKoszt pomieszczenia zbrojowni to 1 000 000$, wymagane jest posiadanie licencji na bro�. Po kupieniu b�dziesz m�g� przystosowywa� j� do swoich potrzeb.", "KUP!", "Cofnij");
						}
						else if(Dom[dom][hZbrojownia] == 1)
						{
						    DialogZbrojowni(playerid);
						}*/
					}
					case 2://Gara�
					{
                        ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest obecnie przebudowywana.\nPrzepraszamy za utrudnienia.", "Wr��", "Wr��");
					    //ShowPlayerDialogEx(playerid, 829, DIALOG_STYLE_MSGBOX, "Kupowanie gara�u", "Gara� - dodaj� nowy slot dzi�ki kt�remu mo�esz posiada� o 1 auto wi�cej.\nAuto ze slotu gara�owego mo�esz prakowa� tylko 20 metr�w od domu, ka�dy nast�pny poziom kosztuje 500 000$ i zwi�ksza odleg�o�� parkowania o 20 metr�w.\nAby go kupi� potrzebujesz turbow�zek.", "KUP!", "Cofnij");
					}
					case 3://Apteczka
					{
					    if(Dom[dom][hApteczka] == 0)
					    {
	       					format(string, sizeof(string), "Apteczka - pozwala leczy� si� w domu (przywraca 100 procent HP).\n\nAby j� kupi� potrzebujesz 100 000$, piwo, 10g heroiny i 10g marihuany.");
	                        ShowPlayerDialogEx(playerid, 830, DIALOG_STYLE_MSGBOX, "Kupowanie Apteczki", string, "KUP!", "Cofnij");
						}
						else
						{
						    SendClientMessage(playerid, COLOR_P@, "Posiadasz maksymalny level apteczki (1)");
		        			KupowanieDodatkow(playerid, dom);
						}
					}
					case 4://Pancerz
					{
					    if(Dom[dom][hKami] < 9)
					    {
					        format(string, sizeof(string), "Pancerz - pozwala on za�o�y� kamizelk� kuloodporn� w domu.\nPierwszy poziom daje 10 procent pancerza a ka�dy nast�pny dodaje o 10 procent wi�cej.\n\nAby go kupi� potrzebujesz %d$, wino Komandos, Apteczk�, 50 procent pancerza i M4.", 100000*(Dom[dom][hKami]+1));
	                        ShowPlayerDialogEx(playerid, 830, DIALOG_STYLE_MSGBOX, "Kupowanie Pancerza", string, "KUP!", "Cofnij");
						}
						else
						{
						    SendClientMessage(playerid, COLOR_P@, "Posiadasz maksymalny level kamizelki (9)");
		        			KupowanieDodatkow(playerid, dom);
						}
					}
					case 5://L�dowisko
					{
					    ShowPlayerDialogEx(playerid, 832, DIALOG_STYLE_MSGBOX, "Kupowanie l�dowiska", "L�dowisko - pozwala parkowa� pojazd lataj�cy nie tylko na lotnisku ale tak�e przy swoim domu.\nPrzy 1 poziomie l�dowiska, kt�ry kosztuje 10 mln, pojazd lataj�cy mo�esz parkowa� 20 metr�w od domu. Ka�dy nast�pny poziom kosztuje 1 000 000$ i zwi�ksza t� warto�� o kolejne 20 metr�w.", "KUP!", "Cofnij");
					}
					case 6://Alarm
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 7://Zamek
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 8://Komputer
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 9://Sprz�t RTV
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 10://Zestaw hazardzisty
					{
					    /*if(Dom[dom][hHazard] < 3)
					    {
					        //format(string, sizeof(string), "Zestaw hazardzisty - pozwala gra� w r�ne gry hazardowe niewychodz�c z domu.\nPierwszy poziom daje mo�liwo�� grania w ko�o fortuny, drugi w ruletk� a trzeci w oczko. Zu�ywa on OMGXXXXWTF produkt�w domu.\n\nAby go kupi� potrzebujesz %d$", 100000*(Dom[dom][hKami]+1));
	                        //ShowPlayerDialogEx(playerid, 830, DIALOG_STYLE_MSGBOX, "Kupowanie Zestawu Hazardzisty", string, "KUP!", "Cofnij");
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_P@, "Posiadasz wszystkie dodatki hazardowe (ko�o fortuny, ruletka i blackjack)");
		        			KupowanieDodatkow(playerid, dom);
					    }*/
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 11://Szafa
					{
					    /*if(Dom[dom][hSzafa] == 0)
					    {
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_P@, "Posiadasz maksymalny level szafy (1)");
		        			KupowanieDodatkow(playerid, dom);
					    }*/
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
					case 12://Tajemnicze dodatki
					{
					    ShowPlayerDialogEx(playerid, 1231, DIALOG_STYLE_MSGBOX, "Zablokowane", "Ta opcja jest na razie w fazie produkcji", "Wr��", "Wr��");
					}
		        }
		    }
		    if(!response)
		    {
		        if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
		    	{
					ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
				}
		    }
		}
		if(dialogid == 1231)
		{
		    KupowanieDodatkow(playerid, PlayerInfo[playerid][pDom]);
		}
		if(dialogid == 827)//kupowanie sejfu
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
		        new str3[256];
		    	if(Dom[dom][hSejf] < 10)
			    {
			        if(PlayerInfo[playerid][pMats] >= 5000*(Dom[dom][hSejf]+1) && PlayerInfo[playerid][pDrugs] >= 2*(Dom[dom][hSejf]+1) /*&& PlayerInfo[playerid][pZiolo] >= 2*(Dom[dom][hSejf]+1)*/)
			        {
				        if(kaska[playerid] != 0 && kaska[playerid] >= 100000*(Dom[dom][hSejf]+1))
				        {
							new dmdm = 100000*(Dom[dom][hSejf]+1);
							new matsmats = 5000*(Dom[dom][hSejf]+1);
							new dragdrag = 2*(Dom[dom][hSejf]+1);
							PlayerInfo[playerid][pMats] -= matsmats;
							//PlayerInfo[playerid][pZiolo] -= dragdrag;
							PlayerInfo[playerid][pDrugs] -= dragdrag;
							ZabierzKase(playerid, dmdm);
							format(str3, sizeof(str3), "Kupi�e� %d level Sejfu za %d$, %d drag�w oraz %d mats�w. Aby go u�y� wpisz /sejfpanel.", Dom[dom][hSejf], dmdm, 4*Dom[dom][hSejf], matsmats);
							SendClientMessage(playerid, COLOR_P@, str3);
							format(str3, sizeof(str3), "Pojemno�� sejfu: Kasa: %d$, Materia�y: %d, Marihuana: %d, Heroina: %d", dmdm, matsmats*2, dragdrag*5, dragdrag*5);
							SendClientMessage(playerid, COLOR_P@, str3);
							Dom[dom][hSejf] ++;
							ZapiszDom(dom);
							KupowanieDodatkow(playerid, dom);
							Log(payLog, INFO, "%s kupi� do domu %s sejf poziomu %d za %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hSejf], dmdm);
	       				}
	       				else
	       				{
				    		format(str3, sizeof(str3), "%d level sejfu kosztuje %d$, a ty tyle nie masz!", Dom[dom][hSejf]+1, 100000*(Dom[dom][hSejf]+1));
							SendClientMessage(playerid, COLOR_P@, str3);
							KupowanieDodatkow(playerid, dom);
	       				}
					}
					else
					{
		  				format(str3, sizeof(str3), "Aby kupi� sejf o levelu %d musisz mie� %d materia��w, %dg Marihuany i %dg Heroiny", Dom[dom][hSejf]+1, 5000*(Dom[dom][hSejf]+1), 2*(Dom[dom][hSejf]+1), 2*(Dom[dom][hSejf]+1));
						SendClientMessage(playerid, COLOR_P@, str3);
						KupowanieDodatkow(playerid, dom);
					}
			    }
			    else
			   	{
	      			if(PlayerInfo[playerid][pMats] >= (5000*(Dom[dom][hSejf]+1)) && PlayerInfo[playerid][pDrugs] >= (2*(Dom[dom][hSejf]+1)) /*&& PlayerInfo[playerid][pZiolo] >= (2*(Dom[dom][hSejf]+1))*/ && PlayerInfo[playerid][pLevel] >= (Dom[dom][hSejf]+1))
			       	{
				        if(kaska[playerid] != 0 && kaska[playerid] >= 1000000*((Dom[dom][hSejf]-10)+1))
				        {
	            			new dmdm = 1000000*((Dom[dom][hSejf]-10)+1);
							new matsmats = 5000*(Dom[dom][hSejf]+1);
							new dragdrag = 2*(Dom[dom][hSejf]+1);
							PlayerInfo[playerid][pMats] -= matsmats;
							//PlayerInfo[playerid][pZiolo] -= dragdrag;
							PlayerInfo[playerid][pDrugs] -= dragdrag;
							ZabierzKase(playerid, dmdm);
							format(str3, sizeof(str3), "Kupi�e� %d level Sejfu za %d$, %d drag�w oraz %d mats�w. Aby go u�y� wpisz /sejfpanel.", Dom[dom][hSejf], 1000000*(Dom[dom][hSejf]-10), 4*Dom[dom][hSejf], 5000*Dom[dom][hSejf]);
							SendClientMessage(playerid, COLOR_P@, str3);
							format(str3, sizeof(str3), "Pojemno�� sejfu: Kasa: %d$, Materia�y: %d, Marihuana: %d, Heroina: %d", dmdm, 100000*((Dom[dom][hSejf]-10)+1), dragdrag*10, dragdrag*10);
							SendClientMessage(playerid, COLOR_P@, str3);
							Dom[dom][hSejf] ++;
							ZapiszDom(dom);
							KupowanieDodatkow(playerid, dom);
							Log(payLog, INFO, "%s kupi� do domu %s sejf poziomu %d za %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hSejf], dmdm);
				        }
				        else
				        {
						    format(str3, sizeof(str3), "%d level sejfu kosztuje %d$, a ty tyle nie masz!", Dom[dom][hSejf]+1, 1000000*((Dom[dom][hSejf]-10)+1));
							SendClientMessage(playerid, COLOR_P@, str3);
							KupowanieDodatkow(playerid, dom);
				        }
	    			}
					else
					{
			  			format(str3, sizeof(str3), "Aby kupi� sejf o levelu %d musisz mie� %d materia��w, %dg Marihuany i %dg Heroiny oraz %d LEVEL", Dom[dom][hSejf]+1, 5000*(Dom[dom][hSejf]+1), 2*(Dom[dom][hSejf]+1), 2*(Dom[dom][hSejf]+1), (Dom[dom][hSejf]+1));
						SendClientMessage(playerid, COLOR_P@, str3);
						KupowanieDodatkow(playerid, dom);
					}
			    }
			}
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
		if(dialogid == 8281)//kupowanie zbrojowni
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
	    		if(PlayerInfo[playerid][pGunLic] != 0)
	      		{
			        if(kaska[playerid] != 0 && kaska[playerid] >= 1000000)
			        {
			            Dom[dom][hZbrojownia] = 1;
			            ZabierzKase(playerid, 1000000);
			            SendClientMessage(playerid, COLOR_P@, "Gratulacje, kupi�e� zbrojownie za 1 000 000$, skonfiguruj teraz co chcesz w niej przechowywa�! Aby jej u�y� wpisz /zbrojownia we wn�trzu swojego domu");
						ZapiszDom(dom);
						DialogZbrojowni(playerid);
						Log(payLog, INFO, "%s kupi� do domu %s zbrojownie za 1000000$", GetPlayerLogName(playerid), GetHouseLogName(dom));
			        }
			        else
					{
					    SendClientMessage(playerid, COLOR_P@, "Nie masz 1 000 000$!");
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_P@, "Aby kupi� zbrojownie musisz mie� pozowlenie na bro�!");
				}
		    }
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
		if(dialogid == 8282)//kupowanie ulepsze� zbrojowni
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://Kastet ( 0 )
		            {
		            	ShowPlayerDialogEx(playerid, 8220, DIALOG_STYLE_MSGBOX, "Przystosowanie - Kastet", "Ten dodatek pozwala przechowywa� kastet w zbrojowni.\nCena przystosowania zbrojowni do przechowywania kastetu: 1 000$", "KUP!", "Cofnij");
		            }
		            case 1://Spadochron ( 11 )
		            {
		                ShowPlayerDialogEx(playerid, 8221, DIALOG_STYLE_MSGBOX, "Przystosowanie - Spadochron", "Ten dodatek pozwala przechowywa� spadochron w zbrojowni.\nCena przystosowania zbrojowni do przechowywania spadochronu: 5 000$", "KUP!", "Cofnij");
		            }
		            case 2://Sprej ga�nica i aparat ( 9 )
		            {
		                ShowPlayerDialogEx(playerid, 8222, DIALOG_STYLE_MSGBOX, "Przystosowanie - Sprej ga�nica i aparat", "Ten dodatek pozwala przechowywa� sprej ga�nic� i aparat w zbrojowni.\nCena przystosowania zbrojowni do przechowywania spreju ga�nicy i aparatu: 40 000$", "KUP!", "Cofnij");
		            }
		            case 3://Wibratory kwiaty i laska ( 10 )
		            {
		                ShowPlayerDialogEx(playerid, 8223, DIALOG_STYLE_MSGBOX, "Przystosowanie - Wibratory kwiaty i laska", "Ten dodatek pozwala przechowywa� wibratory kwiaty i lask� w zbrojowni.\nCena przystosowania zbrojowni do przechowywania wibrator�w kwiat�w i laski: 50 000$", "KUP!", "Cofnij");
		            }
		            case 4://Bro� bia�a ( 1 )
		            {
		                ShowPlayerDialogEx(playerid, 8224, DIALOG_STYLE_MSGBOX, "Przystosowanie - Bro� bia�a", "Ten dodatek pozwala przechowywa� bro� bia�� w zbrojowni.\nCena przystosowania zbrojowni do przechowywania broni bia�ej: 75 000$", "KUP!", "Cofnij");
		            }
		            case 5://Pistolety ( 2 )
		            {
		                ShowPlayerDialogEx(playerid, 8225, DIALOG_STYLE_MSGBOX, "Przystosowanie - Pistolety", "Ten dodatek pozwala przechowywa� pistolety w zbrojowni.\nCena przystosowania zbrojowni do przechowywania pistolet�w: 250 000$", "KUP!", "Cofnij");
		            }
		            case 6://Strzelby ( 3 )
		            {
		                ShowPlayerDialogEx(playerid, 8226, DIALOG_STYLE_MSGBOX, "Przystosowanie - Strzelby", "Ten dodatek pozwala przechowywa� strzelby w zbrojowni.\nCena przystosowania zbrojowni do przechowywania strzelb: 450 000$", "KUP!", "Cofnij");
		            }
		            case 7://Pistolety maszynowe ( 4 )
		            {
		                ShowPlayerDialogEx(playerid, 8227, DIALOG_STYLE_MSGBOX, "Przystosowanie - Pistolety maszynowe", "Ten dodatek pozwala przechowywa� pistolety maszynowe w zbrojowni.\nCena przystosowania zbrojowni do przechowywania pistolet�w maszynowych: 550 000$", "KUP!", "Cofnij");
		            }
		            case 8://Karabiny szturmowe ( 5 )
		            {
		                ShowPlayerDialogEx(playerid, 8228, DIALOG_STYLE_MSGBOX, "Przystosowanie - Karabiny szturmowe", "Ten dodatek pozwala przechowywa� Karabiny szturmowe w zbrojowni.\nCena przystosowania zbrojowni do przechowywania karabin�w szturmowych: 850 000$", "KUP!", "Cofnij");
		            }
		            case 9://Snajperki ( 6 )
		            {
		                ShowPlayerDialogEx(playerid, 8229, DIALOG_STYLE_MSGBOX, "Przystosowanie - Snajperki", "Ten dodatek pozwala przechowywa� snajperki w zbrojowni.\nCena przystosowania zbrojowni do przechowywania snajperek: 700 000$", "KUP!", "Cofnij");
		            }
		            case 10://Bro� ci�ka ( 7 )
		            {
		                ShowPlayerDialogEx(playerid, 8230, DIALOG_STYLE_MSGBOX, "Przystosowanie - Bro� ci�ka", "Ten dodatek pozwala przechowywa� Bro� ci�k� w zbrojowni.\nCena przystosowania zbrojowni do przechowywania broni ci�kiej: 2 000 000$", "KUP!", "Cofnij");
		            }
		            case 11://�adunki wybuchowe ( 8 )
		            {
		                ShowPlayerDialogEx(playerid, 8231, DIALOG_STYLE_MSGBOX, "Przystosowanie - �adunki wybuchowe", "Ten dodatek pozwala przechowywa� �adunki wybuchowe w zbrojowni.\nCena przystosowania zbrojowni do przechowywania �adunk�w wybuchowych: 4 000 000$", "KUP!", "Cofnij");
		            }
		        }
		    }
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
		if(dialogid == 830)//kupowanie apteczki
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
	            new Float:HP;
				GetPlayerHealth(playerid, HP);
	   			if(/*PlayerInfo[playerid][pZiolo] >= 10 &&*/ PlayerInfo[playerid][pDrugs] >= 10 && PlayerInfo[playerid][pPiwo] >= 1 && HP >= 100 && IsPlayerHealthy(playerid))
			    {
	      			if(kaska[playerid] != 0 && kaska[playerid] >= 100000)
		        	{
				        ZabierzKase(playerid, 100000);
						Dom[dom][hApteczka] = 1;
						//PlayerInfo[playerid][pZiolo] -= 10;
						PlayerInfo[playerid][pDrugs] -= 10;
						PlayerInfo[playerid][pPiwo] --;
						ZapiszDom(dom);
						//Dom[dom][hMagazyn] --;
						SendClientMessage(playerid, COLOR_P@, "Kupi�e� Apteczk� za 100 000$, piwo oraz 10g marihuany i heroiny. Aby jej u�y� wpisz /apteczka");
						KupowanieDodatkow(playerid, dom);
						Log(payLog, INFO, "%s kupi� do domu %s apteczk� poziomu %d za 100000$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hApteczka]);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_P@, "Apteczka kosztuje 100 000$ a ty tyle nie masz!");
				       	KupowanieDodatkow(playerid, dom);
					}
			    }
			    else
			    {
					SendClientMessage(playerid, COLOR_P@, "Aby kupi� apteczk� potrzebujesz: 10g marihuany, 10g herioiny, Mrucznego Gula, brak choroby i 100 HP");
			        KupowanieDodatkow(playerid, dom);
			    }
		    }
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
		if(dialogid == 831)//kupowanie pancerza
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
	            new Float:ARMOR;
				GetPlayerArmour(playerid, ARMOR);
			    if(PlayerInfo[playerid][pWino] >= 1 && ARMOR >= 50 && Dom[dom][hApteczka] != 0 && PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pDetSkill] >= 101 )
	   			{
					new str3[256];
		 			if(kaska[playerid] != 0 && kaska[playerid] >= 100000*(Dom[dom][hKami]+1))
		    		{
				      	new dmdm = 100000*(Dom[dom][hKami]+1);
				      	ZabierzKase(playerid, dmdm);
						Dom[dom][hKami] ++;
						PlayerInfo[playerid][pWino] --;
						ZapiszDom(dom);
						//Dom[dom][hMagazyn] --;
				    	format(str3, sizeof(str3), "Kupi�e� %d level Pancerza za %d$ i wino. Aby jej u�y� wpisz /pancerz", Dom[dom][hKami], 100000*(Dom[dom][hKami]+1));
						SendClientMessage(playerid, COLOR_P@, str3);
						KupowanieDodatkow(playerid, dom);
						Log(payLog, INFO, "%s kupi� do domu %s pancerz poziomu %d za %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hKami], dmdm);
					}
					else
					{
			    		
			    		format(str3, sizeof(str3), "%d level pancerza kosztuje %d$ a ty tyle nie masz!", Dom[dom][hKami]+1, 100000*(Dom[dom][hKami]+1));
						SendClientMessage(playerid, COLOR_P@, str3);
						KupowanieDodatkow(playerid, dom);
					}
			    }
			    else
			    {
			      	SendClientMessage(playerid, COLOR_P@, "Aby kupi� pancerz potrzebujesz: Wino Komandos, 50 procent pancerza, Apteczk�, 3 skill �owcy nagr�d i M4");
			      	KupowanieDodatkow(playerid, dom);
			    }
		    }
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
	    if(dialogid == 832)//kupowanie l�dowiska
		{
		    new dom = PlayerInfo[playerid][pDom];
		    if(response)
		    {
                if(Dom[dom][hLadowisko] == 0)
                {
                	if(kaska[playerid] != 0 && kaska[playerid] >= 10000000)
                	{
                	    ZabierzKase(playerid, 10000000);
						Dom[dom][hLadowisko] = 20;
						ZapiszDom(dom);
						SendClientMessage(playerid, COLOR_P@, "Kupi�e� L�dowisko za 10 000 000$. Mo�esz teraz parkowa� sw�j pojazd lataj�cy 20 metr�w od domu");
						KupowanieDodatkow(playerid, dom);
						Log(payLog, INFO, "%s kupi� do domu %s l�dowisko poziomu %d za 10000000$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hLadowisko]);
                	}
                	else
                	{
                	    SendClientMessage(playerid, COLOR_P@, "Gara� kosztuje 10 000 000$ a ty tyle nie masz!");
			       		KupowanieDodatkow(playerid, dom);
                	}
                }
                else
                {
                    if(kaska[playerid] != 0 && kaska[playerid] >= 1000000)
                	{
                	    ZabierzKase(playerid, 1000000);
						Dom[dom][hLadowisko] += 20;
						ZapiszDom(dom);
						SendClientMessage(playerid, COLOR_P@, "Kupi�e� ulepszenie l�dowiska za 1 000 000$. Mo�esz teraz parkowa� sw�j pojazd lataj�cy o 20 metr�w wi�cej ni� poprzednio.");
						KupowanieDodatkow(playerid, dom);
						Log(payLog, INFO, "%s kupi� do domu %s l�dowisko poziomu %d za 1000000$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hLadowisko]);
                	}
                	else
                	{
                	    SendClientMessage(playerid, COLOR_P@, "Gara� kosztuje 1 000 000$ a ty tyle nie masz!");
			       		KupowanieDodatkow(playerid, dom);
                	}
                }
		    }
		    if(!response)
		    {
	            KupowanieDodatkow(playerid, dom);
		    }
		}
		if(dialogid == 8000)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://Zawarto�� sejfu
		            {
		                new zawartosc[256];
	                 	new dom = PlayerInfo[playerid][pDomWKJ];
		                format(zawartosc, sizeof(zawartosc), "Zawarto�� sejfu:\n\nGot�wka:\t%d$\nMateria�y:\t%d kg\nMarihuana:\t%d gram\nHeroina:\t%d gram", Dom[dom][hS_kasa], Dom[dom][hS_mats], Dom[dom][hS_ziolo], Dom[dom][hS_drugs]);
		            	ShowPlayerDialogEx(playerid, 8001, DIALOG_STYLE_MSGBOX, "Sejf - zawarto��", zawartosc, "Cofnij", "Wyjd�");
		            }
		            case 1://W�� do sejfu
		            {
	            		ShowPlayerDialogEx(playerid, 8002, DIALOG_STYLE_LIST, "Sejf - w��", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
		            }
		            case 2://wyjmij z sejfu
		            {
		                ShowPlayerDialogEx(playerid, 8003, DIALOG_STYLE_LIST, "Sejf - wyjmij", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
		            }
		            case 3://kod do sejfu
		            {
		                if(PlayerInfo[playerid][pDom] == PlayerInfo[playerid][pDomWKJ])
		                {
		                	ShowPlayerDialogEx(playerid, 8004, DIALOG_STYLE_INPUT, "Sejf - ustalanie kodu", "Wpisz kod do sejfu w okienko poni�ej", "OK", "Wr��");
						}
						else
						{
						    SendClientMessage(playerid, COLOR_P@, "Tylko dla w�a�ciciela");
						    ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
						}
					}
		        }
		    }
		}
		if(dialogid == 8001)
		{
		    if(response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8002)//wk�adanie
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://kasa
		            {
		                ShowPlayerDialogEx(playerid, 8005, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� got�wki chcesz w�o�y� do sejfu", "W��", "Wr��");
		            }
		            case 1://matsy
		            {
		                ShowPlayerDialogEx(playerid, 8006, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� materia��w chcesz w�o�y� do sejfu", "W��", "Wr��");
		            }
		            case 2://marycha
		            {
		                ShowPlayerDialogEx(playerid, 8008, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� heroiny chcesz w�o�y� do sejfu", "W��", "Wr��");
		                //ShowPlayerDialogEx(playerid, 8007, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� marihuany chcesz w�o�y� do sejfu", "W��", "Wr��");
		            }
		            case 3://heroina
		            {
		                ShowPlayerDialogEx(playerid, 8008, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� heroiny chcesz w�o�y� do sejfu", "W��", "Wr��");
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8003)//wyjmowanie
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://kasa
		            {
		                ShowPlayerDialogEx(playerid, 8009, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� got�wki chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            }
		            case 1://matsy
		            {
		                ShowPlayerDialogEx(playerid, 8010, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� materia��w chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            }
		            case 2://marycha
		            {
		                ShowPlayerDialogEx(playerid, 8012, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� heroiny chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		                //ShowPlayerDialogEx(playerid, 8011, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� marihuany chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            }
		            case 3://heroina
		            {
		                ShowPlayerDialogEx(playerid, 8012, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� heroiny chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
					}
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8004)//kod do sejfu
		{
		    if(response)
		    {
		        if(strlen(inputtext) >= 4 && strlen(inputtext) <= 10)
		        {
	             	new kod[64];
	                new kodplik[20];
	                format(kodplik, sizeof(kodplik), "%s", inputtext);
	                mysql_real_escape_string(kodplik, kodplik);
					Dom[PlayerInfo[playerid][pDom]][hKodSejf] = kodplik;
					ZapiszDom(PlayerInfo[playerid][pDom]);
					format(kod, sizeof(kod), "Kod do sejfu to teraz: %s", inputtext);
					ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
				}
		        else
		        {
		            SendClientMessage(playerid, COLOR_P@, "Kod do sejfu od 4 do 10 znak�w");
		            ShowPlayerDialogEx(playerid, 8004, DIALOG_STYLE_INPUT, "Sejf - ustalanie kodu", "Kod twojego sejfu nie jest ustalony - musisz go ustali�.\nAby to zrobi� wpisz nowy kod do okienka poni�ej. (MIN 4 MAX 10 znak�w)", "OK", "");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8005)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8005, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� got�wki chcesz w�o�y� do sejfu", "W��", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        new maxwloz;
		        if(Dom[dom][hSejf] <= 10)
		        {
		            maxwloz = 100000*Dom[dom][hSejf];
		        }
		        else
		        {
	                maxwloz = 1000000*(Dom[dom][hSejf]-10);
		        }
		        new wkladanie = (maxwloz-Dom[dom][hS_kasa]);
		        if(strval(inputtext) >= 1 && strval(inputtext) <= wkladanie)
		        {
		            if(strval(inputtext) <= kaska[playerid] )
		            {
						new before, after;
						before = Dom[dom][hS_kasa] ;
			            Dom[dom][hS_kasa] += strval(inputtext);
						after = Dom[dom][hS_kasa];
						dini_IntSet(string, "S_kasa", Dom[dom][hS_kasa]);
			            ZabierzKase(playerid, strval(inputtext));
			            format(string, sizeof(string), "W�o�y�e� do sejfu %d$, znajduje si� w nim teraz: %d$.", strval(inputtext), Dom[dom][hS_kasa]);
			            SendClientMessage(playerid, COLOR_P@, string);
			            ShowPlayerDialogEx(playerid, 8002, DIALOG_STYLE_LIST, "Sejf - w��", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
			            ZapiszDom(PlayerInfo[playerid][pDom]);
						Log(payLog, INFO, "%s w�o�y� do sejfu w domu %s kwot� %d$. W sejfie przed: %d$, po: %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext), before, after);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_P@, "Nie sta� ci� aby w�o�y� tyle do sejfu");
		            	ShowPlayerDialogEx(playerid, 8005, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� got�wki chcesz w�o�y� do sejfu", "W��", "Wr��");
					}
				}
		        else
		        {
		            format(string, sizeof(string), "Pojemno�� sejfu to %d$. Nie mo�esz w�o�y� do niego %d$ gdy� jest ju� w nim %d$. Maksymalna stawka jak� mo�esz teraz do niego w�o�y� to %d$", maxwloz, strval(inputtext), Dom[dom][hS_kasa], wkladanie);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8005, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� got�wki chcesz w�o�y� do sejfu", "W��", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8006)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8006, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� materia��w chcesz w�o�y� do sejfu", "W��", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        new maxwloz;
		        if(Dom[dom][hSejf] <= 10)
		        {
		            maxwloz = (5000*(Dom[dom][hSejf])*2);
				}
		        else
		        {
	                maxwloz = 100000*(Dom[dom][hSejf]-10);
		        }
		        new wkladanie = (maxwloz-Dom[dom][hS_mats]);
		        if(strval(inputtext) >= 1 && strval(inputtext) <= wkladanie)
		        {
		            if(strval(inputtext) <= PlayerInfo[playerid][pMats])
		            {
			            new before, after;
						before = Dom[dom][hS_mats];
						Dom[dom][hS_mats] += strval(inputtext);
						after = Dom[dom][hS_mats];
						dini_IntSet(string, "S_mats", Dom[dom][hS_mats]);
			            PlayerInfo[playerid][pMats] -= strval(inputtext);
			            format(string, sizeof(string), "W�o�y�e� do sejfu %d mats�w, znajduje si� w nim teraz: %d mats�w.", strval(inputtext), Dom[dom][hS_mats]);
			            SendClientMessage(playerid, COLOR_P@, string);
			            ShowPlayerDialogEx(playerid, 8002, DIALOG_STYLE_LIST, "Sejf - w��", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
			            ZapiszDom(PlayerInfo[playerid][pDom]);
						Log(payLog, INFO, "%s w�o�y� do sejfu w domu %s paczk� %d materia��w. W sejfie przed: %d, po: %d", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext), before, after);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_P@, "Nie sta� ci� aby w�o�y� tyle do sejfu");
		            	ShowPlayerDialogEx(playerid, 8006, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� materia��w chcesz w�o�y� do sejfu", "W��", "Wr��");
					}
				}
		        else
		        {
		            format(string, sizeof(string), "Pojemno�� sejfu to %d mats�w. Nie mo�esz w�o�y� do niego %d mats�w gdy� jest ju� w nim %d mats�w. Maksymalna ilo�� jak� mo�esz teraz do niego w�o�y� to %d mats�w", maxwloz, strval(inputtext), Dom[dom][hS_mats], wkladanie);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8006, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� materia��w chcesz w�o�y� do sejfu", "W��", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8008)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8008, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� heroiny chcesz w�o�y� do sejfu", "W��", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        new maxwloz;
		        if(Dom[dom][hSejf] <= 10)
		        {
		            maxwloz = (2*Dom[dom][hSejf])*5;
		        }
		        else
		        {
	                maxwloz = 2*(Dom[dom][hSejf]*10);
		        }
		        new wkladanie = (maxwloz-Dom[dom][hS_drugs]);
		        if(strval(inputtext) >= 1 && strval(inputtext) <= wkladanie)
		        {
		            if(strval(inputtext) <= PlayerInfo[playerid][pDrugs])
		            {
						new before, after;
						before = Dom[dom][hS_drugs];
			            Dom[dom][hS_drugs] += strval(inputtext);
						after = Dom[dom][hS_drugs];
			            PlayerInfo[playerid][pDrugs] -= strval(inputtext);
			            format(string, sizeof(string), "W�o�y�e� do sejfu %d drag�w, znajduje si� w nim teraz: %d drag�w.", strval(inputtext), Dom[dom][hS_drugs]);
			            SendClientMessage(playerid, COLOR_P@, string);
			            ShowPlayerDialogEx(playerid, 8002, DIALOG_STYLE_LIST, "Sejf - w��", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
			            ZapiszDom(PlayerInfo[playerid][pDom]);
						Log(payLog, INFO, "%s w�o�y� do sejfu w domu %s paczk� %d narkotyk�w. W sejfie przed: %d, po: %d", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext), before, after);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_P@, "Nie sta� ci� aby w�o�y� tyle do sejfu");
		            	ShowPlayerDialogEx(playerid, 8008, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� heroiny chcesz w�o�y� do sejfu", "W��", "Wr��");
					}
				}
		        else
		        {
		            format(string, sizeof(string), "Pojemno�� sejfu to %d drag�w. Nie mo�esz w�o�y� do niego %d drag�w gdy� jest ju� w nim %d drag�w. Maksymalna ilo�� jak� mo�esz teraz do niego w�o�y� to %d drag�w", maxwloz, strval(inputtext), Dom[dom][hS_drugs], wkladanie);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8008, DIALOG_STYLE_INPUT, "Sejf - wk�adanie", "Wpisz jak� ilo�� heroiny chcesz w�o�y� do sejfu", "W��", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8009)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8009, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� got�wki chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        if(strval(inputtext) >= 1 && strval(inputtext) <= Dom[dom][hS_kasa])
		        {
		            Dom[dom][hS_kasa] -= strval(inputtext);
					dini_IntSet(string, "S_kasa", Dom[dom][hS_kasa]);
		            DajKase(playerid, strval(inputtext));
		            format(string, sizeof(string), "Wyj��e� z sejfu %d$. Jest w nim teraz %d$.", strval(inputtext), Dom[dom][hS_kasa]);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8003, DIALOG_STYLE_LIST, "Sejf - wyjmij", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
					Log(payLog, INFO, "%s wyj�� z sejfu w domu %s kwot� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext));
		        }
		        else
		        {
		            format(string, sizeof(string), "Masz w sejfie %d$. Nie mo�esz wyj�� z niego %d$.", Dom[dom][hS_kasa], strval(inputtext));
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8009, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� got�wki chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            ZapiszDom(PlayerInfo[playerid][pDom]);
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8010)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8010, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� materia��w chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        if(strval(inputtext) >= 1 && strval(inputtext) <= Dom[dom][hS_mats])
		        {
		            Dom[dom][hS_mats] -= strval(inputtext);
					dini_IntSet(string, "S_mats", Dom[dom][hS_mats]);
		            PlayerInfo[playerid][pMats] += strval(inputtext);
		            format(string, sizeof(string), "Wyj��e� z sejfu %d materia��w. Jest w nim teraz %d materia��w.", strval(inputtext), Dom[dom][hS_mats]);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8003, DIALOG_STYLE_LIST, "Sejf - wyjmij", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
		            ZapiszDom(PlayerInfo[playerid][pDom]);
					Log(payLog, INFO, "%s wyj�� z sejfu w domu %s paczk� %d materia��w", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext));
		        }
		        else
		        {
		            format(string, sizeof(string), "Masz w sejfie %d materia��w. Nie mo�esz wyj�� z niego %d materia��w.", Dom[dom][hS_mats], strval(inputtext));
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8010, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� materia��w chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		/*if(dialogid == 8011)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8011, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� marihuany chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        if(strval(inputtext) >= 1 && strval(inputtext) <= Dom[dom][hS_ziolo])
		        {
		            Dom[dom][hS_ziolo] -= strval(inputtext);
		            PlayerInfo[playerid][pZiolo] += strval(inputtext);
		            format(string, sizeof(string), "Wyj��e� z sejfu %d zio�a. Jest w nim teraz %d zio�a.", strval(inputtext), Dom[dom][hS_ziolo]);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8003, DIALOG_STYLE_LIST, "Sejf - wyjmij", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
		        }
		        else
		        {
		            format(string, sizeof(string), "Masz w sejfie %d zio�a. Nie mo�esz wyj�� z niego %d zio�a.", Dom[dom][hS_ziolo], strval(inputtext));
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8011, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� marihuany chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}*/
		if(dialogid == 8012)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	                ShowPlayerDialogEx(playerid, 8012, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� heroiny chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		            return 1;
				}
		        new dom = PlayerInfo[playerid][pDomWKJ];
		        new string[256];
		        if(strval(inputtext) >= 1 && strval(inputtext) <= Dom[dom][hS_drugs])
		        {
		            Dom[dom][hS_drugs] -= strval(inputtext);
					dini_IntSet(string, "S_drugs", Dom[dom][hS_drugs]);
		            PlayerInfo[playerid][pDrugs] += strval(inputtext);
		            format(string, sizeof(string), "Wyj��e� z sejfu %d drag�w. Jest w nim teraz %d drag�w.", strval(inputtext), Dom[dom][hS_drugs]);
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8003, DIALOG_STYLE_LIST, "Sejf - wyjmij", "Got�wk�\nMateria�y\nMarihuane\nHeroine", "Wybierz", "Wr��");
		            ZapiszDom(PlayerInfo[playerid][pDom]);
					Log(payLog, INFO, "%s wyj�� z sejfu w domu %s paczk� %d narkotyk�w", GetPlayerLogName(playerid), GetHouseLogName(dom), strval(inputtext));
		        }
		        else
		        {
		            format(string, sizeof(string), "Masz w sejfie %d heroiny. Nie mo�esz wyj�� z niego %d heroiny.", Dom[dom][hS_drugs], strval(inputtext));
		            SendClientMessage(playerid, COLOR_P@, string);
		            ShowPlayerDialogEx(playerid, 8012, DIALOG_STYLE_INPUT, "Sejf - wyjmowanie", "Wpisz jak� ilo�� heroiny chcesz wyj�� z sejfu", "Wyjmij", "Wr��");
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8015)
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
	         		ShowPlayerDialogEx(playerid, 8015, DIALOG_STYLE_INPUT, "Sejf - wpisz kod", "Ten sejf jest zabezpieczony kodem. Aby si� do niego dosta� wpisz poprawny kod w okienko poni�ej", "Zatwierd�", "Wyjd�");
					return 1;
				}
				
				if(GetPVarInt(playerid, "kodVw") != GetPlayerVirtualWorld(playerid)) return 1;
				new kod[20];
				format(kod, sizeof(kod), "%s", Dom[PlayerInfo[playerid][pDomWKJ]][hKodSejf]);
				if(strcmp(kod, inputtext, true ) == 0)
				{
	                SendClientMessage(playerid, COLOR_GREEN, "KOD POPRAWNY!");
	                ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawarto�� sejfu\nW�� do sejfu\nWyjmij z sejfu", "Wybierz", "Anuluj");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_PANICRED, "Z�Y KOD!");
				    AntyWlamSejf[playerid] ++;
				    if(AntyWlamSejf[playerid] < 5)
				    {
				    	ShowPlayerDialogEx(playerid, 8015, DIALOG_STYLE_INPUT, "Sejf - wpisz kod", "Ten sejf jest zabezpieczony kodem. Aby si� do niego dosta� wpisz poprawny kod w okienko poni�ej", "Zatwierd�", "Wyjd�");
					}
					else
					{
					    SetTimerEx("ZlyKodUn",300000,0,"d",playerid);
					    SendClientMessage(playerid, COLOR_PANICRED, "Zbyt du�o nieudanych pr�b, spr�buj jeszcze raz za 5 minut!");
					    return 1;
					}
				}
			}
		}
		if(dialogid == 8800)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(Dom[dom][hUL_Z] == 1)
		                {
		                    SendClientMessage(playerid, COLOR_P@, "Teraz tylko ty b�dziesz m�g� otwiera� i zamyka� dom");
		                    Dom[dom][hUL_Z] = 0;
		                }
		                else
		                {
		                    SendClientMessage(playerid, COLOR_P@, "Teraz wszyscy lokatorzy b�d� mogli otwiera� i zamyka� dom");
		                    Dom[dom][hUL_Z] = 1;
		                }
		                new string[256];
		                new taknie_z[10];
		                new taknie_d[10];
		                if(Dom[dom][hUL_Z] == 1)
		                {
		                    taknie_z = "tak";
		                }
		                else
		                {
		                    taknie_z = "nie";
		                }
		                if(Dom[dom][hUL_D] == 1)
		                {
		                    taknie_d = "tak";
		                }
		                else
		                {
		                    taknie_d = "nie";
		                }
		                format(string, sizeof(string), "Zamykanie i otwieranie drzwi:\t %s\nKorzystanie z dodatk�w:\t %s", taknie_z, taknie_d);
	                    ShowPlayerDialogEx(playerid, 8800, DIALOG_STYLE_LIST, "Uprawnienia lokator�w", string, "Zmie�", "Wr��");
		            }
		            case 1:
		            {
		                if(Dom[dom][hUL_D] == 1)
		                {
		                    SendClientMessage(playerid, COLOR_P@, "Teraz tylko ty b�dziesz m�g� korzysta� z dodatk�w");
		                    Dom[dom][hUL_D] = 0;
		                }
		                else
		                {
		                    SendClientMessage(playerid, COLOR_P@, "Teraz wszyscy lokatorzy b�d� mogli korzysta� z dodatk�w");
		                    Dom[dom][hUL_D] = 1;
		                }
		                new string[256];
		                new taknie_z[10];
		                new taknie_d[10];
		                if(Dom[dom][hUL_Z] == 1)
		                {
		                    taknie_z = "tak";
		                }
		                else
		                {
		                    taknie_z = "nie";
		                }
		                if(Dom[dom][hUL_D] == 1)
		                {
		                    taknie_d = "tak";
		                }
		                else
		                {
		                    taknie_d = "nie";
		                }
		                format(string, sizeof(string), "Zamykanie i otwieranie drzwi:\t %s\nKorzystanie z dodatk�w:\t %s", taknie_z, taknie_d);
	                    ShowPlayerDialogEx(playerid, 8800, DIALOG_STYLE_LIST, "Uprawnienia lokator�w", string, "Zmie�", "Wr��");
		            }
		        }
				ZapiszDom(dom);
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 815, DIALOG_STYLE_LIST, "Panel wynajmu", "Informacje og�lne\nZarz�dzaj lokatorami\nTryb wynajmu\nCena wynajmu\nInfomacja dla lokator�w\nUprawnienia lokator�w", "Wybierz", "Wyjd�");
		    }
		}
		if(dialogid == 8810)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pWynajem];
		        switch(listitem)
		        {
		            case 0://Informacje o domu
		            {
		                new string2[512];
						new wynajem[20];
						if(Dom[dom][hWynajem] == 0)
						{
	                        wynajem = "nie";
						}
						else
						{
	                        wynajem = "tak";
						}
						new drzwi[30];
						if(Dom[dom][hZamek] == 0)
						{
	                        drzwi = "Zamkni�te";
						}
						else
						{
	                        drzwi = "Otwarte";
						}
		                format(string2, sizeof(string2), "ID domu:\t%d\nID wn�trza:\t%d\nCena domu:\t%d$\nWynajem:\t%s\nIlosc pokoi:\t%d\nPokoi wynajmowanych\t%d\nCena wynajmu:\t%d$\nO�wietlenie:\t%d\nDrzwi:\t%s", dom, Dom[dom][hDomNr], Dom[dom][hCena], wynajem, Dom[dom][hPokoje], Dom[dom][hPW], Dom[dom][hCenaWynajmu], Dom[dom][hSwiatlo], drzwi);
		                ShowPlayerDialogEx(playerid, 8811, DIALOG_STYLE_MSGBOX, "G��wne informacje domu", string2, "Wr��", "Wyjd�");
		            }
		            case 1://Zamknij/Otw�rz
		            {
		                if(Dom[dom][hUL_Z] == 1)
		                {
			                if(Dom[dom][hZamek] == 1)
			                {
								Dom[dom][hZamek] = 0;
								ShowPlayerDialogEx(playerid, 8811, DIALOG_STYLE_MSGBOX, "Zamykanie domu", "Dom zosta� zamkni�ty pomy�lnie", "Wr��", "Wyjd�");
							}
							else if(Dom[dom][hZamek] == 0)
							{
							    Dom[dom][hZamek] = 1;
			                	ShowPlayerDialogEx(playerid, 8811, DIALOG_STYLE_MSGBOX, "Otwieranie domu", "Dom zosta� otworzony pomy�lnie", "Wr��", "Wyjd�");
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_P@, "W�a�cicel domu ustali�, �e nie mo�esz zamyka� ani otwiera� domu.");
		                	if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
					    	{
								ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
							}
							else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
							{
				   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
							}
						}
		            }
		            case 2://Spawn
		            {
		                ShowPlayerDialogEx(playerid, 8812, DIALOG_STYLE_LIST, "Wybierz typ spawnu", "Normalny spawn\nSpawn przed domem\nSpawn w domu", "Wybierz", "Wr��");
		            }
		            case 3://Pomoc
		            {
		                SendClientMessage(playerid, COLOR_P@, "Ju� wkr�tce");
		                if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
				    	{
							ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
						{
			   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
		            }
		        }
		    }
		}
		if(dialogid == 8811)
		{
		    if(response)
		    {
		        if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
		    	{
					ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
				}
				else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
				{
	   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
				}
		    }
		}
		if(dialogid == 8812)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:// Normalny spawn
		            {
		                PlayerInfo[playerid][pSpawn] = 0;
		                SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� na swoim normalnym spawnie");
		                if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
				    	{
							ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
						{
			   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
		            }
		            case 1:// Spawn przed domem
		            {
		                PlayerInfo[playerid][pSpawn] = 1;
		                SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� przed domem");
		                if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
				    	{
							ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
						{
			   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
					}
		            case 2:// Spawn w domu
		            {
	                    PlayerInfo[playerid][pSpawn] = 2;
	                    SendClientMessage(playerid, COLOR_NEWS, "B�dziesz si� teraz spawnowa� wewn�trz domu");
	                    if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 0)
				    	{
							ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
						else if(Dom[PlayerInfo[playerid][pWynajem]][hZamek] == 1)
						{
			   				ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
						}
					}
				}
			}
		}
		if(dialogid >= 8220 && dialogid <= 8231)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        if(dialogid == 8220)
		        {
		            if(Dom[dom][hS_PG0] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 1000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania kastetu za 1 000$!");
							ZabierzKase(playerid, 1000);
							Dom[dom][hS_PG0] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania kastetu!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8221)
		        {
		            if(Dom[dom][hS_PG11] == 0)
		            {
	                    if(kaska[playerid] >= 1 && kaska[playerid] >= 5000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania spadochronu za 5 000$!");
							ZabierzKase(playerid, 5000);
							Dom[dom][hS_PG11] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania spadochronu!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8222)
		        {
		            if(Dom[dom][hS_PG9] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 50000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania sperju, ga�nicy i kamery za 50 000$!");
							ZabierzKase(playerid, 50000);
							Dom[dom][hS_PG9] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania sperju, ga�nicy i kamery!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8223)
		        {
		            if(Dom[dom][hS_PG10] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 60000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania wibrator�w, laski i kwiat�w za 60 000$!");
							ZabierzKase(playerid, 60000);
							Dom[dom][hS_PG10] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania wibrator�w, laski i kwiat�w!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8224)
		        {
		            if(Dom[dom][hS_PG1] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 75000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania broni bia�ej za 75 000$!");
							ZabierzKase(playerid, 75000);
							Dom[dom][hS_PG1] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania broni bia�ej!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8225)
		        {
		            if(Dom[dom][hS_PG2] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 250000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania pistolet�w za 250 000$!");
							ZabierzKase(playerid, 250000);
							Dom[dom][hS_PG2] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania pistolet�w!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8226)
		        {
		            if(Dom[dom][hS_PG3] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 450000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania strzelb za 450 000$!");
							ZabierzKase(playerid, 450000);
							Dom[dom][hS_PG3] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania strzelb!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8227)
		        {
		            if(Dom[dom][hS_PG4] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 550000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania pistolet�w maszynowych za 550 000$!");
							ZabierzKase(playerid, 550000);
							Dom[dom][hS_PG4] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania pistolet�w maszynowych!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8228)
		        {
		            if(Dom[dom][hS_PG5] == 0)
		            {
	                    if(kaska[playerid] >= 1 && kaska[playerid] >= 850000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania karabin�w szturmowych za 850 000$!");
							ZabierzKase(playerid, 850000);
							Dom[dom][hS_PG5] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania karabin�w szturmowych!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8229)
		        {
		            if(Dom[dom][hS_PG6] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 700000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania snajperek za 700 000$!");
							ZabierzKase(playerid, 700000);
							Dom[dom][hS_PG6] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania snajperek!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8230)
		        {
		            if(Dom[dom][hS_PG7] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 2000000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania broni ci�zkiej za 2 000 000$!");
							ZabierzKase(playerid, 2000000);
							Dom[dom][hS_PG7] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania broni ci�zkiej!");
		                DialogZbrojowni(playerid);
		            }
		        }
		        if(dialogid == 8231)
		        {
		            if(Dom[dom][hS_PG8] == 0)
		            {
		                if(kaska[playerid] >= 1 && kaska[playerid] >= 4000000)
		                {
			                SendClientMessage(playerid, COLOR_NEWS, "Gratulacje, przystosowa�e� swoj� zbrojownie do przechowywania �adunk�w wybuchowych za 4 000 000$!");
							ZabierzKase(playerid, 4000000);
							Dom[dom][hS_PG8] = 1;
							DialogZbrojowni(playerid);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Nie sta� ci�!");
		                	DialogZbrojowni(playerid);
						}
		            }
		            else
		            {
		                SendClientMessage(playerid, COLOR_GRAD3, "Przystosowa�e� ju� swoj� zbrojownie do przechowywania �adunk�w wybuchowych!");
		                DialogZbrojowni(playerid);
		            }
		        }
		    }
		    if(!response)
		    {
		        DialogZbrojowni(playerid);
		    }
		}
		if(dialogid == 8240)//zbrojownia
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://Wyjmij bro�
		            {
		                WyjmijBron(playerid);
		            }
		            case 1://Schowaj bro�
		            {
		                SchowajBron(playerid);
		            }
		            case 2://Zawarto�� zbrojowni
		            {
		                ListaBroni(playerid);
		            }
		        }
		    }
		}
		if(dialogid == 8241)//wyjmowanie broni
		{
		    if(response)
		    {
		     	new BronieF[13][2];
				for(new i = 0; i < 13; i++) { GetPlayerWeaponData(playerid, i, BronieF[i][0], BronieF[i][1]); }
		        switch(listitem)
		        {
		            case 0:
		            {
		                new dom = PlayerInfo[playerid][pDom];
						if(BronieF[0][0] != 0)
						{
						    IDBroniZbrojownia[playerid] = 0;
						    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", "Posiadasz ju� bro� typu kastet, czy chcesz j� zamieni� na kastet ze zbrojowni?", "Zamie�", "Wr��");
						}
						else
						{
							Dom[dom][hS_G0] = 0;
							PlayerInfo[playerid][pGun0] = Dom[dom][hS_G0];
							PlayerInfo[playerid][pAmmo0] = 1;
							GivePlayerWeapon(playerid, 1, 1);
						    SendClientMessage(playerid, COLOR_NEWS, "Wyj��e� kastet ze zbrojowni.");
	                        WyjmijBron(playerid);
						}
		            }
		            case 1:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[1][0] != 0)
						{
						    IDBroniZbrojownia[playerid] = 1;
						    format(brondef, sizeof(brondef), "Posiadasz ju� bro� bia�� (%s), chcesz j� zamieni� na %s?", GunNames[BronieF[1][0]], GunNames[Dom[dom][hS_G1]]);
						    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
						}
						else
						{
							Dom[dom][hS_G1] = 0;
							Dom[dom][hS_A1] = 0;
							PlayerInfo[playerid][pGun1] = Dom[dom][hS_G1];
							PlayerInfo[playerid][pAmmo1] = 1;
							GivePlayerWeapon(playerid, Dom[dom][hS_G1], 1);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G1]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 2:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[2][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun2] == Dom[dom][hS_G2])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], Dom[dom][hS_A2]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 2;
							    format(brondef, sizeof(brondef), "Posiadasz ju� pistolet (%s), chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[2][0]], GunNames[Dom[dom][hS_G2]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G2] = 0;
							Dom[dom][hS_A2] = 0;
							PlayerInfo[playerid][pGun2] = Dom[dom][hS_G2];
							PlayerInfo[playerid][pAmmo2] = Dom[dom][hS_A2];
							GivePlayerWeapon(playerid, Dom[dom][hS_G2], Dom[dom][hS_A2]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G2]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 3:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[3][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun3] == Dom[dom][hS_G3])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], Dom[dom][hS_A3]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 3;
							    format(brondef, sizeof(brondef), "Posiadasz ju� strzelb� (%s), chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[3][0]], GunNames[Dom[dom][hS_G3]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G3] = 0;
							Dom[dom][hS_A3] = 0;
	                        PlayerInfo[playerid][pGun3] = Dom[dom][hS_G3];
							PlayerInfo[playerid][pAmmo3] = Dom[dom][hS_A3];
							GivePlayerWeapon(playerid, Dom[dom][hS_G3], Dom[dom][hS_A3]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G3]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 4:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[4][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun4] == Dom[dom][hS_G4])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], Dom[dom][hS_A4]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 4;
							    format(brondef, sizeof(brondef), "Posiadasz ju� pistolet maszynowy (%s), chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[4][0]], GunNames[Dom[dom][hS_G4]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G4] = 0;
							Dom[dom][hS_A4] = 0;
							PlayerInfo[playerid][pGun4] = Dom[dom][hS_G4];
							PlayerInfo[playerid][pAmmo4] = Dom[dom][hS_A4];
							GivePlayerWeapon(playerid, Dom[dom][hS_G4], Dom[dom][hS_A4]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G4]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 5:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[5][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun5] == Dom[dom][hS_G5])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], Dom[dom][hS_A5]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 5;
							    format(brondef, sizeof(brondef), "Posiadasz ju� karabin szturmowy (%s), chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[5][0]], GunNames[Dom[dom][hS_G5]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G5] = 0;
							Dom[dom][hS_A5] = 0;
							PlayerInfo[playerid][pGun5] = Dom[dom][hS_G5];
							PlayerInfo[playerid][pAmmo5] = Dom[dom][hS_A5];
							GivePlayerWeapon(playerid, Dom[dom][hS_G5], Dom[dom][hS_A5]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G5]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 6:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[6][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun6] == Dom[dom][hS_G6])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], Dom[dom][hS_A6]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 6;
							    format(brondef, sizeof(brondef), "Posiadasz ju� snajperk� (%s), chcesz j� zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[6][0]], GunNames[Dom[dom][hS_G6]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G6] = 0;
							Dom[dom][hS_A6] = 0;
							PlayerInfo[playerid][pGun6] = Dom[dom][hS_G6];
							PlayerInfo[playerid][pAmmo6] = Dom[dom][hS_A6];
							GivePlayerWeapon(playerid, Dom[dom][hS_G6], Dom[dom][hS_A6]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G6]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 7:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[7][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun7] == Dom[dom][hS_G7])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], Dom[dom][hS_A7]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 7;
							    format(brondef, sizeof(brondef), "Posiadasz ju� bro� ci�k� (%s), chcesz j� zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[7][0]], GunNames[Dom[dom][hS_G7]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G7] = 0;
							Dom[dom][hS_A7] = 0;
							PlayerInfo[playerid][pGun7] = Dom[dom][hS_G7];
							PlayerInfo[playerid][pAmmo7] = Dom[dom][hS_A7];
							GivePlayerWeapon(playerid, Dom[dom][hS_G7], Dom[dom][hS_A7]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G7]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 8:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[8][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun8] == Dom[dom][hS_G8])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], Dom[dom][hS_A8]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 8;
							    format(brondef, sizeof(brondef), "Posiadasz ju� �adnuek wybuchowy (%s), chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[8][0]], GunNames[Dom[dom][hS_G8]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G8] = 0;
							Dom[dom][hS_A8] = 0;
							PlayerInfo[playerid][pGun8] = Dom[dom][hS_G8];
							PlayerInfo[playerid][pAmmo8] = Dom[dom][hS_A8];
							GivePlayerWeapon(playerid, Dom[dom][hS_G8], Dom[dom][hS_A8]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G8]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 9:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[9][0] != 0)
						{
						    if(PlayerInfo[playerid][pGun9] == Dom[dom][hS_G9])
		                    {
	                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], Dom[dom][hS_A9]);
		                		ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
		                    }
		                    else
		                    {
							    IDBroniZbrojownia[playerid] = 9;
							    format(brondef, sizeof(brondef), "Posiadasz ju� %s, chcesz go zamieni� na %s?\n(W przypadku gdy bro� jest taka sama, do obecnej broni b�dziesz m�g� doda� amunicje)", GunNames[BronieF[9][0]], GunNames[Dom[dom][hS_G9]]);
							    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
							}
						}
						else
						{
							Dom[dom][hS_G9] = 0;
							Dom[dom][hS_A9] = 0;
							PlayerInfo[playerid][pGun9] = Dom[dom][hS_G9];
							PlayerInfo[playerid][pAmmo9] = Dom[dom][hS_A9];
							GivePlayerWeapon(playerid, Dom[dom][hS_G9], Dom[dom][hS_A9]);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G9]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 10:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[10][0] != 0)
						{
						    IDBroniZbrojownia[playerid] = 10;
						    format(brondef, sizeof(brondef), "Posiadasz ju� %s, chcesz go zamieni� na %s?", GunNames[BronieF[10][0]], GunNames[Dom[dom][hS_G10]]);
						    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
						}
						else
						{
							Dom[dom][hS_G10] = 0;
							Dom[dom][hS_A10] = 0;
							PlayerInfo[playerid][pGun10] = Dom[dom][hS_G10];
							PlayerInfo[playerid][pAmmo10] = 1;
							GivePlayerWeapon(playerid, Dom[dom][hS_G10], 1);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G10]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		            case 11:
		            {
		                new brondef[256];
		                new dom = PlayerInfo[playerid][pDom];
		                if(BronieF[11][0] != 0)
						{
						    IDBroniZbrojownia[playerid] = 11;
						    format(brondef, sizeof(brondef), "Posiadasz ju� %s, chcesz go zamieni� na %s?", GunNames[BronieF[11][0]], GunNames[Dom[dom][hS_G11]]);
						    ShowPlayerDialogEx(playerid, 8244, DIALOG_STYLE_MSGBOX, "Wyjmowanie broni", brondef, "Zamie�", "Wr��");
						}
						else
						{
							Dom[dom][hS_G11] = 0;
							Dom[dom][hS_A11] = 0;
							PlayerInfo[playerid][pGun11] = Dom[dom][hS_G11];
							PlayerInfo[playerid][pAmmo11] = 1;
							GivePlayerWeapon(playerid, Dom[dom][hS_G11], 1);
							format(brondef, sizeof(brondef), "Wyj��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G11]]);
						    SendClientMessage(playerid, COLOR_NEWS, brondef);
	                        WyjmijBron(playerid);
						}
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8240, DIALOG_STYLE_LIST, "Zbrojownia", "Wyjmij bro�\nSchowaj bro�\nZawarto�� zbrojowni", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8242)//chowanie broni
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        new brondef[512];
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(Dom[dom][hS_PG0] >= 1)
		                {
			                if(Dom[dom][hS_G0] == 1)
			                {
			                    IDBroniZbrojownia[playerid] = 0;
							    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[1], GunNames[1]);
							    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
			                }
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun0]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G0] = 1;
								PlayerInfo[playerid][pGun0] = 0;
								PlayerInfo[playerid][pAmmo0] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
				            }
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania kastetu.");
						    SchowajBron(playerid);
						}
		            }
		            case 1:
		            {
		                if(Dom[dom][hS_PG1] >= 1)
		                {
		                    if(Dom[dom][hS_G1] >= 1)
			                {
			                    IDBroniZbrojownia[playerid] = 1;
							    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G1]], GunNames[PlayerInfo[playerid][pGun1]]);
							    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
			                }
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun1]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G1] = PlayerInfo[playerid][pGun1];
				    			Dom[dom][hS_A1] = 1;
								PlayerInfo[playerid][pGun1] = 0;
								PlayerInfo[playerid][pAmmo1] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania broni bia�ej.");
						    SchowajBron(playerid);
						}
		            }
		            case 2:
		            {
		                if(Dom[dom][hS_PG2] >= 1)
		                {
			                if(Dom[dom][hS_G2] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun2] == Dom[dom][hS_G2])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], PlayerInfo[playerid][pGun2]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 2;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G2]], GunNames[PlayerInfo[playerid][pGun2]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun2]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G2] = PlayerInfo[playerid][pGun2];
				    			Dom[dom][hS_A2] = PlayerInfo[playerid][pAmmo2];
								PlayerInfo[playerid][pGun2] = 0;
								PlayerInfo[playerid][pAmmo2] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania pistolet�w.");
						    SchowajBron(playerid);
						}
		            }
		            case 3:
		            {
		                if(Dom[dom][hS_PG3] >= 1)
		                {
			                if(Dom[dom][hS_G3] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun3] == Dom[dom][hS_G3])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], PlayerInfo[playerid][pGun3]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 3;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G3]], GunNames[PlayerInfo[playerid][pGun3]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun3]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G3] = PlayerInfo[playerid][pGun3];
				    			Dom[dom][hS_A3] = PlayerInfo[playerid][pAmmo3];
								PlayerInfo[playerid][pGun3] = 0;
								PlayerInfo[playerid][pAmmo3] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
							  	SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania strzelb.");
						    SchowajBron(playerid);
						}
		            }
		            case 4:
		            {
		                if(Dom[dom][hS_PG4] >= 1)
		                {
			                if(Dom[dom][hS_G4] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun4] == Dom[dom][hS_G4])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], PlayerInfo[playerid][pGun4]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 4;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G4]], GunNames[PlayerInfo[playerid][pGun4]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun4]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G4] = PlayerInfo[playerid][pGun4];
				    			Dom[dom][hS_A4] = PlayerInfo[playerid][pAmmo4];
								PlayerInfo[playerid][pGun4] = 0;
								PlayerInfo[playerid][pAmmo4] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania pistolet�w maszynowych.");
						    SchowajBron(playerid);
						}
		            }
		            case 5:
		            {
		                if(Dom[dom][hS_PG5] >= 1)
		                {
			                if(Dom[dom][hS_G5] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun5] == Dom[dom][hS_G5])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], PlayerInfo[playerid][pGun5]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 5;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G5]], GunNames[PlayerInfo[playerid][pGun5]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun5]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G5] = PlayerInfo[playerid][pGun5];
				    			Dom[dom][hS_A5] = PlayerInfo[playerid][pAmmo5];
								PlayerInfo[playerid][pGun5] = 0;
								PlayerInfo[playerid][pAmmo5] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania karabin�w maszynowych.");
						    SchowajBron(playerid);
						}
		            }
		            case 6:
		            {
		                if(Dom[dom][hS_PG6] >= 1)
		                {
			                if(Dom[dom][hS_G6] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun6] == Dom[dom][hS_G6])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], PlayerInfo[playerid][pGun6]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 6;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G6]], GunNames[PlayerInfo[playerid][pGun6]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun6]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G6] = PlayerInfo[playerid][pGun6];
				    			Dom[dom][hS_A6] = PlayerInfo[playerid][pAmmo6];
								PlayerInfo[playerid][pGun6] = 0;
								PlayerInfo[playerid][pAmmo6] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania snajperek.");
						    SchowajBron(playerid);
						}
		            }
		            case 7:
		            {
		                if(Dom[dom][hS_PG7] >= 1)
		                {
			                if(Dom[dom][hS_G7] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun7] == Dom[dom][hS_G7])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], PlayerInfo[playerid][pGun7]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 7;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G7]], GunNames[PlayerInfo[playerid][pGun7]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun7]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G7] = PlayerInfo[playerid][pGun7];
				    			Dom[dom][hS_A7] = PlayerInfo[playerid][pAmmo7];
								PlayerInfo[playerid][pGun7] = 0;
								PlayerInfo[playerid][pAmmo7] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania broni ci�kiej.");
						    SchowajBron(playerid);
						}
		            }
		            case 8:
		            {
		                if(Dom[dom][hS_PG8] >= 1)
		                {
			                if(Dom[dom][hS_G8] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun8] == Dom[dom][hS_G8])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], PlayerInfo[playerid][pGun8]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 8;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G8]], GunNames[PlayerInfo[playerid][pGun8]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun8]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G8] = PlayerInfo[playerid][pGun8];
				    			Dom[dom][hS_A8] = PlayerInfo[playerid][pAmmo8];
								PlayerInfo[playerid][pGun8] = 0;
								PlayerInfo[playerid][pAmmo8] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania �adunk�w wybuchowych.");
						    SchowajBron(playerid);
						}
		            }
		            case 9:
		            {
		                if(Dom[dom][hS_PG9] >= 1)
		                {
			                if(Dom[dom][hS_G9] >= 1)
			                {
			                    if(PlayerInfo[playerid][pGun9] == Dom[dom][hS_G9])
			                    {
		                            format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], PlayerInfo[playerid][pGun9]);
			                		ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			                    }
			                    else
			                    {
				                    IDBroniZbrojownia[playerid] = 9;
								    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G9]], GunNames[PlayerInfo[playerid][pGun9]]);
								    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
								}
							}
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun9]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G9] = PlayerInfo[playerid][pGun9];
				    			Dom[dom][hS_A9] = PlayerInfo[playerid][pAmmo9];
								PlayerInfo[playerid][pGun9] = 0;
								PlayerInfo[playerid][pAmmo9] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania spreju/ga�nicy/aparatu.");
						    SchowajBron(playerid);
						}
		            }
		            case 10:
		            {
	                    if(Dom[dom][hS_PG10] >= 1)
		                {
			                if(Dom[dom][hS_G10] >= 1)
			                {
			                    IDBroniZbrojownia[playerid] = 10;
							    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G10]], GunNames[PlayerInfo[playerid][pGun10]]);
							    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
			                }
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun10]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G10] = PlayerInfo[playerid][pGun10];
				    			Dom[dom][hS_A10] = 1;
								PlayerInfo[playerid][pGun10] = 0;
								PlayerInfo[playerid][pAmmo10] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania kwiat�w/lasek/wibrator�w.");
						    SchowajBron(playerid);
						}
		            }
		            case 11:
		            {
		                if(Dom[dom][hS_PG11] >= 1)
		                {
			                if(Dom[dom][hS_G11] >= 1)
			                {
			                    IDBroniZbrojownia[playerid] = 11;
							    format(brondef, sizeof(brondef), "W zbrojowni jest ju� %s, chcesz zamieni� zawarto�� na %s?", GunNames[Dom[dom][hS_G11]], GunNames[PlayerInfo[playerid][pGun11]]);
							    ShowPlayerDialogEx(playerid, 8246, DIALOG_STYLE_MSGBOX, "Chowanie broni", brondef, "Zamie�", "Wr��");
			                }
			                else
			                {
				                format(brondef, sizeof(brondef), "Schowa�e� %s do zbrojowni", GunNames[PlayerInfo[playerid][pGun11]]);
				    			SendClientMessage(playerid, COLOR_NEWS, brondef);
				    			Dom[dom][hS_G11] = PlayerInfo[playerid][pGun11];
				    			Dom[dom][hS_A11] = 1;
								PlayerInfo[playerid][pGun11] = 0;
								PlayerInfo[playerid][pAmmo11] = 0;
				                ResetPlayerWeapons(playerid);
				                PrzywrocBron(playerid);
				                SchowajBron(playerid);
				            }
			            }
						else
						{
						    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania spadochronu.");
						    SchowajBron(playerid);
						}
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8240, DIALOG_STYLE_LIST, "Zbrojownia", "Wyjmij bro�\nSchowaj bro�\nZawarto�� zbrojowni", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8243)//lista/usuwanie broni
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        switch(listitem)
		        {
		            case 0:
		            {
		                new brondef[256];
		                Dom[dom][hS_G0] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G0]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 1:
		            {
		                new brondef[256];
		                Dom[dom][hS_G1] = 0;
		                Dom[dom][hS_A1] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G1]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 2:
		            {
		                new brondef[256];
		                Dom[dom][hS_G2] = 0;
		                Dom[dom][hS_A2] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G2]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 3:
		            {
		                new brondef[256];
		                Dom[dom][hS_G3] = 0;
		                Dom[dom][hS_A3] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G3]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 4:
		            {
		                new brondef[256];
		                Dom[dom][hS_G4] = 0;
		                Dom[dom][hS_A4] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G4]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 5:
		            {
		                new brondef[256];
		                Dom[dom][hS_G5] = 0;
		                Dom[dom][hS_A5] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G5]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 6:
		            {
		                new brondef[256];
		                Dom[dom][hS_G6] = 0;
		                Dom[dom][hS_A6] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G6]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 7:
		            {
		                new brondef[256];
		                Dom[dom][hS_G7] = 0;
		                Dom[dom][hS_A7] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G7]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 8:
		            {
		                new brondef[256];
		                Dom[dom][hS_G8] = 0;
		                Dom[dom][hS_A8] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G8]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 9:
		            {
		                new brondef[256];
		                Dom[dom][hS_G9] = 0;
		                Dom[dom][hS_A9] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G9]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 10:
		            {
		                new brondef[256];
		                Dom[dom][hS_G10] = 0;
		                Dom[dom][hS_A10] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G10]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		            case 11:
		            {
		                new brondef[256];
		                Dom[dom][hS_G11] = 0;
		                Dom[dom][hS_A11] = 0;
						format(brondef, sizeof(brondef), "Usun��e� %s ze zbrojowni", GunNames[Dom[dom][hS_G11]]);
		    			SendClientMessage(playerid, COLOR_NEWS, brondef);
	        			ListaBroni(playerid);
		            }
		        }
		    }
		    if(!response)
		    {
		        ShowPlayerDialogEx(playerid, 8240, DIALOG_STYLE_LIST, "Zbrojownia", "Wyjmij bro�\nSchowaj bro�\nZawarto�� zbrojowni", "Wybierz", "Anuluj");
		    }
		}
		if(dialogid == 8244)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        if(IDBroniZbrojownia[playerid] == 0)
		        {
		            SendClientMessage(playerid, COLOR_NEWS, "Wymieni�e� kastet na kastet");
		            Dom[dom][hS_G0] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 1)
		        {
	       			new brondef[256];
	          		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun1]], GunNames[Dom[dom][hS_G1]]);
	            	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun1] = Dom[dom][hS_G1];
	                PlayerInfo[playerid][pAmmo1] = Dom[dom][hS_A1];
	                Dom[dom][hS_G1] = 0;
	                Dom[dom][hS_A1] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 2)
		        {
	 				new brondef[256];
	          		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun2]], GunNames[Dom[dom][hS_G2]]);
	            	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun2] = Dom[dom][hS_G2];
	                PlayerInfo[playerid][pAmmo2] = Dom[dom][hS_A2];
	                Dom[dom][hS_G2] = 0;
	                Dom[dom][hS_A2] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 3)
		        {
	      			new brondef[256];
		       		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun3]], GunNames[Dom[dom][hS_G3]]);
		        	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun3] = Dom[dom][hS_G3];
	    			PlayerInfo[playerid][pAmmo3] = Dom[dom][hS_A3];
	       			Dom[dom][hS_G3] = 0;
	          		Dom[dom][hS_A3] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 4)
		        {
	      			new brondef[256];
		       		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun4]], GunNames[Dom[dom][hS_G4]]);
		        	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun4] = Dom[dom][hS_G4];
	    			PlayerInfo[playerid][pAmmo4] = Dom[dom][hS_A4];
	       			Dom[dom][hS_G4] = 0;
	          		Dom[dom][hS_A4] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 5)
		        {
	      			new brondef[256];
	       			format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun5]], GunNames[Dom[dom][hS_G5]]);
	         		SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun5] = Dom[dom][hS_G5];
	    			PlayerInfo[playerid][pAmmo5] = Dom[dom][hS_A5];
	       			Dom[dom][hS_G5] = 0;
	          		Dom[dom][hS_A5] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 6)
		        {
	      			new brondef[256];
	     			format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun6]], GunNames[Dom[dom][hS_G6]]);
		           	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun6] = Dom[dom][hS_G6];
					PlayerInfo[playerid][pAmmo6] = Dom[dom][hS_A6];
	    			Dom[dom][hS_G6] = 0;
	   				Dom[dom][hS_A6] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 7)
		        {
	      			new brondef[256];
		       		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun7]], GunNames[Dom[dom][hS_G7]]);
		        	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun7] = Dom[dom][hS_G7];
				    PlayerInfo[playerid][pAmmo7] = Dom[dom][hS_A7];
				    Dom[dom][hS_G7] = 0;
				    Dom[dom][hS_A7] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 8)
		        {
		       		new brondef[256];
	       			format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun8]], GunNames[Dom[dom][hS_G8]]);
		           	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun8] = Dom[dom][hS_G8];
	    			PlayerInfo[playerid][pAmmo8] = Dom[dom][hS_A8];
	   				Dom[dom][hS_G8] = 0;
	       			Dom[dom][hS_A8] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 9)
		        {
	      			new brondef[256];
	       			format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun9]], GunNames[Dom[dom][hS_G9]]);
	         		SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun9] = Dom[dom][hS_G9];
	    			PlayerInfo[playerid][pAmmo9] = Dom[dom][hS_A9];
	       			Dom[dom][hS_G9] = 0;
	          		Dom[dom][hS_A9] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 10)
		        {
	       			new brondef[256];
	          		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun10]], GunNames[Dom[dom][hS_G10]]);
	            	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun10] = Dom[dom][hS_G10];
	                PlayerInfo[playerid][pAmmo10] = Dom[dom][hS_A10];
	                Dom[dom][hS_G10] = 0;
	                Dom[dom][hS_A10] = 0;
		        }
		        if(IDBroniZbrojownia[playerid] == 11)
		        {
	       			new brondef[256];
	          		format(brondef, sizeof(brondef), "Wymieni�e� %s na %s", GunNames[PlayerInfo[playerid][pGun11]], GunNames[Dom[dom][hS_G11]]);
	            	SendClientMessage(playerid, COLOR_NEWS, brondef);
					PlayerInfo[playerid][pGun11] = Dom[dom][hS_G11];
	                PlayerInfo[playerid][pAmmo11] = Dom[dom][hS_A11];
	                Dom[dom][hS_G11] = 0;
	                Dom[dom][hS_A11] = 0;
		        }
	            WyjmijBron(playerid);
	            ResetPlayerWeapons(playerid);
		        PrzywrocBron(playerid);
		    }
		    if(!response)
		    {
		        IDBroniZbrojownia[playerid] = 0;
		        WyjmijBron(playerid);
		    }
		}
		if(dialogid == 8245)
		{
		    if(response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        new brondef[256];
		        if(IDBroniZbrojownia[playerid] == 2)
		        {
		   			PlayerInfo[playerid][pAmmo2] += Dom[dom][hS_A2];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], Dom[dom][hS_A2]);
		      		Dom[dom][hS_G2] = 0;
					Dom[dom][hS_A2] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo2], GunNames[PlayerInfo[playerid][pGun2]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 3)
		        {
		   			PlayerInfo[playerid][pAmmo3] += Dom[dom][hS_A3];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], Dom[dom][hS_A3]);
		      		Dom[dom][hS_G3] = 0;
					Dom[dom][hS_A3] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo3], GunNames[PlayerInfo[playerid][pGun3]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 4)
		        {
		   			PlayerInfo[playerid][pAmmo4] += Dom[dom][hS_A4];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], Dom[dom][hS_A4]);
		      		Dom[dom][hS_G4] = 0;
					Dom[dom][hS_A4] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo4], GunNames[PlayerInfo[playerid][pGun4]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 5)
		        {
		   			PlayerInfo[playerid][pAmmo5] += Dom[dom][hS_A5];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun5], Dom[dom][hS_A5]);
		      		Dom[dom][hS_G5] = 0;
					Dom[dom][hS_A5] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo5], GunNames[PlayerInfo[playerid][pGun5]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 6)
		        {
		   			PlayerInfo[playerid][pAmmo6] += Dom[dom][hS_A6];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun6], Dom[dom][hS_A6]);
		      		Dom[dom][hS_G6] = 0;
					Dom[dom][hS_A6] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo6], GunNames[PlayerInfo[playerid][pGun6]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 7)
		        {
		   			PlayerInfo[playerid][pAmmo7] += Dom[dom][hS_A7];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun7], Dom[dom][hS_A7]);
		      		Dom[dom][hS_G7] = 0;
					Dom[dom][hS_A7] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo7], GunNames[PlayerInfo[playerid][pGun7]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 8)
		        {
		   			PlayerInfo[playerid][pAmmo8] += Dom[dom][hS_A8];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun8], Dom[dom][hS_A8]);
		      		Dom[dom][hS_G8] = 0;
					Dom[dom][hS_A8] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo8], GunNames[PlayerInfo[playerid][pGun8]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 9)
		        {
		   			PlayerInfo[playerid][pAmmo9] += Dom[dom][hS_A9];
		      		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun9], Dom[dom][hS_A9]);
		      		Dom[dom][hS_G9] = 0;
					Dom[dom][hS_A9] = 0;
		            format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo9], GunNames[PlayerInfo[playerid][pGun9]]);
		            SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				WyjmijBron(playerid);
			}
		    if(!response)
		    {
		        new dom = PlayerInfo[playerid][pDom];
		        if(strlen(inputtext) >= 1 && strlen(inputtext) <= 6 && strval(inputtext) >= 1 && strval(inputtext) <= 100000)
		        {
		            new brondef[512];
		            if(IDBroniZbrojownia[playerid] == 2)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A2])
			            {
			                Dom[dom][hS_A2] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo2] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo2], GunNames[PlayerInfo[playerid][pGun2]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], Dom[dom][hS_A2]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 3)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A3])
			            {
			                Dom[dom][hS_A3] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo3] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo3], GunNames[PlayerInfo[playerid][pGun3]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], Dom[dom][hS_A3]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 4)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A4])
			            {
			                Dom[dom][hS_A4] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo4] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo4], GunNames[PlayerInfo[playerid][pGun4]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], Dom[dom][hS_A4]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 5)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A5])
			            {
			                Dom[dom][hS_A5] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo5] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun5], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo5], GunNames[PlayerInfo[playerid][pGun5]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], Dom[dom][hS_A5]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 6)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A6])
			            {
			                Dom[dom][hS_A6] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo6] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun6], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo6], GunNames[PlayerInfo[playerid][pGun6]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], Dom[dom][hS_A6]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 7)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A7])
			            {
			                Dom[dom][hS_A7] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo7] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun7], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo7], GunNames[PlayerInfo[playerid][pGun7]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], Dom[dom][hS_A7]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 8)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A8])
			            {
			                Dom[dom][hS_A8] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo8] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun8], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo8], GunNames[PlayerInfo[playerid][pGun8]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], Dom[dom][hS_A8]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 9)
			        {
			            if(strval(inputtext) < Dom[dom][hS_A9])
			            {
			                Dom[dom][hS_A9] -= strval(inputtext);
			                PlayerInfo[playerid][pAmmo9] += strval(inputtext);
			                GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun9], strval(inputtext));
			                format(brondef, sizeof(brondef), "Masz teraz %d naboi w swoim %s", PlayerInfo[playerid][pAmmo9], GunNames[PlayerInfo[playerid][pGun9]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz tyle naboi w zbrojowni lub pr�bujesz wzi��� wszystkie. Aby wzi��c wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], Dom[dom][hS_A9]);
			                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        WyjmijBron(playerid);
		        }
		        else
		        {
		            SendClientMessage(playerid, COLOR_NEWS, "Ilo�� naboi od 1 do 100 000");
		         	if(IDBroniZbrojownia[playerid] == 2)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], Dom[dom][hS_A2]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
		            }
			        if(IDBroniZbrojownia[playerid] == 3)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], Dom[dom][hS_A3]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
		        	}
			        if(IDBroniZbrojownia[playerid] == 4)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], Dom[dom][hS_A4]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
			        }
			        if(IDBroniZbrojownia[playerid] == 5)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], Dom[dom][hS_A5]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
			        }
			        if(IDBroniZbrojownia[playerid] == 6)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], Dom[dom][hS_A6]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
			        }
			        if(IDBroniZbrojownia[playerid] == 7)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], Dom[dom][hS_A7]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
			        }
			        if(IDBroniZbrojownia[playerid] == 8)
		        	{
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], Dom[dom][hS_A8]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
		            	return 1;
			        }
			        if(IDBroniZbrojownia[playerid] == 9)
			        {
		                new info[512];
						format(info, sizeof(info), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz wyj�� ca�� bro� z nabojami lub wyj�� okre�lon� ilo�� naboi.\nJe�eli chcesz wyj�� naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], Dom[dom][hS_A9]);
		                ShowPlayerDialogEx(playerid, 8245, DIALOG_STYLE_INPUT, "Wyjmowanie amunicji", info, "Wszystko", "Naboje");
						return 1;
					}
		        }
		    }
		}
		if(dialogid == 8246)
		{
		    if(response)
		    {
		        new brondef[256];
		        new dom = PlayerInfo[playerid][pDom];
		        if(IDBroniZbrojownia[playerid] == 0)
		        {
		            Dom[dom][hS_G0] = 1;
	          		PlayerInfo[playerid][pGun0] = 0;
	    			PlayerInfo[playerid][pAmmo0] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s", GunNames[1]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 1)
		        {
		            Dom[dom][hS_G1] = PlayerInfo[playerid][pGun1];
	          		Dom[dom][hS_A1] = 1;
	          		PlayerInfo[playerid][pGun1] = 0;
	    			PlayerInfo[playerid][pAmmo1] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s", GunNames[Dom[dom][hS_G1]]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
		        if(IDBroniZbrojownia[playerid] == 2)
		        {
		            Dom[dom][hS_G2] = PlayerInfo[playerid][pGun2];
	          		Dom[dom][hS_A2] = PlayerInfo[playerid][pAmmo2];
	          		PlayerInfo[playerid][pGun2] = 0;
	    			PlayerInfo[playerid][pAmmo2] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G2]], Dom[dom][hS_A2]);
				}
				if(IDBroniZbrojownia[playerid] == 3)
		        {
		            Dom[dom][hS_G3] = PlayerInfo[playerid][pGun3];
	          		Dom[dom][hS_A3] = PlayerInfo[playerid][pAmmo3];
	          		PlayerInfo[playerid][pGun3] = 0;
	    			PlayerInfo[playerid][pAmmo3] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G3]], Dom[dom][hS_A3]);
				}
				if(IDBroniZbrojownia[playerid] == 4)
		        {
		            Dom[dom][hS_G4] = PlayerInfo[playerid][pGun4];
	          		Dom[dom][hS_A4] = PlayerInfo[playerid][pAmmo4];
	          		PlayerInfo[playerid][pGun4] = 0;
	    			PlayerInfo[playerid][pAmmo4] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G4]], Dom[dom][hS_A4]);
				}
				if(IDBroniZbrojownia[playerid] == 5)
		        {
		            Dom[dom][hS_G5] = PlayerInfo[playerid][pGun5];
	          		Dom[dom][hS_A5] = PlayerInfo[playerid][pAmmo5];
	          		PlayerInfo[playerid][pGun5] = 0;
	    			PlayerInfo[playerid][pAmmo5] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G5]], Dom[dom][hS_A5]);
				}
				if(IDBroniZbrojownia[playerid] == 6)
		        {
		            Dom[dom][hS_G6] = PlayerInfo[playerid][pGun6];
	          		Dom[dom][hS_A6] = PlayerInfo[playerid][pAmmo6];
	          		PlayerInfo[playerid][pGun6] = 0;
	    			PlayerInfo[playerid][pAmmo6] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G6]], Dom[dom][hS_A6]);
				}
				if(IDBroniZbrojownia[playerid] == 7)
		        {
		            Dom[dom][hS_G7] = PlayerInfo[playerid][pGun7];
	          		Dom[dom][hS_A7] = PlayerInfo[playerid][pAmmo7];
	          		PlayerInfo[playerid][pGun7] = 0;
	    			PlayerInfo[playerid][pAmmo7] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G7]], Dom[dom][hS_A7]);
				}
				if(IDBroniZbrojownia[playerid] == 8)
		        {
		            Dom[dom][hS_G8] = PlayerInfo[playerid][pGun8];
	          		Dom[dom][hS_A8] = PlayerInfo[playerid][pAmmo8];
	          		PlayerInfo[playerid][pGun8] = 0;
	    			PlayerInfo[playerid][pAmmo8] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G8]], Dom[dom][hS_A8]);
				}
				if(IDBroniZbrojownia[playerid] == 9)
		        {
		            Dom[dom][hS_G9] = PlayerInfo[playerid][pGun9];
	          		Dom[dom][hS_A9] = PlayerInfo[playerid][pAmmo9];
	          		PlayerInfo[playerid][pGun9] = 0;
	    			PlayerInfo[playerid][pAmmo9] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G9]], Dom[dom][hS_A9]);
				}
				if(IDBroniZbrojownia[playerid] == 10)
		        {
		            Dom[dom][hS_G10] = PlayerInfo[playerid][pGun10];
	          		Dom[dom][hS_A10] = 1;
	          		PlayerInfo[playerid][pGun10] = 0;
	    			PlayerInfo[playerid][pAmmo10] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s", GunNames[Dom[dom][hS_G10]]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				if(IDBroniZbrojownia[playerid] == 11)
		        {
		            Dom[dom][hS_G11] = PlayerInfo[playerid][pGun11];
	          		Dom[dom][hS_A11] = 1;
	          		PlayerInfo[playerid][pGun11] = 0;
	    			PlayerInfo[playerid][pAmmo11] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s", GunNames[Dom[dom][hS_G11]]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
				}
				ResetPlayerWeapons(playerid);
				PrzywrocBron(playerid);
	            SchowajBron(playerid);
			}
			if(!response)
			{
			    SchowajBron(playerid);
			}
		}
		if(dialogid == 8247)
		{
			if(response)
			{
			    new dom = PlayerInfo[playerid][pDom];
			    new brondef[256];
			    if(IDBroniZbrojownia[playerid] == 2)
		        {
	          		Dom[dom][hS_A2] += PlayerInfo[playerid][pAmmo2];
	          		PlayerInfo[playerid][pGun2] = 0;
	    			PlayerInfo[playerid][pAmmo2] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G2]], Dom[dom][hS_A2]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 3)
		        {
	          		Dom[dom][hS_A3] += PlayerInfo[playerid][pAmmo3];
	          		PlayerInfo[playerid][pGun3] = 0;
	    			PlayerInfo[playerid][pAmmo3] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G3]], Dom[dom][hS_A3]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 4)
		        {
	          		Dom[dom][hS_A4] += PlayerInfo[playerid][pAmmo4];
	          		PlayerInfo[playerid][pGun4] = 0;
	    			PlayerInfo[playerid][pAmmo4] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G4]], Dom[dom][hS_A4]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 5)
		        {
	          		Dom[dom][hS_A5] += PlayerInfo[playerid][pAmmo5];
	          		PlayerInfo[playerid][pGun5] = 0;
	    			PlayerInfo[playerid][pAmmo5] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G5]], Dom[dom][hS_A5]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 6)
		        {
	          		Dom[dom][hS_A6] += PlayerInfo[playerid][pAmmo6];
	          		PlayerInfo[playerid][pGun6] = 0;
	    			PlayerInfo[playerid][pAmmo6] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G6]], Dom[dom][hS_A6]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 7)
		        {
	          		Dom[dom][hS_A7] += PlayerInfo[playerid][pAmmo7];
	          		PlayerInfo[playerid][pGun7] = 0;
	    			PlayerInfo[playerid][pAmmo7] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G7]], Dom[dom][hS_A7]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 8)
		        {
	          		Dom[dom][hS_A8] += PlayerInfo[playerid][pAmmo8];
	          		PlayerInfo[playerid][pGun8] = 0;
	    			PlayerInfo[playerid][pAmmo8] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G8]], Dom[dom][hS_A8]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        if(IDBroniZbrojownia[playerid] == 9)
		        {
	          		Dom[dom][hS_A9] += PlayerInfo[playerid][pAmmo9];
	          		PlayerInfo[playerid][pGun9] = 0;
	    			PlayerInfo[playerid][pAmmo9] = 0;
			       	format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %s z %d nabojami", GunNames[Dom[dom][hS_G9]], Dom[dom][hS_A9]);
					SendClientMessage(playerid, COLOR_NEWS, brondef);
		        }
		        ResetPlayerWeapons(playerid);
				PrzywrocBron(playerid);
	            SchowajBron(playerid);
			}
			if(!response)
			{
	            new dom = PlayerInfo[playerid][pDom];
		        if(strlen(inputtext) >= 1 && strlen(inputtext) <= 6 && strval(inputtext) >= 1 && strval(inputtext) <= 100000)
		        {
		            new brondef[512];
		            if(IDBroniZbrojownia[playerid] == 2)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo2])
			            {
			                PlayerInfo[playerid][pAmmo2] -= strval(inputtext);
			                Dom[dom][hS_A2] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A2], GunNames[Dom[dom][hS_G2]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], PlayerInfo[playerid][pGun2]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 3)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo3])
			            {
			                PlayerInfo[playerid][pAmmo3] -= strval(inputtext);
			                Dom[dom][hS_A3] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A3], GunNames[Dom[dom][hS_G3]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], PlayerInfo[playerid][pGun3]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 4)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo4])
			            {
			                PlayerInfo[playerid][pAmmo4] -= strval(inputtext);
			                Dom[dom][hS_A4] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A4], GunNames[Dom[dom][hS_G4]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], PlayerInfo[playerid][pGun4]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 5)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo5])
			            {
			                PlayerInfo[playerid][pAmmo5] -= strval(inputtext);
			                Dom[dom][hS_A5] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A5], GunNames[Dom[dom][hS_G5]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], PlayerInfo[playerid][pGun5]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 6)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo6])
			            {
			                PlayerInfo[playerid][pAmmo6] -= strval(inputtext);
			                Dom[dom][hS_A6] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A6], GunNames[Dom[dom][hS_G6]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], PlayerInfo[playerid][pGun6]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 7)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo7])
			            {
			                PlayerInfo[playerid][pAmmo7] -= strval(inputtext);
			                Dom[dom][hS_A7] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A7], GunNames[Dom[dom][hS_G7]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], PlayerInfo[playerid][pGun7]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 8)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo8])
			            {
			                PlayerInfo[playerid][pAmmo8] -= strval(inputtext);
			                Dom[dom][hS_A8] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A8], GunNames[Dom[dom][hS_G8]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], PlayerInfo[playerid][pGun8]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        if(IDBroniZbrojownia[playerid] == 9)
			        {
	                    if(strval(inputtext) < PlayerInfo[playerid][pAmmo9])
			            {
			                PlayerInfo[playerid][pAmmo9] -= strval(inputtext);
			                Dom[dom][hS_A9] += strval(inputtext);
			                format(brondef, sizeof(brondef), "W zbrojowni znajduje si� teraz %d naboi do %s", Dom[dom][hS_A9], GunNames[Dom[dom][hS_G9]]);
	            			SendClientMessage(playerid, COLOR_NEWS, brondef);
			            }
			            else
			            {
			                SendClientMessage(playerid, COLOR_NEWS, "Nie masz przy sobie tyle naboi lub pr�bujesz schowa� wszystkie. Aby schowa� wszystkie naboje kliknij 'Wszystko'");
							format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], PlayerInfo[playerid][pGun9]);
	   						ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
			            	return 1;
			            }
			        }
			        ResetPlayerWeapons(playerid);
					PrzywrocBron(playerid);
		            SchowajBron(playerid);
				}
				else
				{
				    new brondef[512];
				    if(IDBroniZbrojownia[playerid] == 2)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G2]], PlayerInfo[playerid][pGun2]);
				    }
				    if(IDBroniZbrojownia[playerid] == 3)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G3]], PlayerInfo[playerid][pGun3]);
				    }
				    if(IDBroniZbrojownia[playerid] == 4)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G4]], PlayerInfo[playerid][pGun4]);
				    }
				    if(IDBroniZbrojownia[playerid] == 5)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G5]], PlayerInfo[playerid][pGun5]);
				    }
				    if(IDBroniZbrojownia[playerid] == 6)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G6]], PlayerInfo[playerid][pGun6]);
				    }
				    if(IDBroniZbrojownia[playerid] == 7)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G7]], PlayerInfo[playerid][pGun7]);
				    }
				    if(IDBroniZbrojownia[playerid] == 8)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G8]], PlayerInfo[playerid][pGun8]);
				    }
				    if(IDBroniZbrojownia[playerid] == 9)
				    {
				    	format(brondef, sizeof(brondef), "Masz t� sam� bro� przy sobie i w zbrojowni.\nMo�esz schowa� ca�� bro� z nabojami lub schowa� okre�lon� ilo�� naboi.\nJe�eli chcesz schowa� tylko naboje, wpisz ilo�� poni�ej i kliknij 'Naboje'\n\n\nBro�: %s\t\tAmunicja: %d", GunNames[Dom[dom][hS_G9]], PlayerInfo[playerid][pGun9]);
				    }
					ShowPlayerDialogEx(playerid, 8247, DIALOG_STYLE_INPUT, "Chowanie amunicji", brondef, "Wszystko", "Naboje");
				    SendClientMessage(playerid, COLOR_NEWS, "Ilo�� naboi od 1 do 100 000");
				}
			}
		}
		if(dialogid == 495)
		{
		    if(response)
		    {
                new lider = GetPlayerOrg(playerid);
				new stan[256];
				format(stan, sizeof(stan), "{F8F8FF}Stan sejfu:\t\t{008000}%d$", Sejf_Rodziny[lider]);
				new stanmats[128];
				format(stanmats, sizeof(stanmats), "{F8F8FF}Liczba materia��w w sejfie:\t\t{008080}%d", Rodzina_Mats[lider]);
				new stanContraband[128];
				format(stanContraband, sizeof(stanContraband), "{F8F8FF}Liczba kontrabandy w sejfie:\t\t{008080}%d", Rodzina_Contraband[lider]);
		        switch(listitem)
		        {
		            case 0:
		            {
						format(stan, sizeof(stan), "%s\n%s\n%s", stan, stanmats, stanContraband);
		                ShowPlayerDialogEx(playerid, 496, DIALOG_STYLE_TABLIST, "Sejf organizacji - stan konta", stan, "Wr��", "Wr��");
		            }
		            case 1:
						ShowPlayerDialogEx(playerid, 497, DIALOG_STYLE_INPUT, "Sejf organizacji - wyp�acanie got�wki", stan, "Wyp�a�", "Wr��");
		            case 2:
						ShowPlayerDialogEx(playerid, 498, DIALOG_STYLE_INPUT, "Sejf organizacji - wp�acanie got�wki", stan, "Wp�a�", "Wr��");
					case 3:
						ShowPlayerDialogEx(playerid, 5430, DIALOG_STYLE_INPUT, "Sejf organizacji mats - wyci�ganie", stanmats, "Wyp�a�", "Wr��");
					case 4: 
					{
						format(stan, sizeof(stan), "%s\n{F8F8FF}Liczba materia��w kt�re posiadasz:\t\t{008080}%d", stanmats, PlayerInfo[playerid][pMats]);
						ShowPlayerDialogEx(playerid, 5431, DIALOG_STYLE_INPUT, "Sejf organizacji mats - chowanie", stan, "Wp�a�", "Wr��");
					}
					case 5:
						ShowPlayerDialogEx(playerid, 5432, DIALOG_STYLE_INPUT, "Sejf kontrabanda - wyci�ganie", stanContraband, "Wyp�a�", "Wr��");
					case 6:
					{
						format(stanContraband, sizeof(stanContraband), "%s\n{F8F8FF}Liczba kontrabandy kt�r� posiadasz:\t\t{008080}%d", stanContraband, PlayerInfo[playerid][pContraband]);
						ShowPlayerDialogEx(playerid, 5433, DIALOG_STYLE_INPUT, "Sejf kontrabanda - chowanie", stanContraband, "Wyp�a�", "Wr��");
					}
		        }
		    }
		}
		if(dialogid == 496)
		{
			SejfR_Show(playerid);
		}
		if(dialogid == 497)
		{
		    if(response)
		    {
                new kasa = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(kasa > 0 && kasa <= Sejf_Rodziny[lider])
				{
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					SejfR_Add(lider, -kasa);
					PlayerInfo[playerid][pAccount] += kasa;

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Wyp�aci�e� %d$ z sejfu organizacji. Jest w nim teraz %d$. Wyp�acone pieni�dze s� teraz na twoim koncie bankowym.", kasa, Sejf_Rodziny[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s wyp�aci� z sejfu organizacji %s kwot� %d$. Nowy stan: %d$", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						kasa,
						Sejf_Rodziny[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
				else
				{
					SendClientMessage(playerid, COLOR_P@, "W sejfie nie znajduje si� a� tyle");
					new stan[256];
					format(stan, sizeof(stan), "{F8F8FF}Stan sejfu:\t{008000}%d$", Sejf_Rodziny[lider]);
					ShowPlayerDialogEx(playerid, 497, DIALOG_STYLE_INPUT, "Sejf organizacji - wyp�acanie got�wki", stan, "Wyp�a�", "Wr��");
				}
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
		if(dialogid == 498)
		{
		    if(response)
		    {
                new kasa = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(kasa > 0 && kaska[playerid] >= kasa)
				{
					if(Sejf_Rodziny[lider] + kasa > 1_000_000_000)
					{
						SendClientMessage(playerid, -1, "Sejf si� przepe�ni!");
						return 1;
					}
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					ZabierzKase(playerid, kasa);
					SejfR_Add(lider, kasa);

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Wp�aci�e� %d$ do sejfu organizacji. Jest w nim teraz %d$.", kasa, Sejf_Rodziny[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s wp�aci� do sejfu organizacji %s kwot� %d$. Nowy stan: %d$", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						kasa,
						Sejf_Rodziny[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
		        else
		        {
					SendClientMessage(playerid, COLOR_P@, "Niepoprawna ilo��!");
		            new stan[256];
	                format(stan, sizeof(stan), "{F8F8FF}Stan sejfu:\t{008000}%d$", Sejf_Rodziny[lider]);
					ShowPlayerDialogEx(playerid, 498, DIALOG_STYLE_INPUT, "Sejf organizacji - wp�acanie got�wki", stan, "Wp�a�", "Wr��");
		        }
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
		if(dialogid == 5430)
		{
		    if(response)
		    {
                new mats = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(mats > 0 && mats <= Rodzina_Mats[lider])
				{
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					SejfR_AddMats(lider, -mats);
					PlayerInfo[playerid][pMats] += mats;

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Wyp�aci�e� %d mats�w z sejfu organizacji. Jest w nim teraz %d mats.", mats, Rodzina_Mats[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s wyp�aci� z sejfu organizacji %s %d mats. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						mats,
						Rodzina_Mats[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
				else
				{
					SendClientMessage(playerid, COLOR_P@, "W sejfie nie znajduje si� a� tyle");
					new stanmats[128];
					format(stanmats, sizeof(stanmats), "{F8F8FF}Liczba materia��w w sejfie:\t\t{008080}%d", Rodzina_Mats[lider]);
					ShowPlayerDialogEx(playerid, 5430, DIALOG_STYLE_INPUT, "Sejf organizacji mats - wyci�ganie", stanmats, "Wyp�a�", "Wr��");
				}
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
		if(dialogid == 5431)
		{
		    if(response)
		    {
                new mats = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(mats > 0 && PlayerInfo[playerid][pMats] >= mats)
				{
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					PlayerInfo[playerid][pMats] -= mats;
					SejfR_AddMats(lider, mats);

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Wp�aci�e� %d mats do sejfu organizacji. Jest w nim teraz %d mats.", mats, Rodzina_Mats[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s wp�aci� do sejfu organizacji %s %d mats. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						mats,
						Rodzina_Mats[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
		        else
		        {
		            SendClientMessage(playerid, COLOR_P@, "Niepoprawna ilo��!");
					new stanmats[256];
					format(stanmats, sizeof(stanmats), "{F8F8FF}Liczba materia��w w sejfie:\t\t{008080}%d\n{F8F8FF}Liczba materia��w kt�re posiadasz:\t\t{008080}%d", Rodzina_Mats[lider], PlayerInfo[playerid][pMats]);
					ShowPlayerDialogEx(playerid, 5431, DIALOG_STYLE_INPUT, "Sejf organizacji mats - chowanie", stanmats, "Wyp�a�", "Wr��");
		        }
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
		if(dialogid == 5432)
		{
		    if(response)
		    {
                new contraband = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(contraband > 0 && contraband <= Rodzina_Contraband[lider])
				{
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					SejfR_AddContraband(lider, -contraband);
					PlayerInfo[playerid][pContraband] += contraband;

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Wyci�gn��e� %d kontrabandy z sejfu organizacji. Jest w nim teraz %d kontrabandy.", contraband, Rodzina_Contraband[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s wyci�gn�� z sejfu organizacji %s %d kontrabandy. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						contraband,
						Rodzina_Contraband[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
				else
				{
					SendClientMessage(playerid, COLOR_P@, "W sejfie nie znajduje si� a� tyle");
					new string[128];
					format(string, sizeof(string), "{F8F8FF}Liczba kontrabandy w sejfie:\t\t{008080}%d", Rodzina_Contraband[lider]);
					ShowPlayerDialogEx(playerid, 5432, DIALOG_STYLE_INPUT, "Sejf kontrabandy - wyci�ganie", string, "Wyp�a�", "Wr��");
				}
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
		if(dialogid == 5433)
		{
		    if(response)
		    {
                new contraband = FunkcjaK(inputtext);
                new lider = GetPlayerOrg(playerid);
				if(contraband > 0 && PlayerInfo[playerid][pContraband] >= contraband)
				{
					new nick[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nick, sizeof(nick));

					PlayerInfo[playerid][pContraband] -= contraband;
					SejfR_AddContraband(lider, contraband);

					new komunikat[256];
					format(komunikat, sizeof(komunikat), "Schowa�e� %d kontrabandy do sejfu organizacji. Jest w nim teraz %d kontrabandy.", contraband, Rodzina_Contraband[lider]);
					SendClientMessage(playerid, COLOR_P@, komunikat);
					Log(payLog, INFO, "%s schowa� do sejfu organizacji %s %d kontrabandy. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetOrgLogName(lider),
						contraband,
						Rodzina_Contraband[lider]);
					SejfR_Save(lider);
					SejfR_Show(playerid);
				}
		        else
		        {
		            SendClientMessage(playerid, COLOR_P@, "Niepoprawna ilo��!");
					new string[256];
					format(string, sizeof(string), "{F8F8FF}Liczba kontrabandy w sejfie:\t\t{008080}%d\n{F8F8FF}Liczba kontrabandy, kt�r� posiadasz:\t\t{008080}%d", Rodzina_Contraband[lider], PlayerInfo[playerid][pContraband]);
					ShowPlayerDialogEx(playerid, 5433, DIALOG_STYLE_INPUT, "Sejf organizacji mats - chowanie", string, "Wyp�a�", "Wr��");
		        }
		    }
		    else
		    {
		        SejfR_Show(playerid);
		    }
		}
        if(dialogid == 666)
		{
		    if(response)
		    {
		        new veh = GetPlayerVehicleID(playerid);
		        new dont_override = false;
		        new engine,lights,alarm,doors,bonnet,boot,objective;
		        GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);

		        new komunikat[256];

                if(strfind(inputtext, "�wiat�a") != -1)
                {
                    if(lights == VEHICLE_PARAMS_ON)
					{
						SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
					}
					else
					{
						SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
					}
                }
                else if(strfind(inputtext, "Maska") != -1)
                {
                    if(bonnet == VEHICLE_PARAMS_ON)
					{
						SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
					}
					else
					{
						SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
					}
                }
                else if(strfind(inputtext, "Baga�nik") != -1)
                {
                    if(boot == VEHICLE_PARAMS_ON)
			 		{
						SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
					}
					else
					{
						SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
					}
                }
                else if(strfind(inputtext, "CB-Radio") != -1)
                {
                    if(!cbradijo[playerid])
                	{
                		cbradijo[playerid] = 1;
                		SendClientMessage(playerid, COLOR_WHITE, "   CB-radio wy��czone !");
                	}
                	else
                	{
                		cbradijo[playerid] = 0;
                		SendClientMessage(playerid,0xff00ff, "   CB-radio w��czone !");
                	}
                }
                else if(strfind(inputtext, "Neony") != -1)
                {
                    new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
				    if(VehicleUID[veh][vNeon])
					{
						DestroyDynamicObject(VehicleUID[veh][vNeonObject][0]);
			     		DestroyDynamicObject(VehicleUID[veh][vNeonObject][1]);
				        VehicleUID[veh][vNeon] = false;
				        format(komunikat, sizeof(komunikat), "* %s naciska przycisk i gasi neony.", sendername);
						ProxDetector(30.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    }
				    else
				    {
						if(IsPlayerPremiumOld(playerid))
			            {
							VehicleUID[veh][vNeonObject][0] = CreateDynamicObject(CarData[VehicleUID[veh][vUID]][c_Neon], 0.0,0.0,0.0, 0, 0, 0);
                            AttachDynamicObjectToVehicle(VehicleUID[veh][vNeonObject][0], veh, -0.8, 0.0, -0.5, 0.0, 0.0, 0.0);
				       		VehicleUID[veh][vNeonObject][1] = CreateDynamicObject(CarData[VehicleUID[veh][vUID]][c_Neon], 0.0,0.0,0.0, 0, 0, 0);
                            AttachDynamicObjectToVehicle(VehicleUID[veh][vNeonObject][1], veh, 0.8, 0.0, -0.5, 0.0, 0.0, 0.0);
						}
						else
						{
							VehicleUID[veh][vNeonObject][0] = CreateDynamicObject(18652, 0.0,0.0,0.0, 0, 0, 0);
                            AttachDynamicObjectToVehicle(VehicleUID[veh][vNeonObject][0], veh, -0.8, 0.0, -0.5, 0.0, 0.0, 0.0);
				       		VehicleUID[veh][vNeonObject][1] = CreateDynamicObject(18652, 0.0,0.0,0.0, 0, 0, 0);
                            AttachDynamicObjectToVehicle(VehicleUID[veh][vNeonObject][1], veh, 0.8, 0.0, -0.5, 0.0, 0.0, 0.0);
						}
                        VehicleUID[veh][vNeon] = true;
                        format(komunikat, sizeof(komunikat), "* %s naciska przycisk i w��cza neony.", sendername);
						ProxDetector(30.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    }
                }
				else if(strfind(inputtext, "Mrucznik Radio") != -1)
                {
					if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						foreach(new i : Player)
						{
							if(IsPlayerInVehicle(i, veh))
							{
								PlayAudioStreamForPlayer(i, "http://4stream.pl:18434");
								SetPVarInt(i, "sanlisten", 3);
							}
						}
					}
                }
				else if(strfind(inputtext, "Vice City Radio") != -1)
                {
                    if(!response) return 1;
                    dont_override = true;
                    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
					{
						ShowViceCityRadioDialog(playerid, 671, "Radio Vice City");
					}
                }
                else if(strfind(inputtext, "Radio SAN1") != -1)
                {
                    if(RadioSANUno[0] != EOF)
                    {
                        if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                        {
                            //new veh;
							veh = GetPlayerVehicleID(playerid);

                            foreach(new i : Player)
                            {
                                if(IsPlayerInVehicle(i, veh))
                                {
                                    PlayAudioStreamForPlayer(i, RadioSANUno);
                                    SetPVarInt(i, "sanlisten", 1);
                                }
                            }
                        }
                    }
                }
                else if(strfind(inputtext, "Radio SAN2") != -1)
                {
                    if(RadioSANDos[0] != EOF)
                    {
                        if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                        {
                            foreach(new i : Player)
                            {
                                if(IsPlayerInVehicle(i, veh))
                                {
                                    PlayAudioStreamForPlayer(i, RadioSANDos);
                                    SetPVarInt(i, "sanlisten", 2);
                                }
                            }
                        }
                    }
                }
				else if(strfind(inputtext, "Lepa Station") != -1)
                {
                    if(RadioSANDos[0] != EOF)
                    {
                        if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                        {
                            foreach(new i : Player)
                            {
                                if(IsPlayerInVehicle(i, veh))
                                {
                                    PlayAudioStreamForPlayer(i, "http://4stream.pl:18214/");
                                    SetPVarInt(i, "sanlisten", 2);
                                }
                            }
                        }
                    }
                }
                else if(strfind(inputtext, "Wlasny Stream") != -1)
                {
                    if(!response) return 1;
                    dont_override = true;
                    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
                    	ShowPlayerDialogEx(playerid, 670, DIALOG_STYLE_INPUT, "W�asny stream", "Wklej poni�ej link do streama", "Start", "Wr��");
                    }
                }
                else if(strfind(inputtext, "Wy��cz radio") != -1)
                {
                    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                    {
                        foreach(new i : Player)
                        {
                            if(IsPlayerInVehicle(i, veh))
                            {
                                StopAudioStreamForPlayer(i);
                                SetPVarInt(i, "sanlisten", 0);
                            }
                        }
						DisableVehicleRadio(veh);
                    }
                }
                //
			    new taknieL[64];
			    new taknieBON[64];
			    new taknieBOT[64];
			    GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
                if(lights == 1) format(taknieL, sizeof(taknieL), "Wy��cz");
				else format(taknieL, sizeof(taknieL), "W��cz");
				if(bonnet == 1) format(taknieBON, sizeof(taknieBON), "Zamknij");
				else format(taknieBON, sizeof(taknieBON), "Otw�rz");
				if(boot == 1) format(taknieBOT, sizeof(taknieBOT), "Zamknij");
				else format(taknieBOT, sizeof(taknieBOT), "Otw�rz");
                //
                format(komunikat, sizeof(komunikat), "�wiat�a (%s)\nMaska (%s)\nBaga�nik (%s)", taknieL, taknieBON, taknieBOT);
                //
                if(PlayerInfo[playerid][pCB])
                {
                    new cbr[16];
                    if(cbradijo[playerid]) format(cbr, 16, "W��cz");
                    else format(cbr, 16, "Wy��cz");
                    format(komunikat, sizeof(komunikat), "%s\nCB-Radio (%s)", komunikat, cbr);
                }
                if(CarData[VehicleUID[veh][vUID]][c_Neon] != 0 || veh >= 475 && veh <= 483)
				{
				    new taknieNeo[16];
					if(VehicleUID[veh][vNeon]) format(taknieNeo, sizeof(taknieNeo), "Wy��cz");
					else format(taknieNeo, sizeof(taknieNeo), "W��cz");
                    format(komunikat, sizeof(komunikat), "%s\nNeony (%s)", komunikat, taknieNeo);
				}
                format(komunikat, sizeof(komunikat), "%s\nMrucznik Radio\nVice City Radio\nRadio SAN1\nRadio SAN2\nLepa Station\nWlasny Stream\nWy��cz radio", komunikat); //+ 35char
                if(!dont_override) ShowPlayerDialogEx(playerid, 666, DIALOG_STYLE_LIST, "Deska rozdzielcza", komunikat, "Wybierz", "Anuluj");
		    }
		}
		else if(dialogid == 670) 
		{
			if(response)
			{
				if (ValidateURLAndNotify(playerid, inputtext)) return 1;
				new veh = GetPlayerVehicleID(playerid);
				//if(IsAValidURL(inputtext))
				//{
				if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
				{
					foreach(new i : Player) 
					{
						if(IsPlayerInVehicle(i, veh)) 
						{
							PlayAudioStreamForPlayer(i, inputtext);
						}
					}
					SetPVarString(playerid, "radioUrl", inputtext);
					SetVehicleRadio(GetPlayerVehicleID(playerid), inputtext);
					SetPVarInt(playerid, "sanlisten", 3);
				}
			}
			return 1;
		}
		else if(dialogid == 671) 
		{
			if(response)
			{
				new veh = GetPlayerVehicleID(playerid);
				if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
				{
					foreach(new i : Player) 
					{
						if(IsPlayerInVehicle(i, veh)) 
						{
							PlayAudioStreamForPlayer(i, GetViceCityRadioStream(listitem));
						}
					}
					SetPVarString(playerid, "radioUrl", GetViceCityRadioStream(listitem));
					SetVehicleRadio(GetPlayerVehicleID(playerid), GetViceCityRadioStream(listitem));
					SetPVarInt(playerid, "sanlisten", 3);
				}
			}
			return 1;
		}
        else if(dialogid == 667)
        {
            if(!response) return 1;
            SetPVarInt(playerid, "sanradio", listitem);
            ShowPlayerDialogEx(playerid, 669, DIALOG_STYLE_LIST, "Wybierz muzyk�", "Mrucznik Radio\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW�asna", "Wybierz", "Anuluj");

        }
        else if(dialogid == 669)
        {
            if(!response) return 1;
            if(GetPVarInt(playerid, "sanradio") == 0)
            {
                switch(listitem)
                {
                    case 0: format(RadioSANUno, sizeof(RadioSANUno), "http://4stream.pl:18434");
                    case 1: format(RadioSANUno, sizeof(RadioSANUno), "http://www.polskastacja.pl/play/aac_discopolo.pls");
                    case 2: format(RadioSANUno, sizeof(RadioSANUno), "http://www.polskastacja.pl/play/aac_dance100.pls");
                    case 3: format(RadioSANUno, sizeof(RadioSANUno), "http://www.polskastacja.pl/play/aac_mnt.pls");
                    case 4: format(RadioSANUno, sizeof(RadioSANUno), "http://www.polskastacja.pl/play/aac_hiphop.pls");
                    case 5: format(RadioSANUno, sizeof(RadioSANUno), "http://www.polskastacja.pl/play/aac_party.pls");
                    case 6: return ShowPlayerDialogEx(playerid, 668, DIALOG_STYLE_INPUT, "Podaj adres URL", "Prosz� wprowadzi� adres URL muzyki dla stacji SAN 01", "Wybierz", "Anuluj");
                }
                foreach(new i : Player)
                {
                    if(IsPlayerInAnyVehicle(i))
                    {
                        if(GetPVarInt(i, "sanlisten") == 1)
                        {
                            PlayAudioStreamForPlayer(i, RadioSANUno);
                        }
                    }
                }
            }
            else //sanradio == 1
            {
                switch(listitem)
                {
                    case 0: format(RadioSANDos, sizeof(RadioSANDos), "http://4stream.pl:18240");
                    case 1: format(RadioSANDos, sizeof(RadioSANDos), "http://www.polskastacja.pl/play/aac_discopolo.pls");
                    case 2: format(RadioSANDos, sizeof(RadioSANDos), "http://www.polskastacja.pl/play/aac_dance100.pls");
                    case 3: format(RadioSANDos, sizeof(RadioSANDos), "http://www.polskastacja.pl/play/aac_mnt.pls");
                    case 4: format(RadioSANDos, sizeof(RadioSANDos), "http://www.polskastacja.pl/play/aac_hiphop.pls");
                    case 5: format(RadioSANDos, sizeof(RadioSANDos), "http://www.polskastacja.pl/play/aac_party.pls");
                    case 6: return ShowPlayerDialogEx(playerid, 668, DIALOG_STYLE_INPUT, "Podaj adres URL", "Prosz� wprowadzi� adres URL muzyki dla stacji SAN 02", "Wybierz", "Anuluj");
                }
                foreach(new i : Player)
                {
                    if(IsPlayerInAnyVehicle(i))
                    {
                        if(GetPVarInt(i, "sanlisten") == 2)
                        {
                            PlayAudioStreamForPlayer(i, RadioSANDos);
                        }
                    }
                }
            }
            SendClientMessage(playerid, COLOR_GRAD2, " Zmieni�e� nadawan� stacj�.");
        }
        if(dialogid == 668)
        {
            if(!response) return 1;
			if (ValidateURLAndNotify(playerid, inputtext)) return 1;
            new radio = GetPVarInt(playerid, "sanradio");
            if(!radio)
            {
                format(RadioSANUno, 128, "%s", inputtext);
                foreach(new i : Player)
                {
                    if(IsPlayerInAnyVehicle(i))
                    {
                        if(GetPVarInt(i, "sanlisten") == 1)
                        {
                            PlayAudioStreamForPlayer(i, RadioSANUno);
                        }
                    }
                }

            }
            else
            {
                format(RadioSANDos, 128, "%s", inputtext);
                foreach(new i : Player)
                {
                    if(IsPlayerInAnyVehicle(i))
                    {
                        if(GetPVarInt(i, "sanlisten") == 2)
                        {
                            PlayAudioStreamForPlayer(i, RadioSANDos);
                        }
                    }
                }
            }
            SendClientMessage(playerid, COLOR_GRAD2, " Zmieni�e� nadawan� stacj�.");
        }
		if(dialogid == 765)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
                    case 0: format(SANrepertuar, sizeof(SANrepertuar), "http://s1.slotex.pl:7170");
                    case 1: format(SANrepertuar, sizeof(SANrepertuar), "http://4stream.pl:18240");
		            case 2: format(SANrepertuar, sizeof(SANrepertuar), "http://www.polskastacja.pl/play/aac_discopolo.pls");
                    case 3: format(SANrepertuar, sizeof(SANrepertuar), "http://www.polskastacja.pl/play/aac_dance100.pls");
                    case 4: format(SANrepertuar, sizeof(SANrepertuar), "http://www.polskastacja.pl/play/aac_mnt.pls");
                    case 5: format(SANrepertuar, sizeof(SANrepertuar), "http://www.polskastacja.pl/play/aac_hiphop.pls");
                    case 6: format(SANrepertuar, sizeof(SANrepertuar), "http://www.polskastacja.pl/play/aac_party.pls");
                    case 7: return ShowPlayerDialogEx(playerid, 767, DIALOG_STYLE_INPUT, "Podaj adres URL", "Prosz� wprowadzi� adres URL do wybranego utworu", "Wybierz", "Anuluj");
		        }
                ShowPlayerDialogEx(playerid, 766, DIALOG_STYLE_LIST, "Wybierz zasi�g", "Bardzo ma�y zasi�g\nMa�y zasi�g\n�redni zasi�g\nDu�y zasi�g", "Wybierz", "Anuluj");
		    }
		}
        if(dialogid == 766)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0: SANzasieg = 10.0;
                    case 1: SANzasieg = 20.0;
                    case 2: SANzasieg = 35.0;
                    case 3: SANzasieg = 50.0;
				}
                new Float:x1,Float:y1,Float:z1, Float:a1, nick[MAX_PLAYER_NAME], string[256];
				GetPlayerPos(playerid,x1,y1,z1);
				GetPlayerFacingAngle(playerid, a1);
				GetPlayerName(playerid, nick, sizeof(nick));
				SANradio = CreateDynamicObject(2232, x1, y1, z1-0.3, 0, 0, a1-180);
				SANx = x1;
				SANy = y1;
				SANz = z1;
                SAN3d = CreateDynamic3DTextLabel("G�o�nik SAN", COLOR_NEWS, x1, y1, z1+0.5, 10.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
				format(string, sizeof(string), "* %s stawia g�o�nik na ziemi i w��cza.", nick);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SendClientMessage(playerid, COLOR_NEWS, "Ustawi�e� g�o�nik SAN. Aby go wy��czy� wpisz /glosnik");
                //
                foreach(new i : Player)
                {
                    if(IsPlayerConnected(i))
                    {
                        if(!GetPVarInt(i, "sanaudio") && !GetPVarInt(i, "HaveAMp3Stream"))
                        {
                            if(PlayerToPoint(SANzasieg, i, SANx, SANy, SANz))
                            {
                                PlayAudioStreamForPlayer(i, SANrepertuar, SANx, SANy, SANz, SANzasieg, 1);
                                SetPVarInt(i, "sanaudio", 1);
                            }
                        }
                    }
                }
                //
			}
		}
		else if(dialogid == 767)
        {
            if(!response) return 1;
			if (ValidateURLAndNotify(playerid, inputtext)) return 1;
            format(SANrepertuar, 128, inputtext);
            ShowPlayerDialogEx(playerid, 766, DIALOG_STYLE_LIST, "Wybierz zasi�g", "Bardzo ma�y zasi�g\nMa�y zasi�g\n�redni zasi�g\nDu�y zasi�g", "Wybierz", "Anuluj");
        }
		else if(dialogid == 768)
		{
			if(response)
		    {
		        switch(listitem)
		        {
                    case 0: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://s1.slotex.pl:7170");
                    case 1: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://4stream.pl:18240");
		            case 2: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://www.polskastacja.pl/play/aac_discopolo.pls");
                    case 3: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://www.polskastacja.pl/play/aac_dance100.pls");
                    case 4: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://www.polskastacja.pl/play/aac_mnt.pls");
                    case 5: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://www.polskastacja.pl/play/aac_hiphop.pls");
                    case 6: format(KLUBOWErepertuar, sizeof(KLUBOWErepertuar), "http://www.polskastacja.pl/play/aac_party.pls");
                    case 7: return ShowPlayerDialogEx(playerid, 770, DIALOG_STYLE_INPUT, "Podaj adres URL", "Prosz� wprowadzi� adres URL do wybranego utworu", "Wybierz", "Anuluj");
		        }
                ShowPlayerDialogEx(playerid, 769, DIALOG_STYLE_LIST, "Wybierz zasi�g", "Bardzo ma�y zasi�g\nMa�y zasi�g\n�redni zasi�g\nDu�y zasi�g", "Wybierz", "Anuluj");
		    }
		}
		else if(dialogid == 770)
        {
            if(!response) return 1;
			if (ValidateURLAndNotify(playerid, inputtext)) return 1;
            format(KLUBOWErepertuar, 128, inputtext);
            ShowPlayerDialogEx(playerid, 769, DIALOG_STYLE_LIST, "Wybierz zasi�g", "Bardzo ma�y zasi�g\nMa�y zasi�g\n�redni zasi�g\nDu�y zasi�g", "Wybierz", "Anuluj");
        }
		if(dialogid == 769)
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0: KLUBOWEzasieg = 10.0;
                    case 1: KLUBOWEzasieg = 20.0;
                    case 2: KLUBOWEzasieg = 35.0;
                    case 3: KLUBOWEzasieg = 50.0;
				}
                new Float:x1,Float:y1,Float:z1, Float:a1, nick[MAX_PLAYER_NAME], string[256];
				GetPlayerPos(playerid,x1,y1,z1);
				GetPlayerFacingAngle(playerid, a1);
				GetPlayerName(playerid, nick, sizeof(nick));
				KLUBOWEradio = CreateDynamicObject(2232, x1, y1, z1-0.3, 0, 0, a1-180);
				KLUBOWEx = x1;
				KLUBOWEy = y1;
				KLUBOWEz = z1;
                KLUBOWE3d = CreateDynamic3DTextLabel("G�o�nik Klubowy", COLOR_NEWS, x1, y1, z1+0.5, 10.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
				format(string, sizeof(string), "* %s stawia g�o�nik na ziemi i w��cza.", nick);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SendClientMessage(playerid, COLOR_NEWS, "Ustawi�e� g�o�nik klubowy. Aby go wy��czy� wpisz /glosnik");
                //
                foreach(new i : Player)
                {
                    if(IsPlayerConnected(i))
                    {
                        if(!GetPVarInt(i, "kluboweaudio") && !GetPVarInt(i, "HaveAMp3Stream"))
                        {
                            if(PlayerToPoint(KLUBOWEzasieg, i, KLUBOWEx, KLUBOWEy, KLUBOWEz))
                            {
                                PlayAudioStreamForPlayer(i, KLUBOWErepertuar, KLUBOWEx, KLUBOWEy, KLUBOWEz, KLUBOWEzasieg, 1);
                                SetPVarInt(i, "kluboweaudio", 1);
                            }
                        }
                    }
                }
                //
			}
		}
        else if(dialogid == 1401)
		{
			new string[256];
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://Bia�y
		            {
						format(string, sizeof(string), "Bia�e neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_WHITE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18652;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 1://��ty
		            {
						format(string, sizeof(string), "��te neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, 0xDAA520FF, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18650;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 2://Zielony
		            {
						format(string, sizeof(string), "Zielone neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18649;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 3://Niebieski
		            {

						format(string, sizeof(string), "Niebieskie neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18648;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 4://Czerwony
		            {

						format(string, sizeof(string), "Czerwone neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_RED, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18647;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);

		            }
		            case 5://R�owy
		            {
						format(string, sizeof(string), "R�owe neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_PURPLE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18651;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		        }
		    }
			else
			{
				format(string, sizeof(string), "Bia�e neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				CarData[IloscAut[playerid]][c_Neon] = 18652;
				PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
			}
			Car_Save(IloscAut[playerid], CAR_SAVE_TUNE);
			return 1;
		}
		else if(dialogid == 1403)
		{
		    if(response)
		    {
				new string[128];
		        switch(listitem)
		        {
					
		            case 0:
		            {
						if(kaska[playerid] >= onePoolPrice)
						{
							format(string, sizeof(string), "Pani Janina m�wi: Oto pakiet 100 kredyt�w za jedyne %d$.", onePoolPrice);
							SendClientMessage(playerid, COLOR_WHITE, string);
							Kredyty[playerid] += 100;
							ZabierzKase(playerid, onePoolPrice);
							SejfR_Add(43, onePoolPrice);
							SejfR_Save(43);
							poolCashStats = poolCashStats+onePoolPrice;
							poolCreditStatus = poolCreditStatus+100;
						}
						else
						{
							sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
							return 1;
						}
		            }
		            case 1:
		            {
						if(kaska[playerid] >= twoPoolPrice)
						{
							format(string, sizeof(string), "Pani Janina m�wi: Oto pakiet 200 kredyt�w za jedyne %d$.", twoPoolPrice);
							SendClientMessage(playerid, COLOR_WHITE, string);
							Kredyty[playerid] += 200;
							ZabierzKase(playerid, twoPoolPrice); 
							SejfR_Add(43, twoPoolPrice);
							SejfR_Save(43);
							poolCreditStatus = poolCreditStatus+200;
							poolCashStats = poolCashStats+twoPoolPrice;
						}
						else
						{
							sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
							return 1;
						}
		            }
		            case 2://Zielony
		            {
						if(kaska[playerid] >= threePoolPrice)
						{
							format(string, sizeof(string), "Pani Janina m�wi: Oto pakiet 500 kredyt�w za jedyne %d$.", threePoolPrice);
							SendClientMessage(playerid, COLOR_WHITE, string);
							Kredyty[playerid] += 500;
							ZabierzKase(playerid, threePoolPrice);
							SejfR_Add(43, threePoolPrice);
							SejfR_Save(43);
							poolCreditStatus = poolCreditStatus+500;
							poolCashStats = poolCashStats+threePoolPrice;
						}
						else
						{
							sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
							return 1;
						}
		            }
		            case 3://Niebieski
		            {
						if(kaska[playerid] >= fourPoolPrice)
						{
							format(string, sizeof(string), "Pani Janina m�wi: Oto pakiet 1000 kredyt�w za jedyne %d$.", fourPoolPrice);
							SendClientMessage(playerid, COLOR_WHITE, string);
							Kredyty[playerid] += 1000;
							ZabierzKase(playerid, fourPoolPrice);
							SejfR_Add(43, fourPoolPrice);
							SejfR_Save(43);
							poolCreditStatus = poolCreditStatus+1000;
							poolCashStats = poolCashStats+fourPoolPrice;
						}
						else
						{
							sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
							return 1;
						}
		            }
		        }
				return 1;
		    }
		}
		else if(dialogid == 1093)//panel lidera basenu
		{
			if(response)
			{
				new string[128];
				switch(listitem)
				{
					case 0://Otw�rz/zamknij basen
					{
						if(poolStatus == 0)
						{
							poolStatus = 1;
							sendTipMessage(playerid, "Otworzy�e� basen Tsunami");
							format(string, sizeof(string), "%s otworzy� basen.", GetNick(playerid));
							SendOrgMessage(43, TEAM_BLUE_COLOR, string);
						}
						else
						{
							poolStatus = 0;
							sendTipMessage(playerid, "Zamkn��e� basen Tsunami");
							format(string, sizeof(string), "%s zamkn�� basen - Koniec p�ywania!", GetNick(playerid));
							SendOrgMessage(43, TEAM_BLUE_COLOR, string);
						
						}
					}
					case 1://Zmie� cen� kredytu
					{
						ShowPlayerDialogEx(playerid, 1096, DIALOG_STYLE_LIST, "Mrucznik Role Play - Basen Tsunami", "1. Dzieci�cy\n2. Podstawowy\n3.Zaawansowany\n4.Premium", "Akceptuj", "Wr��"); 
					}
					case 2://Ustal muzyk�
					{
						sendTipMessage(playerid, "Ju� nied�ugo!"); 
					}
					case 3://Wy�lij wiadomo��
					{
						format(string, sizeof(string), "%s u�y� komunikatu basenu", GetNickEx(playerid));
						SendAdminMessage(COLOR_RED, string); //Wiadomo�� dla @
						SendClientMessageToAll(COLOR_WHITE, "|___________ Basen Tsunami ___________|");
						format(string, sizeof(string), "Plusk Plusk - Basen Tsunami otwarty! Zapraszamy do najlepszego obiektu rekreacyjnego w mie�cie!");
						SendClientMessageToAll(COLOR_BLUE, string);
					}
				}
				return 1;
			}
		}
		else if(dialogid == 1095)//pusty dialog basenu - statystyk
		{
			if(response)
			{
				sendTipMessage(playerid, "Nie za dobrze wygl�daj� te statystki! Popraw je!");
				return 1;
			}
		}
		else if(dialogid == 1096)
		{
			if(response)
			{
				new string[128];
				switch(listitem)
				{
					case 0:
					{
						format(string, sizeof(string), "{C0C0C0}Wpisz poni�ej now� kwot� dla pakietu {00FFFF}dzieci�cego\n{C0C0C0}Aktualna cena to: {37AC45}%d$", onePoolPrice);
						ShowPlayerDialogEx(playerid, 1097, DIALOG_STYLE_INPUT, "Mrucznik Role Play - Basen Tsunami", string, "Akceptuj", "Odrzu�"); 
						SetPVarInt(playerid, "wyborPoziomuKredytow", 1);
					}
					case 1:
					{	
						format(string, sizeof(string), "{C0C0C0}Wpisz poni�ej now� kwot� dla pakietu {00FFFF}dzieci�cego\n{C0C0C0}Aktualna cena to: {37AC45}%d$", twoPoolPrice);
						ShowPlayerDialogEx(playerid, 1097, DIALOG_STYLE_INPUT, "Mrucznik Role Play - Basen Tsunami", string, "Akceptuj", "Odrzu�"); 
						SetPVarInt(playerid, "wyborPoziomuKredytow", 2);
					}
					case 2:
					{
						format(string, sizeof(string), "{C0C0C0}Wpisz poni�ej now� kwot� dla pakietu {00FFFF}dzieci�cego\n{C0C0C0}Aktualna cena to: {37AC45}%d$", threePoolPrice);
						ShowPlayerDialogEx(playerid, 1097, DIALOG_STYLE_INPUT, "Mrucznik Role Play - Basen Tsunami", string, "Akceptuj", "Odrzu�"); 
						SetPVarInt(playerid, "wyborPoziomuKredytow", 3);
					}
					case 3:
					{
						
						format(string, sizeof(string), "{C0C0C0}Wpisz poni�ej now� kwot� dla pakietu {00FFFF}dzieci�cego\n{C0C0C0}Aktualna cena to: {37AC45}%d$", fourPoolPrice);
						ShowPlayerDialogEx(playerid, 1097, DIALOG_STYLE_INPUT, "Mrucznik Role Play - Basen Tsunami", string, "Akceptuj", "Odrzu�"); 
						SetPVarInt(playerid, "wyborPoziomuKredytow", 4);
					}
				}
				return 1;
			}
		}
		else if(dialogid == 1097)
		{
			if(response)
			{
				new pricePool = FunkcjaK(inputtext);
				if(GetPVarInt(playerid, "wyborPoziomuKredytow") == 1)
				{
					if(pricePool <= 300000)
					{
						if(pricePool > 1)
						{
							onePoolPrice = pricePool;
							sendTipMessage(playerid, "Ustali�e� now� cen�!");
						}
						else
						{
							sendErrorMessage(playerid, "Cena musi by� wi�ksza ni� 1 dolar!"); 
							return 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "Przekroczy�e� maksymaln� kwot�!"); 
					}
					return 1;
				
				}
				if(GetPVarInt(playerid, "wyborPoziomuKredytow") == 2)
				{
					if(pricePool <= 450000)
					{
						if(pricePool > 1)
						{
							twoPoolPrice = pricePool;
							sendTipMessage(playerid, "Ustali�e� now� cen�!");
						}
						else
						{
							sendErrorMessage(playerid, "Kwota musi by� wi�ksza ni� 1 dolar!");
							return 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "Przekroczy�e� maksymaln� kwot�!"); 
					}
					return 1;
				}
				if(GetPVarInt(playerid, "wyborPoziomuKredytow") == 3)
				{
					if(pricePool <= 600000)
					{
						if(pricePool > 1)
						{
							threePoolPrice = pricePool;
							sendTipMessage(playerid, "Ustali�e� now� cen�!");
						}
						else
						{
							sendErrorMessage(playerid, "Kwota musi by� wi�ksza ni� 1 dolar!"); 
							return 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "Przekroczy�e� maksymaln� kwot�!"); 
					}		
					return 1;
				}
				if(GetPVarInt(playerid, "wyborPoziomuKredytow") == 4)
				{
					if(pricePool <= 1000000)
					{
						if(pricePool > 1)
						{
							fourPoolPrice = pricePool;
							sendTipMessage(playerid, "Ustali�e� now� cen�!");
						}
						else
						{
							sendErrorMessage(playerid, "Kwota musi by� wi�ksza ni� 1 dolar!"); 
							return 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "Przekroczy�es maksymaln� kwot�!"); 
					}
					return 1;
				}
			}
		
		}
		else if(dialogid == 1402)//rupxnup
		{
            if(response || !response)
		    {
		        new string[256];
		        switch(listitem)
		        {
		            case 0://Bia�y
		            {
						format(string, sizeof(string), "Bia�e neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_WHITE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18652;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 1://��ty
		            {
						format(string, sizeof(string), "��te neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, 0xDAA520FF, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18650;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 2://Zielony
		            {
						format(string, sizeof(string), "Zielone neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18649;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 3://Niebieski
		            {

						format(string, sizeof(string), "Niebieskie neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18648;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 4://Czerwony
		            {

						format(string, sizeof(string), "Czerwone neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_RED, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18647;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		            case 5://R�owy
		            {
						format(string, sizeof(string), "R�owe neony zosta�y zamontowane w twoim %s. Aby je w��czy� wpisz /dr", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
						SendClientMessage(playerid, COLOR_PURPLE, string);
                        CarData[IloscAut[playerid]][c_Neon] = 18651;
                        PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
		            }
		        }
                Car_Save(IloscAut[playerid], CAR_SAVE_TUNE);
		    }
		}
		else if(dialogid == 1410)//Panel tras
		{
		    if(response)
		    {
				new string[256];
		        switch(listitem)
				{
				    case 0://Poka� trasy
				    {
						ShowPlayerDialogEx(playerid, 1411, DIALOG_STYLE_LIST, "Wszystkie trasy:", ListaWyscigow(), "Wi�cej", "Wyjd�");
				    }
				    case 1://Zorganizuj wy�cig
				    {
						new ow = IsAWyscigOrganizowany();
						if(ow == -1)
						{
							if(Scigamy == 666)
							{
								ShowPlayerDialogEx(playerid, 1412, DIALOG_STYLE_LIST, "Organizowanie wy�cigu. Dost�pne trasy:", ListaWyscigow(), "Zorganizuj", "Wr��");
							}
							else
							{
								format(string, sizeof(string), "Obecnie wy�cig %s jest zorganizowany. Poczekaj a� si� sko�czy.", Wyscig[Scigamy][wNazwa]);
								SendClientMessage(playerid, COLOR_GREY, string);
							}
						}
						else
						{
							format(string, sizeof(string), "Gracz %s organizuje wy�cig. Poczekaj a� sko�czy.", GetNick(ow));
							SendClientMessage(playerid, COLOR_GREY, string);
						}
				    }
				    case 2://Edytuj tras�
				    {
						new ow = IsAWyscigOrganizowany();
						if(ow == -1)
						{
							if(Scigamy == 666)
							{
								ShowPlayerDialogEx(playerid, 1413, DIALOG_STYLE_LIST, "Edytowanie. Dost�pne trasy:", ListaWyscigow(), "Edytuj", "Wr��");
							}
							else
							{
								format(string, sizeof(string), "Obecnie wy�cig %s jest zorganizowany. Poczekaj a� si� sko�czy.", Wyscig[Scigamy][wNazwa]);
								SendClientMessage(playerid, COLOR_GREY, string);
							}
						}
						else
						{
							format(string, sizeof(string), "Gracz %s organizuje wy�cig. Poczekaj a� sko�czy.", GetNick(ow));
							SendClientMessage(playerid, COLOR_GREY, string);
						}
				    }
				    case 3://Usu� tras�
				    {
						new ow = IsAWyscigOrganizowany();
						if(ow == -1)
						{
							if(Scigamy == 666)
							{
								ShowPlayerDialogEx(playerid, 1414, DIALOG_STYLE_LIST, "Usuwanie. Dost�pne trasy:", ListaWyscigow(), "Usu�", "Wr��");
							}
							else
							{
								format(string, sizeof(string), "Obecnie wy�cig %s jest zorganizowany. Poczekaj a� si� sko�czy.", Wyscig[Scigamy][wNazwa]);
								SendClientMessage(playerid, COLOR_GREY, string);
							}
						}
						else
						{
							format(string, sizeof(string), "Gracz %s organizuje wy�cig. Poczekaj a� sko�czy.", GetNick(ow));
							SendClientMessage(playerid, COLOR_GREY, string);
						}
				    }
				}
				return 1;
		    }
		}
		if(dialogid == 1411)//Poka� trasy. Wi�cej informacji
		{
			if(response)
			{
			    if(Wyscig[listitem][wStworzony] == 1)
			    {
				    new komunikat[1024];
					new wklej[256];
					if(Wyscig[listitem][wTypCH] == 0)
					{
						strcat(wklej, "{7CFC00}Typ checkpoint�w:{FFFFFF} Normalne\n");
					}
					else
					{
	    				strcat(wklej, "{7CFC00}Typ checkpoint�w:{FFFFFF} Ko�a\n");
					}
					if(Wyscig[listitem][wRozmiarCH] == 10.0)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Ogromne\n");
					}
					else if(Wyscig[listitem][wRozmiarCH] == 7.5)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Du�e\n");
					}
					else if(Wyscig[listitem][wRozmiarCH] == 5)
					{
	    				strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} �rednie\n");
					}
					else if(Wyscig[listitem][wRozmiarCH] == 2.5)
					{
						strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Ma�e\n");
					}
					else if(Wyscig[listitem][wRozmiarCH] == 1)
					{
	    				strcat(wklej, "{7CFC00}Rozmiar checkpoint�w:{FFFFFF} Mini\n");
					}
	   				format(komunikat, sizeof(komunikat), "{7CFC00}Nazwa:{FFFFFF} %s\n{7CFC00}Opis:{FFFFFF} %s\n{7CFC00}Nagroda:{FFFFFF} %d$\n%s\n{7CFC00}Ilo�� checkpoint�w:{FFFFFF} %d\n{7CFC00}Rekord toru:{FFFFFF} %s - %d:%d", Wyscig[listitem][wNazwa], Wyscig[listitem][wOpis], Wyscig[listitem][wNagroda], wklej, Wyscig[listitem][wCheckpointy]+1, Wyscig[listitem][wRekordNick], Wyscig[listitem][wRekordCzas]);
	    			ShowPlayerDialogEx(playerid, 1415, DIALOG_STYLE_MSGBOX, "{7CFC00}Informacje o wy�cigu{FFFFFF}", komunikat, "Wr��", "");
	    		}
	    		else
	    		{
					SendClientMessage(playerid, COLOR_GREY, "Ta trasa nie zosta�a jeszcze stworzona!");
					ShowPlayerDialogEx(playerid, 1411, DIALOG_STYLE_LIST, "Wszystkie trasy:", ListaWyscigow(), "Wi�cej", "Wyjd�");
	    		}
				return 1;
			}
			if(!response)
			{
				if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
 				{
 				    if(PlayerInfo[playerid][pRank] >= 4)
 				    {
						ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
					}
					else
					{
					    ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig", "Wybierz", "Anuluj");
					}
 				}
				return 1;
			}
		}
		if(dialogid == 1412)//organizuj wy�cig
		{
		    if(response)
		    {
		        if(Wyscig[listitem][wStworzony] == 1)
			    {
			        new naglowek[64];
					format(naglowek, sizeof(naglowek), "Organizacja wy�cigu '%s'", Wyscig[listitem][wNazwa]);
		       		new komunikat[256];
		       		format(komunikat, sizeof(komunikat), "Aby zorganizowa� ten wyscig musisz ponie�� koszty:\nNagroda dla wygranego: {FF0000}%d${B0C4DE}\nKoszt postawienia checkpoint�w: {FF0000}%d${B0C4DE}\nRazem: {FF0000}%d${B0C4DE}\nJe�eli chcesz kontynuowa�, wci�nij \"Dalej\"", Wyscig[listitem][wNagroda], (Wyscig[listitem][wCheckpointy]+1)*2000, Wyscig[listitem][wNagroda]+((Wyscig[listitem][wCheckpointy]+1)*2000));
			        ShowPlayerDialogEx(playerid, 1416, DIALOG_STYLE_MSGBOX, naglowek, komunikat, "Dalej", "Wr��");
			        tworzenietrasy[playerid] = listitem;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "Ta trasa nie zosta�a jeszcze stworzona!");
					ShowPlayerDialogEx(playerid, 1412, DIALOG_STYLE_LIST, "Organizowanie wy�cigu. Dost�pne trasy:", ListaWyscigow(), "Zorganizuj", "Wr��");
				}
				return 1;
		    }
		    if(!response)
		    {
		        if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
 				{
 				    if(PlayerInfo[playerid][pRank] >= 4)
 				    {
						ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
					}
					else
					{
					    ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig", "Wybierz", "Anuluj");
					}
 				}
				return 1;
		    }
		}
		if(dialogid == 1413)//edytuj trase
		{
		    if(response)
		    {
		        if(Wyscig[listitem][wStworzony] == 1)
			    {
			        ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
			        tworzenietrasy[playerid] = listitem;
                }
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "Ta trasa nie zosta�a jeszcze stworzona!");
					ShowPlayerDialogEx(playerid, 1413, DIALOG_STYLE_LIST, "Edytowanie. Dost�pne trasy:", ListaWyscigow(), "Edytuj", "Wr��");
				}
				return 1;
			}
			if(!response)
		    {
                if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
 				{
 				    if(PlayerInfo[playerid][pRank] >= 4)
 				    {
						ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
					}
					else
					{
					    ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig", "Wybierz", "Anuluj");
					}
 				}
				return 1;
			}
		}
		if(dialogid == 1414)//usu� trase
		{
		    if(response)
		    {
		        if(Wyscig[listitem][wStworzony] == 1)
			    {
			        new naglowek[64];
					format(naglowek, sizeof(naglowek), "Usuwanie wy�cigu '%s'", Wyscig[listitem][wNazwa]);
			        ShowPlayerDialogEx(playerid, 1417, DIALOG_STYLE_MSGBOX, naglowek, "{FF0000}UWAGA!{B0C4DE} Na pewno chcesz usun�� ten wy�cig?\nZostanie on bezpowrotnie zlikwidowany!\nNa pewno chcesz kontynuowa�?", "Usu�", "Wr��");
			        tworzenietrasy[playerid] = listitem;
                }
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "Ta trasa nie zosta�a jeszcze stworzona!");
					ShowPlayerDialogEx(playerid, 1414, DIALOG_STYLE_LIST, "Usuwanie. Dost�pne trasy:", ListaWyscigow(), "Usu�", "Wr��");
				}
				return 1;
		    }
		    if(!response)
		    {
		        if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
 				{
 				    if(PlayerInfo[playerid][pRank] >= 4)
 				    {
						ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
					}
					else
					{
					    ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig", "Wybierz", "Anuluj");
					}
 				}
				return 1;
		    }
		}
		if(dialogid == 1415)//informacje o wy�cigu
		{
		    if(response || !response)
		    {
				ShowPlayerDialogEx(playerid, 1411, DIALOG_STYLE_LIST, "Wszystkie trasy:", ListaWyscigow(), "Wi�cej", "Wyjd�");
				return 1;
		    }
		}
		if(dialogid == 1416)//Akceptowanie organizowania
		{
		    if(response)
			{
				if(kaska[playerid] >= Wyscig[tworzenietrasy[playerid]][wNagroda] && Wyscig[tworzenietrasy[playerid]][wNagroda] > 0 && kaska[playerid] > 0)
				{
					new sendername[MAX_PLAYER_NAME];
					new komunikat[128];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(komunikat, sizeof(komunikat), "Komunikat frakcyjny: {FFFFFF}%s zorganizowa� wy�cig %s", sendername, Wyscig[tworzenietrasy[playerid]][wNazwa]);
					SendFamilyMessage(15, COLOR_YELLOW, komunikat);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wy�cig zorganizowany! Udaj si� na start i zapro� osoby do wyscigu komend� /wyscig [id].");
					SetPlayerRaceCheckpoint(playerid,1,wCheckpoint[tworzenietrasy[playerid]][0][0], wCheckpoint[tworzenietrasy[playerid]][0][1], wCheckpoint[tworzenietrasy[playerid]][0][2],wCheckpoint[tworzenietrasy[playerid]][1][0], wCheckpoint[tworzenietrasy[playerid]][1][1], wCheckpoint[tworzenietrasy[playerid]][1][2], 10);
					ZabierzKase(playerid, (Wyscig[tworzenietrasy[playerid]][wCheckpointy]+1)*2000);
					ZabierzKase(playerid, Wyscig[tworzenietrasy[playerid]][wNagroda]);
					
					Log(payLog, INFO, "%s zorganizowa� wy�cig %s. Koszt organizacji: %d$, nagroda: %d$",
						GetPlayerLogName(playerid),
						Wyscig[tworzenietrasy[playerid]][wNazwa], 
						(Wyscig[tworzenietrasy[playerid]][wCheckpointy]+1)*2000, 
						Wyscig[tworzenietrasy[playerid]][wNagroda]);

					owyscig[playerid] = tworzenietrasy[playerid];
					//tworzenietrasy[playerid] = 666; - po co pytam sie zmieniac po wybraniu trasy zmienn� jakoby TWORZYMY TRASE, PO CO?
					
				}
				else
				{
					SendClientMessage(playerid, COLOR_PANICRED, "Nie sta� ci� na zorganizowanie tego wy�cigu!!");
					tworzenietrasy[playerid] = 666;
					ShowPlayerDialogEx(playerid, 1412, DIALOG_STYLE_LIST, "Organizowanie wy�cigu. Dost�pne trasy:", ListaWyscigow(), "Zorganizuj", "Wr��");
				}
			}
		    if(!response)
		    {
				tworzenietrasy[playerid] = 666;
				ShowPlayerDialogEx(playerid, 1412, DIALOG_STYLE_LIST, "Organizowanie wy�cigu. Dost�pne trasy:", ListaWyscigow(), "Zorganizuj", "Wr��");
		    }
			return 1;
		}
		if(dialogid == 1417)//usu� trase
		{
		    if(response)
			{
				Log(serverLog, INFO, "%s zlikwidowa� tras� wy�cigow� %s[%d]", GetPlayerLogName(playerid), Wyscig[tworzenietrasy[playerid]][wNazwa], tworzenietrasy[playerid]);

			    Wyscig[tworzenietrasy[playerid]][wStworzony] = 0;
				strcat(Wyscig[tworzenietrasy[playerid]][wNazwa], "Wolne", 20);
				strcat(Wyscig[tworzenietrasy[playerid]][wOpis], "", 50);
				Wyscig[tworzenietrasy[playerid]][wCheckpointy] = 0;
				Wyscig[tworzenietrasy[playerid]][wNagroda] = 0;
				Wyscig[tworzenietrasy[playerid]][wTypCH] = 0;
				Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 0;
				for(new ii; ii<26; ii++)
				{
					wCheckpoint[tworzenietrasy[playerid]][ii][0] = 0;
			  		wCheckpoint[tworzenietrasy[playerid]][ii][1] = 0;
			    	wCheckpoint[tworzenietrasy[playerid]][ii][2] = 0;
			    }
				SendClientMessage(playerid, COLOR_RED, "Trasa pomy�lnie zlikwidowana!");
				tworzenietrasy[playerid] = 666;
			    if(PlayerInfo[playerid][pRank] >= 4)
 			    {
					ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
				}
				else
				{
				    ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig", "Wybierz", "Anuluj");
				}
				return 1;
			}
			if(!response)
			{
				tworzenietrasy[playerid] = 666;
				ShowPlayerDialogEx(playerid, 1414, DIALOG_STYLE_LIST, "Usuwanie. Dost�pne trasy:", ListaWyscigow(), "Usu�", "Wr��");
				return 1;
			}
		}
		if(dialogid == 1430)//opcje edycji
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0://Nazw�
		            {
		                ShowPlayerDialogEx(playerid, 1431, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nazwa", "Wpisz nazw� wy�cigu. Maksymalnie 20 znak�w", "Edytuj", "Wr��");
		            }
		            case 1://Opis
		            {
		                ShowPlayerDialogEx(playerid, 1432, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Opis", "Wpisz opis trasy. Maksymalnie 50 znak�w", "Edytuj", "Wr��");
		            }
		            case 2://Nagrode
		            {
		                ShowPlayerDialogEx(playerid, 1433, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nagroda", "Wpisz nagrod� jak� dostanie zwyci�zca wy�cigu.\nMinimalna stawka to 10 000$ a maksymalna to 10 000 000$", "Edytuj", "Wr��");
		            }
		        }
				return 1;
		    }
		    if(!response)
		    {
				tworzenietrasy[playerid] = 666;
				ShowPlayerDialogEx(playerid, 1413, DIALOG_STYLE_LIST, "Edytowanie. Dost�pne trasy:", ListaWyscigow(), "Edytuj", "Wr��");
				return 1;
			}
		}
		if(dialogid == 1431)
		{
		    if(response)
		    {
				if(Scigamy == 666)
				{
					if(strlen(inputtext) > 1 && strlen(inputtext) <= 20)
					{
						format(Wyscig[tworzenietrasy[playerid]][wNazwa], 20, "%s", inputtext);
						new string[128];
						format(string, sizeof(string), "Nazwa wy�cigu pomy�lnie zmieniona na: {FFFFFF}%s", inputtext);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						ZapiszTrase(tworzenietrasy[playerid]);
						ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "Nazwa nie mo�e by� pusta/zbyt du�o znak�w!");
						ShowPlayerDialogEx(playerid, 1431, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nazwa", "Wpisz nazw� wy�cigu. Maksymalnie 20 znak�w", "Edytuj", "Wr��");
					}
				}
				else
				{
					ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					SendClientMessage(playerid, COLOR_PANICRED, "Trwa wy�cig, nie mo�na edytowa�!");
				}
				return 1;
		    }
		    if(!response)
			{
			    ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
				return 1;
			}
		}
		if(dialogid == 1432)
		{
            if(response)
		    {
				if(Scigamy == 666)
				{
					if(strlen(inputtext) > 1 && strlen(inputtext) <= 50)
					{
						format(Wyscig[tworzenietrasy[playerid]][wOpis], 50, "%s", inputtext);
						new string[128];
						format(string, sizeof(string), "Opis wy�cigu pomy�lnie zmieniony na: {FFFFFF}%s", inputtext);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						ZapiszTrase(tworzenietrasy[playerid]);
						ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "Nazwa nie mo�e by� pusta/zbyt du�o znak�w!");
						ShowPlayerDialogEx(playerid, 1432, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Opis", "Wpisz opis trasy. Maksymalnie 50 znak�w", "Edytuj", "Wr��");
					}
				}
				else
				{
					ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					SendClientMessage(playerid, COLOR_PANICRED, "Trwa wy�cig, nie mo�na edytowa�!");
				}
				return 1;
    		}
		    if(!response)
			{
			    ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
				return 1;
			}
		}
		if(dialogid == 1433)
		{
		    if(response)
		    {
				if(Scigamy == 666)
				{
					if(strval(inputtext) >= 10000 && strval(inputtext) <= 100000000)
					{
						Wyscig[tworzenietrasy[playerid]][wNagroda] = strval(inputtext);
						new string[128];
						format(string, sizeof(string), "Nagroda wy�cigu pomy�lnie zmieniona na: {FFFFFF}%d$", strval(inputtext));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						ZapiszTrase(tworzenietrasy[playerid]);
						ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					}
					else
					{
						ShowPlayerDialogEx(playerid, 1433, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nagroda", "Wpisz nagrod� jak� dostanie zwyci�zca wy�cigu.\nMinimalna stawka to 10 000$ a maksymalna to 10 000 000$", "Edytuj", "Wr��");
					}
				}
				else
				{
					ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
					SendClientMessage(playerid, COLOR_PANICRED, "Trwa wy�cig, nie mo�na edytowa�!");
				}
				return 1;
		    }
		    if(!response)
			{
			    ShowPlayerDialogEx(playerid, 1430, DIALOG_STYLE_LIST, "Edycja trasy: Wybierz co chcesz edytowa�", "Nazw�\nOpis\nNagrod�", "Wybierz", "Anuluj");
				return 1;
			}
		}
		if(dialogid == 1420)//Tworzenie wy�cigu. Wybieranie slotu
		{
			if(response)
			{
				if(Wyscig[listitem][wStworzony] == 0)
				{
				    tworzenietrasy[playerid] = listitem;
				    ShowPlayerDialogEx(playerid, 1421, DIALOG_STYLE_LIST, "Kreator wy�cig�w: Wybierz typ checkpoint�w", "Normalne\nKo�a", "Wybierz", "Cofnij");
				}
				else
				{
                    new string[1024];
    				for(new i=0; i<sizeof(Wyscig); i++)
					{
					    if(Wyscig[i][wStworzony] == 1)
					    {
						    format(string, sizeof(string), "%s%s\n", string, Wyscig[i][wNazwa]);
						}
						else
						{
						    strcat(string, "Wolny\n");
						}
					}
     				ShowPlayerDialogEx(playerid, 1420, DIALOG_STYLE_LIST, "Kreator wy�cig�w: Wybierz slot", string, "Wybierz", "Anuluj");
     				SendClientMessage(playerid, COLOR_GREY, "Slot zaj�ty!");
				}
				return 1;
			}
			if(!response)
			{
				ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wy�cig�w: Wybierz opcj�", "Poka� trasy\nZorganizuj wy�cig\nEdytuj tras�\nUsu� tras�", "Wybierz", "Anuluj");
				return 1;
			}
		}
		if(dialogid == 1421)//Tworzenie wy�cigu. Wybieranie typu checkpointu
		{
			if(response)
			{
			    if(listitem == 1)
			    {
			    	Wyscig[tworzenietrasy[playerid]][wTypCH] = 3;
				}
				else
				{
				    Wyscig[tworzenietrasy[playerid]][wTypCH] = 0;
				}
			    ShowPlayerDialogEx(playerid, 1422, DIALOG_STYLE_LIST, "Kreator wy�cig�w: Wybierz rozmiar checkpoint�w", "Ogromne\nDu�e\n�rednie\nMa�e\nMini", "Wybierz", "Wr��");
				return 1;
			}
			if(!response)
			{
			    tworzenietrasy[playerid] = 666;
			    new string[1024];
				for(new i=0; i<sizeof(Wyscig); i++)
				{
					if(Wyscig[i][wStworzony] == 1)
					{
						format(string, sizeof(string), "%s%s\n", string, Wyscig[i][wNazwa]);
					}
					else
					{
						strcat(string, "Wolny\n");
					}
				}
     			ShowPlayerDialogEx(playerid, 1420, DIALOG_STYLE_LIST, "Kreator wy�cig�w: Wybierz slot", string, "Wybierz", "Anuluj");
				return 1;
			}
		}
		if(dialogid == 1422)//Tworzenie wy�cigu. Wybieranie wielko�ci checkpointu
		{
			if(response)
			{
			    switch(listitem)
				{
				    case 0://Ogromne
				    {
				        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 10.0;//rupxnup
				    }
				    case 1://Du�e
				    {
				        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 7.5;
				    }
				    case 2://�rednie
				    {
				        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 5.0;
				    }
				    case 3://Ma�e
				    {
				        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 2.5;
				    }
				    case 4://Mini
				    {
				        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 1.0;
				    }
				}
				ShowPlayerDialogEx(playerid, 1423, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nazwa", "Wpisz nazw� wy�cigu. Maksymalnie 20 znak�w", "Dalej", "");
				return 1;
   			}
			if(!response)
			{
			    Wyscig[tworzenietrasy[playerid]][wTypCH] = 0;
			    ShowPlayerDialogEx(playerid, 1421, DIALOG_STYLE_LIST, "Kreator wy�cig�w: Wybierz typ checkpoint�w", "Normalne\nKo�a", "Wybierz", "Wr��");
			}
		}
		if(dialogid == 1423)//Tworzenie wy�cigu. Wypisywanie nazwy
		{
		    if(strlen(inputtext) > 1 && strlen(inputtext) <= 20)
			{
			    format(Wyscig[tworzenietrasy[playerid]][wNazwa], 20, "%s", inputtext);
			    ShowPlayerDialogEx(playerid, 1424, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Opis", "Wpisz opis trasy. Maksymalnie 50 znak�w", "Dalej", "");
			}
		    else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Nazwa nie mo�e by� pusta/zbyt du�o znak�w!");
			    ShowPlayerDialogEx(playerid, 1423, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nazwa", "Wpisz nazw� wy�cigu. Maksymalnie 20 znak�w", "Dalej", "");
			}
		}
		if(dialogid == 1424)//Tworzenie wy�cigu. Wpisywanie opisu
		{
		    if(strlen(inputtext) > 1 && strlen(inputtext) <= 50)
			{
			    format(Wyscig[tworzenietrasy[playerid]][wOpis], 50, "%s", inputtext);
			    ShowPlayerDialogEx(playerid, 1425, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nagroda", "Wpisz nagrod� jak� dostanie zwyci�zca wy�cigu.\nMinimalna stawka to 10 000$ a maksymalna to 10 000 000$", "Dalej", "");
			}
		    else
			{
				SendClientMessage(playerid, COLOR_GREY, "Opis nie mo�e by� pusty/zbyt du�o znak�w!");
			    ShowPlayerDialogEx(playerid, 1424, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Opis", "Wpisz opis trasy. Maksymalnie 50 znak�w", "Dalej", "");
			}
		}
		if(dialogid == 1425)//Tworzenie wy�cigu. Nagroda
		{
			if(strval(inputtext) >= 10000 && strval(inputtext) <= 10000000)
			{
			    Wyscig[tworzenietrasy[playerid]][wNagroda] = strval(inputtext);
			    ShowPlayerDialogEx(playerid, 1426, DIALOG_STYLE_MSGBOX, "Kreator wy�cig�w: Tworzenie trasy", "Poda�e� ju� wszystkie wymagane informacje.\nMo�esz przej�� do tworzenia trasy lub anulowa� proces tworzenia.\nAby postawi� czekpoint wpisz /checkpoint\nAby postawi� mete i zako�czyc tworzenie trasy, wpisz /meta\nAby przej�� dalej, naci�nnij \"Dalej\"", "Dalej", "Usu�");
			}
			else
			{
			    ShowPlayerDialogEx(playerid, 1425, DIALOG_STYLE_INPUT, "Kreator wy�cig�w: Nagroda", "Wpisz nagrod� jak� dostanie zwyci�zca wy�cigu.\nMinimalna stawka to 10 000$ a maksymalna to 10 000 000$", "Dalej", "");
			}
		}
		if(dialogid == 1426)//Tworzenie wy�cigu. Przej�cie do tworzenia trasy
		{
		    if(response)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Aby stworzy� checkpoint wpisz /checkpoint. Aby usun�� ostatnio postawiony checkpoint wpisz /checkpoint-usun. Aby zako�czy� tworzenie i postawi� finisz, wpisz /meta");
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Maksymalna ilo�� checkpoint�w to 50.");
		    }
		    if(!response)
		    {
		        format(Wyscig[tworzenietrasy[playerid]][wOpis], 50, "");
		        format(Wyscig[tworzenietrasy[playerid]][wNazwa], 20, "");
		        Wyscig[tworzenietrasy[playerid]][wTypCH] = 0;
		        Wyscig[tworzenietrasy[playerid]][wRozmiarCH] = 0;
		        tworzenietrasy[playerid] = 666;
		    }
		}
		if(dialogid == 1427)//Tworzenie wy�cigu. Koniec tworzenia trasy
		{
		    if(response)
		    {
		        //testowanie wy�cigu
		    }
		}
	}
	if(dialogid == 1888)
	{
	    if(response)
	    {
	        if(IsPlayerAdmin(playerid))
	        {
	            new gf[256];
				dini_IntSet("Admini/weryfikacje.ini", "ilosc", dini_Int("Admini/weryfikacje.ini", "ilosc")+1);
    			new i = dini_Int("Admini/weryfikacje.ini", "ilosc");
 		    	format(gf, sizeof(gf), "Nick_%d", i);
   				dini_Set("Admini/weryfikacje.ini", gf, inputtext);
	        	ShowPlayerDialogEx(playerid, 1889, DIALOG_STYLE_INPUT, "Tworzenie weryfikacji", "Wpisz weryfikacje", "Stw�rz", "");
			}
	    }
	}
	if(dialogid == 1889)
	{
	    if(IsPlayerAdmin(playerid))
     	{
     	    new gf[256], gf2[MAX_PLAYER_NAME];
     	    new i = dini_Int("Admini/weryfikacje.ini", "ilosc");
     	    format(gf, sizeof(gf), "Weryfikacja_%d", i);
     	    format(gf2, sizeof(gf2), "Nick_%d", i);
     	    dini_Set("Admini/weryfikacje.ini", gf, inputtext);
     	    format(gf, sizeof(gf), "Weryfikacja utworzona pomy�lnie.\nNick: %s\nWeryfikacja: %s", dini_Get("Admini/weryfikacje.ini", gf2), dini_Get("Admini/weryfikacje.ini", gf));
            ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_INPUT, "Tworzenie weryfikacji", gf, "OK", "");
      	}
	}
	if(dialogid==DIALOG_IBIZA_MIKSER)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //stream
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_STREAM, DIALOG_STYLE_LIST, "Wyb�r streama", "W�asny link\nClub Party\nEnergy Sound", "Wybierz", "Wr��");
					return 1;
				}
				case 1: //telebim
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TELEBIM, DIALOG_STYLE_LIST, "Telebim opcje", "Zmie� tekst\nZmie� kolor\nAnimacja\nCzcionka", "Wybierz", "Wr��");
					return 1;
				}
				case 2: //�wiat�a
				{
					if(IbizaSwiatla)
					{
						WylaczSwiatla();
						IbizaSwiatla = false;
					}
					else
					{
						WlaczSwiatla();
						IbizaSwiatla = true;
					}
				}
				case 3: //strobo
				{
					if(!IbizaStrobo)	 //w��cz
					{

						IbizaStroboObiekty[0] = CreateDynamicObject(354,1930.5400000,-2494.5100000,21.3700000,0.0000000,0.0000000,-5.6400000,1, 0, -1);
						IbizaStroboObiekty[1] = CreateDynamicObject(354,1930.7100000,-2492.0900000,21.1800000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[2] = CreateDynamicObject(354,1930.7100000,-2489.4900000,21.0800000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[3] = CreateDynamicObject(354,1930.7400000,-2487.0700000,21.1700000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[4] = CreateDynamicObject(354,1930.6900000,-2484.4700000,21.3600000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[5] = CreateDynamicObject(354,1934.3000000,-2479.9000000,12.5800000,0.0000000,0.0000000,0.4200000,1, 0, -1);
						IbizaStroboObiekty[6] = CreateDynamicObject(354,1934.3800000,-2499.5800000,12.5500000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[7] = CreateDynamicObject(354,1955.7200000,-2479.9700000,12.5800000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[8] = CreateDynamicObject(354,1955.8100000,-2499.5500000,12.5700000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[9] = CreateDynamicObject(354,1937.4000000,-2467.5600000,21.9100000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[10] = CreateDynamicObject(354,1939.4400000,-2467.4400000,21.9200000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[11] = CreateDynamicObject(354,1941.4900000,-2467.5200000,21.9300000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[12] = CreateDynamicObject(354,1943.4600000,-2467.5500000,21.9200000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[13] = CreateDynamicObject(354,1945.7600000,-2467.7400000,21.9300000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[14] = CreateDynamicObject(354,1935.8700000,-2471.1600000,14.5100000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[15] = CreateDynamicObject(354,1947.6300000,-2471.0700000,14.4900000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[16] = CreateDynamicObject(354,1944.4300000,-2466.3200000,14.4800000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[17] = CreateDynamicObject(354,1939.5800000,-2466.3200000,14.4500000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[18] = CreateDynamicObject(354,1958.4000000,-2470.3600000,14.4600000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[19] = CreateDynamicObject(354,1957.4700000,-2477.8700000,22.1700000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[20] = CreateDynamicObject(354,1958.7100000,-2487.0000000,21.1700000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[21] = CreateDynamicObject(354,1958.6500000,-2488.7100000,21.0900000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[22] = CreateDynamicObject(354,1958.6800000,-2490.2000000,21.1300000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[23] = CreateDynamicObject(354,1958.3500000,-2497.4500000,21.9200000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[24] = CreateDynamicObject(354,1949.5700000,-2503.1500000,23.4000000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[25] = CreateDynamicObject(354,1944.7700000,-2503.3100000,23.3800000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[26] = CreateDynamicObject(354,1942.6700000,-2503.2700000,23.3400000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaStroboObiekty[27] = CreateDynamicObject(354,1937.2100000,-2503.2100000,23.3500000,0.0000000,0.0000000,0.0000000,1, 0, -1);
						IbizaOdswiezObiekty();
						IbizaStrobo = true;
					}
					else //off
					{
						for(new i=0; i<28; i++)
						{
							DestroyDynamicObject(IbizaStroboObiekty[i]);
						}
						IbizaStrobo = false;
					}
				}
				case 4: //dym
				{

					if(!IbizaDym)
					{
						IbizaDymObiekty[0] = CreateDynamicObject(2780,1932.4400000,-2502.9500000,23.7500000,0.0000000,0.0000000,139.2600000, 1, 0, -1, 600.0); //Object number 0
						IbizaDymObiekty[1] = CreateDynamicObject(2780,1958.9700000,-2503.2600000,17.1300000,0.0000000,0.0000000,-132.7800000, 1, 0, -1, 600.0); //Object number 1
						IbizaDymObiekty[2] = CreateDynamicObject(2780,1944.4800000,-2489.7100000,5.3100000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 2
						IbizaDymObiekty[3] = CreateDynamicObject(2780,1941.2600000,-2475.9900000,7.8100000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 3
						IbizaDymObiekty[4] = CreateDynamicObject(2780,1954.3000000,-2496.6800000,5.0900000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 4
						IbizaDymObiekty[5] = CreateDynamicObject(2780,1954.5900000,-2482.4500000,5.9500000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 5						IbizaDymObiekty[6] = CreateDynamicObject(2780,1937.0200000,-2481.9100000,5.6900000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 6
						IbizaDymObiekty[7] = CreateDynamicObject(2780,1937.4100000,-2497.8000000,5.6900000,0.0000000,0.0000000,0.0000000, 1, 0, -1, 600.0); //Object number 7
						IbizaDymObiekty[8] = CreateDynamicObject(2780,1928.8200000,-2472.6500000,20.3400000,0.0000000,0.0000000,132.5400000, 1, 0, -1, 600.0); //Object number 8
						IbizaDymObiekty[9] = CreateDynamicObject(2780,1950.6400000,-2468.2800000,20.7200000,0.0000000,0.0000000,-20.7000000, 1, 0, -1, 600.0); //Object number 9
						IbizaDym = true;
						IbizaOdswiezObiekty();
					}
					else //wy��cz
					{
						for(new i=0; i<10; i++)
						{
							DestroyDynamicObject(IbizaDymObiekty[i]);
						}
						IbizaDym=false;
					}
				}
				case 5: //rury
				{
					if(!IbizaRury) //wysu�
					{
						MoveDynamicObject(IbizaRuryObiekty[0], 1936.6000, -2482.1799, 13.8000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[1], 1953.6300, -2482.1299, 13.8000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[2], 1936.5900, -2497.4700, 13.8000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[3], 1953.6500, -2497.4600, 13.8000, 2.0);
						MoveDynamicObject(IbizaKafle[0], 1936.5900000,-2482.1700000,12.6000, 2.0);
						MoveDynamicObject(IbizaKafle[1],1953.6400000,-2482.1300000,12.6000, 2.0);
						MoveDynamicObject(IbizaKafle[2], 1953.6500000,-2497.4700000,12.6000, 2.0);
						MoveDynamicObject(IbizaKafle[3], 1936.6100000,-2497.4700000,12.6000, 2.0);
						IbizaRury = true;

					}
					else //schowaj
					{
						MoveDynamicObject(IbizaRuryObiekty[0], 1936.6000, -2482.1799, 11.0000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[1], 1953.6300, -2482.1299, 11.0000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[2], 1936.5900, -2497.4700, 11.0000, 2.0);
						MoveDynamicObject(IbizaRuryObiekty[3], 1953.6500, -2497.4600, 11.0000, 2.0);
						MoveDynamicObject(IbizaKafle[0], 1936.5900000,-2482.1700000,12.5084, 2.0);
						MoveDynamicObject(IbizaKafle[1],1953.6400000,-2482.1300000,12.5084, 2.0);
						MoveDynamicObject(IbizaKafle[2] ,1953.6500000,-2497.4700000,12.5084, 2.0);
						MoveDynamicObject(IbizaKafle[3], 1936.6100000,-2497.4700000,12.5084, 2.0);
						IbizaRury = false;
					}
				}
			}
			MikserDialog(playerid);
		}
		return 1;
	}

	if(dialogid==DIALOG_IBIZA_STREAM)
	{
		if(response)
		{
			if(listitem==0)
			{
				ShowPlayerDialogEx(playerid, DIALOG_IBIZA_STREAM_WLASNY, DIALOG_STYLE_INPUT, "W�asny stream", "Wklej poni�ej link do streama", "Wybierz", "Wr��");
				return 1;
			}
			else
			{
				IbizaStreamID = listitem;
				WlaczStream(listitem);
			}
		}
		return MikserDialog(playerid);
	}
	if(dialogid==DIALOG_IBIZA_STREAM_WLASNY)
	{
		if(response)
		{
			if(strlen(inputtext) > 128) return SendClientMessage(playerid, -1, "Podany link jest zbyt d�ugi");
			if (ValidateURLAndNotify(playerid, inputtext)) return 1;
			format(IbizaStream[0], 128, "%s", inputtext);
			IbizaStreamID = 0;
			WlaczStream(0);
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_IBIZA_STREAM, DIALOG_STYLE_LIST, "Wyb�r streama", "W�asny link\nClub Party\nEnergy Sound", "Wybierz", "Wr��");

		}
		return MikserDialog(playerid);
	}

	if(dialogid==DIALOG_IBIZA_TELEBIM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //tekst
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TEKST, DIALOG_STYLE_INPUT, "Zmiana tekstu", "Wpisz poni�ej takst jaki ma by�\nwy�wietlony na telebimie (MAX 18 znak�w)", "Zmie�", "Wr��");
				}
				case 1: //kolor
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_KOLOR, DIALOG_STYLE_LIST, "Zmiana koloru", "Bia�y\nPomara�czowy\nNiebieski\nZielony\n��ty", "Zmie�", "Wr��");

				}
				case 2: //animacja
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_ANIM, DIALOG_STYLE_LIST, "Opcje animacji", "W��cz\nWy��cz", "Zmie�", "Wr��");
				}
				case 3: //czcionka
				{
					ShowPlayerDialogEx(playerid, DIALOG_IBIZA_CZCIONKA, DIALOG_STYLE_LIST, "Wyb�r czcionki", "Arial\nVerdana\nCourier New\nComic Sans MS\nTahoma", "Zmie�", "Wr��");
				}

			}

		}
		else MikserDialog(playerid);

		return 1;

	}
	if(dialogid==DIALOG_IBIZA_ANIM)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(Telebim[tRuchomy]) return SendClientMessage(playerid, -1, "Animacja jest ju� w�aczona!");
				if(Telebim[tWRuchu] ) return SendClientMessage(playerid, -1, "Poczekaj a� animacja sko�czy sw�j cykl!!!");
				new dl = strlen(Telebim[tTekst]);
				format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "");
				for(new i; i<38+(2*dl); i++)
				{
					format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "%s%s", Telebim[tTekstAnim], IBIZA_WYPELNIENIE);
				}
				format(Telebim[tTekstAnim], sizeof(Telebim[tTekstAnim]), "%s%s|", Telebim[tTekstAnim], Telebim[tTekst]);
				SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekstAnim],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
				Telebim[tRuchomy] = 1;
				Telebim[tWRuchu] = 1;
				SetTimerEx("TelebimAnim", Telebim[tSzybkosc], false, "d", strlen(Telebim[tTekstAnim]));
				SendClientMessage(playerid, -1, "W��czy�e� animacje");
			}
			else
			{
				if(!Telebim[tRuchomy]) return SendClientMessage(playerid, -1, "Animacje jest ju� wy��czona!");
				Telebim[tRuchomy] = 0;
				SendClientMessage(playerid, -1, "Wy��czy�e� animacje");
			}
			MikserDialog(playerid);
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TELEBIM, DIALOG_STYLE_LIST, "Telebim opcje", "Zmie� tekst\nZmie� kolor\nAnimacja\nCzcionka", "Wybierz", "Wr��");
		}
		return 1;

	}
	if(dialogid==DIALOG_IBIZA_CZCIONKA)
	{
		if(response)
		{
			format(Telebim[tCzcionka], sizeof Telebim[tCzcionka], "%s", IbizaCzcionkiTelebim[listitem]);
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekst],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			SendClientMessage(playerid, -1, "Zmieni�e� czcionk�");
			MikserDialog(playerid);
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TELEBIM, DIALOG_STYLE_LIST, "Telebim opcje", "Zmie� tekst\nZmie� kolor\nAnimacja\nCzcionka", "Wybierz", "Wr��");
		}
		return 1;

	}
	if(dialogid==DIALOG_IBIZA_KOLOR)
	{
		if(response)
		{
			Telebim[tCzcionkaKolor] = IbizaKoloryTelebim[listitem];
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekst],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			SendClientMessage(playerid, -1, "Zmieni�e� kolor napisu");
			MikserDialog(playerid);
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TELEBIM, DIALOG_STYLE_LIST, "Telebim opcje", "Zmie� tekst\nZmie� kolor\nAnimacja\nCzcionka", "Wybierz", "Wr��");
		}
		return 1;
	}
	if(dialogid==DIALOG_IBIZA_TEKST)
	{
		if(response)
		{
			if( strlen(inputtext) > DLUGOSC_TELEBIMA-1 )
			{
				SendClientMessage(playerid, 0xFF0000FF, "Podany tekst jest za d�ugi");
				ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TEKST, DIALOG_STYLE_INPUT, "Zmiana tekstu", "Wpisz poni�ej takst jaki ma by�\nwy�wietlony na telebimie (MAX 18 znak�w)", "Ustaw", "Anuluj");
			}
			else
			{
				if(Telebim[tRuchomy] || Telebim[tWRuchu] ) return SendClientMessage(playerid, -1, "Nie mo�esz zmieni� tekstu podczas dzia�ania animacji, najpierw j� zatrzymaj!");
				format(Telebim[tTekst], sizeof Telebim[tTekst], "%s", inputtext);
				SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekst],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
				SendClientMessage(playerid, 0x00FF00FF, "Zmieni�e� napis na telebimie");
				MikserDialog(playerid);

			}
			return 1;
		}
		else
		{
			ShowPlayerDialogEx(playerid, DIALOG_IBIZA_TELEBIM, DIALOG_STYLE_LIST, "Telebim opcje", "Zmie� tekst\nZmie� kolor\nAnimacja\nCzcionka", "Wybierz", "Wr��");
			return 1;
		}
	}

	if(dialogid==DIALOG_IBIZA_BILET)
	{
		new string[128];
		new id = GetPVarInt(playerid, "IbizaBiletSell");
		if(response)
		{
			new hajs = kaska[playerid];
			if(hajs < IbizaBilet)
			{
				SendClientMessage(id, -1, "Ten gracz nie ma tyle kasy");
				return SendClientMessage(playerid, -1, "Nie masz wystarczaj�cej ilo�ci pieni�dzy");
			}
			else
			{
				if(IbizaBilet < 0) return 1;
				ZabierzKase(playerid, IbizaBilet);
				SetPVarInt(playerid, "IbizaBilet", 1);
				format(string, sizeof string, "%s kupi�� od Ciebie bilet", PlayerName(playerid));
				SendClientMessage(id, 0x0080D0FF, string);
				format(string, sizeof string, "Kupi�e� bilet do Ibiza Club za %d$", IbizaBilet);
				SendClientMessage(playerid, 0x00FF00FF, string);
			}
		}
		else
		{
			format(string, sizeof string, "Gracz %s nie zgodzi�� si� na kupno biletu", PlayerName(playerid));
			SendClientMessage(id, 0xFF0030FF, string);

		}
		DeletePVar(playerid, "IbizaBiletSell");
		return 1;
	}
	if(dialogid==DIALOG_KLUB_BAR)
	{
		new string[128];
		new bizId = GetPVarInt(playerid, "polejBizId");
		new barman = GetPVarInt(playerid, "polejBarman");
		new drink = GetPVarInt(playerid, "polejDrink");
		if(response)
		{
			new cena = bizId == 39
				? IbizaDrinkiCeny[drink]
				: vinylDrinkCosts[drink];
			if(kaska[playerid] >= cena)
			{
				ZabierzKase(playerid, cena);
				SetPlayerSpecialAction(playerid, 22);
				GenerateFrontBusinessIncome(bizId, cena);
				format(string, 128, "Sprzedano drinka klientowi %s", PlayerName(playerid));
				SendClientMessage(barman, -1, string);
			}
			else
			{
				SendClientMessage(playerid, -1, "Nie masz wystarczaj�cej ilo�ci pieni�dzy");
				format(string, sizeof string, "Klient %s nie ma tyle pieni�dzy", PlayerName(playerid));
				SendClientMessage(barman, 0xB52E2BFF, string);
			}


		}
		else
		{
			format(string, sizeof string, "Gracz %s nie zgodzi� si� na kupno drinka", PlayerName(playerid));
			SendClientMessage(barman, 0xB52E2BFF, string);
		}
		DeletePVar(playerid, "polejBizId");
		DeletePVar(playerid, "polejBarman");
		DeletePVar(playerid, "polejDrink");
		return 1;
	}
	if(dialogid == D_ERS_SPRZEDAZ_APTECZKI)
	{
		new string[128];
		new id = GetPVarInt(playerid, "HealthPackOffer");
		if(response)
		{
			new hajs = kaska[playerid];
			if(hajs < (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR))
			{
				SendClientMessage(id, -1, "Ten gracz nie ma tyle kasy");
				return SendClientMessage(playerid, -1, "Nie masz wystarczaj�cej ilo�ci pieni�dzy");
			}
			else
			{
				format(string, sizeof string, "%s kupi� od Ciebie apteczk�. Otrzymujesz %d$ prowizji.", PlayerName(playerid), HEALTH_PACK_AMOUNTDOCTOR);
				SendClientMessage(id, 0x0080D0FF, string);
				format(string, sizeof string, "Kupi�e� apteczk� od Lekarza za %d$", (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
				SendClientMessage(playerid, 0x00FF00FF, string);
				format(string, sizeof string, "[ERS] Lekarz %s sprzeda� apteczk�! Na konto frakcji wp�ywa %d$", PlayerName(id), HEALTH_PACK_PRICE);
        		SendFamilyMessage(4, COLOR_GREEN, string);
				ZabierzKase(playerid, (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
				DajKase(id, HEALTH_PACK_AMOUNTDOCTOR);
        		Sejf_Add(FRAC_ERS, HEALTH_PACK_PRICE);
				PlayerInfo[playerid][pHealthPacks]++;
			}
		}
		else
		{
			format(string, sizeof string, "Gracz %s nie zgodzi� si� na kupno apteczki.", PlayerName(playerid));
			SendClientMessage(id, 0xFF0030FF, string);
		}
		DeletePVar(playerid, "HealthPackOffer");
		return 1;
	}

	if(dialogid == D_UZYCIE_APTECZKI)
	{
		new string[144];
		new id = GetPVarInt(playerid, "HealthPackOffer");
		if(response)
		{
			if(GetDistanceBetweenPlayers(playerid,id) > 5) return SendClientMessage(playerid, 0xFF0030FF, "Udzielaj�cy pomocy jest zbyt daleko");
			
			if(GetPlayerFraction(id) == FRAC_ERS)
			{
				SendClientMessage(playerid, COLOR_WHITE, "Zosta�e� uzdrowiony przez Lekarza");
				format(string, sizeof(string),"* Lekarz %s wyci�ga apteczk�, banda�uje rany oraz podaje leki %s.", GetNick(id), GetNick(playerid));
				ProxDetector(20.0, id, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				format(string, sizeof(string), "%s czuje si� lepiej dzi�ki interwencji lekarza.", GetNick(playerid));
				ProxDetector(20.0, id, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				isBeatenUp[playerid] = false;
				ZdejmijBW(playerid, 3500);
				SetPlayerHealth(playerid, 90.0);
			}
			else
			{
				if(PlayerInfo[id][pHealthPacks] < 1) return SendClientMessage(id, 0xFF0030FF, "Gracz nie posiada ju� apteczek by udzieli� Ci pomocy.");
				if(PlayerInfo[playerid][pBW] > 0) return SendClientMessage(playerid, 0xFF0030FF, "Jeste� ci�ko ranny, takie obra�enia mo�e opatrzy� tylko lekarz! (/wezwij medyk)");
				format(string, sizeof(string),"* Udzielono pomocy medycznej %s i opatrzono rany.", GetNick(playerid));
				SendClientMessage(id, COLOR_WHITE, string);
				format(string, sizeof(string),"* %s wyci�ga apteczk�, banda�uje obra�enia %s oraz podaje mu leki.", GetNick(id), GetNick(playerid));
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerInfo[id][pHealthPacks]--;
				isBeatenUp[playerid] = false;
				ZdejmijBW(playerid, 6000);
				SetPlayerHealth(playerid, HEALTH_PACK_HP);
			}
		}
		else
		{
			format(string, sizeof string, "Gracz %s nie zgodzi� si� na udzielenie pomocy medycznej.", PlayerName(playerid));
			SendClientMessage(id, 0xFF0030FF, string);
		}
		DeletePVar(playerid, "HealthPackOffer");
		return 1;
	}
	if(dialogid == D_PRZEDMIOTY_BRONIE)
	{
		if(response)
		{
			GUIExit[playerid] = 0;
			new weaponid = DynamicGui_GetValue(playerid, listitem);
			new weapondata = DynamicGui_GetDataInt(playerid, listitem);
			if(weaponid == MyWeapon[playerid])
			{
				weaponid = PlayerInfo[playerid][pGun0];
			}
			/*new string[144];
			format(string, sizeof(string), "* %s wybra� bro� w GUI (opcja %d) ID broni: %d [%s]", GetNick(playerid), listitem, weaponid, GunNames[weaponid]);
			SendClientMessageToAll(COLOR_WHITE, string);*/
			return PrzedmiotyZmienBron(playerid, weaponid, weapondata);
		}
		else
		{
			//PrzedmiotyZmienBron(playerid, PlayerInfo[playerid][pGun0]);
			GUIExit[playerid] = 0;
			return 1;
		}
	}
	if(dialogid == D_ANIMLIST)
	{
		if(!response)
		{
			return 1;
		}
		
		switch(listitem)
		{
		    case 0: MRP_DoAnimation(playerid,"@bar1");
		    case 1: MRP_DoAnimation(playerid,"@caluj1");
		    case 2: MRP_DoAnimation(playerid,"@car1");
		    case 3: MRP_DoAnimation(playerid,"@colt1");
		    case 4: MRP_DoAnimation(playerid,"@crack1");
		    case 5: MRP_DoAnimation(playerid,"@dance1");
			case 6: MRP_DoAnimation(playerid,"@diler1");
			case 7: MRP_DoAnimation(playerid,"@idz1");
			case 8: MRP_DoAnimation(playerid,"@klepnij1");
			case 9: MRP_DoAnimation(playerid,"@krzeslo1");

			case 10: MRP_DoAnimation(playerid,"@lez1");
			case 11: MRP_DoAnimation(playerid,"@lokiec1");
		    case 12: MRP_DoAnimation(playerid,"@lowrider1");
		    case 13: MRP_DoAnimation(playerid,"@nies1");
		    case 14: MRP_DoAnimation(playerid,"@papieros1");
		    case 15: MRP_DoAnimation(playerid,"@placz1");
			case 16: MRP_DoAnimation(playerid,"@ranny1");
			case 17: MRP_DoAnimation(playerid,"@rap1");
			case 18: MRP_DoAnimation(playerid,"@rozmowa1");
			case 19: MRP_DoAnimation(playerid,"@sex1");

			case 20: MRP_DoAnimation(playerid,"@sklep1");
   			case 21: MRP_DoAnimation(playerid,"@smierc1");
		    case 22: MRP_DoAnimation(playerid,"@spij1");
		    case 23: MRP_DoAnimation(playerid,"@spray1");
		    case 24: MRP_DoAnimation(playerid,"@stack1");
		    case 25: MRP_DoAnimation(playerid,"@strip1");
			case 26: MRP_DoAnimation(playerid,"@wygralem1");
			case 27: MRP_DoAnimation(playerid,"@yo1");
			case 28: MRP_DoAnimation(playerid,"@bomba"); //
			case 29: MRP_DoAnimation(playerid,"@box");

		    case 30: MRP_DoAnimation(playerid,"@celuj");
       		case 31: MRP_DoAnimation(playerid,"@celujkarabin");
		    case 32: MRP_DoAnimation(playerid,"@crack");
		    case 33: MRP_DoAnimation(playerid,"@czas");
		    case 34: MRP_DoAnimation(playerid,"@dodge");
		    case 35: MRP_DoAnimation(playerid,"@doping");
			case 36: MRP_DoAnimation(playerid,"@drap");
			case 37: MRP_DoAnimation(playerid,"@dzieki");
			case 38: MRP_DoAnimation(playerid,"@fuck");
			case 39: MRP_DoAnimation(playerid,"@greet");

		    case 40: MRP_DoAnimation(playerid,"@hitch");
		    case 41: MRP_DoAnimation(playerid,"@joint");
		    case 42: MRP_DoAnimation(playerid,"@karta");
		    case 43: MRP_DoAnimation(playerid,"@komputer");
		    case 44: MRP_DoAnimation(playerid,"@kozak");
		    case 45: MRP_DoAnimation(playerid,"@taichi");
			case 46: MRP_DoAnimation(playerid,"@machaj");
			case 47: MRP_DoAnimation(playerid,"@maska");
			case 48: MRP_DoAnimation(playerid,"@medyk");
			case 49: MRP_DoAnimation(playerid,"@napad");

		    case 50: MRP_DoAnimation(playerid,"@nie");
		    case 51: MRP_DoAnimation(playerid,"@odbierz");
		    case 52: MRP_DoAnimation(playerid,"@odloz");
		    case 53: MRP_DoAnimation(playerid,"@oh");
		    case 54: MRP_DoAnimation(playerid,"@opieraj");
		    case 55: MRP_DoAnimation(playerid,"@pa");
			case 56: MRP_DoAnimation(playerid,"@pij");
			case 57: MRP_DoAnimation(playerid,"@placz");
			case 58: MRP_DoAnimation(playerid,"@przeladuj");
			case 59: MRP_DoAnimation(playerid,"@ramiona");

			case 60: MRP_DoAnimation(playerid,"@rozciagaj");
			case 61: MRP_DoAnimation(playerid,"@rozlacz");
		    case 62: MRP_DoAnimation(playerid,"@siad");
		    case 63: MRP_DoAnimation(playerid,"@sikaj");
		    case 64: MRP_DoAnimation(playerid,"@smiech");
		    case 65: MRP_DoAnimation(playerid,"@stoj");
			case 66: MRP_DoAnimation(playerid,"@tak");
			case 67: MRP_DoAnimation(playerid,"@waledochodze");
			case 68: MRP_DoAnimation(playerid,"@walekonia");
			case 69: MRP_DoAnimation(playerid,"@wolaj");

			case 70: MRP_DoAnimation(playerid,"@wozszlug");
   			case 71: MRP_DoAnimation(playerid,"@wstan");
		    case 72: MRP_DoAnimation(playerid,"@wtf");
		    case 73: MRP_DoAnimation(playerid,"@wymiotuj");
		    case 74: MRP_DoAnimation(playerid,"@zarcie");
		    case 75: MRP_DoAnimation(playerid,"@zmeczony");
		}
		return 1;
	}
    if(dialogid == DIALOG_ELEVATOR_SAD)
    {
        if(response)
        {
			switch(listitem)
			{
			    case 0: // archiwum
				{
				 	if(SadWinda[0] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,10);
    				TogglePlayerControllable(playerid,0);
                    Wchodzenie(playerid);
    				SetPlayerPos(playerid,1311.5483,-1361.2096,62.8567);
    				SetInteriorTimeAndWeather(playerid); 
					GameTextForPlayer(playerid, "~w~By~n~~r~skLolsy & skTom", 5000, 1);
				}
				case 1: // hol 
    			{
					if(SadWinda[1] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,11);
    				TogglePlayerControllable(playerid,0);
                    Wchodzenie(playerid);
    				SetPlayerPos(playerid,1305.9991,-1326.1344,52.5659);
    				SetInteriorTimeAndWeather(playerid); 
					GameTextForPlayer(playerid, "~w~By~n~~r~skLolsy & skTom", 5000, 1);
				}
				case 2: //Sale Rozpraw
				{
				  	if(SadWinda[2] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,12);
    				TogglePlayerControllable(playerid,0);
                    Wchodzenie(playerid);
    				SetPlayerPos(playerid,1309.9982,-1364.2216,59.6271);
    				SetInteriorTimeAndWeather(playerid); 
					GameTextForPlayer(playerid, "~w~By~n~~r~skLolsy & skTom", 5000, 1);
				}
                case 3: //Biura
				{
					if(SadWinda[3] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,13);
    				TogglePlayerControllable(playerid,0);
                    Wchodzenie(playerid);
    				SetPlayerPos(playerid,1310.1989,-1328.8876,82.5859);
    				SetInteriorTimeAndWeather(playerid); 
					GameTextForPlayer(playerid, "~w~By~n~~r~skLolsy & skTom", 5000, 1);
				}
				case 4: //Socjal
				{
					if(SadWinda[4] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,14);
    				TogglePlayerControllable(playerid,0);
                    Wchodzenie(playerid);
    				SetPlayerPos(playerid,1310.2946,-1321.2517,74.6955);
    				SetInteriorTimeAndWeather(playerid); 
					GameTextForPlayer(playerid, "~w~By~n~~r~skLolsy & skTom", 5000, 1);
				
				}
				case 5: //Dach
				{
					if(SadWinda[5] == 1)
					{
						sendTipMessageEx(playerid, COLOR_RED, "Ten poziom zosta� zablokowany przez pracownik�w s�du!"); 
						return 1;
					}
    	            SetPlayerVirtualWorld(playerid,0);
    	            SetPlayerPos(playerid,1310.3961,-1319.0530,35.6587);
    	            new Hour, Minute, Second;
    				gettime(Hour, Minute, Second);
    				SetPlayerTime(playerid,Hour,Minute);
					
				
				}
			}
		}
	}
    else if(dialogid == D_SERVERINFO)
    {
        if(response) return 1;
        TextDrawHideForPlayer(playerid, TXD_Info);
        return 1;
    }
    else if(dialogid == D_EDIT)
    {
        if(!response) return 1;
        new lStr[1024];
        switch(listitem)
        {
            case 1:
            {
                if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return SendClientMessage(playerid, COLOR_RED, "Brak uprawnie�");
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x ,y ,z);
                for(new i=0;i<MAX_VEHICLES;i++)
                {
                    if(VehicleUID[i][vUID] == 0) continue;
                    if(GetVehicleDistanceFromPoint(i, x, y, z) < 15.0)
                    {
                        format(lStr, 1024, "%s%d � %s (%d)\n", lStr, CarData[VehicleUID[i][vUID]][c_UID], VehicleNames[GetVehicleModel(i)-400], i);
                    }
                }
                strcat(lStr, "Wprowad� UID pojazdu, kt�ry chcesz edytowa�:");
                ShowPlayerDialogEx(playerid, D_EDIT_CAR, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", lStr, "Dalej", "Wr��");
            }
            case 2:
            {
                if(!Uprawnienia(playerid, ACCESS_EDITRANG)) return SendClientMessage(playerid, COLOR_RED, "Brak uprawnie�");

                ShowPlayerDialogEx(playerid, D_EDIT_RANG, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", "Frakcja\nOrganizacja", "Wybierz", "Wr��");
            }
        }
        return 1;
    }
    //EDYCJA POJAZD�W
    else if(dialogid == D_EDIT_CAR)
    {
        if(!response) return RunCommand(playerid, "/edytuj",  "");
        new lStr[1024];
        if(strval(inputtext) == 0)
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x ,y ,z);
            for(new i=0;i<MAX_VEHICLES;i++)
            {
                if(VehicleUID[i][vUID] == 0) continue;
                if(GetVehicleDistanceFromPoint(i, x, y, z) < 15.0)
                {
                    format(lStr, 1024, "%s%d � %s (%d)\n", lStr, CarData[VehicleUID[i][vUID]][c_UID], VehicleNames[GetVehicleModel(i)-400], i);
                }
            }
            strcat(lStr, "Wprowad� UID pojazdu, kt�ry chcesz edytowa�:");
            ShowPlayerDialogEx(playerid, D_EDIT_CAR, DIALOG_STYLE_INPUT, "Edycja pojazd�w", lStr, "Dalej", "Wr��");
            return 1;
        }
        new lID = Car_GetIDXFromUID(strval(inputtext));
        if(lID == -1)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Pojazd nie by� wczytany do systemu, inicjalizacja ...");
            lID = Car_LoadEx(strval(inputtext));
            if(lID == -1) return SendClientMessage(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
        }

        SetPVarInt(playerid, "edit-car", lID);
        ShowCarEditDialog(playerid);
        return 1;
    }
    else if(dialogid == D_EDIT_CAR_MENU)
    {
        if(!response) return RunCommand(playerid, "/edytuj",  "");
        new car = GetPVarInt(playerid, "edit-car");
        if(CarData[car][c_UID] == 0) return 1;
        switch(listitem)
        {
            case 0:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_MODEL, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Wprowad� model pojazdu:", "Ustaw", "Wr��");
            }
            case 1:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Brak\nFrakcja\nOrganizacja\nGracz\nPraca\nSpecjalny\nPubliczny\nDo kradni�cia", "Wybierz", "Wr��");
            }
            case 2:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_RANG, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Wprowad� rang� (dla frakcji/org) lub skill dla pracy:", "Ustaw", "Wr��");
            }
			case 3:
			{
				ShowPlayerDialogEx(playerid, 1089, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}opisu", "Wprowad� nowy opis dla pojazdu:", "Ustaw", "Wr��");
			}
            case 4:
            {
                CarData[car][c_HP] = 1000.0;
                if(CarData[car][c_ID] != 0)
                {
                    SetVehicleHealth(CarData[car][c_ID], 1000.0);
                }
                Car_Save(car, CAR_SAVE_STATE);
            }
            case 5:
            {
				new VW = GetPlayerVirtualWorld(playerid);
                new veh = CarData[car][c_ID];
                new Float:X, Float:Y, Float:Z, Float:A;
                GetVehiclePos(veh, X, Y, Z);
                GetVehicleZAngle(veh, A);
                CarData[car][c_Pos][0] = X;
                CarData[car][c_Pos][1] = Y;
                CarData[car][c_Pos][2] = Z;
				CarData[car][c_VW] = VW; //Zapisywanie VirtualWorldu
                CarData[car][c_Rot] = A;
                Car_Save(CarData[car][c_ID], CAR_SAVE_STATE);
                Car_Unspawn(veh);
                Car_Spawn(car);
                new string[128];
				format(string, 128, "Zmieniono parking dla pojazdu %s [ID: %d] [UID: %d] [VW: %d]", VehicleNames[GetVehicleModel(veh)-400], veh, CarData[car][c_UID], CarData[car][c_VW]);
				SendClientMessage(playerid, 0xFFC0CB, string);
				Log(serverLog, INFO, "Gracz %s zaparkowa� pojazd %s", GetPlayerLogName(playerid), GetVehicleLogName(veh));
            }
            case 6:
            {
                CarData[car][c_Keys] = 0;
                Car_Save(car, CAR_SAVE_OWNER);
            }
            case 7:
            {
                SetPVarInt(playerid, "car_edit_color", 1);
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_COLOR, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj nowy kolor (od 0 do 255).", "Ustaw", "Wr��");
            }
            case 8:
            {
                SetPVarInt(playerid, "car_edit_color", 2);
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_COLOR, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj nowy kolor (od 0 do 255).", "Ustaw", "Wr��");
            }
        }
        return 1;
    }
	else if(dialogid == D_HASLO_INFO)
	{
		if(!response) return KickEx(playerid, "anulowanie zmiany has�a"); 
		if(response)
		{
			sendTipMessage(playerid, "Zmieniasz has�o:");
			ShowPlayerDialogEx(playerid, D_HASLO_ZMIEN, DIALOG_STYLE_INPUT, "Mrucznik Role Play", "Wprowad� poni�ej nowe has�o, kt�rego b�dziesz u�ywa�\ndo gry na naszym serwisie!", "Zatwierd�", "Odrzu�"); 
		}
		return 1;
	}
	else if(dialogid == D_HASLO_ZMIEN)
	{
		if(!response) return KickEx(playerid, "anulowanie zmiany has�a"); 
		if(response)
		{
			if(strlen(inputtext) < 4)
			{
				sendErrorMessage(playerid, "Has�o musi posiada� +3 znaki!"); 
				return 1;
			}
			if(strfind(inputtext, "%") != -1)
			{
				sendErrorMessage(playerid, "Has�o nie mo�e zawiera� znaku procenta!");
				return 1;
			}
			sendErrorMessage(playerid, "Twoje has�o do konta w grze zosta�o zmienione!!!!");
			sendErrorMessage(playerid, "Je�li nie jeste� pewien  nowego has�a - nie wychod� z serwera i zmie� je za pomoc� /zmienhaslo");
			sendErrorMessage(playerid, "Nowe has�o:");
			SendClientMessage(playerid, COLOR_PANICRED, inputtext);

			Log(serverLog, INFO, "%s zmieni� sobie has�o.", GetPlayerLogName(playerid));
			MruMySQL_ChangePassword(GetNick(playerid), inputtext);

			if(GetPVarInt(playerid, "ChangingPassword")) //password changing
			{
				if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0 || IsAScripter(playerid))
				{
					ShowPlayerDialogEx(playerid, 235, DIALOG_STYLE_INPUT, "Weryfikacja", "Logujesz si� jako cz�onek administracji. Zostajesz poproszony o wpisanie w\nponi�sze pole has�a weryfikacyjnego. Pami�taj, aby nie podawa� go nikomu!", "Weryfikuj", "Wyjd�");
				}

				if(PlayerInfo[playerid][pJailed] == 0)
				{ 
    				lowcap[playerid] = 1;
					SetPVarInt(playerid, "spawn", 1);
					SetPlayerSpawn(playerid);
					TogglePlayerSpectating(playerid, false);
					ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_MSGBOX, "Serwer", "Czy chcesz si� teleportowa� do poprzedniej pozycji?", "TAK", "NIE");
				}
			}
		}
		return 1;
	}
	else if(dialogid == 1089)
	{
		if(!response) return ShowCarEditDialog(playerid);
		sendTipMessage(playerid, "Trwaj� prace!"); 
	
		return 1;
	}
    else if(dialogid == D_EDIT_CAR_MODEL)
    {
        if(!response) return ShowCarEditDialog(playerid);
        if(strval(inputtext) < 400 || strval(inputtext) > 611)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Nieprawid�owy model pojazdu.");
            return ShowCarEditDialog(playerid);
        }
        new car = GetPVarInt(playerid, "edit-car");
        new Float:x, Float:y, Float:z, Float:a, bool:dotp=false;
        if(CarData[car][c_ID] != 0)
        {
            GetVehiclePos(CarData[car][c_ID], x, y, z);
            GetVehicleZAngle(CarData[car][c_ID], a);
            Car_Unspawn(CarData[car][c_ID], true);
            dotp=true;
        }
		new oldmodel = CarData[car][c_Model];
        CarData[car][c_Model] = strval(inputtext);
        Car_Save(car, CAR_SAVE_STATE);
        if(dotp)
        {
            Car_Spawn(car);
            SetVehiclePos(CarData[car][c_ID], x, y, z);
            SetVehicleZAngle(CarData[car][c_ID], a);
        }
		
		//logi
		Log(adminLog, INFO, "Admin %s zmieni� model auta %s z %s[%d] na %s[%d]", \
			GetPlayerLogName(playerid), \
			GetCarDataLogName(car), \
			VehicleNames[oldmodel-400], oldmodel, \
			VehicleNames[CarData[car][c_Model]-400], CarData[car][c_Model] \
		);
        return 1;
    }
    else if(dialogid == D_EDIT_CAR_RANG)
    {
        if(!response) return ShowCarEditDialog(playerid);
        if(strval(inputtext) < 0)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Nieprawid�owa ranga.");
            return ShowCarEditDialog(playerid);
        }
        new car = GetPVarInt(playerid, "edit-car");

        CarData[car][c_Rang] = strval(inputtext);
        Car_Save(car, CAR_SAVE_OWNER);
        ShowCarEditDialog(playerid);
        return 1;
    }
    else if(dialogid == D_EDIT_CAR_OWNER)
    {
        if(!response) return ShowCarEditDialog(playerid);
        SetPVarInt(playerid, "edit_car_ownertype", listitem);
        new car = GetPVarInt(playerid, "edit-car");
        new string[512];
        switch(listitem)
        {
            case INVALID_CAR_OWNER:
            {
                new lSlot;
                if(CarData[car][c_OwnerType] == CAR_OWNER_PLAYER)
                {
                    new lUID = Car_GetOwner(car);
					if(lUID != 0)
					{
						foreach(new i : Player)
						{
							if(PlayerInfo[i][pUID] == lUID)
							{
								for(new j=0;j<MAX_CAR_SLOT;j++)
								{
									if(PlayerInfo[i][pCars][j] == car)
									{
										PlayerInfo[i][pCars][j] = 0;
										lSlot = j+1;
										break;
									}
								}

								format(string, sizeof(string), " Usuni�to pojazd ze slotu %d graczowi %s.", lSlot, GetNick(i));
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								
                   				Log(adminLog, INFO, "Admin %s usun�� %s pojazd %s ze slotu %d", 
									GetPlayerLogName(playerid), 
									GetPlayerLogName(i),
									GetCarDataLogName(car),
									lSlot);
								break;
							}
						}
					}
                }
                CarData[car][c_OwnerType] = 0;
                Car_Save(car, CAR_SAVE_OWNER);
				
				Log(adminLog, INFO, "Admin %s zmieni� w %s typ pojazdu na 0", GetPlayerLogName(playerid), GetCarDataLogName(car));
            }
            case CAR_OWNER_FRACTION:
            {
                for(new i=0;i<sizeof(FractionNames);i++)
                {
                    format(string, 512, "%s%d\t%s\n", string, i, FractionNames[i]);
                }
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER_APPLY, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", string, "Ustaw", "Wr��");
                return 1;
            }
            case CAR_OWNER_FAMILY:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER_APPLY, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj UID organizacji:", "Ustaw", "Wr��");
                return 1;
            }
            case CAR_OWNER_PLAYER:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER_APPLY, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj UID gracza:", "Ustaw", "Wr��");
                return 1;
            }
            case CAR_OWNER_JOB:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER_APPLY, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj ID pracy:", "Ustaw", "Wr��");
                return 1;
            }
            case CAR_OWNER_SPECIAL:
            {
                ShowPlayerDialogEx(playerid, D_EDIT_CAR_OWNER_APPLY, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}pojazd�w", "Podaj typ pojazdu specjalnego:\n\n1. Wypo�yczalnia\n2. GoKart\n3. �u�el\n4. Pojazd bot�w przemytniczych", "Ustaw", "Wr��");
                return 1;
            }
            case CAR_OWNER_PUBLIC:
            {
                new lSlot;
                if(CarData[car][c_OwnerType] == CAR_OWNER_PLAYER)
                {
                    new lUID = Car_GetOwner(car);
					if(lUID != 0)
					{
						foreach(new i : Player)
						{
							if(PlayerInfo[i][pUID] == lUID)
							{
								for(new j=0;j<MAX_CAR_SLOT;j++)
								{
									if(PlayerInfo[i][pCars][j] == car)
									{
										PlayerInfo[i][pCars][j] = 0;
										lSlot = j+1;
										break;
									}
								}

								format(string, sizeof(string), " Usuni�to pojazd ze slotu %d graczowi %s.", lSlot, GetNick(i));
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								Log(adminLog, INFO, "Admin %s usun�� %s pojazd %s ze slotu %d", 
									GetPlayerLogName(playerid), 
									GetPlayerLogName(i),
									GetCarDataLogName(car),
									lSlot);
								break;
							}
						}
					}
                }
                CarData[car][c_OwnerType] = CAR_OWNER_PUBLIC;
                Car_Save(car, CAR_SAVE_OWNER);
				
				Log(adminLog, INFO, "Admin %s zmieni� w %s typ pojazdu na 6",  GetPlayerLogName(playerid), GetCarDataLogName(car));
            }
			case CAR_OWNER_STEAL:
            {
                new lSlot;
                if(CarData[car][c_OwnerType] == CAR_OWNER_PLAYER)
                {
                    new lUID = Car_GetOwner(car);
					if(lUID != 0)
					{
						foreach(new i : Player)
						{
							if(PlayerInfo[i][pUID] == lUID)
							{
								for(new j=0;j<MAX_CAR_SLOT;j++)
								{
									if(PlayerInfo[i][pCars][j] == car)
									{
										PlayerInfo[i][pCars][j] = 0;
										lSlot = j+1;
										break;
									}
								}

								format(string, sizeof(string), " Usuni�to pojazd ze slotu %d graczowi %s.", lSlot, GetNick(i));
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								Log(adminLog, INFO, "Admin %s usun�� %s pojazd %s ze slotu %d", 
									GetPlayerLogName(playerid), 
									GetPlayerLogName(i),
									GetCarDataLogName(car),
									lSlot);
								break;
							}
						}
					}
                }
                CarData[car][c_OwnerType] = CAR_OWNER_STEAL;
                Car_Save(car, CAR_SAVE_OWNER);
				
				Log(adminLog, INFO, "Admin %s zmieni� w %s typ pojazdu na 7",  GetPlayerLogName(playerid), GetCarDataLogName(car));
            }
        }
        ShowCarEditDialog(playerid);
        return 1;
    }
    else if(dialogid == D_EDIT_CAR_OWNER_APPLY)
    {
        if(!response) return ShowCarEditDialog(playerid);
        new typ = GetPVarInt(playerid, "edit_car_ownertype");
        new car = GetPVarInt(playerid, "edit-car");
        if(strval(inputtext) < 0) return ShowCarEditDialog(playerid);

        new lSlot, string[128];
        if(CarData[car][c_OwnerType] == CAR_OWNER_PLAYER)
        {
            new lUID = Car_GetOwner(car);
			if(lUID != 0)
			{
				foreach(new i : Player)
				{
					if(PlayerInfo[i][pUID] == lUID)
					{
						for(new j=0;j<MAX_CAR_SLOT;j++)
						{
							if(PlayerInfo[i][pCars][j] == car)
							{
								PlayerInfo[i][pCars][j] = 0;
								lSlot = j+1;
								break;
							}
						}

						format(string, sizeof(string), " Usuni�to pojazd ze slotu %d graczowi %s.", lSlot, GetNick(i));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						Log(adminLog, INFO, "Admin %s usun�� %s pojazd %s ze slotu %d", 
									GetPlayerLogName(playerid), 
									GetPlayerLogName(i),
									GetCarDataLogName(car),
									lSlot);
						break;
					}
				}
			}
        }
		
        if(typ == CAR_OWNER_PLAYER)
        {
            foreach(new i : Player)
            {
                if(PlayerInfo[i][pUID] == strval(inputtext))
                {
                    Car_MakePlayerOwner(i, car);
                    break;
                }
            }
        }
		CarData[car][c_OwnerType] = typ;
		CarData[car][c_Owner] = strval(inputtext);
		
		Log(adminLog, INFO, "Admin %s zmieni� w %s typ pojazdu na %d", GetPlayerLogName(playerid), GetCarDataLogName(car), typ);
		Car_Save(car, CAR_SAVE_OWNER);
		
        ShowCarEditDialog(playerid);
        return 1;
    }
    else if(dialogid == D_EDIT_CAR_COLOR)
    {
        if(!response) return ShowCarEditDialog(playerid);
        if(strval(inputtext) < 0 || strval(inputtext) > 255)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Nieprawid�owy kolor.");
            return ShowCarEditDialog(playerid);
        }
        new car = GetPVarInt(playerid, "edit-car");

        if(GetPVarInt(playerid, "car_edit_color") == 1)
		{
			MRP_ChangeVehicleColor(CarData[car][c_ID], strval(inputtext), CarData[car][c_Color][1]);
            ChangeVehicleColor(CarData[car][c_ID], strval(inputtext), CarData[car][c_Color][1]);
		}
        else
		{
			MRP_ChangeVehicleColor(CarData[car][c_ID], CarData[car][c_Color][0], strval(inputtext));
            ChangeVehicleColor(CarData[car][c_ID], CarData[car][c_Color][0], strval(inputtext));
		}

        ShowCarEditDialog(playerid);
        return 1;
    }
    //EDYCJA    RANG
    else if(dialogid == D_EDIT_RANG)
    {
        if(!response) return RunCommand(playerid, "/edytuj",  "");
        new string[512];
        SetPVarInt(playerid, "edit_rang_typ", listitem);
        if(listitem == 0)
        {
            for(new i=0;i<sizeof(FractionNames);i++)
            {
                format(string, 512, "%s%d\t%s\n", string, i, FractionNames[i]);
            }
            format(string, 512, "%s\n\nWprowad� UID frakcji:", string);
            ShowPlayerDialogEx(playerid, D_EDIT_RANG_2, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}rang", string, "Wybierz", "Wr��");
        }
        else
        {
            ShowPlayerDialogEx(playerid, D_EDIT_RANG_2, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}rang", "Wprowad� UID organizacji (/organizacje UID):", "Wybierz", "Wr��");
        }
        return 1;
    }
    else if(dialogid == D_EDIT_RANG_2)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_EDIT_RANG, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", "Frakcja\nOrganizacja", "Wybierz", "Wr��");
        new typ = GetPVarInt(playerid, "edit_rang_typ");
        new id = strval(inputtext);
        if(typ == 0)
        {
            if(id < 1 || id > 17) return ShowPlayerDialogEx(playerid, D_EDIT_RANG, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", "Frakcja\nOrganizacja", "Wybierz", "Wr��");
        }
        else
        {
            if(!IsActiveOrg(id)) return ShowPlayerDialogEx(playerid, D_EDIT_RANG, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", "Frakcja\nOrganizacja", "Wybierz", "Wr��");
        }
        SetPVarInt(playerid, "edit_rang_id", id);
        EDIT_ShowRangNames(playerid, typ, id, true);
        return 1;
    }
    else if(dialogid == D_EDIT_RANG_SET)
    {
        if(!response) return ShowPlayerDialogEx(playerid, D_EDIT_RANG, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", "Frakcja\nOrganizacja", "Wybierz", "Wr��");
        SetPVarInt(playerid, "edit_rang_index", listitem);
        ShowPlayerDialogEx(playerid, D_EDIT_RANG_NAME, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}rang", "Podaj now� nazw� dla rangi.\n{FF0000}Je�eli chcesz usun�� rang�, wpisz minus (-)", "Ustaw", "Wr��");
        return 1;
    }
    else if(dialogid == D_EDIT_RANG_NAME)
    {
        if(!response) return EDIT_ShowRangNames(playerid, GetPVarInt(playerid, "edit_rang_typ"), GetPVarInt(playerid, "edit_rang_id"), true);
        new idx = GetPVarInt(playerid, "edit_rang_index");
        if(strlen(inputtext) < 1 || strlen(inputtext) > 24)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "D�ugosc od 1 do 24");
            ShowPlayerDialogEx(playerid, D_EDIT_RANG_NAME, DIALOG_STYLE_INPUT, "{8FCB04}Edycja {FFFFFF}rang", "Podaj now� nazw� dla rangi.\n{FF0000}Je�eli chcesz usun�� rang�, wpisz minus (-)", "Ustaw", "Wr��");
            return 1;
        }
        new typ = GetPVarInt(playerid, "edit_rang_typ");
        new id = GetPVarInt(playerid, "edit_rang_id");
        new name[20];
        mysql_real_escape_string(inputtext, name);
        if(inputtext[0] == '-')
        {
            if(typ == 0) strdel(FracRang[id][idx], 0, MAX_RANG_LEN);
            else if(typ == 1) strdel(OrgRank[id][idx], 0, MAX_RANG_LEN);
        }
        else
        {
            if(typ == 0) format(FracRang[id][idx], MAX_RANG_LEN, "%s", name);
            else if(typ == 1) format(OrgRank[id][idx], MAX_RANG_LEN, "%s", name);
        }
        //EDIT_SaveRangs(typ, id);
        RANG_ApplyChanges[typ][id] = true;
        EDIT_ShowRangNames(playerid, typ, id, true);
        return 1;
    }
    //30.10
    else if(dialogid == D_TRANSPORT)
    {
        if(!response) return 1;
        new lStr[256];

        new skill, level = PlayerInfo[playerid][pTruckSkill];

        if(level <= 50) skill = 1;
        else if(level >= 51 && level <= 100) skill = 2;
        else if(level >= 101 && level <= 200) skill = 3;
        else if(level >= 201 && level <= 400) skill = 4;
        else if(level >= 401) skill = 5;

        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pTruckSkill] < 200) return SendClientMessage(playerid, COLOR_GRAD2, " Szybkie zlecenia dost�pne od 4 poziomu umiej�tno�ci!");
                for(new i=0;i<sizeof(TransportJobData);i++)
                {
                    if(TransportJobData[i][eTJDStartX] != 0 && TransportJobData[i][eTJDEndX] != 0)
                    {
                        if(TransportJobData[i][eTJDMoney] >= 5000 && skill < 5) continue;
                        format(lStr, 256, "%s%d\t%s\n", lStr, i, TransportJobData[i][eTJDName]);
                    }
                }
                ShowPlayerDialogEx(playerid, D_TRANSPORT_LIST, DIALOG_STYLE_LIST, "Szybkie zlecenie", lStr, "Wybierz", "Wr��");
                return 0;
            }
            case 1:
            {
                if(!IsPlayerInRangeOfPoint(playerid, 10.0, TransportJobData[0][eTJDStartX], TransportJobData[0][eTJDStartY], TransportJobData[0][eTJDStartZ]))
                {
                    SetPlayerCheckpoint(playerid, TransportJobData[0][eTJDStartX], TransportJobData[0][eTJDStartY], TransportJobData[0][eTJDStartZ], 5.0);
                    SendClientMessage(playerid, COLOR_GRAD2, "Zlecenie mo�esz wybra� w swoim centrum pracy.");
                    return 0;
                }


                for(new i=0;i<sizeof(TransportJobData);i++)
                {
                    if(TransportJobData[i][eTJDStartX] == 0 && TransportJobData[i][eTJDEndX] != 0)
                    {
                        if(TransportJobData[i][eTJDMoney] >= 5000 && skill < 5) continue;
                        if(TransportJobData[i][eTJDMoney] >= 3500 && skill < 4) continue;
                        if(TransportJobData[i][eTJDMoney] >= 2500 && skill < 3) continue;
                        format(lStr, 256, "%s%d\t%s\n", lStr, i, TransportJobData[i][eTJDName]);
                    }
                }
                ShowPlayerDialogEx(playerid, D_TRANSPORT_LIST, DIALOG_STYLE_LIST, "Planowane zlecenie", lStr, "Wybierz", "Wr��");
            }
        }
    }
    else if(dialogid == D_TRANSPORT_LIST)
    {
        if(!response) return RunCommand(playerid, "/zlecenie",  "");
        new idx = strval(inputtext);
        SetPVarInt(playerid, "trans_idx", idx);
        new lStr[256];
        format(lStr, 256, "TOWAR PRZEWO�ONY:\t%s\nMAX. DOCH�D:\t$%d\nILO�� TOWARU:\t%d\nPOTRZEBNE MATERIA�Y: %d\n\nCzy chcesz przyj�� zlecenie?", TransportJobData[idx][eTJDName],TransportJobData[idx][eTJDMoney], TransportJobData[idx][eTJDMaxItems], TransportJobData[idx][eTJDMats]);

        ShowPlayerDialogEx(playerid, D_TRANSPORT_ACCEPT, DIALOG_STYLE_MSGBOX, "Akceptacja", lStr, "Gotowe!", "Anuluj");
    }
    else if(dialogid == D_TRANSPORT_ACCEPT)
    {
        if(!response) return RunCommand(playerid, "/zlecenie",  "");
        new idx = GetPVarInt(playerid, "trans_idx");
        new lStr[128];
        if(TransportJobData[idx][eTJDMats] > TJD_Materials)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "W magazynie na ma tylu materia��w. Wsi�d� w w�zek wid�owy i do�aduj magazyn!");
            return 0;
        }
        TJD_Materials -= TransportJobData[idx][eTJDMats];
        TJD_UpdateLabel();

        format(lStr, 128, "Przyj�to zlecenie. Twoim zadaniem jest transport %s. Udaj si� do punktu.", TransportJobData[idx][eTJDName]);
        SendClientMessage(playerid, COLOR_YELLOW, lStr);

        SetPVarInt(playerid, "trans", ((idx)*2)+1);
        if(TransportJobData[idx][eTJDStartX] != 0) SetPlayerCheckpoint(playerid, TransportJobData[idx][eTJDStartX], TransportJobData[idx][eTJDStartY], TransportJobData[idx][eTJDStartZ], 5.0);
        else
        {
            SetPlayerCheckpoint(playerid, TransportJobData[0][eTJDStartX], TransportJobData[0][eTJDStartY], TransportJobData[0][eTJDStartZ], 5.0);
        }
    }
    else if(dialogid == D_DODATKI_TYP)
    {
        if(!response) return 1;
        if(listitem == 2 && !IsAPolicja(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jestes w policji!");
        if(listitem == 4 && !IsAPrzestepca(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jestes w organizacji przestepczej!");
        CallRemoteFunction("SEC_Dodatki_Show", "dd", playerid, listitem);
        return 1;
    }
    else if(dialogid == D_WINDA_LSFD)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
				{
			 			SetPlayerPos(playerid, 1745.8119,-1129.8972,24.0781);
                        SetPlayerVirtualWorld(playerid, 0);
				}
                case 1:
				{
						SetPlayerPos(playerid, 1746.2399,-1128.2211,227.8059);
                        SetPlayerVirtualWorld(playerid, 22);
                        Wchodzenie(playerid);
				}
                case 2:
				{
						SetPlayerPos(playerid, 1745.8934,-1129.6250,47.2859);
                        SetPlayerVirtualWorld(playerid, 23);
                        Wchodzenie(playerid);
				}
                case 3:
				{
						SetPlayerPos(playerid, 1745.8119,-1129.8972,46.5700);
                        SetPlayerVirtualWorld(playerid, 0);
				}
            }
        }
        return 1;
    }
    else if(dialogid == D_SUPPORT_LIST)
    {
        SetPVarInt(playerid, "support_dialog", 0);
        if(!response)
            return 1;
        new id = strval(inputtext);
        if(!TICKET[id][suppValid]) return 1;
        new pid = TICKET[id][suppCaller];
        Support_ClearTicket(id);

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
        Unspec[playerid][sPint] = GetPlayerInterior(playerid);
        Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);

        GetPlayerPos(pid, x, y, z);
        SetPlayerPos(playerid, x, y, z);
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(pid));
        SetPlayerInterior(playerid, GetPlayerInterior(pid));
        Wchodzenie(playerid);
        Wchodzenie(pid);
        SetPVarInt(playerid, "validticket", 1);
        new str[128];
        format(str, 64, "SUPPORT: %s oferuje Ci pomoc, skorzystaj z tego!", GetNick(playerid));
        SendClientMessage(pid, COLOR_YELLOW, str);
        format(str, 128, "SUPPORT: Pomagasz teraz %s. Aby wr�ci� do poprzedniej pozycji wpisz /ticketend.", GetNick(pid));
        SendClientMessage(playerid, COLOR_YELLOW, str);
		if(GetPVarInt(playerid, "dutyadmin") == 1)
		{
			iloscZapytaj[playerid] = iloscZapytaj[playerid]+1;
		}

		SendClientMessage(playerid, COLOR_YELLOW, "Pe�na tre�� pytania:");
		format(str, sizeof(str), "%s", TICKET[id][suppDesc]);
		SendClientMessage(playerid, COLOR_YELLOW, str);

        return 1;
    }
//====================[KONTO BANKOWE]========================================
//By Simeone 25-12-2018
	//==================[G��WNE OKNO DIALOGOWE]=======================================
	else if(dialogid == 1067)
	{
		if(response)
        {
			//Zmienne u�yte do dzia�ania dialogu
			new string[128];
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			new FracGracza = PlayerInfo[playerid][pLider];
		
            switch(listitem)
            {
				
				
				//dzia�anie dialogu
                case 0://Stan konta
				{
					format(string, sizeof(string), "{C0C0C0}Witaj {800080}%s{C0C0C0},\nObecny stan konta: {80FF00}%d$", giveplayer, PlayerInfo[playerid][pAccount]);
					ShowPlayerDialogEx(playerid, 1080, DIALOG_STYLE_MSGBOX, "Stan Konta", string, "Okej", "");
				}
                case 1://Wp�a�
				{
					format(string, sizeof(string), "Konto Bankowe >> %s", giveplayer);
					ShowPlayerDialogEx(playerid, 1068, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej kwot�, kt�r� chcesz wp�aci�", "Wykonaj", "Odrzu�");
				}
                case 2://Wyp�a�
				{
					
					format(string, sizeof(string), "Konto Bankowe >> %s", giveplayer);
					ShowPlayerDialogEx(playerid, 1071, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej kwot�, kt�r� chcesz wyp�aci�", "Wykonaj", "Odrzu�");
				}
                case 3://Przelew do osoby
				{
					
					format(string, sizeof(string), "Konto Bankowe >> %s >> Przelew", giveplayer);
					ShowPlayerDialogEx(playerid, 1072, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej ID odbiorcy", "Wykonaj", "Odrzu�");
				}
				case 4://>>Konto frakcji
				{
					if(GetPlayerFraction(playerid) != 0)
					{
						if(PlayerInfo[playerid][pLider] != 0)
						{
							if(PlayerInfo[playerid][pLiderValue] < 3)
							{
								format(string, sizeof(string), ">> %s >> %s", giveplayer, FractionNames[FracGracza]);
								ShowPlayerDialogEx(playerid, 1069, DIALOG_STYLE_LIST, string, "Stan Konta\nPrzelew do osoby\nPrzelew do frakcji\nWp�a�\nWyp�a�\nWp�a� materia�y\nWyp�a� materia�y\n<< Twoje konto", "Wybierz", "Wyjd�");
							}
							else 
							{
								sendErrorMessage(playerid, "Nie mo�esz zarz�dza� kontem twojej frakcji!"); 
								return 1;
							}

						}
						else
						{
							sendErrorMessage(playerid, "Nie jeste� liderem frakcji!"); 
							return 1;
						}
					}	
					else
					{
						sendErrorMessage(playerid, "Nie jeste� we frakcji!");
						return 1;
					}
					
				}
				case 5://Konto rodziny
				{
					sendTipMessage(playerid, "U�yj /sejf!"); 
				}
				
            }
			return 1;
        }
	
	}
	//===============[WP�ATA NA SWOJE KONTO]=========================
	else if(dialogid == 1068)
	{
		if(response)
	    {
			if(gPlayerLogged[playerid] == 1)
			{
				new string[128];
				new money = strval(inputtext);
				money = FunkcjaK(inputtext);//--Funkcja wp�acania na k
				if (money > kaska[playerid] || money < 1)
				{
					sendTipMessage(playerid, "Nie masz tyle \\ B��dna kwota!");
					return 1;
				}
				if(PlayerInfo[playerid][pAccount] + money > 2_000_000_000)
				{
					sendTipMessage(playerid, "Konto bankowe przepe�nione, mo�emy przechowywa� nie wi�cej ni� 2 miliardy!");
					return 1;
				}
				ZabierzKase(playerid, money);
				new currentFunds = PlayerInfo[playerid][pAccount];
				SendClientMessage(playerid, COLOR_WHITE, "|___ {80FF00}STAN KONTA {FFFFFF}___|");
				format(string, sizeof(string), "  Poprzedni stan: {80FF00}$%d", currentFunds);
				SendClientMessage(playerid, COLOR_GRAD2, string);
				PlayerInfo[playerid][pAccount] = money + PlayerInfo[playerid][pAccount];
				format(string, sizeof(string), "  Depozyt: {80FF00}$%d", money);
				SendClientMessage(playerid, COLOR_GRAD4, string);
				SendClientMessage(playerid, COLOR_GRAD6, "|-----------------------------------------|");
				format(string, sizeof(string), "  Nowy stan: {80FF00}$%d", PlayerInfo[playerid][pAccount]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				
				Log(payLog, INFO, "%s wp�aci� na swoje konto %d$. Nowy stan: %d$",
					GetPlayerLogName(playerid),
					money, 
					PlayerInfo[playerid][pAccount]);
			}	
			return 1;
		}
	}
	//====================[DIALOG === KONTO FRAKCJI]==============================
	else if(dialogid == 1069)
	{
		if(response)
        {
		
			//Zmienne i funkcje
			new FracGracza = PlayerInfo[playerid][pLider];//Nazwa frakcji gracza
			new string[256];
			new StanSejfuFrac[128];//drugi string specjalnie do stanu konta frakcji
			new stan = Sejf_Frakcji[GetPlayerFraction(playerid)];//Stan sejfu frakcji
			new stanmats = Frakcja_Mats[GetPlayerFraction(playerid)];
			new giveplayer[MAX_PLAYER_NAME];//Gracz odbieraj�cy
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
            switch(listitem)
            {
				
				
				//Case'y i dzia�anie kodu
				
				case 0://=======================>>Sprawd� stan konta organizacji
				{	
					format(string, sizeof(string), "{C0C0C0}Witaj {800080}%s{C0C0C0},\nPomy�lnie zalogowano na:{80FF00}%s\n{C0C0C0}Obecny stan konta: {80FF00}%d$\n{C0C0C0}Obecny stan materia��w: {80FFFF}%d", giveplayer, FractionNames[FracGracza], stan, stanmats);
					ShowPlayerDialogEx(playerid, 1080, DIALOG_STYLE_MSGBOX, "Stan Konta", string, "Okej", "");
				}
				case 1://=======================>>Przelew z konta frakcji na konto gracza
				{
					
					format(string, sizeof(string), ">> %s", FractionNames[FracGracza]);
					ShowPlayerDialogEx(playerid, 1075, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej ID odbiorcy", "Wykonaj", "Odrzu�");
				}
				case 2://=======================>>Przelew z konta frakcji na konto frakcji 
				{
					if(IsAPrzestepca(playerid))
					{
						sendTipMessage(playerid, "Organizacje przest�pcze musz� znale�� lepszy (cichszy) spos�b na przelew"); 
						return 1;
					}
					format(string, sizeof(string), ">> %s", FractionNames[FracGracza]);
					ShowPlayerDialogEx(playerid, 1098, DIALOG_STYLE_LIST, string, "LSPD\nFBI\nLSFD\nLSMC\nDMV\nUSSS\nSN\nKT\nNOA", "Dalej", "Powr�t"); 
				
				}
				case 3://=======================>>Wp�a� na konto frakcji
				{
					format(string, sizeof(string), "%s", FractionNames[FracGracza]); 
					ShowPlayerDialogEx(playerid, 1077, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej kwot�, jak� chcesz wp�aci�", "Wykonaj", "Odrzu�"); 
				}
				case 4://=======================>>Wyp�a� z konta frakcji
				{
					
					
					format(string, sizeof(string), "%s", FractionNames[FracGracza]);
					format(StanSejfuFrac, sizeof(StanSejfuFrac), "Stan konta: {80FF00}%d\n{C0C0C0}Wpisz poni�ej kwot� jak� chcesz wyp�aci�", stan);
					ShowPlayerDialogEx(playerid, 1078, DIALOG_STYLE_INPUT, string, StanSejfuFrac, "Wykonaj", "Odrzu�"); 
				}
				case 5: { // wplac mats
					format(string, sizeof(string), "Wpisz poni�ej ilo�� materia��w, jak� chcesz wp�aci�\nIlo�� materia��w kt�re posiadasz: {80FFFF}%d", PlayerInfo[playerid][pMats]);
					ShowPlayerDialogEx(playerid, 1577, DIALOG_STYLE_INPUT, FractionNames[FracGracza], string, "Wykonaj", "Odrzu�"); 
				}
				case 6: { // wyplac mats
					format(string, sizeof(string), "Ilo�� materia��w na koncie: {80FFFF}%d\n{C0C0C0}Wpisz poni�ej ilo�� jak� chcesz wyp�aci�", stanmats);
					ShowPlayerDialogEx(playerid, 1578, DIALOG_STYLE_INPUT, FractionNames[FracGracza], string, "Wykonaj", "Odrzu�"); 
				}
				case 7://=======================>>Powr�t do g��wnego panelu
				{	
					
					format(string, sizeof(string), "Konto Bankowe >> %s", giveplayer);
					ShowPlayerDialogEx(playerid, 1067, DIALOG_STYLE_LIST, string, "Stan konta\n\nWp�a�\nWyp�a�\n>>Frakcyjne\n>>Organizacyjne", "Wybierz", "Wyjd�");
				
				}
			
			
			}
			return 1;
		}
		
	}
	//============[DIALOG - WYBIERZ DO KOGO PRZELA� KASE]===================
	//LSPD\nFBI\nLSFD\nLSMC\nDMV\nUSSS\nSN\nKT\nNOA
	else if(dialogid == 1098)
	{
		if(response)
        {
			new string[128];
			switch(listitem)
			{
				case 0:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 1);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: LSPD");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do LSPD", string, "Wykonaj", "Odrzu�"); 
				}
				case 1:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 2);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: FBI");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do FBI", string, "Wykonaj", "Odrzu�"); 
				}
				case 2:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 17);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: LSFD");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do LSFD", string, "Wykonaj", "Odrzu�"); 
				}
				case 3:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 4);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: LSMC");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do LSMC", string, "Wykonaj", "Odrzu�"); 
				}
				case 4:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 11);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: DMV");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do DMV", string, "Wykonaj", "Odrzu�"); 
				}
				case 5:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 7);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: USSS");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do USSS", string, "Wykonaj", "Odrzu�"); 
				}
				case 6:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 9);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: SN");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do SN", string, "Wykonaj", "Odrzu�"); 
				}
				case 7:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 10);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: KT");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do KT", string, "Wykonaj", "Odrzu�"); 
				}
				case 8:
				{
					SetPVarInt(playerid, "PrzelewFrakcjaFrakcja", 15);
					format(string, sizeof(string), "Wpisz w poni�szym polu kwot�,\nkt�r� masz zamiar przela�.\n\nWykonujesz przelew do frakcji: NOA");
					ShowPlayerDialogEx(playerid, 1099, DIALOG_STYLE_INPUT, "Przelew do NOA", string, "Wykonaj", "Odrzu�"); 
				}
			
			}
			return 1;
		}
	}
	else if(dialogid == 1099)
	{
		if(response)
		{
			new string[128];
			new bigstring[256];
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid);
			new frac = GetPVarInt(playerid, "PrzelewFrakcjaFrakcja");
			if(money > 0)
			{
				if(frac == frakcja)
				{
					sendErrorMessage(playerid, "Nie mo�esz przela� got�wki do w�asnej frakcji!"); 
					return 1;
				}
				if(Sejf_Frakcji[frakcja] < money)
				{
					sendErrorMessage(playerid, "W sejfie twojej frakcji nie ma a� takiej ilo�ci got�wki!"); 
					return 1;
				}
				if(Sejf_Frakcji[frac] >= 1_500_000_000)
				{
					format(string, sizeof(string), "Sejf %s wylewa si�! Kwota 1,5kkk przekroczona", FractionNames[frac]);
					sendErrorMessage(playerid, string);
					return 1;
				}
				//KOMUNIKATY:
				format(string, sizeof(string), "Dokona�e� przelewu na konto frakcji %s w wysoko�ci %d", FractionNames[frac], money);
				sendTipMessage(playerid, string);
				
				
				format(bigstring, sizeof(bigstring), "%s dokona� przelewu na konto %s z konta %s w wysoko�ci %d",
				GetNickEx(playerid),
				FractionNames[frac], 
				FractionNames[frakcja], money);
				SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, bigstring);
				
				format(bigstring, sizeof(bigstring), "Twoja frakcja otrzyma�a przelew od lidera %s [%s] w wysoko�ci %d", 
				FractionNames[frakcja],
				GetNickEx(playerid), money);
				
				SendLeaderRadioMessage(frac, COLOR_RED, "===================================");
				SendLeaderRadioMessage(frac, COLOR_LIGHTGREEN, bigstring);
				SendLeaderRadioMessage(frac, COLOR_RED, "==================================="); 
				
				//LOG
				Log(payLog, INFO, "%s przela� do sejfu frakcji %s kwot� %d$. Nowy stan: %d$",
					GetPlayerLogName(playerid),
					GetFractionLogName(frakcja),
					money,
					Sejf_Frakcji[frakcja]);
				
				//Powiadomienie dla admin�w
				if(money >= 2_500_000)
				{
					SendAdminMessage(COLOR_GREEN, "============[ADM-LOG]===========");
					format(string, sizeof(string), "Przelewaj�cy: %s [%d]", GetNickEx(playerid), playerid);
					SendAdminMessage(COLOR_WHITE, string);
					format(string, sizeof(string), "Z konta: %s", FractionNames[frakcja]);
					SendAdminMessage(COLOR_WHITE, string);
					format(string, sizeof(string), "Na konto: %s", FractionNames[frac]);
					SendAdminMessage(COLOR_WHITE, string);
					format(string, sizeof(string), "Kwota: %d", money);
					SendAdminMessage(COLOR_WHITE, string);
					SendAdminMessage(COLOR_GREEN, "================================");
				}
				//czynno�ci
				Sejf_Add(frac, money);
				Sejf_Add(frakcja, -money);
				Sejf_Save(frac);
				Sejf_Save(frakcja);
			}
			else
			{
				sendTipMessage(playerid, "B��dna kwota");
			}
		}
		else
		{
			sendTipMessage(playerid, "Odrzucono akcj� przelewu"); 
			return 1;
		}
	
	}
	//============[DIALOG INFORMACYJNY (INFO) -> Zwrot Marcepana]============
	else if(dialogid == 1080)
	{
		if(response)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Marcepan Marks m�wi: Do zobaczenia!");
			return 1;
        }
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "Marcepan Marks m�wi: Do zobaczenia! Zapraszamy ponownie do Verte Bank");
			return 1;
		}
       
	
	}
	/*else if(dialogid == 10001)
	{
		if(response)
		{
			if(gPlayerLogged[playerid] == 1)
			{
				if(strlen(inputtext) >= 3)
				{
					if(SprawdzZnaki(inputtext) == 0)
					{
						new nickAdminStatus; 
						foreach(new i : Player)
						{
							if(strfind(GetNick(i), inputtext) == -1)
							{
								nickAdminStatus = 0; 	
							}
							else
							{
								sendErrorMessage(playerid, "Taki nick jest ju� u�ywany!"); 
								return 1;
							}
						}
						if(nickAdminStatus == 0)
						{
							strdel(PlayerInfo[playerid][pAdminName], 0, MAX_PLAYER_NAME); 
							mysql_real_escape_string(inputtext, PlayerInfo[playerid][pAdminName]);
							return 1;
						}
					}
					else
					{
						sendErrorMessage(playerid, "U�y�e� nieodpowiednich znak�w!"); 
						return 1;
					}
				}
				else
				{
					sendErrorMessage(playerid, "Zbyt kr�tka/d�uga liczba znak�w w nicku"); 
					return 1;
				}
			}
		}
		return 1;
	}*/ 
	else if(dialogid == 1071)//wyp�ata z swojego konta
	{
		if(response)
	    {
			if(gPlayerLogged[playerid] == 1)
			{
				new string[128];
				new money = strval(inputtext);
				money = FunkcjaK(inputtext);//--Funkcja wp�acania na k
				
				if (money > PlayerInfo[playerid][pAccount] || money < 1)//Zabezpieczenie
				{
					sendTipMessage(playerid, "Nie masz tyle \\ B��dna kwota");
					return 1;
				}
				
				//Komunikaty:
				new currentFunds = PlayerInfo[playerid][pAccount];
				SendClientMessage(playerid, COLOR_WHITE, "|___ {80FF00}STAN KONTA {FFFFFF}___|");
				format(string, sizeof(string), "  Poprzedni stan: {80FF00}$%d", currentFunds);
				SendClientMessage(playerid, COLOR_GRAD2, string);
				format(string, sizeof(string), "  Depozyt: {80FF00}$-%d", money);
				SendClientMessage(playerid, COLOR_GRAD4, string);
				//Czynno�ci:
				DajKase(playerid, money);
				PlayerInfo[playerid][pAccount] -= money;
				//Komunikaty:
				SendClientMessage(playerid, COLOR_GRAD6, "|-----------------------------------------|");
				format(string, sizeof(string), "  Nowy stan: {80FF00}$%d", PlayerInfo[playerid][pAccount]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				
				Log(payLog, INFO, "%s wyp�aci� ze swojego konta %d$. Nowu stan: %d$", 
					GetPlayerLogName(playerid), 
					money, 
					PlayerInfo[playerid][pAccount]);
			}	
			return 1;
		}
	
	}
	else if(dialogid == 9992)
	{
		if(!response)
		{
			sendTipMessage(playerid, "Wy��czono system actor�w"); 
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					sendTipMessage(playerid, "Dost�pne ju� wkr�tce"); 
				}
				case 1:
				{
					sendTipMessage(playerid, "Dost�pne ju� wkr�tce");
				}
				case 2:
				{
					sendTipMessage(playerid, "Ta opcja zostanie dodana ju� niebawem!");
				}
				case 3:
				{
					sendTipMessage(playerid, "Ta opcja zostanie dodana ju� niebawem!");
				}
				case 4:
				{
					sendTipMessage(playerid, "Ta opcja zostanie dodana ju� niebawem!");
				}
			}
		}
	}
	else if(dialogid == DIALOG_EMPTY_SC)
	{
		if(!response)
		{
			return 1;
		}
		else
		{
			return 1;
		}
	}
	//============[PRZELEWY OD GRACZA DO GRACZA = ID ODBIORCY]===================================
	else if(dialogid == 1072)//Przelew
	{
		if(!response)
	    {
			sendErrorMessage(playerid, "Odrzucono akcje przelewu!");
		}
		else//Je�li przejdzie dalej
		{
			new string[128];
			new giveplayerid = strval(inputtext);
			if(GetPlayerVirtualWorld(giveplayerid) == 1488)
			{
				sendErrorMessage(playerid, "Ten gracz jest w trakcie logowania!"); 
				return 1;
			}
			if (IsPlayerConnected(giveplayerid) && gPlayerLogged[giveplayerid])
			{
				if(giveplayerid != playerid)
				{
					SetPVarInt(playerid, PVAR_PRZELEW_ID, giveplayerid);
					format(string, sizeof(string), "Wpisz poni�ej sum�, ktor� chcesz przela� do %s", GetNick(giveplayerid));
					ShowPlayerDialogEx(playerid, 1073, DIALOG_STYLE_INPUT, ">>Przelew >> 1  >> 2 ", string, "Wykonaj", "Odrzu�");
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo�esz przela� got�wki samemu sobie!");
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza!"); 
				return 1;
			}
			return 1;
		}
	
	
	}
	//================[PRZELEWY DO GRACZA OD GRACZA = Czynno�ci + Kwota przelewu]========================
	else if(dialogid == 1073)
	{
		if(!response)
	    {
			sendErrorMessage(playerid, "Odrzucono akcje przelewu!"); 
		}
		else//Je�li kliknie "TAK"
		{
			new string[256];
			new sendername[MAX_PLAYER_NAME];
			new giveplayer[MAX_PLAYER_NAME];
			new giveplayerid = GetPVarInt(playerid, PVAR_PRZELEW_ID);
			new money = FunkcjaK(inputtext);//Zbugowany string 
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			
			if(money >= 1 && money <= PlayerInfo[playerid][pAccount])//Zabezpieczenie 
			{
				if(PlayerInfo[giveplayerid][pAccount]+money > MAX_MONEY_IN_BANK)
				{
					sendErrorMessage(playerid, "Gracz do kt�rego pr�bowa�e� przela� got�wk� - ma zbyt du�o pieni�dzy na koncie."); 
					return 1;
				}
				if(!IsPlayerConnected(giveplayerid))
				{
					sendErrorMessage(playerid, "Gracz, do kt�rego pr�bowa�e� przela� got�wk� wyszed� z serwera!"); 
					return 1;
				}
				//Czynno�ci:
				PlayerInfo[playerid][pAccount] -= money;
				PlayerInfo[giveplayerid][pAccount] += money;
				
				//komunikaty:
				format(string, sizeof(string), "Otrzyma�e� przelew w wysoko�ci %d$ od %s . Pieni�dze znajduj� si� na twoim koncie.", money, sendername);
				SendClientMessage(giveplayerid, COLOR_RED, string);
				
				format(string, sizeof(string), "Wys�a�e� przelew dla %s w wysoko�ci %d$. Pieni�dze zosta�y pobrane z twojego konta bankowego", giveplayer, money);
				SendClientMessage(playerid, COLOR_RED, string); 
				
				Log(payLog, INFO, "%s przela� %s kwot� %d$", 
					GetPlayerLogName(playerid),
					GetPlayerLogName(giveplayerid),
					money);
				
				if(money >= 5_000_000)//Wiadomosc dla adminow
				{
					format(string, sizeof(string), "Gracz %s wys�a� przelew do %s w wysoko�ci %d$", GetNick(playerid), GetNick(giveplayerid), money); 
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
			}
			else//Je�li pr�buje oszuka� (brak got�wki, b��dnie wpisana kwota)
			{
				sendErrorMessage(playerid, "B��dna kwota || Nie masz takiej ilo�ci got�wki na swoim koncie!"); 
				return 1;
			}
			return 1;
		}
		
	
	
	}
	//=================[DIALOG ZWROTNY --> Zwraca nas do "Twoje Konto"]=================
	else if(dialogid == 1074)
	{
		if(response)
		{
			new string[128];
			new giveplayer[MAX_PLAYER_NAME];
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			new frakcja = PlayerInfo[playerid][pLider];
			format(string, sizeof(string), ">> %s >> %s", giveplayer, FractionNames[frakcja]);
			ShowPlayerDialogEx(playerid, 1069, DIALOG_STYLE_LIST, string, "Stan Konta\nPrzelew do osoby\nPrzelew do frakcji\nWp�a�\nWyp�a�\nWp�a� materia�y\nWyp�a� materia�y\n<< Twoje konto", "Wybierz", "Wyjd�");
			return 1;
		}

	}
	else if(dialogid == 1075)//Pobieranie ID odbiorcy - przelew z konta frakcji
	{
		if(!response)
	    {
			sendErrorMessage(playerid, "Nie uzupe�ni�e� ID odbiorcy!"); 
		}
		else
		{
			new string[128];
			new frakcja = PlayerInfo[playerid][pLider];
			new giveplayerid = strval(inputtext);
			if(IsPlayerConnected(giveplayerid) && gPlayerLogged[giveplayerid])
			{
				SetPVarInt(playerid, PVAR_PRZELEW_ID, giveplayerid);
				format(string, sizeof(string), "Odbiorca: %s\nWysy�aj�cy: %s\nWpisz poni�ej kwot�, kt�ra ma zosta� przelana na jego konto.", GetNick(giveplayerid), FractionNames[frakcja]); 
				ShowPlayerDialogEx(playerid, 1076, DIALOG_STYLE_INPUT, "Przelewy frakcji >> ID >> Kwota", string, "Wykonaj", "Odrzu�"); 
				
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma na serwerze takiego gracza!"); 
				return 1;
			}
			return 1;
		}
	}
	else if(dialogid == 1076)//Wpisywanie kwoty i ca�o�� funkcji - przelew z konta organizacji na gracza
	{
		if(!response)
		{
		
			sendErrorMessage(playerid, "Odrzucono akcj� przelewu"); 
			return 1;
		}
		else
		{
			new string[256];
			new sendername[MAX_PLAYER_NAME];//Nadawca
			new giveplayer[MAX_PLAYER_NAME];//Odbiorca
			new giveplayerid = GetPVarInt(playerid, PVAR_PRZELEW_ID);
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid);
			
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			
			if(money <= 0 || money > Sejf_Frakcji[frakcja])
			{
				sendErrorMessage(playerid, "Nieprawid�owa kwota przelewu!"); 
				return 1;
			}
			if(!IsPlayerConnected(giveplayerid))
			{
				sendErrorMessage(playerid, "Gracz, do kt�rego pr�bowa�e� przela� got�wk� wyszed� z serwera!"); 
				return 1;
			}
			if(PlayerInfo[giveplayerid][pAccount]+money > MAX_MONEY_IN_BANK)
			{
				sendErrorMessage(playerid, "Gracz do kt�rego pr�bowa�e� przela� got�wk� - ma zbyt du�o pieni�dzy na koncie."); 
				return 1;
			}
			
			PlayerInfo[giveplayerid][pAccount] += money;
			Sejf_Add(frakcja, -money);
			Sejf_Save(frakcja);
			
			format(string, sizeof(string), ">>>Otrzyma�e� przelew w wysoko�ci %d$, od lidera %s -> %s", money, FractionNames[frakcja], sendername); 
			SendClientMessage(giveplayerid, COLOR_RED, string);
			
			format(string, sizeof(string), ">>>Wys�a�e� przelew w wysoko�ci %d$, na konto %s, z konta %s", money, giveplayer, FractionNames[frakcja]); 
			SendClientMessage(playerid, COLOR_RED, string);
			
			format(string, sizeof(string), ">>>Lider %s[%d] wys�a� %d$ na konto %s[%d]", sendername, playerid, money, giveplayer, giveplayerid);
			SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string);
			
			Log(payLog, INFO, "%s przela� z sejfu frakcji %s na konto gracza %s kwot� %d$. Nowy stan: %d$",
				GetPlayerLogName(playerid),
				GetFractionLogName(frakcja),
				GetPlayerLogName(giveplayerid),
				money,
				Sejf_Frakcji[frakcja]);
				
			if(money >= 2500000)//Warning dla admin�w, gdy gracz przekroczy 2.5kk 
			{
				SendAdminMessage(COLOR_YELLOW, "|======[ADM-WARNING]======|"); 
				format(string, sizeof(string), "%s[%d] wykona� przelew %d$ na konto %s[%d]", sendername, playerid, money, giveplayer, giveplayerid); 
				SendAdminMessage(COLOR_WHITE, string); 
				format(string, sizeof(string), "Frakcja gracza(z sejfu): %s", FractionNames[frakcja]);
				SendAdminMessage(COLOR_WHITE, string);
				SendAdminMessage(COLOR_YELLOW, "|=========================|");
			}
			return 1;
		}
	}
	//=================[WP�ATA NA KONTO ORGANIZACJI]=================
	else if(dialogid == 1077)
	{
		if(!response)
		{
		
			sendErrorMessage(playerid, "Odrzucono akcj� wp�aty"); 
			return 1;
		}
		else
		{
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid);
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(money >= 1)
			{
				if(money <= kaska[playerid])
				{
					new string[128];
					Sejf_Add(frakcja, money);
					Sejf_Save(frakcja);
					ZabierzKase(playerid, money); 
					format(string, sizeof(string), "Lider %s wp�aci� %d$ na konto organizacji", sendername, money); 
					SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string); 
					
					Log(payLog, INFO, "%s wp�aci� na konto frakcji %s kwot� %d$. Nowy stan: %d$", 
						GetPlayerLogName(playerid),
						GetFractionLogName(frakcja),
						money,
						Sejf_Frakcji[frakcja]);
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz tyle!"); 
					return 1;
				}
			
			}
			else
			{
				sendErrorMessage(playerid, "B��dna kwota transakcji");
				return 1;
			}
		
			return 1;
		}
	
	
	}
	else if(dialogid == 1077)
	{
		if(!response)
		{
		
			sendErrorMessage(playerid, "Odrzucono akcj� wp�aty"); 
			return 1;
		}
		else
		{
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid);
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(money >= 1)
			{
				if(money <= kaska[playerid])
				{
					new string[128];
					Sejf_Add(frakcja, money);
					Sejf_Save(frakcja);
					ZabierzKase(playerid, money); 
					format(string, sizeof(string), "Lider %s wp�aci� %d$ na konto organizacji", sendername, money); 
					SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string); 
					
					Log(payLog, INFO, "%s wp�aci� na konto frakcji %s kwot� %d$. Nowy stan: %d$", 
						GetPlayerLogName(playerid),
						GetFractionLogName(frakcja),
						money,
						Sejf_Frakcji[frakcja]);
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz tyle!"); 
					return 1;
				}
			
			}
			else
			{
				sendErrorMessage(playerid, "B��dna kwota transakcji");
				return 1;
			}
		
			return 1;
		}
	
	
	}
	else if(dialogid == 1577) // wplata matsow
	{
		if(!response)
		{
			sendErrorMessage(playerid, "Odrzucono akcj� wp�aty"); 
			return 1;
		}
		else
		{
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid);
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(money >= 1)
			{
				if(money <= PlayerInfo[playerid][pMats])
				{
					new string[128];
					Sejf_AddMats(frakcja, money);
					Sejf_Save(frakcja);
					PlayerInfo[playerid][pMats] -= money; 
					format(string, sizeof(string), "Lider %s wp�aci� %d mats�w na konto organizacji", sendername, money); 
					SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string); 
					
					Log(payLog, INFO, "%s wp�aci� na konto frakcji %s %d mats. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetFractionLogName(frakcja),
						money,
						Frakcja_Mats[frakcja]);
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz tyle materia��w!"); 
					return 1;
				}
			
			}
			else
			{
				sendErrorMessage(playerid, "B��dna kwota transakcji");
				return 1;
			}
		
			return 1;
		}
	
	
	}
	//=================[WyP�ATA Z KONTA ORGANIZACJI]=================
	else if(dialogid == 1078)
	{
		if(!response)
		{
			sendErrorMessage(playerid, "Odrzucono akcj� wyp�aty"); 
			return 1;
		}
		else
		{
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid); 
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(money >= 1)
			{
				if(money <= Sejf_Frakcji[frakcja])
				{
					new string[128];
					Sejf_Add(frakcja, -money);
					Sejf_Save(frakcja);
					DajKase(playerid, money); 
					format(string, sizeof(string), "Lider %s wyp�aci� %d$ z konta organizacji", sendername, money); 
					SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string); 
					
					Log(payLog, INFO, "%s wyp�aci� z konta frakcji %s kwot� %d$. Nowy stan: %d$", 
						GetPlayerLogName(playerid),
						GetFractionLogName(frakcja),
						money,
						Sejf_Frakcji[frakcja]);
					
					if(money >= 2000000)
					{
						
						SendAdminMessage(COLOR_YELLOW, "|======[ADM-WARNING]======|");
						SendAdminMessage(COLOR_WHITE, string);
						SendAdminMessage(COLOR_YELLOW, "|=========================|");
						
					
					}
				}
				else
				{
					sendErrorMessage(playerid, "W sejfie twojej organizacji nie ma takiej kwoty!"); 
					return 1;
				}
			
			}
			else
			{
				sendErrorMessage(playerid, "B��dna kwota transakcji!");
				return 1;
			}
		
			return 1;
		}
	}
	else if(dialogid == 1578) // wyplata mats
	{
		if(!response)
		{
			sendErrorMessage(playerid, "Odrzucono akcj� wyp�aty"); 
			return 1;
		}
		else
		{
			new money = FunkcjaK(inputtext);
			new frakcja = GetPlayerFraction(playerid); 
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(money >= 1)
			{
				if(money <= Frakcja_Mats[frakcja])
				{
					new string[128];
					Sejf_AddMats(frakcja, -money);
					Sejf_Save(frakcja);
					PlayerInfo[playerid][pMats] += money; 
					format(string, sizeof(string), "Lider %s wyp�aci� %d mats z konta organizacji", sendername, money); 
					SendLeaderRadioMessage(frakcja, COLOR_LIGHTGREEN, string); 
					
					Log(payLog, INFO, "%s wyp�aci� z konta frakcji %s %d mats. Nowy stan: %d", 
						GetPlayerLogName(playerid),
						GetFractionLogName(frakcja),
						money,
						Frakcja_Mats[frakcja]);
					
					if(money >= 2000000)
					{
						
						SendAdminMessage(COLOR_YELLOW, "|======[ADM-WARNING]======|");
						SendAdminMessage(COLOR_WHITE, string);
						SendAdminMessage(COLOR_YELLOW, "|=========================|");
						
					
					}
				}
				else
				{
					sendErrorMessage(playerid, "W sejfie twojej organizacji nie ma tylu materia��w!"); 
					return 1;
				}
			
			}
			else
			{
				sendErrorMessage(playerid, "B��dna kwota transakcji!");
				return 1;
			}
		
			return 1;
		}
	}
//=================[KONIEC]========================
	else if(dialogid == 1090)//Dialog do kupna bilet�w KT --> Poci�g
	{
		if(!response)
        {
			new string[128];
            format(string, sizeof(string), "* %s jest strasznie rozstargniony i zdecydowa� odej�� od maszyny bez biletu.", GetNick(playerid));//Ciekawostka - niezdecydowany
			ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			return 1;
        }
		else
		{
			if(IsAtTicketMachine(playerid))
			{
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(kaska[playerid] >= CenaBiletuPociag)				        
				{
					ZabierzKase(playerid, CenaBiletuPociag);
					Sejf_Add(FRAC_KT, TransportValue[playerid]);//Posiada wewn�trzne Sejf_Save
					PlayerInfo[playerid][pBiletpociag] = 1;
					new string[128]; 
					format(string, sizeof(string), "Zakupi�e� bilet za %d$", CenaBiletuPociag); 
					sendTipMessage(playerid, string);
					format(string, sizeof(string), "%s[ID: %d] zakupi� bilet za %d$", sendername, playerid, CenaBiletuPociag); 
					SendLeaderRadioMessage(FRAC_KT, COLOR_LIGHTGREEN, string);
						
					format(string, sizeof(string), "* %s zakupi� bilet do poci�gu za %d$, schowa� go do kieszeni.", GetNick(playerid), CenaBiletuPociag);
					ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz wystarczaj�cej ilo�ci got�wki!"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie jeste� przy maszynie do kupna bilet�w!"); 
				return 1;
			}
		}
	}
	else if(dialogid == 1091)
	{
		if(!response)
        {
			sendErrorMessage(playerid, "Aby zej�� ze s�u�by wpisz /adminduty"); 
			return 1;
        }
	
	}
    else if(dialogid == 7079)
	{
		if(response)
		{
		    if(HireCar[playerid] == 0)
			{
			    TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicleEx(playerid);
				HireCar[playerid] = 0;
				return 0;
			}
    		new veh = HireCar[playerid];
    		if(veh == 0) return 1;
    		if(Car_GetOwner(veh) != RENT_CAR || Car_GetOwnerType(veh) != CAR_OWNER_SPECIAL)
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Tego pojazdu nie mo�na wypo�yczy�.");
				TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicleEx(playerid);
				HireCar[playerid] = 0;
				return 0;
			}
    		if(CarData[VehicleUID[veh][vUID]][c_Rang] != 0)
			{
			    sendTipMessageEx(playerid, COLOR_GRAD2, "Ten pojazd jest aktualnie wypo�yczony przez inn� osob�.");
			    TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicleEx(playerid);
				HireCar[playerid] = 0;
				return 0;
			}
   			if(GetPVarInt(playerid, "rentTimer") != 0)
   			{
   				sendTipMessageEx(playerid, COLOR_GRAD2, "Aktualnie wypo�yczasz pewien pojazd.");
   				TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicleEx(playerid);
				HireCar[playerid] = 0;
				return 0;
			}
			new cost = GetVehicleHireCost(veh);
			if(kaska[playerid] < cost)
   			{
   				sendErrorMessage(playerid, "Nie masz tyle kasy!");
				return 0;
			}
    		CarData[VehicleUID[veh][vUID]][c_Rang] = (playerid+1);

    		SetPVarInt(playerid, "rentTimer", SetTimerEx("UnhireRentCar", 60*60*1000, 0, "ii", playerid, veh));

    		TogglePlayerControllable(playerid, 1);
    		ZabierzKase(playerid, cost); 
    		HireCar[playerid] = veh;
    		SetPVarInt(playerid, "rentCar", veh);
		}
		if(!response)
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "Odrzuci�e� propozycj� wypo�yczenia pojazdu.");
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicleEx(playerid);
			HireCar[playerid] = 0;
		}
	}
	else if(dialogid == 1012)
	{
		if(!response)
		{
			sendTipMessage(playerid, "Wy��czy�e� dialog tras"); 
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerCheckpoint(playerid, 2005.9244,-1442.3917,13.5631, 3);
					sendTipMessage(playerid, "Trasa rozpoczyna si� spod szpitala, udaj si� tam!");
					sendTipMessage(playerid, "Aby anulowa� wpisz /stopbieg"); 
					SetPVarInt(playerid, "RozpoczalBieg", 1);
				}
				case 1:
				{
					SetPlayerCheckpoint(playerid, 806.4952,-1334.9512,13.5469, 3);
					sendTipMessage(playerid, "Trasa rozpoczyna si� spod metra udaj si� tam!");
					sendTipMessage(playerid, "Aby anulowa� wpisz /stopbieg"); 
					SetPVarInt(playerid, "RozpoczalBieg", 1);
				}
				case 3:
				{
					sendTipMessage(playerid, "Aktualnie trwaj� prace nad t� tras�!"); 
				}
				case 4:
				{
					sendTipMessage(playerid, "Aktualnie trwaj� prace nad t� tras�!"); 
				}
				case 5:
				{
					sendTipMessage(playerid, "Aktualnie trwaj� prace nad t� tras�!"); 
				}
			}
			return 1;
		}
	}
	else if(dialogid == 9666)//dialog tak/nie admina
	{
		if(response)
		{
			sendTipMessage(playerid, "Zag�osowa�e� na TAK!"); 
			glosowanie_admina_tak++;
			SetPVarInt(playerid, "glosowal_w_ankiecie", 1);
			return 1;
		}
		if(!response)
		{
			sendTipMessage(playerid, "Zag�osowa�e� na NIE!"); 
			glosowanie_admina_nie++;
			SetPVarInt(playerid, "glosowal_w_ankiecie", 1); 
			return 1;
		}
	}
	else if(dialogid == D_KONTAKTY_DZWON)
	{
		if(response)
		{
			new string[12];
			format(string, sizeof(string), "%d", Kontakty[playerid][PobierzIdKontaktuZDialogu(playerid, listitem)][eNumer]);
			RunCommand(playerid, "/dzwon",  string);
		}
	}
	else if(dialogid == D_KONTAKTY_SMS)
	{
		if(response)
		{
			SetPVarInt(playerid, "kontakty-dialog-slot", PobierzIdKontaktuZDialogu(playerid, listitem));
			ShowPlayerDialogEx(playerid, D_KONTAKTY_SMS_WIADOMOSC, DIALOG_STYLE_INPUT, "Kontakty - SMS", "Wprowad� wiadomo��:", "Wy�lj SMS", "Zamknij");
		}
	}
	else if(dialogid == D_KONTAKTY_SMS_WIADOMOSC)
	{
		if(response)
		{
			new string[256];
			format(string, sizeof(string), "%d %s", Kontakty[playerid][GetPVarInt(playerid, "kontakty-dialog-slot")][eNumer], inputtext);
			RunCommand(playerid, "/sms",  string);
		}
	}
	else if(dialogid == D_KONTAKTY_EDYTUJ)
	{
		if(response)
		{
			SetPVarInt(playerid, "kontakty-dialog-slot", PobierzIdKontaktuZDialogu(playerid, listitem));
			ShowPlayerDialogEx(playerid, D_KONTAKTY_EDYTUJ_NOWA_NAZWA, DIALOG_STYLE_INPUT, "Kontakty - edytuj", "Wprowad� now� nazw� kontaktu.\nMaksymalnie "#MAX_KONTAKT_NAME" znaki", "Zmie�", "Anuluj");
		}
	}
	else if(dialogid == D_KONTAKTY_EDYTUJ_NOWA_NAZWA)
	{
		if(response)
		{
			EdytujKontakt(playerid, GetPVarInt(playerid, "kontakty-dialog-slot"), inputtext);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kontakt edytowany.");
		}
	}
	else if(dialogid == D_KONTAKTY_USUN)
	{
		if(response)
		{
			UsunKontakt(playerid, PobierzIdKontaktuZDialogu(playerid, listitem));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kontakt usuni�ty.");
		}
	}
	else if(dialogid == D_KONTAKTY_LISTA)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_WHITE, inputtext);
		}
	}
	else if(dialogid == D_PERSONALIZE)
	{
		if(!response)
		{
			sendTipMessage(playerid, "Wyszed�e� z personalizacji - ustawienia zapisane"); 
			return 1;
		}
		else if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPersonalization(playerid, 1); 
				}
				case 1:
				{
					ShowPersonalization(playerid, 2); 
				}
				case 2:
				{
					if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pNewAP] == 0)
					{
						sendTipMessage(playerid, "Nie jeste� administratorem"); 
						return 1;
					}
					ShowPersonalization(playerid, 3); 
				}
				case 3:
				{
					ShowPersonalization(playerid, 4); 
				}
			}
		}
	}
	else if(dialogid == D_PERS_VEH)
	{
		if(!response)
		{
			ShowPlayerDialogEx(playerid, D_PERSONALIZE, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Pojazd\nChat\nAdmin\nInne", "Akceptuj", "Wyjdz");
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerPersonalization[playerid][PERS_LICZNIK] == 0)
					{
						PlayerPersonalization[playerid][PERS_LICZNIK] = 1; 
						ToggleSpeedo[playerid] = true;
						sendTipMessage(playerid, "Wy��czy�e� wy�wietlanie licznika!"); 
					}
					else
					{
						PlayerPersonalization[playerid][PERS_LICZNIK] = 0;
						ToggleSpeedo[playerid] = false;
						sendTipMessage(playerid, "W��czy�e� wy�wietlanie licznika w wozie!");
					}
				}
				case 1:
				{
					if(PlayerPersonalization[playerid][PERS_CB] == 0)
					{
						PlayerPersonalization[playerid][PERS_CB] = 1;
						sendTipMessage(playerid, "Wy��czy�e� CB-RADIO"); 
					}
					else
					{
						PlayerPersonalization[playerid][PERS_CB] = 0;
						sendTipMessage(playerid, "W��czy�e� CB-RADIO!"); 
					}
				}
			}
		}
	}
	else if(dialogid == DIALOG_DMV)
	{
		if(!response)
		{
			ProxDetector(15.0, playerid, "Urz�dnik m�wi: Dzi�kujemy i zapraszamy ponownie!", COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
			return 1;
		}
		if(response)
		{
			new string[124];

			if(listitem < 0 || listitem > 9) return 1;

			if(kaska[playerid] < DmvLicenseCost[listitem])
			{
				sendErrorMessage(playerid, sprintf("Ta us�uga kosztuje %d$, a Ty tyle nie masz!", DmvLicenseCost[listitem]));
				return 1;
			}

			switch(listitem)
			{
				case 0: //Dow�d osobisty
				{
					PlayerInfo[playerid][pDowod] = 1;
					format(string, sizeof(string), "Urz�dnik wprowadza dane %s do komputera, drukuje laminuje i podaje dow�d osobisty", GetNick(playerid)); 
					ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					Log(payLog, INFO, "%s kupi� dow�d osobisty za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
				case 1:
				{
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}
					if(PlayerInfo[playerid][pFishLic] == 1)
					{
						sendErrorMessage(playerid, "Masz ju� kart� w�dkarsk�!"); 
						return 1;
					}

					PlayerInfo[playerid][pFishLic] = 1;
					format(string, sizeof(string), "Urz�dnik wprowadza dane %s do komputera, drukuje laminuje i podaje kart� w�dkarsk�", GetNick(playerid)); 
					ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					Log(payLog, INFO, "%s kupi� kart� w�dkarsk� za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
				case 2:
				{
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}

					PlayerInfo[playerid][pGunLic] = 1;
					format(string, sizeof(string), "Urz�dnik wprowadza dane %s do komputera, drukuje laminuje i podaje pozwolenie na bro�", GetNick(playerid)); 
					ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					Log(payLog, INFO, "%s kupi� pozwolenie na bro� za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
				case 3:
				{
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}
					
					PlayerInfo[playerid][pBoatLic] = 1;
					format(string, sizeof(string), "Urz�dnik wprowadza dane %s do komputera, drukuje laminuje i podaje patent �eglarski", GetNick(playerid)); 
					ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					Log(payLog, INFO, "%s kupi� patent �eglarski za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
				case 4:
				{
					if(PlayerInfo[playerid][pCarLic] > 1000)
					{
						new lTime = PlayerInfo[playerid][pCarLic]-gettime();
						new hh, mm;
						hh = floatround(floatround(floatdiv(lTime, 3600), floatround_floor)%24,floatround_floor);
						mm = floatround(floatround(floatdiv(lTime, 60), floatround_floor)%60,floatround_floor);
						format(string, 128, "Zosta�o Ci odebrane prawo jazdy! Blokada mija za %d h i %d min", hh, mm);
						SendClientMessage(playerid, COLOR_GRAD2, string);
						return 1;
					}
					if(PlayerInfo[playerid][pCarLic] == 2)
					{
						sendErrorMessage(playerid, "Zaliczy�e� ju� egzamin teoretyczny!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pCarLic] == 1)
					{
						sendErrorMessage(playerid, "Masz ju� prawo do jazdy!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}

					PlayerInfo[playerid][pPrawojazdypytania] = 0;
					PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
					PlayerInfo[playerid][pPrawojazdyzleodp] = 0;
					PlayerInfo[playerid][pMinalczasnazdpr] = 0;
					PlayerInfo[playerid][pWtrakcietestprawa] = 1;
					format(string, sizeof(string), "* Urz�dnik wyci�ga test oraz d�ugopis i podaje %s", GetNick(playerid));
					ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					ShowPlayerDialogEx(playerid, D_PJTEST, DIALOG_STYLE_MSGBOX, "Prawo jazdy - Test", "{7FFF00}Witaj!\n{FFFFFF}Rozpoczynasz test na prawo jazdy.\nW te�cie {FF0000}NIE U�YWAJ{FFFFFF} polskich znak�w!\n\n�yczymy powodzenia!", "Rozpocznij", "");
				}
				case 5:
				{
					if(PlayerInfo[playerid][pCarLic] != 2)
					{
						sendErrorMessage(playerid, "Najpierw podejd� do egzaminu teoretycznego!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}

					sendTipMessage(playerid, "Egzaminy praktyczne zostan� dodane ju� wkr�tce!"); 
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Gratulacje! Zda�e� egzamin praktyczny!"); 
					TakingLesson[playerid] = 0;
					PlayerInfo[playerid][pCarLic] = 3;
				}
				case 6:
				{
					if(PlayerInfo[playerid][pCarLic] < 3)
					{
						sendErrorMessage(playerid, "Najpierw podejd� do egzaminu teoretycznego/praktycznego!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pCarLic] == 1)
					{
						sendErrorMessage(playerid, "Masz ju� prawo jazdy!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}
					PlayerInfo[playerid][pCarLic] = 1;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Odebra�e� prawo do jazdy."); 
					Log(payLog, INFO, "%s kupi� licencje na pojazdy za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
				case 7:
				{
					if(PlayerInfo[playerid][pFlyLic] == 1)
					{
						sendErrorMessage(playerid, "Masz ju� licencje na latanie!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pDowod] < 1)
					{
						sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
						return 1;
					}

					PlayerInfo[playerid][pFlyLic] = 1;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Odebra�e� licencje na latanie!"); 
					Log(payLog, INFO, "%s kupi� licencje na latanie za %d$", GetPlayerLogName(playerid), DmvLicenseCost[listitem]);
				}
			}
			Sejf_Add(FRAC_GOV, DmvLicenseCost[listitem]);
			ZabierzKase(playerid, DmvLicenseCost[listitem]);
		}
	}
	else if(dialogid == D_PERS_CHAT)
	{
		if(!response)
		{
			ShowPlayerDialogEx(playerid, D_PERSONALIZE, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Pojazd\nChat\nAdmin\nInne", "Akceptuj", "Wyjdz");
			return 1;	
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerPersonalization[playerid][PERS_AD] == 0)
					{
						PlayerPersonalization[playerid][PERS_AD] = 1;
						sendTipMessage(playerid, "Wy��czy�e� wy�wietlanie og�osze� graczy!"); 
					}
					else
					{
						PlayerPersonalization[playerid][PERS_AD] = 0;
						sendTipMessage(playerid, "W��czy�e� widoczno�� og�osze� graczy!"); 
					}
				}
				case 1:
				{
					if(PlayerPersonalization[playerid][PERS_NEWBIE] == 0)
					{
						PlayerPersonalization[playerid][PERS_NEWBIE] =1;
						sendTipMessage(playerid, "Wy��czy�e� chat newbie!"); 
					}
					else
					{
						PlayerPersonalization[playerid][PERS_NEWBIE] =0;
						sendTipMessage(playerid, "W��czy�e� chat newbie!"); 
					}
				}
				case 2:
				{
					if(PlayerPersonalization[playerid][PERS_FINFO] == 0)
					{
						PlayerPersonalization[playerid][PERS_FINFO] = 1;
						sendTipMessage(playerid, "Wy��czy�e� komunikaty od frakcji"); 
					}
					else 
					{
						PlayerPersonalization[playerid][PERS_FINFO] = 0;
						sendTipMessage(playerid, "W��czy�e� komunikaty od frakcji"); 
					}
				}
			}
		}
	}
	else if(dialogid == D_PERS_ADMIN)
	{
		if(!response)
		{
			ShowPlayerDialogEx(playerid, D_PERSONALIZE, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Pojazd\nChat\nAdmin\nInne", "Akceptuj", "Wyjdz");
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerPersonalization[playerid][PERS_REPORT] == 0)
					{
						PlayerPersonalization[playerid][PERS_REPORT] = 1;
						sendTipMessage(playerid, "Wy��czy�e� widoczno�� zg�osze� graczy"); 
					}
					else if(PlayerPersonalization[playerid][PERS_REPORT] == 1)
					{
						PlayerPersonalization[playerid][PERS_REPORT] = 0;
						sendTipMessage(playerid, "W��czy�e� widoczno�� zg�osze� graczy"); 
					}
				}
				case 1:
				{
					if(PlayerPersonalization[playerid][WARNDEATH] == 0)
					{
						PlayerPersonalization[playerid][WARNDEATH] = 1;
						sendTipMessage(playerid, "Wy��czy�e� podgl�d widoczno�ci �mierci graczy"); 
					}
					else if(PlayerPersonalization[playerid][WARNDEATH] == 1)
					{
						PlayerPersonalization[playerid][WARNDEATH] =0;
						sendTipMessage(playerid, "W��czy�e� podgl�d widoczno�ci �mierci graczy!"); 
					}
				}
			}
		}
	}
	else if(dialogid == D_PERS_INNE)
	{
		if(!response)
		{
			ShowPlayerDialogEx(playerid, D_PERSONALIZE, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Pojazd\nChat\nAdmin\nInne", "Akceptuj", "Wyjdz");
			return 1;
		}
		if(response)
		{
			switch(listitem)
			{
				case 0://Konto Bankowe
				{
					if(PlayerPersonalization[playerid][PERS_KB] == 0)
					{
						PlayerPersonalization[playerid][PERS_KB]=1; 
						sendTipMessage(playerid, "Wy��czy�e� przelew za pomoc� /kb"); 
					}
					else if(PlayerPersonalization[playerid][PERS_KB] == 1)
					{
						PlayerPersonalization[playerid][PERS_KB] =0; 
						sendTipMessage(playerid, "W��czy�e� przelew za pomoc� /kb"); 
					}
				}
				case 1://NickNames
				{
					if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 0)
					{
						PlayerPersonalization[playerid][PERS_NICKNAMES] =1; 
						sendTipMessage(playerid, "Wy��czy�e� wy�wietlanie nick�w nad g�ow�!");
						SetPVarInt(playerid, "tognick", 1);
      					foreach(new i : Player)
						{
							ShowPlayerNameTagForPlayer(playerid, i, 0);
						}
					}
					else if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 1)
					{
						PlayerPersonalization[playerid][PERS_NICKNAMES] = 0; 
						sendTipMessage(playerid, "W��czy�e� wy�wietlanie nick�w nad g�ow�"); 
						SetPVarInt(playerid, "tognick", 1);
      					foreach(new i : Player)
						{
							ShowPlayerNameTagForPlayer(playerid, i, 1);
						}
					}
				
				}
				case 2:
				{
					if(togADMTXD[playerid] == 0)
					{
						togADMTXD[playerid] =1; 
						sendTipMessage(playerid, "Wy��czy�e� textdrawy kar");
						PlayerPersonalization[playerid][PERS_KARYTXD] =1;
					}
					else if(togADMTXD[playerid] == 1)
					{
						togADMTXD[playerid] =0; 
						sendTipMessage(playerid, "W��czy�e� textdrawy kar"); 
						PlayerPersonalization[playerid][PERS_KARYTXD]=0;
					}
				}
				case 3:
				{
					if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 0)
					{
						sendTipMessage(playerid, "Wy��czy�e� auto-gui po zmianie broni");
						PlayerPersonalization[playerid][PERS_GUNSCROLL] = 1;
					}
					else if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 1)
					{
						sendTipMessage(playerid, "W��czy�e� auto-gui po zmianie broni");
						PlayerPersonalization[playerid][PERS_GUNSCROLL] = 0;
					}
				}

			}
		}
	}
	else if(dialogid == D_VINYL)
	{
		if(response)
		{
			new txt_light[128], txt_neon[128], txt_sphere[128], txt_podest[128], txt_zaluzja[128];
			new txt_klub[256], txt_biuro[256], txt_dym[128], txt_eq[128], txt_txt[128];
			// KLUB
			if(lightsVinyl == false){
				format(txt_light, 128, "{FFFFFF}O�wietlenie: \t{FF0000}Wy��czone");
			}else{
				format(txt_light, 128, "{FFFFFF}O�wietlenie: \t{00FF00}W��czone");
			}
			if(neonVinyl == 0){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \tBrak");
			}
			if(neonVinyl == 1){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \tMieszane");
			}
			if(neonVinyl == 2){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \t{1E2BFE}Niebieski");
			}
			if(neonVinyl == 3){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \t{C71E09}Czerwony");
			}
			if(neonVinyl == 4){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \t{CD17F9}Fioletowy");
			}
			if(neonVinyl == 5){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \t{1CFF27}Zielony");
			}
			if(neonVinyl == 6){
				format(txt_neon, 128, "{FFFFFF}\nNeony: \t{F3FA30}��ty");
			}
			if(sphereVinyl == false){
				format(txt_sphere, 128, "{FFFFFF}\nKula: \t{FF0000}Wy��czone");
			}else{
				format(txt_sphere, 128, "{FFFFFF}\nKula: \t{00FF00}W��czone");
			}
			if(podestVinyl == false){
				format(txt_podest, 128, "{FFFFFF}\nPodest: \t{FF0000}Wy��czone");
			}else{
				format(txt_podest, 128, "{FFFFFF}\nPodest: \t{00FF00}W��czone");
			}
			if(dymVinyl == false){
				format(txt_dym, 128, "{FFFFFF}\nDym: \t{FF0000}Wy��czone");
			}else{
				format(txt_dym, 128, "{FFFFFF}\nDym: \t{00FF00}W��czone");
			}
			if(eqVinyl == false){
				format(txt_eq, 128, "{FFFFFF}\nEqualizator: \t{FF0000}Wy��czone");
			}else{
				format(txt_eq, 128, "{FFFFFF}\nEqualizator: \t{00FF00}W��czone");
			}
			if(textVinyl == false){
				format(txt_txt, 128, "{FFFFFF}\nTekst: \t{FF0000}Wy��czone");
			}else{
				format(txt_txt, 128, "{FFFFFF}\nTekst: \t{00FF00}W��czone");
			}
			format(txt_klub, 256, "%s %s %s %s %s %s %s", txt_light, txt_neon, txt_sphere, txt_podest, txt_dym, txt_eq, txt_txt);
			// BIURO
			if((moveZaluzja1 == false) && (moveZaluzja2 == false)){
				format(txt_zaluzja, 128, "{FFFFFF}�aluzje: \t{00FF00}W��czone");
			}else{
				format(txt_zaluzja, 128, "{FFFFFF}�aluzje: \t{FF0000}Wy��czone");
			}
			format(txt_biuro, 256, "%s \n{FFFFFF}Kamery: \tOgl�daj", txt_zaluzja);
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialogEx(playerid, D_VINYL_K, DIALOG_STYLE_LIST, "{00FFFF}VinylClub{FFFFFF} | Klub", txt_klub, "Wybierz", "Anuluj");
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, D_VINYL_B, DIALOG_STYLE_LIST, "{00FFFF}VinylClub{FFFFFF} | Biuro", txt_biuro, "Wybierz", "Anuluj");
				}
				case 2:
				{
					ShowPlayerDialogEx(playerid, D_VINYL_J, DIALOG_STYLE_LIST, "{00FFFF}VinylClub{FFFFFF} | Jacuzzi", "Jacuzzi", "Wybierz", "Anuluj");
				}
			}
		}
	}
	else if(dialogid == D_VINYL_K)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{

					if(lightsVinyl == false)
					{
						led1 = CreateDynamicObject(18653, 822.621154, -1387.984619, -19.836418, 0.000000, -11.000000, 70.000000, 71, 0, -1, 300.00, 300.00); 
						led2 = CreateDynamicObject(18653, 811.361022, -1387.984619, -19.836418, 0.000000, -11.000000, 110.000000, 71, 0, -1, 300.00, 300.00); 
						led3 = CreateDynamicObject(18102, 820.466613, -1402.050292, -20.383949, 31.300003, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 
						sendTipMessageEx(playerid, COLOR_P@, "Pomy�lnie wy��czono o�wietlenie"); 
						lightsVinyl = true;
					}
					else
					{
						DestroyDynamicObject(led1);
						DestroyDynamicObject(led2);
						DestroyDynamicObject(led3);
						lightsVinyl = false;
						sendTipMessageEx(playerid, COLOR_P@, "Pomy�lnie wy��czono o�wietlenie!"); 
					}
				}
				case 1:
				{
					ShowPlayerDialogEx(playerid, D_VINYL_NEON, DIALOG_STYLE_LIST, "{00FFFF}VinylClub{FFFFFF} | Klub >> Neony", "Brak \nMieszane \n{1E2BFE}Niebieski \n{C71E09}Czerwony \n{CD17F9}Fioletowy \n{1CFF27}Zielony \n{F3FA30}��ty", "Wybierz", "Anuluj");
				}
				case 2:
				{
					if(sphereVinyl == false){
						kula = CreateDynamicObject(3054, 817.169311, -1394.821899, -9.629315, 0.000000, 0.000000, 0.000000, 71, 0, -1, 340.00, 340.00); 
						SetDynamicObjectMaterial(kula, 0, 19041, "matwatches", "watchtype10map", 0x00000000);
						SetDynamicObjectMaterial(kula, 1, 18901, "matclothes", "hatmap1", 0x00000000);
						MoveDynamicObject(kula, 817.169311, -1394.821899, -13.629315, 1);
						sphereTimer = SetTimer("SphereSpinFirst", 5000, false);
						
						
						sphereVinyl = true;
					}else{
						MoveDynamicObject(kula, 817.169311, -1394.821899, -9.629315, 1);
						KillTimer(sphereTimer);
						KillTimer(sphereTimer_second);
						
						sphereVinyl = false;
					}
				}
				case 3:
				{
					if(podestVinyl == false){
						MoveDynamicObject(podest1, 816.637390, -1403.019653, -24.998998, 1);
						MoveDynamicObject(podest2, 816.607849, -1402.989624, -22.408988, 1);
						podestVinyl = true;
						sendTipMessage(playerid, "Podest zosta� wysuni�y!");
					}else{
						MoveDynamicObject(podest1, 816.637390, -1403.019653, -26.998998, 1);
						MoveDynamicObject(podest2, 816.607849, -1402.989624, -24.408988, 1);
						podestVinyl = false;
						sendTipMessage(playerid, "Podest zosta� schowany!"); 
					}
				}
				case 4:{
					if(dymVinyl == false){
						dym1 = CreateDynamicObject(18747, 817.424255, -1390.892700, -23.989006, 0.000000, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 
						dym2 = CreateDynamicObject(18747, 817.424255, -1394.652587, -23.989006, 0.000000, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 
						dym3 = CreateDynamicObject(18747, 817.424255, -1398.743164, -23.989006, 0.000000, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 

						dym4 = CreateDynamicObject(18728, 812.184020, -1386.922851, -22.539764, 22.800003, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 
						dym5 = CreateDynamicObject(18728, 821.514099, -1386.922851, -22.539764, 22.800003, 0.000000, 0.000000, 71, 0, -1, 300.00, 300.00); 
						dymVinyl = true;
						sendTipMessage(playerid, "Dym w sali vinyl Club zosta� w��czony!"); 
					}else{
						DestroyDynamicObject(dym1);
						DestroyDynamicObject(dym2);
						DestroyDynamicObject(dym3);
						DestroyDynamicObject(dym4);
						DestroyDynamicObject(dym5);
						dymVinyl = false;
						sendTipMessage(playerid, "Dym w sali Vinyl Club zosta� wy��czony!"); 
					}
				}
				case 5:{
					if(eqVinyl == false){
						eq_1_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -23.328979, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_1_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -23.328979, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_1_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_1_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_2_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -22.818969, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_2_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -22.818969, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_2_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_2_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_3_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -22.298957, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_3_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -22.298957, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_3_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_3_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_4_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -21.728950, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_4_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -21.728950, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_4_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_4_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_5_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -21.158937, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_5_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -21.158937, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_5_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_5_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_6_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -20.598926, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_6_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -20.598926, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_6_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_6_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_7_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -20.028915, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_7_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -20.028915, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_7_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_7_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

						eq_8_1 = CreateDynamicObject(19939, 809.013793, -1387.950805, -19.468902, 180.000000, 90.000000, 90.000000, 71, 0, -1, 300.00, 300.00); 
						eq_8_2 = CreateDynamicObject(19939, 824.865051, -1387.950805, -19.468902, -0.000007, 270.000000, -89.999984, 71, 0, -1, 300.00, 300.00); 
						SetDynamicObjectMaterial(eq_8_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						SetDynamicObjectMaterial(eq_8_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
						eqTimer_First = SetTimer("eqFirst", 2000, true);
						eqTimer_First = SetTimer("eqSecond", 1400, true);
						eqTimer_First = SetTimer("eqThird", 900, true);
						eqTimer_First = SetTimer("eqFourth", 400, true);
					
						eqVinyl = true;
					}else{
						DestroyEq();
						KillTimer(eqTimer_First);
						KillTimer(eqTimer_Second);
						KillTimer(eqTimer_Third);
						KillTimer(eqTimer_Fourth);
						eqVinyl = false;
					}
				}
				case 6:{
					ShowPlayerDialogEx(playerid, D_VINYL_TEKST, DIALOG_STYLE_INPUT, "PANEL: {00FFFF}VinylClub >> Tekst", "Wpisz tekst", "Wybierz", "Anuluj");
				}
			}
		}
	}
	else if(dialogid == D_VINYL_TEKST)
	{
		if(response)
		{
			if(textVinyl == false){
				text_Vinyl = CreateDynamicObject(7911, 817.176879, -1386.975463, -21.528980, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
				SetDynamicObjectMaterialText(text_Vinyl, 0, inputtext, 130, "Calibri", 20, 0, 0xFF00FFFF, 0x00000000, 1);
				textVinyl_Timer = SetTimer("textVinylT", 3000, true);
				textVinyl = true;
			}else{
				textVinyl = false;
				KillTimer(textVinyl_Timer);
				DestroyDynamicObject(text_Vinyl);
			}
		}
	}
	else if(dialogid == D_VINYL_NEON)
	{
		if(response){
			switch(listitem){
				case 0:{
					DestroyNeons();
					neonsVinyl = false;
					KillTimer(NeonsTimer);
				}
				case 1:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18647, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18647, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18648, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18648, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18648, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18648, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18648, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18648, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18648, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18648, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18648, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18648, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18651, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18651, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18651, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18651, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18650, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18650, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18649, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18649, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18649, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18649, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18649, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 1;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
				case 2:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18648, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18648, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18648, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18648, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18648, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18648, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18648, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18648, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18648, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18648, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18648, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18648, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18648, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18648, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18648, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18648, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18648, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18648, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18648, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18648, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18648, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18648, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18648, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 2;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
				case 3:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18647, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18647, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18647, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18647, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18647, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18647, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18647, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18647, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18647, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18647, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18647, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18647, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18647, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18647, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18647, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18647, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18647, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18647, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18647, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18647, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18647, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18647, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18647, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 3;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
				case 4:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18651, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18651, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18651, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18651, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18651, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18651, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18651, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18651, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18651, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18651, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18651, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18651, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18651, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18651, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18651, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18651, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18651, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18651, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18651, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18651, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18651, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18651, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18651, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 4;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
				case 5:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18649, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18649, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18649, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18649, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18649, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18649, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18649, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18649, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18649, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18649, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18649, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18649, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18649, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18649, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18649, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18649, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18649, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18649, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18649, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18649, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18649, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18649, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18649, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 5;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
				case 6:{
					// MIESZANE
					if(neonsVinyl == false){
						DestroyNeons();
						neon1 = CreateDynamicObject(18650, 821.522766, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon2 = CreateDynamicObject(18650, 812.322387, -1400.391113, -19.608976, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - blue
						neon3 = CreateDynamicObject(18650, 836.026428, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon4 = CreateDynamicObject(18650, 797.565612, -1401.542114, -21.099332, 0.000000, 0.000000, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon5 = CreateDynamicObject(18650, 816.854736, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon6 = CreateDynamicObject(18650, 818.914855, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon7 = CreateDynamicObject(18650, 820.985351, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon8 = CreateDynamicObject(18650, 814.755065, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon9 = CreateDynamicObject(18650, 812.654663, -1387.407104, -17.199321, 0.000000, 0.000000, 270.000000, 71, 0, -1, 400.00, 400.00); 
						neon10 = CreateDynamicObject(18650, 895.382629, -1416.163452, -20.143314, 0.000007, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon11 = CreateDynamicObject(18650, 899.163024, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						neon12 = CreateDynamicObject(18650, 895.652343, -1413.132690, -15.103283, 0.000000, -0.000007, 180.000000, 71, 0, -1, 400.00, 400.00); 
						// - purple
						neon13 = CreateDynamicObject(18650, 821.579284, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon14 = CreateDynamicObject(18650, 831.959838, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon15 = CreateDynamicObject(18650, 811.879882, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon16 = CreateDynamicObject(18650, 803.919372, -1414.808471, -19.919300, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - yellow
						neon17 = CreateDynamicObject(18650, 805.490844, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						neon18 = CreateDynamicObject(18650, 828.301147, -1400.387573, -19.639308, 0.000000, 0.000000, 90.000000, 71, 0, -1, 400.00, 400.00); 
						// - green
						neon19 = CreateDynamicObject(18650, 835.885803, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon20 = CreateDynamicObject(18650, 835.885803, -1413.598632, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon21 = CreateDynamicObject(18650, 835.885803, -1407.657836, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon22 = CreateDynamicObject(18650, 798.036376, -1407.517700, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						neon23 = CreateDynamicObject(18650, 798.036376, -1391.377685, -19.889291, 0.000000, 0.000000, 0.000000, 71, 0, -1, 400.00, 400.00); 
						
						NeonsTimer = SetTimer("MoveNeons", 3000, true);
						neonVinyl = 6;
						neonsVinyl = true;
					}else{
						DestroyNeons();
						neonsVinyl = false;
						neonVinyl = 0;
					}
				}
			}
		}
	}
	else if(dialogid == D_VINYL_B)
	{
		if(response){
			switch(listitem){
				case 0:{
					if(IsPlayerInRangeOfPoint(playerid, 4, 678.121704, -1393.385620, -21.709302)){
						if((moveZaluzja1 == false) && (moveZaluzja2 == false)){
							MoveDynamicObject(zaluzja1, 678.121704, -1393.385620, -19.709302, 1);
							MoveDynamicObject(zaluzja2, 680.731506, -1393.385620, -19.709302, 1);
							moveZaluzja1 = true;
							moveZaluzja2 = true;
						}else{
							MoveDynamicObject(zaluzja1, 678.121704, -1393.385620, -21.709302, 1);
							MoveDynamicObject(zaluzja2, 680.731506, -1393.385620, -21.709302, 1);
							moveZaluzja1 = false;
							moveZaluzja2 = false;
						}
					}
				}
				case 1:{
					ShowPlayerDialogEx(playerid, D_VINYL_CAM, DIALOG_STYLE_LIST, "PANEL: {00FFFF}VinylClub >> Kamery", "Brak \nHol \nObok baru \nPrzy �azienkach \nParkiet", "Wybierz", "Anuluj");
				}
			}
			
		}
	}
	else if(dialogid == D_VINYL_CAM)
	{
		if(response){
			if(IsPlayerInRangeOfPoint(playerid, 4,  674.076904, -1390.442871, -22.679317)){
				switch(listitem){
					case 0:{
						SetCameraBehindPlayer(playerid);
					}
					case 1:{
						//HOL PRZEDSIONEK
						SetPlayerCameraPos(playerid, 675.147, -1399.068, -20.939);
						SetPlayerCameraLookAt(playerid, 688.3051,-1395.4424,-22.6093, 1);
					}
					case 2:{
						//PRZY WEJ�CIU VIPA
						SetPlayerCameraPos(playerid, 804.162, -1414.056, -20.379);
						SetPlayerCameraLookAt(playerid, 801.9684,-1389.1116,-22.6193, 1);
					}
					case 3:{
						//PRZY WC
						SetPlayerCameraPos(playerid, 829.635, -1388.634, -20.350);
						SetPlayerCameraLookAt(playerid, 832.2269,-1413.2073,-22.6093, 1);
					}
					case 4:{
						//PARKIET
						SetPlayerCameraPos(playerid, 830.185, -1389.178, -14.814);
						SetPlayerCameraLookAt(playerid, 812.8127,-1399.2845,-22.5390, 1);
					}
				}
			}else{
				SendClientMessage(playerid, -1, "Nie znajdujesz si� przy monitoringu");
			}
		}
	}
	else if (dialogid == DIALOG_KUPSKIN)
	{
		if(response) 
		{
			if(listitem < 0 || listitem >= sizeof(ShopSkins) || ShopSkins[listitem][SKIN_TYPE] != SKIN_TYPE_DEFAULT) 
			{
				//should never happend
				return 1;
			}
			if(kaska[playerid] < ShopSkins[listitem][SKIN_PRICE])
			{
				sendErrorMessage(playerid, "Nie posiadasz wystarczaj�cej ilo�ci got�wki, na tego skina");
				DialogKupSkin(playerid);
				return 1;
			}
			SetPlayerSkin(playerid, ShopSkins[listitem][SKIN_ID]);
			ZabierzKase(playerid, ShopSkins[listitem][SKIN_PRICE]);
			PlayerInfo[playerid][pSkin] = ShopSkins[listitem][SKIN_ID]; 
			
			sendTipMessage(playerid, sprintf("Kupi�e� skina za %d$", ShopSkins[listitem][SKIN_PRICE])); 
			Log(payLog, INFO, "%s kupi� skina %d za %d$", GetPlayerLogName(playerid), ShopSkins[listitem][SKIN_ID], ShopSkins[listitem][SKIN_PRICE]);
			return 1;
		}
	}
	else if(orgpanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext))
	{
		return 1;
	}
	else if(mru_ac_OnDialogResponse(playerid, dialogid, response, listitem, inputtext))
	{
		return 1;
	}
	else if(BW_OnDialogResponse(playerid, dialogid, response, listitem, inputtext))
	{
		return 1;
	}
	return 0;
}
//ondialogresponse koniec
