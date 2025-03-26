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
	System biznesów.
*/

//

//------------------<[ MySQL: ]>--------------------
LoadBusiness()// Ladowanie biznesów z bazy danych
{
	//Tworzenie BIZ na ID 0
	mysql_real_escape_string("Testowy Biznes", Business[0][b_Name]); 
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
	mysql_real_escape_string("Szmulowice Dolne", Business[0][b_Location]); 
	mysql_real_escape_string("Brak - na sprzeda¿", Business[0][b_Name_Owner]);
	BusinessLoaded=1; 
	new query[1024];

	new CurrentBID = 1;
	while(CurrentBID < MAX_BIZNES)
	{
		new fields[256], result[1024];
		format(fields, sizeof(fields), "`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `enVw`, `enInt`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`, `Icon`");

		format(query, sizeof(query), "SELECT %s FROM `mru_business` WHERE `ID`='%d'", fields, CurrentBID);
		mysql_query(query);
		mysql_store_result();
		if (mysql_num_rows())
		{
			mysql_fetch_row_format(result, "|");
			sscanf(result, "p<|>dds[32]s[64]ffffffddddddds[64]dd",
			Business[CurrentBID][b_ID], 
			Business[CurrentBID][b_ownerUID],
			Business[CurrentBID][b_Name_Owner],
			Business[CurrentBID][b_Name],
			Business[CurrentBID][b_enX],
			Business[CurrentBID][b_enY],
			Business[CurrentBID][b_enZ],
			Business[CurrentBID][b_exX],
			Business[CurrentBID][b_exY],
			Business[CurrentBID][b_exZ],
			Business[CurrentBID][b_enVw],
			Business[CurrentBID][b_enInt],
			Business[CurrentBID][b_vw],
			Business[CurrentBID][b_int],
			Business[CurrentBID][b_pLocal],
			Business[CurrentBID][b_maxMoney],
			Business[CurrentBID][b_cost],
			Business[CurrentBID][b_Location],
			Business[CurrentBID][b_moneyPocket],
			Business[CurrentBID][b_icon]);

			if(strlen(Business[CurrentBID][b_Name]) >= 3)
			{
				BusinessLoaded++; 
			}
		}
		CurrentBID++;
		mysql_free_result();
	}
	return 1;
}
ClearBusinessOwner(businessID)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`bizz`='%d' \
	WHERE `bizz`='%d'", INVALID_BIZ_ID, businessID); 
	mysql_query(query); 
	format(query, sizeof(query), "UPDATE `mru_business` SET \
	`ownerUID`='%d', \
	`ownerName`='Brak' \
	WHERE `ID`='%d'", 0, businessID);
	mysql_query(query); 
	return 1;
}
Create_BusinessMySQL(bus_ID)
{
	new query[1024];

	format(query, sizeof(query), "INSERT INTO `mru_business` (`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`, `Icon`) VALUES\
	('%d', '%d', '%s', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d')", 
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
	Business[bus_ID][b_moneyPocket],
	Business[bus_ID][b_icon]);

	mysql_query(query);
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
	mysql_query(query);
	return 1;
}

//end