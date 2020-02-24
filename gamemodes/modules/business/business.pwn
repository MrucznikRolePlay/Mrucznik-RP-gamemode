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
}
stock LoadBiz()
{
	new query[1024];
	new lStr[64];  
	new valueBiz; 
	new lStr2[64];
	new string[64];
	format(lStr, sizeof(lStr), "SELECT COUNT(*) FROM `mru_biz`");
	mysql_query(lStr);
	mysql_store_result();
	mysql_fetch_row_format(lStr2,"|");
	valueBiz = strval(lStr2);
	mysql_free_result();

	for(new i; i <= MAX_BIZ; i++) 
	{
		lStr = "`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`";
		format(query, sizeof(query), "SELECT %s FROM `mru_biz` WHERE `ID`='%d'", lStr, i);
		mysql_query(query); 
		mysql_store_result();
		if (mysql_num_rows())
		{
			mysql_fetch_row_format(lStr, "|");
			sscanf(lStr, "p<|>dds[32]s[64]ffffffdddds[64]d",
			mBiz[i][b_ID], 
			mBiz[i][b_ownerUID],
			mBiz[i][b_Name_Owner],
			mBiz[i][b_Name],
			mBiz[i][b_enX],
			mBiz[i][b_enY],
			mBiz[i][b_enZ],
			mBiz[i][b_exX],
			mBiz[i][b_exY],
			mBiz[i][b_exZ],
			mBiz[i][b_vw],
			mBiz[i][b_int],
			mBiz[i][b_pLocal],
			mBiz[i][b_cost],
			mBiz[i][b_Location],
			mBiz[i][b_moneyPocket]);
			loadedBiz++; 
		}
		mysql_free_result();
	}
	format(string, sizeof(string), "Zaladowano %d biznesow z %d w bazie", loadedBiz, valueBiz);
	print(string);
	return 1;
}
stock SaveBiz(bIDE)
{

	return 1;
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
	new float:posX, float:posY, float:posZ; 
	GetPlayerPos(playerid, posX, posY, posZ);
	new pZone[MAX_ZONE_NAME];
	GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	new query[1024];
	new bIDE = FreeBizID();
	//=====================================[Polecenie do bazy danych]============================
	format(query, sizeof(query), "INSERT INTO `mru_biz` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`) VALUES\
	('%d', '%d', '%s', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%s', '%d')", 
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
	0);
	mysql_query(query);


	//================================[Tworzenie biznesu w czasie realnym]=========================
	mysql_real_escape_string(bName, mBiz[bIDE][b_Name]); 
	mysql_real_escape_string("Brak", mBiz[bIDE][b_Name_Owner]); 
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
	mysql_real_escape_string(pZone, mBiz[bIDE][b_Location]);
	mBiz[bIDE][b_TYPE] = BTYPE_DEFAULT; 
	mBiz[bIDE][b_TYPE2] = BTYPE2_DEFAULT; 
	CreateDynamic3DTextLabel(mBiz[bIDE][b_Name], 0x008080FF, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]+0.4, 10.0);
    CreateDynamicPickup(1272, 1, mBiz[bIDE][b_enX], mBiz[bIDE][b_enY], mBiz[bIDE][b_enZ]+0.4, 0, 0, -1, STREAMER_PICKUP_SD); 
	loadedBiz++; 
	return 1;
}
//end