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
		new gsid = orgid-21;
		if(gsid >= 3)
		{
			continue;
		}
		if (gunid == 0) // mats
		{
			GS_MatsCena[gsid] = cena;
		}
		else 
		{
			if(gunid >= 47) continue;
			GS_BronCena[gsid][gunid] = cena;
		}
	}
	mysql_free_result();
	LoadMats3DText();
}

SaveGsPanelPrice(gsid, gunid) 
{
	new str[256];
	new cena;
	if(gunid == 0) cena = GS_MatsCena[gsid];
	else cena = GS_BronCena[gsid][gunid];
	format(str, sizeof(str), "INSERT INTO `mru_gspanel` VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE `cena`=%d", gsid+21, gunid, cena, cena);
	mysql_query(str);
}

//end