//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  business                                                 //
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
// Autor: Simeone
// Data utworzenia: 04.02.2020
//Opis:
/*
	System biznesów Mrucznik'a Role Play 2.0 
*/

//

//-----------------<[ Funkcje: ]>-------------------
BizExist(value)
{
	if(mBiz[value][b_enX] != 0)
	{
		return true;
	}
	return false; 
}
stock FreeBizID()
{
	for(new i; i <= MAX_BIZ; i++)
	{
		if(!BizExist(i))
		{
			return i; 
		}
	} 
	return INVALID_BUSINESSID;
}
GetBusinessName(bIDE)
{
	new string[64];
	format(string, sizeof(string), "%s", mBiz[bIDE][b_Name]);
	return string; 
}
GetBusinessOwnerName(bIDE)
{
	new string[MAX_PLAYER_NAME];
	format(string, sizeof(string), "%s", mBiz[bIDE][b_Name_Owner]);
	return string; 
}
stock CreateMBiz(playerid, bCost, bName[64])
{
	//=====================================[Sprawdzanie poprawnoœci]============================
	if(loadedBiz+1 >= MAX_BIZ)
    {
        sendErrorMessage(playerid, "Serwer osi¹gn¹³ maksymaln¹ wartoœæ biznesów!"); 
        return 1;
    }
	
	
	//======================[Pobieranie informacji, tworzenie zmiennych]========================
	new Float:posX, Float:posY, Float:posZ; 
	GetPlayerPos(playerid, posX, posY, posZ);
	new pZone[MAX_ZONE_NAME];
	GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	new query[1024];
	new bIDE = FreeBizID();
	//=====================================[Polecenie do bazy danych]============================
	format(query, sizeof(query), "INSERT INTO `mru_biz` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`, `bTYPE`, `bTYPE2`, `ulepszenie1`, `ulepszenie2`, `ulepszenie3`, `ulepszenie4`, `ulepszenie5`, `bMOTD`, `neededType`) VALUES ('%d', '%d', '%s', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%s', '%d')", 
	bIDE, 
	0,
	"Brak",
	bName,
	posX, 
	posY,
	posZ,
	posX,
	posY,
	posZ,
	0,
	0,
	PLOCAL_DEFAULT,
	bCost,
	pZone,
	0,
	BTYPE_DEFAULT,
	BTYPE_DEFAULT,
	0,
	0,
	0,
	0,
	0,
	"[Default MOTD] Witaj w biznesie",
	9999);
	mysql_query(query);


	//================================[Tworzenie biznesu w czasie realnym]=========================
	mysql_real_escape_string(bName, mBiz[bIDE][b_Name]); 
	mysql_real_escape_string("Brak", mBiz[bIDE][b_Name_Owner]);
	mysql_real_escape_string("[Default MOTD] Witaj w biznesie", mBiz[bIDE][b_motd]); 
	mBiz[bIDE][b_ownerUID] = 0; 
	mBiz[bIDE][b_moneyPocket] = 0; 
	mBiz[bIDE][b_enX] = posX;
	mBiz[bIDE][b_enY] = posY;
	mBiz[bIDE][b_enZ] = posZ; 
	mBiz[bIDE][b_exX] = posX;
	mBiz[bIDE][b_exY] = posY;
	mBiz[bIDE][b_exZ] = posZ; 
	mBiz[bIDE][b_int] = 0;
	mBiz[bIDE][b_vw] = 0;
	mBiz[bIDE][b_pLocal] = PLOCAL_DEFAULT; 
	mBiz[bIDE][b_cost] = bCost;
	mBiz[bIDE][b_neededType] = BTYPE_DEFAULT;
	mysql_real_escape_string(pZone, mBiz[bIDE][b_Location]);
	mBiz[bIDE][b_TYPE2] = BTYPE_DEFAULT; 
	CreateBusiness3DText(bIDE);
	CreateBusinessIcon(bIDE); 
	loadedBiz++; 
	Log(businessLog, INFO, "BusinessGod %s stworzyl biznes %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE));
	return 1;
}
CheckSymbolsInText(const inputtext[])
{
	new textSize = strlen(inputtext); 
	for(new i; i <= textSize; i++)
	{
		if(inputtext[i] == '%'
		|| inputtext[i] == '/'
		|| inputtext[i] == '\n'
		|| inputtext[i] == '#')
		{
			return false;
		}
	}
	return true; 
}
DestroyBusinessIcon(bIDE)
{
	DestroyDynamicPickup(businessIcon[bIDE]);
	return 0;
}
DestroyBusiness3DText(bIDE)
{
	DestroyDynamic3DTextLabel(businessText[bIDE]);
	return 0; 
}
CreateBusinessIcon(bIDE)
{
	businessIcon[bIDE] = CreateDynamicPickup(1274, 1, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]-0.1, 0, 0, -1, STREAMER_PICKUP_SD);
	return 0;
}
CreateBusiness3DText(bIDE)
{
	businessText[bIDE] = CreateDynamic3DTextLabel(mBiz[bIDE][b_Name], 0x008080FF, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]+0.3, 10.0);
	return 0;
}
CreateBusinessIcons()
{
	new iconsLoaded; 
	for(new i; i <= MAX_BIZ; i++)
	{
		if(iconsLoaded == loadedBiz)
		{
			return 1;
		}
		if(BizExist(i))
		{
			CreateBusiness3DText(i);
			CreateBusinessIcon(i);
			iconsLoaded++; 
		}
	}
	return 0; 
}
GiveBizToPlayer(playerid, bIDE, bType2)
{
	new string[124]; 
	strdel(mBiz[bIDE][b_Name_Owner], 0, strlen(mBiz[bIDE][b_Name_Owner]));
    strcat(mBiz[bIDE][b_Name_Owner], GetNick(playerid), MAX_PLAYER_NAME);
	mBiz[bIDE][b_ownerUID] = PlayerInfo[playerid][pUID]; 
	mBiz[bIDE][b_moneyPocket] = 0; 
	mBiz[bIDE][b_TYPE2] = bType2; 
	mBiz[bIDE][b_elementsPocket] = 2000; 
	SendClientMessage(playerid, COLOR_GREEN, "======<[Zakupi³eœ nowy biznes]>======");
	format(string, sizeof(string), "ID: [%d] NAME: [%s] LOCATION: [%s]", bIDE, GetBusinessLogName(bIDE), mBiz[bIDE][b_Location]); 
	SendClientMessage(playerid, COLOR_RED, string); 
	sendTipMessage(playerid, "Mo¿esz zarz¹dzaæ swoim biznesem za pomoc¹ /mbizpanel"); 
	Log(businessLog, INFO, "Gracz %s kupil biznes %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE));
	SaveBiz(bIDE);
	PlayerInfo[playerid][pBusinessOwner] = bIDE; 
	return 1;
}
PlayerNearBusinessType(playerid, btype)
{
	new businessChecked; 
	for(new i; i<=MAX_BIZ; i++)
	{
		if(businessChecked == loadedBiz)
		{
			return false; 
		}
		if(BizExist(i))
		{
			if(mBiz[i][b_TYPE2] == btype)
			{
				if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ])
				&& GetPlayerVirtualWorld(playerid) == 0)//SPRAWDZANIE ZEWN¥TRZ
				{
					return true;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 10.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]) 
				&& GetPlayerVirtualWorld(playerid) == mBiz[i][b_vw]
				&& GetPlayerInterior(playerid) == mBiz[i][b_int])// SPRAWDZANIE WEWN¥TRZ
				{
					return true;
				}
			}	
			businessChecked++; 
		}
	}
	return false; 
}
GetNearBusinessID(playerid)
{
	for(new i; i<=MAX_BIZ; i++)
	{
		if(i == MAX_BIZ)
		{
			break;
		}
		if(BizExist(i))
		{
			if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ])
			&& GetPlayerVirtualWorld(playerid) == 0)//SPRAWDZANIE ZEWN¥TRZ
			{
				return i;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]) 
			&& GetPlayerVirtualWorld(playerid) == mBiz[i][b_vw]
			&& GetPlayerInterior(playerid) == mBiz[i][b_int])// SPRAWDZANIE WEWN¥TRZ
			{
				return i;
			}
		}
	}
	return INVALID_BUSINESSID; 
}
GetTempPocketMaxSpace(bIDE)
{
	new value;
	if(mBiz[bIDE][b_ulepszenie5] > 0)
	{
		value = MAX_CASH_IN_TEMPPOCKET+(mBiz[bIDE][b_ulepszenie5]*1000000); 
	}
	else 
	{
		value = MAX_CASH_IN_TEMPPOCKET;
	}
	return value; 
}
GetPocketMaxSpace(bIDE)
{
	new value;
	if(mBiz[bIDE][b_ulepszenie4] > 0)
	{
		value = MAX_CASH_IN_MONEYPOCKET+(mBiz[bIDE][b_ulepszenie4]*1000000); 
	}
	else 
	{
		value = MAX_CASH_IN_MONEYPOCKET;
	}
	return value; 
}
GetElementsFromBusiness(bIDE, value)
{
	mBiz[bIDE][b_elementsPocket] = mBiz[bIDE][b_elementsPocket]-value;
	return 1;
}
DajKaseBizTemp(bIDE, playerid, value)
{
	new oldValue = mBiz[bIDE][b_tempPocket]; 
	if(!BizExist(bIDE))
	{
		Log(businessCashLog, INFO, "CRASH LOG DLA %d tBID", bIDE);
		return 1; 
	}
	if(playerid == INVALID_PLAYER_ID)//Wykonywanie dla dodania bez osoby fizycznej
	{
		if(mBiz[bIDE][b_tempPocket]+value <= GetTempPocketMaxSpace(bIDE))
		{
			mBiz[bIDE][b_tempPocket]=mBiz[bIDE][b_tempPocket]+value;
			Log(businessCashLog, INFO, "[TEMP] W biznes %s wplynelo %d$ poprzednio %d$ nowa wartosc %d$", GetBusinessLogName(bIDE), value, oldValue, mBiz[bIDE][b_tempPocket]);
		}
	}
	else //Wykonanie dla dodania z osob¹ fizyczn¹
	{
		if(mBiz[bIDE][b_tempPocket]+value <= GetTempPocketMaxSpace(bIDE))
		{
			mBiz[bIDE][b_tempPocket]=mBiz[bIDE][b_tempPocket]+value; 
			Log(businessCashLog, INFO, "[TEMP] W biznes %s wplynelo %d$ od %s poprzednio %d$ nowa wartosc %d$", GetBusinessLogName(bIDE), GetPlayerLogName(playerid), value, oldValue, mBiz[bIDE][b_tempPocket]);
		}
	}
	return 1; 
}
PlayerRunWithMoney(playerid)//TODO: Do przepisania zgodnie z uwaga 0Verte
{
	new bIDE = PlayerInfo[playerid][pBusinessOwner];
	new string[256];
	if(bIDE == INVALID_BUSINESSID)
	{
		sendErrorMessage(playerid, "Wyst¹pi³ problem z wyp³aceniem i przewiezieniem gotówki biznesu!");
		sendTipMessage(playerid, "Twój biznes nie odpowiada"); 
		return 1;
	}
	if(mBiz[bIDE][b_tempPocket] <= 0)
	{
		sendTipMessage(playerid, "Nie masz nic w sejfie tymczasowym biznesu - nie mo¿esz rozpocz¹æ przewozu gotówki"); 
		return 1;
	}
	if(mBiz[bIDE][b_tempPocketUsage]+1 > 3)
	{
		sendErrorMessage(playerid, "Mo¿esz przewoziæ gotówkê maksymalnie 3 razy dziennie!"); 
		return 1;
	}
	if(GetNearBusinessID(playerid) != PlayerInfo[playerid][pBusinessOwner])
	{
		sendErrorMessage(playerid, "Nie stoisz przy swoim biznesie!");
		return 1;
	}
	sendTipMessageEx(playerid, COLOR_GREEN, "Rozpoczynasz przewóz gotówki!"); 
	sendTipMessage(playerid, "Z sejfu zosta³a wyci¹gniêta gotówka, masz j¹ teraz przy sobie!"); 
	sendTipMessage(playerid, "Uwa¿aj na z³odziejaszków, którzy czaj¹ siê za ka¿dym rogiem. Twoim zadaniem jest dostanie siê [.]");
	sendTipMessage(playerid, "[.] bezpiecznie do banku i wpisanie komendy /mbizmoney. Mo¿esz t¹ akcje wykonywaæ maksymalnie 3x/dzieñ.");
	sendTipMessageEx(playerid, COLOR_RED, "Uwaga! Je¿eli wyrzuci Ciê teraz z serwera - gotówka nie wróci do biznesu!");
	format(string, sizeof(string), "%s wyci¹ga z sejfu %s gotówkê w wysokoœci $%d", GetNick(playerid), GetBusinessName(bIDE), mBiz[bIDE][b_tempPocket]);
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE); 
	PlayerMoneyFromBiz[playerid] = mBiz[bIDE][b_tempPocket]; 
	mBiz[bIDE][b_tempPocket] = 0; 
	mBiz[bIDE][b_tempPocketUsage]++; 
	
	//Obiekt torby
	AttachPlayerItem(playerid, 19624, 6, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 1.0, 1.0, 1.0, 0,0);
	//SetPlayerAttachedObject(playerid, 7, zd, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
	return 1;
}
SendBizLogoMessage(playerid, bIDE)
{
	new string[124];
	format(string, sizeof(string), "=========<[ %s ]>========", GetBusinessName(bIDE));
	SendClientMessage(playerid, COLOR_GREEN, string); 
	return 1;
}
ShowBusinessOwnerDialog(playerid, dialogType)
{
	
	new bIDE = PlayerInfo[playerid][pBusinessOwner]; 
	new string[312]; 
	if(bIDE == INVALID_BUSINESSID)
	{
		sendErrorMessage(playerid, "Nieprawid³owa w³asnoœæ biznesu"); 
		return 1;
	}
	if(dialogType ==  DIALOG_MAIN)
	{
		format(string, sizeof(string), "{F3EB34}====<[%s]>====\t \n\
		Pracownicy\t \n\
		Sejfy\t \n\
		Zarzadzaj drzwiami\t \n\
		Dodatki\t ", GetBusinessName(bIDE)); 
		ShowPlayerDialogEx(playerid, DIALOG_BIZ_OWNER, DIALOG_STYLE_TABLIST, SetDefaultCaption(), 
		string, "Akceptuj", "Odrzuæ"); 
	}
	else if(dialogType == DIALOG_WORKERS)
	{
		format(string, sizeof(string), "{F3EB34}====<[%s]>====\t \n\
		Pracownicy On-line:\t{33AA33}%d\n\
		Przyjmij\t \n\
		Zwolnij\t ", GetBusinessName(bIDE), 0); 
		ShowPlayerDialogEx(playerid, DIALOG_BIZ_OWNER2, DIALOG_STYLE_TABLIST, SetDefaultCaption(), 
		string, "Akceptuj", "Wstecz"); 
	}
	else if(dialogType == DIALOG_SEJF)
	{
		format(string, sizeof(string), "{F3EB34}====<[%s]>====\t \n\
		Stan sejfu G:\t{33AA33}$%d\n\
		Wp³aæ\t \n\
		Wyp³aæ\t \n\
		Stan sejfu T:\t{33AA33}$%d\n\
		Wyp³aæ\t \n\
		Stan sejfu materia³ów:\t{33AA33}%d", GetBusinessName(bIDE), mBiz[bIDE][b_moneyPocket], mBiz[bIDE][b_tempPocket], mBiz[bIDE][b_elementsPocket]); 
		ShowPlayerDialogEx(playerid, DIALOG_BIZ_OWNER3, DIALOG_STYLE_TABLIST, SetDefaultCaption(), 
		string, "Akceptuj", "Wstecz"); 
	}
	else if(dialogType == DIALOG_DOORS)
	{
		format(string, sizeof(string), "{F3EB34}====<[%s]>====\t \n\
		Otwórz\t \n\
		Zamknij\t \n\
		Ustal godziny otwarcia\t ", GetBusinessName(bIDE)); 
		ShowPlayerDialogEx(playerid, DIALOG_BIZ_OWNER4, DIALOG_STYLE_TABLIST, SetDefaultCaption(), 
		string, "Akceptuj", "Wstecz"); 
	}
	else if(dialogType == DIALOG_ADDS)
	{
		format(string, sizeof(string), "{F3EB34}====<[%s]>====\t \n\
		Zmiana nazwy\t{33AA33}$%d\n\
		Zmiana MOTD\t{33AA33}$%d\n\
		Spawn pod biznesem\t{33AA33}$%d\n\
		Rozwój sejfu G\t{33AA33}$%d\n\
		Rozwój sejfu T\t{33AA33}$%d\n\
		Dodaj interior\t \n\
		Rozwój sejfu materia³ów\t{33AA33}$%d",
		GetBusinessName(bIDE),
		B_CENA_ZMIENAZWE,
		B_CENA_ZMIENMOTD,
		B_CENA_ZMIENSPAWN,
		B_CENA_SEJFG,
		B_CENA_SEJFT,
		B_CENA_SEJFE); 
		ShowPlayerDialogEx(playerid, DIALOG_BIZ_OWNER5, DIALOG_STYLE_TABLIST, SetDefaultCaption(), 
		string, "Akceptuj", "Wstecz"); 
	}
	else
	{
		sendErrorMessage(playerid, "INVALID DIALOG TYPE"); 
	}
	return 1;
}
ShowInteriorList(playerid)
{
	new string[456];
	format(string, sizeof(string), "Nazwa\tWielkoœæ\tCena\n\
	%s\t%s\t$%d\n\
	%s\t%s\t$%d\n\
	%s\t%s\t$%d\n\
	%s\t%s\t$%d",
	interiorsPos[0][i_name],
	interiorsPos[0][i_size],
	interiorsPos[0][i_cost],
	interiorsPos[1][i_name],
	interiorsPos[1][i_size],
	interiorsPos[1][i_cost],
	interiorsPos[2][i_name],
	interiorsPos[2][i_size],
	interiorsPos[2][i_cost],
	interiorsPos[3][i_name],
	interiorsPos[3][i_size],
	interiorsPos[3][i_cost]);
	ShowPlayerDialogEx(playerid, DIALOG_BIZ_INTERIORLIST, DIALOG_STYLE_TABLIST_HEADERS, SetDefaultCaption(),
	string, "Dalej", "WyjdŸ"); 
	return 1;
}
IsABusinessGod(playerid)//Pozwala zarz¹dzaæ biznesami
{
	if(PlayerInfo[playerid][pAdmin] >= 5000)//Tylko dla H@ - DO ZMIANY NA UID!!!!!!!
	{
		return true;
	}
	return false; 
}
IsPlayerNearBusinessDoor(playerid)//Powoduje wejœcie do biznesu
{
	new string[124];
	new checkedBiz; 
	for(new i; i<=MAX_BIZ; i++)
	{
		if(checkedBiz == loadedBiz)
		{
			sendTipMessageEx(playerid, COLOR_WHITE, "Nie uda³o siê zlokalizowaæ ¿adnego biznesu wokó³ Ciebie. Upewnij siê, ¿e stoisz w ikonce biznesu.");
			break; 
		}
		if(BizExist(i))
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.5, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ])
			&& GetPlayerVirtualWorld(playerid) == 0)
			{
				if(mBiz[i][b_vw] == 0)
				{	
					sendErrorMessage(playerid, "Ten biznes nie posiada ¿adnego wnêtrza!"); 
					sendTipMessage(playerid, "Je¿eli chcesz skorzystaæ z jego udogodnieñ - stañ w jego ikonce.");
					return 1;
				}
				SetPlayerPos(playerid, mBiz[i][b_exX], mBiz[i][b_exY], mBiz[i][b_exZ]);
				SetPlayerInterior(playerid, mBiz[i][b_int]);
				SetPlayerVirtualWorld(playerid, mBiz[i][b_vw]);
				sendTipMessageEx(playerid, COLOR_GREEN, mBiz[i][b_motd]); 
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.5, mBiz[i][b_exX], mBiz[i][b_exY], mBiz[i][b_exZ])
			&& GetPlayerVirtualWorld(playerid) != 0)
			{
				new bIDE = GetPlayerVirtualWorld(playerid)-1000; 
				if(!BizExist(bIDE))//Nie powinno wyst¹piæ
				{
					sendErrorMessage(playerid, "Wyst¹pi³ b³¹d (niezgodne ID wyjœcia z interioru) - zg³oœ go na forum!");
					return 1;
				}
				SetPlayerPos(playerid, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]);
				SetPlayerInterior(playerid, mBiz[bIDE][b_int]);
				SetPlayerVirtualWorld(playerid, mBiz[bIDE][b_vw]);
				format(string, sizeof(string), "Dziêkujemy za przybycie i zapraszamy ponownie - %s", GetBusinessName(bIDE)); 
				sendTipMessageEx(playerid, COLOR_GREEN, string); 
			}
			checkedBiz++; 
		}
	}
	return 0; 
}
SetPlayerBusiness(playerid)
{
	new businessChecked;
	for(new i; i<=MAX_BIZ; i++)
	{
		if(businessChecked == loadedBiz)
		{
			break;
		}
		if(BizExist(i))
		{
			if(mBiz[i][b_ownerUID] == PlayerInfo[playerid][pUID])
			{
				PlayerInfo[playerid][pBusinessOwner] = i; 
				break;
			}
			businessChecked++; 
		}
	}
	return 0; 
}
CheckPlayerBusiness(playerid)
{
	new string[124];
	//Korekcja nieprawid³owego biznesu
	if(PlayerInfo[playerid][pBusinessOwner] == 0
	|| PlayerInfo[playerid][pBusinessMember] == 0)
	{
		PlayerInfo[playerid][pBusinessOwner] = INVALID_BUSINESSID;
		PlayerInfo[playerid][pBusinessMember] = INVALID_BUSINESSID; 
	}
	else if(PlayerInfo[playerid][pBusinessOwner] > 0)
	{
		if(BizExist(PlayerInfo[playerid][pBusinessOwner]))
		{
			if(mBiz[PlayerInfo[playerid][pBusinessOwner]][b_ownerUID] != PlayerInfo[playerid][pUID])
			{
				format(string, sizeof(string), "ID binesu ze stats: [%d], bizOwner: [%d] -> Kliknij F8 (zrób screenshot'a)", PlayerInfo[playerid][pBusinessOwner], mBiz[PlayerInfo[playerid][pBusinessOwner]][b_ownerUID]); 
				sendErrorMessage(playerid, "Twój biznes nale¿y do kogoœ innego // nie ma w³aœciciela!"); 
				sendTipMessage(playerid, "Je¿eli uwa¿asz to za b³¹d mo¿esz napisaæ stratê na naszym forum!"); 
				sendTipMessageEx(playerid, COLOR_RED, string); 
				PlayerInfo[playerid][pBusinessOwner] = INVALID_BUSINESSID;
			}
		}
		else 
		{
			format(string, sizeof(string), "ID biznesu ze stats: [%d] -> kliknij F8 (zrób screenshot'a)", PlayerInfo[playerid][pBusinessOwner]); 
			sendErrorMessage(playerid, "Nie uda³o siê odnaleŸæ twojego biznesu w bazie danych.");
			sendTipMessage(playerid, "Je¿eli uwa¿asz to za b³¹d mo¿esz napisaæ stratê na naszym forum!"); 
			sendTipMessageEx(playerid, COLOR_RED, string); 
			PlayerInfo[playerid][pBusinessOwner] = INVALID_BUSINESSID;
		}
	}
	return 0; 
}
GetBusinessTypeName(bIDE)
{
	new string[64], businessType; 
	businessType = mBiz[bIDE][b_TYPE2]; 
	if(businessType == BTYPE_DEFAULT)
	{
		format(string, sizeof(string), "Brak typu"); 
	}
	else if(businessType == BTYPE_SHOP)
	{
		format(string, sizeof(string), "%s", BNAME_SHOP); 
	}
	else if(businessType == BTYPE_CLOTHESSHOP)
	{
		format(string, sizeof(string), "%s", BNAME_CLOTHESSHOP); 
	}
	else if(businessType == BTYPE_RESTAURANT)
	{
		format(string, sizeof(string), "%s", BNAME_RESTAURANT); 
	}
	else if(businessType == BTYPE_WORKSHOP)
	{
		format(string, sizeof(string), "%s", BNAME_WORKSHOP); 
	}
	else if(businessType == BTYPE_HOTEL)
	{
		format(string, sizeof(string), "%s", BNAME_HOTEL); 
	} 
	else
	{
		format(string, sizeof(string), "Nieznany"); 
	}
	return string;
}
StartLicytacjaBiz(bIDE, playerid, bChoice)
{
	new string[256]; 
	foreach(new i : Player)
	{
		SendClientMessage(i, COLOR_GREEN, "=======<[ San Andreas Property Department ]>=======");
		format(string, sizeof(string), "Pan(i) %s rozpoczê³a licytacjê obiektu %s [.]", GetNick(playerid), GetBusinessName(bIDE));
		SendClientMessage(i, COLOR_WHITE, string);
		format(string, sizeof(string), "[.] znajduj¹cego siê na %s. Cena proponowana $%d", mBiz[bIDE][b_Location], mBiz[bIDE][b_cost]);
		SendClientMessage(i, COLOR_WHITE, string); 
		SendClientMessage(i, COLOR_GREEN, "=====<[ Koniec komunikatu ]>====="); 
		sendTipMessage(playerid, "Je¿eli chcia³byœ zalicytowaæ obiekt podejdŸ do niego i wpisz /licytuj"); 
		//MRUCZNIK - DO DOKOÑCZENIA (LICYTACJE) 
	}
	mBiz[bIDE][b_auction] = 1; //Trwa licytacja na ten biznes
	return 1; 
}
GetCostFromDistance(playerid, pX, pY, pZ)//TODO: Przenieœæ do osobnego modu³u
{
	new value = ((floatround(GetPlayerDistanceFromPoint(playerid, pX, pY, pZ))/1000)*500);
	value = floatround(value); 
	return value;
}
//end