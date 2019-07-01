//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ hydraulika ]----------------------------------------------//
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

YCMD:hydraulika(playerid, params[], help)
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsANoA(playerid) || GetPlayerOrg(playerid) == 15 || GetPlayerOrg(playerid) == 16 || GetPlayerOrg(playerid) == 19)//if(PlayerInfo[playerid][pJob] == 7 || IsANoA(playerid))
        {
            if(!IsAtWarsztat(playerid)) { return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning"); }
            new playa;
            if( sscanf(params, "k<fix>", playa))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /hydraulika [Nick/ID]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt zamontowania to: 10 000$");
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
                                if(PlayerInfo[playerid][pMechSkill] >= 50)
                                {
                                    new pojazd = GetPlayerVehicleID(playa);
                                    if(!IsCarOwner(playa, pojazd)) {
                                        return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale¿y do tego gracza.");
                                    }

                                    AddVehicleComponent(pojazd,1087);//hydraulika
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Zamontowa³eœ graczowi %s hydraulike (-10 000$)",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ hydraulike w twoim samochodzie",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje hydraulike w %s.", sendername, VehicleNames[GetVehicleModel(pojazd) - 400]);
                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                    ZabierzKase(playerid, 10000);
                                    format(string, sizeof(string), "~r~-$%d", 10000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
                                    if(playa != playerid)
                                    {
                                        PlayerInfo[playerid][pMechSkill]++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                        PlayerPlaySound(playa, 1141, 0.0, 0.0, 0.0);
                                    }
                                    CarData[VehicleUID[pojazd][vUID]][c_bHydraulika] = true;
                                } else
                                {
                                    SendClientMessage(playerid, COLOR_GRAD2, "Musisz mieæ 2 skill mechanika aby montowaæ hydraulike.");
                                }
                            } else
                            {
                                SendClientMessage(playerid, COLOR_WHITE, "Nie masz wystarczaj¹cej iloœci pieniêdzy (10 000$)");
                            }
                        } else
                        {
                            SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest w samochodzie");
                        }
                    } else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest za daleko");
                    }
                } else
                {
                    SendClientMessage(playerid, COLOR_WHITE, "Nie ma takiego gracza");
                }
            }
        } else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Nie jesteœ mechanikiem");
        }
    }
    return 1;
}
