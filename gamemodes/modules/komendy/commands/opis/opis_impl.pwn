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
// Autor: niceczlowiek
// Data utworzenia: 13.05.2019


//

//------------------<[ Implementacja: ]>-------------------
command_opis_Impl(playerid)
{
	if(PlayerInfo[playerid][pBP] != 0)
	{
		return SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokadê pisania na czatach globalnych, nie mo¿esz utworzyæ opisu.");
	}
	DynamicGui_Init(playerid);
	new string[1400];
		
	if(!isnull(PlayerInfo[playerid][pDesc]))
	{
		new str[256];
		strcopy(str, PlayerInfo[playerid][pDesc], 256);
		strdel(str, 55, 256); // jednak pokazujemy ca³y opis :D
		format(string, sizeof(string), "%s{f4f5fa}%s...\n", string, str);
		DynamicGui_AddRow(playerid, DLG_NO_ACTION);
	
		format(string, sizeof(string), "%s{888888}##\t{ff0000}Usuñ opis\n", string);
		DynamicGui_AddRow(playerid, DG_DESC_DELETE);
	}
	else
	{
		format(string, sizeof(string), "%s{888888}##\t{00B33C}Ustaw opis\n", string);
		DynamicGui_AddRow(playerid, DG_DESC_ADD);
	}

	format(string, sizeof(string), "%s\t\t\n", string);
	DynamicGui_AddBlankRow(playerid);
	format(string, sizeof(string), "%s{00B33C}Ostatnie opisy\n", string);
	DynamicGui_AddBlankRow(playerid);

	new DBResult:db_result;
	db_result = db_query(db_handle, sprintf("SELECT * FROM `mru_opisy` WHERE `owner`=%d ORDER BY `last_used` DESC LIMIT 5", PlayerInfo[playerid][UID]));

	new rows = db_num_rows(db_result);
		
	if( rows )
	{
		for(new row; row < rows; row++,db_next_row(db_result))   
		{
			new tmpText[256];
			db_get_field(db_result, 1, tmpText, sizeof(tmpText));
			strdel(tmpText, 55, 256);
			format(string, sizeof(string), "%s(%d)\t%s...\n", string, row+1, tmpText);
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