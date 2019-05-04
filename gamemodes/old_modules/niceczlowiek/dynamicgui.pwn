#define DYNAMIC_GUI_MAX_ROWS 60  // Max rows in gui

#define DG_NO_ACTION 0  // Value of no action row
#define INVALID_ROW_VALUE -198744124 // Do not touch

enum e_dynamic_gui_row
{
	value,
	additional_data_int,
}
new dynamic_gui[MAX_PLAYERS][DYNAMIC_GUI_MAX_ROWS][e_dynamic_gui_row];

new dynamic_gui_value[MAX_PLAYERS] = {-1, ...};

DynamicGui_Init(playerid)
{
	for(new i; i < DYNAMIC_GUI_MAX_ROWS; i++)
	{
		dynamic_gui[playerid][i][value] = INVALID_ROW_VALUE;
		dynamic_gui[playerid][i][additional_data_int] = 0;
	}
	
	dynamic_gui_value[playerid] = -1;
}

DynamicGui_SetDialogValue(playerid, d_value)
{
	dynamic_gui_value[playerid] = d_value;
}

DynamicGui_GetDialogValue(playerid)
{
	return dynamic_gui_value[playerid];
}

DynamicGui_FreeRow(playerid)
{
	for(new i; i < DYNAMIC_GUI_MAX_ROWS; i++)
	{
		if( dynamic_gui[playerid][i][value] == INVALID_ROW_VALUE )
		{
			return i;
		}
	}
	
	return -1;
}

DynamicGui_AddRow(playerid, dg_value, dg_additional_data_int = 0)
{
	new first_free_row = DynamicGui_FreeRow(playerid);
	if( first_free_row == -1 ) return;

	dynamic_gui[playerid][first_free_row][value] = dg_value;
	dynamic_gui[playerid][first_free_row][additional_data_int] = dg_additional_data_int;
}

DynamicGui_AddBlankRow(playerid)
{
	new first_free_row = DynamicGui_FreeRow(playerid);
	if( first_free_row == -1 ) return;

	dynamic_gui[playerid][first_free_row][value] = DG_NO_ACTION;
}

DynamicGui_GetValue(playerid, listitem)
{
	if( listitem > DYNAMIC_GUI_MAX_ROWS-1 ) return 0;
	
	return dynamic_gui[playerid][listitem][value];
}

DynamicGui_GetDataInt(playerid, listitem)
{
	if( listitem > DYNAMIC_GUI_MAX_ROWS-1 ) return 0;
	
	return dynamic_gui[playerid][listitem][additional_data_int];
}