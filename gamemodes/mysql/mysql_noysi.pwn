GetWorkers(id)
{
	new workers;
	new query[128];
	mysql_format(mruMySQL_Connection, query, sizeof(query), "SELECT COUNT(*) FROM `mru_konta` WHERE `Member`='%d' AND Rank < 90", id);
	new Cache:result = mysql_query(mruMySQL_Connection, query);
	cache_get_value_int(0, 0, workers);
	cache_delete(result);
	return workers;
}

showFactionWorkers(playerid, page=1)
{
	new query[128];
	new id = PlayerInfo[playerid][pLider];
	new ilosc = GetWorkers(id);
	if(ilosc == 0) return sendErrorMessage(playerid, "Ta frakcja nie ma pracowników");

	new header[128], Float:pp = ilosc / FPANEL_PER_PAGE;
	format(header, sizeof(header), "Panel Lidera » Pracownicy [%d/%d]", page, floatround(pp, floatround_ceil)+1);

	DynamicGui_Init(playerid);

	new str[1400];

	format(str, sizeof(str), "Imie i Nazwisko\tRanga");

	new offset = (page - 1) * FPANEL_PER_PAGE;

	mysql_format(mruMySQL_Connection, query, sizeof(query), "SELECT UID,Nick,Rank,Lider FROM `mru_konta` WHERE `Member`='%d' AND Rank < 90 ORDER BY Rank Desc LIMIT %d,%d;", id, offset, FPANEL_PER_PAGE);
	new Cache:result = mysql_query(mruMySQL_Connection, query);
	
	new nick[MAX_PLAYER_NAME], uid, rank, lider = 0, rankname[36];
	for(new i; i < cache_num_rows(); i++)
	{
		cache_get_value_index_int(i, 0, uid);
		cache_get_value_index(i, 1, nick);
		cache_get_value_index_int(i, 2, rank);
		cache_get_value_index_int(i, 3, lider);

		if(rank != 99 && lider == 0)
        {
	        strmid(rankname, FracRang[id][rank], 0, 35, 36);
	        format(str, sizeof(str), "%s\n%s\t[%d] %s", str, nick, rank, rankname);
	        DynamicGui_AddRow(playerid, FPANEL_DG_OSOBA, uid);
	    }
	}
	cache_delete(result);

    if( page > 1 )
	{
		format(str, sizeof(str), "%s\n\n{888888}<<< Poprzednia strona\n  \n", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_PREV);

		DynamicGui_AddBlankRow(playerid);
	}

	if( ilosc > (page*FPANEL_PER_PAGE) )
	{
		format(str, sizeof(str), "%s\n\n{888888}Nast?pna strona >>>", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_NEXT);
	}

	SetPVarInt(playerid, "fpanel_Page", page);


	ShowPlayerDialogEx(playerid, 1959, DIALOG_STYLE_TABLIST_HEADERS, header, str, "Wybierz", "Cofnij");

	return 1;
}