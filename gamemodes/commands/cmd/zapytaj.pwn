//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zapytaj ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:zapytaj(playerid, params[], help)
{
    if(GetPVarInt(playerid, "active_ticket") != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Twoje wczesniejsze zg³oszenie nadal jest aktywne. Poczekaj na odpowiedŸ!");
    new desc[64];
    if(sscanf(params, "s[64]", desc))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Potrzebujesz pomocy na temat gry IC? U¿yj zapytania do supportu!");
        SendClientMessage(playerid, COLOR_GRAD2, "Wpisz ogólny temat w nawiasach kwadratowych [TEMAT] oraz dalsz¹ tresc.");
        SendClientMessage(playerid, COLOR_GRAD2, "Przyk³ad u¿ycia: {FFFFFF}/zapytaj [Pojazd] Gdzie kupiê swój pierwszy pojazd?");
        return 1;
    }
    new pos = strfind(desc, "["), pos2 = strfind(desc, "]");
    if(pos == -1 || pos2 == -1 || pos2 < pos)
    {
        SendClientMessage(playerid, COLOR_GRAD2, "Wpisz ogólny temat w nawiasach kwadratowych [TEMAT] oraz dalsz¹ tresc.");
        SendClientMessage(playerid, COLOR_GRAD2, "Przyk³ad u¿ycia: {FFFFFF}/zapytaj [Pojazd] Gdzie kupiê swój pierwszy pojazd?");
        return 1;
    }
    new sub[16], str[32];
    strmid(sub, desc, pos+1, pos2);
    while(desc[pos2+1] == ' ')
    {
        strdel(desc, pos2, pos2+1);
    }
    strmid(str, desc, pos2+1, strlen(desc), 32);
    if(strlen(sub) < 2 || strlen(desc) < 10)
    {
        sendTipMessageEx(playerid, COLOR_GRAD2, "Poda³es za krótki opis lub temat.");
        return 1;
    }
    new id;
    if((id = Support_Add(playerid, sub, str)) != -1)
    {
        sendTipMessageEx(playerid, COLOR_YELLOW, "Wys³ano zapytanie do pomocy. Proszê czekaæ cierpliwie na odpowiedŸ :)");
        SetPVarInt(playerid, "active_ticket", id+1);

        foreach(new i : Player)
            if(GetPVarInt(i, "support_duty") == 1)
                SendClientMessage(i, COLOR_GREEN, "SUPPORT: {FFFFFF}Nowe zg³oszenie o pomoc (/tickets).");
    }
    else
        sendTipMessageEx(playerid, COLOR_RED, "Nie mo¿na dodaæ zapytania, lista jest pe³na.");
    return 1;
}
