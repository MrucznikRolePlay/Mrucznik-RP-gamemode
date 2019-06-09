//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  biznesy                                                  //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System biznesów.
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
ZaladujBiznesy()
{
    for(new i=0;i<MAX_BIZNES;i++)
	{
		CreateDynamicPickup(19523, 1, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ], -1, -1, -1, 125.0);
    	CreateDynamic3DTextLabel(BizData[i][eBizName], 0x008080FF, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ]+0.4, 10.0);
	}
	PickupSklep01 = CreateDynamicPickup(1239, 3, BizData[10][eBizWyjX], BizData[10][eBizWyjY], BizData[10][eBizWyjZ], -1, -1, -1, 10.0);//ZIP
	return 1;
}

Biz_Owner(biz)
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

ResetBizOffer(playerid)
{
	SetPVarInt(playerid, "Oferujacy_ID", -1);
	SetPVarInt(playerid, "Oferujacy_Cena", 0); 
	SetPVarInt(playerid, "Oferujacy_biz_ID",0);
	SetPVarInt(playerid, "wpisal_sprzedaj_biz", 0);
	return 1;
}

CheckBizLocation(bizid)
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

GiveRandomMoneyBiz(playerid)
{
	new string[128];
	new losuj = random(10);
	new bizid = PlayerInfo[playerid][pPbiskey];
	if(PlayerInfo[playerid][pPbiskey] >= 0 && PlayerInfo[playerid][pPbiskey] <= MAX_BIZNES)
	{
		if(IsPlayerPremiumOld(playerid))
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

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end