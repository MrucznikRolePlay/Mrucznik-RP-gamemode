//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ malunek ]------------------------------------------------//
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

YCMD:malunek(playerid, params[], help)
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAMechazordWarsztatowy(playerid))//PlayerInfo[playerid][pJob] == 7 || IsANoA(playerid))
        {
            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa, malunek;
            if( sscanf(params, "k<fix>d", playa, malunek))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /malunek [Nick/ID] [id malunku]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt namalowania to: 20 000$ , aby zobaczyæ liste malunków wpisz /malunki");
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
                            if(kaska[playerid] > 20000)
                            {
                                if(PlayerInfo[playerid][pMechSkill] >= 100)
                                {
                                    new pojazd = GetPlayerVehicleID(playa);
                                    if(!IsCarOwner(playa, pojazd))
                                        return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale¿y do tego gracza.");

                                    new model = GetVehicleModel(pojazd);
                                    if(model == 412 || model >= 534 && model <= 536 || model >= 558 && model <= 562 || model >= 565 && model <= 567 || model == 575 || model == 576 || model == 483)
                                    {
                                        if(malunek >= 0 && malunek <= 3)
                                        {
                                            GetPlayerName(playerid, sendername, sizeof(sendername));
                                            GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                            format(string, sizeof(string), "* Zrobi³eœ graczowi %s malunek samochodu (-20 000$)",giveplayer);
                                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                            format(string, sizeof(string), "* Mechanik %s zrobi³ malunek na twoim %s",sendername, VehicleNames[model-400]);
                                            SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                            format(string, sizeof(string),"* Mechanik %s wyci¹ga sprey i tworzy malunek na %s.", sendername, VehicleNames[model-400]);
                                            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                            Log(payLog, INFO, "Gracz %s zamontowa³ %s malunek %d na pojazd %s za %d$",
                                                GetPlayerLogName(playerid), GetPlayerLogName(playa), malunek, GetVehicleLogName(pojazd), 20000
                                            );
                                            ZabierzKase(playerid, 20000);
                                            format(string, sizeof(string), "~r~-$%d", 20000);
                                            GameTextForPlayer(playerid, string, 5000, 1);
                                            ChangeVehiclePaintjob(pojazd,malunek);
                                            PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
                                            if(playa != playerid)
                                            {
                                                PlayerInfo[playerid][pMechSkill] ++;
                                                SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                PlayerPlaySound(playa, 1134, 0.0, 0.0, 0.0);
                                            }
                                            CarData[VehicleUID[pojazd][vUID]][c_Malunek] = malunek;
                                        }
                                        else
                                        {
                                            SendClientMessage(playerid, COLOR_GRAD2, "ID malunku od 0 do 3 (wpisz /malunki aby zobaczyæ dostêpne malunki)");
                                        }
                                    }
                                    else
                                    {
                                        format(string, sizeof(string), "Wozu %s nie mo¿na pomalowaæ, wpisz /malunki aby zobaczyæ jakie wozy mo¿na pomalowaæ", VehicleNames[GetVehicleModel(pojazd)-400]);
                                        SendClientMessage(playerid, COLOR_GRAD4, string);
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_GRAD4, "Musisz mieæ 3 skill mechanika");
                                }
                            }
                            else
                            {
                                SendClientMessage(playerid, COLOR_WHITE, "Nie masz wystarczaj¹cej iloœci pieniêdzy (20 000$)");
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest w samochodzie");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest za daleko");
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_WHITE, "Nie ma takiego gracza");
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Nie jesteœ mechanikiem");
        }
    }
    return 1;
}
