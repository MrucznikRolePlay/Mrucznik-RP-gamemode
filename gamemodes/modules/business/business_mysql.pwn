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
	aaa
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

//end