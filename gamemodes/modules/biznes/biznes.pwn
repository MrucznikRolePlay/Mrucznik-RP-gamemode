//biznes.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: biznes.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera system biznesów == aktów w³asnoœci
	A dok³adnie:
		> ...
		> ..
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

stock ZaladujBiznesy()
{
    for(new i=0;i<MAX_BIZNES;i++)
	{
		CreateDynamicPickup(19523, 1, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ], -1, -1, -1, 125.0);
    	CreateDynamic3DTextLabel(BizData[i][eBizName], 0x008080FF, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ]+0.4, 10.0);
	}
	PickupSklep01 = CreateDynamicPickup(1239, 3, BizData[10][eBizWyjX], BizData[10][eBizWyjY], BizData[10][eBizWyjZ], -1, -1, -1, 10.0);//ZIP
	return 1;
}
stock Biz_Owner(biz)
{
    new lStr[64];
    format(lStr, 64, "SELECT `Nick` FROM mru_konta WHERE `Bizz`='%d'", biz);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
    	mysql_fetch_row_format(lStr, "|");
		mysql_free_result();
	}
    return lStr;
}

stock ResetBizOffer(playerid)
{
	SetPVarInt(playerid, "Oferujacy_ID", -1);
	SetPVarInt(playerid, "Oferujacy_Cena", 0); 
	SetPVarInt(playerid, "Oferujacy_biz_ID",0);
	SetPVarInt(playerid, "wpisal_sprzedaj_biz", 0);
	return 1;
}
stock CheckBizLocation(bizid)
{
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_LS)
	{
		format(bizLocation, sizeof(bizLocation), "Los Santos");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_DILL)
	{
		format(bizLocation, sizeof(bizLocation), "Dillimore");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_PC)
	{
		format(bizLocation, sizeof(bizLocation), "Palomino Creek");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_MONT)
	{
		format(bizLocation, sizeof(bizLocation), "Montgomery");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_BB)
	{
		format(bizLocation, sizeof(bizLocation), "Blueberry");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_LV)
	{
		format(bizLocation, sizeof(bizLocation), "Las Venturas");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_SF)
	{
		format(bizLocation, sizeof(bizLocation), "San Fierro");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_BS)
	{
		format(bizLocation, sizeof(bizLocation), "Bay Side");
	}
	if(BizData[bizid][eBizLocation] == BIZ_LOCATION_UNKNOW)
	{
		format(bizLocation, sizeof(bizLocation), "Nie znane");
	}
	return bizLocation;
}
stock GiveRandomMoneyBiz(playerid)
{
	new string[128];
	new losuj = random(10);
	new bizid = PlayerInfo[playerid][pPbiskey];
	if(PlayerInfo[playerid][pPbiskey] >= 0 && PlayerInfo[playerid][pPbiskey] <= MAX_BIZNES)
	{
		if(PlayerInfo[playerid][pDonateRank] > 2)
		{
			if(losuj == 1 || losuj == 2 || losuj == 3)//Max kwota
			{
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
				SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ maksimum"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				DajKase(playerid,BizData[bizid][eBizMoney]);
			}
			if(losuj == 4 || losuj == 5 || losuj == 6 || losuj == 7)//Po³owiczny zysk
			{
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]/2);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
				SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ po³owê"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				DajKase(playerid,BizData[bizid][eBizMoney]/2);
			}
			if(losuj == 8 || losuj == 9)//minimalna strata
			{
				new kwotaStraty = 0-(BizData[bizid][eBizMoney]/2);
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: $%d", kwotaStraty);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}minimalne straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(GetPlayerMoney(playerid) >= kwotaStraty)
				{
					ZabierzKase(playerid,kwotaStraty);
				}
				else
				{
					if(PlayerInfo[playerid][pAccount] >= kwotaStraty)
					{
						PlayerInfo[playerid][pAccount] = PlayerInfo[playerid][pAccount]-kwotaStraty;
					}
					else
					{
						sendTipMessageEx(playerid,COLOR_RED, "Twoje d³ugi rosn¹! Twój biznes przynosi kolejne straty"); 
					}
				}
			
			}
			if(losuj == 10)//Du¿a strata
			{
				
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: $%d", BizData[bizid][eBizMoney]);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}du¿e straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(GetPlayerMoney(playerid) >= BizData[bizid][eBizMoney])
				{
					ZabierzKase(playerid,BizData[bizid][eBizMoney]);
				}
				else
				{
					if(PlayerInfo[playerid][pAccount] >= BizData[bizid][eBizMoney])
					{
						PlayerInfo[playerid][pAccount] = PlayerInfo[playerid][pAccount]-BizData[bizid][eBizMoney];
					}
					else
					{
						sendTipMessageEx(playerid,COLOR_RED, "Twoje d³ugi rosn¹! Twój biznes przynosi kolejne straty"); 
					}
				}
			
			}
		}
		else
		{
			if(losuj == 1 || losuj == 2)//Max kwota
			{
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ maksimum"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				DajKase(playerid,BizData[bizid][eBizMoney]);
			}
			if(losuj == 4 || losuj == 5 || losuj == 6 )//Po³owiczny zysk
			{
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]/2);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ po³owê"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				DajKase(playerid,BizData[bizid][eBizMoney]/2);
			}
			if(losuj == 7 || losuj == 8 || losuj == 3)//minimalna strata
			{
				new kwotaStraty = 0-(BizData[bizid][eBizMoney]/2);
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: $%d", kwotaStraty);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}minimalne straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(GetPlayerMoney(playerid) >= kwotaStraty)
				{
					ZabierzKase(playerid,kwotaStraty);
				}
				else
				{
					if(PlayerInfo[playerid][pAccount] >= kwotaStraty)
					{
						PlayerInfo[playerid][pAccount] = PlayerInfo[playerid][pAccount]-kwotaStraty;
					}
					else
					{
						sendTipMessageEx(playerid,COLOR_RED, "Twoje d³ugi rosn¹! Twój biznes przynosi kolejne straty"); 
					}
				}
			
			}
			if(losuj == 9 || losuj == 10)//Du¿a strata
			{
				
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: $%d", BizData[bizid][eBizMoney]);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}du¿e straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(GetPlayerMoney(playerid) >= BizData[bizid][eBizMoney])
				{
					ZabierzKase(playerid,BizData[bizid][eBizMoney]);
				}
				else
				{
					if(PlayerInfo[playerid][pAccount] >= BizData[bizid][eBizMoney])
					{
						PlayerInfo[playerid][pAccount] = PlayerInfo[playerid][pAccount]-BizData[bizid][eBizMoney];
					}
					else
					{
						sendTipMessageEx(playerid,COLOR_RED, "Twoje d³ugi rosn¹! Twój biznes przynosi kolejne straty"); 
					}
				}
			}
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
		format(string, sizeof(string), "Brak posiadanego biznesu!");
		SendClientMessage(playerid, COLOR_WHITE, string); 
		SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
	}
	return 1;
}


