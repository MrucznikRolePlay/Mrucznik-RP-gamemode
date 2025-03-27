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
command_naucz_Impl(playerid, params[256])
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playa, styl;
        if( sscanf(params, "k<fix>d", playa, styl))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U�YJ: /naucz [ID gracza] [numer stylu]");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Dost�pne style: 1- Gangsterski(25 000$), 2- Kung-Fu(50 000$), 3- KickBoxing(100 000$)");
            SendClientMessage(playerid, COLOR_GRAD2, "Kiedy sprzedajesz komu� styl zabiera ci kase (ilo�� podana przy stylu)");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Aby zarobic dawaj 2-4 razy wi�ksze ceny");
            return 1;
        }
        if(PlayerInfo[playerid][pJob] == 12 || PlayerInfo[playerid][pAdmin] >= 1000)
        {
            if(ProxDetectorS(8.0, playerid, playa) && IsAtGym(playerid))
            {
                if(styl > 3 || styl < 1)
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "Dost�pne style: 1- gangster(25 000$), 2- kung-fu(50 000$), 3- kick-boxing(100 000$)");
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
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj�co du�o pieni�dzy ($25 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_BOXING)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u�ywa stylu walki 'Gangster'");
                            }
                            else
                            {
                                SetPlayerFightingStyle(playa, FIGHT_STYLE_BOXING);
                                PlayerInfo[playa][pStylWalki] = 1;
                                ZabierzKase(playerid, 25_000);
                                format(string, sizeof(string), "* Nauczy�e� gracza %s stylu walki 'gangster', koszty nauki wynios�y 25 000$",GetNick(playa));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                format(string, sizeof(string), "* Bokser %s nauczy� ci� stylu walki 'gangster'.",GetNick(playerid));
                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyj�ciu z gry twoja posta� nadal b�dzie posiada�a ten styl walki.");
                                format(string, sizeof(string), "~r~-$%d", 25_000);
                                GameTextForPlayer(playerid, string, 5000, 1);
                                if(playerid != playa)
                                {
                                    SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczai� si� do nowego stylu musisz stoczy� walk� z bokserem");
                                    SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczai� ucznia do nowego stylu musisz stoczy� z nim walk�");
                                    SetPlayerBoxingPos(playerid, playa);
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
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj�co du�o pieni�dzy ($50 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KUNGFU)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u�ywa stylu walki 'Kung Fu'");
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
                                    format(string, sizeof(string), "* Naucz�e� gracza %s stylu walki 'kung-fu', koszty nauki wynios�y 50 000$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy� ci� stylu walki stylu walki 'kung-fu'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyj�ciu z gry twoja posta� nadal b�dzie posiada�a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", 50_000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczai� si� do nowego stylu musisz stoczy� walk� z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczai� ucznia do nowego stylu musisz stoczy� z nim walk�");
                                        SetPlayerBoxingPos(playerid, playa);
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
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 3 skillu Boxera aby m�c uczy� kung fu");
                                }
                            }
                        }
                        else if(styl == 3)
                        {
                            if(kaska[playerid] < 100_000)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj�co du�o pieni�dzy ($100 000).");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KNEEHEAD)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u�ywa stylu walki 'KickBoxing'");
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
                                    format(string, sizeof(string), "* Naucz�e� gracza %s stylu walki 'Kick Boxing', koszty nauki wynios�y 100 000$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy� ci� stylu walki stylu walki 'Kick Boxing'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyj�ciu z gry twoja posta� nadal b�dzie posiada�a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", 100_000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczai� si� do nowego stylu musisz stoczy� walk� z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczai� ucznia do nowego stylu musisz stoczy� z nim walk�");
                                        SetPlayerBoxingPos(playerid, playa);
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
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 4 skillu Boxera aby m�c uczy� Kick Boxingu");
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
            SendClientMessage(playerid, COLOR_RED, "Nie jeste� bokserem.");
        }
    }
    return 1;
}

//end
