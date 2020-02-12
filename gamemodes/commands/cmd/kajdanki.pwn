//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kajdanki ]-----------------------------------------------//
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

YCMD:kajdanki(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsACop(playerid) || (IsABOR(playerid) && PlayerInfo[playerid][pRank] >= 2))
        {
            new giveplayerid;
            if(sscanf(params, "k<fix>", giveplayerid))
            {
                sendTipMessage(playerid, "U¿yj /kajdanki [ID_GRACZA]");
                return 1;
            }

            if(uzytekajdanki[playerid] != 1)
            {
                if(IsACop(playerid))
                {
                    if(OnDuty[playerid] == 0)
                    {
                        sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
                        return 1;
                    }
                }
                if(!IsPlayerConnected(giveplayerid))
                {
                    sendTipMessage(playerid, "Nie ma takiego gracza");
                    return 1;
                }

                if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
                {
                    sendTipMessage(playerid, "Jesteœ zbyt daleko od gracza");
                    return 1;
                }

                if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
                {
                    if(GetPlayerState(playerid) == 1 && GetPlayerState(giveplayerid) == 1)
                    {
                        if(zakuty[giveplayerid] == 0)
                        {
                            new string[128];
                            if(PlayerInfo[giveplayerid][pBW] >= 1 || PlayerInfo[giveplayerid][pInjury] >= 1)
                            {
                                //Wiadomoœci
                                format(string, sizeof(string), "* %s docisn¹³ do ziemi nieprzytomnego %s i sku³ go.", GetNick(playerid, true), GetNick(giveplayerid, true));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Dziêki szybkiej interwencji uda³o Ci siê skuæ %s.", GetNick(giveplayerid, true));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Jesteœ nieprzytomny - policjant sku³ ciê bez wiêkszego wysi³ku.");

                                //czynnoœci
                                PlayerInfo[giveplayerid][pBW] = 0;
                                PlayerInfo[giveplayerid][pInjury] = 0;
                                zakuty[giveplayerid] = 1;
                                uzytekajdanki[playerid] = 1;
                                PDkuje[giveplayerid] = playerid;
                                SkutyGracz[playerid] = giveplayerid;
                                ClearAnimations(giveplayerid);
                                SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
                                SetPlayerAttachedObject(giveplayerid, 5, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
                                SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
                                SetTimerEx("Kajdanki_debug", 1000, 0, "d", giveplayerid);
                                return 1;
                            }
                            else if(GetPlayerSpecialAction(giveplayerid) == SPECIAL_ACTION_DUCK)
                            {
                                //Wiadomoœci
                                format(string, sizeof(string), "* %s dociska do ziemi %s, a nastêpnie zakuwa go w kajdanki.", GetNick(playerid, true), GetNick(giveplayerid, true));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Sku³eœ %s.", GetNick(giveplayerid, true));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Le¿a³eœ na ziemi - policjant sku³ ciê bez wiêkszego wysi³ku.");

                                //czynnoœci
                                zakuty[giveplayerid] = 1;
                                uzytekajdanki[playerid] = 1;
                                PDkuje[giveplayerid] = playerid;
                                SkutyGracz[playerid] = giveplayerid;
                                ClearAnimations(giveplayerid);
                                SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
                                SetPlayerAttachedObject(giveplayerid, 5, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
                                SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
                                SetTimerEx("Kajdanki_debug", 1000, 0, "d", giveplayerid);
                                return 1;
                            }

                            format(string, sizeof(string), "* %s wyci¹ga kajdanki i próbuje je za³o¿yæ %s.", GetNick(playerid, true),GetNick(giveplayerid, true));
                            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            ShowPlayerDialogEx(giveplayerid, 98, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za³o¿yæ ci kajdanki, jeœli osacza ciê niedu¿a liczba policjantów mo¿esz spróbowaæ siê wyrwaæ\nJednak pamiêtaj jeœli siê wyrwiesz i jesteœ uzbrojony policjant ma prawo ciê zabiæ. \nMo¿esz tak¿e dobrowolnie poddaæ siê policjantom.", "Poddaj siê", "Wyrwij siê");
                            PDkuje[giveplayerid] = playerid;
                            //uzytekajdanki[giveplayerid] = 1;
                            SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
                            return 1;
                        }
                        else
                        {
                            new str[32];
                            valstr(str, giveplayerid);
                            RunCommand(playerid, "/rozkuj",  str);
                        }
                    } else
                    {
                        sendErrorMessage(playerid, "¯aden z was nie mo¿e byæ w wozie!");
                    }
                } else
                {
                    sendTipMessage(playerid, "Jesteœ zbyt daleko od gracza");
                }
            } else
            {
                new str[32];
                valstr(str, giveplayerid);
                RunCommand(playerid, "/rozkuj",  str);
                return 1;
            }
        } else
        {
            sendTipMessage(playerid, "Nie posiadasz kajdanek");
        }
    }
    return 1;
}
