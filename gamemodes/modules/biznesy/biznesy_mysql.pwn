//-----------------------------------------------<< MySQL >>-------------------------------------------------//
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
	System biznesÃ³w.
*/

//

//------------------<[ MySQL: ]>--------------------
LoadBusiness()//?adowanie biznesów z bazy danych
{
	//Tworzenie BIZ na ID 0
	mysql_escape_string("Testowy Biznes", Business[0][b_Name]); 
	Business[0][b_ownerUID] = 0; 
	Business[0][b_enX] = 0.0;
	Business[0][b_enY] = 0.0;
	Business[0][b_enZ] = -2.0; 
	Business[0][b_exX] = 0.0;
	Business[0][b_exY] = 0.0;
	Business[0][b_exZ] = -2.0; 
	Business[0][b_int] = 0;   
	Business[0][b_vw] = 0; 
	Business[0][b_pLocal] = 255; 
	Business[0][b_maxMoney] = 0;
	Business[0][b_cost] = 100000000;
	mysql_escape_string("Szmulowice Dolne", Business[0][b_Location]); 
	mysql_escape_string("Brak - na sprzeda¿", Business[0][b_Name_Owner]);
	BusinessLoaded=0;

	new Cache:result = mysql_query(mruMySQL_Connection, "SELECT `ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket` \
		FROM `mru_business`", true);
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
		{
			new CurrentBID;
			cache_get_value_index_int(i, 0, CurrentBID);
			Business[CurrentBID][b_ID] = CurrentBID; //wut??
			cache_get_value_index_int(i, 1, Business[CurrentBID][b_ownerUID]);
			cache_get_value_index(i, 2, Business[CurrentBID][b_Name_Owner]);
			cache_get_value_index(i, 3, Business[CurrentBID][b_Name]);
			cache_get_value_index_float(i, 4, Business[CurrentBID][b_enX]);
			cache_get_value_index_float(i, 5, Business[CurrentBID][b_enY]);
			cache_get_value_index_float(i, 6, Business[CurrentBID][b_enZ]);
			cache_get_value_index_float(i, 7, Business[CurrentBID][b_exX]);
			cache_get_value_index_float(i, 8, Business[CurrentBID][b_exY]);
			cache_get_value_index_float(i, 9, Business[CurrentBID][b_exZ]);
			cache_get_value_index_int(i, 10, Business[CurrentBID][b_vw]);
			cache_get_value_index_int(i, 11, Business[CurrentBID][b_int]);
			cache_get_value_index_int(i, 12, Business[CurrentBID][b_pLocal]);
			cache_get_value_index_int(i, 13, Business[CurrentBID][b_maxMoney]);
			cache_get_value_index_int(i, 14, Business[CurrentBID][b_cost]);
			cache_get_value_index(i, 15, Business[CurrentBID][b_Location]);
			cache_get_value_index_int(i, 16, Business[CurrentBID][b_moneyPocket]);

			if(strlen(Business[CurrentBID][b_Name]) >= 3)
			{
				BusinessLoaded++; 
			}
		}
		cache_delete(result);
	}
	return 1;
}
ClearBusinessOwner(businessID)
{
	//TODO: MySQL
	// new query[256];
	// format(query, sizeof(query), "UPDATE `mru_konta` SET \
	// `bizz`='%d' \
	// WHERE `bizz`='%d'", INVALID_BIZ_ID, businessID); 
	// mysql_query(query); 
	// format(query, sizeof(query), "UPDATE `mru_business` SET \
	// `ownerUID`='%d', \
	// `ownerName`='Brak' \
	// WHERE `ID`='%d'", 0, businessID);
	// mysql_query(query); 
	// return 1;
}
Create_BusinessMySQL(bus_ID)
{
	new query[1024];

	format(query, sizeof(query), "INSERT INTO `mru_business` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`) VALUES\
	('%d', '%d', '%s', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%d', '%s', '%d')", 
	bus_ID, 
	Business[bus_ID][b_ownerUID],
	Business[bus_ID][b_Name_Owner],
	Business[bus_ID][b_Name],
	Business[bus_ID][b_enX], 
	Business[bus_ID][b_enY],
	Business[bus_ID][b_enZ],
	Business[bus_ID][b_exX],
	Business[bus_ID][b_exY],
	Business[bus_ID][b_exZ],
	Business[bus_ID][b_vw],
	Business[bus_ID][b_int],
	Business[bus_ID][b_pLocal],
	Business[bus_ID][b_maxMoney],
	Business[bus_ID][b_cost],
	Business[bus_ID][b_Location],
	Business[bus_ID][b_moneyPocket]);

	mysql_query(mruMySQL_Connection, query);
	return 1;
}
SaveBusiness(busID)//Zapis biznesów do bazy danych
{
	new query[1024];
	format(query, sizeof(query), "UPDATE `mru_business` SET \
	`ID`='%d', \
	`ownerUID`='%d', \
	`ownerName`='%s', \
	`Name`='%s', \
	`enX`='%f', \
	`enY`='%f', \
	`enZ`='%f', \
	`exX`='%f', \
	`exY`= '%f', \
	`exZ`= '%f', \
	`exVW`= '%d', \
	`exINT` = '%d', \
	`pLocal` = '%d', \
	`Money` = '%d', \
	`Cost` = '%d', \
	`Location` = '%s', \
	`MoneyPocket` = '%d' \
	WHERE `ID`='%d'", 
	Business[busID][b_ID], 
	Business[busID][b_ownerUID],
	Business[busID][b_Name_Owner],
	Business[busID][b_Name],
	Business[busID][b_enX], 
	Business[busID][b_enY],
	Business[busID][b_enZ],
	Business[busID][b_exX],
	Business[busID][b_exY],
	Business[busID][b_exZ],
	Business[busID][b_vw],
	Business[busID][b_int],
	Business[busID][b_pLocal],
	Business[busID][b_maxMoney],
	Business[busID][b_cost],
	Business[busID][b_Location],
	Business[busID][b_moneyPocket],
	busID); 
	mysql_query(mruMySQL_Connection,query);
	return 1;
}

//end