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
	new valueGraffiti;
	new loadedGraffiti;
	if(id == -1) //get all
	{
		new Cache:result = mysql_query(mruMySQL_Connection, "SELECT `ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy` FROM `mru_graffiti`", true);
		if(cache_is_valid(result))
		{
			for(new i; i < cache_num_rows(); i++)
			{
				LoadGraffitiRow(i);
				loadedGraffiti++;
			}
			printf("Zaladowano %d graffiti z %d w bazie", loadedGraffiti, valueGraffiti);
			cache_delete(result);
		}
	}
	else
	{
		new Cache:result = mysql_query(mruMySQL_Connection, 
			sprintf("SELECT `ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy` FROM `mru_graffiti` WHERE id='%d'", id),
			true);
		if(cache_is_valid(result))
		{
			if(cache_num_rows())
			{
				LoadGraffitiRow(id);
			}
			else
			{
				graffiti_Zeruj(id);
			}
			cache_delete(result);
		}
	}
	return 0;
}

LoadGraffitiRow(i)
{
	cache_get_value_index(i, 0, GraffitiInfo[i][pOwner]);
	cache_get_value_index(i, 1, GraffitiInfo[i][grafText]);
	cache_get_value_index_int(i, 2, GraffitiInfo[i][gColor]);
	cache_get_value_index_float(i, 3, GraffitiInfo[i][grafXpos]);
	cache_get_value_index_float(i, 4, GraffitiInfo[i][grafYpos]);
	cache_get_value_index_float(i, 5, GraffitiInfo[i][grafZpos]);
	cache_get_value_index_float(i, 6, GraffitiInfo[i][grafXYpos]);
	cache_get_value_index_float(i, 7, GraffitiInfo[i][grafYYpos]);
	cache_get_value_index_float(i, 8, GraffitiInfo[i][grafZYpos]);
	
	graffiti_DefineColor(i);
	strreplace(GraffitiInfo[i][grafText], "~n~", "\n", .ignorecase = true);
	strreplace(GraffitiInfo[i][grafText], "'", "\'", .ignorecase = true);
	GraffitiInfo[i][gID] = CreateDynamicObject(19482, GraffitiInfo[i][grafXpos], GraffitiInfo[i][grafYpos], GraffitiInfo[i][grafZpos], GraffitiInfo[i][grafXYpos], GraffitiInfo[i][grafYYpos], GraffitiInfo[i][grafZYpos], 0, 0, -1, 200);
	SetDynamicObjectMaterialText(GraffitiInfo[i][gID], 0, GraffitiInfo[i][grafText], OBJECT_MATERIAL_SIZE_512x128, "Arial", 24, 0, GraffitiInfo[i][gColor], 0, 1);
}

stock graffiti_SaveMySQL(id, playerid)
{
	new query[1024];
	mysql_format(mruMySQL_Connection, query, sizeof(query), 
		"INSERT INTO `mru_graffiti`(`id`, `ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy`) \
		VALUES ('%d', '%e', '%e', '%d', '%f', '%f', '%f', '%f', '%f', '%f')",
		id,
		GetNickEx(playerid),
		GraffitiInfo[id][grafText],
		GraffitiInfo[id][gColor],
		GraffitiInfo[id][grafXpos],
		GraffitiInfo[id][grafYpos],
		GraffitiInfo[id][grafZpos],
		GraffitiInfo[id][grafXYpos],
		GraffitiInfo[id][grafYYpos],
		GraffitiInfo[id][grafZYpos]);
	mysql_query(mruMySQL_Connection, query);
}

stock graffiti_UpdateMySQL(id, type = 1)
{
	new query[1024];
	if(type == 1)
	{
		format(query, sizeof(query), "UPDATE `mru_graffiti` SET `x`='%f',`y`='%f',`z`='%f',`xy`='%f',`yy`='%f',`zy`='%f' WHERE `id`='%d'",
			GraffitiInfo[id][grafXpos],
			GraffitiInfo[id][grafYpos],
			GraffitiInfo[id][grafZpos],
			GraffitiInfo[id][grafXYpos],
			GraffitiInfo[id][grafYYpos],
			GraffitiInfo[id][grafZYpos],
			id);
		mysql_query(mruMySQL_Connection, query);
	}
	else if(type == 2)
	{
		if(strlen(GraffitiInfo[id][grafText]) <= 1)
		{
			DestroyDynamicObject(GraffitiInfo[id][gID]);
			graffiti_DeleteMySQL(id);
			graffiti_Zeruj(id);
		}
		else
		{
			mysql_format(mruMySQL_Connection, query, sizeof(query), "UPDATE `mru_graffiti` SET `text`='%e',`kolor`='%d' WHERE `id`='%d'",
			GraffitiInfo[id][grafText],
			GraffitiInfo[id][gColor],
			id);
			mysql_query(mruMySQL_Connection, query);
		}
	}
}

stock graffiti_DeleteMySQL(id)
{
	DestroyDynamicObject(GraffitiInfo[id][gID]);
	new query[1024];
	format(query, sizeof(query), "DELETE FROM `mru_graffiti` WHERE `id`='%d'", id);
	mysql_query(mruMySQL_Connection, query);
	graffiti_Zeruj(id);
}

//stock graffiti_UpdateMySQL(id)
//end