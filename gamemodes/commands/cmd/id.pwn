//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ id ]--------------------------------------------------//
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

YCMD:id(playerid, params[], help)
{
    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /id [playerid/czêœæ nicku]");
        return 1;
    }

    new string[333];
    if(IsNumeric(params))
    {
        new giveplayerid = strval(params);

        if(!IsPlayerConnected(giveplayerid))
        {
            sendTipMessage(playerid, "Obecnie na serwerze nie ma gracza o tym ID.");
            return 1;
        }

        SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");
        format(string, sizeof(string), "Gracz (ID: %d) %s.", giveplayerid, GetNick(giveplayerid));
        SendClientMessage(playerid, COLOR_GRAD1, string);

        return 1;
    } else
    {
        if(strlen(params) < 3)
        {
            sendErrorMessage(playerid, "Za krótka fraza.");
            return 1;
        }

        SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");

        new c = 0;
        new nick[MAX_PLAYER_NAME];
        foreach(new i : Player)
        {
            if(c >= 10) { break; }

            GetPlayerName(i, nick, sizeof(nick));
            if(strfind(nick, params, true) != -1)
            {
                format(string, sizeof(string), "ID: (%d) %s",i,nick);
                SendClientMessage(playerid, COLOR_GRAD1, string);
                c++;
            }
        }

        if(c >= 10)
        {
            sendErrorMessage(playerid, "Zbyt du¿o wyników, zmieñ kryteria.");
            return 1;
        }

        if(c == 0)
        {
            sendErrorMessage(playerid, "Nie znaleziono takiego nicku.");
            return 1;
        }
    }
    return 1;
}
