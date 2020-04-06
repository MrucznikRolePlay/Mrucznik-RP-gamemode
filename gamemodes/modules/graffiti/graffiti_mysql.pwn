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
		for(new i; i < GRAFFITI_MAX; i++) 
		{
			lStr = "`ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy`";
			format(query, sizeof(query), "SELECT %s FROM `mru_graffiti` WHERE `id`='%d'", lStr, i);
			mysql_query(query); 
			mysql_store_result();
			if (mysql_num_rows())
			{
				mysql_fetch_row_format(query, "|");
				sscanf(query, "p<|>s[32]s[128]dffffff",
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
			graffiti_DefineColor(i);
			strreplace(GraffitiInfo[i][grafText], "~n~", "\n", .ignorecase = true);
			strreplace(GraffitiInfo[i][grafText], "'", "\'", .ignorecase = true);
			GraffitiInfo[i][gID] = CreateDynamicObject(19482, GraffitiInfo[i][grafXpos], GraffitiInfo[i][grafYpos], GraffitiInfo[i][grafZpos], GraffitiInfo[i][grafXYpos], GraffitiInfo[i][grafYYpos], GraffitiInfo[i][grafZYpos], 0, 0, -1, 200);
			SetDynamicObjectMaterialText(GraffitiInfo[i][gID], 0, GraffitiInfo[i][grafText], OBJECT_MATERIAL_SIZE_512x128, "Arial", 24, 0, GraffitiInfo[i][gColor], 0, 1);
		}
		format(string, sizeof(string), "Zaladowano %d graffiti z %d w bazie", loadedGraffiti, valueGraffiti);
		print(string);
	}
	else
	{
		lStr = "`ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy`";
		format(query, sizeof(query), "SELECT %s FROM `mru_graffiti` WHERE `id`='%d'", lStr, id);
		mysql_query(query); 
		mysql_store_result();
		if (mysql_num_rows())
		{
			mysql_fetch_row_format(query, "|");
			sscanf(query, "p<|>s[32]s[128]dffffff",
			GraffitiInfo[id][pOwner],
			GraffitiInfo[id][grafText],
			GraffitiInfo[id][gColor],
			GraffitiInfo[id][grafXpos],
			GraffitiInfo[id][grafYpos],
			GraffitiInfo[id][grafZpos],
			GraffitiInfo[id][grafXYpos],
			GraffitiInfo[id][grafYYpos],
			GraffitiInfo[id][grafZYpos]);
			mysql_free_result();
			graffiti_DefineColor(id);
			strreplace(GraffitiInfo[id][grafText], "~n~", "\n", .ignorecase = true);
			GraffitiInfo[id][gID] = CreateDynamicObject(19482, GraffitiInfo[id][grafXpos], GraffitiInfo[id][grafYpos], GraffitiInfo[id][grafZpos], GraffitiInfo[id][grafXYpos], GraffitiInfo[id][grafYYpos], GraffitiInfo[id][grafZYpos], 0, 0, -1, 200);
			SetDynamicObjectMaterialText(GraffitiInfo[id][gID], 0, GraffitiInfo[id][grafText], OBJECT_MATERIAL_SIZE_256x256, "Arial", 24, 0, GraffitiInfo[id][gColor], 0, 1);
		}
		else
		{
			graffiti_Zeruj(id);
		}
	}
	return 0;
}
stock graffiti_SaveMySQL(id, playerid)
{
	new query[1024], escaped_text[128];
	mysql_real_escape_string(GraffitiInfo[id][grafText], escaped_text);
	format(query, sizeof(query), "INSERT INTO `mru_graffiti`(`id`, `ownerName`, `text`, `kolor`, `x`, `y`, `z`, `xy`, `yy`, `zy`) VALUES ('%d', '%s', '%s', '%d', '%f', '%f', '%f', '%f', '%f', '%f')",
	id,
	GetNickEx(playerid),
	escaped_text,
	GraffitiInfo[id][gColor],
	GraffitiInfo[id][grafXpos],
	GraffitiInfo[id][grafYpos],
	GraffitiInfo[id][grafZpos],
	GraffitiInfo[id][grafXYpos],
	GraffitiInfo[id][grafYYpos],
	GraffitiInfo[id][grafZYpos]);
	mysql_query(query);
}

stock graffiti_UpdateMySQL(id, type = 1)
{
	new query[1024], escaped_text[128];
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
		mysql_query(query);
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
			mysql_real_escape_string(GraffitiInfo[id][grafText], escaped_text);
			format(query, sizeof(query), "UPDATE `mru_graffiti` SET `text`='%s',`kolor`='%d' WHERE `id`='%d'",
			escaped_text,
			GraffitiInfo[id][gColor],
			id);
			mysql_query(query);
		}
	}
}

stock graffiti_DeleteMySQL(id)
{
	DestroyDynamicObject(GraffitiInfo[id][gID]);
	new query[1024];
	format(query, sizeof(query), "DELETE FROM `mru_graffiti` WHERE `id`='%d'", id);
	mysql_query(query);
	graffiti_Zeruj(id);
}

//stock graffiti_UpdateMySQL(id)
//end