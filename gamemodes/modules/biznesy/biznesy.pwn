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
	System biznes�w. Pozwala tworzy� biznesy inGame, zapisywane do bazy danych.
	Co godzina zwraca podane warto�ci jako przych�d dla w�a�ciciela (X/4, X/2, X, -X, -X/4, -X/2), gdzie X - sta�a warto��. 
	Biznes pozwala dodawa� maksymalnie 5 os�b (w zale�no�ci od wielko�ci), do niego (jako ala-Job) - umo�liwia to [..]
	[..] korzystanie z chatu biznesowego /biz [Radio IC], /obiz [Radio OOC]. 

	W�a�ciciel ma mo�liwo�� podgl�du pracownik�w On-Line, mo�e ich zwolni� tak�e onLine.  Biznesy s� podpi�te tak�e pod /brama. 

	Funkcje zawarte w kodzie:
	> GetPlayerBusiness - sprawdza jaki ma biznes gracz (owner/member) i zwraca warto�� value. 
	> SendMessageToBiz - wysy�a wiadomo�� do cz�onk�w biznesu (1 - IC, 0 - OOC)
	> BusinessPayDay - przydziela got�wk� za posiadanie biznesu. 
	> IsALeaderBusiness - sprawdza czy gracz jest liderem jakiego� biznesu
	> IsAMemberBusiness - sprawdza czy gracz jest cz�onkiem jakiego� biznesu
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
		sendTipMessage(playerid, "Nie posiadasz w�asnego biznesu"); 
		return 1;
	}
	if(randomValue == 0)
	{
		BusinessPayDay(playerid);//powt�rzenie dla warto�ci zerowej. 
		return 1;
	}
	if(IsPlayerPremium(playerid))
	{
		
		if(randomValue <= 4)//40% na MAX
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes wygenerowa� {37AC45}maksymalne przychody!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue > 4 && randomValue <= 6)//20% na po�owiczny zysk
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes wygenerowa� {37AC45}po�owiczne przychody"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue == 7)//10 % na zero
		{
			moneyForPlayer = 0;
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes {999999}nie przyni�s� zysku"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
		}
		else if(randomValue >= 8)// 30 % na strate po�owiczn� 
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: {FFFF00}Konto Premium");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes przyni�s� {FF0000}po�owiczne straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj�cej ilo�ci �rodk�w aby pokry� straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Tw�j poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
	}
	else 
	{
		if(randomValue <= 2)//20% na MAX
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j doch�d z biznesu {37AC45}osi�gn�� maksimum"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue >= 3 && randomValue <= 6)//30% na po�owiczny zysk
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j doch�d z biznesu {37AC45}osi�gn�� po�owiczny zysk"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			DajKase(playerid, moneyForPlayer);
		}
		else if(randomValue > 6 && randomValue <= 9 )//30 % na p� straty!
		{
			moneyForPlayer = (Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]/2);
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes przyni�s� {FF0000} po�owiczne straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj�cej ilo�ci �rodk�w aby pokry� straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Tw�j poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
		else if(randomValue == 10)// 10 % na strate ca�kowit�
		{
			moneyForPlayer = Business[PlayerInfo[playerid][pBusinessOwner]][b_maxMoney]; 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|___ DOCH�D Z BIZNESU ___|");
			format(string, sizeof(string), "Nazwa biznesu: %s", Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]);
			SendClientMessage(playerid,COLOR_WHITE, string); 
			format(string, sizeof(string), "  Doch�d z biznesu: $-%d", moneyForPlayer);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Bonusy: BRAK!");
			SendClientMessage(playerid,COLOR_WHITE, "Tw�j biznes przyni�s� {FF0000}maksymalnie straty!"); 
			SendClientMessage(playerid,COLOR_LIGHTBLUE, "|_________________________|");
			if(kaska[playerid] >= moneyForPlayer)
			{
				ZabierzKase(playerid, moneyForPlayer); 
			}
			else 
			{
				sendTipMessageEx(playerid, COLOR_RED, "Nie masz wystarczaj�cej ilo�ci �rodk�w aby pokry� straty"); 
				sendTipMessageEx(playerid, COLOR_RED, "Tw�j poziom poszukiwania wzrasta"); 
				PlayerInfo[playerid][pWL]++; 
			}
		}
	}
	
	return 1;
}
GetNearestBusiness(playerid)
{
	new bizID=INVALID_BIZ_ID; 
	for(new i; i<=BusinessLoaded; i++)
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
	}
	mysql_free_result();
    return lStr;
}
stock CorrectPlayerBusiness(playerid)
{
	if(PlayerInfo[playerid][pBusinessOwner] == 0)
	{
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		sendTipMessage(playerid, "Posiada�e� biznes testowy - pomy�lnie wy��czono.");
		Log(serverLog, WARNING, "%s wyzerowanie biznesu 0", GetPlayerLogName(playerid));
	}
	if(PlayerInfo[playerid][pBusinessOwner] > MAX_BIZNES)
	{
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID;
		PlayerInfo[playerid][pBusinessMember] = INVALID_BIZ_ID; 
	}
	if(PlayerInfo[playerid][pBusinessMember] == 0)
	{
		PlayerInfo[playerid][pBusinessMember] = INVALID_BIZ_ID;
		sendTipMessage(playerid, "Posiada�e� biznes testowy - pomy�lnie wy��czono.");
		Log(serverLog, WARNING, "%s wyzerowanie pracownika biznesu 0", GetPlayerLogName(playerid));
	}
	return 0; 
}

