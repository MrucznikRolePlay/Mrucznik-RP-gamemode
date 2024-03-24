
showFactionWorkers(playerid, page=1)
{
	new query[128];

	new id = PlayerInfo[playerid][pLider];

	format(query, sizeof(query), "SELECT COUNT(*) FROM `mru_konta` WHERE `Member`='%d' AND `Rank` < 90", id);

	mysql_query(query);
	mysql_store_result();
	new row[24];
	mysql_fetch_row_format(row,"|");
	new ilosc = strval(row);

	mysql_free_result();

	if(ilosc == 0) return sendErrorMessage(playerid, "Ta frakcja nie ma pracowników");

	new header[128], Float:pp = ilosc / FPANEL_PER_PAGE;
	format(header, sizeof(header), "Panel Lidera » Pracownicy [%d/%d]", page, floatround(pp, floatround_ceil)+1);

	DynamicGui_Init(playerid);

	new str[1400];

	format(str, sizeof(str), "Imie i Nazwisko\tRanga");

	new offset = (page - 1) * FPANEL_PER_PAGE;

	format(query, sizeof(query), "SELECT `UID`, `Nick`, `Rank`, `Lider` FROM `mru_konta` WHERE `Member`='%d' AND `Rank` < 90 ORDER BY `Rank` Desc LIMIT %d,%d;", id, offset, FPANEL_PER_PAGE);
	mysql_query(query);
	mysql_store_result();

	new nick[24], uid, rank, lider = 0, rankname[36];
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ds[24]dd", uid, nick, rank, lider);
        if(rank != 99 && lider == 0)
        {
	        strmid(rankname, FracRang[id][rank], 0, 35, 36);
	        format(str, sizeof(str), "%s\n%s\t[%d] %s", str, nick, rank, rankname);
	        DynamicGui_AddRow(playerid, FPANEL_DG_OSOBA, uid);
	    }
    }

    if( page > 1 )
	{
		format(str, sizeof(str), "%s\n\n{888888}<<< Poprzednia strona\n  \n", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_PREV);

		DynamicGui_AddBlankRow(playerid);
	}

	if( ilosc > (page*FPANEL_PER_PAGE) )
	{
		format(str, sizeof(str), "%s\n\n{888888}Nastêpna strona >>>", str);
		DynamicGui_AddRow(playerid, FPANEL_DG_NEXT);
	}

	SetPVarInt(playerid, "fpanel_Page", page);

	mysql_free_result();

	ShowPlayerDialogEx(playerid, 1959, DIALOG_STYLE_TABLIST_HEADERS, header, str, "Wybierz", "Cofnij");

	return 1;
}