//-----------------<[ Komendy: ]>-------------------
CMD:dajbiznes(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] == 5000 || PlayerInfo[playerid][pAdmin] == 5001)
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc)) return sendTipMessage(playerid, "U¿yj /dajbiznes [playerid/CzêœæNicku] [ID Biznesu]");
		if(IsPlayerConnected(gracz))
		{
			new string[128];
			PlayerInfo[gracz][pPbiskey] = wartosc;
			MruMySQL_SaveAccount(playerid);
			format(string, sizeof(string),"AdmCmd: %s dal biznes %s (ID %d) graczowi %s.", GetNick(playerid), BizData[wartosc][eBizName], wartosc, GetNick(gracz));
            BiznesLog(string);
            _MruAdmin(playerid, sprintf("Da³eœ biznes %s (ID %d) graczowi %s [ID: %d]", BizData[wartosc][eBizName], wartosc, GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta³eœ biznes %s (ID %d) Admina %s [ID: %d]", BizData[wartosc][eBizName], wartosc, GetNick(playerid, true), playerid));
		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:sprzedajbiznes(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new giveplayerid, valueCost;
		new string[256];
		if(sscanf(params, "k<fix>d", giveplayerid, valueCost))
		{
			return sendTipMessage(playerid, "U¿yj /sprzedajbiznes [ID_GRACZA] [Cena]"); 
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid == playerid)
			{
				sendTipMessage(playerid, "Nie mo¿esz zaoferowaæ sprzeda¿y samemu sobie"); 
				return 1;
			}
			if(ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(IsPlayerInRangeOfPoint(playerid, 
				5.0, 
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejX], 
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejY],
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejZ]))
				{
				
					if(valueCost <= BIZ_SELL_MONEY_LIMIT)
					{
						if(GetPlayerMoney(giveplayerid) >= valueCost)
						{
							if(GetPVarInt(playerid, "wpisal_sprzedaj_biz") == 0)
							{
								sendTipMessage(playerid, "Pamiêtaj, ¿e Wydzia³ Planowania otr¹ci podatek w wysokoœci 1/5 podanej kwoty."); 
								sendTipMessage(playerid, "Je¿eli akceptujesz podane warunki wpisz ponownie komendê"); 
								SetPVarInt(playerid, "wpisal_sprzedaj_biz", 1); 
							}
							else
							{
								format(string, sizeof(string), "Wys³a³eœ ofertê do %s odnoœnie kupna biznesu [ID %d] za %d", GetNick(giveplayerid, true), PlayerInfo[playerid][pPbiskey], valueCost);
								sendTipMessage(playerid, string);
								sendTipMessage(playerid, "Oczekuj na akceptacje"); 
								
								
								//do giveplayerid
								format(string, sizeof(string), "Gracz %s oferuje Ci kupno biznesu [ID: %d] za kwotê %d$, wpisz /akceptuj biznes", GetNick(playerid, true), PlayerInfo[playerid][pPbiskey], valueCost); 
								sendTipMessage(giveplayerid, string); 
								SetPVarInt(giveplayerid, "Oferujacy_ID", playerid);
								SetPVarInt(giveplayerid, "Oferujacy_Cena", valueCost); 
								SetPVarInt(giveplayerid, "Oferujacy_biz_ID", PlayerInfo[playerid][pPbiskey]); 
							}
						}
						else
						{
							sendTipMessage(playerid, "Ten gracz nie ma przy sobie takiej kwoty"); 
							return 1;
						}
					}
					else
					{
						sendTipMessage(playerid, "Przy sprzeda¿y biznesu za wiêksz¹ cene wymagana jest obecnoœæ cz³onka Wydzia³u Planowania"); 
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie znajdujesz siê pod swoim biznesem"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz nie znajduje siê obok Ciebie!"); 
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza"); 
		}
	}
	return 1;
}
CMD:zabierzbiznes(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] == 5000 || PlayerInfo[playerid][pAdmin] == 5001)
	{
		new gracz;
		if(sscanf(params, "d", gracz)) return sendTipMessage(playerid, "U¿yj /zabierzbiznes [playerid/CzêœæNicku]");
		if(IsPlayerConnected(gracz))
		{
			new string[128];
			PlayerInfo[gracz][pPbiskey] = 255;
			MruMySQL_SaveAccount(playerid);
			format(string, sizeof(string),"AdmCmd: %s zabral biznes graczowi %s.", GetNick(playerid), GetNick(gracz));
            BiznesLog(string);
            _MruAdmin(playerid, sprintf("Zabra³eœ biznes graczowi %s [ID: %d]", GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Biznes zosta³ zabrany przez Admina %s [ID: %d]", GetNick(playerid, true), playerid));
		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:bizlock(playerid)
{
	if(PlayerInfo[playerid][pPbiskey] >= 0 && PlayerInfo[playerid][pPbiskey] <= MAX_BIZNES)
	{
		new bizid = PlayerInfo[playerid][pPbiskey];
		new string[128];
		if(BizOpenStatus[bizid] == 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, BizData[bizid][eBizWejX], BizData[bizid][eBizWejY], BizData[bizid][eBizWejZ]))
			{
				format(string, sizeof(string), "%s przekrêca kluczyk i otwiera biznes %s", GetNick(playerid, true), BizData[bizid][eBizName]);
				ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				BizOpenStatus[bizid] = 1;
			}
			else
			{
				sendErrorMessage(playerid, "Musisz byæ pod drzwiami swojego biznesu, aby tego dokonaæ!"); 
			}
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, BizData[bizid][eBizWejX], BizData[bizid][eBizWejY], BizData[bizid][eBizWejZ]))
			{
				format(string, sizeof(string), "%s przekrêca kluczyk i zamyka biznes %s", GetNick(playerid, true), BizData[bizid][eBizName]);
				ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				BizOpenStatus[bizid] = 0;
			}
			else
			{
				sendErrorMessage(playerid, "Musisz byæ pod drzwiami swojego biznesu, aby tego dokonaæ!"); 
			}
		
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz w³asnego biznesu! ~ Zakup go w Wydziale Planowania."); 
	}
	return 1;
}
CMD:bizmoneydebug(playerid)
{
	
	/*    new string[128];
		new bizid = PlayerInfo[playerid][pPbiskey];
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
		format(string, sizeof(string), "  Dochód z biznesu: $%d", BizData[bizid][eBizMoney]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|________________________|");
		DajKase(playerid, BizData[bizid][eBizMoney]);*/
	if(PlayerInfo[playerid][pAdmin] > 5000)
	{
		GiveRandomMoneyBiz(playerid);	
	}
	return 1;
}
CMD:bizinfo(playerid)
{
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
			new string[256];
			for(new i=0;i<MAX_BIZNES;i++)
		    {
				if(IsPlayerInRangeOfPoint(playerid, 3.0, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ]))
				{
				    new bizowner[64];
					bizowner = Biz_Owner(i);
					CheckBizLocation(i);
        			if(strfind(bizowner, "mru_konta", true)>=0)
					{
					    format(string, sizeof(string), "{ff704d}NIERUCHOMOŒÆ [0%d]\n{fbfe00}[%s]\n\n{ffffff}W³aœciciel:\tBrak (biznes na sprzeda¿)\nPremia PayDay:\t%d$\nLokalizacja:\t%s", i, BizData[i][eBizName],BizData[i][eBizMoney], bizLocation);
	        			ShowPlayerDialogEx(playerid, 9900, DIALOG_STYLE_MSGBOX, "Informacje o biznesie", string, "Zamknij", "");
					}
					else
					{
					    format(string, sizeof(string), "{ff704d}NIERUCHOMOŒÆ [0%d]\n{fbfe00}[%s]\n\n{ffffff}W³aœciciel:\t%s\nPremia PayDay:\t%d$\nLokalizacja:\t%s", i, BizData[i][eBizName],bizowner,BizData[i][eBizMoney], bizLocation);
	        			ShowPlayerDialogEx(playerid, 9900, DIALOG_STYLE_MSGBOX, "Informacje o biznesie", string, "Zamknij", "");
	 				}
                }
			}
	    }
	}
	return 1;
}


//-----------------<[ Timery: ]>-------------------


//end