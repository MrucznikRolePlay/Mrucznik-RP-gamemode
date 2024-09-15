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
command_kostka_Impl(playerid, params[256])
{
    if(!IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Tylko w kasynie!");
    if(strcmp(params, "akceptuj", true) == 0 || strcmp(params, "a", true) == 0)
    {
        if(GetPVarInt(playerid, "kostka-wait") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nikt nie oferowa³ Ci gry!");
        if(GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Obecnie rozgrywasz ju¿ grê!");
        new id = GetPVarInt(playerid, "kostka-wait")-1;
        if(GetPVarInt(id, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz obecnie rozgrywa grê.");
        if(GetPVarInt(id, "kostka-last") != playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Rozgrywka nieaktualna.");
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        if(!IsPlayerInRangeOfPoint(id, 10.0, x, y, z))  return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz nie stoi obok Ciebie.");
        new czas = GetPVarInt(id, "kostka-czas");
        if(czas != GetPVarInt(playerid, "kostka-czas")) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Rozgrywka nieaktualna.");
        if(kaska[id] < GetPVarInt(id, "kostka-cash") || kaska[playerid] < GetPVarInt(id, "kostka-cash")) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Jednego z graczy nie staæ na tê grê.");

        SetPVarInt(playerid, "kostka-cash", GetPVarInt(id, "kostka-cash"));
        SetPVarInt(playerid, "kostka-throw", GetPVarInt(id, "kostka-throw"));

        SetPVarInt(playerid, "kostka", 1);
        SetPVarInt(id, "kostka", 1);
        new str[128], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "%s zaakceptowa³ grê, rzuca on pierwszy.", nick);
        sendTipMessageEx(id, COLOR_GREEN, str);
        sendTipMessageEx(playerid, COLOR_GREEN, "Zaakceptowa³eœ grê, rzucasz pierwszy.");

        SetPVarInt(playerid, "kostka-player", id);
        SetPVarInt(id, "kostka-player", playerid);

        SetPVarInt(playerid, "kostka-rzut", 1);
        SetPVarInt(id, "kostka-rzut", 0);

        ZabierzKase(playerid, GetPVarInt(id, "kostka-cash"));
        ZabierzKase(id, GetPVarInt(id, "kostka-cash"));
    }
    else if(strcmp(params, "odrzuæ", true) == 0 || strcmp(params, "odrzuc", true) == 0 || strcmp(params, "o", true) == 0)
    {
        if(GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Obecnie rozgrywasz ju¿ grê!");
        if(GetPVarInt(playerid, "kostka-wait") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nikt nie oferowa³ Ci gry!");
        new id = GetPVarInt(playerid, "kostka-wait")-1;

        SetPVarInt(playerid, "kostka-wait", 0);

        new str[64], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 64, "%s odrzuci³ Twoje zaproszenie.", nick);
        sendTipMessageEx(id, COLOR_RED, str);
        sendTipMessageEx(playerid, COLOR_RED, "Odrzuci³eœ zaproszenie do gry.");
    }
    else if(GetPVarInt(playerid, "kostka") == 1)
    {
        if(GetPVarInt(playerid, "kostka-rzut") == 1)
        {
            if(GetPVarInt(playerid, "kostka-throw") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Brak rzutów.");
            new rzuty = GetPVarInt(playerid, "kostka-throw"), str[64], nick[MAX_PLAYER_NAME +1];
            GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
            rzuty--;

            new ile;
            ile = 1+true_random(6);

            format(str, 64, "* %s wyrzuca %d oczek.", nick, ile);
            ProxDetector(12.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

            SetPVarInt(playerid, "kostka-throw", rzuty);
            SetPVarInt(playerid, "kostka-suma", ile + GetPVarInt(playerid, "kostka-suma"));
            new id = GetPVarInt(playerid, "kostka-player");

            if(rzuty == 0)
            {
                if(GetPVarInt(playerid, "kostka-suma") > GetPVarInt(id, "kostka-suma"))
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        new kasa = GetPVarInt(playerid, "kostka-cash");

                        format(str, 64, "Gratulacje! Wygra³eœ %d$!", 2*kasa);
                        sendTipMessageEx(playerid, COLOR_GREEN, str);
                        format(str, 64, "Pora¿ka! Przegra³eœ %d$!", kasa);
                        sendTipMessageEx(id, COLOR_RED, str);
                        format(str, 64, "* %s wygrywa!", nick);
                        ProxDetector(12.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                        Kostka_Wygrana(playerid, id, (2*kasa));

                        SetPVarInt(playerid, "kostka",0);
                        SetPVarInt(playerid, "kostka-throw", 0);
                        SetPVarInt(playerid, "kostka-suma", 0);
                        SetPVarInt(playerid, "kostka-cash", 0);
                        SetPVarInt(playerid, "kostka-first", 0);
                        SetPVarInt(playerid, "kostka-rzut", 0);
                        SetPVarInt(playerid, "kostka-wait", 0);
                        SetPVarInt(playerid, "kostka-player", 0);

                        SetPVarInt(id, "kostka",0);
                        SetPVarInt(id, "kostka-throw", 0);
                        SetPVarInt(id, "kostka-suma", 0);
                        SetPVarInt(id, "kostka-cash", 0);
                        SetPVarInt(id, "kostka-first", 0);
                        SetPVarInt(id, "kostka-rzut", 0);
                        SetPVarInt(id, "kostka-wait", 0);
                        SetPVarInt(id, "kostka-player", 0);
                    }

                }
                else if(GetPVarInt(playerid, "kostka-suma") == GetPVarInt(id, "kostka-suma"))
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        SetPVarInt(playerid, "kostka-throw", 1);
                        SetPVarInt(id, "kostka-throw", 1);

                        sendTipMessageEx(playerid, COLOR_RED, "REMIS! Masz dodatkowy rzut.");
                        sendTipMessageEx(id, COLOR_RED, "REMIS! Masz dodatkowy rzut.");
                    }
                }
                else
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        new kasa = GetPVarInt(id, "kostka-cash");

                        GetPlayerName(id, nick, MAX_PLAYER_NAME);
                        format(str, 64, "Gratulacje! Wygra³eœ %d$!", 2*kasa);
                        sendTipMessageEx(id, COLOR_GREEN, str);
                        format(str, 64, "Pora¿ka! Przegra³eœ %d$!", kasa);
                        sendTipMessageEx(playerid, COLOR_RED, str);
                        format(str, 64, "* %s wygrywa!", nick);
                        ProxDetector(12.0, id, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                        Kostka_Wygrana(id, playerid, (2*kasa));

                        SetPVarInt(playerid, "kostka",0);
                        SetPVarInt(playerid, "kostka-throw", 0);
                        SetPVarInt(playerid, "kostka-suma", 0);
                        SetPVarInt(playerid, "kostka-cash", 0);
                        SetPVarInt(playerid, "kostka-first", 0);
                        SetPVarInt(playerid, "kostka-rzut", 0);
                        SetPVarInt(playerid, "kostka-wait", 0);
                        SetPVarInt(playerid, "kostka-player", 0);

                        SetPVarInt(id, "kostka",0);
                        SetPVarInt(id, "kostka-throw", 0);
                        SetPVarInt(id, "kostka-suma", 0);
                        SetPVarInt(id, "kostka-cash", 0);
                        SetPVarInt(id, "kostka-first", 0);
                        SetPVarInt(id, "kostka-rzut", 0);
                        SetPVarInt(id, "kostka-wait", 0);
                        SetPVarInt(id, "kostka-player", 0);
                    }
                }
            }
            SetPVarInt(playerid, "kostka-rzut", 0);
            SetPVarInt(id, "kostka-rzut", 1);
        }
        else sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "To nie jest Twoja kolej na rzut.");
    }
    else
    {
        new id, kasa, throw, Float:x, Float:y, Float:z;
        if(sscanf(params, "k<fix>dd", id, kasa, throw)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Aby rozpocz¹æ grê w kosci u¿yj: /kostka [Nick/ID] [Stawka] [Iloœc rzutów]");
        if(!IsPlayerConnected(id) || id == playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nie ma takiego gracza.");
        if(kasa < 1 || kasa > 100000000) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Stawka nie mniejsza ni¿ 1$ i nie wiêksza ni¿ 100kk");
        if(throw < 2 || throw > 10) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Minimalna iloœæ rzutów to 2 a maksymalna to 10.");
        if(GetPVarInt(id, "kostka-wait") > 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz otrzyma³ ju¿ ofertê.");
        if(GetPVarInt(id, "kostka") == 1 || GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz obecnie rozgrywa grê.");
        GetPlayerPos(playerid, x, y, z);
        if(!IsPlayerInRangeOfPoint(id, 10.0, x, y, z))  return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz nie stoi obok Ciebie.");
        if(kaska[id] < kasa || kaska[playerid] < kasa) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Za du¿a stawka na Was, ktos nie ma tyle.");

        SetPVarInt(id, "kostka-wait", playerid+1);

        SetPVarInt(playerid, "kostka-cash", kasa);
        SetPVarInt(playerid, "kostka-throw", throw);

        SetPVarInt(playerid, "kostka-last", id);

        SetPVarInt(playerid, "kostka-czas", gettime());
        SetPVarInt(id, "kostka-czas", gettime());

        new str[128], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(id, nick, MAX_PLAYER_NAME);
        format(str, 128, "Wys³ano zaproszenie do gry graczowi %s.", nick);
        sendTipMessageEx(playerid, COLOR_GREEN, str);
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "Gracz %s chce zagraæ z Tob¹ w koœci na %d rzutów o %d $.", nick, throw, kasa);
        sendTipMessageEx(id, COLOR_GREEN, str);
        sendTipMessageEx(id, COLOR_PAPAYAWHIP, "Aby zaakceptowaæ u¿yj /kostka akceptuj, aby odrzuciæ u¿yj /kostka odrzuæ");
    }
    return 1;
}

//end
