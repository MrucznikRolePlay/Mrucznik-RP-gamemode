//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    opis                                                   //
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
// Autor: niceczlowiek | Creative
// Data utworzenia: 13.05.2019


//

//------------------<[ Implementacja: ]>-------------------
command_opis_Impl(playerid, params[])
{
	if(PlayerInfo[playerid][pBP] != 0)
	{
		return SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokadÍ pisania na czatach globalnych, nie moøesz utworzyÊ opisu.");
	}

	new opis[128];
	if(!sscanf(params, "s[128]", opis))
	{
		new givenString[128];
		format(givenString, sizeof(givenString), "%s", opis);
		if(strfind(givenString, "(FF0000)", true) != -1 || strfind(givenString, "(000000)", true) != -1)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Znaleziono niedozwolony kolor.");
			return 1;
		}
		//todo: kolorowe opisy tylko dla KP
		petla(i, strlen(givenString))
		{
			givenString[i] = tolower(givenString[i]);
			if(givenString[i] == '{' || givenString[i] == '}' || (givenString[i] != 'q' && givenString[i] != 'w' && givenString[i] != 'e' && givenString[i] != 'r' && givenString[i] != 't' && givenString[i] != 'y' && givenString[i] != 'u'
			&& givenString[i] != 'i' && givenString[i] != 'o' && givenString[i] != 'p' && givenString[i] != 'a' && givenString[i] != 's' && givenString[i] != 'd' && givenString[i] != 'f'
			&& givenString[i] != 'g' && givenString[i] != 'h' && givenString[i] != 'j' && givenString[i] != 'k' && givenString[i] != 'l' && givenString[i] != 'z' && givenString[i] != 'x'
			&& givenString[i] != 'c' && givenString[i] != 'v' && givenString[i] != 'b' && givenString[i] != 'n' && givenString[i] != 'm' && givenString[i] != ',' && givenString[i] != '.'
			&& givenString[i] != '!' && givenString[i] != '?' && givenString[i] != 'Í' && givenString[i] != 'Û' && givenString[i] != 'π' && givenString[i] != 'ú' && givenString[i] != '≥'
			&& givenString[i] != 'ø' && givenString[i] != 'ü' && givenString[i] != 'Ê' && givenString[i] != 'Ò' && givenString[i] != ' ' && givenString[i] != '”' && givenString[i] != '•'
			&& givenString[i] != 'å' && givenString[i] != '£' && givenString[i] != 'Ø' && givenString[i] != 'è' && givenString[i] != '∆' && givenString[i] != '—' && givenString[i] != ' '
			&& givenString[i] != '1' && givenString[i] != '2' && givenString[i] != '3' && givenString[i] != '4' && givenString[i] != '5' && givenString[i] != '6' && givenString[i] != '7'
			&& givenString[i] != '8' && givenString[i] != '9' && givenString[i] != '-' && givenString[i] != '0' && givenString[i] != '|' && givenString[i] != '/' && givenString[i] != '@' 
			&& givenString[i] != '(' && givenString[i] != ')' && givenString[i] != '[' && givenString[i] != ']' && givenString[i] != ':' && givenString[i] != ';'))
			{
				SendClientMessage(playerid, COLOR_GRAD1, sprintf("Znaleziono niedozwolony znak: %s", givenString[i]));
				return 1;
			}
		}

		if(!strcmp(opis, "usun", true) || !strcmp(opis, "usuÒ", true))
		{
			Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, "");
			PlayerInfo[playerid][pDesc][0] = EOS;
			sendTipMessage(playerid, "Opis zosta≥ usuniÍty.");
			return 1;
		}

		mysql_real_escape_string(opis, opis);
		new DBResult:db_result;
		db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`= '%d' AND `text` = '%s'", PlayerInfo[playerid][pUID], opis));
		new rows = db_num_rows(db_result);

		if(rows) //opis istnieje wiec update
		{
			new descUid = db_get_field_assoc_int(db_result, "uid");
			db_result = db_query(db_handle, sprintf("UPDATE `mru_opisy` SET `last_used`=%d WHERE `uid`=%d", gettime(), descUid));
		}
		else
		{
			db_free_result(db_query(db_handle, sprintf("INSERT INTO `mru_opisy` (`uid`,`text`, `owner`, `last_used`) VALUES (null, '%s', '%d', '%d')", opis, PlayerInfo[playerid][pUID], gettime())));
		}

		PlayerInfo[playerid][pDesc] = opis;
		ReColor(opis);
		Attach3DTextLabelToPlayer(PlayerInfo[playerid][pDescLabel], playerid, 0.0, 0.0, -0.7);
		Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, wordwrapEx(opis));
		sendTipMessage(playerid, "Ustawiono nowy opis:");
		new stropis[126];
		format(stropis, sizeof(stropis), "%s", opis);
		SendClientMessage(playerid, 0xBBACCFFF, stropis);
		return 1;
	}
		

	DynamicGui_Init(playerid);
	new string[1400];
	if(!isnull(PlayerInfo[playerid][pDesc]))
	{
		new str[256];
		strcopy(str, PlayerInfo[playerid][pDesc], sizeof str);
		strdel(str, 55, sizeof str);
		ReColor(str);
		format(string, sizeof(string), "{f4f5fa}%s...", str);
		DynamicGui_AddRow(playerid, DLG_NO_ACTION);
		format(string, sizeof(string), "%s\n{ff0000}UsuÒ (/opis usun)\n", string);
		DynamicGui_AddRow(playerid, DG_DESC_DELETE);
	}
	else
	{
		format(string, sizeof(string), "Nie masz ustawionego opisu...");
		DynamicGui_AddRow(playerid, DLG_NO_ACTION);
		format(string, sizeof(string), "%s{888888}\n{ff0000}Dodaj opis postaci (/opis [tekst])\n", string);
		DynamicGui_AddRow(playerid, DLG_NO_ACTION);
	}

	format(string, sizeof(string), "%s\t\t\n", string);
	DynamicGui_AddBlankRow(playerid);
	format(string, sizeof(string), "%s{00B33C}Ostatnie opisy\n", string);
	DynamicGui_AddBlankRow(playerid);

	new DBResult:db_result;
	db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`=%d ORDER BY `last_used` DESC LIMIT 5", PlayerInfo[playerid][pUID]));

	new rows = db_num_rows(db_result);
		
	if( rows )
	{
		for(new row; row < rows; row++,db_next_row(db_result))   
		{
			new tmpText[256];
			db_get_field(db_result, 1, tmpText, sizeof(tmpText));
			strdel(tmpText, 55, 256);
			ReColor(tmpText);
			format(string, sizeof(string), "%s(%d)\t{FFFFFF}%s...\n", string, row+1, tmpText);
			DynamicGui_AddRow(playerid, DG_DESC_USEOLD, db_get_field_assoc_int(db_result, "uid"));
		}
	}
	else 
	{
		format(string, sizeof(string), "%sBrak\n", string);
		DynamicGui_AddBlankRow(playerid);
	}

	ShowPlayerDialogEx(playerid, 4192, DIALOG_STYLE_LIST, "Opis", string, "Ok", "X");
	return 1;
}


//end