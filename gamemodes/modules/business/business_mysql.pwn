//-----------------------------------------------<< MySQL >>-------------------------------------------------//
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

//------------------<[ MySQL: ]>--------------------

stock LoadBiz()
{
	new query[1024];
	new lStr[256];  
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
		lStr = "`ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`";
		format(query, sizeof(query), "SELECT %s FROM `mru_biz` WHERE `ID`='%d'", lStr, i);
		mysql_query(query); 
		mysql_store_result();
		if (mysql_num_rows())
		{
			mysql_fetch_row_format(query, "|");
			sscanf(query, "p<|>ds[32]s[64]ffffffdddds[64]d",
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
	new query[1024]; 
	format(query, sizeof(query), "UPDATE `mru_biz` SET \
	`ID`='%d',\
	`ownerUID`='%d',\
	`ownerName`='%s'\
	`Name`='%s',\
	`enX`='%f',\
	`enY`='%f',\
	`enZ`='%f',\
	`exX`='%f',\
	`exY`='%f',\
	`exZ`='%f',\
	`exVW`='%d',\
	`exINT`='%d',\
	`pLocal`='%d',\
	`Cost`='%d',\
	`Location`='%s',\
	`MoneyPocket`='%d'\
	WHERE `ID`='%d'", 
	bIDE, 
	mBiz[bIDE][b_ownerUID],
	mBiz[bIDE][b_Name_Owner],
	mBiz[bIDE][b_Name],
	mBiz[bIDE][b_enX],
	mBiz[bIDE][b_enY],
	mBiz[bIDE][b_enZ],
	mBiz[bIDE][b_exX],
	mBiz[bIDE][b_exY],
	mBiz[bIDE][b_exZ],
	mBiz[bIDE][b_vw],
	mBiz[bIDE][b_int],
	mBiz[bIDE][b_pLocal],
	mBiz[bIDE][b_cost],
	mBiz[bIDE][b_Location],
	mBiz[bIDE][b_moneyPocket],
	bIDE);
	mysql_query(query);
	return 1;
}

//end