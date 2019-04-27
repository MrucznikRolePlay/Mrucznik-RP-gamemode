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
    if(IsPlayerConnected(playerid))
    {
        if(IsANoA(playerid) || GetPlayerOrg(playerid) == 15 || GetPlayerOrg(playerid) == 16 || GetPlayerOrg(playerid) == 19)//if(PlayerInfo[playerid][pJob] == 7 || IsANoA(playerid))
        {
            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa;
            if( sscanf(params, "k<fix>", playa))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /zderzak [Nick/ID]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt tuningu to: 10 000$");
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
                            if(kaska[playerid] > 10000)
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
                                SendClientMessage(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci pieniêdzy (10 000$)");
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
