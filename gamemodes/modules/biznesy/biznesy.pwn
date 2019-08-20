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
// Autor: Simeone & _Kamil
// Data utworzenia: 08.07.2019
//Opis:
/*
	System biznesów. Pozwala tworzyæ biznesy inGame, zapisywane do bazy danych.
	Co godzina zwraca podane wartoœci jako przychód dla w³aœciciela (X/4, X/2, X, -X, -X/4, -X/2), gdzie X - sta³a wartoœæ. 
	Biznes pozwala dodawaæ maksymalnie 5 osób (w zale¿noœci od wielkoœci), do niego (jako ala-Job) - umo¿liwia to [..]
	[..] korzystanie z chatu biznesowego /biz [Radio IC], /obiz [Radio OOC]. 

	W³aœciciel ma mo¿liwoœæ podgl¹du pracowników On-Line, mo¿e ich zwolniæ tak¿e onLine.  Biznesy s¹ podpiête tak¿e pod /brama. 

	Funkcje zawarte w kodzie:
	> GetPlayerBusiness - sprawdza jaki ma biznes gracz (owner/member) i zwraca wartoœæ value. 
	> SendMessageToBiz - wysy³a wiadomoœæ do cz³onków biznesu (1 - IC, 0 - OOC)
	> BusinessPayDay - przydziela gotówkê za posiadanie biznesu. 
	> IsALeaderBusiness - sprawdza czy gracz jest liderem jakiegoœ biznesu
	> IsAMemberBusiness - sprawdza czy gracz jest cz³onkiem jakiegoœ biznesu
	> GetPlayerBusiness - pobiera biznes gracza i zwraca go jako Value
	> CheckIfPlayerInBusinessPoint - sprawdza czy gracz jest w miejscu biznesu.

*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock IsALeaderBusiness(playerid)
{
	new lid = PlayerInfo[playerid][pBusinessOwner]; 
	if(lid >= 0 && lid != INVALID_BIZ_ID)
	{
		return 1;
	}
	return 0; 
}
stock IsAMemberBusiness(playerid)
{
	new lid = PlayerInfo[playerid][pBusinessMember]; 
	if(lid >= 0 && lid != INVALID_BIZ_ID)
	{
		return 1;
	}
	return 0;
}
GetPlayerBusiness(playerid)
{
	new value;
	if(IsAMemberBusiness(playerid))
	{
		value = PlayerInfo[playerid][pBusinessMember]; 
	}
	else if(IsALeaderBusiness(playerid))
	{
		value = PlayerInfo[playerid][pBusinessOwner]; 
	}
	else 
	{
		value = INVALID_BIZ_ID; 
	}
	return value; 
}
SendMessageToBiz(bizID, mess[], color, type)
{
	new string[256]; 
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pBusinessMember] == bizID || PlayerInfo[i][pBusinessOwner] == bizID)
		{
			if(type == 0)
			{
				format(string, sizeof(string), "(( %s ))", mess); 
			}
			else if(type == 1)
			{
				format(string, sizeof(string), "** %s **", mess); 
			}
			SendClientMessage(i, color, string); 	
		}
	}
	return 1; 
}
BusinessPayDay(playerid) 
{
	new randomValue = random(10); 
	new moneyForPlayer; 
	new string[124]; 
	if(PlayerInfo[playerid][pBusinessOwner] == INVALID_BIZ_ID)
	{
		sendTipMessage(playerid, "Nie posiadasz w³asego biznesu"); 
		return 1;
	}
	if(randomValue == 0)
	{
		BusinessPayDay(playerid);//powtórzenie dla wartoœci zerowej. 
		return 1;
	}
	if(IsPlayerPremiumOld(playerid))
	{
		
		if(randomValue <= 4)//40% na MAX
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ maksimum"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue > 4 && randomValue <= 6)//20% na po³owiczny zysk
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ po³owiczny zysk"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue == 7)//10 % na zero
		{
			moneyForPlayer = 0;
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {FF0000}nie przyniós³ zysku"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
		}
		else if(randomValue >= 8)// 30 % na strate po³owiczn¹ 
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}po³owiczne straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj¹cej iloœci œrodków aby pokryæ straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Twój poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
	}
	else 
	{
		if(randomValue <= 2)//20% na MAX
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ maksimum"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue >= 3 && randomValue <= 6)//30% na po³owiczny zysk
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Twój dochód z biznesu {37AC45}osi¹gn¹³ po³owiczny zysk"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue > 6 && randomValue <= 9 )//30 % na pó³ straty!
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2);
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000} po³owiczne straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj¹cej iloœci œrodków aby pokryæ straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Twój poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
		else if(randomValue == 10)// 10 % na strate ca³kowit¹
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Dochód z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}maksymalnie straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj¹cej iloœci œrodków aby pokryæ straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Twój poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
	}
	
	return 1;
}
GetNearestBusiness(playerid)
{
	new bizID=INVALID_BIZ_ID; 
	for(new i; i<BusinessLoaded+1; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ]))
		{
			bizID = i;
			return bizID; 
		}
	}
	return bizID; 
}
stock ResetBizOffer(playerid)
{
	SetPVarInt(playerid, "Oferujacy_ID", -1);
	SetPVarInt(playerid, "Oferujacy_Cena", 0); 
	SetPVarInt(playerid, "wpisal_sprzedaj_biz", 0);
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
stock CorrectPlayerBusiness(playerid)
{
	if(PlayerInfo[playerid][pBusinessOwner] == 0)
	{
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		sendTipMessage(playerid, "Posiada³eœ biznes testowy - pomyœlnie wy³¹czono.");
	}
	if(PlayerInfo[playerid][pBusinessOwner] > MAX_BIZNES)
	{
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		sendErrorMessage(playerid, "Posiada³eœ b³êdny biznes - zosta³ on WYZEROWANY!");
		sendTipMessage(playerid, "Je¿eli uwa¿asz to za b³¹d - zg³oœ to na naszym forum!"); 
	}
	if(PlayerInfo[playerid][pBusinessMember] == 0)
	{
		PlayerInfo[playerid][pBusinessMember] = INVALID_BIZ_ID;
		sendTipMessage(playerid, "Posiada³eœ biznes testowy - pomyœlnie wy³¹czono.");
	}
	return 0; 
}
stock GetFreeBizID()
{
	new bID = BusinessLoaded+1; 
	for(new i; i<BusinessLoaded; i++)
	{
		if(i != 0)
		{
			if(strlen(Business[i][b_Name]) <= 3)
			{
				bID = i; 
				return bID; 
			}
		}
	}
	return bID; 
}
stock LoadBusinessPickup()
{
	for(new i; i<MAX_BIZNES; i++)
	{
		if(strlen(Business[i][b_Name]) >= 3)
		{	
			BizPickUp[i] = CreateDynamicPickup(1272, 1, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ], 0, 0 -1);
			Biz3DText[i] = CreateDynamic3DTextLabel(Business[i][b_Name], 0x008080FF, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ]+0.6, 20.0);
		}
	}
	return 1;
}
stock UnLoadBusiness(idBIZ)
{
	new stringName[64]; 
	new stringNamed[MAX_PLAYER_NAME]; 
	format(stringName, sizeof(stringName), " ");
	mysql_real_escape_string(stringName, Business[idBIZ][b_Name]); 
	Business[idBIZ][b_ownerUID] = 0; 
	Business[idBIZ][b_enX] = 0.0;
	Business[idBIZ][b_enY] = 0.0;
	Business[idBIZ][b_enZ] = 0.0; 
	Business[idBIZ][b_exX] = 0.0;
	Business[idBIZ][b_exY] = 0.0;
	Business[idBIZ][b_exZ] = 0.0; 
	Business[idBIZ][b_int] = 0;   
	Business[idBIZ][b_vw] = 0; 
	Business[idBIZ][b_pLocal] = 255; 
	Business[idBIZ][b_maxMoney] = 0;
	Business[idBIZ][b_cost] = 0;
	format(stringName, sizeof(stringName), " ");
	Business[idBIZ][b_Location] = stringName; 
	format(stringNamed, sizeof(stringNamed), " ");
	Business[idBIZ][b_Name_Owner] = stringNamed; 
	DestroyDynamicPickup(BizPickUp[idBIZ]); 
	DestroyDynamic3DTextLabel(Biz3DText[idBIZ]);
	BizPickUp[idBIZ] = 0;

	return 1;
}
//-----------------<[ Komendy: ]>-------------------


//OLD CODE:

/*
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
				new kwotaStraty = BizData[bizid][eBizMoney]/2;
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: -$%d", kwotaStraty);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}minimalne straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(kaska[playerid] >= kwotaStraty)
				{
					ZabierzKase(playerid, kwotaStraty);
				}
				else
				{
					if(PlayerInfo[playerid][pAccount] >= kwotaStraty)
					{
						PlayerInfo[playerid][pAccount] = PlayerInfo[playerid][pAccount]-kwotaStraty;
					}
					else
					{
						ZabierzKase(playerid, kwotaStraty);
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
				if(kaska[playerid] >= BizData[bizid][eBizMoney])
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
						ZabierzKase(playerid,BizData[bizid][eBizMoney]);
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
				new kwotaStraty = BizData[bizid][eBizMoney]/2;
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCHÓD Z BIZNESU ___|");
				format(string, sizeof(string), "Nazwa biznesu: %s", BizData[bizid][eBizName]);
				SendClientMessage(playerid,COLOR_WHITE, string); 
				format(string, sizeof(string), "  Strata z biznesu: -$%d", kwotaStraty);
				SendClientMessage(playerid,COLOR_WHITE, string);
				SendClientMessage(playerid,COLOR_WHITE, "Twój biznes przyniós³ {FF0000}minimalne straty"); 
				SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
				if(kaska[playerid] >= kwotaStraty)
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
				if(kaska[playerid] >= BizData[bizid][eBizMoney])
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
*/ 
//end