//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ naucz ]-------------------------------------------------//
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

YCMD:naucz(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playa, styl;
        if( sscanf(params, "k<fix>d", playa, styl))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /naucz [ID gracza] [numer stylu]");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Dostêpne style: 1- Gangsterski(25 000$), 2- Kung-Fu(50 000$), 3- KickBoxing(100 000$)");
            SendClientMessage(playerid, COLOR_GRAD2, "Kiedy sprzedajesz komuœ styl zabiera ci kase (iloœæ podana przy stylu)");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Aby zarobic dawaj 2-4 razy wiêksze ceny");
            return 1;
        }
        if(PlayerInfo[playerid][pJob] == 12 || PlayerInfo[playerid][pAdmin] >= 1000)
        {
            if(ProxDetectorS(8.0, playerid, playa) && IsPlayerInRangeOfPoint(playerid, 9.0, 762.9852,2.4439,1001.5942))
            {
                if(styl > 3 || styl < 1)
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "Dostêpne style: 1- gangster(25 000$), 2- kung-fu(50 000$), 3- KickEx-boxing(100 000$)");
                    return 1;
                }
                if(IsPlayerConnected(playa))
                {
                    if(playa != INVALID_PLAYER_ID)
                    {
                        if(styl == 1)
                        {
                            if(kaska[playerid] < 25_000)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($25 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_BOXING)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'Gangster'");
                            }
                            else
                            {
                                SetPlayerFightingStyle(playa, FIGHT_STYLE_BOXING);
                                PlayerInfo[playa][pStylWalki] = 1;
                                ZabierzKase(playerid, 25_000);
                                format(string, sizeof(string), "* Nauczy³eœ gracza %s stylu walki 'gangster', koszty nauki wynios³y 25 000$",GetNick(playa));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki 'gangster'.",GetNick(playerid));
                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki.");
                                format(string, sizeof(string), "~r~-$%d", 25_000);
                                GameTextForPlayer(playerid, string, 5000, 1);
                                if(playerid != playa)
                                {
                                    SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem");
                                    SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê");
                                    SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                    SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                    SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                    TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                                    GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                                    if(BoxOffer[playerid] == 999) return GameTextForPlayer(playa, "~r~Brak oferty", 3000, 1);
                                    BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                                    if(BoxDelay < 1){ BoxDelay = 20; }
                                    InRing = 1;
                                    Boxer1 = playa;
                                    Boxer2 = playerid;
                                    PlayerBoxing[playerid] = 1;
                                    PlayerBoxing[BoxOffer[playerid]] = 1;
                                    BoxDelay = 0;
                                    BoxWaitTime[playerid] = 0;
                                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                                    PlayerPlaySound(playa, 1057, 0.0, 0.0, 0.0);
                                    GameTextForPlayer(playerid, "~g~Walka rozpoczeta", 5000, 1);
                                    GameTextForPlayer(playa, "~g~Walka rozpoczeta", 5000, 1);
                                    TogglePlayerControllable(playerid, 1);
                                    TogglePlayerControllable(playa, 1);
                                    RoundStarted = 1;
                                    PlayerInfo[playerid][pBoxSkill] += 5;
                                    SendClientMessage(playerid, COLOR_GRAD2, "Skill + 5");
                                }
                            }
                        }
                        else if(styl == 2)
                        {
                            if(kaska[playerid] < 50_000)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($50 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KUNGFU)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'Kung Fu'");
                            }
                            else
                            {
                                if(PlayerInfo[playerid][pBoxSkill] > 100)
                                {
                                    SetPlayerFightingStyle(playa, FIGHT_STYLE_KUNGFU);
                                    PlayerInfo[playa][pStylWalki] = 2;
                                    ZabierzKase(playerid, 50_000);
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Naucz³eœ gracza %s stylu walki 'kung-fu', koszty nauki wynios³y 50 000$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki stylu walki 'kung-fu'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", 50_000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê");
                                        SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                        SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                        SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                        TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                                        GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                                        if(BoxOffer[playerid] == 999) return GameTextForPlayer(playa, "~r~Brak oferty", 3000, 1);
                                        BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                                        if(BoxDelay < 1){ BoxDelay = 20; }
                                        InRing = 1;
                                        Boxer1 = playa;
                                        Boxer2 = playerid;
                                        PlayerBoxing[playerid] = 1;
                                        PlayerBoxing[BoxOffer[playerid]] = 1;
                                        BoxDelay = 0;
                                        BoxWaitTime[playerid] = 0;
                                        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                                        PlayerPlaySound(playa, 1057, 0.0, 0.0, 0.0);
                                        GameTextForPlayer(playerid, "~g~Walka rozpoczeta", 5000, 1);
                                        GameTextForPlayer(playa, "~g~Walka rozpoczeta", 5000, 1);
                                        TogglePlayerControllable(playerid, 1);
                                        TogglePlayerControllable(playa, 1);
                                        RoundStarted = 1;
                                        PlayerInfo[playerid][pBoxSkill] += 5;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill + 5");
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 3 skillu Boxera aby móc uczyæ kung fu");
                                }
                            }
                        }
                        else if(styl == 3)
                        {
                            if(kaska[playerid] < 100_000)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($100 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KNEEHEAD)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'KickBoxing'");
                            }
                            else
                            {
                                if(PlayerInfo[playerid][pBoxSkill] > 200)
                                {
                                    SetPlayerFightingStyle(playa, FIGHT_STYLE_KNEEHEAD);
                                    PlayerInfo[playa][pStylWalki] = 3;
                                    ZabierzKase(playerid, 100_000);
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Naucz³eœ gracza %s stylu walki 'Kick Boxing', koszty nauki wynios³y 100 000$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki stylu walki 'Kick Boxing'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", 100_000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê");
                                        SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                        SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                        SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                        TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                                        GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                                        if(BoxOffer[playerid] == 999) return GameTextForPlayer(playa, "~r~Brak oferty", 3000, 1);
                                        BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                                        if(BoxDelay < 1){ BoxDelay = 20; }
                                        InRing = 1;
                                        Boxer1 = playa;
                                        Boxer2 = playerid;
                                        PlayerBoxing[playerid] = 1;
                                        PlayerBoxing[BoxOffer[playerid]] = 1;
                                        BoxDelay = 0;
                                        BoxWaitTime[playerid] = 0;
                                        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                                        PlayerPlaySound(playa, 1057, 0.0, 0.0, 0.0);
                                        GameTextForPlayer(playerid, "~g~Walka rozpoczeta", 5000, 1);
                                        GameTextForPlayer(playa, "~g~Walka rozpoczeta", 5000, 1);
                                        TogglePlayerControllable(playerid, 1);
                                        TogglePlayerControllable(playa, 1);
                                        RoundStarted = 1;
                                        PlayerInfo[playerid][pBoxSkill] += 5;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill + 5");
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 4 skillu Boxera aby móc uczyæ Kick Boxingu");
                                }
                            }
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_RED, "Gracz nie istnieje.");
                    }
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_RED, "Gracz jest za daleko.");
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "Nie jesteœ bokserem.");
        }
    }
    return 1;
}
