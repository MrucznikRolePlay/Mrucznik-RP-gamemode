//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizinfo                                                 //
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
// Autor: Simeone
// Data utworzenia: 05.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbizinfo_Impl(playerid)
{
    if(GetPVarInt(playerid, "MozeUzycKomendyBiz") == 1)
    {
        sendErrorMessage(playerid, "Odczekaj 5 sekund!"); 
        return 1;
    }
    new string[426];
    new value; 
    for(new i; i <= MAX_BIZ; i++)
    {
        if(value == loadedBiz)
        {
            sendErrorMessage(playerid, "Nie znajdujesz siê obok ¿adnego biznesu!"); 
            break;
        }
        if(BizExist(i))
        {
            if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]))
            {
                if(mBiz[i][b_auction] == 2)
                {
                    format(string, sizeof(string), " \t{FF1493}%s\n{FFFFFF}W³aœciciel: {747b41}%s\n{FFFFFF}Typ: {747b41}%s\n{FFFFFF}Lokalizacja: {747b41}%s\n{FFFFFF}Cena: {747b41}$%d\n{FFFFFF}Identyfikator: {747b41}%d",
                    GetBusinessName(i),
                    GetBusinessOwnerName(i),
                    GetBusinessTypeName(i),
                    mBiz[i][b_Location],
                    mBiz[i][b_cost],
                    i);
                }
                else if(mBiz[i][b_auction] == 1)//Trwa licytacja
                {
                    format(string, sizeof(string), " \t{FF1493}%s\n{FFFFFF}W³aœciciel: {747b41}San Andreas Property Department\n{FFFFFF}Typ: {747b41}%s\n{FFFFFF}Lokalizacja: {747b41}%s\n{FFFFFF}Aktualny stan licytacji: {747b41}$%d\n{FFFFFF}Identyfikator: {747b41}%d\n{FFFFFF}Je¿eli chcesz wzi¹æ udzia³ w licytacji tego biznesu\nwpisz /licytuj stoj¹c w tym miejscu.",
                    GetBusinessName(i),
                    GetBusinessTypeName(i),
                    mBiz[i][b_Location],
                    mBiz[i][b_cost],
                    i);
                }
                else 
                {
                    format(string, sizeof(string), " \t{FF1493}%s\n{FFFFFF}W³aœciciel: {747b41}San Andreas Property Department\n{FFFFFF}Typ: {747b41}%s\n{FFFFFF}Lokalizacja: {747b41}%s\n{FFFFFF}Cena wyjœciowa: {747b41}$%d\n{FFFFFF}Identyfikator: {747b41}%d\n{FFFFFF}Biznes nie posiada ceny sprzeda¿y. Mo¿esz rozpoczaæ na niego licytacjê wpisuj¹c /mbizbuy [.]\nw urzêdzie miasta Los Santos.",
                    GetBusinessName(i),
                    GetBusinessTypeName(i),
                    mBiz[i][b_Location],
                    mBiz[i][b_cost],
                    i);
                }
                ShowPlayerDialogEx(playerid, BIZ_DIALOG_INFO, DIALOG_STYLE_MSGBOX, SetDefaultCaption(), string, "Okej", "");
                return 1; 
            }
            value++; 
        } 
    }
    return 1;
}

//end