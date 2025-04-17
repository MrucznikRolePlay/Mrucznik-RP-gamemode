//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                gunshoppanel                                               //
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
// Autor: wiger
// Data utworzenia: 18.02.2024
//Opis:
/*
	Panel zarzadzania sklepem z bronia
*/

//

//------------------<[ MySQL: ]>--------------------
LoadGsPanelPrices() 
{
	new str[1024];
	mysql_query("SELECT * FROM `mru_gspanel`");
	mysql_store_result();
	while(mysql_fetch_row_format(str, "|")) {
		new orgid, gunid, cena;
		sscanf(str, "p<|>ddd", orgid, gunid, cena);
		if(orgid >= MAX_ORG)
		{
			continue;
		}
		if (gunid == GUNID_MATS)
		{
			GS_MatsCena[orgid] = cena;
		}
		else if (gunid == GUNID_CONTRABAND)
		{
			GS_KontraCena[orgid] = cena;
		}
		else 
		{
			if(gunid >= 47) continue;
			GS_BronCena[orgid][gunid] = cena;
		}
	}
	mysql_free_result();
	LoadMats3DText();
}

SaveGsPanelPrice(org, gunid) 
{
	new str[256];
	new cena;
	switch (gunid) {
		case GUNID_MATS:
			cena = GS_MatsCena[org];
		case GUNID_CONTRABAND:
			cena = GS_KontraCena[org];
		default:
			cena = GS_BronCena[org][gunid];
	}
	format(str, sizeof(str), "INSERT INTO `mru_gspanel` VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE `cena`=%d", org, gunid, cena, cena);
	mysql_query(str);
}

//end