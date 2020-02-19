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
	new lStr[326];  
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
		lStr = "`ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Cost`, `Location`, `MoneyPocket`, `bTYPE`, `bTYPE2`, `ulepszenie1`, `ulepszenie2`, `ulepszenie3`, `ulepszenie4`, `ulepszenie5`, `bMOTD`, `neededType`, `bAuction`, `bSejfE`";
		format(query, sizeof(query), "SELECT %s FROM `mru_biz` WHERE `ID`='%d'", lStr, i);
		mysql_query(query); 
		mysql_store_result();
		if (mysql_num_rows())
		{
			mysql_fetch_row_format(query, "|");
			sscanf(query, "p<|>ds[32]s[64]ffffffdddds[64]dddddddds[64]ddd",
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
			mBiz[i][b_moneyPocket],
			mBiz[i][b_TYPE],
			mBiz[i][b_TYPE2],
			mBiz[i][b_ulepszenie1],
			mBiz[i][b_ulepszenie2],
			mBiz[i][b_ulepszenie3],
			mBiz[i][b_ulepszenie4],
			mBiz[i][b_ulepszenie5],
			mBiz[i][b_motd],
			mBiz[i][b_neededType],
			mBiz[i][b_auction],
			mBiz[i][b_elementsPocket]);
			loadedBiz++; 
		}
		mysql_free_result();
	}
	format(string, sizeof(string), "Zaladowano %d biznesow z %d w bazie", loadedBiz, valueBiz);
	print(string);
	return 0;
}
stock SaveBiz(bIDE)
{
	new query[1024]; 
	format(query, sizeof(query), "UPDATE `mru_biz` SET \
	`ID`='%d',\
	`ownerUID`='%d',\
	`ownerName`='%s',\
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
	`MoneyPocket`='%d',\
	`bTYPE`='%d',\
	`bTYPE2`='%d',\
	`ulepszenie1`='%d',\
	`ulepszenie2`='%d',\
	`ulepszenie3`='%d',\
	`ulepszenie4`='%d',\
	`ulepszenie5`='%d',\
	`bMOTD`='%s',\
	`neededType`='%d',\
	`bAuction`='%d', \
	`bSejfE`='%d', \
	WHERE `ID`='%d'", 
	bIDE, 
	mBiz[bIDE][b_ownerUID],
	GetBusinessOwnerName(bIDE),
	GetBusinessName(bIDE),
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
	mBiz[bIDE][b_TYPE],
	mBiz[bIDE][b_TYPE2],
	mBiz[bIDE][b_ulepszenie1],
	mBiz[bIDE][b_ulepszenie2],
	mBiz[bIDE][b_ulepszenie3],
	mBiz[bIDE][b_ulepszenie4],
	mBiz[bIDE][b_ulepszenie5],
	mBiz[bIDE][b_motd],
	mBiz[bIDE][b_neededType],
	mBiz[bIDE][b_auction],
	mBiz[bIDE][b_elementsPocket],
	bIDE);
	mysql_query(query);
	return 0;
}

//end