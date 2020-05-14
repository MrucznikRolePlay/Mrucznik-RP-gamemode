//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  cooking                                                  //
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
// Autor: mrucznik
// Data utworzenia: 03.03.2020
//Opis:
/*
	System gotowania potraw
*/

//

// DB structure:
// CREATE TABLE IF NOT EXISTS `mru_player_cooking` (
// `id` int(11) NOT NULL,
//   `owner` int(11) NOT NULL,
//   `model` int(11) NOT NULL,
//   `name` varchar(20) COLLATE latin1_general_ci NOT NULL,
//   `weight` int(11) NOT NULL,
//   `type` int(11) NOT NULL
// ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
//
// ALTER TABLE `mru_player_cooking` ADD PRIMARY KEY (`id`), ADD KEY `owner` (`owner`);
// ALTER TABLE `mru_player_cooking` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;


//------------------<[ MySQL: ]>--------------------
MruMySQL_CookedMealsDialog(playerid)
{
	new string[(44+MAX_COOKED_NAME)*50]; //message length: 12+1+MAX_COOKED_NAME+9+12+2=56, 64 for safety

	new Cache:result = mysql_query(mruMySQL_Connection, 
		sprintf("SELECT id, model, name, weight, type FROM mru_player_cooking WHERE owner='%d' ORDER BY id DESC LIMIT 50", 
		PlayerInfo[playerid][pUID]
	), true);

	if(cache_is_valid(result))
	{
		new rows = cache_num_rows();
		new id, model, name[MAX_COOKED_NAME], weight, type;
		DynamicGui_Init(playerid);
		for(new i; i < rows; i++)
		{
			cache_get_value_index_int(i, 0, id);
			cache_get_value_index_int(i, 1, model);
			cache_get_value_index(i, 2, name);
			cache_get_value_index_int(i, 3, weight);
			cache_get_value_index_int(i, 4, type);

			strcat(string, sprintf("%i\t%s~n~~g~~h~%dg\n", model, Odpolszcz(name), weight));
			DynamicGui_AddRow(playerid, id);
		}
		cache_delete(result);
		if(rows == 0)
		{
			sendErrorMessage(playerid, "Nie masz nic do zjedzenia.");
			return 1;
		}
		string[strlen(string)-1] = '\0';
	}

    ShowPlayerDialogEx(playerid, DIALOG_EATING, DIALOG_STYLE_PREVIEW_MODEL, "Twoje potrawy", string, "Jedz", "Anuluj");
	return 1;
}

MruMySQL_AddCookedMeal(playerid, model, name[], weight, type)
{
	mysql_query(mruMySQL_Connection, 
		sprintf("INSERT INTO mru_player_cooking (owner, model, name, weight, type) VALUES ('%d', '%d', '%s', '%d', '%d')",
		PlayerInfo[playerid][pUID], model, name, weight, type
	));
	return cache_insert_id();
}

MruMySQL_EatCookedMeal(playerid, id)
{
	new Cache:result = mysql_query(mruMySQL_Connection, sprintf("SELECT name, weight, type FROM mru_player_cooking WHERE id='%d'", id), true);
	if(cache_is_valid(result))
	{
		if(cache_num_rows())
		{
			new name[MAX_COOKED_NAME], weight, type;
			cache_get_value_index(0, 0, name);
			cache_get_value_index_int(0, 1, weight);
			cache_get_value_index_int(0, 2, type);

			EatCookedMeal(playerid, name, weight, type);
		}
		cache_delete(result);

		mysql_query(mruMySQL_Connection, sprintf("DELETE FROM mru_player_cooking WHERE id='%d'", id));
	}

	return;
}

//end