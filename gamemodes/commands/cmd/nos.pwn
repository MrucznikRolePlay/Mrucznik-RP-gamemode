//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ nos ]--------------------------------------------------//
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

YCMD:nos(playerid, params[], help)
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsANoA(playerid) || GetPlayerOrg(playerid) == 15 || GetPlayerOrg(playerid) == 16 || GetPlayerOrg(playerid) == 19)//if(PlayerInfo[playerid][pJob] == 7 || IsANoA(playerid))
        {
            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa;
            if( sscanf(params, "k<fix>", playa))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /nitro [Nick/ID]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt zamontowania to: 5000$");
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
                            if(kaska[playerid] > 5000)
                            {
                                new pojazd = GetPlayerVehicleID(playa);
                                if(!IsCarOwner(playa, pojazd))
                                    return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale¿y do tego gracza.");

                                if(PlayerInfo[playerid][pMechSkill] <= 50)
                                {
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Zamontowa³eœ graczowi %s nitro(pojemnoœæ: 2) w jego samochodzie [-5000$](wiêkszy skill-wiêksza pojemnoœæ)",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ nitro o pojemnoœci 2 w twoim samochodzie",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje nitro w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                    AddVehicleComponent(pojazd, 1009);
                                    ZabierzKase(playerid, 5000);
                                    format(string, sizeof(string), "~r~-$%d", 5000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                    if(playa != playerid)
                                    {
                                        PlayerInfo[playerid][pMechSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                    }
                                    CarData[VehicleUID[pojazd][vUID]][c_Nitro] = 1009;
                                }
                                else if(PlayerInfo[playerid][pMechSkill] >= 50 && PlayerInfo[playerid][pMechSkill] <= 99)
                                {
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Zamontowa³eœ graczowi %s nitro(pojemnoœæ: 5) w jego samochodzie [-5000$](wiêkszy skill-wiêksza pojemnoœæ)",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ nitro o pojemnoœci 5 w twoim samochodzie",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje nitro w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                    AddVehicleComponent(pojazd, 1008);
                                    ZabierzKase(playerid, 5000);
                                    format(string, sizeof(string), "~r~-$%d", 5000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                    if(playa != playerid)
                                    {
                                        PlayerInfo[playerid][pMechSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                    }
                                    CarData[VehicleUID[pojazd][vUID]][c_Nitro] = 1008;
                                }
                                else if(PlayerInfo[playerid][pMechSkill] >= 100)
                                {
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Zamontowa³eœ graczowi %s nitro(pojemnoœæ: 10) w jego samochodzie [-5000$](wiêkszy skill-wiêksza pojemnoœæ)",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ nitro o pojemnoœci: 10 w twoim samochodzie",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje nitro w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                    AddVehicleComponent(pojazd, 1010);
                                    ZabierzKase(playerid, 5000);
                                    format(string, sizeof(string), "~r~-$%d", 5000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                    if(playa != playerid)
                                    {
                                        PlayerInfo[playerid][pMechSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                    }
                                    CarData[VehicleUID[pojazd][vUID]][c_Nitro] = 1010;
                                }
                                else
                                {
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Zamontowa³eœ graczowi %s nitro(pojemnoœæ: 2) w jego samochodzie [-5000$](wiêkszy skill-wiêksza pojemnoœæ)",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ nitro o pojemnoœci 2 w twoim samochodzie",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje nitro w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                    AddVehicleComponent(pojazd, 1009);
                                    ZabierzKase(playerid, 5000);
                                    format(string, sizeof(string), "~r~-$%d", 5000);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                    if(playa != playerid)
                                    {
                                        PlayerInfo[playerid][pMechSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                    }
                                    CarData[VehicleUID[pojazd][vUID]][c_Nitro] = 1009;
                                }
                            }
                            else
                            {
                                SendClientMessage(playerid, COLOR_WHITE, "Nie masz wystarczaj¹cej iloœci pieniêdzy (5000$)");
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
