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
        if(IsAPolicja(playerid) || (IsABOR(playerid) && PlayerInfo[playerid][Rank] >= 2))
        {
            new giveplayerid;
            if(sscanf(params, "k<fix>", giveplayerid))
            {
                sendTipMessage(playerid, "U¿yj /kajdanki [ID_GRACZA]");
                return 1;
            }

            if(!IsPlayerConnected(giveplayerid))
            {
                sendTipMessage(playerid, "Nie ma takiego gracza");
                return 1;
            }

            if(Kajdanki_Uzyte[playerid] != 1)
            {
                if(IsAPolicja(playerid))
                {
                    if(OnDuty[playerid] == 0)
                    {
                        sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
                        return 1;
                    }
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
                        if(Kajdanki_JestemSkuty[giveplayerid] == 0)
                        {
                            new string[128];
                            if(PlayerInfo[giveplayerid][pBW] >= 1 || PlayerInfo[giveplayerid][pInjury] >= 1)
                            {
                                //Wiadomoœci
                                format(string, sizeof(string), "* %s docisn¹³ do ziemi nieprzytomnego %s i sku³ go.", GetNick(playerid), GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Dziêki szybkiej interwencji uda³o Ci siê skuæ %s.", GetNick(giveplayerid));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Jesteœ nieprzytomny - policjant sku³ ciê bez wiêkszego wysi³ku.");

                                //czynnoœci
                                CuffedAction(playerid, giveplayerid);
                            }
                            else if(GetPlayerSpecialAction(giveplayerid) == SPECIAL_ACTION_DUCK)
                            {
                                //Wiadomoœci
                                format(string, sizeof(string), "* %s dociska do ziemi %s, a nastêpnie zakuwa go w kajdanki.", GetNick(playerid), GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Sku³eœ %s.", GetNick(giveplayerid));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Le¿a³eœ na ziemi - policjant sku³ ciê bez wiêkszego wysi³ku.");

                                //czynnoœci
                                CuffedAction(playerid, giveplayerid);
                            }
                            else
                            {
                                format(string, sizeof(string), "* %s wyci¹ga kajdanki i próbuje je za³o¿yæ %s.", GetNick(playerid),GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                ShowPlayerDialogEx(giveplayerid, 98, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za³o¿yæ ci kajdanki, jeœli osacza ciê niedu¿a liczba policjantów mo¿esz spróbowaæ siê wyrwaæ\nJednak pamiêtaj jeœli siê wyrwiesz i jesteœ uzbrojony policjant ma prawo ciê zabiæ. \nMo¿esz tak¿e dobrowolnie poddaæ siê policjantom.", "Poddaj siê", "Wyrwij siê");
                                Kajdanki_PDkuje[giveplayerid] = playerid;
                                //Kajdanki_Uzyte[giveplayerid] = 1;
                                SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
                            }
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
            }
        } else
        {
            sendTipMessage(playerid, "Nie posiadasz kajdanek");
        }
    }
    return 1;
}
