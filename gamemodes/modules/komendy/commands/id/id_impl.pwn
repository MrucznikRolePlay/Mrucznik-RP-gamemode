//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_id_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        new giveplayerid; 
        if(sscanf(params, "k<fix>", giveplayerid))
        {
            sendTipMessage(playerid, "U¿yj /id [ID/czêœæ nicku]"); 
            return 1;
        }

        new string[333];
        if(IsNumeric(params))
        {
            if(!IsPlayerConnected(giveplayerid))
            {
                sendTipMessage(playerid, "Obecnie na serwerze nie ma gracza o tym ID.");
                return 1;
            }

            SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");
            format(string, sizeof(string), "Gracz (ID: %d) %s", giveplayerid, GetNick(giveplayerid));
            SendClientMessage(playerid, COLOR_GRAD1, string);

            return 1;
        } 
        else
        {
            if(strlen(params) < 3)
            {
                sendErrorMessage(playerid, "Za krótka fraza.");
                return 1;
            }

            SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");

            new c = 0;
            foreach(new i : Player)
            {
                if(c >= 10) { break; }

                if(strfind(GetNick(i), params, true) != -1)
                {
                    format(string, sizeof(string), "Gracz (ID: %d) %s", i, GetNick(i));
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
    }
    return 1;
}

//end
