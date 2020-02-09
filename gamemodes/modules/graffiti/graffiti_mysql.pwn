//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  graffiti                                                 //
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
// Autor: Sanda³
// Data utworzenia: 01.02.2020
//Opis:
/*
	System graffiti
*/

//

//------------------<[ MySQL: ]>--------------------
stock graffiti_LoadMySQL(id = -1)
{
	new query[1024];
	new lStr[263]; 
	new lStr2[64];
	new string[128];
	new valueGraffiti;
	new loadedGraffiti;
	format(lStr, sizeof(lStr), "SELECT COUNT(*) FROM `mru_graffiti`");
	mysql_query(lStr);
	mysql_store_result();
	mysql_fetch_row_format(lStr2,"|");
	valueGraffiti = strval(lStr2);
	mysql_free_result();
	if(id == -1)
	{
		for(new i; i <= GRAFFITI_MAX; i++) 
		{
			lStr = "`ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy`";
			format(query, sizeof(query), "SELECT %s FROM `mru_graffiti` WHERE `id`='%d'", lStr, i);
			mysql_query(query); 
			mysql_store_result();
			if (mysql_num_rows())
			{
				mysql_fetch_row_format(query, "|");
				sscanf(query, "p<|>s[64]s[128]dffffff",
				GraffitiInfo[i][pOwner],
				GraffitiInfo[i][grafText],
				GraffitiInfo[i][gColor],
				GraffitiInfo[i][grafXpos],
				GraffitiInfo[i][grafYpos],
				GraffitiInfo[i][grafZpos],
				GraffitiInfo[i][grafXYpos],
				GraffitiInfo[i][grafYYpos],
				GraffitiInfo[i][grafZYpos]);
				loadedGraffiti++;
			}
			mysql_free_result();

			switch(GraffitiInfo[i][gColor])
			{
				case 0: GraffitiInfo[i][gColor] = GRAFFITI_CZARNY;// CZARNY
 
                case 1: GraffitiInfo[i][gColor] = GRAFFITI_BIALY; // BIALY
 
                case 2: GraffitiInfo[i][gColor] = GRAFFITI_CZERWONY; // CZERWONY
 
                case 3: GraffitiInfo[i][gColor] = GRAFFITI_ZIELONY; // ZIELONY
 
                case 4: GraffitiInfo[i][gColor] = GRAFFITI_NIEBIESKI; // NIEBIESKI
 
                case 5: GraffitiInfo[i][gColor] = GRAFFITI_SZARY;  // SZARY
			}
			GraffitiInfo[i][gID] = CreateDynamicObject(19482, GraffitiInfo[i][grafXpos], GraffitiInfo[i][grafYpos], GraffitiInfo[i][grafZpos], GraffitiInfo[i][grafXYpos], GraffitiInfo[i][grafYYpos], GraffitiInfo[i][grafZYpos], 0, 0, -1, 200);
    		SetDynamicObjectMaterialText(GraffitiInfo[i][gID], 0, GraffitiInfo[i][grafText], OBJECT_MATERIAL_SIZE_256x256, "Arial", 24, 0, GraffitiInfo[i][gColor], 0, 1);
		}
		format(string, sizeof(string), "Zaladowano %d graffiti z %d w bazie", loadedGraffiti, valueGraffiti);
		print(string);
		return 0;
	}
	else
	{
		//wczytanie tego jednego id
		return 1;
	}
}
//end