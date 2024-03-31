//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zderzaki ]-----------------------------------------------//
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

YCMD:zderzaki(playerid, params[], help)
{
    new string[MAX_MESSAGE_LENGTH];
    if(IsPlayerConnected(playerid))
    {
        if(IsAMechazordWarsztatowy(playerid) || PlayerInfo[playerid][pJob] == 7)
        {
            new cost = 10000;
            if(IsAMechazordWarsztatowy(playerid))
            {
                cost /= 2;
            }

            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa;
            if( sscanf(params, "k<fix>", playa))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /zderzak [Nick/ID]");
                format(string, sizeof(string), "INFORMACJA: Koszt tuningu to: %d$", cost);
                SendClientMessage(playerid, COLOR_GRAD3, string);
                return 1;
            }


            if(IsPlayerConnected(playa))
            {
                if(playa != INVALID_PLAYER_ID)
                {
                    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
                    {
                        if(IsPlayerInAnyVehicle(playa))
                        {
                            if(kaska[playerid] > cost)
                            {
                                if(PlayerInfo[playerid][pMechSkill] >= 200)
                                {
                                    if(GUIExit[playerid] == 0)
                                    {
                                        mechanikid[playerid] = playa;
                                        new pojazd = GetVehicleModel(GetPlayerVehicleID(playa));
                                        if(pojazd >= 558 && pojazd <= 562 || pojazd == 565)//alien i x-flow
                                        {
                                            ShowPlayerDialogEx(playerid, 501, DIALOG_STYLE_LIST, "Wybierz zderzaki", "X-Flow\nAlien", "Montuj", "WyjdŸ");
                                        }
                                        else if(pojazd == 575 || pojazd == 534 || pojazd == 536 || pojazd == 567 || pojazd == 576)//lowrider
                                        {
                                            ShowPlayerDialogEx(playerid, 502, DIALOG_STYLE_LIST, "Wybierz zderzaki", "Chromowe\nMasywne", "Montuj", "WyjdŸ");
                                        }
                                        else if(pojazd == 535)//slamvan
                                        {
                                            ShowPlayerDialogEx(playerid, 503, DIALOG_STYLE_LIST, "Wybierz zderzaki", "Masywne", "Montuj", "WyjdŸ");
                                        }
                                        else
                                        {
                                            SendClientMessage(playerid, COLOR_GREY, "W tym wozie nie mo¿na zamontowac zderzaków");
                                        }
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_GREY, "Musisz mieæ 4 skill mechanika");
                                }
                            }
                            else
                            {
                                format(string, sizeof(string), "Nie masz wystarczaj¹cej iloœci pieniêdzy (%d$)", cost);
                                SendClientMessage(playerid, COLOR_GREY, string);
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "Gracz nie jest w samochodzie");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "Gracz nie jest za daleko");
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "Nie ma takiego gracza");
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ mechanikiem");
        }
    }
    return 1;
}