CheckPlayerBusiness(playerid)
{
	new businessID = PlayerInfo[playerid][pBusinessOwner];
	if(businessID != INVALID_BIZ_ID)
	{
		if(Business[businessID][b_ownerUID] != PlayerInfo[playerid][pUID])
		{
			sendErrorMessage(playerid, "Wczytywanie twojego biznesu si� nie powiod�o! Zostaje Ci on odebrany"); 
			sendErrorMessage(playerid, "Je�eli uwa�asz to za b��d skryptu - zg�o� strat� na naszym forum!");
			Log(errorLog, INFO, "%s zosta� odebrany biznes %s z powodu b��du w wczytaniu",
				GetPlayerLogName(playerid), 
				GetBusinessLogName(businessID)
			);
			PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID; 
		}
	}
}

stock GetFreeBizID()
{
	new bID = BusinessLoaded++; 
	return bID; 
}
stock LoadBusinessPickup()
{
	for(new i; i<MAX_BIZNES; i++)
	{
		if(strlen(Business[i][b_Name]) >= 3 && Business[i][b_enX] != 0.0 && Business[i][b_enY] != 0.0)
		{	
			BizPickUp[i] = CreateDynamicPickup(1272, 1, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ], Business[i][b_enVw], Business[i][b_enInt]);
			Biz3DText[i] = CreateDynamic3DTextLabel(Business[i][b_Name], 0x008080FF, 
				Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ]+0.6, 
				20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 
				Business[i][b_enVw], Business[i][b_enInt]);
			
			if(Business[i][b_icon] != 0)
			{
				new iconVw, iconInt;
				if(Business[i][b_enVw] != 0)
				{
					iconVw = -1;
				}
				if(Business[i][b_enInt] != 0)
				{
					iconInt = -1;
				}
				
				MruCreateDynamicMapIcon(Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ], 
					Business[i][b_icon], // type https://www.open.mp/docs/scripting/resources/mapicons
					-1, // color, This should only be used with the square icon (ID: 0)
					iconVw, // worldid
					iconInt, // interiorid
					-1, // playerid
					2000.0, // streamdistance -1 = inifnite
					MAPICON_LOCAL // style https://www.open.mp/docs/scripting/resources/mapiconstyles
				);	
			}
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
	Business[idBIZ][b_icon] = 0;
	format(stringName, sizeof(stringName), " ");
	Business[idBIZ][b_Location] = stringName; 
	format(stringNamed, sizeof(stringNamed), " ");
	Business[idBIZ][b_Name_Owner] = stringNamed; 
	DestroyDynamicPickup(BizPickUp[idBIZ]); 
	DestroyDynamic3DTextLabel(Biz3DText[idBIZ]);
	BizPickUp[idBIZ] = 0;

	return 1;
}

Business_AkceptujBiznes(playerid)
{
	new string[256];
	new giveplayerid = GetPVarInt(playerid, "Oferujacy_ID");
	new price = GetPVarInt(playerid, "Oferujacy_Cena");
	new tax = (price/12);

	if(giveplayerid == INVALID_PLAYER_ID)//przy connect
	{
		sendErrorMessage(playerid, "Nikt nie oferowa� Ci kupna biznesu"); 
		return 1;
	}
	
	if(GetPlayerBusiness(playerid) != INVALID_BIZ_ID)
	{
		sendTipMessage(playerid, "Masz ju� jaki� biznes!");
		return 1;
	}

	if(!IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Gracz, kt�ry oferowa� Ci biznes wyszed� z serwera"); 
		ResetBizOffer(playerid);
		return 1;
	}

	if(kaska[playerid] < price)
	{
		sendTipMessage(playerid, "Nie masz takiej kwoty"); 
		ResetBizOffer(playerid);
		return 1;
	}

	new businessID = GetPVarInt(playerid, "Biznes_ID"); 
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Ten gracz nie ma biznesu.");
		return 1;
	}

	if(businessID != PlayerInfo[giveplayerid][pBusinessOwner])
	{
		sendErrorMessage(playerid, "Nieprawid�owe ID biznesu.");
		ResetBizOffer(playerid);
		return 1;
	}

	ZabierzKase(playerid, price);
	DajKase(giveplayerid, (price-tax)); 
	Sejf_Add(FRAC_GOV, tax); 
	Sejf_Save(FRAC_GOV); 

	format(string, sizeof(string), "%s [ID:%d] kupi� biznes [ID: %d] od %s [ID: %d] za %d$", 
		GetNickEx(playerid), 
		playerid, 
		businessID, 
		GetNickEx(giveplayerid), 
		giveplayerid, 
		price
	);
	SendLeaderRadioMessage(FRAC_GOV, COLOR_LIGHTGREEN, string);
	SendAdminMessage(COLOR_P@, string); 
	
	//Wykonanie czynno�ci
	PlayerInfo[giveplayerid][pBusinessOwner] = INVALID_BIZ_ID; 
	PlayerInfo[playerid][pBusinessOwner] = businessID;
	Business[businessID][b_cost] = price;
	Business[businessID][b_ownerUID] = PlayerInfo[playerid][pUID]; 
	Business[businessID][b_Name_Owner] = GetNick(playerid); 
	MruMySQL_SaveAccount(playerid);
	MruMySQL_SaveAccount(giveplayerid); 

	Log(payLog, INFO, "%s sprzeda� %s biznes %s za %d$",
		GetPlayerLogName(giveplayerid),
		GetPlayerLogName(playerid),
		GetBusinessLogName(businessID),
		price
	);

	ResetBizOffer(giveplayerid); 
	ResetBizOffer(playerid);
	return 1;
}
//end